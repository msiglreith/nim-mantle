
import mantle

proc dbg_msg_proc(msgTyp: GrDbgMsgType, validationLevel: GrValidationLevel, srcObject: GrBaseObject, location: GrSize, msgCode: GrDbgMsgCode, pMsg: ptr GrChar, pUserData: pointer) {.stdcall.} =
  echo "[", msgCode, "]: ", pMsg

var
  appInfo: GrApplicationInfo
  gpus: array[GR_MAX_PHYSICAL_GPUS, GrPhysicalGpu]
  gpuCount: GrUint

# register debug callback
discard grDbgRegisterMsgCallback(dbg_msg_proc, nil)

# init and get devices
appInfo.apiVersion = GR_API_VERSION
discard grInitAndEnumerateGpus(addr appInfo, nil, addr gpuCount, gpus)

# create device and queue
var queueCreateInfo = GrDeviceQueueCreateInfo(queueType: GR_QUEUE_UNIVERSAL, queueCount: 1)
var deviceCreateInfo = GrDeviceCreateInfo(
                         queueRecordCount: 1,
                         pRequestedQueues: addr queueCreateInfo,
                         extensionCount: 0,
                         ppEnabledExtensionNames: nil,
                         maxValidationLevel: GR_VALIDATION_LEVEL_4,
                         flags: GR_DEVICE_CREATE_VALIDATION
                       )

var device: GrDevice
discard grCreateDevice(gpus[0], addr deviceCreateInfo, addr device);

var deviceQueue: GrQueue
discard grGetDeviceQueue(device, GR_QUEUE_UNIVERSAL, 0, addr deviceQueue);

# destroy device
discard grDestroyDevice(device)