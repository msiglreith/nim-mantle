
import mantle
import windows
import "../common/window_base.nim"

proc dbg_msg_proc(msgTyp: GrDbgMsgType, validationLevel: GrValidationLevel, srcObject: GrBaseObject, location: GrSize, msgCode: GrDbgMsgCode, pMsg: cstring, pUserData: pointer) {.stdcall.} =
  echo "[", msgCode, "]: ", pMsg

# create window
registerWindowClass()
var hWindow = buildWindow(1440, 900)

var rect: RECT
discard GetClientRect(hWindow, addr rect)

let
  width: GrInt = rect.BottomRight.x - rect.TopLeft.x
  height: GrInt = rect.BottomRight.y - rect.TopLeft.y
 
# init mantle
var
  appInfo: GrApplicationInfo
  gpus: array[GR_MAX_PHYSICAL_GPUS, GrPhysicalGpu]
  gpuCount: GrUint

discard grDbgRegisterMsgCallback(dbg_msg_proc, nil)

appInfo.apiVersion = GR_API_VERSION
discard grInitAndEnumerateGpus(addr appInfo, nil, addr gpuCount, gpus)

discard grGetExtensionSupport(gpus[0], "GR_WSI_WINDOWS")

var extensionsRaw = ["GR_WSI_WINDOWS"]
var extensions = allocCStringArray(extensionsRaw)
var queueCreateInfo = GrDeviceQueueCreateInfo(queueType: GR_QUEUE_UNIVERSAL, queueCount: 1)
var deviceCreateInfo = GrDeviceCreateInfo(
                         queueRecordCount: 1,
                         pRequestedQueues: addr queueCreateInfo,
                         extensionCount: extensionsRaw.len.GrUint,
                         ppEnabledExtensionNames: extensions,
                         maxValidationLevel: GR_VALIDATION_LEVEL_4,
                         flags: GR_DEVICE_CREATE_VALIDATION
                       )
deallocCStringArray(extensions)
var device: GrDevice
discard grCreateDevice(gpus[0], addr deviceCreateInfo, addr device);

var deviceQueue: GrQueue
discard grGetDeviceQueue(device, GR_QUEUE_UNIVERSAL, 0, addr deviceQueue);

# create presentable image
var
  image: GrImage
  memImage: GrGpuMemory
  
var imageCreateInfo = GrWsiWinPresentableImageCreateInfo(
                        format: GrFormat(
                                  channelFormat: GR_CH_FMT_R8G8B8A8,
                                  numericFormat: GR_NUM_FMT_UNORM
                                ),
                        usage: GR_IMAGE_USAGE_COLOR_TARGET,
                        extent: GrExtent2d(width: width, height: height),
                        display: GR_NULL_HANDLE,
                        flags: 0
                      )
discard grWsiWinCreatePresentableImage(device, addr imageCreateInfo, addr image, addr memImage)

var
  cmdBufferPresent: GrCmdBuffer
  cmdBufferCreateInfo = GrCmdBufferCreateInfo(queueType: GR_QUEUE_UNIVERSAL, flags: 0)
  
discard grCreateCommandBuffer(device, addr cmdBufferCreateInfo, addr cmdBufferPresent)
discard grBeginCommandBuffer(cmdBufferPresent, 0)

var imageTransition = GrImageStateTransition(
                        image: image,
                        oldState: GR_IMAGE_STATE_UNINITIALIZED,
                        newState: GR_WSI_WIN_IMAGE_STATE_PRESENT_WINDOWED,
                        subresourceRange: GrImageSubresourceRange(
                                            aspect: GR_IMAGE_ASPECT_COLOR,
                                            baseMipLevel: 0,
                                            mipLevels: GR_LAST_MIP_OR_SLICE,
                                            baseArraySlice: 0,
                                            arraySize: GR_LAST_MIP_OR_SLICE
                                          )
                     )

grCmdPrepareImages(cmdBufferPresent, 1, addr imageTransition)
discard grEndCommandBuffer(cmdBufferPresent)

var memRef = GrMemoryRef(mem: memImage, flags: 0) 
discard grQueueSubmit(deviceQueue, 1, addr cmdBufferPResent, 1, addr memRef, GR_NULL_HANDLE)

var presentInfo = GrWsiWinPresentInfo(
                    hWndDest: hWindow,
                    srcImage: image,
                    presentMode: GrWsiWinPresentModeWindowed,
                    presentInterval: 0,
                    flags: 0
                  )

# main loop
while true:
  discard grWsiWinQueuePresent(deviceQueue, addr presentInfo)
  pollWindow()
