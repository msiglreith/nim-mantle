
## Nim wrapper for ``Mantle``

import windows # Wsi

{.deadCodeElim: on.}

# todo: other OS, x86/x86_64
when defined(windows):
  const libmantle* = "mantle64.dll"

# Types
type
  # Standard Types
  GrInt* = cint
  GrUint* = cuint
  GrInt32* = int32
  GrUint8* = uint8
  GrUint32* = uint32
  GrUint64* = uint64
  GrByte* = byte
  GrBool* = bool
  GrChar* = cchar
  GrFloat* = cfloat
  GrSize* = csize

  GrEnum* = cuint
  GrFlags* = uint32 # todo: verify!

  GrDbgMsgCode* = GrEnum # todo:

  GrGpuSize* = csize # todo: verify!
  GrSampleMask* = uint32 # todo: verify!

  # Object Types
  GrBaseObject* = uint64

  GrObject* = GrBaseObject
  GrDevice* = GrBaseObject
  GrPhysicalGpu* = uint64 # todo: verify!
  GrGpuMemory* = uint64 # todo: verify!
  GrQueue* = uint64 # todo: verify

  GrCmdBuffer* = GrObject
  GrDescriptorSet* = GrObject
  GrEvent* = GrObject
  GrImage* = GrObject
  GrFence* = GrObject
  GrPipeline* = GrObject
  GrSampler* = GrObject
  GrShader* = GrObject
  GrStateObject* = GrObject
  GrQueueSemaphore* = GrObject
  GrQueryPool* = GrObject
  GrView* = GrObject

  GrColorTargetView* = GrView
  GrDepthStencilView* = GrView
  GrImageView* = GrView

  GrColorBlendStateObject* = GrStateObject
  GrDepthStencilStateObject* = GrStateObject
  GrMsaaStateObject* = GrStateObject
  GrRasterStateObject* = GrStateObject
  GrViewportStateObject* = GrStateObject

  # Wsi
  GrWsiWinDisplay* = GrObject

  # Extensions
  GrBorderColorPalette* = GrObject

# Error codes / result
type
  GrResult* {.size: sizeof(GrEnum).} = enum
    # todo: verify!
    GR_SUCCESS = 0x10000
    GR_UNSUPPORTED
    GR_NOT_READY
    GR_TIMEOUT
    GR_EVENT_SET
    GR_EVENT_RESET

    GR_ERROR_UNKNOWN = 0x11000
    GR_ERROR_UNAVAILABLE
    GR_ERROR_INITIALIZATION_FAILED
    GR_ERROR_OUT_OF_MEMORY
    GR_ERROR_OUT_OF_GPU_MEMORY
    GR_ERROR_DEVICE_ALREADY_CREATED
    GR_ERROR_DEVICE_LOST
    GR_ERROR_INVALID_POINTER
    GR_ERROR_INVALID_VALUE
    GR_ERROR_INVALID_HANDLE
    GR_ERROR_INVALID_ORDINAL
    GR_ERROR_INVALID_MEMORY_SIZE
    GR_ERROR_INVALID_EXTENSION
    GR_ERROR_INVALID_FLAGS
    GR_ERROR_INVALID_ALIGNMENT
    GR_ERROR_INVALID_FORMAT
    GR_ERROR_INVALID_IMAGE
    GR_ERROR_INVALID_DESCRIPTOR_SET_DATA
    GR_ERROR_INVALID_QUEUE_TYPE
    GR_ERROR_INVALID_OBJECT_TYPE
    GR_ERROR_UNSUPPORTED_SHADER_IL_VERSION
    GR_ERROR_BAD_SHADER_CODE
    GR_ERROR_BAD_PIPELINE_DATA
    GR_ERROR_TOO_MANY_MEMORY_REFERENCES
    GR_ERROR_NOT_MAPPABLE
    GR_ERROR_MEMORY_MAP_FAILED
    GR_ERROR_MEMORY_UNMAP_FAILED
    GR_ERROR_INCOMPATIBLE_DEVICE
    GR_ERROR_INCOMPATIBLE_DRIVER
    GR_ERROR_INCOMPLETE_COMMAND_BUFFER
    GR_ERROR_BUILDING_COMMAND_BUFFER
    GR_ERROR_MEMORY_NOT_BOUND
    GR_ERROR_INCOMPATIBLE_QUEUE
    GR_ERROR_NOT_SHAREABLE

    # todo:
    # Wsi
    GR_WSI_WIN_PRESENT_OCCLUDED
    GR_WSI_WIN_ERROR_FULLSCREEN_UNAVAILABLE
    GR_WSI_WIN_ERROR_DISPLAY_REMOVED
    GR_WSI_WIN_ERROR_INCOMPATIBLE_DISPLAY_MODE
    GR_WSI_WIN_ERROR_MULTI_DEVICE_PRESENT_FAILED
    GR_WSI_WIN_ERROR_WINDOWED_PRESENT_UNAVAILABLE
    GR_WSI_WIN_ERROR_INVALID_RESOLUTION

# Constants
const
  GR_API_VERSION*: GrUint32 = 1 # todo: verify!

  GR_MAX_COLOR_TARGETS*: GrSize = 16 # todo: verify!
  GR_MAX_DESCRIPTOR_SETS*: GrSize = 1 # todo: verify!
  GR_MAX_DEVICE_NAME_LEN*: GrSize = 128 # todo: verify!
  GR_MAX_PHYSICAL_GPUS*: GrSize = 8 # todo: verify!
  GR_MAX_PHYSICAL_GPU_NAME*: GrSize = 128 # todo: verify!
  GR_MAX_MEMORY_HEAPS*: GrSize = 8 # todo: verify!
  GR_MAX_VIEWPORTS*: GrSize = 8 # todo: verify!

  # Wsi
  GR_MAX_GAMMA_RAMP_CONTROL_POINTS*: GrSize = 1 # todo: verify!

  # Extension
  GR_MAX_MSAA_RASTERIZER_SAMPLES*: GrSize = 1 # todo: verify!

# Enumerations
type
  GrAtomicOp* {.size: sizeof(GrEnum).} = enum
    GR_ATOMIC_ADD_INT32 = 0x2d00
    GR_ATOMIC_SUB_INT32 = 0x2d01
    GR_ATOMIC_MIN_UINT32 = 0x2d02
    GR_ATOMIC_MAX_UINT32 = 0x2d03
    GR_ATOMIC_MIN_SINT32 = 0x2d04
    GR_ATOMIC_MAX_SINT32 = 0x2d05
    GR_ATOMIC_AND_INT32 = 0x2d06
    GR_ATOMIC_OR_INT32 = 0x2d07
    GR_ATOMIC_XOR_INT32 = 0x2d08
    GR_ATOMIC_INC_UINT32 = 0x2d09
    GR_ATOMIC_DEC_UINT32 = 0x2d0a
    GR_ATOMIC_ADD_INT64 = 0x2d0b
    GR_ATOMIC_SUB_INT64 = 0x2d0c
    GR_ATOMIC_MIN_UINT64 = 0x2d0d
    GR_ATOMIC_MAX_UINT64 = 0x2d0e
    GR_ATOMIC_MIN_SINT64 = 0x2d0f
    GR_ATOMIC_MAX_SINT64 = 0x2d10
    GR_ATOMIC_AND_INT64 = 0x2d11
    GR_ATOMIC_OR_INT64 = 0x2d12
    GR_ATOMIC_XOR_INT64 = 0x2d13
    GR_ATOMIC_INC_UINT64 = 0x2d14
    GR_ATOMIC_DEC_UINT64 = 0x2d15

  GrBorderColorType* {.size: sizeof(GrEnum).} = enum
    GR_BORDER_COLOR_WHITE = 0x1c00
    GR_BORDER_COLOR_TRANSPARENT_BLACK = 0x1c01
    GR_BORDER_COLOR_OPAQUE_BLACK = 0x1c02

    # Extension
    GR_EXT_BORDER_COLOR_TYPE_PALETTE_ENTRY_0 = 0x0030a000

  GrBlend* {.size: sizeof(GrEnum).} = enum
    GR_BLEND_ZERO = 0x2900
    GR_BLEND_ONE = 0x2901
    GR_BLEND_SRC_COLOR = 0x2902
    GR_BLEND_ONE_MINUS_SRC_COLOR = 0x2903
    GR_BLEND_DEST_COLOR = 0x2904
    GR_BLEND_ONE_MINUS_DEST_COLOR = 0x2905
    GR_BLEND_SRC_ALPHA = 0x2906
    GR_BLEND_ONE_MINUS_SRC_ALPHA = 0x2907
    GR_BLEND_DEST_ALPHA = 0x2908
    GR_BLEND_ONE_MINUS_DEST_ALPHA = 0x2909
    GR_BLEND_CONSTANT_COLOR = 0x290a
    GR_BLEND_ONE_MINUS_CONSTANT_COLOR = 0x290b
    GR_BLEND_CONSTANT_ALPHA = 0x290c
    GR_BLEND_ONE_MINUS_CONSTANT_ALPHA = 0x290d
    GR_BLEND_SRC_ALPHA_SATURATE = 0x290e
    GR_BLEND_SRC1_COLOR = 0x290f
    GR_BLEND_ONE_MINUS_SRC1_COLOR = 0x2910
    GR_BLEND_SRC1_ALPHA = 0x2911
    GR_BLEND_ONE_MINUS_SRC1_ALPHA = 0x2912

  GrBlendFunc* {.size: sizeof(GrEnum).} = enum
    GR_BLEND_FUNC_ADD = 0x2a00
    GR_BLEND_FUNC_SUBTRACT = 0x2a01
    GR_BLEND_FUNC_REVERSE_SUBTRACT = 0x2a02
    GR_BLEND_FUNC_MIN = 0x2a03
    GR_BLEND_FUNC_MAX = 0x2a04

  GrChannelFormat* {.size: sizeof(GrEnum).} = enum
    GR_CH_FMT_UNDEFINED = 0
    GR_CH_FMT_R4G4 = 1
    GR_CH_FMT_R4G4B4A4 = 2
    GR_CH_FMT_R5G6B5 = 3
    GR_CH_FMT_B5G6R5 = 4
    GR_CH_FMT_R5G5B5A1 = 5
    GR_CH_FMT_R8 = 6
    GR_CH_FMT_R8G8 = 7
    GR_CH_FMT_R8G8B8A8 = 8
    GR_CH_FMT_B8G8R8A8 = 9
    GR_CH_FMT_R10G11B11 = 10
    GR_CH_FMT_R11G11B10 = 11
    GR_CH_FMT_R10G10B10A2 = 12
    GR_CH_FMT_R16 = 13
    GR_CH_FMT_R16G16 = 14
    GR_CH_FMT_R16G16B16A16 = 15
    GR_CH_FMT_R32 = 16
    GR_CH_FMT_R32G32 = 17
    GR_CH_FMT_R32G32B32 = 18
    GR_CH_FMT_R32G32B32A32 = 19
    GR_CH_FMT_R16G8 = 20
    GR_CH_FMT_R32G8 = 21
    GR_CH_FMT_R9G9B9E5 = 22
    GR_CH_FMT_BC1 = 23
    GR_CH_FMT_BC2 = 24
    GR_CH_FMT_BC3 = 25
    GR_CH_FMT_BC4 = 26
    GR_CH_FMT_BC5 = 27
    GR_CH_FMT_BC6U = 28
    GR_CH_FMT_BC6S = 29
    GR_CH_FMT_BC7 = 30

  GrChannelSwizzle* {.size: sizeof(GrEnum).} = enum
    GR_CHANNEL_SWIZZLE_ZERO = 0x1800
    GR_CHANNEL_SWIZZLE_ONE = 0x1801
    GR_CHANNEL_SWIZZLE_R = 0x1802
    GR_CHANNEL_SWIZZLE_G = 0x1803
    GR_CHANNEL_SWIZZLE_B = 0x1804
    GR_CHANNEL_SWIZZLE_A = 0x1805

  GrCompareFunc* {.size: sizeof(GrEnum).} = enum
    GR_COMPARE_NEVER = 0x2500
    GR_COMPARE_LESS = 0x2501
    GR_COMPARE_EQUAL = 0x2502
    GR_COMPARE_LESS_EQUAL = 0x2503
    GR_COMPARE_GREATER = 0x2504
    GR_COMPARE_NOT_EQUAL = 0x2505
    GR_COMPARE_GREATER_EQUAL = 0x2506
    GR_COMPARE_ALWAYS = 0x2507

  GrCullMode* {.size: sizeof(GrEnum).} = enum
    GR_CULL_NONE = 0x2700
    GR_CULL_FRONT = 0x2701
    GR_CULL_BACK = 0x2702

  GrDescriptorSetSlotType* {.size: sizeof(GrEnum).} = enum
    GR_SLOT_UNUSED = 0x1900
    GR_SLOT_SHADER_RESOURCE = 0x1901
    GR_SLOT_SHADER_UAV = 0x1902
    GR_SLOT_SHADER_SAMPLER = 0x1903
    GR_SLOT_NEXT_DESCRIPTOR_SET = 0x1904

  GrFaceOrientation* {.size: sizeof(GrEnum).} = enum
    GR_FRONT_FACE_CCW = 0x2800
    GR_FRONT_FACE_CW = 0x2801

  GrFillMode* {.size: sizeof(GrEnum).} = enum
    GR_FILL_SOLID = 0x2600
    GR_FILL_WIREFRAME = 0x2601

  GrHeapMemoryType* {.size: sizeof(GrEnum).} = enum
    GR_HEAP_MEMORY_OTHER = 0x2f00
    GR_HEAP_MEMORY_LOCAL = 0x2f01
    GR_HEAP_MEMORY_REMOTE = 0x2f02
    GR_HEAP_MEMORY_EMBEDDED = 0x2f03

  GrImageAspect* {.size: sizeof(GrEnum).} = enum
    GR_IMAGE_ASPECT_COLOR = 0x1700
    GR_IMAGE_ASPECT_DEPTH = 0x1701
    GR_IMAGE_ASPECT_STENCIL = 0x1702

  GrImageState* {.size: sizeof(GrEnum).} = enum
    GR_IMAGE_STATE_DATA_TRANSFER = 0x1300
    GR_IMAGE_STATE_GRAPHICS_SHADER_READ_ONLY = 0x1301
    GR_IMAGE_STATE_GRAPHICS_SHADER_WRITE_ONLY = 0x1302
    GR_IMAGE_STATE_GRAPHICS_SHADER_READ_WRITE = 0x1303
    GR_IMAGE_STATE_COMPUTE_SHADER_READ_ONLY = 0x1304
    GR_IMAGE_STATE_COMPUTE_SHADER_WRITE_ONLY = 0x1305
    GR_IMAGE_STATE_COMPUTE_SHADER_READ_WRITE = 0x1306
    GR_IMAGE_STATE_MULTI_SHADER_READ_ONLY = 0x1307
    GR_IMAGE_STATE_TARGET_AND_SHADER_READ_ONLY = 0x1308
    GR_IMAGE_STATE_UNINITIALIZED = 0x1309
    GR_IMAGE_STATE_TARGET_RENDER_ACCESS_OPTIMAL = 0x130a
    GR_IMAGE_STATE_TARGET_SHADER_ACCESS_OPTIMAL = 0x130b
    GR_IMAGE_STATE_CLEAR = 0x130c
    GR_IMAGE_STATE_RESOLVE_SOURCE = 0x130d
    GR_IMAGE_STATE_RESOLVE_DESTINATION = 0x130e
    GR_IMAGE_STATE_DATA_TRANSFER_SOURCE = 0x1310
    GR_IMAGE_STATE_DATA_TRANSFER_DESTINATION = 0x1311
    GR_IMAGE_STATE_DISCARD = 0x131f

    # Wsi
    GR_WSI_WIN_IMAGE_STATE_PRESENT_WINDOWED = 0x00200000
    GR_WSI_WIN_IMAGE_STATE_PRESENT_FULLSCREEN = 0x00200001

    # Extension
    GR_EXT_IMAGE_STATE_GRAPHICS_SHADER_FMASK_LOOKUP = 0x00300100
    GR_EXT_IMAGE_STATE_COMPUTE_SHADER_FMASK_LOOKUP = 0x00300101
    GR_EXT_IMAGE_STATE_DATA_TRANSFER_DMA_QUEUE = 0x00300102

  GrImageTiling* {.size: sizeof(GrEnum).} = enum
    GR_LINEAR_TILING = 0x1500
    GR_OPTIMAL_TILING = 0x1501

  GrImageType* {.size: sizeof(GrEnum).} = enum
    GR_IMAGE_1D = 0x1400
    GR_IMAGE_2D = 0x1401
    GR_IMAGE_3D = 0x1402

  GrImageViewType* {.size: sizeof(GrEnum).} = enum
    GR_IMAGE_VIEW_1D = 0x1600
    GR_IMAGE_VIEW_2D = 0x1601
    GR_IMAGE_VIEW_3D = 0x1602
    GR_IMAGE_VIEW_CUBE = 0x1603

  GrIndexType* {.size: sizeof(GrEnum).} = enum
    GR_INDEX_16 = 0x2100
    GR_INDEX_32 = 0x2101

  GrInfoType* {.size: sizeof(GrEnum).} = enum
    GR_INFO_TYPE_PHYSICAL_GPU_PROPERTIES = 0x6100
    GR_INFO_TYPE_PHYSICAL_GPU_PERFORMANCE = 0x6101
    GR_INFO_TYPE_PHYSICAL_GPU_QUEUE_PROPERTIES = 0x6102
    GR_INFO_TYPE_PHYSICAL_GPU_MEMORY_PROPERTIES = 0x6103
    GR_INFO_TYPE_PHYSICAL_GPU_IMAGE_PROPERTIES = 0x6104
    GR_INFO_TYPE_MEMORY_HEAP_PROPERTIES = 0x6200
    GR_INFO_TYPE_FORMAT_PROPERTIES = 0x6300
    GR_INFO_TYPE_SUBRESOURCE_LAYOUT = 0x6400
    GR_INFO_TYPE_MEMORY_REQUIREMENTS = 0x6800
    GR_INFO_TYPE_PARENT_DEVICE = 0x6801
    GR_INFO_TYPE_PARENT_PHYSICAL_GPU = 0x6802

    # Wsi
    GR_WSI_WIN_INFO_TYPE_QUEUE_PROPERTIES = 0x00206800
    GR_WSI_WIN_INFO_TYPE_DISPLAY_PROPERTIES = 0x00206801
    GR_WSI_WIN_INFO_TYPE_GAMMA_RAMP_CAPABILITIES = 0x00206802
    GR_WSI_WIN_INFO_TYPE_DISPLAY_FREESYNC_SUPPORT = 0x00206803
    GR_WSI_WIN_INFO_TYPE_PRESENTABLE_IMAGE_PROPERTIES = 0x00206804
    GR_WSI_WIN_INFO_TYPE_EXTENDED_DISPLAY_PROPERTIES = 0x00206805

    # Extension
    GR_EXT_INFO_TYPE_PHYSICAL_GPU_SUPPORTED_AXL_VERSION = 0x00306100
    GR_EXT_INFO_TYPE_QUEUE_BORDER_COLOR_PALETTE_PROPERTIES = 0x00306800
    GR_EXT_INFO_TYPE_QUEUE_CONTROL_FLOW_PROPERTIES = 0x00306801

  GrLogicOp* {.size: sizeof(GrEnum).} = enum
    GR_LOGIC_OP_COPY = 0x2c00
    GR_LOGIC_OP_CLEAR = 0x2c01
    GR_LOGIC_OP_AND = 0x2c02
    GR_LOGIC_OP_AND_REVERSE = 0x2c03
    GR_LOGIC_OP_AND_INVERTED = 0x2c04
    GR_LOGIC_OP_NOOP = 0x2c05
    GR_LOGIC_OP_XOR = 0x2c06
    GR_LOGIC_OP_OR = 0x2c07
    GR_LOGIC_OP_NOR = 0x2c08
    GR_LOGIC_OP_EQUIV = 0x2c09
    GR_LOGIC_OP_INVERT = 0x2c0a
    GR_LOGIC_OP_OR_REVERSE = 0x2c0b
    GR_LOGIC_OP_COPY_INVERTED = 0x2c0c
    GR_LOGIC_OP_OR_INVERTED = 0x2c0d
    GR_LOGIC_OP_NAND = 0x2c0e
    GR_LOGIC_OP_SET = 0x2c0f

  GrMemoryPriority* {.size: sizeof(GrEnum).} = enum
    GR_MEMORY_PRIORITY_NORMAL = 0x1100
    GR_MEMORY_PRIORITY_HIGH = 0x1101
    GR_MEMORY_PRIORITY_LOW = 0x1102
    GR_MEMORY_PRIORITY_UNUSED = 0x1103
    GR_MEMORY_PRIORITY_VERY_HIGH = 0x1104
    GR_MEMORY_PRIORITY_VERY_LOW = 0x1105

  GrMemoryState* {.size: sizeof(GrEnum).} = enum
    GR_MEMORY_STATE_DATA_TRANSFER = 0x1200
    GR_MEMORY_STATE_GRAPHICS_SHADER_READ_ONLY = 0x1201
    GR_MEMORY_STATE_GRAPHICS_SHADER_WRITE_ONLY = 0x1202
    GR_MEMORY_STATE_GRAPHICS_SHADER_READ_WRITE = 0x1203
    GR_MEMORY_STATE_COMPUTE_SHADER_READ_ONLY = 0x1204
    GR_MEMORY_STATE_COMPUTE_SHADER_WRITE_ONLY = 0x1205
    GR_MEMORY_STATE_COMPUTE_SHADER_READ_WRITE = 0x1206
    GR_MEMORY_STATE_MULTI_USE_READ_ONLY = 0x1207
    GR_MEMORY_STATE_INDEX_DATA = 0x1208
    GR_MEMORY_STATE_INDIRECT_ARG = 0x1209
    GR_MEMORY_STATE_WRITE_TIMESTAMP = 0x120a
    GR_MEMORY_STATE_QUEUE_ATOMIC = 0x120b
    GR_MEMORY_STATE_DISCARD = 0x120c
    GR_MEMORY_STATE_DATA_TRANSFER_SOURCE = 0x120d
    GR_MEMORY_STATE_DATA_TRANSFER_DESTINATION = 0x120e

    # Extension
    GR_EXT_MEMORY_STATE_COPY_OCCLUSION_DATA = 0x00300000
    GR_EXT_MEMORY_STATE_CMD_CONTROL = 0x00300001

  GrNumFormat* {.size: sizeof(GrEnum).} = enum
    GR_NUM_FMT_UNDEFINED = 0
    GR_NUM_FMT_UNORM = 1
    GR_NUM_FMT_SNORM = 2
    GR_NUM_FMT_UINT = 3
    GR_NUM_FMT_SINT = 4
    GR_NUM_FMT_FLOAT = 5
    GR_NUM_FMT_SRGB = 6
    GR_NUM_FMT_DS = 7

  GrPhysicalGpuType* {.size: sizeof(GrEnum).} = enum
    GR_GPU_TYPE_OTHER = 0x3000
    GR_GPU_TYPE_INTEGRATED = 0x3001
    GR_GPU_TYPE_DISCRETE = 0x3002
    GR_GPU_TYPE_VIRTUAL = 0x3003

  GrPipelineBindPoint* {.size: sizeof(GrEnum).} = enum
    GR_PIPELINE_BIND_POINT_COMPUTE = 0x1e00
    GR_PIPELINE_BIND_POINT_GRAPHICS = 0x1e01

  GrPrimitiveTopology* {.size: sizeof(GrEnum).} = enum
    GR_TOPOLOGY_POINT_LIST = 0x2000
    GR_TOPOLOGY_LINE_LIST = 0x2001
    GR_TOPOLOGY_LINE_STRIP = 0x2002
    GR_TOPOLOGY_TRIANGLE_LIST = 0x2003
    GR_TOPOLOGY_TRIANGLE_STRIP = 0x2004
    GR_TOPOLOGY_RECT_LIST = 0x2005
    GR_TOPOLOGY_QUAD_LIST = 0x2006
    GR_TOPOLOGY_QUAD_STRIP = 0x2007
    GR_TOPOLOGY_LINE_LIST_ADJ = 0x2008
    GR_TOPOLOGY_LINE_STRIP_ADJ = 0x2009
    GR_TOPOLOGY_TRIANGLE_LIST_ADJ = 0x200a
    GR_TOPOLOGY_TRIANGLE_STRIP_ADJ = 0x200b
    GR_TOPOLOGY_PATCH = 0x200c

  GrQueryType* {.size: sizeof(GrEnum).} = enum
    GR_QUERY_OCCLUSION = 0x1a00
    GR_QUERY_PIPELINE_STATISTICS = 0x1a01

  GrQueueType* {.size: sizeof(GrEnum).} = enum
    GR_QUEUE_UNIVERSAL = 0x1000
    GR_QUEUE_COMPUTE = 0x1001

    # Extension
    GR_EXT_QUEUE_DMA = 0x00300200
    GR_EXT_QUEUE_TIMER = 0x00300201

  GrStateBindPoint* {.size: sizeof(GrEnum).} = enum
    GR_STATE_BIND_VIEWPORT = 0x1f00
    GR_STATE_BIND_RASTER = 0x1f01
    GR_STATE_BIND_DEPTH_STENCIL = 0x1f02
    GR_STATE_BIND_COLOR_BLEND = 0x1f03
    GR_STATE_BIND_MSAA = 0x1f04

  GrStencilOp* {.size: sizeof(GrEnum).} = enum
    GR_STENCIL_OP_KEEP = 0x2b00
    GR_STENCIL_OP_ZERO = 0x2b01
    GR_STENCIL_OP_REPLACE = 0x2b02
    GR_STENCIL_OP_INC_CLAMP = 0x2b03
    GR_STENCIL_OP_DEC_CLAMP = 0x2b04
    GR_STENCIL_OP_INVERT = 0x2b05
    GR_STENCIL_OP_INC_WRAP = 0x2b06
    GR_STENCIL_OP_DEC_WRAP = 0x2b07

  GrSystemAllocType* {.size: sizeof(GrEnum).} = enum
    GR_SYSTEM_ALLOC_API_OBJECT = 0x2e00
    GR_SYSTEM_ALLOC_INTERNAL = 0x2e01
    GR_SYSTEM_ALLOC_INTERNAL_TEMP = 0x2e02
    GR_SYSTEM_ALLOC_INTERNAL_SHADER = 0x2e03
    GR_SYSTEM_ALLOC_DEBUG = 0x2e04

  GrTexAddress* {.size: sizeof(GrEnum).} = enum
    GR_TEX_ADDRESS_WRAP = 0x2400
    GR_TEX_ADDRESS_MIRROR = 0x2401
    GR_TEX_ADDRESS_CLAMP = 0x2402
    GR_TEX_ADDRESS_MIRROR_ONCE = 0x2403
    GR_TEX_ADDRESS_CLAMP_BORDER = 0x2404

  GrTexFilter* {.size: sizeof(GrEnum).} = enum
    GR_TEX_FILTER_MAG_POINT_MIN_POINT_MIP_POINT = 0x2340
    GR_TEX_FILTER_MAG_LINEAR_MIN_POINT_MIP_POINT = 0x2341
    GR_TEX_FILTER_MAG_POINT_MIN_LINEAR_MIP_POINT = 0x2344
    GR_TEX_FILTER_MAG_LINEAR_MIN_LINEAR_MIP_POINT = 0x2345
    GR_TEX_FILTER_MAG_POINT_MIN_POINT_MIP_LINEAR = 0x2380
    GR_TEX_FILTER_MAG_LINEAR_MIN_POINT_MIP_LINEAR = 0x2381
    GR_TEX_FILTER_MAG_POINT_MIN_LINEAR_MIP_LINEAR = 0x2384
    GR_TEX_FILTER_MAG_LINEAR_MIN_LINEAR_MIP_LINEAR = 0x2385
    GR_TEX_FILTER_ANISOTROPIC = 0x238f

  GrTimestampType* {.size: sizeof(GrEnum).} = enum
    GR_TIMESTAMP_TOP = 0x1b00
    GR_TIMESTAMP_BOTTOM = 0x1b01

  GrValidationLevel* {.size: sizeof(GrEnum).} = enum
    GR_VALIDATION_LEVEL_0 = 0x8000
    GR_VALIDATION_LEVEL_1 = 0x8001
    GR_VALIDATION_LEVEL_2 = 0x8002
    GR_VALIDATION_LEVEL_3 = 0x8003
    GR_VALIDATION_LEVEL_4 = 0x8004

  GrDbgDataType* {.size: sizeof(GrEnum).} = enum
    GR_DBG_DATA_OBJECT_TYPE = 0x00020a00
    GR_DBG_DATA_OBJECT_CREATE_INFO = 0x00020a01
    GR_DBG_DATA_OBJECT_TAG = 0x00020a02
    GR_DBG_DATA_CMD_BUFFER_API_TRACE = 0x00020b00
    GR_DBG_DATA_MEMORY_OBJECT_LAYOUT = 0x00020c00
    GR_DBG_DATA_MEMORY_OBJECT_STATE = 0x00020c01
    GR_DBG_DATA_SEMAPHORE_IS_BLOCKED = 0x00020d00

  GrDbgDeviceOption* {.size: sizeof(GrEnum).} = enum
    GR_DBG_OPTION_DISABLE_PIPELINE_LOADS = 0x00020400
    GR_DBG_OPTION_FORCE_OBJECT_MEMORY_REQS = 0x00020401,
    GR_DBG_OPTION_FORCE_LARGE_IMAGE_ALIGNMENT = 0x00020402
    GR_DBG_OPTION_SKIP_EXECUTION_ON_ERROR = 0x00020403

  GrDbgGlobalOption* {.size: sizeof(GrEnum).} = enum
    GR_DBG_OPTION_DEBUG_ECHO_ENABLE = 0x00020100
    GR_DBG_OPTION_BREAK_ON_ERROR = 0x00020101
    GR_DBG_OPTION_BREAK_ON_WARNING = 0x00020102

  GrDbgMsgFilter* {.size: sizeof(GrEnum).} = enum
    GR_DBG_MSG_FILTER_NONE = 0x00020800
    GR_DBG_MSG_FILTER_REPEATED = 0x00020801
    GR_DBG_MSG_FILTER_ALL = 0x00020802

  GrDbgMsgType* {.size: sizeof(GrEnum).} = enum
    GR_DBG_MSG_UNKNOWN = 0x00020000
    GR_DBG_MSG_ERROR = 0x00020001
    GR_DBG_MSG_WARNING = 0x00020002
    GR_DBG_MSG_PERF_WARNING = 0x00020003

  GrDbgObjectType* {.size: sizeof(GrEnum).} = enum
    GR_DBG_OBJECT_UNKNOWN = 0x00020900
    GR_DBG_OBJECT_DEVICE = 0x00020901
    GR_DBG_OBJECT_QUEUE = 0x00020902
    GR_DBG_OBJECT_GPU_MEMORY = 0x00020903
    GR_DBG_OBJECT_IMAGE = 0x00020904
    GR_DBG_OBJECT_IMAGE_VIEW = 0x00020905
    GR_DBG_OBJECT_COLOR_TARGET_VIEW = 0x00020906
    GR_DBG_OBJECT_DEPTH_STENCIL_VIEW = 0x00020907
    GR_DBG_OBJECT_SHADER = 0x00020908
    GR_DBG_OBJECT_GRAPHICS_PIPELINE = 0x00020909
    GR_DBG_OBJECT_COMPUTE_PIPELINE = 0x0002090a
    GR_DBG_OBJECT_SAMPLER = 0x0002090b
    GR_DBG_OBJECT_DESCRIPTOR_SET = 0x0002090c
    GR_DBG_OBJECT_VIEWPORT_STATE = 0x0002090d
    GR_DBG_OBJECT_RASTER_STATE = 0x0002090e
    GR_DBG_OBJECT_MSAA_STATE = 0x0002090f
    GR_DBG_OBJECT_COLOR_BLEND_STATE = 0x00020910
    GR_DBG_OBJECT_DEPTH_STENCIL_STATE = 0x00020911
    GR_DBG_OBJECT_CMD_BUFFER = 0x00020912
    GR_DBG_OBJECT_FENCE = 0x00020913
    GR_DBG_OBJECT_QUEUE_SEMAPHORE = 0x00020914
    GR_DBG_OBJECT_EVENT = 0x00020915
    GR_DBG_OBJECT_QUERY_POOL = 0x00020916
    GR_DBG_OBJECT_SHARED_GPU_MEMORY = 0x00020917
    GR_DBG_OBJECT_SHARED_QUEUE_SEMAPHORE = 0x00020918
    GR_DBG_OBJECT_PEER_GPU_MEMORY = 0x00020919
    GR_DBG_OBJECT_PEER_IMAGE = 0x0002091a
    GR_DBG_OBJECT_PINNED_GPU_MEMORY = 0x0002091b
    GR_DBG_OBJECT_INTERNAL_GPU_MEMORY = 0x0002091c

  # Wsi
  GrWsiWinPresentMode* {.size: sizeof(GrEnum).} = enum
    GR_WSI_WIN_PRESENT_MODE_WINDOWED = 0x00200200
    GR_WSI_WIN_PRESENT_MODE_FULLSCREEN = 0x00200201

  GrWsiWinRotationAngle* {.size: sizeof(GrEnum).} = enum
    GR_WSI_WIN_ROTATION_ANGLE_0 = 0x00200100
    GR_WSI_WIN_ROTATION_ANGLE_90 = 0x00200101
    GR_WSI_WIN_ROTATION_ANGLE_180 = 0x00200102
    GR_WSI_WIN_ROTATION_ANGLE_270 = 0x00200103

  # Extension
  GrExtOcclusionCondition* {.size: sizeof(GrEnum).} = enum
    GR_EXT_OCCLUSION_CONDITION_VISIBLE = 0x00300300
    GR_EXT_OCCLUSION_CONDITION_INVISIBLE = 0x00300301


# Flags
const # GR_CMD_BUFFER_BUILD_FLAGS
  GR_CMD_BUFFER_OPTIMIZE_GPU_SMALL_BATCH* = 0x00000001
  GR_CMD_BUFFER_OPTIMIZE_PIPELINE_SWITCH* = 0x00000002
  GR_CMD_BUFFER_OPTIMIZE_ONE_TIME_SUBMIT* = 0x00000004
  GR_CMD_BUFFER_OPTIMIZE_DESCRIPTOR_SET_SWITCH* = 0x00000008

const # GR_DEPTH_STENCIL_VIEW_CREATE_FLAGS
  GR_DEPTH_STENCIL_VIEW_CREATE_READ_ONLY_DEPTH* = 0x00000001
  GR_DEPTH_STENCIL_VIEW_CREATE_READ_ONLY_STENCIL* = 0x00000002

const # GR_DEVICE_CREATE_FLAGS
  GR_DEVICE_CREATE_VALIDATION* = 0x00000001

const # GR_FORMAT_FEATURE_FLAGS
  GR_FORMAT_IMAGE_SHADER_READ* = 0x00000001
  GR_FORMAT_IMAGE_SHADER_WRITE* = 0x00000002
  GR_FORMAT_IMAGE_COPY* = 0x00000004
  GR_FORMAT_MEMORY_SHADER_ACCESS* = 0x00000008
  GR_FORMAT_COLOR_TARGET_WRITE* = 0x00000010
  GR_FORMAT_COLOR_TARGET_BLEND* = 0x00000020
  GR_FORMAT_DEPTH_TARGET* = 0x00000040
  GR_FORMAT_STENCIL_TARGET* = 0x00000080
  GR_FORMAT_MSAA_TARGET* = 0x00000100
  GR_FORMAT_CONVERSION* = 0x00000200

const # GR_GPU_COMPATIBILITY_FLAGS
  GR_GPU_COMPAT_ASIC_FEATURES* = 0x00000001
  GR_GPU_COMPAT_IQ_MATCH* = 0x00000002
  GR_GPU_COMPAT_PEER_WRITE_TRANSFER* = 0x00000004
  GR_GPU_COMPAT_SHARED_MEMORY* = 0x00000008
  GR_GPU_COMPAT_SHARED_SYNC* = 0x00000010
  GR_GPU_COMPAT_SHARED_GPU0_DISPLAY* = 0x00000020
  GR_GPU_COMPAT_SHARED_GPU1_DISPLAY* = 0x00000040

const # GR_IMAGE_CREATE_FLAGS
  GR_IMAGE_CREATE_INVARIANT_DATA* = 0x00000001
  GR_IMAGE_CREATE_CLONEABLE* = 0x00000002
  GR_IMAGE_CREATE_SHAREABLE* = 0x00000004
  GR_IMAGE_CREATE_VIEW_FORMAT_CHANGE* = 0x00000008

const # GR_IMAGE_USAGE_FLAGS
  GR_IMAGE_USAGE_SHADER_ACCESS_READ* = 0x00000001
  GR_IMAGE_USAGE_SHADER_ACCESS_WRITE* = 0x00000002
  GR_IMAGE_USAGE_COLOR_TARGET* = 0x00000004
  GR_IMAGE_USAGE_DEPTH_STENCIL* = 0x00000008

const # GR_MEMORY_ALLOC_FLAGS
  GR_MEMORY_ALLOC_VIRTUAL* = 0x00000001
  GR_MEMORY_ALLOC_SHAREABLE* = 0x00000002

const # GR_MEMORY_HEAP_FLAGS
  GR_MEMORY_HEAP_CPU_VISIBLE* = 0x00000001
  GR_MEMORY_HEAP_CPU_GPU_COHERENT* = 0x00000002
  GR_MEMORY_HEAP_CPU_UNCACHED* = 0x00000004
  GR_MEMORY_HEAP_CPU_WRITE_COMBINED* = 0x00000008
  GR_MEMORY_HEAP_HOLDS_PINNED* = 0x00000010
  GR_MEMORY_HEAP_SHAREABLE* = 0x00000020

const # GR_MEMORY_PROPERTY_FLAGS
  GR_MEMORY_MIGRATION_SUPPORT* = 0x00000001
  GR_MEMORY_VIRTUAL_REMAPPING_SUPPORT* = 0x00000002
  GR_MEMORY_PINNING_SUPPORT* = 0x00000004
  GR_MEMORY_PREFER_GLOBAL_REFS* = 0x00000008

const # GR_MEMORY_REF_FLAGS
  GR_MEMORY_REF_READ_ONLY* = 0x00000001

const # GR_PIPELINE_CREATE_FLAGS
  GR_PIPELINE_CREATE_DISABLE_OPTIMIZATION* = 0x00000001

const # GR_QUERY_CONTROL_FLAGS
  GR_QUERY_IMPRECISE_DATA* = 0x00000001

const # GR_SEMAPHORE_CREATE_FLAGS
  GR_SEMAPHORE_CREATE_SHAREABLE* = 0x00000001

const # GR_SHADER_CREATE_FLAGS
  GR_SHADER_CREATE_ALLOW_RE_Z* = 0x00000001

# Wsi
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

# Extension
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

# Callbacks
type
  GrAllocFunction* = proc(size: GrSize, alignment: GrSize, allocType: GrEnum): pointer {.stdcall.}
  GrFreeFunction* = proc(pMem: pointer) {.stdcall.}

  GrDbgMsgCallbackFunction* = proc(msgTyp: GrDbgMsgType, validationLevel: GrValidationLevel, srcObject: GrBaseObject, location: GrSize, msgCode: GrDbgMsgCode, pMsg: ptr GrChar, pUserData: pointer) {.stdcall.}


# Data Structures
type
  GrAllocCallbacks* {.final.} = object
    pfnAlloc*: GrAllocFunction
    pfnFree*: GrFreeFunction

  GrApplicationInfo* {.final.} = object
    pAppName*: ptr GrChar
    appVersion*: GrUint32
    pEngineName*: ptr GrChar
    engineVersion*: GrUint32
    apiVersion*: GrUint32

  GrChannelMapping* {.final.} = object
    r*: GrChannelSwizzle
    g*: GrChannelSwizzle
    b*: GrChannelSwizzle
    a*: GrChannelSwizzle

  GrCmdBufferCreateInfo* {.final.} = object
    queueType*: GrQueueType
    flags*: GrFlags

  GrColorBlendStateCreateInfo* {.final.} = object
    target*: array[GR_MAX_COLOR_TARGETS, GrColorTargetBlendState]
    blendCost*: array[4, GrFloat]

  GrColorTargetBindInfo* {.final.} = object
    view*: GrColorTargetView
    colorTargetState*: GrImageState

  GrColorTargetBlendState* {.final.} = object
    blendEnable*: GrBool
    srcBlendColor*: GrBlend
    destBlendcolor*: GrBlend
    blendFuncColor*: GrBlendFunc
    srcBlendAlpha*: GrBlend
    destBlendAlpha*: GrBlend
    blendFuncAlpha*: GrBlendFunc

  GrColorTargetViewCreateInfo* {.final.} = object
    image*: GrImage
    format*: GrFormat
    mipLevel*: GrUint
    baseArraySlice*: GrUint
    arraySize*: GrUint

  GrComputePipelineCreateInfo* {.final.} = object
    cs*: GrPipelineShader
    flags*: GrFlags

  GrDepthStencilBindInfo* {.final.} = object
    view*: GrDepthStencilView
    depthState*: GrEnum
    stencilState*: GrEnum

  GrDepthStencilOp* {.final.} = object
    stencilFailOp*: GrStencilOp
    stencilPassOp*: GrStencilOp
    stencilDepthFailOp*: GrStencilOp
    stencilFunc*: GrCompareFunc
    stencilRef*: GrUint8

  GrDepthStencilStateCreateInfo* {.final.} = object
    depthEnable*: GrBool
    depthWriteEnable*: GrBool
    depthFunc*: GrCompareFunc
    depthBoundsEnable*: GrBool
    minDepth*: GrFloat
    maxDepth*: GrFloat
    stencilEnable*: GrBool
    stencilReadMask*: GrUint8
    stencilWriteMask*: GrUint8
    front*: GrDepthStencilOp
    back*: GrDepthStencilOp

  GrDepthStencilViewCreateInfo* {.final.} = object
    image*: GrImage
    mipLevel*: GrUint
    baseArraySlice*: GrUint
    arraySize*: GrUint
    flags*: GrFlags

  GrDescriptorSetAttachInfo* {.final.} = object
    descriptorSet*: GrDescriptorSet
    slotOffset*: GrUint

  GrDescriptorSetCreateInfo* {.final.} = object
    slots*: GrUint

  GrDescriptorSetMapping* {.final.} = object
    descriptorCount*: GrUint
    pDescriptorInfo*: ptr GrDescriptorSlotInfo

  GrDescriptorSlotInfoUnion* {.final, union.} = object # todo: public?
      shaderEntityIndex*: GrUint
      pNextLevelSet*: ptr GrDescriptorSetMapping

  GrDescriptorSlotInfo* {.final.} = object
    slotObjectType*: GrDescriptorSetSlotType
    # todo*: anonymous object?
    union*: GrDescriptorSlotInfoUnion

  GrDeviceCreateInfo* {.final.} = object
    queueRecordCount*: GrUint
    pRequestedQueues*: ptr GrDeviceQueueCreateInfo
    extensionCount*: GrUint
    ppEnabledExtensionNames*: ptr GrChar # todo*: ptr of ptr?
    maxValidationLevel*: GrValidationLevel
    flags*: GrFlags

  GrDeviceQueueCreateInfo* {.final.} = object
    queueType*: GrQueueType
    queueCount*: GrUint

  GrDispatchIndirectArg* {.final.} = object
    x*: GrUint32
    y*: GrUint32
    z*: GrUint32

  GrDrawIndexedIndirectArg* {.final.} = object
    indexCount*: GrUint32
    instanceCount*: GrUint32
    firstIndex*: GrUint32
    vertexOffset*: GrInt32
    firstInstance*: GrUint32

  GrDrawIndirectArg* {.final.} = object
    vertexCount*: GrUint32
    instanceCount*: GrUint32
    firstVertex*: GrUint32
    firstInstance*: GrUint32

  GrDynamicMemoryViewSlotInfo* {.final.} = object
    slotObjectType*: GrDescriptorSetSlotType
    shaderEntityIndex*: GrUint

  GrEventCreateInfo* {.final.} = object
    flags*: GrFlags

  GrExtent2d* {.final.} = object
    width*: GrInt
    height*: GrInt

  GrExtent3d* {.final.} = object
    width*: GrInt
    height*: GrInt
    depth*: GrInt

  GrFenceCreateInfo* {.final.} = object
    flags*: GrFlags

  GrFormat* {.final.} = object
    channelFormat *: GrChannelFormat # todo*: 16bit
    numericFormat*: GrNumFormat # todo*: 16bit

  GrFormatProperties* {.final.} = object
    linearTilingFeatures*: GrFlags
    optimalTilingFeatures*: GrFlags

  GrGpuCompatibilityInfo* {.final.} = object
    compatibilityFlags*: GrFlags

  GrGraphicsPipelineCreateInfo* {.final.} = object
    vs*: GrPipelineShader
    hs*: GrPipelineShader
    ds*: GrPipelineShader
    gs*: GrPipelineShader
    ps*: GrPipelineShader
    iaState*: GrPipelineIaState
    tessState*: GrPipelineTessState
    rsState*: GrPipelineRsState
    cbState*: GrPipelineCbState
    dbState*: GrPipelineDbState
    flags*: GrFlags

  GrImageCopy* {.final.} = object
    srcSubresource*: GrImageSubresource
    srcOffset*: GrOffset3d
    destSubresource*: GrImageSubresource
    destOffset*: GrOffset3d
    extent*: GrExtent3d

  GrImageCreateInfo* {.final.} = object
    imageType*: GrIndexType
    format*: GrFormat
    extent*: GrExtent3d
    mipLevels*: GrUint
    arraySize*: GrUint
    samples*: GrUint
    tiling*: GrImageTiling
    usage*: GrFlags
    flags*: GrFlags

  GrImageResolve* {.final.} = object
    srcSubresource*: GrImageSubresource
    srcOffset*: GrOffset2d
    destSubresource*: GrImageSubresource
    destOffset*: GrOffset2d
    extent*: GrExtent2d

  GrImageStateTransition* {.final.} = object
    image*: GrImage
    oldState*: GrImageState
    newState*: GrImageState
    subresourceRange*: GrImageSubresourceRange

  GrImageSubresource* {.final.} = object
    aspect*: GrImageAspect
    mipLevel*: GrUint
    arraySlice*: GrUint

  GrImageSubresourceRange* {.final.} = object
    aspect*: GrImageAspect
    baseMipLevel*: GrUint
    mipLevels*: GrUint
    baseArraySlice*: GrUint
    arraySize*: GrUint

  GrImageViewAttachInfo* {.final.} = object
    view*: GrImageViewType
    state*: GrImageState

  GrImageViewCreateInfo* {.final.} = object
    image*: GrImage
    viewType*: GrImageViewType
    format*: GrFormat
    channels*: GrChannelMapping
    subresourceRange*: GrImageSubresourceRange
    minLod*: GrFloat

  GrLinkConstBuffer* {.final.} = object
    bufferId*: GrUint
    bufferSize*: GrSize
    pBufferData*: pointer

  GrMemoryAllocInfo* {.final.} = object
    size*: GrGpuSize
    alignment*: GrGpuSize
    flags*: GrFlags
    heapCount*: GrUint
    heaps*: array[GR_MAX_MEMORY_HEAPS, GrUint]
    memPriority*: GrMemoryPriority

  GrMemoryCopy* {.final.} = object
    srcOffset*: GrGpuSize
    destOffset*: GrGpuSize
    copySize*: GrGpuSize

  GrMemoryHeapProperties* {.final.} = object
    heapMemoryType*: GrHeapMemoryType
    heapSize*: GrGpuSize
    pageSize*: GrGpuSize
    flags*: GrFlags
    gpuReadPerfRating*: GrFloat
    gpuWritePerfRating*: GrFloat
    cpuReadPerfRating*: GrFloat
    cpuWritePerfRating*: GrFloat

  GrMemoryImageCopy* {.final.} = object
    memOffset*: GrGpuSize
    imageSubresource*: GrImageSubresource
    imageOffset*: GrOffset3d
    imageExtent*: GrExtent3d

  GrMemoryOpenInfo* {.final.} = object
    sharedMem*: GrGpuMemory

  GrMemoryRef* {.final.} = object
    mem*: GrGpuMemory
    flags*: GrFlags

  GrMemoryRequirements* {.final.} = object
    size*: GrGpuSize
    alignment*: GrGpuSize
    heapCount*: GrUint
    heaps*: array[GR_MAX_MEMORY_HEAPS, GrUint]

  GrMemoryStateTransition* {.final.} = object
    mem*: GrGpuMemory
    oldState*: GrMemoryState
    newState*: GrMemoryState
    offset*: GrGpuSize
    regionSize*: GrGpuSize

  GrMemoryViewAttachInfo* {.final.} = object
    mem*: GrGpuMemory
    offset*: GrGpuSize
    range*: GrGpuSize
    stride*: GrGpuSize
    format*: GrFormat
    state*: GrMemoryState

  GrMsaaStateCreateInfo* {.final.} = object
    samples*: GrUint
    sampleMask*: GrSampleMask

  GrOffset2d* {.final.} = object
    x*: GrInt
    y*: GrInt

  GrOffset3d* {.final.} = object
    x*: GrInt
    y*: GrInt
    z*: GrInt

  GrParentDevice* {.final.} = object
    device*: GrDevice

  GrParentPhysicalGpu* {.final.} = object
    gpu*: GrPhysicalGpu

  GrPeerImageOpenInfo* {.final.} = object
    originalImage*: GrImage

  GrPeerMemoryOpenInfo* {.final.} = object
    originalMem*: GrGpuMemory

  GrPhysicalGpuImageProperties* {.final.} = object
    maxSliceWidht*: GrUint
    maxSliceHeight*: GrUint
    maxDepth*: GrUint
    maxArraySlices*: GrUint
    reserved1*: GrUint
    reserved2*: GrUint
    maxMemoryAlignment*: GrGpuSize
    sparseImageSupportLevel*: GrUint32
    flags*: GrFlags

  GrPhysicalGpuMemoryProperties* {.final.} = object
    flags*: GrFlags
    virtualMemPageSize*: GrGpuSize
    maxVirtualMemSize*: GrGpuSize
    maxPhysicalMemSize*: GrGpuSize

  GrPhysicalGpuPerformance* {.final.} = object
    maxGpuClock*: GrFloat
    aluPerClock*: GrFloat
    texPerClock*: GrFloat
    primsPerClock*: GrFloat
    pixelsPerClock*: GrFloat

  GrPhysicalGpuProperties* {.final.} = object
    apiVersion*: GrUint32
    driverVersion*: GrUint32
    vendorId*: GrUint32
    deviceId*: GrUint32
    gpuType*: GrPhysicalGpuType
    gpuName*: array[GR_MAX_PHYSICAL_GPU_NAME, GrChar]
    maxMemRefsPerSubmission*: GrUint
    reserved*: GrGpuSize
    maxInlineMemoryUpdateSize*: GrGpuSize
    maxBoundDescriptorSets*: GrUint
    maxThreadGroupSize*: GrUint
    timestampFrequency*: GrUint64
    multiColorTargetClears*: GrBool

  GrPhysicalGpuQueueProperties* {.final.} = object
    queueType*: GrQueueType
    queueCount*: GrUint
    maxAtomicCounters*: GrUint
    supportsTimestamps*: GrBool

  GrPipelineCbState* {.final.} = object
    alphaToCoverageEnable*: GrBool
    dualSourceBlendEnable*: GrBool
    logicOp*: GrLogicOp
    target*: array[GR_MAX_COLOR_TARGETS, GrPipelineCbTargetState]

  GrPipelineCbTargetState* {.final.} = object
    blendEnable*: GrBool
    format*: GrFormat
    channelWriteMask*: GrUint8

  GrPipelineDbState* {.final.} = object
    format*: GrFormat

  GrPipelineIaState* {.final.} = object
    topology*: GrPrimitiveTopology
    disableVertexReuse*: GrBool

  GrPipelineRsState* {.final.} = object
    depthClipEnable*: GrBool

  GrPipelineShader* {.final.} = object
    shader*: GrShader
    descriptorSetMapping*: array[GR_MAX_DESCRIPTOR_SETS, GrDescriptorSetMapping]
    linkConstBufferCount*: GrUint
    pLinkConstBufferInfo*: ptr GrLinkConstBuffer
    dynamicMemoryViewMapping*: GrDynamicMemoryViewSlotInfo

  GrPipelineStatisticsData* {.final.} = object
    psInvocations*: GrUint64
    cPrimitives*: GrUint64
    cInvocations*: GrUint64
    vsInvocations*: GrUint64
    gsInvocations*: GrUint64
    gsPrimitives*: GrUint64
    iaPrimitives*: GrUint64
    iaVertices*: GrUint64
    hsInvocations*: GrUint64
    dsInvocations*: GrUint64
    csInvocations*: GrUint64

  GrPipelineTessState* {.final.} = object
    patchControlPoints*: GrUint
    optimalTessFactor*: GrFloat

  GrQueryPoolCreateInfo* {.final.} = object
    queryType*: GrQueryType
    slots*: GrUint

  GrQueueSemaphoreCreateInfo* {.final.} = object
    initialCount*: GrUint
    flags*: GrFlags

  GrQueueSemaphoreOpenInfo* {.final.} = object
    sharedSemaphore*: GrQueueSemaphore

  GrRasterStateCreateInfo* {.final.} = object
    fillMode*: GrFillMode
    cullMode*: GrCullMode
    frontFace*: GrFaceOrientation
    depthBias*: GrInt
    depthBiasClamp*: GrFloat
    slopeScaledDepthBias*: GrFloat

  GrRect* {.final.} = object
    offset*: GrOffset2d
    extent*: GrExtent2d

  GrSamplerCreateInfo* {.final.} = object
    filter*: GrTexFilter
    addressU*: GrTexAddress
    addressV*: GrTexAddress
    addressW*: GrTexAddress
    mipLodBias*: GrFloat
    maxAnisotropy*: GrUint
    compareFunc*: GrCompareFunc
    minLod*: GrFloat
    maxLod*: GrFloat
    borderColor*: GrBorderColorType

  GrShaderCreateInfo* {.final.} = object
    codeSize*: GrSize
    pCode*: ptr GrChar
    flags*: GrFlags

  GrSubresourceLayout* {.final.} = object
    offset*: GrGpuSize
    size*: GrGpuSize
    rowPitch*: GrGpuSize
    depthPitch*: GrGpuSize

  GrViewport* {.final.} = object
    originX*: GrFloat
    originY*: GrFloat
    width*: GrFloat
    height*: GrFloat
    minDepth*: GrFloat
    maxDepth*: GrFloat

  GrViewportStateCreateInfo* {.final.} = object
    viewportCount*: GrUint
    scissorEnable*: GrBool
    viewports*: array[GR_MAX_VIEWPORTS, GrViewport]
    scissors*: array[GR_MAX_VIEWPORTS, GrRect]

  GrVirtualMemoryRemapRange* {.final.} = object
    virtualMem*: GrGpuMemory
    virtualStartPage*: GrGpuSize
    realMem*: GrGpuMemory
    realStartPage*: GrGpuSize
    pageCount*: GrGpuSize

  # Wsi
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

  # Extension
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
# Initialization and Device Functions
proc grInitAndEnumerateGpus*(pAppInfo: ptr GrApplicationInfo, pAllocCb: ptr GrAllocCallbacks, pGpuCount: ptr GrUint, gpus: array[GR_MAX_PHYSICAL_GPUS, GrPhysicalGpu]): GR_RESULT
proc grGetGpuInfo*(gpu: GrPhysicalGpu, infoType: GrInfoType, pDataSize: ptr GrSize, pData: pointer): GR_RESULT
proc grCreateDevice*(gpu: GrPhysicalGpu, pCreateInfo: ptr GrDeviceCreateInfo, pDevice: ptr GrDevice): GR_RESULT
proc grDestroyDevice*(device: GrDevice): GR_RESULT

# Extension Discovery Functions
proc grGetExtensionSupport*(gpu: GrPhysicalGpu, pExtName: ptr GrChar): GR_RESULT

# Queue Functions
proc grGetDeviceQueue*(device: GrDevice, queueType: GrQueueType, queueId: GrUint, pQueue: ptr GrQueue): GR_RESULT
proc grQueueWaitIdle*(queue: GrQueue): GR_RESULT
proc grDeviceWaitIdle*(device: GrDevice): GR_RESULT
proc grQueueSubmit*(queue: GrQueue, cmdBufferCount: GrUint, pCmdBuffers: ptr GrCmdBuffer, memRefCount: GrUint, pMemRefs: ptr GrMemoryRef, fence: GrFence): GR_RESULT
proc grQueueSetGlobalMemReferences*(queue: GrQueue, memRefCount: GrUint, pMemRefs: GrMemoryRef): GR_RESULT

# Memory Management Functions
proc grGetMemoryHeapCount*(device: GrDevice, pCount: ptr GrUint): GR_RESULT
proc grGetMemoryHeapInfo*(device: GrDevice, heapId: GrUint, infoType: GrInfoType, pDataSize: ptr GrSize, pData: pointer): GR_RESULT
proc grAllocMemory*(device: GrDevice, pAllocInfo: ptr GrMemoryAllocInfo, pMem: ptr GrGpuMemory): GR_RESULT
proc grFreeMemory*(mem: GrGpuMemory): GR_RESULT
proc grSetMemoryPriority*(mem: GrGpuMemory, priority: GrMemoryPriority): GR_RESULT
proc grMapMemory*(mem: GrGpuMemory, flags: GrFlags, ppData: ptr pointer): GR_RESULT
proc grUnmapMemory*(mem: GrGpuMemory): GR_RESULT
proc grRemapVirtualMemoryPages*(device: GrDevice, rangeCount: GrUint, pRanges: ptr GrVirtualMemoryRemapRange, preWaitSemaphoreCount: ptr GrQueueSemaphore, postSignalSemaphoreCount: GrUint, pPostSignalSemaphores: ptr GrQueueSemaphore): GR_RESULT
proc grPinSystemMemory*(device: GrDevice, pSysMem: pointer, memSize: GrSize, pMem: ptr GrGpuMemory): GR_RESULT

# Generic API Object Management Functions
proc grDestroyObject*(obj: GrObject): GR_RESULT
proc grGetObjectInfo*(obj: GrObject, infoType: GrInfoType, pDataSize: ptr GrSize, pData: pointer): GR_RESULT
proc grBindObjectMemory*(obj: GrObject, mem: GrGpuMemory, offset: GrGpuSize): GR_RESULT

# Image and Sampler Functions
proc grGetFormatInfo*(device: GrDevice, format: GrFormat, infoType: GrInfoType, pDataSize: ptr GrSize, pData: pointer): GR_RESULT
proc grCreateImage*(device: GrDevice, pCreateInfo: ptr GrImageCreateInfo, pImage: ptr GrImage): GR_RESULT
proc grGetImageSubresourceInfo*(image: GrImage, pSubresource: ptr GrImageSubresource, infoType: GrInfoType, pDataSize: ptr GrSize, pData: pointer): GR_RESULT
proc grCreateSampler*(device: GrDevice, pCreateInfo: ptr GrSamplerCreateInfo, pSampler: ptr GrSampler): GR_RESULT

# Image View Functions
proc grCreateImageView*(device: GrDevice, pCreateInfo: ptr GrImageViewCreateInfo, pView: ptr GrImageView): GR_RESULT
proc grCreateColorTargetView*(device: GrDevice, pCreateInfo: ptr GrColorTargetViewCreateInfo, pView: GrColorTargetView): GR_RESULT
proc grCreateDepthStencilView*(device: GrDevice, pCreateInfo: ptr GrDepthStencilViewCreateInfo, pView: GrDepthStencilView): GR_RESULT

# Shader and Pipeline Functions
proc grCreateShader*(device: GrDevice, pCreateInfo: ptr GrShaderCreateInfo, pShader: ptr GrShader): GR_RESULT
proc grCreateGraphicsPipeline*(device: GrDevice, pCreateInfo: ptr GrGraphicsPipelineCreateInfo, pPipeline: ptr GrPipeline): GR_RESULT
proc grCreateComputePipeline*(device: GrDevice, pCreateInfo: ptr GrComputePipelineCreateInfo, pPipeline: ptr GrPipeline): GR_RESULT
proc grStorePipeline*(pipeline: GrPipeline, pDataSize: ptr GrSize, pData: pointer): GR_RESULT
proc grLoadPipeline*(device: GrDevice, dataSize: GrSize, pData: pointer, pPipeline: ptr GrPipeline): GR_RESULT

# Descriptor Set Functions
proc grCreateDescriptorSet*(device: GrDevice, pCreateInfo: ptr GrDescriptorSetCreateInfo, pDescriptorSet: ptr GrDescriptorSet): GR_RESULT
proc grBeginDescriptorSetUpdate*(descriptorSet: GrDescriptorSet): GR_RESULT
proc grEndDescriptorSetUpdate*(descriptorSet: GrDescriptorSet): GR_RESULT
proc grAttachSamplerDescriptors*(descriptorSet: GrDescriptorSet, startSlot: GrUint, slotCount: GrUint, pSamplers: ptr GrSampler): GR_RESULT
proc grAttachImageViewDescriptors*(descriptorSet: GrDescriptorSet, startSlot: GrUint, slotCount: GrUint, pImageViews: ptr GrImageViewAttachInfo): GR_RESULT
proc grAttachMemoryViewDescriptors*(descriptorSet: GrDescriptorSet, startSlot: GrUint, slotCount: GrUint, pMemView: ptr GrMemoryViewAttachInfo): GR_RESULT
proc grAttachNestedDescriptors*(descriptorSet: GrDescriptorSet, startSlot: GrUint, slotCount: GrUint, pNestedDescriptorSets: ptr GrDescriptorSetAttachInfo): GR_RESULT
proc grClearDescriptorSetSlots*(descriptorSet: GrDescriptorSet, startSlot: GrUint, slotCount: GrUint): GR_RESULT

# State Object Functions
proc grCreateViewportState*(device: GrDevice, pCreateInfo: ptr GrViewportStateCreateInfo, pState: ptr GrViewportStateObject): GR_RESULT
proc grCreateRasterState*(device: GrDevice, pCreateInfo: ptr GrRasterStateCreateInfo, pState: ptr GrRasterStateObject): GR_RESULT
proc grCreateColorBlendState*(device: GrDevice, pCreateInfo: ptr GrColorBlendStateCreateInfo, pState: ptr GrColorBlendStateObject): GR_RESULT
proc grCreateDepthStencilState*(device: GrDevice, pCreateInfo: ptr GrDepthStencilStateCreateInfo, pState: ptr GrDepthStencilStateObject): GR_RESULT
proc grCreateMsaaState*(device: GrDevice, pCreateInfo: ptr GrMsaaStateCreateInfo, pState: ptr GrMsaaStateObject): GR_RESULT

# Query and Synchronization Functions
proc grCreateQueryPool*(device: GrDevice, pCreateInfo: ptr GrQueryPoolCreateInfo, pQueryPool: ptr GrQueryPool): GR_RESULT
proc grGetQueryPoolResults*(queryPool: GrQueryPool, startQuery: GrUint, queryCount: GrUint, pDataSize: ptr GrSize, pData: pointer): GR_RESULT
proc grCreateFence*(device: GrDevice, pCreateInfo: ptr GrFenceCreateInfo, pFence: ptr GrFence): GR_RESULT
proc grGetFenceStatus*(fence: GrFence): GR_RESULT
proc grWaitForFences*(device: GrDevice, fenceCount: GrUint, pFences: ptr GrFence, waitAll: GrBool, timeout: GrFloat): GR_RESULT
proc grCreateQueueSemaphore*(device: GrDevice, pCreateInfo: ptr GrQueueSemaphoreCreateInfo): GR_RESULT
proc grSignalQueueSemaphore*(queue: GrQueue, semaphore: GrQueueSemaphore): GR_RESULT
proc grWaitQueueSemaphore*(queue: GrQueue, semaphore: GrQueueSemaphore): GR_RESULT
proc grCreateEvent*(device: GrDevice, pCreateInfo: ptr GrEventCreateInfo, pEvent: ptr GrEvent): GR_RESULT
proc grGetEventStatus*(event: GrEvent): GR_RESULT
proc grSetEvent*(event: GrEvent): GR_RESULT
proc grResetEvent*(event: GrEvent): GR_RESULT

# Multi-Device Management Functions
proc grGetMultiGpuCompatibility*(gpu0, GrPhysicalGpu, gpu1: GrPhysicalGpu, pInfo: ptr GrGpuCompatibilityInfo): GR_RESULT
proc grOpenSharedMemory*(device: GrDevice, pOpenInfo: ptr GrMemoryOpenInfo, pMem: ptr GrGpuMemory): GR_RESULT
proc grOpenSharedQueueSemaphore*(device: GrDevice, pOpenInfo: ptr GrQueueSemaphoreOpenInfo, pSemaphore: ptr GrQueueSemaphore): GR_RESULT
proc grOpenPeerMemory*(device: GrDevice, pOpenInfo: ptr GrPeerMemoryOpenInfo, pMem: ptr GrGpuMemory): GR_RESULT
proc grOpenPeerImage*(device: GrDevice, pOpenInfo: ptr GrPeerImageOpenInfo, pMem: ptr GrGpuMemory): GR_RESULT

# Command Buffer Management Functions
proc grCreateCommandBuffer*(device: GrDevice, pCreateInfo: ptr GrCmdBufferCreateInfo, pCmdBuffer: ptr GrCmdBuffer): GR_RESULT
proc grBeginCommandBuffer*(cmdBuffer: GrCmdBuffer, flags: GrFlags): GR_RESULT
proc grEndCommandBuffer*(cmdBuffer: GrCmdBuffer): GR_RESULT
proc grResetCommandBuffer*(cmdBuffer: GrCmdBuffer): GR_RESULT

# Command Buffer Building Functions
proc grCmdBindPipeline*(cmdBuffer: GrCmdBuffer, pipelineBindPoint: GrPipelineBindPoint, pipeline: GrPipeline)
proc grCmdBindStateObject*(cmdBuffer: GrCmdBuffer, stateBindPoint: GrStateBindPoint, state: GrStateObject)
proc grCmdBindDescriptorSet*(cmdBuffer: GrCmdBuffer, pipelineBindPoint: GrPipelineBindPoint, index: GrUint, descriptorSet: GrDescriptorSet, slotOffset: GrUint)
proc grCmdBindDynamicMemoryView*(cmdBuffer: GrCmdBuffer, pipelineBindPoint: GrPipelineBindPoint, pMemView: ptr GrMemoryViewAttachInfo)
proc grCmdBindIndexData*(cmdBuffer: GrCmdBuffer, mem: GrGpuMemory, offset: GrGpuSize, indexType: GrIndexType)
proc grCmdBindTargets*(cmdBuffer: GrCmdBuffer, colorTargetCount: GrUint, pColorTargets: ptr GrColorTargetBindInfo, pDepthTarget: ptr GrDepthStencilBindInfo)
proc grCmdPrepareMemoryRegions*(cmdBuffer: GrCmdBuffer, transitionCount: GrUint, pStateTransitions: ptr GrMemoryStateTransition)
proc grCmdPrepareImages*(cmdBuffer: GrCmdBuffer, transitionCount: GrUint, pStateTransitions: ptr GrImageStateTransition)
proc grCmdDraw*(cmdBuffer: GrCmdBuffer, firstVertex: GrUint, vertexCount: GrUint, firstInstance: GrUint, instanceCount: GrUint)
proc grCmdDrawIndexed*(cmdBuffer: GrCmdBuffer, firstIndex: GrUint, indexCount: GrUint, vertexOffset: GrInt, firstInstance: GrUint, instanceCount: GrUint)
proc grCmdDrawIndirect*(cmdBuffer: GrCmdBuffer, mem: GrGpuMemory, offset: GrGpuSize)
proc grCmdDrawIndexedIndirect*(cmdBuffer: GrCmdBuffer, mem: GrGpuMemory, offset: GrGpuSize)
proc grCmdDispatch*(cmdBuffer, GrCmdBuffer, x: GrUint, y: GrUint, z: GrUint)
proc grCmdDispatchIndirect*(cmdBuffer: GrCmdBuffer, mem: GrGpuMemory, offset: GrGpuSize)
proc grCmdCopyMemory*(cmdBuffer: GrCmdBuffer, srcMem: GrGpuMemory, destMem: GrGpuMemory, regionCount: GrUint, pRegions: ptr GrMemoryCopy)
proc grCmdCopyImage*(cmdBuffer: GrCmdBuffer, srcImage: GrImage, destImage: GrImage, regionCount: GrUint, pRegions: ptr GrImageCopy)
proc grCmdCopyMemoryToImage*(cmdBuffer: GrCmdBuffer, srcMem: GrGpuMemory, destImage: GrImage, regionCount: GrUint, pRegions: ptr GrMemoryImageCopy)
proc grCmdCopyImageToMemory*(cmdBuffer: GrCmdBuffer, srcImage: GrImage, destMem: GrGpuMemory, regionCount: GrUint, pRegions: ptr GrMemoryImageCopy)
proc grCmdResolveImage*(cmdBuffer: GrCmdBuffer, srcImage: GrImage, destImage: GrImage, regionCount: GrUint, pRegions: ptr GrImageResolve)
proc grCmdCloneImageData*(cmdBuffer: GrCmdBuffer, srcImage: GrImage, srcImageState: GrImageState, destImage: GrImage, destImageState: GrImageState)
proc grCmdUpdateMemory*(cmdBuffer: GrCmdBuffer, destMem: GrGpuMemory, destOffset: GrGpuSize, dataSize: GrGpuSize, pData: pointer)
proc grCmdFillMemory*(cmdBuffer: GrCmdBuffer, destMem: GrGpuMemory, destOffset: GrGpuSize, fillSize: GrGpuSize, data: GrUint32)
proc grCmdClearColorImage*(cmdBuffer: GrCmdBuffer, image: GrImage, color: array[4, GrFloat], rangeCount: GrUint, pRanges: ptr GrImageSubresourceRange)
proc grCmdClearColorImageRaw*(cmdBuffer: GrCmdBuffer, image: GrImage, color: array[4, GrUint32], rangeCount: GrUint, pRanges: ptr GrImageSubresourceRange)
proc grCmdClearDepthStencil*(cmdBuffer: GrCmdBuffer, image: GrImage, depth: GrFloat, stencil: GrUint8, rangeCount: GrUint, pRanges: ptr GrImageSubresourceRange)
proc grCmdSetEvent*(cmdBuffer: GrCmdBuffer, event: GrEvent)
proc grCmdResetEvent*(cmdBuffer: GrCmdBuffer, event: GrEvent)
proc grCmdMemoryAtomic*(cmdBuffer: GrCmdBuffer, destMem: GrGpuMemory, destOffset: GrGpuSize, srcData: GrUint64, atomicOp: GrAtomicOp)
proc grCmdBeginQuery*(cmdBuffer: GrCmdBuffer, queryPool: GrQueryPool, slot: GrUint, flags: GrFlags)
proc grCmdEndQuery*(cmdBuffer: GrCmdBuffer, queryPool: GrQueryPool, slot: GrUint)
proc grCmdResetQueryPool*(cmdBuffer: GrCmdBuffer, queryPool: GrQueryPool, startQuery: GrUint, queryCount: GrUint)
proc grCmdWriteTimestamp*(cmdBuffer: GrCmdBuffer, timestampType: GrTimestampType, destMem: GrGpuMemory, destOffset: GrGpuSize)
proc grCmdInitAtomicCounters*(cmdBuffer: GrCmdBuffer, pipelineBindPoint: GrPipelineBindPoint, startCounter: GrUint, counterCount: GrUint, pData: ptr GrUint32)
proc grCmdLoadAtomicCounters*(cmdBuffer: GrCmdBuffer, pipelineBindPoint: GrPipelineBindPoint, startCounter: GrUint, counterCount: GrUint, srcMem: GrGpuMemory, srcOffset: GrGpuSize)
proc grCmdSaveAtomicCounters*(cmdBuffer, GrCmdBuffer, pipelineBindPoint: GrPipelineBindPoint, startCounter: GrUint, counterCount: GrUint, destMem: GrGpuMemory, destOffset: GrGpuSize)

# Debug and Validation
proc grDbgSetValidationLevel*(device: GrDevice, validationLevel: GrValidationLevel): GR_RESULT
proc grDbgRegisterMsgCallback*(pfnMsgCallback: GrDbgMsgCallbackFunction, pUserData: pointer): GR_RESULT
proc grDbgUnregisterMsgCallback*(pfnMsgCallback: GrDbgMsgCallbackFunction): GR_RESULT
proc grDbgSetMessageFilter*(device: GrDevice, msgCode: GrDbgMsgCode, filter: GrDbgMsgFilter): GR_RESULT
proc grDbgSetObjectTag*(obj: GrBaseObject, tagSize: GrSize, pTag: pointer): GR_RESULT
proc grDbgSetGlobalOption*(dbgOption: GrDbgGlobalOption, dataSize: GrSize, pData: pointer): GR_RESULT
proc grDbgSetDeviceOption*(device: GrDevice, dbgOption: GrDbgDeviceOption, dataSize: GrSize, pData: pointer): GR_RESULT
proc grCmdDbgMarkerBegin*(cmdBuffer: GrCmdBuffer, pMarker: ptr GrChar)
proc grCmdDbgMarkerEnd*(cmdBuffer: GrCmdBuffer)


# Wsi
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


# Extension
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
proc grCmdCopyOcclusionData*(cmdBuffer: GrCmdBuffer, queryPool: GrQueryPool, startQuery: GrUint, queryCount: GrUint, destMem: GrGpuMemory, destOffset: GrGpuSize, accumulateData: GrBool) # todo: why does a grCmd* function return sth? typo in the documentation?

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
{.pop.} # callConv, importc, dynlib
