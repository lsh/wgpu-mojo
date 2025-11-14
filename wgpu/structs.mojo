from collections import Optional
from utils import Variant
from memory import Span, ArcPointer
from collections.string import StringSlice

from .bitflags import *
from .constants import *
from .enums import *
from .objects import *


import . _cffi as _c

alias Limits = _c.WGPULimits
alias BlendComponent = _c.WGPUBlendComponent
alias Extent3D = _c.WGPUExtent3D
alias Origin3D = _c.WGPUOrigin3D
alias VertexAttribute = _c.WGPUVertexAttribute
alias Color = _c.WGPUColor
alias BlendState = _c.WGPUBlendState
alias StencilFaceState = _c.WGPUStencilFaceState


struct RequestAdapterOptions[surface: ImmutOrigin](Copyable, Movable):
    var power_preference: PowerPreference
    var force_fallback_adapter: Bool
    var compatible_surface: Optional[Pointer[Surface, surface]]

    fn __init__(
        out self,
        power_preference: PowerPreference = PowerPreference.undefined,
        force_fallback_adapter: Bool = False,
        compatible_surface: Optional[Pointer[Surface, surface]] = None,
    ):
        self.power_preference = power_preference
        self.force_fallback_adapter = force_fallback_adapter
        self.compatible_surface = compatible_surface


struct AdapterInfo[origin: ImmutOrigin](Copyable, Movable):
    var vendor: StringSlice[origin]
    var architecture: StringSlice[origin]
    var device: StringSlice[origin]
    var description: StringSlice[origin]
    var backend_type: BackendType
    var adapter_type: AdapterType
    var vendor_ID: UInt32
    var device_ID: UInt32


struct DeviceDescriptor(Copyable, Movable):
    var label: String
    var required_features: Optional[List[FeatureName]]
    var limits: Limits
    # var device_lost_callback: UnsafePointer[NoneType]
    # var device_lost_userdata: UnsafePointer[NoneType]
    # var uncaptured_error_callback_info: UnsafePointer[NoneType]

    fn __init__(
        out self,
        label: String = "",
        required_features: Optional[List[FeatureName]] = None,
        limits: Limits = Limits(),
    ):
        self.label = label
        self.required_features = required_features
        self.limits = limits


@fieldwise_init
struct BindingResource[T: Copyable & Movable, origin: ImmutOrigin](
    Copyable, Movable
):
    var _value: Variant[BufferBinding[T, origin], BufferArray[T, origin]]

    @implicit
    fn __init__(out self, var value: BufferBinding[T, origin]):
        self._value = value^

    @implicit
    fn __init__(out self, var value: BufferArray[T, origin]):
        self._value = value^

    fn is_buffer(self) -> Bool:
        return self._value.isa[BufferBinding[T, origin]]()

    fn is_buffer_array(self) -> Bool:
        return self._value.isa[BufferArray[T, origin]]()

    fn buffer(self) -> ref [self._value] BufferBinding[T, origin]:
        return self._value[BufferBinding[T, origin]]

    fn buffer_array(self) -> ref [self._value] BufferArray[T, origin]:
        return self._value[BufferArray[T, origin]]


@fieldwise_init
struct BufferBinding[T: Copyable & Movable, origin: ImmutOrigin](
    Copyable, Movable
):
    var buffer: Pointer[Buffer[T], origin]
    var offset: UInt64
    var size: UInt64

    fn __init__(
        out self, ref [origin]buffer: Buffer[T], offset: UInt64, size: UInt64
    ):
        self.buffer = Pointer(to=buffer)
        self.offset = offset
        self.size = size


@fieldwise_init
struct BufferArray[T: Copyable & Movable, origin: ImmutOrigin](
    Copyable, Movable
):
    var value: List[BufferBinding[T, origin]]


@fieldwise_init
struct BindGroupEntry[T: Copyable & Movable, origin: ImmutOrigin](
    Copyable, Movable
):
    var binding: UInt32
    var resource: BindingResource[T, origin]


struct BindGroupDescriptor[
    T: Copyable & Movable, origin: ImmutOrigin, bind_group_origin: ImmutOrigin
](Copyable, Movable):
    var label: String
    var layout: ArcPointer[BindGroupLayout]
    var entries: Span[BindGroupEntry[T, bind_group_origin], origin]

    fn __init__(
        out self,
        label: String,
        layout: ArcPointer[BindGroupLayout],
        entries: Span[BindGroupEntry[T, bind_group_origin], origin],
    ):
        self.label = label
        self.layout = layout
        self.entries = entries


@fieldwise_init
struct BindingType(Copyable, Movable):
    var _value: Variant[
        BufferBindingLayout,
        SamplerBindingLayout,
        TextureBindingLayout,
        StorageTextureBindingLayout,
    ]

    @implicit
    fn __init__(out self, var value: BufferBindingLayout):
        self._value = value^

    @implicit
    fn __init__(out self, var value: SamplerBindingLayout):
        self._value = value^

    @implicit
    fn __init__(out self, var value: TextureBindingLayout):
        self._value = value^

    @implicit
    fn __init__(out self, var value: StorageTextureBindingLayout):
        self._value = value^

    fn is_buffer(self) -> Bool:
        return self._value.isa[BufferBindingLayout]()

    fn is_sampler(self) -> Bool:
        return self._value.isa[SamplerBindingLayout]()

    fn is_texture(self) -> Bool:
        return self._value.isa[TextureBindingLayout]()

    fn is_storage_texture(self) -> Bool:
        return self._value.isa[StorageTextureBindingLayout]()

    fn buffer(ref self) -> ref [self._value] BufferBindingLayout:
        return self._value[BufferBindingLayout]

    fn sampler(ref self) -> ref [self._value] SamplerBindingLayout:
        return self._value[SamplerBindingLayout]

    fn texture(ref self) -> ref [self._value] TextureBindingLayout:
        return self._value[TextureBindingLayout]

    fn storage_texture(
        ref self,
    ) -> ref [self._value] StorageTextureBindingLayout:
        return self._value[StorageTextureBindingLayout]


@fieldwise_init
struct BufferBindingLayout(Copyable, Movable):
    var type: BufferBindingType
    var has_dynamic_offset: Bool
    var min_binding_size: UInt64


@fieldwise_init
struct SamplerBindingLayout(Copyable, Movable):
    var type: SamplerBindingType


@fieldwise_init
struct TextureBindingLayout(Copyable, Movable):
    var sample_type: TextureSampleType
    var view_dimension: TextureViewDimension
    var multisampled: Bool


struct SurfaceCapabilities(Copyable, Movable):
    var _handle: _c.WGPUSurfaceCapabilities

    fn __init__(out self, unsafe_ptr: _c.WGPUSurfaceCapabilities):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = {}

    fn __del__(deinit self):
        _c.surface_capabilities_free_members(UnsafePointer(to=self._handle))

    fn usages(self) -> TextureUsage:
        return self._handle.usages

    fn formats(self) -> Span[TextureFormat, ImmutOrigin.external]:
        return Span[TextureFormat, ImmutOrigin.external](
            ptr=self._handle.formats.unsafe_ptr(),
            length=self._handle.format_count,
        )

    fn present_modes(self) -> Span[PresentMode, ImmutOrigin.external]:
        return Span[PresentMode, ImmutOrigin.external](
            ptr=self._handle.present_modes.unsafe_ptr(),
            length=self._handle.present_mode_count,
        )

    fn alpha_modes(self) -> Span[CompositeAlphaMode, ImmutOrigin.external]:
        return Span[CompositeAlphaMode, ImmutOrigin.external](
            ptr=self._handle.alpha_modes.unsafe_ptr(),
            length=self._handle.alpha_mode_count,
        )


struct SurfaceConfiguration(Copyable, Movable):
    var format: TextureFormat
    var usage: TextureUsage
    var view_formats: List[TextureFormat]
    var alpha_mode: CompositeAlphaMode
    var width: UInt32
    var height: UInt32
    var present_mode: PresentMode

    fn __init__(
        out self,
        format: TextureFormat,
        usage: TextureUsage,
        var view_formats: List[TextureFormat],
        alpha_mode: CompositeAlphaMode,
        width: UInt32,
        height: UInt32,
        present_mode: PresentMode,
    ):
        self.format = format
        self.usage = usage
        self.view_formats = view_formats^
        self.alpha_mode = alpha_mode
        self.width = width
        self.height = height
        self.present_mode = present_mode


@fieldwise_init
struct StorageTextureBindingLayout(Copyable, Movable):
    var access: StorageTextureAccess
    var format: TextureFormat
    var view_dimension: TextureViewDimension


@fieldwise_init
struct BindGroupLayoutEntry(Copyable, Movable):
    var binding: UInt32
    var visibility: ShaderStage
    var type: BindingType
    var count: UInt32


@fieldwise_init
struct BindGroupLayoutDescriptor[mut: Bool, //, origin: Origin[mut]](
    Copyable, Movable
):
    var label: String
    var entries: Span[BindGroupLayoutEntry, origin]


@fieldwise_init
struct BufferDescriptor(Copyable, Movable):
    var label: String
    var usage: BufferUsage
    var size: UInt64
    var mapped_at_creation: Bool


@fieldwise_init
struct ConstantEntry(Copyable, Movable):
    var key: String
    var value: Float64


@fieldwise_init
struct CommandBufferDescriptor(Copyable, Movable):
    var label: String


struct CommandEncoderDescriptor(Copyable, Movable):
    var label: String

    fn __init__(out self, var label: String = ""):
        self.label = label


@fieldwise_init
struct WGPUCompilationInfo(Copyable, Movable):
    var messages: List[CompilationMessage]


@fieldwise_init
struct CompilationMessage(Copyable, Movable):
    var message: String
    var type: CompilationMessageType
    var line_num: UInt64
    var line_pos: UInt64
    var offset: UInt64
    var length: UInt64
    var utf16_line_pos: UInt64
    var utf16_offset: UInt64
    var utf16_length: UInt64


@fieldwise_init
struct ComputePassDescriptor(Copyable, Movable):
    var label: String
    var timestamp_writes: Optional[ComputePassTimestampWrites]


@fieldwise_init
struct ComputePassTimestampWrites(Copyable, Movable):
    var query_set: ArcPointer[QuerySet]
    var beginning_of_pass_write_index: UInt32
    var end_of_pass_write_index: UInt32


@fieldwise_init
struct ComputePipelineDescriptor(Copyable, Movable):
    var label: String
    var layout: ArcPointer[PipelineLayout]
    var compute: ProgrammableStageDescriptor


@fieldwise_init
struct ImageCopyBuffer[T: Copyable & Movable, buf: ImmutOrigin](
    Copyable, Movable
):
    var layout: TextureDataLayout
    var buffer: Pointer[Buffer[T], buf]

    fn __init__(
        out self,
        ref [buf]buffer: Buffer[T],
        var layout: TextureDataLayout = TextureDataLayout(),
    ):
        self.buffer = Pointer(to=buffer)
        self.layout = layout^


@fieldwise_init
struct ImageCopyTexture[tex: ImmutOrigin](Copyable, Movable):
    var texture: Pointer[Texture, tex]
    var mip_level: UInt32
    var origin: Origin3D
    var aspect: TextureAspect

    fn __init__(
        out self,
        ref [tex]texture: Texture,
        mip_level: UInt32 = 0,
        origin: Origin3D = Origin3D(),
        aspect: TextureAspect = TextureAspect.all,
    ):
        self.texture = Pointer(to=texture)
        self.mip_level = mip_level
        self.origin = origin
        self.aspect = aspect


@fieldwise_init
struct VertexBufferLayout[mut: Bool, //, origin: Origin[mut]](
    Copyable, Movable
):
    var array_stride: UInt64
    var step_mode: VertexStepMode
    var attributes: Span[VertexAttribute, origin]


@fieldwise_init
struct PipelineLayoutDescriptor[
    mut: Bool, //,
    origin: Origin[mut],
](Copyable, Movable):
    var label: String
    var bind_group_layouts: Span[ArcPointer[BindGroupLayout], origin]


@fieldwise_init
struct ProgrammableStageDescriptor(Copyable, Movable):
    var module: ArcPointer[ShaderModule]
    var entry_point: String
    var constants: List[ConstantEntry]


@fieldwise_init
struct QuerySetDescriptor(Copyable, Movable):
    var label: String
    var type: QueryType
    var count: UInt32


@fieldwise_init
struct RenderBundleDescriptor(Copyable, Movable):
    var label: String


@fieldwise_init
struct RenderBundleEncoderDescriptor(Copyable, Movable):
    var label: String
    var color_formats: List[TextureFormat]
    var depth_stencil_format: TextureFormat
    var sample_count: UInt32
    var depth_read_only: Bool
    var stencil_read_only: Bool


@fieldwise_init
struct RenderPassColorAttachment[tex: ImmutOrigin](Movable):
    var view: Pointer[TextureView, tex]
    var depth_slice: UInt32
    var resolve_target: Optional[ArcPointer[TextureView]]
    var load_op: LoadOp
    var store_op: StoreOp
    var clear_value: Color

    fn __init__(
        out self,
        ref [tex]view: TextureView,
        load_op: LoadOp,
        store_op: StoreOp,
        *,
        resolve_target: Optional[ArcPointer[TextureView]] = None,
        clear_value: Color = Color(),
        depth_slice: UInt32 = DEPTH_SLICE_UNDEFINED,
    ):
        self.view = Pointer(to=view)
        self.load_op = load_op
        self.store_op = store_op
        self.resolve_target = resolve_target
        self.clear_value = clear_value
        self.depth_slice = depth_slice


@fieldwise_init
struct RenderPassDepthStencilAttachment(Copyable, Movable):
    var view: ArcPointer[TextureView]
    var depth_load_op: LoadOp
    var depth_store_op: StoreOp
    var depth_clear_value: Float32
    var depth_read_only: Bool
    var stencil_load_op: LoadOp
    var stencil_store_op: StoreOp
    var stencil_clear_value: UInt32
    var stencil_read_only: Bool


struct RenderPassDescriptor[tex: ImmutOrigin](Copyable, Movable):
    var label: String
    var color_attachments: List[ArcPointer[RenderPassColorAttachment[tex]]]
    var depth_stencil_attachment: Optional[RenderPassDepthStencilAttachment]
    var occlusion_query_set: Optional[ArcPointer[QuerySet]]
    var timestamp_writes: Optional[RenderPassTimestampWrites]

    fn __init__(
        out self,
        label: String = "",
        var color_attachments: List[
            ArcPointer[RenderPassColorAttachment[tex]]
        ] = [],
        var depth_stencil_attachment: Optional[
            RenderPassDepthStencilAttachment
        ] = None,
        var occlusion_query_set: Optional[ArcPointer[QuerySet]] = None,
        var timestamp_writes: Optional[RenderPassTimestampWrites] = None,
    ):
        self.label = label
        self.color_attachments = color_attachments^
        self.depth_stencil_attachment = depth_stencil_attachment^
        self.occlusion_query_set = occlusion_query_set^
        self.timestamp_writes = timestamp_writes^


@fieldwise_init
struct RenderPassDescriptorMaxDrawCount(Copyable, Movable):
    var max_draw_count: UInt64


@fieldwise_init
struct RenderPassTimestampWrites(Copyable, Movable):
    var query_set: ArcPointer[QuerySet]
    var beginning_of_pass_write_index: UInt32
    var end_of_pass_write_index: UInt32


struct VertexState[
    entry_mut: Bool,
    buf_mut: Bool,
    vbuf_mut: Bool, //,
    mod: ImmutOrigin,
    entry: Origin[entry_mut],
    buf: Origin[buf_mut],
    vbuf: Origin[vbuf_mut],
](Copyable, Movable):
    var module: Pointer[ShaderModule, mod]
    var entry_point: StringSlice[entry]
    # var constants: Span[ConstantEntry, lifetime]
    var buffers: Span[VertexBufferLayout[vbuf], buf]

    fn __init__(
        out self,
        ref [mod]module: ShaderModule,
        entry_point: StringSlice[entry],
        buffers: Span[VertexBufferLayout[vbuf], buf],
    ):
        self.module = Pointer(to=module)
        self.entry_point = entry_point
        self.buffers = buffers


struct PrimitiveState(Copyable, Movable):
    var topology: PrimitiveTopology
    var strip_index_format: IndexFormat
    var front_face: FrontFace
    var cull_mode: CullMode

    fn __init__(
        out self,
        *,
        topology: PrimitiveTopology = PrimitiveTopology(0),
        strip_index_format: IndexFormat = IndexFormat(0),
        front_face: FrontFace = FrontFace(0),
        cull_mode: CullMode = CullMode(0),
    ):
        self.topology = topology
        self.strip_index_format = strip_index_format
        self.front_face = front_face
        self.cull_mode = cull_mode


@fieldwise_init
struct PrimitiveDepthClipControl(Copyable, Movable):
    var unclipped_depth: Bool


@fieldwise_init
struct DepthStencilState(Copyable, Movable):
    var format: TextureFormat
    var depth_write_enabled: Bool
    var depth_compare: CompareFunction
    var stencil_front: StencilFaceState
    var stencil_back: StencilFaceState
    var stencil_read_mask: UInt32
    var stencil_write_mask: UInt32
    var depth_bias: Int32
    var depth_bias_slope_scale: Float32
    var depth_bias_clamp: Float32


struct MultisampleState(Copyable, Movable):
    var count: UInt32
    var mask: UInt32
    var alpha_to_coverage_enabled: Bool

    fn __init__(
        out self,
        *,
        count: UInt32 = 1,
        mask: UInt32 = ~0,
        alpha_to_coverage_enabled: Bool = False,
    ):
        self.count = count
        self.mask = mask
        self.alpha_to_coverage_enabled = alpha_to_coverage_enabled


@fieldwise_init
struct FragmentState[
    entry_mut: Bool, //,
    mod: ImmutOrigin,
    entry: Origin[entry_mut],
    tgt: MutOrigin,
](Copyable, Movable):
    var module: Pointer[ShaderModule, mod]
    var entry_point: StringSlice[entry]
    # var constants: Span[ConstantEntry, lifetime]
    var targets: Span[ColorTargetState, tgt]

    fn __init__(
        out self,
        *,
        ref [mod]module: ShaderModule,
        entry_point: StringSlice[entry],
        # constants: Span[ConstantEntry],
        targets: Span[ColorTargetState, tgt],
    ):
        self.module = Pointer(to=module)
        self.entry_point = entry_point
        # self.constants = constants
        self.targets = targets


@fieldwise_init
struct ColorTargetState(Copyable, Movable):
    var format: TextureFormat
    var blend: Optional[BlendState]
    var write_mask: ColorWriteMask


@fieldwise_init
struct RenderPipelineDescriptor[
    lyt_mut: Bool,
    ventry_mut: Bool,
    buf_mut: Bool,
    vbuf_mut: Bool,
    fentry_mut: Bool, //,
    lyt: Origin[lyt_mut],
    vmod: ImmutOrigin,
    ventry: Origin[ventry_mut],
    buf: Origin[buf_mut],
    vbuf: Origin[vbuf_mut],
    fmod: ImmutOrigin,
    fentry: Origin[fentry_mut],
    tgt: MutOrigin,
](Copyable, Movable):
    var label: String
    var layout: Optional[Pointer[PipelineLayout, lyt]]
    var vertex: VertexState[vmod, ventry, buf, vbuf]
    var primitive: PrimitiveState
    var depth_stencil: Optional[DepthStencilState]
    var multisample: MultisampleState
    var fragment: Optional[FragmentState[fmod, fentry, tgt]]


@fieldwise_init
struct SamplerDescriptor(Copyable, Movable):
    var label: String
    var address_mode_u: AddressMode
    var address_mode_v: AddressMode
    var address_mode_w: AddressMode
    var mag_filter: FilterMode
    var min_filter: FilterMode
    var mipmap_filter: MipmapFilterMode
    var lod_min_clamp: Float32
    var lod_max_clamp: Float32
    var compare: CompareFunction
    var max_anisotropy: UInt16


@fieldwise_init
struct ShaderModuleDescriptor(Copyable, Movable):
    var label: String
    var hints: List[ShaderModuleCompilationHint]


@fieldwise_init
struct ShaderModuleCompilationHint(Copyable, Movable):
    var entry_point: String
    var layout: ArcPointer[PipelineLayout]


@fieldwise_init
struct SurfaceDescriptor(Copyable, Movable):
    var label: String


struct SurfaceTexture(Movable):
    var texture: Texture
    var suboptimal: Bool
    var status: SurfaceGetCurrentTextureStatus

    fn __init__(
        out self,
        var texture: Texture,
        suboptimal: Bool = False,
        status: SurfaceGetCurrentTextureStatus = SurfaceGetCurrentTextureStatus(
            0
        ),
    ):
        self.texture = texture^
        self.suboptimal = suboptimal
        self.status = status

    fn __enter__(var self) -> Self:
        return self^


struct TextureDataLayout(Copyable, Movable):
    var offset: UInt64
    var bytes_per_row: Optional[UInt32]
    var rows_per_image: Optional[UInt32]

    fn __init__(
        out self,
        offset: UInt64 = 0,
        bytes_per_row: Optional[UInt32] = None,
        rows_per_image: Optional[UInt32] = None,
    ):
        self.offset = offset
        self.bytes_per_row = bytes_per_row
        self.rows_per_image = rows_per_image


struct TextureDescriptor(Copyable, Movable):
    var label: String
    var usage: TextureUsage
    var dimension: TextureDimension
    var size: Extent3D
    var format: TextureFormat
    var mip_level_count: UInt32
    var sample_count: UInt32
    var view_formats: List[TextureFormat]


struct TextureViewDescriptor(Copyable, Movable):
    var label: String
    var format: TextureFormat
    var dimension: TextureViewDimension
    var base_mip_level: UInt32
    var mip_level_count: UInt32
    var base_array_layer: UInt32
    var array_layer_count: UInt32
    var aspect: TextureAspect

    fn __init__(
        out self,
        format: TextureFormat,
        dimension: TextureViewDimension,
        var label: String = "",
        base_mip_level: UInt32 = 0,
        mip_level_count: UInt32 = MIP_LEVEL_COUNT_UNDEFINED,
        base_array_layer: UInt32 = 0,
        array_layer_count: UInt32 = ARRAY_LAYER_COUNT_UNDEFINED,
        aspect: TextureAspect = TextureAspect.all,
    ):
        self.label = label
        self.format = format
        self.dimension = dimension
        self.base_mip_level = base_mip_level
        self.mip_level_count = mip_level_count
        self.base_array_layer = base_array_layer
        self.array_layer_count = array_layer_count
        self.aspect = aspect


@fieldwise_init
struct UncapturedErrorCallbackInfo(Copyable, Movable):
    var callback: OpaquePointer[MutOrigin.external]
    var userdata: OpaquePointer[MutOrigin.external]
