import enum
import json
import math
import sys
from dataclasses import dataclass
from itertools import filterfalse, tee
from pathlib import Path
from types import SimpleNamespace
from typing import Optional


def partition(predicate, iterable):
    """Partition entries into false entries and true entries.

    If *predicate* is slow, consider wrapping it with functools.lru_cache().
    """
    # partition(is_odd, range(10)) → 0 2 4 6 8   and  1 3 5 7 9
    t1, t2 = tee(iterable)
    return filterfalse(predicate, t1), filter(predicate, t2)


@dataclass
class Constant:
    name: str
    value: str
    doc: str


@dataclass
class Typedef:
    name: str
    doc: str
    type: str


@dataclass
class EnumEntry:
    name: str
    doc: str
    value: Optional[str]


@dataclass
class Enum:
    name: str
    doc: str
    entries: list[EnumEntry]
    extended: bool


@dataclass
class BitflagEntry:
    name: str
    doc: str
    value: str
    value_combination: list[str]


@dataclass
class Bitflag:
    name: str
    doc: str
    entries: list[BitflagEntry]
    extended: bool


class PointerType(enum.StrEnum):
    MUTABLE = "mutable"
    IMMUTABLE = "immutable"


@dataclass
class ParameterType:
    name: str
    doc: str
    type: str
    pointer: Optional[PointerType]
    optional: bool


@dataclass
class Callback:
    name: str
    doc: str
    style: str
    args: list[ParameterType]


@dataclass
class Function:
    name: str
    doc: str
    returns: ParameterType
    args: list[ParameterType]
    returns_async: list[ParameterType]


@dataclass
class Struct:
    name: str
    type: str
    doc: str
    free_members: bool
    members: list[ParameterType]


@dataclass
class Object:
    name: str
    doc: str
    methods: list[Function]
    extended: bool
    namespace: str


@dataclass
class Spec:
    copyright: str
    name: str
    enum_prefix: str
    constants: list[Constant]
    # currently empty
    typedefs: list[Typedef]
    enums: list[Enum]
    bitflags: list[Bitflag]
    structs: list[Struct]
    callbacks: list[Callback]
    functions: list[Function]
    objects: list[Object]
    function_types: list[Function]


def load_spec(path: Path) -> Spec:
    with open(path, "r") as f:
        return json.load(f, object_hook=lambda d: SimpleNamespace(**d))


def gen_enum(entry: Enum) -> str:
    output = f"""
@fieldwise_init
@register_passable("trivial")
struct {entry.name.title().replace("_", "")}(Copyable, EqualityComparable, ImplicitlyCopyable, Movable, Writable):
    \"\"\"
    {entry.doc.strip()}
    \"\"\"
    var value: UInt32

    fn __eq__(self, rhs: Self) -> Bool:
        return self.value == rhs.value
"""
    for i, e in enumerate(entry.entries):
        ename = e.name.lower()
        if entry.name == "texture_view_dimension" or entry.name == "texture_dimension":
            ename = ename[::-1]
        output += f"    alias {ename} = Self({e.value if hasattr(e, 'value') else i})\n"
        output += f'    """{e.doc.strip()}"""\n'
    output += """\n    fn write_to(self, mut w: Some[Writer]):\n"""
    for i, e in enumerate(entry.entries):
        ename = e.name.lower()
        if entry.name == "texture_view_dimension" or entry.name == "texture_dimension":
            ename = ename[::-1]
        output += f"""
        {"" if i == 0 else "el"}if self == Self.{ename}:
            w.write("{ename}")
"""

    return output


def gen_bitflag(entry: Bitflag) -> str:
    output = f"""
@fieldwise_init
@register_passable("trivial")
struct {entry.name.title().replace("_", "")}(Copyable, EqualityComparable, ImplicitlyCopyable, Movable):
    \"\"\"
    {entry.doc.strip()}
    \"\"\"
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

"""
    for i, e in enumerate(entry.entries):
        if hasattr(e, "value_combination"):
            combination = " | ".join(f"Self.{val}" for val in e.value_combination)
            output += f"    alias {e.name.lower()} = {combination}\n"
        else:
            output += f"    alias {e.name.lower()} = Self({int(math.pow(2, int(e.value) if hasattr(e, 'value') else i - 1))})\n"
        output += f'    """{e.doc.strip()}"""\n'
    return output


def gen_constant(entry: Constant) -> str:
    match entry.value:
        case "uint32_max":
            val = "UInt32.MAX"
        case "uint64_max":
            val = "UInt64.MAX"
        case "usize_max":
            val = "Int.MAX"
        case _:
            val = entry.value
    return f"""
alias {entry.name.upper()} = {val}
\"\"\"
{entry.doc.strip()}
\"\"\"
"""


def sanitize_name(
    name: str, object_pointer: bool = True, struct_pointer: bool = False
) -> str:
    if name.startswith("enum."):
        return name.removeprefix("enum.").title().replace("_", "")
    elif name.startswith("bitflag."):
        return name.removeprefix("bitflag.").title().replace("_", "")
    elif name.startswith("struct."):
        if struct_pointer:
            n = name.removeprefix("struct.").title().replace("_", "")
            return f"UnsafePointer[WGPU{n}]"
        else:
            return "WGPU" + name.removeprefix("struct.").title().replace("_", "")
    elif name.startswith("function_type."):
        return name.removeprefix("function_type.").title().replace("_", "")
    elif name.startswith("object."):
        if object_pointer:
            n = name.removeprefix("object.").title().replace("_", "")
            return f"WGPU{n}"
        else:
            return name.removeprefix("object.").title().replace("_", "")
    elif name == "string":
        return "UnsafePointer[Int8]"
    elif name == "uint32":
        return "UInt32"
    elif name == "uint16":
        return "UInt16"
    elif name == "int16":
        return "Int16"
    elif name == "uint64":
        return "UInt64"
    elif name == "int32":
        return "Int32"
    elif name == "int64":
        return "Int64"
    elif name == "bool":
        return "Bool"
    elif name == "float32":
        return "Float32"
    elif name == "float64":
        return "Float64"
    elif name == "usize":
        return "Int"
    elif name == "c_void":
        return "UnsafePointer[NoneType]"
    else:
        return name


def gen_parameter_type(
    entry: ParameterType,
    *,
    default_assign: bool = False,
    type_only: bool = False,
    object_pointer: bool = True,
    struct_pointer: bool = False,
    in_function: bool = False,
) -> str:
    ty = sanitize_name(
        entry.type, object_pointer=object_pointer, struct_pointer=struct_pointer
    )
    if hasattr(entry, "pointer"):
        if "array<" in entry.type:
            ty = sanitize_name(
                entry.type.removeprefix("array<").removesuffix(">"),
                object_pointer=object_pointer,
                struct_pointer=struct_pointer,
            )
            # ty = f"Span[{ty}]"
            ty = f"UnsafePointer[{ty}]"
        else:
            ty = f"{ty}"
    if type_only:
        if in_function and entry.type.startswith("array<"):
            return f"Int32, {ty}"
        return ty
    res = f"""{entry.name}: {ty}"""
    if in_function and entry.type.startswith("array<"):
        res = f"{entry.name[:-1]}_count: Int{' = Int()' if hasattr(entry, 'optional') else ''}, {res}"
    if hasattr(entry, "optional") and default_assign:
        res = f"{res} = {ty}()"
    return res


def gen_function(
    entry: Function,
    contains_self: bool = False,
    type: Optional[str] = None,
    prefix: Optional[str] = None,
) -> str:
    args = entry.args if hasattr(entry, "args") else []
    args_ordered = partition(lambda x: hasattr(x, "optional"), args)
    params_pre_opt = ", ".join(
        gen_parameter_type(e, default_assign=True, in_function=True)
        for e in args_ordered[0]
    )
    params_post_opt = ", ".join(
        gen_parameter_type(e, default_assign=True, in_function=True)
        for e in args_ordered[1]
    )
    params_no_default = ", ".join(
        gen_parameter_type(e, type_only=True, struct_pointer=True, in_function=True)
        for e in args
    )

    if hasattr(entry, "returns_async"):
        ret_async = entry.returns_async
        if args:
            params_no_default += ","
        cb_params = ", ".join(
            gen_parameter_type(
                e,
                default_assign=True,
                type_only=True,
                struct_pointer=True,
                in_function=True,
            )
            for e in ret_async
        )
        cb_params += ", UnsafePointer[NoneType]"
        cb_params_arg = ", ".join(
            gen_parameter_type(
                e,
                default_assign=True,
                object_pointer=True,
                type_only=True,
                struct_pointer=True,
                in_function=True,
            )
            for e in ret_async
        )
        cb_params_arg += ", UnsafePointer[NoneType]"
        params_no_default += f"fn({cb_params}) -> None, UnsafePointer[NoneType]"
        params = ", ".join(
            a
            for a in [
                params_pre_opt,
                f"callback: fn({cb_params_arg}) -> None, user_data: UnsafePointer[NoneType]",
                params_post_opt,
            ]
            if a
        )
    else:
        params = ", ".join(a for a in [params_pre_opt, params_post_opt] if a)
        ret_async = None

    if contains_self:
        params = f"handle: WGPU{type}, {params}"
        if type:
            params_no_default = f"WGPU{type}, {params_no_default}"
    try:
        ret = gen_parameter_type(entry.returns, type_only=True, object_pointer=True)
        ret_ptr = gen_parameter_type(entry.returns, type_only=True, object_pointer=True)
    except:
        ret = "None"
        ret_ptr = "None"
    call_args = ", ".join(
        f"UnsafePointer(to={e.name})"
        if e.type.startswith("struct")
        else (
            f"{e.name[:-1]}_count, {e.name}" if e.type.startswith("array<") else e.name
        )
        for e in args
    )
    if contains_self:
        call_args = f"handle, {call_args}"
    if ret_async:
        if args:
            call_args += ","
        call_args += "callback, user_data"
    return f"""
fn {prefix + "_" if prefix else ""}{entry.name}({params}) -> {ret}:
    \"\"\"
    {entry.doc.strip()}
    \"\"\"
    {"return" if ret != "None" else "_ = "} external_call["wgpu{type or ""}{entry.name.title().replace("_", "")}", {ret if ret != "None" else "NoneType"}, {params_no_default}]({call_args})
"""


def gen_callback(entry: Callback):
    args = entry.args if hasattr(entry, "args") else []
    params_no_default = ", ".join(
        gen_parameter_type(e, type_only=True, in_function=True) for e in args
    )
    call_args = ", ".join(e.name for e in args)
    return f"\nalias {entry.name}_callback = fn({params_no_default}) -> None\n"


def gen_object(entry: Object) -> str:
    name = entry.name.title().replace("_", "")
    output = f"""
struct _{name}Impl:
    pass
alias WGPU{name} = UnsafePointer[_{name}Impl]

fn {entry.name}_release(handle: WGPU{name}):
    _ = external_call["wgpu{name}Release", NoneType, UnsafePointer[_{name}Impl]](handle)
"""
    for method in entry.methods:
        output += gen_function(method, type=name, contains_self=True, prefix=entry.name)
    return output


def gen_struct(entry: Struct) -> str:
    output = f"""
struct WGPU{entry.name.title().replace("_", "")}(Copyable, ImplicitlyCopyable, Movable):
    \"\"\"
    {entry.doc.strip()}
    \"\"\"
"""
    if entry.type == "base_in":
        output += "    var next_in_chain: UnsafePointer[ChainedStruct]\n"
    elif entry.type == "base_out":
        output += "    var next_in_chain: UnsafePointer[ChainedStructOut]\n"
    elif entry.type == "extension_in":
        output += "    var chain: ChainedStruct\n"
    elif entry.type == "extension_out":
        output += "    var chain: ChainedStructOut\n"
    members = entry.members if hasattr(entry, "members") else []
    for member in members:
        if member.type.startswith("function_type."):
            output += f"    var {member.name}: UnsafePointer[NoneType]\n"
        elif member.type.startswith("array<"):
            output += f"    var {member.name[:-1]}_count: Int\n"
            output += f"    var {gen_parameter_type(member, struct_pointer=False)}\n"
        else:
            output += f"    var {gen_parameter_type(member, struct_pointer=hasattr(member, 'pointer'))}\n"
    output += "\n    fn __init__(out self,\n"
    if entry.type == "base_in":
        output += "        next_in_chain: UnsafePointer[ChainedStruct] = {},\n"
    elif entry.type == "base_out":
        output += "        next_in_chain: UnsafePointer[ChainedStructOut] = {},\n"
    elif entry.type == "extension_in":
        output += "        chain: ChainedStruct = {},\n"
    elif entry.type == "extension_out":
        output += "        chain: ChainedStructOut = {}\n"
    for member in members:
        if member.type.startswith("enum.") or member.type.startswith("bitflag."):
            ty = gen_parameter_type(member, type_only=True)
            output += f"\n        {member.name}: {ty} = {ty}(0),\n"
        elif member.type == "bool":
            output += f"\n        {member.name}: Bool = False,"
        elif member.type.startswith("function_type."):
            output += f"\n        {member.name}: UnsafePointer[NoneType] = {{}},\n"
        elif member.type.startswith("array<"):
            ty = gen_parameter_type(member, type_only=True, struct_pointer=False)
            output += f"\n        {member.name[:-1]}_count: Int = Int(),\n"
            output += f"\n        {member.name}: {ty} = {ty}(),\n"
        else:
            ty = gen_parameter_type(
                member, type_only=True, struct_pointer=hasattr(member, "pointer")
            )
            owned = (
                "var "
                if member.type.startswith("struct.") and not hasattr(member, "pointer")
                else ""
            )
            output += f"\n        {owned}{member.name}: {ty} = {{}},\n"
    output += "    ):\n"
    if entry.type == "base_in":
        output += "        self.next_in_chain = next_in_chain\n"
    elif entry.type == "base_out":
        output += "        self.next_in_chain = next_in_chain\n"
    elif entry.type == "extension_in":
        output += "        self.chain = chain\n"
    elif entry.type == "extension_out":
        output += "        self.chain = chain\n"
    for member in members:
        take = (
            "^"
            if member.type.startswith("struct") and not hasattr(member, "pointer")
            else ""
        )
        if member.type.startswith("array<"):
            output += (
                f"        self.{member.name[:-1]}_count = {member.name[:-1]}_count\n"
            )
        output += f"        self.{member.name} = {member.name}{take}\n"

    return output


def gen_function_type(entry: Function) -> str:
    cb_params_arg = ", ".join(
        gen_parameter_type(
            e,
            default_assign=True,
            object_pointer=True,
            type_only=True,
            struct_pointer=True,
        )
        for e in entry.args
    )
    cb_params_arg += ", UnsafePointer[NoneType]"
    return (
        f"alias {entry.name.title().replace('_', '')} = fn({cb_params_arg}) -> None\n"
    )


if __name__ == "__main__":
    spec_path = Path.cwd() / (sys.argv[1])
    spec = load_spec(spec_path)
    enums = "\n".join(gen_enum(e) for e in spec.enums)
    enums += """

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
"""
    with open("wgpu/enums.mojo", "w+") as f:
        f.write(enums)
    structs = "\n".join(gen_struct(e) for e in spec.structs)
    bitflags = "\n".join(gen_bitflag(e) for e in spec.bitflags)
    bitflags += """

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
"""
    with open("wgpu/bitflags.mojo", "w+") as f:
        f.write(bitflags)
    constants = "\n".join(gen_constant(e) for e in spec.constants)
    with open("wgpu/constants.mojo", "w+") as f:
        f.write(constants)
    functions = "\n".join(gen_function(e) for e in spec.functions)
    objects = "\n".join(gen_object(e) for e in spec.objects)
    function_types = "\n".join(gen_function_type(e) for e in spec.function_types)
    output = """
from sys.ffi import external_call
from .enums import *
from .bitflags import *
from .constants import *


struct ChainedStruct(Copyable, ImplicitlyCopyable, Movable):
    var next: UnsafePointer[Self]
    var s_type: SType

    fn __init__(out self, next: UnsafePointer[Self] = UnsafePointer[Self](), s_type: SType = SType.invalid):
        self.next = next
        self.s_type = s_type

struct ChainedStructOut(Copyable, ImplicitlyCopyable, Movable):
    var next: UnsafePointer[Self]
    var s_type: SType

    fn __init__(out self, next: UnsafePointer[Self] = UnsafePointer[Self](), s_type: SType = SType.invalid):
        self.next = next
        self.s_type = s_type
"""
    output += "\n".join([objects, structs, functions, function_types])
    output += """

# WGPU SPECIFIC DEFS

struct WGPUInstanceExtras(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var backends: InstanceBackend
    var flags: InstanceFlag
    var dx12_shader_compiler: Dx12Compiler
    var gl_es_3_minor_version: Gles3MinorVersion
    var dxil_path: UnsafePointer[Int8]
    var dxc_path: UnsafePointer[Int8]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        backends: InstanceBackend = InstanceBackend.all,
        flags: InstanceFlag = InstanceFlag.default,
        dx12_shader_compiler: Dx12Compiler = Dx12Compiler.undefined,
        gl_es_3_minor_version: Gles3MinorVersion = Gles3MinorVersion.automatic,
        dxil_path: UnsafePointer[Int8] = UnsafePointer[Int8](),
        dxc_path: UnsafePointer[Int8] = UnsafePointer[Int8](),
    ):
        self.chain = chain
        self.backends = backends
        self.flags = flags
        self.dx12_shader_compiler = dx12_shader_compiler
        self.gl_es_3_minor_version = gl_es_3_minor_version
        self.dxil_path = dxil_path
        self.dxc_path = dxc_path


struct WGPUDeviceExtras(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var trace_path: UnsafePointer[Int8]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        trace_path: UnsafePointer[Int8] = UnsafePointer[Int8](),
    ):
        self.chain = chain
        self.trace_path = trace_path


struct WGPUNativeLimits(Copyable, ImplicitlyCopyable, Movable):
    var max_push_constant_size: UInt32
    var max_non_sampler_bindings: UInt32

    fn __init__(
        out self,
        max_push_constant_size: UInt32 = 0,
        max_non_sampler_bindings: UInt32 = 0,
    ):
        self.max_push_constant_size = max_push_constant_size
        self.max_non_sampler_bindings = max_non_sampler_bindings


struct WGPURequiredLimitsExtras(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var limits: WGPUNativeLimits

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        limits: WGPUNativeLimits = WGPUNativeLimits(),
    ):
        self.chain = chain
        self.limits = limits


struct WGPUSupportedLimitsExtras(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var limits: WGPUNativeLimits

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        limits: WGPUNativeLimits = WGPUNativeLimits(),
    ):
        self.chain = chain
        self.limits = limits


struct WGPUPushConstantRange(Copyable, ImplicitlyCopyable, Movable):
    var stages: ShaderStage
    var start: UInt32
    var end: UInt32

    fn __init__(
        out self,
        stages: ShaderStage = ShaderStage.none,
        start: UInt32 = 0,
        end: UInt32 = 0,
    ):
        self.stages = stages
        self.start = start
        self.end = end


struct WGPUPipelineLayoutExtras(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var push_constant_range_count: Int
    var push_constant_ranges: UnsafePointer[WGPUPushConstantRange]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        push_constant_range_count: Int = 0,
        push_constant_ranges: UnsafePointer[
            WGPUPushConstantRange
        ] = UnsafePointer[WGPUPushConstantRange](),
    ):
        self.chain = chain
        self.push_constant_range_count = push_constant_range_count
        self.push_constant_ranges = push_constant_ranges


alias WGPUSubmissionIndex = UInt64


struct WGPUWrappedSubmissionIndex(Copyable, ImplicitlyCopyable, Movable):
    var queue: WGPUQueue
    var submission_index: WGPUSubmissionIndex

    fn __init__(
        out self,
        queue: WGPUQueue = WGPUQueue(),
        submission_index: WGPUSubmissionIndex = WGPUSubmissionIndex(),
    ):
        self.queue = queue
        self.submission_index = submission_index


struct WGPUShaderDefine(Copyable, ImplicitlyCopyable, Movable):
    var name: UnsafePointer[Int8]
    var value: UnsafePointer[Int8]

    fn __init__(
        out self,
        name: UnsafePointer[Int8] = UnsafePointer[Int8](),
        value: UnsafePointer[Int8] = UnsafePointer[Int8](),
    ):
        self.name = name
        self.value = value


struct WGPUShaderModuleGLSLDescriptor(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var stage: ShaderStage
    var code: UnsafePointer[Int8]
    var define_count: UInt32
    var defines: UnsafePointer[WGPUShaderDefine]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        stage: ShaderStage = ShaderStage.none,
        code: UnsafePointer[Int8] = UnsafePointer[Int8](),
        define_count: UInt32 = 0,
        defines: UnsafePointer[WGPUShaderDefine] = UnsafePointer[
            WGPUShaderDefine
        ](),
    ):
        self.chain = chain
        self.stage = stage
        self.code = code
        self.define_count = define_count
        self.defines = defines


struct WGPURegistryReport(Copyable, ImplicitlyCopyable, Movable):
    var num_allocated: Int
    var num_kept_from_user: Int
    var num_released_from_user: Int
    var num_error: Int
    var element_size: Int

    fn __init__(
        out self,
        num_allocated: Int = 0,
        num_kept_from_user: Int = 0,
        num_released_from_user: Int = 0,
        num_error: Int = 0,
        element_size: Int = 0,
    ):
        self.num_allocated = num_allocated
        self.num_kept_from_user = num_kept_from_user
        self.num_released_from_user = num_released_from_user
        self.num_error = num_error
        self.element_size = element_size


struct WGPUHubReport(Copyable, ImplicitlyCopyable, Movable):
    var adapters: WGPURegistryReport
    var devices: WGPURegistryReport
    var queues: WGPURegistryReport
    var pipeline_layouts: WGPURegistryReport
    var shader_modules: WGPURegistryReport
    var bind_group_layouts: WGPURegistryReport
    var bind_groups: WGPURegistryReport
    var command_buffers: WGPURegistryReport
    var render_bundles: WGPURegistryReport
    var render_pipelines: WGPURegistryReport
    var compute_pipelines: WGPURegistryReport
    var query_sets: WGPURegistryReport
    var buffers: WGPURegistryReport
    var textures: WGPURegistryReport
    var texture_views: WGPURegistryReport
    var samplers: WGPURegistryReport

    fn __init__(
        out self,
        adapters: WGPURegistryReport = WGPURegistryReport(),
        devices: WGPURegistryReport = WGPURegistryReport(),
        queues: WGPURegistryReport = WGPURegistryReport(),
        pipeline_layouts: WGPURegistryReport = WGPURegistryReport(),
        shader_modules: WGPURegistryReport = WGPURegistryReport(),
        bind_group_layouts: WGPURegistryReport = WGPURegistryReport(),
        bind_groups: WGPURegistryReport = WGPURegistryReport(),
        command_buffers: WGPURegistryReport = WGPURegistryReport(),
        render_bundles: WGPURegistryReport = WGPURegistryReport(),
        render_pipelines: WGPURegistryReport = WGPURegistryReport(),
        compute_pipelines: WGPURegistryReport = WGPURegistryReport(),
        query_sets: WGPURegistryReport = WGPURegistryReport(),
        buffers: WGPURegistryReport = WGPURegistryReport(),
        textures: WGPURegistryReport = WGPURegistryReport(),
        texture_views: WGPURegistryReport = WGPURegistryReport(),
        samplers: WGPURegistryReport = WGPURegistryReport(),
    ):
        self.adapters = adapters
        self.devices = devices
        self.queues = queues
        self.pipeline_layouts = pipeline_layouts
        self.shader_modules = shader_modules
        self.bind_group_layouts = bind_group_layouts
        self.bind_groups = bind_groups
        self.command_buffers = command_buffers
        self.render_bundles = render_bundles
        self.render_pipelines = render_pipelines
        self.compute_pipelines = compute_pipelines
        self.query_sets = query_sets
        self.buffers = buffers
        self.textures = textures
        self.texture_views = texture_views
        self.samplers = samplers


struct WGPUGlobalReport(Copyable, ImplicitlyCopyable, Movable):
    var surfaces: WGPURegistryReport
    var backend_type: BackendType
    var vulkan: WGPUHubReport
    var metal: WGPUHubReport
    var dx12: WGPUHubReport
    var gl: WGPUHubReport

    fn __init__(
        out self,
        surfaces: WGPURegistryReport = WGPURegistryReport(),
        backend_type: BackendType = BackendType.undefined,
        vulkan: WGPUHubReport = WGPUHubReport(),
        metal: WGPUHubReport = WGPUHubReport(),
        dx12: WGPUHubReport = WGPUHubReport(),
        gl: WGPUHubReport = WGPUHubReport(),
    ):
        self.surfaces = surfaces
        self.backend_type = backend_type
        self.vulkan = vulkan
        self.metal = metal
        self.dx12 = dx12
        self.gl = gl


struct WGPUInstanceEnumerateAdapterOptions(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var backends: InstanceBackend

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        backends: InstanceBackend = InstanceBackend.all,
    ):
        self.chain = chain
        self.backends = backends


struct WGPUBindGroupEntryExtras(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var buffers: UnsafePointer[WGPUBuffer]
    var buffer_count: Int
    var samplers: UnsafePointer[WGPUSampler]
    var sampler_count: Int
    var texture_views: UnsafePointer[WGPUTextureView]
    var texture_view_count: Int

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        buffers: UnsafePointer[WGPUBuffer] = UnsafePointer[WGPUBuffer](),
        buffer_count: Int = 0,
        samplers: UnsafePointer[WGPUSampler] = UnsafePointer[WGPUSampler](),
        sampler_count: Int = 0,
        texture_views: UnsafePointer[WGPUTextureView] = UnsafePointer[
            WGPUTextureView
        ](),
        texture_view_count: Int = 0,
    ):
        self.chain = chain
        self.buffers = buffers
        self.buffer_count = buffer_count
        self.samplers = samplers
        self.sampler_count = sampler_count
        self.texture_views = texture_views
        self.texture_view_count = texture_view_count


struct WGPUBindGroupLayoutEntryExtras(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var count: UInt32

    fn __init__(
        out self, chain: ChainedStruct = ChainedStruct(), count: UInt32 = 0
    ):
        self.chain = chain
        self.count = count


struct WGPUQuerySetDescriptorExtras(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var pipeline_statistics: UnsafePointer[PipelineStatisticName]
    var pipeline_statistics_count: Int

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        pipeline_statistics: UnsafePointer[
            PipelineStatisticName
        ] = UnsafePointer[PipelineStatisticName](),
        pipeline_statistics_count: Int = 0,
    ):
        self.chain = chain
        self.pipeline_statistics = pipeline_statistics
        self.pipeline_statistics_count = pipeline_statistics_count


struct WGPUSurfaceConfigurationExtras(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var desired_maximum_frame_latency: UInt32

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        desired_maximum_frame_latency: UInt32 = 0,
    ):
        self.chain = chain
        self.desired_maximum_frame_latency = desired_maximum_frame_latency


alias WGPULogCallback = fn (
    level: LogLevel,
    message: UnsafePointer[Int8],
    userdata: UnsafePointer[NoneType],
) -> None


fn generate_report(instance: WGPUInstance, report: UnsafePointer[WGPUGlobalReport]):
    external_call[
        "wgpuGenerateReport",
        NoneType,
        WGPUInstance, UnsafePointer[WGPUGlobalReport]
    ](instance, report)


fn instance_enumerate_adapters(
    instance: WGPUInstance,
    options: UnsafePointer[WGPUInstanceEnumerateAdapterOptions],
    adapters: UnsafePointer[WGPUAdapter],
) -> Int:
    return external_call[
        "wgpuInstanceEnumerateAdapters",
        Int,
        WGPUInstance,
        UnsafePointer[WGPUInstanceEnumerateAdapterOptions],
        UnsafePointer[WGPUAdapter],
    ](
        instance, options, adapters
    )


fn queue_submit_for_index(
    queue: WGPUQueue,
    command_count: Int,
    commands: UnsafePointer[WGPUCommandBuffer],
) -> WGPUSubmissionIndex:
    return external_call[
        "wgpuQueueSubmitForIndex",
        WGPUSubmissionIndex,
        WGPUQueue,
        Int,
        UnsafePointer[WGPUCommandBuffer],
    ](queue, command_count, commands)


fn device_poll(
    device: WGPUDevice,
    wait: Bool = False,
    wrapped_submission_index: UnsafePointer[WGPUWrappedSubmissionIndex] = {},
) -> Bool:
    \"\"\"Returns true if the queue is empty, or false if there are more queue submissions still in flight.
    \"\"\"
    return external_call[
        "wgpuDevicePoll",
        Bool,
        WGPUDevice,
        Bool,
        UnsafePointer[WGPUWrappedSubmissionIndex]
    ](
        device,
        wait,
        wrapped_submission_index,
    )


fn set_log_callback(
    callback: WGPULogCallback, userdata: UnsafePointer[NoneType]
):
    _ = external_call[
        "wgpuSetLogCallback",
        NoneType,
        WGPULogCallback,
        UnsafePointer[NoneType]
    ](callback, userdata)


fn set_log_level(level: LogLevel):
    _ = external_call["wgpuSetLogLevel", NoneType, Int](level.value)


fn get_version() -> UInt32:
    return external_call["wgpuGetVersion", UInt32]()


fn render_pass_encoder_set_push_constants(
    encoder: WGPURenderPassEncoder,
    stages: ShaderStage,
    offset: UInt32,
    size_bytes: UInt32,
    data: UnsafePointer[NoneType],
):
    _ = external_call[
        "wgpuRenderPassEncoderSetPushConstants",
        NoneType,
        WGPURenderPassEncoder,
        ShaderStage,
        UInt32,
        UInt32,
        UnsafePointer[NoneType],
    ](
        encoder, stages, offset, size_bytes, data
    )


fn render_pass_encoder_multi_draw_indirect(
    encoder: WGPURenderPassEncoder,
    buffer: WGPUBuffer,
    offset: UInt64,
    count: UInt32,
):
    _ = external_call[
        "wgpuRenderPassEncoderMultiDrawIndirect",
        NoneType,
        WGPURenderPassEncoder,
        WGPUBuffer,
        UInt64,
        UInt32,
    ](encoder, buffer, offset, count)


fn render_pass_encoder_multi_draw_indexed_indirect(
    encoder: WGPURenderPassEncoder,
    buffer: WGPUBuffer,
    offset: UInt64,
    count: UInt32,
):
    _ = external_call[
        "wgpuRenderPassEncoderMultiDrawIndexedIndirect",
        NoneType,
        WGPURenderPassEncoder,
        WGPUBuffer,
        UInt64,
        UInt32,
    ](
        encoder, buffer, offset, count
    )


fn render_pass_encoder_multi_draw_indirect_count(
    encoder: WGPURenderPassEncoder,
    buffer: WGPUBuffer,
    offset: UInt64,
    count_buffer: WGPUBuffer,
    count_buffer_offset: UInt64,
    max_count: UInt32,
):
    _ = external_call[
        "wgpuRenderPassEncoderMultiDrawIndirectCount",
        NoneType,
        WGPURenderPassEncoder,
        WGPUBuffer,
        UInt64,
        WGPUBuffer,
        UInt64,
        UInt32,
    ](
        encoder, buffer, offset, count_buffer, count_buffer_offset, max_count
    )


fn render_pass_encoder_multi_draw_indexed_indirect_count(
    encoder: WGPURenderPassEncoder,
    buffer: WGPUBuffer,
    offset: UInt64,
    count_buffer: WGPUBuffer,
    count_buffer_offset: UInt64,
    max_count: UInt32,
):
    _ = external_call[
        "wgpuRenderPassEncoderMultiDrawIndexedIndirectCount",
        NoneType,
        WGPURenderPassEncoder,
        WGPUBuffer,
        UInt64,
        WGPUBuffer,
        UInt64,
        UInt32,
    ](
        encoder, buffer, offset, count_buffer, count_buffer_offset, max_count
    )


fn compute_pass_encoder_begin_pipeline_statistics_query(
    compute_pass_encoder: WGPUComputePassEncoder,
    query_set: WGPUQuerySet,
    query_index: UInt32,
):
    _ = external_call[
        "wgpuComputePassEncoderBeginPipelineStatisticsQuery",
        NoneType, WGPUComputePassEncoder, WGPUQuerySet, UInt32
    ](
        compute_pass_encoder, query_set, query_index
    )


fn compute_pass_encoder_end_pipeline_statistics_query(
    compute_pass_encoder: WGPUComputePassEncoder,
):
    _ = external_call[
        "wgpuComputePassEncoderEndPipelineStatisticsQuery",
        NoneType,
        WGPUComputePassEncoder
    ](compute_pass_encoder)


fn render_pass_encoder_begin_pipeline_statistics_query(
    render_pass_encoder: WGPURenderPassEncoder,
    query_set: WGPUQuerySet,
    query_index: UInt32,
):
    _ = external_call[
        "wgpuRenderPassEncoderBeginPipelineStatisticsQuery",
        NoneType,
        WGPURenderPassEncoder,
        WGPUQuerySet,
        UInt32,
    ](
        render_pass_encoder, query_set, query_index
    )


fn render_pass_encoder_end_pipeline_statistics_query(
    render_pass_encoder: WGPURenderPassEncoder,
):
    _ = external_call[
        "wgpuRenderPassEncoderEndPipelineStatisticsQuery",
        NoneType,
        WGPURenderPassEncoder
    ](render_pass_encoder)

fn surface_capabilities_free_members(capabilities: UnsafePointer[WGPUSurfaceCapabilities]):
   external_call["wgpuSurfaceCapabilitiesFreeMembers", NoneType, UnsafePointer[WGPUSurfaceCapabilities]](capabilities)
"""

    with open("wgpu/_cffi.mojo", "w+") as f:
        f.write(output)
