
## Nim wrapper for ``Mantle`` - Extensions (Ext)

import mantle

# Types
type
  # Object Types
  GrBorderColorPalette* = GrObject
# Constants
const
  GR_MAX_MSAA_RASTERIZER_SAMPLES*: GrSize = 1 # todo: verify!

# Enumerations
type
  GrExtInfoType* {.size: sizeof(GrEnum).} = enum
    GR_EXT_INFO_TYPE_PHYSICAL_GPU_SUPPORTED_AXL_VERSION = 0x00306100
    GR_EXT_INFO_TYPE_QUEUE_BORDER_COLOR_PALETTE_PROPERTIES = 0x00306800
    GR_EXT_INFO_TYPE_QUEUE_CONTROL_FLOW_PROPERTIES = 0x00306801,

  GrExtMemoryState* {.size: sizeof(GrEnum).} = enum
    GR_EXT_MEMORY_STATE_COPY_OCCLUSION_DATA = 0x00300000
    GR_EXT_MEMORY_STATE_CMD_CONTROL = 0x00300001

  GrExtBorderColorType* {.size: sizeof(GrEnum).} = enum
    GR_EXT_BORDER_COLOR_TYPE_PALETTE_ENTRY_0 = 0x0030a000

  GrExtImageState* {.size: sizeof(GrEnum).} = enum
    GR_EXT_IMAGE_STATE_GRAPHICS_SHADER_FMASK_LOOKUP = 0x00300100
    GR_EXT_IMAGE_STATE_COMPUTE_SHADER_FMASK_LOOKUP = 0x00300101
    GR_EXT_IMAGE_STATE_DATA_TRANSFER_DMA_QUEUE = 0x00300102

  GrExtOcclusionCondition* {.size: sizeof(GrEnum).} = enum
    GR_EXT_OCCLUSION_CONDITION_VISIBLE = 0x00300300
    GR_EXT_OCCLUSION_CONDITION_INVISIBLE = 0x00300301

  GrExtQueueType* {.size: sizeof(GrEnum).} = enum
    GR_EXT_QUEUE_DMA = 0x00300200
    GR_EXT_QUEUE_TIMER = 0x00300201

# Flags
const # GR_EXT_CONTROL_FLOW_FEATURE_FLAGS
  GR_EXT_CONTROL_FLOW_OCCLUSION_PREDICATION* = 0x00000001
  GR_EXT_CONTROL_FLOW_MEMORY_PREDICATION* = 0x00000002
  GR_EXT_CONTROL_FLOW_CONDITIONAL_EXECUTION* = 0x00000004
  GR_EXT_CONTROL_FLOW_LOOP_EXECUTION* = 0x00000008

const # GR_EXT_ACCESS_CLIENT
  GR_EXT_ACCESS_DEFAULT* = 0x00000000
  GR_EXT_ACCESS_CPU* = 0x01000000
  GR_EXT_ACCESS_UNIVERSAL_QUEUE* = 0x02000000
  GR_EXT_ACCESS_COMPUTE_QUEUE* = 0x04000000
  GR_EXT_ACCESS_DMA_QUEUE* = 0x08000000

# Data Structures
type
  GrPhysicalGpuSupportedAxlVersion* {.final.} = object
    minVersion*: GrUint32
    maxVersion*: GrUint32

  GrBorderColorPaletteProperties* {.final.} = object
    maxPaletteSize*: GrUint

  GrBorderColorPaletteCreateInfo* {.final.} = object
    paletteSize*: GrUint

  GrAdvancedMsaaStateCreateInfo* {.final.} = object
    coverageSamples*: GrUint
    pixelShaderSamples*: GrUint
    depthStencilSamples*: GrUint
    colorTargetSamples*: GrUint
    sampleMask*: GrSampleMask
    sampleClusters*: GrUint
    alphaToCoverageSamples*: GrUint
    disableAlphaToCoverageDither*: GrBool
    customSamplePatternEnable*: GrBool
    customSamplePattern*: GrMsaaQuadSamplePattern

  GrFmaskImageViewCreateInfo* {.final.} = object
    image*: GrImage
    baseArraySlice*: GrUint
    arraySize*: GrUint

  GrMsaaQuadSamplePattern* {.final.} = object
    topLeft*: array[GR_MAX_MSAA_RASTERIZER_SAMPLES, GrOffset2d]
    topRight*: array[GR_MAX_MSAA_RASTERIZER_SAMPLES, GrOffset2d]
    bottomLeft*: array[GR_MAX_MSAA_RASTERIZER_SAMPLES, GrOffset2d]
    bottomRight*: array[GR_MAX_MSAA_RASTERIZER_SAMPLES, GrOffset2d]

  GrQueueControlFlowProperties* {.final.} = object
    maxNestingLimit*: GrUint
    controlFlowOperations*: GrFlags

  GrGpuTimestampCalibrationUnion* {.final, union.} = object # todo: public?
    cpuWinPerfCounter*: GrUint64
    padding*: array[16, GrByte]

  GrGpuTimestampCalibration* {.final.} = object
    gpuTimestamp*: GrUint64
    union*: GrGpuTimestampCalibrationUnion

# Functions
{.push callConv: stdcall, importc, dynLib: libmantle}
# Library Versioning
proc grGetExtensionLibraryVersion*(): GrUint32

# Border Color Palette Extension
proc grCreateBorderColorPalette*(device: GrDevice, pCreateInfo: ptr GrBorderColorPaletteCreateInfo, pPalette: ptr GrBorderColorPalette): GrResult
proc grUpdateBorderColorPalette*(palette: GrBorderColorPalette, firstEntry: GrUint, entryCount: GrUint, pEntries: ptr GrFloat): GrResult
proc grCmdBindBorderColorPalette*(cmdBuffer: GrCmdBuffer, pipelineBindPoint: GrPipelineBindPoint, palette: GrBorderColorPalette)

# Advanced Multisampling Extension
proc grCreateAdvancedMsaaState*(device: GrDevice, pCreateInfo: ptr GrAdvancedMsaaStateCreateInfo, pState: ptr GrMsaaStateObject): GrResult
proc grCreateFmaskImageView*(device: GrDevice, pCreateInfo: ptr GrFmaskImageViewCreateInfo, pView: ptr GrImageView): GrResult

# Copy Occlusion Query Data Extension
proc grCmdCopyOcclusionData*(cmdBuffer: GrCmdBuffer, queryPool: GrQueryPool, startQuery: GrUint, queryCount: GrUint, destMem: GrGpuMemory, destOffset: GrGpuSize, accumulateData: GrBool): GrResult # todo: why does a grCmd* function return sth? typo in the documentation?

# Command Buffer Control Flow Extension
proc grCmdSetOcclusionPredication*(cmdBuffer: GrCmdBuffer, queryPool: GrQueryPool, slot: GrUint, condition: GrExtOcclusionCondition, waitResults: GrBool, accumulateData: GrBool)
proc grCmdResetOcclusionPredication*(cmdBuffer: GrCmdBuffer)
proc grCmdSetMemoryPredication*(cmdBuffer: GrCmdBuffer, mem: GrGpuMemory, offset: GrGpuSize)
proc grCmdResetMemoryPredication*(cmdBuffer: GrCmdBuffer)
proc grCmdIf*(cmdBuffer: GrCmdBuffer, srcMem: GrGpuMemory, srcOffset: GrGpuSize, data: GrUint64, mask: GrUint64, function: GrCompareFunc)
proc grCmdElse*(cmdBuffer: GrCmdBuffer)
proc grCmdEndIf*(cmdBuffer: GrCmdBuffer)
proc grCmdWhile*(cmdBuffer: GrCmdBuffer, srcMem: GrGpuMemory, srcOffset: GrGpuSize, data: GrUint64, mask: GrUint64, function: GrCompareFunc)
proc grCmdEndWhile*(cmdBuffer: GrCmdBuffer)

# Timer Queue Extension
proc grQueueDelay*(queue: GrQueue, delay: GrFloat): GrResult

# GPU Timestamp Calibration Extension
proc grCalibrateGpuTimestamp*(device: GrDevice, pCalibrationData: ptr GrGpuTimestampCalibration): GrResult
