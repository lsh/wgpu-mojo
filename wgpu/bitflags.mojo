@fieldwise_init
@register_passable("trivial")
struct BufferUsage(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
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

    comptime none = Self(0)
    comptime map_read = Self(1)
    comptime map_write = Self(2)
    comptime copy_src = Self(4)
    comptime copy_dst = Self(8)
    comptime index = Self(16)
    comptime vertex = Self(32)
    comptime uniform = Self(64)
    comptime storage = Self(128)
    comptime indirect = Self(256)
    comptime query_resolve = Self(512)


@fieldwise_init
@register_passable("trivial")
struct ColorWriteMask(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable
):
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

    comptime none = Self(0)
    comptime red = Self(1)
    comptime green = Self(2)
    comptime blue = Self(4)
    comptime alpha = Self(8)
    comptime all = Self.none | Self.red | Self.green | Self.blue | Self.alpha


@fieldwise_init
@register_passable("trivial")
struct MapMode(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
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

    comptime none = Self(0)
    comptime read = Self(1)
    comptime write = Self(2)


@fieldwise_init
@register_passable("trivial")
struct ShaderStage(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
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

    comptime none = Self(0)
    comptime vertex = Self(1)
    comptime fragment = Self(2)
    comptime compute = Self(4)


@fieldwise_init
@register_passable("trivial")
struct TextureUsage(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
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

    comptime none = Self(0)
    comptime copy_src = Self(1)
    comptime copy_dst = Self(2)
    comptime texture_binding = Self(4)
    comptime storage_binding = Self(8)
    comptime render_attachment = Self(16)


# WGPU SPECIFIC BITFLAGS


@fieldwise_init
struct InstanceBackend(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable
):
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

    comptime all = Self(0x00000000)
    comptime vulkan = Self(1 << 0)
    comptime gl = Self(1 << 1)
    comptime metal = Self(1 << 2)
    comptime dx12 = Self(1 << 3)
    comptime dx11 = Self(1 << 4)
    comptime browser_webgpu = Self(1 << 5)
    comptime primary = Self.vulkan | Self.metal | Self.dx12 | Self.browser_webgpu
    comptime secondary = Self.gl | Self.dx11


@fieldwise_init
struct InstanceFlag(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
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

    comptime default = Self(0x00000000)
    comptime debug = Self(1 << 0)
    comptime validation = Self(1 << 1)
    comptime discard_hal_labels = Self(1 << 2)


@fieldwise_init
struct Dx12Compiler(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
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

    comptime undefined = Self(0x00000000)
    comptime fxc = Self(0x00000001)
    comptime dxc = Self(0x00000002)


@fieldwise_init
struct Gles3MinorVersion(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable
):
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

    comptime automatic = Self(0x00000000)
    comptime version0 = Self(0x00000001)
    comptime version1 = Self(0x00000002)
    comptime version2 = Self(0x00000003)


@fieldwise_init
struct PipelineStatisticName(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable
):
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

    comptime vertex_shader_invocations = Self(0x00000000)
    comptime clipper_invocations = Self(0x00000001)
    comptime clipper_primitives_out = Self(0x00000002)
    comptime fragment_shader_invocations = Self(0x00000003)
    comptime compute_shader_invocations = Self(0x00000004)


@fieldwise_init
struct NativeQueryType(
    Copyable, EqualityComparable, ImplicitlyCopyable, Movable
):
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

    comptime pipeline_statistics = Self(0x00030000)
