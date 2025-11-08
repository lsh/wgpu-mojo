
@fieldwise_init
@register_passable("trivial")
struct RequestAdapterStatus(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias success = Self(0)
    """TODO"""
    alias unavailable = Self(1)
    """TODO"""
    alias error = Self(2)
    """TODO"""
    alias unknown = Self(3)
    """TODO"""

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
struct AdapterType(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias discrete_gpu = Self(0)
    """TODO"""
    alias integrated_gpu = Self(1)
    """TODO"""
    alias cpu = Self(2)
    """TODO"""
    alias unknown = Self(3)
    """TODO"""

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
struct AddressMode(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias repeat = Self(0)
    """TODO"""
    alias mirror_repeat = Self(1)
    """TODO"""
    alias clamp_to_edge = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.repeat:
            w.write("repeat")

        elif self == Self.mirror_repeat:
            w.write("mirror_repeat")

        elif self == Self.clamp_to_edge:
            w.write("clamp_to_edge")


@fieldwise_init
@register_passable("trivial")
struct BackendType(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias null = Self(1)
    """TODO"""
    alias webgpu = Self(2)
    """TODO"""
    alias d3d11 = Self(3)
    """TODO"""
    alias d3d12 = Self(4)
    """TODO"""
    alias metal = Self(5)
    """TODO"""
    alias vulkan = Self(6)
    """TODO"""
    alias opengl = Self(7)
    """TODO"""
    alias opengles = Self(8)
    """TODO"""

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
struct BufferBindingType(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias uniform = Self(1)
    """TODO"""
    alias storage = Self(2)
    """TODO"""
    alias read_only_storage = Self(3)
    """TODO"""

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
struct SamplerBindingType(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias filtering = Self(1)
    """TODO"""
    alias non_filtering = Self(2)
    """TODO"""
    alias comparison = Self(3)
    """TODO"""

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
struct TextureSampleType(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias float = Self(1)
    """TODO"""
    alias unfilterable_float = Self(2)
    """TODO"""
    alias depth = Self(3)
    """TODO"""
    alias sint = Self(4)
    """TODO"""
    alias uint = Self(5)
    """TODO"""

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
struct StorageTextureAccess(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias write_only = Self(1)
    """TODO"""
    alias read_only = Self(2)
    """TODO"""
    alias read_write = Self(3)
    """TODO"""

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
struct BlendFactor(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias zero = Self(0)
    """TODO"""
    alias one = Self(1)
    """TODO"""
    alias src = Self(2)
    """TODO"""
    alias one_minus_src = Self(3)
    """TODO"""
    alias src_alpha = Self(4)
    """TODO"""
    alias one_minus_src_alpha = Self(5)
    """TODO"""
    alias dst = Self(6)
    """TODO"""
    alias one_minus_dst = Self(7)
    """TODO"""
    alias dst_alpha = Self(8)
    """TODO"""
    alias one_minus_dst_alpha = Self(9)
    """TODO"""
    alias src_alpha_saturated = Self(10)
    """TODO"""
    alias constant = Self(11)
    """TODO"""
    alias one_minus_constant = Self(12)
    """TODO"""

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
struct BlendOperation(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias add = Self(0)
    """TODO"""
    alias subtract = Self(1)
    """TODO"""
    alias reverse_subtract = Self(2)
    """TODO"""
    alias min = Self(3)
    """TODO"""
    alias max = Self(4)
    """TODO"""

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
struct BufferMapAsyncStatus(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias success = Self(0)
    """TODO"""
    alias validation_error = Self(1)
    """TODO"""
    alias unknown = Self(2)
    """TODO"""
    alias device_lost = Self(3)
    """TODO"""
    alias destroyed_before_callback = Self(4)
    """TODO"""
    alias unmapped_before_callback = Self(5)
    """TODO"""
    alias mapping_already_pending = Self(6)
    """TODO"""
    alias offset_out_of_range = Self(7)
    """TODO"""
    alias size_out_of_range = Self(8)
    """TODO"""

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
struct BufferMapState(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias unmapped = Self(0)
    """TODO"""
    alias pending = Self(1)
    """TODO"""
    alias mapped = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.unmapped:
            w.write("unmapped")

        elif self == Self.pending:
            w.write("pending")

        elif self == Self.mapped:
            w.write("mapped")


@fieldwise_init
@register_passable("trivial")
struct CompareFunction(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias never = Self(1)
    """TODO"""
    alias less = Self(2)
    """TODO"""
    alias less_equal = Self(3)
    """TODO"""
    alias greater = Self(4)
    """TODO"""
    alias greater_equal = Self(5)
    """TODO"""
    alias equal = Self(6)
    """TODO"""
    alias not_equal = Self(7)
    """TODO"""
    alias always = Self(8)
    """TODO"""

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
struct CompilationInfoRequestStatus(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias success = Self(0)
    """TODO"""
    alias error = Self(1)
    """TODO"""
    alias device_lost = Self(2)
    """TODO"""
    alias unknown = Self(3)
    """TODO"""

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
struct CompilationMessageType(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias error = Self(0)
    """TODO"""
    alias warning = Self(1)
    """TODO"""
    alias info = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.error:
            w.write("error")

        elif self == Self.warning:
            w.write("warning")

        elif self == Self.info:
            w.write("info")


@fieldwise_init
@register_passable("trivial")
struct CompositeAlphaMode(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias auto = Self(0)
    """TODO"""
    alias opaque = Self(1)
    """TODO"""
    alias premultiplied = Self(2)
    """TODO"""
    alias unpremultiplied = Self(3)
    """TODO"""
    alias inherit = Self(4)
    """TODO"""

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
struct CreatePipelineAsyncStatus(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias success = Self(0)
    """TODO"""
    alias validation_error = Self(1)
    """TODO"""
    alias internal_error = Self(2)
    """TODO"""
    alias device_lost = Self(3)
    """TODO"""
    alias device_destroyed = Self(4)
    """TODO"""
    alias unknown = Self(5)
    """TODO"""

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
struct CullMode(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias none = Self(0)
    """TODO"""
    alias front = Self(1)
    """TODO"""
    alias back = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.none:
            w.write("none")

        elif self == Self.front:
            w.write("front")

        elif self == Self.back:
            w.write("back")


@fieldwise_init
@register_passable("trivial")
struct DeviceLostReason(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias unknown = Self(1)
    """TODO"""
    alias destroyed = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.unknown:
            w.write("unknown")

        elif self == Self.destroyed:
            w.write("destroyed")


@fieldwise_init
@register_passable("trivial")
struct ErrorFilter(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias validation = Self(0)
    """TODO"""
    alias out_of_memory = Self(1)
    """TODO"""
    alias internal = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.validation:
            w.write("validation")

        elif self == Self.out_of_memory:
            w.write("out_of_memory")

        elif self == Self.internal:
            w.write("internal")


@fieldwise_init
@register_passable("trivial")
struct ErrorType(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias no_error = Self(0)
    """TODO"""
    alias validation = Self(1)
    """TODO"""
    alias out_of_memory = Self(2)
    """TODO"""
    alias internal = Self(3)
    """TODO"""
    alias unknown = Self(4)
    """TODO"""
    alias device_lost = Self(5)
    """TODO"""

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
struct FeatureName(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias depth_clip_control = Self(1)
    """TODO"""
    alias depth32_float_stencil8 = Self(2)
    """TODO"""
    alias timestamp_query = Self(3)
    """TODO"""
    alias texture_compression_bc = Self(4)
    """TODO"""
    alias texture_compression_etc2 = Self(5)
    """TODO"""
    alias texture_compression_astc = Self(6)
    """TODO"""
    alias indirect_first_instance = Self(7)
    """TODO"""
    alias shader_f16 = Self(8)
    """TODO"""
    alias rg11b10_ufloat_renderable = Self(9)
    """TODO"""
    alias bgra8_unorm_storage = Self(10)
    """TODO"""
    alias float32_filterable = Self(11)
    """TODO"""

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
struct FilterMode(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias nearest = Self(0)
    """TODO"""
    alias linear = Self(1)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.nearest:
            w.write("nearest")

        elif self == Self.linear:
            w.write("linear")


@fieldwise_init
@register_passable("trivial")
struct FrontFace(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias ccw = Self(0)
    """TODO"""
    alias cw = Self(1)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.ccw:
            w.write("ccw")

        elif self == Self.cw:
            w.write("cw")


@fieldwise_init
@register_passable("trivial")
struct IndexFormat(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias uint16 = Self(1)
    """TODO"""
    alias uint32 = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.uint16:
            w.write("uint16")

        elif self == Self.uint32:
            w.write("uint32")


@fieldwise_init
@register_passable("trivial")
struct VertexStepMode(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias vertex = Self(0)
    """TODO"""
    alias instance = Self(1)
    """TODO"""
    alias vertex_buffer_not_used = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.vertex:
            w.write("vertex")

        elif self == Self.instance:
            w.write("instance")

        elif self == Self.vertex_buffer_not_used:
            w.write("vertex_buffer_not_used")


@fieldwise_init
@register_passable("trivial")
struct LoadOp(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias clear = Self(1)
    """TODO"""
    alias load = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.clear:
            w.write("clear")

        elif self == Self.load:
            w.write("load")


@fieldwise_init
@register_passable("trivial")
struct MipmapFilterMode(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias nearest = Self(0)
    """TODO"""
    alias linear = Self(1)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.nearest:
            w.write("nearest")

        elif self == Self.linear:
            w.write("linear")


@fieldwise_init
@register_passable("trivial")
struct StoreOp(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias store = Self(1)
    """TODO"""
    alias discard = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.store:
            w.write("store")

        elif self == Self.discard:
            w.write("discard")


@fieldwise_init
@register_passable("trivial")
struct PowerPreference(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias low_power = Self(1)
    """TODO"""
    alias high_performance = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.undefined:
            w.write("undefined")

        elif self == Self.low_power:
            w.write("low_power")

        elif self == Self.high_performance:
            w.write("high_performance")


@fieldwise_init
@register_passable("trivial")
struct PresentMode(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias fifo = Self(0)
    """TODO"""
    alias fifo_relaxed = Self(1)
    """TODO"""
    alias immediate = Self(2)
    """TODO"""
    alias mailbox = Self(3)
    """TODO"""

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
struct PrimitiveTopology(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias point_list = Self(0)
    """TODO"""
    alias line_list = Self(1)
    """TODO"""
    alias line_strip = Self(2)
    """TODO"""
    alias triangle_list = Self(3)
    """TODO"""
    alias triangle_strip = Self(4)
    """TODO"""

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
struct QueryType(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias occlusion = Self(0)
    """TODO"""
    alias timestamp = Self(1)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.occlusion:
            w.write("occlusion")

        elif self == Self.timestamp:
            w.write("timestamp")


@fieldwise_init
@register_passable("trivial")
struct QueueWorkDoneStatus(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias success = Self(0)
    """TODO"""
    alias error = Self(1)
    """TODO"""
    alias unknown = Self(2)
    """TODO"""
    alias device_lost = Self(3)
    """TODO"""

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
struct RequestDeviceStatus(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias success = Self(0)
    """TODO"""
    alias error = Self(1)
    """TODO"""
    alias unknown = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.success:
            w.write("success")

        elif self == Self.error:
            w.write("error")

        elif self == Self.unknown:
            w.write("unknown")


@fieldwise_init
@register_passable("trivial")
struct StencilOperation(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias keep = Self(0)
    """TODO"""
    alias zero = Self(1)
    """TODO"""
    alias replace = Self(2)
    """TODO"""
    alias invert = Self(3)
    """TODO"""
    alias increment_clamp = Self(4)
    """TODO"""
    alias decrement_clamp = Self(5)
    """TODO"""
    alias increment_wrap = Self(6)
    """TODO"""
    alias decrement_wrap = Self(7)
    """TODO"""

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
struct SType(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias invalid = Self(0)
    """TODO"""
    alias surface_descriptor_from_metal_layer = Self(1)
    """TODO"""
    alias surface_descriptor_from_windows_hwnd = Self(2)
    """TODO"""
    alias surface_descriptor_from_xlib_window = Self(3)
    """TODO"""
    alias surface_descriptor_from_canvas_html_selector = Self(4)
    """TODO"""
    alias shader_module_spirv_descriptor = Self(5)
    """TODO"""
    alias shader_module_wgsl_descriptor = Self(6)
    """TODO"""
    alias primitive_depth_clip_control = Self(7)
    """TODO"""
    alias surface_descriptor_from_wayland_surface = Self(8)
    """TODO"""
    alias surface_descriptor_from_android_native_window = Self(9)
    """TODO"""
    alias surface_descriptor_from_xcb_window = Self(10)
    """TODO"""
    alias render_pass_descriptor_max_draw_count = Self(15)
    """TODO"""

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
struct SurfaceGetCurrentTextureStatus(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias success = Self(0)
    """TODO"""
    alias timeout = Self(1)
    """TODO"""
    alias outdated = Self(2)
    """TODO"""
    alias lost = Self(3)
    """TODO"""
    alias out_of_memory = Self(4)
    """TODO"""
    alias device_lost = Self(5)
    """TODO"""

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
struct TextureAspect(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias all = Self(0)
    """TODO"""
    alias stencil_only = Self(1)
    """TODO"""
    alias depth_only = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.all:
            w.write("all")

        elif self == Self.stencil_only:
            w.write("stencil_only")

        elif self == Self.depth_only:
            w.write("depth_only")


@fieldwise_init
@register_passable("trivial")
struct TextureDimension(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias d1 = Self(0)
    """TODO"""
    alias d2 = Self(1)
    """TODO"""
    alias d3 = Self(2)
    """TODO"""

    fn write_to(self, mut w: Some[Writer]):

        if self == Self.d1:
            w.write("d1")

        elif self == Self.d2:
            w.write("d2")

        elif self == Self.d3:
            w.write("d3")


@fieldwise_init
@register_passable("trivial")
struct TextureFormat(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias r8_unorm = Self(1)
    """TODO"""
    alias r8_snorm = Self(2)
    """TODO"""
    alias r8_uint = Self(3)
    """TODO"""
    alias r8_sint = Self(4)
    """TODO"""
    alias r16_uint = Self(5)
    """TODO"""
    alias r16_sint = Self(6)
    """TODO"""
    alias r16_float = Self(7)
    """TODO"""
    alias rg8_unorm = Self(8)
    """TODO"""
    alias rg8_snorm = Self(9)
    """TODO"""
    alias rg8_uint = Self(10)
    """TODO"""
    alias rg8_sint = Self(11)
    """TODO"""
    alias r32_float = Self(12)
    """TODO"""
    alias r32_uint = Self(13)
    """TODO"""
    alias r32_sint = Self(14)
    """TODO"""
    alias rg16_uint = Self(15)
    """TODO"""
    alias rg16_sint = Self(16)
    """TODO"""
    alias rg16_float = Self(17)
    """TODO"""
    alias rgba8_unorm = Self(18)
    """TODO"""
    alias rgba8_unorm_srgb = Self(19)
    """TODO"""
    alias rgba8_snorm = Self(20)
    """TODO"""
    alias rgba8_uint = Self(21)
    """TODO"""
    alias rgba8_sint = Self(22)
    """TODO"""
    alias bgra8_unorm = Self(23)
    """TODO"""
    alias bgra8_unorm_srgb = Self(24)
    """TODO"""
    alias rgb10_a2_uint = Self(25)
    """TODO"""
    alias rgb10_a2_unorm = Self(26)
    """TODO"""
    alias rg11_b10_ufloat = Self(27)
    """TODO"""
    alias rgb9_e5_ufloat = Self(28)
    """TODO"""
    alias rg32_float = Self(29)
    """TODO"""
    alias rg32_uint = Self(30)
    """TODO"""
    alias rg32_sint = Self(31)
    """TODO"""
    alias rgba16_uint = Self(32)
    """TODO"""
    alias rgba16_sint = Self(33)
    """TODO"""
    alias rgba16_float = Self(34)
    """TODO"""
    alias rgba32_float = Self(35)
    """TODO"""
    alias rgba32_uint = Self(36)
    """TODO"""
    alias rgba32_sint = Self(37)
    """TODO"""
    alias stencil8 = Self(38)
    """TODO"""
    alias depth16_unorm = Self(39)
    """TODO"""
    alias depth24_plus = Self(40)
    """TODO"""
    alias depth24_plus_stencil8 = Self(41)
    """TODO"""
    alias depth32_float = Self(42)
    """TODO"""
    alias depth32_float_stencil8 = Self(43)
    """TODO"""
    alias bc1_rgba_unorm = Self(44)
    """TODO"""
    alias bc1_rgba_unorm_srgb = Self(45)
    """TODO"""
    alias bc2_rgba_unorm = Self(46)
    """TODO"""
    alias bc2_rgba_unorm_srgb = Self(47)
    """TODO"""
    alias bc3_rgba_unorm = Self(48)
    """TODO"""
    alias bc3_rgba_unorm_srgb = Self(49)
    """TODO"""
    alias bc4_r_unorm = Self(50)
    """TODO"""
    alias bc4_r_snorm = Self(51)
    """TODO"""
    alias bc5_rg_unorm = Self(52)
    """TODO"""
    alias bc5_rg_snorm = Self(53)
    """TODO"""
    alias bc6h_rgb_ufloat = Self(54)
    """TODO"""
    alias bc6h_rgb_float = Self(55)
    """TODO"""
    alias bc7_rgba_unorm = Self(56)
    """TODO"""
    alias bc7_rgba_unorm_srgb = Self(57)
    """TODO"""
    alias etc2_rgb8_unorm = Self(58)
    """TODO"""
    alias etc2_rgb8_unorm_srgb = Self(59)
    """TODO"""
    alias etc2_rgb8a1_unorm = Self(60)
    """TODO"""
    alias etc2_rgb8a1_unorm_srgb = Self(61)
    """TODO"""
    alias etc2_rgba8_unorm = Self(62)
    """TODO"""
    alias etc2_rgba8_unorm_srgb = Self(63)
    """TODO"""
    alias eac_r11_unorm = Self(64)
    """TODO"""
    alias eac_r11_snorm = Self(65)
    """TODO"""
    alias eac_rg11_unorm = Self(66)
    """TODO"""
    alias eac_rg11_snorm = Self(67)
    """TODO"""
    alias astc_4x4_unorm = Self(68)
    """TODO"""
    alias astc_4x4_unorm_srgb = Self(69)
    """TODO"""
    alias astc_5x4_unorm = Self(70)
    """TODO"""
    alias astc_5x4_unorm_srgb = Self(71)
    """TODO"""
    alias astc_5x5_unorm = Self(72)
    """TODO"""
    alias astc_5x5_unorm_srgb = Self(73)
    """TODO"""
    alias astc_6x5_unorm = Self(74)
    """TODO"""
    alias astc_6x5_unorm_srgb = Self(75)
    """TODO"""
    alias astc_6x6_unorm = Self(76)
    """TODO"""
    alias astc_6x6_unorm_srgb = Self(77)
    """TODO"""
    alias astc_8x5_unorm = Self(78)
    """TODO"""
    alias astc_8x5_unorm_srgb = Self(79)
    """TODO"""
    alias astc_8x6_unorm = Self(80)
    """TODO"""
    alias astc_8x6_unorm_srgb = Self(81)
    """TODO"""
    alias astc_8x8_unorm = Self(82)
    """TODO"""
    alias astc_8x8_unorm_srgb = Self(83)
    """TODO"""
    alias astc_10x5_unorm = Self(84)
    """TODO"""
    alias astc_10x5_unorm_srgb = Self(85)
    """TODO"""
    alias astc_10x6_unorm = Self(86)
    """TODO"""
    alias astc_10x6_unorm_srgb = Self(87)
    """TODO"""
    alias astc_10x8_unorm = Self(88)
    """TODO"""
    alias astc_10x8_unorm_srgb = Self(89)
    """TODO"""
    alias astc_10x10_unorm = Self(90)
    """TODO"""
    alias astc_10x10_unorm_srgb = Self(91)
    """TODO"""
    alias astc_12x10_unorm = Self(92)
    """TODO"""
    alias astc_12x10_unorm_srgb = Self(93)
    """TODO"""
    alias astc_12x12_unorm = Self(94)
    """TODO"""
    alias astc_12x12_unorm_srgb = Self(95)
    """TODO"""

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
struct TextureViewDimension(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias denifednu = Self(0)
    """TODO"""
    alias d1 = Self(1)
    """TODO"""
    alias d2 = Self(2)
    """TODO"""
    alias yarra_d2 = Self(3)
    """TODO"""
    alias ebuc = Self(4)
    """TODO"""
    alias yarra_ebuc = Self(5)
    """TODO"""
    alias d3 = Self(6)
    """TODO"""

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
struct VertexFormat(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias uint8x2 = Self(1)
    """TODO"""
    alias uint8x4 = Self(2)
    """TODO"""
    alias sint8x2 = Self(3)
    """TODO"""
    alias sint8x4 = Self(4)
    """TODO"""
    alias unorm8x2 = Self(5)
    """TODO"""
    alias unorm8x4 = Self(6)
    """TODO"""
    alias snorm8x2 = Self(7)
    """TODO"""
    alias snorm8x4 = Self(8)
    """TODO"""
    alias uint16x2 = Self(9)
    """TODO"""
    alias uint16x4 = Self(10)
    """TODO"""
    alias sint16x2 = Self(11)
    """TODO"""
    alias sint16x4 = Self(12)
    """TODO"""
    alias unorm16x2 = Self(13)
    """TODO"""
    alias unorm16x4 = Self(14)
    """TODO"""
    alias snorm16x2 = Self(15)
    """TODO"""
    alias snorm16x4 = Self(16)
    """TODO"""
    alias float16x2 = Self(17)
    """TODO"""
    alias float16x4 = Self(18)
    """TODO"""
    alias float32 = Self(19)
    """TODO"""
    alias float32x2 = Self(20)
    """TODO"""
    alias float32x3 = Self(21)
    """TODO"""
    alias float32x4 = Self(22)
    """TODO"""
    alias uint32 = Self(23)
    """TODO"""
    alias uint32x2 = Self(24)
    """TODO"""
    alias uint32x3 = Self(25)
    """TODO"""
    alias uint32x4 = Self(26)
    """TODO"""
    alias sint32 = Self(27)
    """TODO"""
    alias sint32x2 = Self(28)
    """TODO"""
    alias sint32x3 = Self(29)
    """TODO"""
    alias sint32x4 = Self(30)
    """TODO"""

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
struct WgslFeatureName(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
    alias undefined = Self(0)
    """TODO"""
    alias readonly_and_readwrite_storage_textures = Self(1)
    """TODO"""
    alias packed4x8_integer_dot_product = Self(2)
    """TODO"""
    alias unrestricted_pointer_parameters = Self(3)
    """TODO"""
    alias pointer_composite_access = Self(4)
    """TODO"""

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
struct NativeSType(Copyable, ImplicitlyCopyable, Movable, EqualityComparable):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    #  Start at 0003 since that's allocated range for wgpu-native
    alias device_extras = Self(0x00030001)
    alias required_limits_extras = Self(0x00030002)
    alias pipeline_layout_extras = Self(0x00030003)
    alias shader_module_glsl_descriptor = Self(0x00030004)
    alias supported_limits_extras = Self(0x00030005)
    alias instance_extras = Self(0x00030006)
    alias bind_group_entry_extras = Self(0x00030007)
    alias bind_group_layout_entry_extras = Self(0x00030008)
    alias query_set_descriptor_extras = Self(0x00030009)
    alias surface_configuration_extras = Self(0x0003000A)


@fieldwise_init
@register_passable("trivial")
struct NativeFeature(Copyable, ImplicitlyCopyable, Movable, EqualityComparable):
    var value: Int

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    alias push_constants = Self(0x00030001)
    alias texture_adapter_specific_format_features = Self(0x00030002)
    alias multi_draw_indirect = Self(0x00030003)
    alias multi_draw_indirect_count = Self(0x00030004)
    alias vertex_writable_storage = Self(0x00030005)
    alias texture_binding_array = Self(0x00030006)
    alias sampled_texture_and_storage_buffer_array_non_uniform_indexing = Self(
        0x00030007
    )
    alias pipeline_statistics_query = Self(0x00030008)
    alias storage_resource_binding_array = Self(0x00030009)
    alias partially_bound_binding_array = Self(0x0003000A)
    alias texture_format_16_bit_norm = Self(0x0003000B)
    alias texture_compression_astc_hdr = Self(0x0003000C)
    # TODO: requires wgpu.h api change
    # alias timestamp_query_inside_passes = Self(0x0003000D)
    alias mappable_primary_buffers = Self(0x0003000E)
    alias buffer_binding_array = Self(0x0003000F)
    alias uniform_buffer_and_storage_texture_array_non_uniform_indexing = Self(
        0x00030010
    )
    # TODO: requires wgpu.h api change
    # alias address_mode_clamp_to_zero = Self(0x00030011)
    # alias address_mode_clamp_to_border = Self(0x00030012)
    # alias polygon_mode_line = Self(0x00030013)
    # alias polygon_mode_point = Self(0x00030014)
    # alias conservative_rasterization = Self(0x00030015)
    # alias clear_texture = Self(0x00030016)
    # alias spirv_shader_passthrough = Self(0x00030017)
    # alias multiview = Self(0x00030018)
    alias vertex_attribute_64_bit = Self(0x00030019)
    alias texture_format_nv_12 = Self(0x0003001A)
    alias ray_tracing_acceleration_structure = Self(0x0003001B)
    alias ray_query = Self(0x0003001C)
    alias shader_f64 = Self(0x0003001D)
    alias shader_i16 = Self(0x0003001E)
    alias shader_primitive_index = Self(0x0003001F)
    alias shader_early_depth_test = Self(0x00030020)


@fieldwise_init
@register_passable("trivial")
struct LogLevel(Copyable, ImplicitlyCopyable, Movable, EqualityComparable):
    var value: Int

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    alias off = Self(0x00000000)
    alias error = Self(0x00000001)
    alias warn = Self(0x00000002)
    alias info = Self(0x00000003)
    alias debug = Self(0x00000004)
    alias trace = Self(0x00000005)


@fieldwise_init
@register_passable("trivial")
struct NativeTextureFormat(Copyable, ImplicitlyCopyable, Movable, EqualityComparable):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    # From Features::TEXTURE_FORMAT_16BIT_NORM
    alias r_16_unorm = Self(0x00030001)
    alias r_16_snorm = Self(0x00030002)
    alias rg_16_unorm = Self(0x00030003)
    alias rg_16_snorm = Self(0x00030004)
    alias rgba_16_unorm = Self(0x00030005)
    alias rgba_16_snorm = Self(0x00030006)
    # From Features::TEXTURE_FORMAT_NV12
    alias nv_12 = Self(0x00030007)
