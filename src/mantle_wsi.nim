
## Nim wrapper for ``Mantle`` - Window System Interface (WSI) for Windows

import mantle
import windows

# Types
type
  # Object Types
  GrWsiWinDisplay* = GrObject

# Constants
const
  GR_MAX_GAMMA_RAMP_CONTROL_POINTS*: GrSize = 1 # todo: verify!

# Enumerations
type
  GrWsiWinImageState* {.size: sizeof(GrEnum).} = enum
    GR_WSI_WIN_IMAGE_STATE_PRESENT_WINDOWED = 0x00200000
    GR_WSI_WIN_IMAGE_STATE_PRESENT_FULLSCREEN = 0x00200001

  GrWsiWinInfoType* {.size: sizeof(GrEnum).} = enum
    GR_WSI_WIN_INFO_TYPE_QUEUE_PROPERTIES = 0x00206800
    GR_WSI_WIN_INFO_TYPE_DISPLAY_PROPERTIES = 0x00206801
    GR_WSI_WIN_INFO_TYPE_GAMMA_RAMP_CAPABILITIES = 0x00206802
    GR_WSI_WIN_INFO_TYPE_DISPLAY_FREESYNC_SUPPORT = 0x00206803
    GR_WSI_WIN_INFO_TYPE_PRESENTABLE_IMAGE_PROPERTIES = 0x00206804
    GR_WSI_WIN_INFO_TYPE_EXTENDED_DISPLAY_PROPERTIES = 0x00206805

  GrWsiWinPresentMode* {.size: sizeof(GrEnum).} = enum
    GR_WSI_WIN_PRESENT_MODE_WINDOWED = 0x00200200
    GR_WSI_WIN_PRESENT_MODE_FULLSCREEN = 0x00200201

  GrWsiWinRotationAngle* {.size: sizeof(GrEnum).} = enum
    GR_WSI_WIN_ROTATION_ANGLE_0 = 0x00200100
    GR_WSI_WIN_ROTATION_ANGLE_90 = 0x00200101
    GR_WSI_WIN_ROTATION_ANGLE_180 = 0x00200102
    GR_WSI_WIN_ROTATION_ANGLE_270 = 0x00200103

# Flags
const # GR_WSI_WIN_EXTENDED_DISPLAY_FLAGS
  GR_WSI_WIN_WINDOWED_VBLANK_WAIT* = 0x00000001
  GR_WSI_WIN_WINDOWED_GET_SCANLINE* = 0x00000002

const # GR_WSI_WIN_IMAGE_CREATE_FLAGS
  GR_WSI_WIN_IMAGE_CREATE_FULLSCREEN_PRESENT* = 0x00000001
  GR_WSI_WIN_IMAGE_CREATE_STEREO* = 0x00000002

const # GR_WSI_WIN_PRESENT_FLAGS
  GR_WSI_WIN_PRESENT_FULLSCREEN_DONOTWAIT* = 0x00000001
  GR_WSI_WIN_PRESENT_FULLSCREEN_STEREO* = 0x00000002

const # GR_WSI_WIN_PRESENT_SUPPORT_FLAGS
  GR_WSI_WIN_FULLSCREEN_PRESENT_SUPPORTED* = 0x00000001
  GR_WSI_WIN_WINDOWED_PRESENT_SUPPORTED* = 0x00000002

# Data Structures
type
  GrRgbFloat* {.final.} = object
    red*: GrFloat
    green*: GrFloat
    blue*: GrFloat

  GrWsiWinDisplayMode* {.final.} = object
    extent*: GrExtent2d
    format*: GrFormat
    refreshRate*: GrUint
    stereo*: GrBool
    crossDisplayPresent*: GrBool

  GrWsiWinDisplayProperties* {.final.} = object
    hMonitor*: windows.HMONITOR
    displayName*: array[GR_MAX_DEVICE_NAME_LEN, GrChar]

  GrWsiWinExtendedDisplayProperties* {.final.} = object
    extendedProperties: GrFlags

  GrWsiWinGammaRamp* {.final.} = object
    scale: GrRgbFloat
    offset: GrRgbFloat
    gammaCurve: array[GR_MAX_GAMMA_RAMP_CONTROL_POINTS, GrRgbFloat]

  GrWsiWinGammaRampCapabilites* {.final.} = object
    supportsScaleAndOffset: GrBool
    minConvertedValue: GrFloat
    maxConvertedValue: GrFloat
    controlPointCount: GrUint
    controlPointPositions: array[GR_MAX_GAMMA_RAMP_CONTROL_POINTS, GrFloat]

  GrWsiWinPresentInfo* {.final.} = object
    hWndDest: windows.HWND
    srcImage: GrImage
    presentMode: GrWsiWinPresentMode
    presentInterval: GrUint # todo: range usable? 0-4
    flags: GrFlags

  GrWsiWinPresentableImageCreateInfo* {.final.} = object
    format: GrFormat
    usage: GrFlags
    extent: GrExtent2d
    display: GrWsiWinDisplay
    flags: GrFlags

  GrWsiWinPresentableImageProperties* {.final.} = object
    createInfo: GrWsiWinPresentableImageCreateInfo
    mem: GrGpuMemory

  GrWsiWinQueueProperties* {.final.} = object
    presentSupport: GrFlags

# Functions
{.push callConv: stdcall, importc, dynLib: libmantle}
proc grWsiWinGetDisplays*(device: GrDevice, pDisplayCount: ptr GrUint, pDisplayList: ptr GrWsiWinDisplay): GR_RESULT
proc grWsiWinGetDisplayModeList*(display: GrWsiWinDisplay, pDisplayModeCount: ptr GrUint, pDisplayModeList: ptr GrWsiWinDisplayMode): GR_RESULT
proc grWsiWinTakeFullscreenOwnership*(display: GrWsiWinDisplay, image: GrImage): GR_RESULT
proc grWsiWinReleaseFullscreenOwnership*(display: GrWsiWinDisplay): GR_RESULT
proc grWsiWinSetGammaRamp*(display: GrWsiWinDisplay, pGammaRamp: ptr GrWsiWinGammaRamp): GR_RESULT
proc grWsiWinWaitForVerticalBlank*(display: GrWsiWinDisplay): GR_RESULT
proc grWsiWinGetScanLine*(display: GrWsiWinDisplay, pScanLine: ptr GrInt): GR_RESULT
proc grWsiWinCreatePresentableImage*(device: GrDevice, pCreateInfo: ptr GrWsiWinPresentableImageCreateInfo, pImage: ptr GrImage, pMem: ptr GrGpuMemory): GR_RESULT
proc grWsiWinQueuePresent*(queue: GrQueue, pPresentInfo: ptr GrWsiWinPresentInfo): GR_RESULT
proc grWsiWinSetMaxQueuedFrames*(device: GrDevice, maxFrames: GrUint): GR_RESULT
{.pop.} # callConv, dynlib