@fieldwise_init
@register_passable("trivial")
struct RequestAdapterStatus(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime success = Self(0)
    comptime unavailable = Self(1)
    comptime error = Self(2)
    comptime unknown = Self(3)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.success:
            w.write("success")

        elif self == Self.unavailable:
            w.write("unavailable")

        elif self == Self.error:
            w.write("error")

        elif self == Self.unknown:
            w.write("unknown")


@fieldwise_init
@register_passable("trivial")
struct AdapterType(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime discrete_gpu = Self(0)
    comptime integrated_gpu = Self(1)
    comptime cpu = Self(2)
    comptime unknown = Self(3)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.discrete_gpu:
            w.write("discrete_gpu")

        elif self == Self.integrated_gpu:
            w.write("integrated_gpu")

        elif self == Self.cpu:
            w.write("cpu")

        elif self == Self.unknown:
            w.write("unknown")


@fieldwise_init
@register_passable("trivial")
struct AddressMode(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime repeat = Self(0)
    comptime mirror_repeat = Self(1)
    comptime clamp_to_edge = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.repeat:
            w.write("repeat")

        elif self == Self.mirror_repeat:
            w.write("mirror_repeat")

        elif self == Self.clamp_to_edge:
            w.write("clamp_to_edge")


@fieldwise_init
@register_passable("trivial")
struct BackendType(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime null = Self(1)
    comptime webgpu = Self(2)
    comptime d3d11 = Self(3)
    comptime d3d12 = Self(4)
    comptime metal = Self(5)
    comptime vulkan = Self(6)
    comptime opengl = Self(7)
    comptime opengles = Self(8)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.null:
            w.write("null")

        elif self == Self.webgpu:
            w.write("webgpu")

        elif self == Self.d3d11:
            w.write("d3d11")

        elif self == Self.d3d12:
            w.write("d3d12")

        elif self == Self.metal:
            w.write("metal")

        elif self == Self.vulkan:
            w.write("vulkan")

        elif self == Self.opengl:
            w.write("opengl")

        elif self == Self.opengles:
            w.write("opengles")


@fieldwise_init
@register_passable("trivial")
struct BufferBindingType(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime uniform = Self(1)
    comptime storage = Self(2)
    comptime read_only_storage = Self(3)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.uniform:
            w.write("uniform")

        elif self == Self.storage:
            w.write("storage")

        elif self == Self.read_only_storage:
            w.write("read_only_storage")


@fieldwise_init
@register_passable("trivial")
struct SamplerBindingType(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime filtering = Self(1)
    comptime non_filtering = Self(2)
    comptime comparison = Self(3)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.filtering:
            w.write("filtering")

        elif self == Self.non_filtering:
            w.write("non_filtering")

        elif self == Self.comparison:
            w.write("comparison")


@fieldwise_init
@register_passable("trivial")
struct TextureSampleType(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime float = Self(1)
    comptime unfilterable_float = Self(2)
    comptime depth = Self(3)
    comptime sint = Self(4)
    comptime uint = Self(5)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.float:
            w.write("float")

        elif self == Self.unfilterable_float:
            w.write("unfilterable_float")

        elif self == Self.depth:
            w.write("depth")

        elif self == Self.sint:
            w.write("sint")

        elif self == Self.uint:
            w.write("uint")


@fieldwise_init
@register_passable("trivial")
struct StorageTextureAccess(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime write_only = Self(1)
    comptime read_only = Self(2)
    comptime read_write = Self(3)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.write_only:
            w.write("write_only")

        elif self == Self.read_only:
            w.write("read_only")

        elif self == Self.read_write:
            w.write("read_write")


@fieldwise_init
@register_passable("trivial")
struct BlendFactor(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime zero = Self(0)
    comptime one = Self(1)
    comptime src = Self(2)
    comptime one_minus_src = Self(3)
    comptime src_alpha = Self(4)
    comptime one_minus_src_alpha = Self(5)
    comptime dst = Self(6)
    comptime one_minus_dst = Self(7)
    comptime dst_alpha = Self(8)
    comptime one_minus_dst_alpha = Self(9)
    comptime src_alpha_saturated = Self(10)
    comptime constant = Self(11)
    comptime one_minus_constant = Self(12)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.zero:
            w.write("zero")

        elif self == Self.one:
            w.write("one")

        elif self == Self.src:
            w.write("src")

        elif self == Self.one_minus_src:
            w.write("one_minus_src")

        elif self == Self.src_alpha:
            w.write("src_alpha")

        elif self == Self.one_minus_src_alpha:
            w.write("one_minus_src_alpha")

        elif self == Self.dst:
            w.write("dst")

        elif self == Self.one_minus_dst:
            w.write("one_minus_dst")

        elif self == Self.dst_alpha:
            w.write("dst_alpha")

        elif self == Self.one_minus_dst_alpha:
            w.write("one_minus_dst_alpha")

        elif self == Self.src_alpha_saturated:
            w.write("src_alpha_saturated")

        elif self == Self.constant:
            w.write("constant")

        elif self == Self.one_minus_constant:
            w.write("one_minus_constant")


@fieldwise_init
@register_passable("trivial")
struct BlendOperation(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime add = Self(0)
    comptime subtract = Self(1)
    comptime reverse_subtract = Self(2)
    comptime min = Self(3)
    comptime max = Self(4)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.add:
            w.write("add")

        elif self == Self.subtract:
            w.write("subtract")

        elif self == Self.reverse_subtract:
            w.write("reverse_subtract")

        elif self == Self.min:
            w.write("min")

        elif self == Self.max:
            w.write("max")


@fieldwise_init
@register_passable("trivial")
struct BufferMapAsyncStatus(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime success = Self(0)
    comptime validation_error = Self(1)
    comptime unknown = Self(2)
    comptime device_lost = Self(3)
    comptime destroyed_before_callback = Self(4)
    comptime unmapped_before_callback = Self(5)
    comptime mapping_already_pending = Self(6)
    comptime offset_out_of_range = Self(7)
    comptime size_out_of_range = Self(8)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.success:
            w.write("success")

        elif self == Self.validation_error:
            w.write("validation_error")

        elif self == Self.unknown:
            w.write("unknown")

        elif self == Self.device_lost:
            w.write("device_lost")

        elif self == Self.destroyed_before_callback:
            w.write("destroyed_before_callback")

        elif self == Self.unmapped_before_callback:
            w.write("unmapped_before_callback")

        elif self == Self.mapping_already_pending:
            w.write("mapping_already_pending")

        elif self == Self.offset_out_of_range:
            w.write("offset_out_of_range")

        elif self == Self.size_out_of_range:
            w.write("size_out_of_range")


@fieldwise_init
@register_passable("trivial")
struct BufferMapState(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime unmapped = Self(0)
    comptime pending = Self(1)
    comptime mapped = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.unmapped:
            w.write("unmapped")

        elif self == Self.pending:
            w.write("pending")

        elif self == Self.mapped:
            w.write("mapped")


@fieldwise_init
@register_passable("trivial")
struct CompareFunction(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime never = Self(1)
    comptime less = Self(2)
    comptime less_equal = Self(3)
    comptime greater = Self(4)
    comptime greater_equal = Self(5)
    comptime equal = Self(6)
    comptime not_equal = Self(7)
    comptime always = Self(8)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.never:
            w.write("never")

        elif self == Self.less:
            w.write("less")

        elif self == Self.less_equal:
            w.write("less_equal")

        elif self == Self.greater:
            w.write("greater")

        elif self == Self.greater_equal:
            w.write("greater_equal")

        elif self == Self.equal:
            w.write("equal")

        elif self == Self.not_equal:
            w.write("not_equal")

        elif self == Self.always:
            w.write("always")


@fieldwise_init
@register_passable("trivial")
struct CompilationInfoRequestStatus(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime success = Self(0)
    comptime error = Self(1)
    comptime device_lost = Self(2)
    comptime unknown = Self(3)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.success:
            w.write("success")

        elif self == Self.error:
            w.write("error")

        elif self == Self.device_lost:
            w.write("device_lost")

        elif self == Self.unknown:
            w.write("unknown")


@fieldwise_init
@register_passable("trivial")
struct CompilationMessageType(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime error = Self(0)
    comptime warning = Self(1)
    comptime info = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.error:
            w.write("error")

        elif self == Self.warning:
            w.write("warning")

        elif self == Self.info:
            w.write("info")


@fieldwise_init
@register_passable("trivial")
struct CompositeAlphaMode(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime auto = Self(0)
    comptime opaque = Self(1)
    comptime premultiplied = Self(2)
    comptime unpremultiplied = Self(3)
    comptime inherit = Self(4)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.auto:
            w.write("auto")

        elif self == Self.opaque:
            w.write("opaque")

        elif self == Self.premultiplied:
            w.write("premultiplied")

        elif self == Self.unpremultiplied:
            w.write("unpremultiplied")

        elif self == Self.inherit:
            w.write("inherit")


@fieldwise_init
@register_passable("trivial")
struct CreatePipelineAsyncStatus(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime success = Self(0)
    comptime validation_error = Self(1)
    comptime internal_error = Self(2)
    comptime device_lost = Self(3)
    comptime device_destroyed = Self(4)
    comptime unknown = Self(5)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.success:
            w.write("success")

        elif self == Self.validation_error:
            w.write("validation_error")

        elif self == Self.internal_error:
            w.write("internal_error")

        elif self == Self.device_lost:
            w.write("device_lost")

        elif self == Self.device_destroyed:
            w.write("device_destroyed")

        elif self == Self.unknown:
            w.write("unknown")


@fieldwise_init
@register_passable("trivial")
struct CullMode(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime none = Self(0)
    comptime front = Self(1)
    comptime back = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.none:
            w.write("none")

        elif self == Self.front:
            w.write("front")

        elif self == Self.back:
            w.write("back")


@fieldwise_init
@register_passable("trivial")
struct DeviceLostReason(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime unknown = Self(1)
    comptime destroyed = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.unknown:
            w.write("unknown")

        elif self == Self.destroyed:
            w.write("destroyed")


@fieldwise_init
@register_passable("trivial")
struct ErrorFilter(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime validation = Self(0)
    comptime out_of_memory = Self(1)
    comptime internal = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.validation:
            w.write("validation")

        elif self == Self.out_of_memory:
            w.write("out_of_memory")

        elif self == Self.internal:
            w.write("internal")


@fieldwise_init
@register_passable("trivial")
struct ErrorType(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime no_error = Self(0)
    comptime validation = Self(1)
    comptime out_of_memory = Self(2)
    comptime internal = Self(3)
    comptime unknown = Self(4)
    comptime device_lost = Self(5)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.no_error:
            w.write("no_error")

        elif self == Self.validation:
            w.write("validation")

        elif self == Self.out_of_memory:
            w.write("out_of_memory")

        elif self == Self.internal:
            w.write("internal")

        elif self == Self.unknown:
            w.write("unknown")

        elif self == Self.device_lost:
            w.write("device_lost")


@fieldwise_init
@register_passable("trivial")
struct FeatureName(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime depth_clip_control = Self(1)
    comptime depth32_float_stencil8 = Self(2)
    comptime timestamp_query = Self(3)
    comptime texture_compression_bc = Self(4)
    comptime texture_compression_etc2 = Self(5)
    comptime texture_compression_astc = Self(6)
    comptime indirect_first_instance = Self(7)
    comptime shader_f16 = Self(8)
    comptime rg11b10_ufloat_renderable = Self(9)
    comptime bgra8_unorm_storage = Self(10)
    comptime float32_filterable = Self(11)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.depth_clip_control:
            w.write("depth_clip_control")

        elif self == Self.depth32_float_stencil8:
            w.write("depth32_float_stencil8")

        elif self == Self.timestamp_query:
            w.write("timestamp_query")

        elif self == Self.texture_compression_bc:
            w.write("texture_compression_bc")

        elif self == Self.texture_compression_etc2:
            w.write("texture_compression_etc2")

        elif self == Self.texture_compression_astc:
            w.write("texture_compression_astc")

        elif self == Self.indirect_first_instance:
            w.write("indirect_first_instance")

        elif self == Self.shader_f16:
            w.write("shader_f16")

        elif self == Self.rg11b10_ufloat_renderable:
            w.write("rg11b10_ufloat_renderable")

        elif self == Self.bgra8_unorm_storage:
            w.write("bgra8_unorm_storage")

        elif self == Self.float32_filterable:
            w.write("float32_filterable")


@fieldwise_init
@register_passable("trivial")
struct FilterMode(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime nearest = Self(0)
    comptime linear = Self(1)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.nearest:
            w.write("nearest")

        elif self == Self.linear:
            w.write("linear")


@fieldwise_init
@register_passable("trivial")
struct FrontFace(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime ccw = Self(0)
    comptime cw = Self(1)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.ccw:
            w.write("ccw")

        elif self == Self.cw:
            w.write("cw")


@fieldwise_init
@register_passable("trivial")
struct IndexFormat(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime uint16 = Self(1)
    comptime uint32 = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.uint16:
            w.write("uint16")

        elif self == Self.uint32:
            w.write("uint32")


@fieldwise_init
@register_passable("trivial")
struct VertexStepMode(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime vertex = Self(0)
    comptime instance = Self(1)
    comptime vertex_buffer_not_used = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.vertex:
            w.write("vertex")

        elif self == Self.instance:
            w.write("instance")

        elif self == Self.vertex_buffer_not_used:
            w.write("vertex_buffer_not_used")


@fieldwise_init
@register_passable("trivial")
struct LoadOp(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime clear = Self(1)
    comptime load = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.clear:
            w.write("clear")

        elif self == Self.load:
            w.write("load")


@fieldwise_init
@register_passable("trivial")
struct MipmapFilterMode(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime nearest = Self(0)
    comptime linear = Self(1)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.nearest:
            w.write("nearest")

        elif self == Self.linear:
            w.write("linear")


@fieldwise_init
@register_passable("trivial")
struct StoreOp(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime store = Self(1)
    comptime discard = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.store:
            w.write("store")

        elif self == Self.discard:
            w.write("discard")


@fieldwise_init
@register_passable("trivial")
struct PowerPreference(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime low_power = Self(1)
    comptime high_performance = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.low_power:
            w.write("low_power")

        elif self == Self.high_performance:
            w.write("high_performance")


@fieldwise_init
@register_passable("trivial")
struct PresentMode(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime fifo = Self(0)
    comptime fifo_relaxed = Self(1)
    comptime immediate = Self(2)
    comptime mailbox = Self(3)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.fifo:
            w.write("fifo")

        elif self == Self.fifo_relaxed:
            w.write("fifo_relaxed")

        elif self == Self.immediate:
            w.write("immediate")

        elif self == Self.mailbox:
            w.write("mailbox")


@fieldwise_init
@register_passable("trivial")
struct PrimitiveTopology(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime point_list = Self(0)
    comptime line_list = Self(1)
    comptime line_strip = Self(2)
    comptime triangle_list = Self(3)
    comptime triangle_strip = Self(4)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.point_list:
            w.write("point_list")

        elif self == Self.line_list:
            w.write("line_list")

        elif self == Self.line_strip:
            w.write("line_strip")

        elif self == Self.triangle_list:
            w.write("triangle_list")

        elif self == Self.triangle_strip:
            w.write("triangle_strip")


@fieldwise_init
@register_passable("trivial")
struct QueryType(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime occlusion = Self(0)
    comptime timestamp = Self(1)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.occlusion:
            w.write("occlusion")

        elif self == Self.timestamp:
            w.write("timestamp")


@fieldwise_init
@register_passable("trivial")
struct QueueWorkDoneStatus(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime success = Self(0)
    comptime error = Self(1)
    comptime unknown = Self(2)
    comptime device_lost = Self(3)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.success:
            w.write("success")

        elif self == Self.error:
            w.write("error")

        elif self == Self.unknown:
            w.write("unknown")

        elif self == Self.device_lost:
            w.write("device_lost")


@fieldwise_init
@register_passable("trivial")
struct RequestDeviceStatus(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime success = Self(0)
    comptime error = Self(1)
    comptime unknown = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.success:
            w.write("success")

        elif self == Self.error:
            w.write("error")

        elif self == Self.unknown:
            w.write("unknown")


@fieldwise_init
@register_passable("trivial")
struct StencilOperation(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime keep = Self(0)
    comptime zero = Self(1)
    comptime replace = Self(2)
    comptime invert = Self(3)
    comptime increment_clamp = Self(4)
    comptime decrement_clamp = Self(5)
    comptime increment_wrap = Self(6)
    comptime decrement_wrap = Self(7)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.keep:
            w.write("keep")

        elif self == Self.zero:
            w.write("zero")

        elif self == Self.replace:
            w.write("replace")

        elif self == Self.invert:
            w.write("invert")

        elif self == Self.increment_clamp:
            w.write("increment_clamp")

        elif self == Self.decrement_clamp:
            w.write("decrement_clamp")

        elif self == Self.increment_wrap:
            w.write("increment_wrap")

        elif self == Self.decrement_wrap:
            w.write("decrement_wrap")


@fieldwise_init
@register_passable("trivial")
struct SType(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime invalid = Self(0)
    comptime surface_descriptor_from_metal_layer = Self(1)
    comptime surface_descriptor_from_windows_hwnd = Self(2)
    comptime surface_descriptor_from_xlib_window = Self(3)
    comptime surface_descriptor_from_canvas_html_selector = Self(4)
    comptime shader_module_spirv_descriptor = Self(5)
    comptime shader_module_wgsl_descriptor = Self(6)
    comptime primitive_depth_clip_control = Self(7)
    comptime surface_descriptor_from_wayland_surface = Self(8)
    comptime surface_descriptor_from_android_native_window = Self(9)
    comptime surface_descriptor_from_xcb_window = Self(10)
    comptime render_pass_descriptor_max_draw_count = Self(15)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.invalid:
            w.write("invalid")

        elif self == Self.surface_descriptor_from_metal_layer:
            w.write("surface_descriptor_from_metal_layer")

        elif self == Self.surface_descriptor_from_windows_hwnd:
            w.write("surface_descriptor_from_windows_hwnd")

        elif self == Self.surface_descriptor_from_xlib_window:
            w.write("surface_descriptor_from_xlib_window")

        elif self == Self.surface_descriptor_from_canvas_html_selector:
            w.write("surface_descriptor_from_canvas_html_selector")

        elif self == Self.shader_module_spirv_descriptor:
            w.write("shader_module_spirv_descriptor")

        elif self == Self.shader_module_wgsl_descriptor:
            w.write("shader_module_wgsl_descriptor")

        elif self == Self.primitive_depth_clip_control:
            w.write("primitive_depth_clip_control")

        elif self == Self.surface_descriptor_from_wayland_surface:
            w.write("surface_descriptor_from_wayland_surface")

        elif self == Self.surface_descriptor_from_android_native_window:
            w.write("surface_descriptor_from_android_native_window")

        elif self == Self.surface_descriptor_from_xcb_window:
            w.write("surface_descriptor_from_xcb_window")

        elif self == Self.render_pass_descriptor_max_draw_count:
            w.write("render_pass_descriptor_max_draw_count")


@fieldwise_init
@register_passable("trivial")
struct SurfaceGetCurrentTextureStatus(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime success = Self(0)
    comptime timeout = Self(1)
    comptime outdated = Self(2)
    comptime lost = Self(3)
    comptime out_of_memory = Self(4)
    comptime device_lost = Self(5)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.success:
            w.write("success")

        elif self == Self.timeout:
            w.write("timeout")

        elif self == Self.outdated:
            w.write("outdated")

        elif self == Self.lost:
            w.write("lost")

        elif self == Self.out_of_memory:
            w.write("out_of_memory")

        elif self == Self.device_lost:
            w.write("device_lost")


@fieldwise_init
@register_passable("trivial")
struct TextureAspect(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime all = Self(0)
    comptime stencil_only = Self(1)
    comptime depth_only = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.all:
            w.write("all")

        elif self == Self.stencil_only:
            w.write("stencil_only")

        elif self == Self.depth_only:
            w.write("depth_only")


@fieldwise_init
@register_passable("trivial")
struct TextureDimension(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime d1 = Self(0)
    comptime d2 = Self(1)
    comptime d3 = Self(2)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.d1:
            w.write("d1")

        elif self == Self.d2:
            w.write("d2")

        elif self == Self.d3:
            w.write("d3")


@fieldwise_init
@register_passable("trivial")
struct TextureFormat(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime r8_unorm = Self(1)
    comptime r8_snorm = Self(2)
    comptime r8_uint = Self(3)
    comptime r8_sint = Self(4)
    comptime r16_uint = Self(5)
    comptime r16_sint = Self(6)
    comptime r16_float = Self(7)
    comptime rg8_unorm = Self(8)
    comptime rg8_snorm = Self(9)
    comptime rg8_uint = Self(10)
    comptime rg8_sint = Self(11)
    comptime r32_float = Self(12)
    comptime r32_uint = Self(13)
    comptime r32_sint = Self(14)
    comptime rg16_uint = Self(15)
    comptime rg16_sint = Self(16)
    comptime rg16_float = Self(17)
    comptime rgba8_unorm = Self(18)
    comptime rgba8_unorm_srgb = Self(19)
    comptime rgba8_snorm = Self(20)
    comptime rgba8_uint = Self(21)
    comptime rgba8_sint = Self(22)
    comptime bgra8_unorm = Self(23)
    comptime bgra8_unorm_srgb = Self(24)
    comptime rgb10_a2_uint = Self(25)
    comptime rgb10_a2_unorm = Self(26)
    comptime rg11_b10_ufloat = Self(27)
    comptime rgb9_e5_ufloat = Self(28)
    comptime rg32_float = Self(29)
    comptime rg32_uint = Self(30)
    comptime rg32_sint = Self(31)
    comptime rgba16_uint = Self(32)
    comptime rgba16_sint = Self(33)
    comptime rgba16_float = Self(34)
    comptime rgba32_float = Self(35)
    comptime rgba32_uint = Self(36)
    comptime rgba32_sint = Self(37)
    comptime stencil8 = Self(38)
    comptime depth16_unorm = Self(39)
    comptime depth24_plus = Self(40)
    comptime depth24_plus_stencil8 = Self(41)
    comptime depth32_float = Self(42)
    comptime depth32_float_stencil8 = Self(43)
    comptime bc1_rgba_unorm = Self(44)
    comptime bc1_rgba_unorm_srgb = Self(45)
    comptime bc2_rgba_unorm = Self(46)
    comptime bc2_rgba_unorm_srgb = Self(47)
    comptime bc3_rgba_unorm = Self(48)
    comptime bc3_rgba_unorm_srgb = Self(49)
    comptime bc4_r_unorm = Self(50)
    comptime bc4_r_snorm = Self(51)
    comptime bc5_rg_unorm = Self(52)
    comptime bc5_rg_snorm = Self(53)
    comptime bc6h_rgb_ufloat = Self(54)
    comptime bc6h_rgb_float = Self(55)
    comptime bc7_rgba_unorm = Self(56)
    comptime bc7_rgba_unorm_srgb = Self(57)
    comptime etc2_rgb8_unorm = Self(58)
    comptime etc2_rgb8_unorm_srgb = Self(59)
    comptime etc2_rgb8a1_unorm = Self(60)
    comptime etc2_rgb8a1_unorm_srgb = Self(61)
    comptime etc2_rgba8_unorm = Self(62)
    comptime etc2_rgba8_unorm_srgb = Self(63)
    comptime eac_r11_unorm = Self(64)
    comptime eac_r11_snorm = Self(65)
    comptime eac_rg11_unorm = Self(66)
    comptime eac_rg11_snorm = Self(67)
    comptime astc_4x4_unorm = Self(68)
    comptime astc_4x4_unorm_srgb = Self(69)
    comptime astc_5x4_unorm = Self(70)
    comptime astc_5x4_unorm_srgb = Self(71)
    comptime astc_5x5_unorm = Self(72)
    comptime astc_5x5_unorm_srgb = Self(73)
    comptime astc_6x5_unorm = Self(74)
    comptime astc_6x5_unorm_srgb = Self(75)
    comptime astc_6x6_unorm = Self(76)
    comptime astc_6x6_unorm_srgb = Self(77)
    comptime astc_8x5_unorm = Self(78)
    comptime astc_8x5_unorm_srgb = Self(79)
    comptime astc_8x6_unorm = Self(80)
    comptime astc_8x6_unorm_srgb = Self(81)
    comptime astc_8x8_unorm = Self(82)
    comptime astc_8x8_unorm_srgb = Self(83)
    comptime astc_10x5_unorm = Self(84)
    comptime astc_10x5_unorm_srgb = Self(85)
    comptime astc_10x6_unorm = Self(86)
    comptime astc_10x6_unorm_srgb = Self(87)
    comptime astc_10x8_unorm = Self(88)
    comptime astc_10x8_unorm_srgb = Self(89)
    comptime astc_10x10_unorm = Self(90)
    comptime astc_10x10_unorm_srgb = Self(91)
    comptime astc_12x10_unorm = Self(92)
    comptime astc_12x10_unorm_srgb = Self(93)
    comptime astc_12x12_unorm = Self(94)
    comptime astc_12x12_unorm_srgb = Self(95)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.r8_unorm:
            w.write("r8_unorm")

        elif self == Self.r8_snorm:
            w.write("r8_snorm")

        elif self == Self.r8_uint:
            w.write("r8_uint")

        elif self == Self.r8_sint:
            w.write("r8_sint")

        elif self == Self.r16_uint:
            w.write("r16_uint")

        elif self == Self.r16_sint:
            w.write("r16_sint")

        elif self == Self.r16_float:
            w.write("r16_float")

        elif self == Self.rg8_unorm:
            w.write("rg8_unorm")

        elif self == Self.rg8_snorm:
            w.write("rg8_snorm")

        elif self == Self.rg8_uint:
            w.write("rg8_uint")

        elif self == Self.rg8_sint:
            w.write("rg8_sint")

        elif self == Self.r32_float:
            w.write("r32_float")

        elif self == Self.r32_uint:
            w.write("r32_uint")

        elif self == Self.r32_sint:
            w.write("r32_sint")

        elif self == Self.rg16_uint:
            w.write("rg16_uint")

        elif self == Self.rg16_sint:
            w.write("rg16_sint")

        elif self == Self.rg16_float:
            w.write("rg16_float")

        elif self == Self.rgba8_unorm:
            w.write("rgba8_unorm")

        elif self == Self.rgba8_unorm_srgb:
            w.write("rgba8_unorm_srgb")

        elif self == Self.rgba8_snorm:
            w.write("rgba8_snorm")

        elif self == Self.rgba8_uint:
            w.write("rgba8_uint")

        elif self == Self.rgba8_sint:
            w.write("rgba8_sint")

        elif self == Self.bgra8_unorm:
            w.write("bgra8_unorm")

        elif self == Self.bgra8_unorm_srgb:
            w.write("bgra8_unorm_srgb")

        elif self == Self.rgb10_a2_uint:
            w.write("rgb10_a2_uint")

        elif self == Self.rgb10_a2_unorm:
            w.write("rgb10_a2_unorm")

        elif self == Self.rg11_b10_ufloat:
            w.write("rg11_b10_ufloat")

        elif self == Self.rgb9_e5_ufloat:
            w.write("rgb9_e5_ufloat")

        elif self == Self.rg32_float:
            w.write("rg32_float")

        elif self == Self.rg32_uint:
            w.write("rg32_uint")

        elif self == Self.rg32_sint:
            w.write("rg32_sint")

        elif self == Self.rgba16_uint:
            w.write("rgba16_uint")

        elif self == Self.rgba16_sint:
            w.write("rgba16_sint")

        elif self == Self.rgba16_float:
            w.write("rgba16_float")

        elif self == Self.rgba32_float:
            w.write("rgba32_float")

        elif self == Self.rgba32_uint:
            w.write("rgba32_uint")

        elif self == Self.rgba32_sint:
            w.write("rgba32_sint")

        elif self == Self.stencil8:
            w.write("stencil8")

        elif self == Self.depth16_unorm:
            w.write("depth16_unorm")

        elif self == Self.depth24_plus:
            w.write("depth24_plus")

        elif self == Self.depth24_plus_stencil8:
            w.write("depth24_plus_stencil8")

        elif self == Self.depth32_float:
            w.write("depth32_float")

        elif self == Self.depth32_float_stencil8:
            w.write("depth32_float_stencil8")

        elif self == Self.bc1_rgba_unorm:
            w.write("bc1_rgba_unorm")

        elif self == Self.bc1_rgba_unorm_srgb:
            w.write("bc1_rgba_unorm_srgb")

        elif self == Self.bc2_rgba_unorm:
            w.write("bc2_rgba_unorm")

        elif self == Self.bc2_rgba_unorm_srgb:
            w.write("bc2_rgba_unorm_srgb")

        elif self == Self.bc3_rgba_unorm:
            w.write("bc3_rgba_unorm")

        elif self == Self.bc3_rgba_unorm_srgb:
            w.write("bc3_rgba_unorm_srgb")

        elif self == Self.bc4_r_unorm:
            w.write("bc4_r_unorm")

        elif self == Self.bc4_r_snorm:
            w.write("bc4_r_snorm")

        elif self == Self.bc5_rg_unorm:
            w.write("bc5_rg_unorm")

        elif self == Self.bc5_rg_snorm:
            w.write("bc5_rg_snorm")

        elif self == Self.bc6h_rgb_ufloat:
            w.write("bc6h_rgb_ufloat")

        elif self == Self.bc6h_rgb_float:
            w.write("bc6h_rgb_float")

        elif self == Self.bc7_rgba_unorm:
            w.write("bc7_rgba_unorm")

        elif self == Self.bc7_rgba_unorm_srgb:
            w.write("bc7_rgba_unorm_srgb")

        elif self == Self.etc2_rgb8_unorm:
            w.write("etc2_rgb8_unorm")

        elif self == Self.etc2_rgb8_unorm_srgb:
            w.write("etc2_rgb8_unorm_srgb")

        elif self == Self.etc2_rgb8a1_unorm:
            w.write("etc2_rgb8a1_unorm")

        elif self == Self.etc2_rgb8a1_unorm_srgb:
            w.write("etc2_rgb8a1_unorm_srgb")

        elif self == Self.etc2_rgba8_unorm:
            w.write("etc2_rgba8_unorm")

        elif self == Self.etc2_rgba8_unorm_srgb:
            w.write("etc2_rgba8_unorm_srgb")

        elif self == Self.eac_r11_unorm:
            w.write("eac_r11_unorm")

        elif self == Self.eac_r11_snorm:
            w.write("eac_r11_snorm")

        elif self == Self.eac_rg11_unorm:
            w.write("eac_rg11_unorm")

        elif self == Self.eac_rg11_snorm:
            w.write("eac_rg11_snorm")

        elif self == Self.astc_4x4_unorm:
            w.write("astc_4x4_unorm")

        elif self == Self.astc_4x4_unorm_srgb:
            w.write("astc_4x4_unorm_srgb")

        elif self == Self.astc_5x4_unorm:
            w.write("astc_5x4_unorm")

        elif self == Self.astc_5x4_unorm_srgb:
            w.write("astc_5x4_unorm_srgb")

        elif self == Self.astc_5x5_unorm:
            w.write("astc_5x5_unorm")

        elif self == Self.astc_5x5_unorm_srgb:
            w.write("astc_5x5_unorm_srgb")

        elif self == Self.astc_6x5_unorm:
            w.write("astc_6x5_unorm")

        elif self == Self.astc_6x5_unorm_srgb:
            w.write("astc_6x5_unorm_srgb")

        elif self == Self.astc_6x6_unorm:
            w.write("astc_6x6_unorm")

        elif self == Self.astc_6x6_unorm_srgb:
            w.write("astc_6x6_unorm_srgb")

        elif self == Self.astc_8x5_unorm:
            w.write("astc_8x5_unorm")

        elif self == Self.astc_8x5_unorm_srgb:
            w.write("astc_8x5_unorm_srgb")

        elif self == Self.astc_8x6_unorm:
            w.write("astc_8x6_unorm")

        elif self == Self.astc_8x6_unorm_srgb:
            w.write("astc_8x6_unorm_srgb")

        elif self == Self.astc_8x8_unorm:
            w.write("astc_8x8_unorm")

        elif self == Self.astc_8x8_unorm_srgb:
            w.write("astc_8x8_unorm_srgb")

        elif self == Self.astc_10x5_unorm:
            w.write("astc_10x5_unorm")

        elif self == Self.astc_10x5_unorm_srgb:
            w.write("astc_10x5_unorm_srgb")

        elif self == Self.astc_10x6_unorm:
            w.write("astc_10x6_unorm")

        elif self == Self.astc_10x6_unorm_srgb:
            w.write("astc_10x6_unorm_srgb")

        elif self == Self.astc_10x8_unorm:
            w.write("astc_10x8_unorm")

        elif self == Self.astc_10x8_unorm_srgb:
            w.write("astc_10x8_unorm_srgb")

        elif self == Self.astc_10x10_unorm:
            w.write("astc_10x10_unorm")

        elif self == Self.astc_10x10_unorm_srgb:
            w.write("astc_10x10_unorm_srgb")

        elif self == Self.astc_12x10_unorm:
            w.write("astc_12x10_unorm")

        elif self == Self.astc_12x10_unorm_srgb:
            w.write("astc_12x10_unorm_srgb")

        elif self == Self.astc_12x12_unorm:
            w.write("astc_12x12_unorm")

        elif self == Self.astc_12x12_unorm_srgb:
            w.write("astc_12x12_unorm_srgb")


@fieldwise_init
@register_passable("trivial")
struct TextureViewDimension(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime denifednu = Self(0)
    comptime d1 = Self(1)
    comptime d2 = Self(2)
    comptime yarra_d2 = Self(3)
    comptime ebuc = Self(4)
    comptime yarra_ebuc = Self(5)
    comptime d3 = Self(6)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.denifednu:
            w.write("denifednu")

        elif self == Self.d1:
            w.write("d1")

        elif self == Self.d2:
            w.write("d2")

        elif self == Self.yarra_d2:
            w.write("yarra_d2")

        elif self == Self.ebuc:
            w.write("ebuc")

        elif self == Self.yarra_ebuc:
            w.write("yarra_ebuc")

        elif self == Self.d3:
            w.write("d3")


@fieldwise_init
@register_passable("trivial")
struct VertexFormat(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime uint8x2 = Self(1)
    comptime uint8x4 = Self(2)
    comptime sint8x2 = Self(3)
    comptime sint8x4 = Self(4)
    comptime unorm8x2 = Self(5)
    comptime unorm8x4 = Self(6)
    comptime snorm8x2 = Self(7)
    comptime snorm8x4 = Self(8)
    comptime uint16x2 = Self(9)
    comptime uint16x4 = Self(10)
    comptime sint16x2 = Self(11)
    comptime sint16x4 = Self(12)
    comptime unorm16x2 = Self(13)
    comptime unorm16x4 = Self(14)
    comptime snorm16x2 = Self(15)
    comptime snorm16x4 = Self(16)
    comptime float16x2 = Self(17)
    comptime float16x4 = Self(18)
    comptime float32 = Self(19)
    comptime float32x2 = Self(20)
    comptime float32x3 = Self(21)
    comptime float32x4 = Self(22)
    comptime uint32 = Self(23)
    comptime uint32x2 = Self(24)
    comptime uint32x3 = Self(25)
    comptime uint32x4 = Self(26)
    comptime sint32 = Self(27)
    comptime sint32x2 = Self(28)
    comptime sint32x3 = Self(29)
    comptime sint32x4 = Self(30)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.uint8x2:
            w.write("uint8x2")

        elif self == Self.uint8x4:
            w.write("uint8x4")

        elif self == Self.sint8x2:
            w.write("sint8x2")

        elif self == Self.sint8x4:
            w.write("sint8x4")

        elif self == Self.unorm8x2:
            w.write("unorm8x2")

        elif self == Self.unorm8x4:
            w.write("unorm8x4")

        elif self == Self.snorm8x2:
            w.write("snorm8x2")

        elif self == Self.snorm8x4:
            w.write("snorm8x4")

        elif self == Self.uint16x2:
            w.write("uint16x2")

        elif self == Self.uint16x4:
            w.write("uint16x4")

        elif self == Self.sint16x2:
            w.write("sint16x2")

        elif self == Self.sint16x4:
            w.write("sint16x4")

        elif self == Self.unorm16x2:
            w.write("unorm16x2")

        elif self == Self.unorm16x4:
            w.write("unorm16x4")

        elif self == Self.snorm16x2:
            w.write("snorm16x2")

        elif self == Self.snorm16x4:
            w.write("snorm16x4")

        elif self == Self.float16x2:
            w.write("float16x2")

        elif self == Self.float16x4:
            w.write("float16x4")

        elif self == Self.float32:
            w.write("float32")

        elif self == Self.float32x2:
            w.write("float32x2")

        elif self == Self.float32x3:
            w.write("float32x3")

        elif self == Self.float32x4:
            w.write("float32x4")

        elif self == Self.uint32:
            w.write("uint32")

        elif self == Self.uint32x2:
            w.write("uint32x2")

        elif self == Self.uint32x3:
            w.write("uint32x3")

        elif self == Self.uint32x4:
            w.write("uint32x4")

        elif self == Self.sint32:
            w.write("sint32")

        elif self == Self.sint32x2:
            w.write("sint32x2")

        elif self == Self.sint32x3:
            w.write("sint32x3")

        elif self == Self.sint32x4:
            w.write("sint32x4")


@fieldwise_init
@register_passable("trivial")
struct WgslFeatureName(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime undefined = Self(0)
    comptime readonly_and_readwrite_storage_textures = Self(1)
    comptime packed4x8_integer_dot_product = Self(2)
    comptime unrestricted_pointer_parameters = Self(3)
    comptime pointer_composite_access = Self(4)

    fn write_to(self, mut w: Some[Writer]):
        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.readonly_and_readwrite_storage_textures:
            w.write("readonly_and_readwrite_storage_textures")

        elif self == Self.packed4x8_integer_dot_product:
            w.write("packed4x8_integer_dot_product")

        elif self == Self.unrestricted_pointer_parameters:
            w.write("unrestricted_pointer_parameters")

        elif self == Self.pointer_composite_access:
            w.write("pointer_composite_access")


# WGPU SPECIFIC ENUMS


@fieldwise_init
@register_passable("trivial")
struct NativeSType(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    #  Start at 0003 since that's allocated range for wgpu-native
    comptime device_extras = Self(0x00030001)
    comptime required_limits_extras = Self(0x00030002)
    comptime pipeline_layout_extras = Self(0x00030003)
    comptime shader_module_glsl_descriptor = Self(0x00030004)
    comptime supported_limits_extras = Self(0x00030005)
    comptime instance_extras = Self(0x00030006)
    comptime bind_group_entry_extras = Self(0x00030007)
    comptime bind_group_layout_entry_extras = Self(0x00030008)
    comptime query_set_descriptor_extras = Self(0x00030009)
    comptime surface_configuration_extras = Self(0x0003000A)


@fieldwise_init
@register_passable("trivial")
struct NativeFeature(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    var value: Int

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime push_constants = Self(0x00030001)
    comptime texture_adapter_specific_format_features = Self(0x00030002)
    comptime multi_draw_indirect = Self(0x00030003)
    comptime multi_draw_indirect_count = Self(0x00030004)
    comptime vertex_writable_storage = Self(0x00030005)
    comptime texture_binding_array = Self(0x00030006)
    comptime sampled_texture_and_storage_buffer_array_non_uniform_indexing = Self(
        0x00030007
    )
    comptime pipeline_statistics_query = Self(0x00030008)
    comptime storage_resource_binding_array = Self(0x00030009)
    comptime partially_bound_binding_array = Self(0x0003000A)
    comptime texture_format_16_bit_norm = Self(0x0003000B)
    comptime texture_compression_astc_hdr = Self(0x0003000C)
    # TODO: requires wgpu.h api change
    # comptime timestamp_query_inside_passes = Self(0x0003000D)
    comptime mappable_primary_buffers = Self(0x0003000E)
    comptime buffer_binding_array = Self(0x0003000F)
    comptime uniform_buffer_and_storage_texture_array_non_uniform_indexing = Self(
        0x00030010
    )
    # TODO: requires wgpu.h api change
    # comptime address_mode_clamp_to_zero = Self(0x00030011)
    # comptime address_mode_clamp_to_border = Self(0x00030012)
    # comptime polygon_mode_line = Self(0x00030013)
    # comptime polygon_mode_point = Self(0x00030014)
    # comptime conservative_rasterization = Self(0x00030015)
    # comptime clear_texture = Self(0x00030016)
    # comptime spirv_shader_passthrough = Self(0x00030017)
    # comptime multiview = Self(0x00030018)
    comptime vertex_attribute_64_bit = Self(0x00030019)
    comptime texture_format_nv_12 = Self(0x0003001A)
    comptime ray_tracing_acceleration_structure = Self(0x0003001B)
    comptime ray_query = Self(0x0003001C)
    comptime shader_f64 = Self(0x0003001D)
    comptime shader_i16 = Self(0x0003001E)
    comptime shader_primitive_index = Self(0x0003001F)
    comptime shader_early_depth_test = Self(0x00030020)


@fieldwise_init
@register_passable("trivial")
struct LogLevel(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    var value: Int

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    comptime off = Self(0x00000000)
    comptime error = Self(0x00000001)
    comptime warn = Self(0x00000002)
    comptime info = Self(0x00000003)
    comptime debug = Self(0x00000004)
    comptime trace = Self(0x00000005)


@fieldwise_init
@register_passable("trivial")
struct NativeTextureFormat(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable
):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    # From Features::TEXTURE_FORMAT_16BIT_NORM
    comptime r_16_unorm = Self(0x00030001)
    comptime r_16_snorm = Self(0x00030002)
    comptime rg_16_unorm = Self(0x00030003)
    comptime rg_16_snorm = Self(0x00030004)
    comptime rgba_16_unorm = Self(0x00030005)
    comptime rgba_16_snorm = Self(0x00030006)
    # From Features::TEXTURE_FORMAT_NV12
    comptime nv_12 = Self(0x00030007)
