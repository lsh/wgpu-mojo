
@fieldwise_init
@register_passable("trivial")
struct BufferUsage(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    fn __ne__(self, rhs: Self) -> Bool:
        return self.value != rhs.value

    fn __xor__(self, rhs: Self) -> Self:
        return Self(self.value ^ rhs.value)

    fn __and__(self, rhs: Self) -> Self:
        return Self(self.value & rhs.value)

    fn __or__(self, rhs: Self) -> Self:
        return Self(self.value | rhs.value)

    fn __invert__(self) -> Self:
        return Self(~self.value)

    alias none = Self(0)
    """TODO"""
    alias map_read = Self(1)
    """TODO"""
    alias map_write = Self(2)
    """TODO"""
    alias copy_src = Self(4)
    """TODO"""
    alias copy_dst = Self(8)
    """TODO"""
    alias index = Self(16)
    """TODO"""
    alias vertex = Self(32)
    """TODO"""
    alias uniform = Self(64)
    """TODO"""
    alias storage = Self(128)
    """TODO"""
    alias indirect = Self(256)
    """TODO"""
    alias query_resolve = Self(512)
    """TODO"""


@fieldwise_init
@register_passable("trivial")
struct ColorWriteMask(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    fn __ne__(self, rhs: Self) -> Bool:
        return self.value != rhs.value

    fn __xor__(self, rhs: Self) -> Self:
        return Self(self.value ^ rhs.value)

    fn __and__(self, rhs: Self) -> Self:
        return Self(self.value & rhs.value)

    fn __or__(self, rhs: Self) -> Self:
        return Self(self.value | rhs.value)

    fn __invert__(self) -> Self:
        return Self(~self.value)

    alias none = Self(0)
    """TODO"""
    alias red = Self(1)
    """TODO"""
    alias green = Self(2)
    """TODO"""
    alias blue = Self(4)
    """TODO"""
    alias alpha = Self(8)
    """TODO"""
    alias all = Self.none | Self.red | Self.green | Self.blue | Self.alpha
    """TODO"""


@fieldwise_init
@register_passable("trivial")
struct MapMode(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    fn __ne__(self, rhs: Self) -> Bool:
        return self.value != rhs.value

    fn __xor__(self, rhs: Self) -> Self:
        return Self(self.value ^ rhs.value)

    fn __and__(self, rhs: Self) -> Self:
        return Self(self.value & rhs.value)

    fn __or__(self, rhs: Self) -> Self:
        return Self(self.value | rhs.value)

    fn __invert__(self) -> Self:
        return Self(~self.value)

    alias none = Self(0)
    """TODO"""
    alias read = Self(1)
    """TODO"""
    alias write = Self(2)
    """TODO"""


@fieldwise_init
@register_passable("trivial")
struct ShaderStage(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    fn __ne__(self, rhs: Self) -> Bool:
        return self.value != rhs.value

    fn __xor__(self, rhs: Self) -> Self:
        return Self(self.value ^ rhs.value)

    fn __and__(self, rhs: Self) -> Self:
        return Self(self.value & rhs.value)

    fn __or__(self, rhs: Self) -> Self:
        return Self(self.value | rhs.value)

    fn __invert__(self) -> Self:
        return Self(~self.value)

    alias none = Self(0)
    """TODO"""
    alias vertex = Self(1)
    """TODO"""
    alias fragment = Self(2)
    """TODO"""
    alias compute = Self(4)
    """TODO"""


@fieldwise_init
@register_passable("trivial")
struct TextureUsage(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    """
    TODO
    """
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    fn __ne__(self, rhs: Self) -> Bool:
        return self.value != rhs.value

    fn __xor__(self, rhs: Self) -> Self:
        return Self(self.value ^ rhs.value)

    fn __and__(self, rhs: Self) -> Self:
        return Self(self.value & rhs.value)

    fn __or__(self, rhs: Self) -> Self:
        return Self(self.value | rhs.value)

    fn __invert__(self) -> Self:
        return Self(~self.value)

    alias none = Self(0)
    """TODO"""
    alias copy_src = Self(1)
    """TODO"""
    alias copy_dst = Self(2)
    """TODO"""
    alias texture_binding = Self(4)
    """TODO"""
    alias storage_binding = Self(8)
    """TODO"""
    alias render_attachment = Self(16)
    """TODO"""


# WGPU SPECIFIC BITFLAGS

@fieldwise_init
struct InstanceBackend(Copyable, ImplicitlyCopyable, Movable, EqualityComparable):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    fn __xor__(self, rhs: Self) -> Self:
        return Self(self.value ^ rhs.value)

    fn __and__(self, rhs: Self) -> Self:
        return Self(self.value & rhs.value)

    fn __or__(self, rhs: Self) -> Self:
        return Self(self.value | rhs.value)

    fn __invert__(self) -> Self:
        return Self(~self.value)

    alias all = Self(0x00000000)
    alias vulkan = Self(1 << 0)
    alias gl = Self(1 << 1)
    alias metal = Self(1 << 2)
    alias dx12 = Self(1 << 3)
    alias dx11 = Self(1 << 4)
    alias browser_webgpu = Self(1 << 5)
    alias primary = Self.vulkan | Self.metal | Self.dx12 | Self.browser_webgpu
    alias secondary = Self.gl | Self.dx11


@fieldwise_init
struct InstanceFlag(Copyable, ImplicitlyCopyable, Movable, EqualityComparable):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    fn __xor__(self, rhs: Self) -> Self:
        return Self(self.value ^ rhs.value)

    fn __and__(self, rhs: Self) -> Self:
        return Self(self.value & rhs.value)

    fn __or__(self, rhs: Self) -> Self:
        return Self(self.value | rhs.value)

    fn __invert__(self) -> Self:
        return Self(~self.value)

    alias default = Self(0x00000000)
    alias debug = Self(1 << 0)
    alias validation = Self(1 << 1)
    alias discard_hal_labels = Self(1 << 2)


@fieldwise_init
struct Dx12Compiler(Copyable, ImplicitlyCopyable, Movable, EqualityComparable):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    fn __xor__(self, rhs: Self) -> Self:
        return Self(self.value ^ rhs.value)

    fn __and__(self, rhs: Self) -> Self:
        return Self(self.value & rhs.value)

    fn __or__(self, rhs: Self) -> Self:
        return Self(self.value | rhs.value)

    fn __invert__(self) -> Self:
        return Self(~self.value)

    alias undefined = Self(0x00000000)
    alias fxc = Self(0x00000001)
    alias dxc = Self(0x00000002)


@fieldwise_init
struct Gles3MinorVersion(Copyable, ImplicitlyCopyable, Movable, EqualityComparable):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    fn __xor__(self, rhs: Self) -> Self:
        return Self(self.value ^ rhs.value)

    fn __and__(self, rhs: Self) -> Self:
        return Self(self.value & rhs.value)

    fn __or__(self, rhs: Self) -> Self:
        return Self(self.value | rhs.value)

    fn __invert__(self) -> Self:
        return Self(~self.value)

    alias automatic = Self(0x00000000)
    alias version0 = Self(0x00000001)
    alias version1 = Self(0x00000002)
    alias version2 = Self(0x00000003)


@fieldwise_init
struct PipelineStatisticName(Copyable, ImplicitlyCopyable, Movable, EqualityComparable):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    fn __xor__(self, rhs: Self) -> Self:
        return Self(self.value ^ rhs.value)

    fn __and__(self, rhs: Self) -> Self:
        return Self(self.value & rhs.value)

    fn __or__(self, rhs: Self) -> Self:
        return Self(self.value | rhs.value)

    fn __invert__(self) -> Self:
        return Self(~self.value)

    alias vertex_shader_invocations = Self(0x00000000)
    alias clipper_invocations = Self(0x00000001)
    alias clipper_primitives_out = Self(0x00000002)
    alias fragment_shader_invocations = Self(0x00000003)
    alias compute_shader_invocations = Self(0x00000004)


@fieldwise_init
struct NativeQueryType(Copyable, ImplicitlyCopyable, Movable, EqualityComparable):
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value

    fn __xor__(self, rhs: Self) -> Self:
        return Self(self.value ^ rhs.value)

    fn __and__(self, rhs: Self) -> Self:
        return Self(self.value & rhs.value)

    fn __or__(self, rhs: Self) -> Self:
        return Self(self.value | rhs.value)

    fn __invert__(self) -> Self:
        return Self(~self.value)

    alias pipeline_statistics = Self(0x00030000)
