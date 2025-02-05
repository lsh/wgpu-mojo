from sys import ffi
from memory import Span, UnsafePointer
from .enums import *
from .bitflags import *
from .constants import *

var _wgpu = ffi.DLHandle("libwgpu_native.dylib", ffi.RTLD.LAZY)
from memory import UnsafePointer


@value
struct ChainedStruct:
    var next: UnsafePointer[Self]
    var s_type: SType

    fn __init__(
        out self,
        next: UnsafePointer[Self] = UnsafePointer[Self](),
        s_type: SType = SType.invalid,
    ):
        self.next = next
        self.s_type = s_type


@value
struct ChainedStructOut:
    var next: UnsafePointer[Self]
    var s_type: SType

    fn __init__(
        out self,
        next: UnsafePointer[Self] = UnsafePointer[Self](),
        s_type: SType = SType.invalid,
    ):
        self.next = next
        self.s_type = s_type


struct _AdapterImpl:
    pass


alias WGPUAdapter = UnsafePointer[_AdapterImpl]


fn adapter_release(handle: WGPUAdapter):
    _wgpu.get_function[fn (UnsafePointer[_AdapterImpl]) -> None](
        "wgpuAdapterRelease"
    )(handle)


var _wgpuAdapterGetLimits = _wgpu.get_function[
    fn (WGPUAdapter, UnsafePointer[WGPUSupportedLimits]) -> Bool
]("wgpuAdapterGetLimits")


fn adapter_get_limits(handle: WGPUAdapter, limits: WGPUSupportedLimits) -> Bool:
    """
    TODO
    """
    return _wgpuAdapterGetLimits(handle, UnsafePointer.address_of(limits))


var _wgpuAdapterHasFeature = _wgpu.get_function[
    fn (WGPUAdapter, FeatureName) -> Bool
]("wgpuAdapterHasFeature")


fn adapter_has_feature(handle: WGPUAdapter, feature: FeatureName) -> Bool:
    """
    TODO
    """
    return _wgpuAdapterHasFeature(handle, feature)


var _wgpuAdapterEnumerateFeatures = _wgpu.get_function[
    fn (WGPUAdapter, FeatureName) -> UInt
]("wgpuAdapterEnumerateFeatures")


fn adapter_enumerate_features(
    handle: WGPUAdapter, features: FeatureName
) -> UInt:
    """
    TODO
    """
    return _wgpuAdapterEnumerateFeatures(handle, features)


var _wgpuAdapterGetInfo = _wgpu.get_function[
    fn (WGPUAdapter, UnsafePointer[WGPUAdapterInfo]) -> None
]("wgpuAdapterGetInfo")


fn adapter_get_info(handle: WGPUAdapter, info: WGPUAdapterInfo) -> None:
    """
    TODO
    """
    return _wgpuAdapterGetInfo(handle, UnsafePointer.address_of(info))


var _wgpuAdapterRequestDevice = _wgpu.get_function[
    fn (
        WGPUAdapter,
        UnsafePointer[WGPUDeviceDescriptor],
        fn (
            RequestDeviceStatus,
            WGPUDevice,
            UnsafePointer[Int8],
            UnsafePointer[NoneType],
        ) -> None,
        UnsafePointer[NoneType],
    ) -> None
]("wgpuAdapterRequestDevice")


fn adapter_request_device(
    handle: WGPUAdapter,
    callback: fn (
        RequestDeviceStatus,
        WGPUDevice,
        UnsafePointer[Int8],
        UnsafePointer[NoneType],
    ) -> None,
    user_data: UnsafePointer[NoneType],
    descriptor: WGPUDeviceDescriptor = WGPUDeviceDescriptor(),
) -> None:
    """
    TODO
    """
    return _wgpuAdapterRequestDevice(
        handle, UnsafePointer[WGPUDeviceDescriptor](), callback, user_data
    )


struct _BindGroupImpl:
    pass


alias WGPUBindGroup = UnsafePointer[_BindGroupImpl]


fn bind_group_release(handle: WGPUBindGroup):
    _wgpu.get_function[fn (UnsafePointer[_BindGroupImpl]) -> None](
        "wgpuBindGroupRelease"
    )(handle)


var _wgpuBindGroupSetLabel = _wgpu.get_function[
    fn (WGPUBindGroup, UnsafePointer[Int8]) -> None
]("wgpuBindGroupSetLabel")


fn bind_group_set_label(
    handle: WGPUBindGroup, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuBindGroupSetLabel(handle, label)


struct _BindGroupLayoutImpl:
    pass


alias WGPUBindGroupLayout = UnsafePointer[_BindGroupLayoutImpl]


fn bind_group_layout_release(handle: WGPUBindGroupLayout):
    _wgpu.get_function[fn (UnsafePointer[_BindGroupLayoutImpl]) -> None](
        "wgpuBindGroupLayoutRelease"
    )(handle)


var _wgpuBindGroupLayoutSetLabel = _wgpu.get_function[
    fn (WGPUBindGroupLayout, UnsafePointer[Int8]) -> None
]("wgpuBindGroupLayoutSetLabel")


fn bind_group_layout_set_label(
    handle: WGPUBindGroupLayout, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuBindGroupLayoutSetLabel(handle, label)


struct _BufferImpl:
    pass


alias WGPUBuffer = UnsafePointer[_BufferImpl]


fn buffer_release(handle: WGPUBuffer):
    _wgpu.get_function[fn (UnsafePointer[_BufferImpl]) -> None](
        "wgpuBufferRelease"
    )(handle)


var _wgpuBufferMapAsync = _wgpu.get_function[
    fn (
        WGPUBuffer,
        MapMode,
        UInt,
        UInt,
        fn (BufferMapAsyncStatus, UnsafePointer[NoneType]) -> None,
        UnsafePointer[NoneType],
    ) -> None
]("wgpuBufferMapAsync")


fn buffer_map_async(
    handle: WGPUBuffer,
    mode: MapMode,
    offset: UInt,
    size: UInt,
    callback: fn (BufferMapAsyncStatus, UnsafePointer[NoneType]) -> None,
    user_data: UnsafePointer[NoneType],
) -> None:
    """
    TODO
    """
    return _wgpuBufferMapAsync(handle, mode, offset, size, callback, user_data)


var _wgpuBufferGetMappedRange = _wgpu.get_function[
    fn (WGPUBuffer, UInt, UInt) -> UnsafePointer[NoneType]
]("wgpuBufferGetMappedRange")


fn buffer_get_mapped_range(
    handle: WGPUBuffer, offset: UInt, size: UInt
) -> UnsafePointer[NoneType]:
    """
    TODO
    """
    return _wgpuBufferGetMappedRange(handle, offset, size)


var _wgpuBufferGetConstMappedRange = _wgpu.get_function[
    fn (WGPUBuffer, UInt, UInt) -> UnsafePointer[NoneType]
]("wgpuBufferGetConstMappedRange")


fn buffer_get_const_mapped_range(
    handle: WGPUBuffer, offset: UInt, size: UInt
) -> UnsafePointer[NoneType]:
    """
    TODO
    """
    return _wgpuBufferGetConstMappedRange(handle, offset, size)


var _wgpuBufferSetLabel = _wgpu.get_function[
    fn (WGPUBuffer, UnsafePointer[Int8]) -> None
]("wgpuBufferSetLabel")


fn buffer_set_label(handle: WGPUBuffer, label: UnsafePointer[Int8]) -> None:
    """
    TODO
    """
    return _wgpuBufferSetLabel(handle, label)


var _wgpuBufferGetUsage = _wgpu.get_function[fn (WGPUBuffer,) -> BufferUsage](
    "wgpuBufferGetUsage"
)


fn buffer_get_usage(
    handle: WGPUBuffer,
) -> BufferUsage:
    """
    TODO
    """
    return _wgpuBufferGetUsage(
        handle,
    )


var _wgpuBufferGetSize = _wgpu.get_function[fn (WGPUBuffer,) -> UInt64](
    "wgpuBufferGetSize"
)


fn buffer_get_size(
    handle: WGPUBuffer,
) -> UInt64:
    """
    TODO
    """
    return _wgpuBufferGetSize(
        handle,
    )


var _wgpuBufferGetMapState = _wgpu.get_function[
    fn (WGPUBuffer,) -> BufferMapState
]("wgpuBufferGetMapState")


fn buffer_get_map_state(
    handle: WGPUBuffer,
) -> BufferMapState:
    """
    TODO
    """
    return _wgpuBufferGetMapState(
        handle,
    )


var _wgpuBufferUnmap = _wgpu.get_function[fn (WGPUBuffer,) -> None](
    "wgpuBufferUnmap"
)


fn buffer_unmap(
    handle: WGPUBuffer,
) -> None:
    """
    TODO
    """
    return _wgpuBufferUnmap(
        handle,
    )


var _wgpuBufferDestroy = _wgpu.get_function[fn (WGPUBuffer,) -> None](
    "wgpuBufferDestroy"
)


fn buffer_destroy(
    handle: WGPUBuffer,
) -> None:
    """
    TODO
    """
    return _wgpuBufferDestroy(
        handle,
    )


struct _CommandBufferImpl:
    pass


alias WGPUCommandBuffer = UnsafePointer[_CommandBufferImpl]


fn command_buffer_release(handle: WGPUCommandBuffer):
    _wgpu.get_function[fn (UnsafePointer[_CommandBufferImpl]) -> None](
        "wgpuCommandBufferRelease"
    )(handle)


var _wgpuCommandBufferSetLabel = _wgpu.get_function[
    fn (WGPUCommandBuffer, UnsafePointer[Int8]) -> None
]("wgpuCommandBufferSetLabel")


fn command_buffer_set_label(
    handle: WGPUCommandBuffer, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuCommandBufferSetLabel(handle, label)


struct _CommandEncoderImpl:
    pass


alias WGPUCommandEncoder = UnsafePointer[_CommandEncoderImpl]


fn command_encoder_release(handle: WGPUCommandEncoder):
    _wgpu.get_function[fn (UnsafePointer[_CommandEncoderImpl]) -> None](
        "wgpuCommandEncoderRelease"
    )(handle)


var _wgpuCommandEncoderFinish = _wgpu.get_function[
    fn (
        WGPUCommandEncoder, UnsafePointer[WGPUCommandBufferDescriptor]
    ) -> WGPUCommandBuffer
]("wgpuCommandEncoderFinish")


fn command_encoder_finish(
    handle: WGPUCommandEncoder,
    descriptor: WGPUCommandBufferDescriptor = WGPUCommandBufferDescriptor(),
) -> WGPUCommandBuffer:
    """
    TODO
    """
    return _wgpuCommandEncoderFinish(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuCommandEncoderBeginComputePass = _wgpu.get_function[
    fn (
        WGPUCommandEncoder, UnsafePointer[WGPUComputePassDescriptor]
    ) -> WGPUComputePassEncoder
]("wgpuCommandEncoderBeginComputePass")


fn command_encoder_begin_compute_pass(
    handle: WGPUCommandEncoder,
    descriptor: WGPUComputePassDescriptor = WGPUComputePassDescriptor(),
) -> WGPUComputePassEncoder:
    """
    TODO
    """
    return _wgpuCommandEncoderBeginComputePass(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuCommandEncoderBeginRenderPass = _wgpu.get_function[
    fn (
        WGPUCommandEncoder, UnsafePointer[WGPURenderPassDescriptor]
    ) -> WGPURenderPassEncoder
]("wgpuCommandEncoderBeginRenderPass")


fn command_encoder_begin_render_pass(
    handle: WGPUCommandEncoder, descriptor: WGPURenderPassDescriptor
) -> WGPURenderPassEncoder:
    """
    TODO
    """
    return _wgpuCommandEncoderBeginRenderPass(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuCommandEncoderCopyBufferToBuffer = _wgpu.get_function[
    fn (
        WGPUCommandEncoder, WGPUBuffer, UInt64, WGPUBuffer, UInt64, UInt64
    ) -> None
]("wgpuCommandEncoderCopyBufferToBuffer")


fn command_encoder_copy_buffer_to_buffer(
    handle: WGPUCommandEncoder,
    source: WGPUBuffer,
    source_offset: UInt64,
    destination: WGPUBuffer,
    destination_offset: UInt64,
    size: UInt64,
) -> None:
    """
    TODO
    """
    return _wgpuCommandEncoderCopyBufferToBuffer(
        handle, source, source_offset, destination, destination_offset, size
    )


var _wgpuCommandEncoderCopyBufferToTexture = _wgpu.get_function[
    fn (
        WGPUCommandEncoder,
        UnsafePointer[WGPUImageCopyBuffer],
        UnsafePointer[WGPUImageCopyTexture],
        UnsafePointer[WGPUExtent3D],
    ) -> None
]("wgpuCommandEncoderCopyBufferToTexture")


fn command_encoder_copy_buffer_to_texture(
    handle: WGPUCommandEncoder,
    source: WGPUImageCopyBuffer,
    destination: WGPUImageCopyTexture,
    copy_size: WGPUExtent3D,
) -> None:
    """
    TODO
    """
    return _wgpuCommandEncoderCopyBufferToTexture(
        handle,
        UnsafePointer.address_of(source),
        UnsafePointer.address_of(destination),
        UnsafePointer.address_of(copy_size),
    )


var _wgpuCommandEncoderCopyTextureToBuffer = _wgpu.get_function[
    fn (
        WGPUCommandEncoder,
        UnsafePointer[WGPUImageCopyTexture],
        UnsafePointer[WGPUImageCopyBuffer],
        UnsafePointer[WGPUExtent3D],
    ) -> None
]("wgpuCommandEncoderCopyTextureToBuffer")


fn command_encoder_copy_texture_to_buffer(
    handle: WGPUCommandEncoder,
    source: WGPUImageCopyTexture,
    destination: WGPUImageCopyBuffer,
    copy_size: WGPUExtent3D,
) -> None:
    """
    TODO
    """
    return _wgpuCommandEncoderCopyTextureToBuffer(
        handle,
        UnsafePointer.address_of(source),
        UnsafePointer.address_of(destination),
        UnsafePointer.address_of(copy_size),
    )


var _wgpuCommandEncoderCopyTextureToTexture = _wgpu.get_function[
    fn (
        WGPUCommandEncoder,
        UnsafePointer[WGPUImageCopyTexture],
        UnsafePointer[WGPUImageCopyTexture],
        UnsafePointer[WGPUExtent3D],
    ) -> None
]("wgpuCommandEncoderCopyTextureToTexture")


fn command_encoder_copy_texture_to_texture(
    handle: WGPUCommandEncoder,
    source: WGPUImageCopyTexture,
    destination: WGPUImageCopyTexture,
    copy_size: WGPUExtent3D,
) -> None:
    """
    TODO
    """
    return _wgpuCommandEncoderCopyTextureToTexture(
        handle,
        UnsafePointer.address_of(source),
        UnsafePointer.address_of(destination),
        UnsafePointer.address_of(copy_size),
    )


var _wgpuCommandEncoderClearBuffer = _wgpu.get_function[
    fn (WGPUCommandEncoder, WGPUBuffer, UInt64, UInt64) -> None
]("wgpuCommandEncoderClearBuffer")


fn command_encoder_clear_buffer(
    handle: WGPUCommandEncoder, buffer: WGPUBuffer, offset: UInt64, size: UInt64
) -> None:
    """
    TODO
    """
    return _wgpuCommandEncoderClearBuffer(handle, buffer, offset, size)


var _wgpuCommandEncoderInsertDebugMarker = _wgpu.get_function[
    fn (WGPUCommandEncoder, UnsafePointer[Int8]) -> None
]("wgpuCommandEncoderInsertDebugMarker")


fn command_encoder_insert_debug_marker(
    handle: WGPUCommandEncoder, marker_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuCommandEncoderInsertDebugMarker(handle, marker_label)


var _wgpuCommandEncoderPopDebugGroup = _wgpu.get_function[
    fn (WGPUCommandEncoder,) -> None
]("wgpuCommandEncoderPopDebugGroup")


fn command_encoder_pop_debug_group(
    handle: WGPUCommandEncoder,
) -> None:
    """
    TODO
    """
    return _wgpuCommandEncoderPopDebugGroup(
        handle,
    )


var _wgpuCommandEncoderPushDebugGroup = _wgpu.get_function[
    fn (WGPUCommandEncoder, UnsafePointer[Int8]) -> None
]("wgpuCommandEncoderPushDebugGroup")


fn command_encoder_push_debug_group(
    handle: WGPUCommandEncoder, group_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuCommandEncoderPushDebugGroup(handle, group_label)


var _wgpuCommandEncoderResolveQuerySet = _wgpu.get_function[
    fn (
        WGPUCommandEncoder, WGPUQuerySet, UInt32, UInt32, WGPUBuffer, UInt64
    ) -> None
]("wgpuCommandEncoderResolveQuerySet")


fn command_encoder_resolve_query_set(
    handle: WGPUCommandEncoder,
    query_set: WGPUQuerySet,
    first_query: UInt32,
    query_count: UInt32,
    destination: WGPUBuffer,
    destination_offset: UInt64,
) -> None:
    """
    TODO
    """
    return _wgpuCommandEncoderResolveQuerySet(
        handle,
        query_set,
        first_query,
        query_count,
        destination,
        destination_offset,
    )


var _wgpuCommandEncoderWriteTimestamp = _wgpu.get_function[
    fn (WGPUCommandEncoder, WGPUQuerySet, UInt32) -> None
]("wgpuCommandEncoderWriteTimestamp")


fn command_encoder_write_timestamp(
    handle: WGPUCommandEncoder, query_set: WGPUQuerySet, query_index: UInt32
) -> None:
    """
    TODO
    """
    return _wgpuCommandEncoderWriteTimestamp(handle, query_set, query_index)


var _wgpuCommandEncoderSetLabel = _wgpu.get_function[
    fn (WGPUCommandEncoder, UnsafePointer[Int8]) -> None
]("wgpuCommandEncoderSetLabel")


fn command_encoder_set_label(
    handle: WGPUCommandEncoder, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuCommandEncoderSetLabel(handle, label)


struct _ComputePassEncoderImpl:
    pass


alias WGPUComputePassEncoder = UnsafePointer[_ComputePassEncoderImpl]


fn compute_pass_encoder_release(handle: WGPUComputePassEncoder):
    _wgpu.get_function[fn (UnsafePointer[_ComputePassEncoderImpl]) -> None](
        "wgpuComputePassEncoderRelease"
    )(handle)


var _wgpuComputePassEncoderInsertDebugMarker = _wgpu.get_function[
    fn (WGPUComputePassEncoder, UnsafePointer[Int8]) -> None
]("wgpuComputePassEncoderInsertDebugMarker")


fn compute_pass_encoder_insert_debug_marker(
    handle: WGPUComputePassEncoder, marker_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuComputePassEncoderInsertDebugMarker(handle, marker_label)


var _wgpuComputePassEncoderPopDebugGroup = _wgpu.get_function[
    fn (WGPUComputePassEncoder,) -> None
]("wgpuComputePassEncoderPopDebugGroup")


fn compute_pass_encoder_pop_debug_group(
    handle: WGPUComputePassEncoder,
) -> None:
    """
    TODO
    """
    return _wgpuComputePassEncoderPopDebugGroup(
        handle,
    )


var _wgpuComputePassEncoderPushDebugGroup = _wgpu.get_function[
    fn (WGPUComputePassEncoder, UnsafePointer[Int8]) -> None
]("wgpuComputePassEncoderPushDebugGroup")


fn compute_pass_encoder_push_debug_group(
    handle: WGPUComputePassEncoder, group_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuComputePassEncoderPushDebugGroup(handle, group_label)


var _wgpuComputePassEncoderSetPipeline = _wgpu.get_function[
    fn (WGPUComputePassEncoder, WGPUComputePipeline) -> None
]("wgpuComputePassEncoderSetPipeline")


fn compute_pass_encoder_set_pipeline(
    handle: WGPUComputePassEncoder, pipeline: WGPUComputePipeline
) -> None:
    """
    TODO
    """
    return _wgpuComputePassEncoderSetPipeline(handle, pipeline)


var _wgpuComputePassEncoderSetBindGroup = _wgpu.get_function[
    fn (
        WGPUComputePassEncoder,
        UInt32,
        WGPUBindGroup,
        Int32,
        UnsafePointer[UInt32],
    ) -> None
]("wgpuComputePassEncoderSetBindGroup")


fn compute_pass_encoder_set_bind_group(
    handle: WGPUComputePassEncoder,
    group_index: UInt32,
    dynamic_offset_count: Int,
    dynamic_offsets: UnsafePointer[UInt32],
    group: WGPUBindGroup = WGPUBindGroup(),
) -> None:
    """
    TODO
    """
    return _wgpuComputePassEncoderSetBindGroup(
        handle, group_index, group, dynamic_offset_count, dynamic_offsets
    )


var _wgpuComputePassEncoderDispatchWorkgroups = _wgpu.get_function[
    fn (WGPUComputePassEncoder, UInt32, UInt32, UInt32) -> None
]("wgpuComputePassEncoderDispatchWorkgroups")


fn compute_pass_encoder_dispatch_workgroups(
    handle: WGPUComputePassEncoder,
    workgroupCountX: UInt32,
    workgroupCountY: UInt32,
    workgroupCountZ: UInt32,
) -> None:
    """
    TODO
    """
    return _wgpuComputePassEncoderDispatchWorkgroups(
        handle, workgroupCountX, workgroupCountY, workgroupCountZ
    )


var _wgpuComputePassEncoderDispatchWorkgroupsIndirect = _wgpu.get_function[
    fn (WGPUComputePassEncoder, WGPUBuffer, UInt64) -> None
]("wgpuComputePassEncoderDispatchWorkgroupsIndirect")


fn compute_pass_encoder_dispatch_workgroups_indirect(
    handle: WGPUComputePassEncoder,
    indirect_buffer: WGPUBuffer,
    indirect_offset: UInt64,
) -> None:
    """
    TODO
    """
    return _wgpuComputePassEncoderDispatchWorkgroupsIndirect(
        handle, indirect_buffer, indirect_offset
    )


var _wgpuComputePassEncoderEnd = _wgpu.get_function[
    fn (WGPUComputePassEncoder,) -> None
]("wgpuComputePassEncoderEnd")


fn compute_pass_encoder_end(
    handle: WGPUComputePassEncoder,
) -> None:
    """
    TODO
    """
    return _wgpuComputePassEncoderEnd(
        handle,
    )


var _wgpuComputePassEncoderSetLabel = _wgpu.get_function[
    fn (WGPUComputePassEncoder, UnsafePointer[Int8]) -> None
]("wgpuComputePassEncoderSetLabel")


fn compute_pass_encoder_set_label(
    handle: WGPUComputePassEncoder, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuComputePassEncoderSetLabel(handle, label)


struct _ComputePipelineImpl:
    pass


alias WGPUComputePipeline = UnsafePointer[_ComputePipelineImpl]


fn compute_pipeline_release(handle: WGPUComputePipeline):
    _wgpu.get_function[fn (UnsafePointer[_ComputePipelineImpl]) -> None](
        "wgpuComputePipelineRelease"
    )(handle)


var _wgpuComputePipelineGetBindGroupLayout = _wgpu.get_function[
    fn (WGPUComputePipeline, UInt32) -> WGPUBindGroupLayout
]("wgpuComputePipelineGetBindGroupLayout")


fn compute_pipeline_get_bind_group_layout(
    handle: WGPUComputePipeline, group_index: UInt32
) -> WGPUBindGroupLayout:
    """
    TODO
    """
    return _wgpuComputePipelineGetBindGroupLayout(handle, group_index)


var _wgpuComputePipelineSetLabel = _wgpu.get_function[
    fn (WGPUComputePipeline, UnsafePointer[Int8]) -> None
]("wgpuComputePipelineSetLabel")


fn compute_pipeline_set_label(
    handle: WGPUComputePipeline, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuComputePipelineSetLabel(handle, label)


struct _DeviceImpl:
    pass


alias WGPUDevice = UnsafePointer[_DeviceImpl]


fn device_release(handle: WGPUDevice):
    _wgpu.get_function[fn (UnsafePointer[_DeviceImpl]) -> None](
        "wgpuDeviceRelease"
    )(handle)


var _wgpuDeviceCreateBindGroup = _wgpu.get_function[
    fn (WGPUDevice, UnsafePointer[WGPUBindGroupDescriptor]) -> WGPUBindGroup
]("wgpuDeviceCreateBindGroup")


fn device_create_bind_group(
    handle: WGPUDevice, descriptor: WGPUBindGroupDescriptor
) -> WGPUBindGroup:
    """
    TODO
    """
    return _wgpuDeviceCreateBindGroup(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuDeviceCreateBindGroupLayout = _wgpu.get_function[
    fn (
        WGPUDevice, UnsafePointer[WGPUBindGroupLayoutDescriptor]
    ) -> WGPUBindGroupLayout
]("wgpuDeviceCreateBindGroupLayout")


fn device_create_bind_group_layout(
    handle: WGPUDevice, descriptor: WGPUBindGroupLayoutDescriptor
) -> WGPUBindGroupLayout:
    """
    TODO
    """
    return _wgpuDeviceCreateBindGroupLayout(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuDeviceCreateBuffer = _wgpu.get_function[
    fn (WGPUDevice, UnsafePointer[WGPUBufferDescriptor]) -> WGPUBuffer
]("wgpuDeviceCreateBuffer")


fn device_create_buffer(
    handle: WGPUDevice, descriptor: WGPUBufferDescriptor
) -> WGPUBuffer:
    """
    TODO
    """
    return _wgpuDeviceCreateBuffer(handle, UnsafePointer.address_of(descriptor))


var _wgpuDeviceCreateCommandEncoder = _wgpu.get_function[
    fn (
        WGPUDevice, UnsafePointer[WGPUCommandEncoderDescriptor]
    ) -> WGPUCommandEncoder
]("wgpuDeviceCreateCommandEncoder")


fn device_create_command_encoder(
    handle: WGPUDevice,
    descriptor: WGPUCommandEncoderDescriptor = WGPUCommandEncoderDescriptor(),
) -> WGPUCommandEncoder:
    """
    TODO
    """
    return _wgpuDeviceCreateCommandEncoder(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuDeviceCreateComputePipeline = _wgpu.get_function[
    fn (
        WGPUDevice, UnsafePointer[WGPUComputePipelineDescriptor]
    ) -> WGPUComputePipeline
]("wgpuDeviceCreateComputePipeline")


fn device_create_compute_pipeline(
    handle: WGPUDevice, descriptor: WGPUComputePipelineDescriptor
) -> WGPUComputePipeline:
    """
    TODO
    """
    return _wgpuDeviceCreateComputePipeline(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuDeviceCreateComputePipelineAsync = _wgpu.get_function[
    fn (
        WGPUDevice,
        UnsafePointer[WGPUComputePipelineDescriptor],
        fn (
            CreatePipelineAsyncStatus,
            WGPUComputePipeline,
            UnsafePointer[Int8],
            UnsafePointer[NoneType],
        ) -> None,
        UnsafePointer[NoneType],
    ) -> None
]("wgpuDeviceCreateComputePipelineAsync")


fn device_create_compute_pipeline_async(
    handle: WGPUDevice,
    descriptor: WGPUComputePipelineDescriptor,
    callback: fn (
        CreatePipelineAsyncStatus,
        WGPUComputePipeline,
        UnsafePointer[Int8],
        UnsafePointer[NoneType],
    ) -> None,
    user_data: UnsafePointer[NoneType],
) -> None:
    """
    TODO
    """
    return _wgpuDeviceCreateComputePipelineAsync(
        handle, UnsafePointer.address_of(descriptor), callback, user_data
    )


var _wgpuDeviceCreatePipelineLayout = _wgpu.get_function[
    fn (
        WGPUDevice, UnsafePointer[WGPUPipelineLayoutDescriptor]
    ) -> WGPUPipelineLayout
]("wgpuDeviceCreatePipelineLayout")


fn device_create_pipeline_layout(
    handle: WGPUDevice, descriptor: WGPUPipelineLayoutDescriptor
) -> WGPUPipelineLayout:
    """
    TODO
    """
    return _wgpuDeviceCreatePipelineLayout(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuDeviceCreateQuerySet = _wgpu.get_function[
    fn (WGPUDevice, UnsafePointer[WGPUQuerySetDescriptor]) -> WGPUQuerySet
]("wgpuDeviceCreateQuerySet")


fn device_create_query_set(
    handle: WGPUDevice, descriptor: WGPUQuerySetDescriptor
) -> WGPUQuerySet:
    """
    TODO
    """
    return _wgpuDeviceCreateQuerySet(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuDeviceCreateRenderPipelineAsync = _wgpu.get_function[
    fn (
        WGPUDevice,
        UnsafePointer[WGPURenderPipelineDescriptor],
        fn (
            CreatePipelineAsyncStatus,
            WGPURenderPipeline,
            UnsafePointer[Int8],
            UnsafePointer[NoneType],
        ) -> None,
        UnsafePointer[NoneType],
    ) -> None
]("wgpuDeviceCreateRenderPipelineAsync")


fn device_create_render_pipeline_async(
    handle: WGPUDevice,
    descriptor: WGPURenderPipelineDescriptor,
    callback: fn (
        CreatePipelineAsyncStatus,
        WGPURenderPipeline,
        UnsafePointer[Int8],
        UnsafePointer[NoneType],
    ) -> None,
    user_data: UnsafePointer[NoneType],
) -> None:
    """
    TODO
    """
    return _wgpuDeviceCreateRenderPipelineAsync(
        handle, UnsafePointer.address_of(descriptor), callback, user_data
    )


var _wgpuDeviceCreateRenderBundleEncoder = _wgpu.get_function[
    fn (
        WGPUDevice, UnsafePointer[WGPURenderBundleEncoderDescriptor]
    ) -> WGPURenderBundleEncoder
]("wgpuDeviceCreateRenderBundleEncoder")


fn device_create_render_bundle_encoder(
    handle: WGPUDevice, descriptor: WGPURenderBundleEncoderDescriptor
) -> WGPURenderBundleEncoder:
    """
    TODO
    """
    return _wgpuDeviceCreateRenderBundleEncoder(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuDeviceCreateRenderPipeline = _wgpu.get_function[
    fn (
        WGPUDevice, UnsafePointer[WGPURenderPipelineDescriptor]
    ) -> WGPURenderPipeline
]("wgpuDeviceCreateRenderPipeline")


fn device_create_render_pipeline(
    handle: WGPUDevice, descriptor: WGPURenderPipelineDescriptor
) -> WGPURenderPipeline:
    """
    TODO
    """
    return _wgpuDeviceCreateRenderPipeline(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuDeviceCreateSampler = _wgpu.get_function[
    fn (WGPUDevice, UnsafePointer[WGPUSamplerDescriptor]) -> WGPUSampler
]("wgpuDeviceCreateSampler")


fn device_create_sampler(
    handle: WGPUDevice,
    descriptor: WGPUSamplerDescriptor = WGPUSamplerDescriptor(),
) -> WGPUSampler:
    """
    TODO
    """
    return _wgpuDeviceCreateSampler(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuDeviceCreateShaderModule = _wgpu.get_function[
    fn (
        WGPUDevice, UnsafePointer[WGPUShaderModuleDescriptor]
    ) -> WGPUShaderModule
]("wgpuDeviceCreateShaderModule")


fn device_create_shader_module(
    handle: WGPUDevice, descriptor: WGPUShaderModuleDescriptor
) -> WGPUShaderModule:
    """
    TODO
    """
    return _wgpuDeviceCreateShaderModule(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuDeviceCreateTexture = _wgpu.get_function[
    fn (WGPUDevice, UnsafePointer[WGPUTextureDescriptor]) -> WGPUTexture
]("wgpuDeviceCreateTexture")


fn device_create_texture(
    handle: WGPUDevice, descriptor: WGPUTextureDescriptor
) -> WGPUTexture:
    """
    TODO
    """
    return _wgpuDeviceCreateTexture(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuDeviceDestroy = _wgpu.get_function[fn (WGPUDevice,) -> None](
    "wgpuDeviceDestroy"
)


fn device_destroy(
    handle: WGPUDevice,
) -> None:
    """
    TODO
    """
    return _wgpuDeviceDestroy(
        handle,
    )


var _wgpuDeviceGetLimits = _wgpu.get_function[
    fn (WGPUDevice, UnsafePointer[WGPUSupportedLimits]) -> Bool
]("wgpuDeviceGetLimits")


fn device_get_limits(handle: WGPUDevice, limits: WGPUSupportedLimits) -> Bool:
    """
    TODO
    """
    return _wgpuDeviceGetLimits(handle, UnsafePointer.address_of(limits))


var _wgpuDeviceHasFeature = _wgpu.get_function[
    fn (WGPUDevice, FeatureName) -> Bool
]("wgpuDeviceHasFeature")


fn device_has_feature(handle: WGPUDevice, feature: FeatureName) -> Bool:
    """
    TODO
    """
    return _wgpuDeviceHasFeature(handle, feature)


var _wgpuDeviceEnumerateFeatures = _wgpu.get_function[
    fn (WGPUDevice, FeatureName) -> UInt
]("wgpuDeviceEnumerateFeatures")


fn device_enumerate_features(handle: WGPUDevice, features: FeatureName) -> UInt:
    """
    TODO
    """
    return _wgpuDeviceEnumerateFeatures(handle, features)


var _wgpuDeviceGetQueue = _wgpu.get_function[fn (WGPUDevice,) -> WGPUQueue](
    "wgpuDeviceGetQueue"
)


fn device_get_queue(
    handle: WGPUDevice,
) -> WGPUQueue:
    """
    TODO
    """
    return _wgpuDeviceGetQueue(
        handle,
    )


var _wgpuDevicePushErrorScope = _wgpu.get_function[
    fn (WGPUDevice, ErrorFilter) -> None
]("wgpuDevicePushErrorScope")


fn device_push_error_scope(handle: WGPUDevice, filter: ErrorFilter) -> None:
    """
    TODO
    """
    return _wgpuDevicePushErrorScope(handle, filter)


var _wgpuDevicePopErrorScope = _wgpu.get_function[
    fn (WGPUDevice, ErrorCallback, UnsafePointer[NoneType]) -> None
]("wgpuDevicePopErrorScope")


fn device_pop_error_scope(
    handle: WGPUDevice,
    callback: ErrorCallback,
    userdata: UnsafePointer[NoneType],
) -> None:
    """
    TODO
    """
    return _wgpuDevicePopErrorScope(handle, callback, userdata)


var _wgpuDeviceSetLabel = _wgpu.get_function[
    fn (WGPUDevice, UnsafePointer[Int8]) -> None
]("wgpuDeviceSetLabel")


fn device_set_label(handle: WGPUDevice, label: UnsafePointer[Int8]) -> None:
    """
    TODO
    """
    return _wgpuDeviceSetLabel(handle, label)


struct _InstanceImpl:
    pass


alias WGPUInstance = UnsafePointer[_InstanceImpl]


fn instance_release(handle: WGPUInstance):
    _wgpu.get_function[fn (UnsafePointer[_InstanceImpl]) -> None](
        "wgpuInstanceRelease"
    )(handle)


var _wgpuInstanceCreateSurface = _wgpu.get_function[
    fn (WGPUInstance, UnsafePointer[WGPUSurfaceDescriptor]) -> WGPUSurface
]("wgpuInstanceCreateSurface")


fn instance_create_surface(
    handle: WGPUInstance, descriptor: WGPUSurfaceDescriptor
) -> WGPUSurface:
    """
    TODO
    """
    return _wgpuInstanceCreateSurface(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuInstanceHasWgslLanguageFeature = _wgpu.get_function[
    fn (WGPUInstance, WgslFeatureName) -> Bool
]("wgpuInstanceHasWgslLanguageFeature")


fn instance_has_WGSL_language_feature(
    handle: WGPUInstance, feature: WgslFeatureName
) -> Bool:
    """
    TODO
    """
    return _wgpuInstanceHasWgslLanguageFeature(handle, feature)


var _wgpuInstanceProcessEvents = _wgpu.get_function[fn (WGPUInstance,) -> None](
    "wgpuInstanceProcessEvents"
)


fn instance_process_events(
    handle: WGPUInstance,
) -> None:
    """
    TODO
    """
    return _wgpuInstanceProcessEvents(
        handle,
    )


var _wgpuInstanceRequestAdapter = _wgpu.get_function[
    fn (
        WGPUInstance,
        UnsafePointer[WGPURequestAdapterOptions],
        fn (
            RequestAdapterStatus,
            WGPUAdapter,
            UnsafePointer[Int8],
            UnsafePointer[NoneType],
        ) -> None,
        UnsafePointer[NoneType],
    ) -> None
]("wgpuInstanceRequestAdapter")


fn instance_request_adapter(
    handle: WGPUInstance,
    callback: fn (
        RequestAdapterStatus,
        WGPUAdapter,
        UnsafePointer[Int8],
        UnsafePointer[NoneType],
    ) -> None,
    user_data: UnsafePointer[NoneType],
    options: WGPURequestAdapterOptions = WGPURequestAdapterOptions(),
) -> None:
    """
    TODO
    """
    return _wgpuInstanceRequestAdapter(
        handle, UnsafePointer.address_of(options), callback, user_data
    )


struct _PipelineLayoutImpl:
    pass


alias WGPUPipelineLayout = UnsafePointer[_PipelineLayoutImpl]


fn pipeline_layout_release(handle: WGPUPipelineLayout):
    _wgpu.get_function[fn (UnsafePointer[_PipelineLayoutImpl]) -> None](
        "wgpuPipelineLayoutRelease"
    )(handle)


var _wgpuPipelineLayoutSetLabel = _wgpu.get_function[
    fn (WGPUPipelineLayout, UnsafePointer[Int8]) -> None
]("wgpuPipelineLayoutSetLabel")


fn pipeline_layout_set_label(
    handle: WGPUPipelineLayout, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuPipelineLayoutSetLabel(handle, label)


struct _QuerySetImpl:
    pass


alias WGPUQuerySet = UnsafePointer[_QuerySetImpl]


fn query_set_release(handle: WGPUQuerySet):
    _wgpu.get_function[fn (UnsafePointer[_QuerySetImpl]) -> None](
        "wgpuQuerySetRelease"
    )(handle)


var _wgpuQuerySetSetLabel = _wgpu.get_function[
    fn (WGPUQuerySet, UnsafePointer[Int8]) -> None
]("wgpuQuerySetSetLabel")


fn query_set_set_label(
    handle: WGPUQuerySet, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuQuerySetSetLabel(handle, label)


var _wgpuQuerySetGetType = _wgpu.get_function[fn (WGPUQuerySet,) -> QueryType](
    "wgpuQuerySetGetType"
)


fn query_set_get_type(
    handle: WGPUQuerySet,
) -> QueryType:
    """
    TODO
    """
    return _wgpuQuerySetGetType(
        handle,
    )


var _wgpuQuerySetGetCount = _wgpu.get_function[fn (WGPUQuerySet,) -> UInt32](
    "wgpuQuerySetGetCount"
)


fn query_set_get_count(
    handle: WGPUQuerySet,
) -> UInt32:
    """
    TODO
    """
    return _wgpuQuerySetGetCount(
        handle,
    )


var _wgpuQuerySetDestroy = _wgpu.get_function[fn (WGPUQuerySet,) -> None](
    "wgpuQuerySetDestroy"
)


fn query_set_destroy(
    handle: WGPUQuerySet,
) -> None:
    """
    TODO
    """
    return _wgpuQuerySetDestroy(
        handle,
    )


struct _QueueImpl:
    pass


alias WGPUQueue = UnsafePointer[_QueueImpl]


fn queue_release(handle: WGPUQueue):
    _wgpu.get_function[fn (UnsafePointer[_QueueImpl]) -> None](
        "wgpuQueueRelease"
    )(handle)


var _wgpuQueueSubmit = _wgpu.get_function[
    fn (WGPUQueue, Int32, UnsafePointer[WGPUCommandBuffer]) -> None
]("wgpuQueueSubmit")


fn queue_submit(
    handle: WGPUQueue,
    command_count: Int,
    commands: UnsafePointer[WGPUCommandBuffer],
) -> None:
    """
    TODO
    """
    return _wgpuQueueSubmit(handle, command_count, commands)


var _wgpuQueueOnSubmittedWorkDone = _wgpu.get_function[
    fn (
        WGPUQueue,
        fn (QueueWorkDoneStatus, UnsafePointer[NoneType]) -> None,
        UnsafePointer[NoneType],
    ) -> None
]("wgpuQueueOnSubmittedWorkDone")


fn queue_on_submitted_work_done(
    handle: WGPUQueue,
    callback: fn (QueueWorkDoneStatus, UnsafePointer[NoneType]) -> None,
    user_data: UnsafePointer[NoneType],
) -> None:
    """
    TODO
    """
    return _wgpuQueueOnSubmittedWorkDone(handle, callback, user_data)


var _wgpuQueueWriteBuffer = _wgpu.get_function[
    fn (WGPUQueue, WGPUBuffer, UInt64, UnsafePointer[UInt8], UInt) -> None
]("wgpuQueueWriteBuffer")


fn queue_write_buffer(
    handle: WGPUQueue,
    buffer: WGPUBuffer,
    buffer_offset: UInt64,
    data: UnsafePointer[UInt8],
    size: UInt,
) -> None:
    """
    TODO
    """
    return _wgpuQueueWriteBuffer(handle, buffer, buffer_offset, data, size)


var _wgpuQueueWriteTexture = _wgpu.get_function[
    fn (
        WGPUQueue,
        UnsafePointer[WGPUImageCopyTexture],
        UnsafePointer[NoneType],
        UInt,
        UnsafePointer[WGPUTextureDataLayout],
        UnsafePointer[WGPUExtent3D],
    ) -> None
]("wgpuQueueWriteTexture")


fn queue_write_texture(
    handle: WGPUQueue,
    destination: WGPUImageCopyTexture,
    data: UnsafePointer[NoneType],
    data_size: UInt,
    data_layout: WGPUTextureDataLayout,
    write_size: WGPUExtent3D,
) -> None:
    """
    TODO
    """
    return _wgpuQueueWriteTexture(
        handle,
        UnsafePointer.address_of(destination),
        data,
        data_size,
        UnsafePointer.address_of(data_layout),
        UnsafePointer.address_of(write_size),
    )


var _wgpuQueueSetLabel = _wgpu.get_function[
    fn (WGPUQueue, UnsafePointer[Int8]) -> None
]("wgpuQueueSetLabel")


fn queue_set_label(handle: WGPUQueue, label: UnsafePointer[Int8]) -> None:
    """
    TODO
    """
    return _wgpuQueueSetLabel(handle, label)


struct _RenderBundleImpl:
    pass


alias WGPURenderBundle = UnsafePointer[_RenderBundleImpl]


fn render_bundle_release(handle: WGPURenderBundle):
    _wgpu.get_function[fn (UnsafePointer[_RenderBundleImpl]) -> None](
        "wgpuRenderBundleRelease"
    )(handle)


var _wgpuRenderBundleSetLabel = _wgpu.get_function[
    fn (WGPURenderBundle, UnsafePointer[Int8]) -> None
]("wgpuRenderBundleSetLabel")


fn render_bundle_set_label(
    handle: WGPURenderBundle, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleSetLabel(handle, label)


struct _RenderBundleEncoderImpl:
    pass


alias WGPURenderBundleEncoder = UnsafePointer[_RenderBundleEncoderImpl]


fn render_bundle_encoder_release(handle: WGPURenderBundleEncoder):
    _wgpu.get_function[fn (UnsafePointer[_RenderBundleEncoderImpl]) -> None](
        "wgpuRenderBundleEncoderRelease"
    )(handle)


var _wgpuRenderBundleEncoderSetPipeline = _wgpu.get_function[
    fn (WGPURenderBundleEncoder, WGPURenderPipeline) -> None
]("wgpuRenderBundleEncoderSetPipeline")


fn render_bundle_encoder_set_pipeline(
    handle: WGPURenderBundleEncoder, pipeline: WGPURenderPipeline
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderSetPipeline(handle, pipeline)


var _wgpuRenderBundleEncoderSetBindGroup = _wgpu.get_function[
    fn (
        WGPURenderBundleEncoder,
        UInt32,
        WGPUBindGroup,
        Int32,
        UnsafePointer[UInt32],
    ) -> None
]("wgpuRenderBundleEncoderSetBindGroup")


fn render_bundle_encoder_set_bind_group(
    handle: WGPURenderBundleEncoder,
    group_index: UInt32,
    dynamic_offset_count: Int,
    dynamic_offsets: UnsafePointer[UInt32],
    group: WGPUBindGroup = WGPUBindGroup(),
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderSetBindGroup(
        handle, group_index, group, dynamic_offset_count, dynamic_offsets
    )


var _wgpuRenderBundleEncoderDraw = _wgpu.get_function[
    fn (WGPURenderBundleEncoder, UInt32, UInt32, UInt32, UInt32) -> None
]("wgpuRenderBundleEncoderDraw")


fn render_bundle_encoder_draw(
    handle: WGPURenderBundleEncoder,
    vertex_count: UInt32,
    instance_count: UInt32,
    first_vertex: UInt32,
    first_instance: UInt32,
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderDraw(
        handle, vertex_count, instance_count, first_vertex, first_instance
    )


var _wgpuRenderBundleEncoderDrawIndexed = _wgpu.get_function[
    fn (WGPURenderBundleEncoder, UInt32, UInt32, UInt32, Int32, UInt32) -> None
]("wgpuRenderBundleEncoderDrawIndexed")


fn render_bundle_encoder_draw_indexed(
    handle: WGPURenderBundleEncoder,
    index_count: UInt32,
    instance_count: UInt32,
    first_index: UInt32,
    base_vertex: Int32,
    first_instance: UInt32,
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderDrawIndexed(
        handle,
        index_count,
        instance_count,
        first_index,
        base_vertex,
        first_instance,
    )


var _wgpuRenderBundleEncoderDrawIndirect = _wgpu.get_function[
    fn (WGPURenderBundleEncoder, WGPUBuffer, UInt64) -> None
]("wgpuRenderBundleEncoderDrawIndirect")


fn render_bundle_encoder_draw_indirect(
    handle: WGPURenderBundleEncoder,
    indirect_buffer: WGPUBuffer,
    indirect_offset: UInt64,
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderDrawIndirect(
        handle, indirect_buffer, indirect_offset
    )


var _wgpuRenderBundleEncoderDrawIndexedIndirect = _wgpu.get_function[
    fn (WGPURenderBundleEncoder, WGPUBuffer, UInt64) -> None
]("wgpuRenderBundleEncoderDrawIndexedIndirect")


fn render_bundle_encoder_draw_indexed_indirect(
    handle: WGPURenderBundleEncoder,
    indirect_buffer: WGPUBuffer,
    indirect_offset: UInt64,
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderDrawIndexedIndirect(
        handle, indirect_buffer, indirect_offset
    )


var _wgpuRenderBundleEncoderInsertDebugMarker = _wgpu.get_function[
    fn (WGPURenderBundleEncoder, UnsafePointer[Int8]) -> None
]("wgpuRenderBundleEncoderInsertDebugMarker")


fn render_bundle_encoder_insert_debug_marker(
    handle: WGPURenderBundleEncoder, marker_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderInsertDebugMarker(handle, marker_label)


var _wgpuRenderBundleEncoderPopDebugGroup = _wgpu.get_function[
    fn (WGPURenderBundleEncoder,) -> None
]("wgpuRenderBundleEncoderPopDebugGroup")


fn render_bundle_encoder_pop_debug_group(
    handle: WGPURenderBundleEncoder,
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderPopDebugGroup(
        handle,
    )


var _wgpuRenderBundleEncoderPushDebugGroup = _wgpu.get_function[
    fn (WGPURenderBundleEncoder, UnsafePointer[Int8]) -> None
]("wgpuRenderBundleEncoderPushDebugGroup")


fn render_bundle_encoder_push_debug_group(
    handle: WGPURenderBundleEncoder, group_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderPushDebugGroup(handle, group_label)


var _wgpuRenderBundleEncoderSetVertexBuffer = _wgpu.get_function[
    fn (WGPURenderBundleEncoder, UInt32, WGPUBuffer, UInt64, UInt64) -> None
]("wgpuRenderBundleEncoderSetVertexBuffer")


fn render_bundle_encoder_set_vertex_buffer(
    handle: WGPURenderBundleEncoder,
    slot: UInt32,
    offset: UInt64,
    size: UInt64,
    buffer: WGPUBuffer = WGPUBuffer(),
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderSetVertexBuffer(
        handle, slot, buffer, offset, size
    )


var _wgpuRenderBundleEncoderSetIndexBuffer = _wgpu.get_function[
    fn (
        WGPURenderBundleEncoder, WGPUBuffer, IndexFormat, UInt64, UInt64
    ) -> None
]("wgpuRenderBundleEncoderSetIndexBuffer")


fn render_bundle_encoder_set_index_buffer(
    handle: WGPURenderBundleEncoder,
    buffer: WGPUBuffer,
    format: IndexFormat,
    offset: UInt64,
    size: UInt64,
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderSetIndexBuffer(
        handle, buffer, format, offset, size
    )


var _wgpuRenderBundleEncoderFinish = _wgpu.get_function[
    fn (
        WGPURenderBundleEncoder, UnsafePointer[WGPURenderBundleDescriptor]
    ) -> WGPURenderBundle
]("wgpuRenderBundleEncoderFinish")


fn render_bundle_encoder_finish(
    handle: WGPURenderBundleEncoder,
    descriptor: WGPURenderBundleDescriptor = WGPURenderBundleDescriptor(),
) -> WGPURenderBundle:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderFinish(
        handle, UnsafePointer.address_of(descriptor)
    )


var _wgpuRenderBundleEncoderSetLabel = _wgpu.get_function[
    fn (WGPURenderBundleEncoder, UnsafePointer[Int8]) -> None
]("wgpuRenderBundleEncoderSetLabel")


fn render_bundle_encoder_set_label(
    handle: WGPURenderBundleEncoder, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuRenderBundleEncoderSetLabel(handle, label)


struct _RenderPassEncoderImpl:
    pass


alias WGPURenderPassEncoder = UnsafePointer[_RenderPassEncoderImpl]


fn render_pass_encoder_release(handle: WGPURenderPassEncoder):
    _wgpu.get_function[fn (UnsafePointer[_RenderPassEncoderImpl]) -> None](
        "wgpuRenderPassEncoderRelease"
    )(handle)


var _wgpuRenderPassEncoderSetPipeline = _wgpu.get_function[
    fn (WGPURenderPassEncoder, WGPURenderPipeline) -> None
]("wgpuRenderPassEncoderSetPipeline")


fn render_pass_encoder_set_pipeline(
    handle: WGPURenderPassEncoder, pipeline: WGPURenderPipeline
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderSetPipeline(handle, pipeline)


var _wgpuRenderPassEncoderSetBindGroup = _wgpu.get_function[
    fn (
        WGPURenderPassEncoder,
        UInt32,
        WGPUBindGroup,
        Int32,
        UnsafePointer[UInt32],
    ) -> None
]("wgpuRenderPassEncoderSetBindGroup")


fn render_pass_encoder_set_bind_group(
    handle: WGPURenderPassEncoder,
    group_index: UInt32,
    dynamic_offset_count: Int,
    dynamic_offsets: UnsafePointer[UInt32],
    group: WGPUBindGroup = WGPUBindGroup(),
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderSetBindGroup(
        handle, group_index, group, dynamic_offset_count, dynamic_offsets
    )


var _wgpuRenderPassEncoderDraw = _wgpu.get_function[
    fn (WGPURenderPassEncoder, UInt32, UInt32, UInt32, UInt32) -> None
]("wgpuRenderPassEncoderDraw")


fn render_pass_encoder_draw(
    handle: WGPURenderPassEncoder,
    vertex_count: UInt32,
    instance_count: UInt32,
    first_vertex: UInt32,
    first_instance: UInt32,
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderDraw(
        handle, vertex_count, instance_count, first_vertex, first_instance
    )


var _wgpuRenderPassEncoderDrawIndexed = _wgpu.get_function[
    fn (WGPURenderPassEncoder, UInt32, UInt32, UInt32, Int32, UInt32) -> None
]("wgpuRenderPassEncoderDrawIndexed")


fn render_pass_encoder_draw_indexed(
    handle: WGPURenderPassEncoder,
    index_count: UInt32,
    instance_count: UInt32,
    first_index: UInt32,
    base_vertex: Int32,
    first_instance: UInt32,
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderDrawIndexed(
        handle,
        index_count,
        instance_count,
        first_index,
        base_vertex,
        first_instance,
    )


var _wgpuRenderPassEncoderDrawIndirect = _wgpu.get_function[
    fn (WGPURenderPassEncoder, WGPUBuffer, UInt64) -> None
]("wgpuRenderPassEncoderDrawIndirect")


fn render_pass_encoder_draw_indirect(
    handle: WGPURenderPassEncoder,
    indirect_buffer: WGPUBuffer,
    indirect_offset: UInt64,
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderDrawIndirect(
        handle, indirect_buffer, indirect_offset
    )


var _wgpuRenderPassEncoderDrawIndexedIndirect = _wgpu.get_function[
    fn (WGPURenderPassEncoder, WGPUBuffer, UInt64) -> None
]("wgpuRenderPassEncoderDrawIndexedIndirect")


fn render_pass_encoder_draw_indexed_indirect(
    handle: WGPURenderPassEncoder,
    indirect_buffer: WGPUBuffer,
    indirect_offset: UInt64,
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderDrawIndexedIndirect(
        handle, indirect_buffer, indirect_offset
    )


var _wgpuRenderPassEncoderExecuteBundles = _wgpu.get_function[
    fn (WGPURenderPassEncoder, Int32, UnsafePointer[WGPURenderBundle]) -> None
]("wgpuRenderPassEncoderExecuteBundles")


fn render_pass_encoder_execute_bundles(
    handle: WGPURenderPassEncoder,
    bundle_count: Int,
    bundles: UnsafePointer[WGPURenderBundle],
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderExecuteBundles(handle, bundle_count, bundles)


var _wgpuRenderPassEncoderInsertDebugMarker = _wgpu.get_function[
    fn (WGPURenderPassEncoder, UnsafePointer[Int8]) -> None
]("wgpuRenderPassEncoderInsertDebugMarker")


fn render_pass_encoder_insert_debug_marker(
    handle: WGPURenderPassEncoder, marker_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderInsertDebugMarker(handle, marker_label)


var _wgpuRenderPassEncoderPopDebugGroup = _wgpu.get_function[
    fn (WGPURenderPassEncoder,) -> None
]("wgpuRenderPassEncoderPopDebugGroup")


fn render_pass_encoder_pop_debug_group(
    handle: WGPURenderPassEncoder,
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderPopDebugGroup(
        handle,
    )


var _wgpuRenderPassEncoderPushDebugGroup = _wgpu.get_function[
    fn (WGPURenderPassEncoder, UnsafePointer[Int8]) -> None
]("wgpuRenderPassEncoderPushDebugGroup")


fn render_pass_encoder_push_debug_group(
    handle: WGPURenderPassEncoder, group_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderPushDebugGroup(handle, group_label)


var _wgpuRenderPassEncoderSetStencilReference = _wgpu.get_function[
    fn (WGPURenderPassEncoder, UInt32) -> None
]("wgpuRenderPassEncoderSetStencilReference")


fn render_pass_encoder_set_stencil_reference(
    handle: WGPURenderPassEncoder, reference: UInt32
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderSetStencilReference(handle, reference)


var _wgpuRenderPassEncoderSetBlendConstant = _wgpu.get_function[
    fn (WGPURenderPassEncoder, UnsafePointer[WGPUColor]) -> None
]("wgpuRenderPassEncoderSetBlendConstant")


fn render_pass_encoder_set_blend_constant(
    handle: WGPURenderPassEncoder, color: WGPUColor
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderSetBlendConstant(
        handle, UnsafePointer.address_of(color)
    )


var _wgpuRenderPassEncoderSetViewport = _wgpu.get_function[
    fn (
        WGPURenderPassEncoder,
        Float32,
        Float32,
        Float32,
        Float32,
        Float32,
        Float32,
    ) -> None
]("wgpuRenderPassEncoderSetViewport")


fn render_pass_encoder_set_viewport(
    handle: WGPURenderPassEncoder,
    x: Float32,
    y: Float32,
    width: Float32,
    height: Float32,
    min_depth: Float32,
    max_depth: Float32,
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderSetViewport(
        handle, x, y, width, height, min_depth, max_depth
    )


var _wgpuRenderPassEncoderSetScissorRect = _wgpu.get_function[
    fn (WGPURenderPassEncoder, UInt32, UInt32, UInt32, UInt32) -> None
]("wgpuRenderPassEncoderSetScissorRect")


fn render_pass_encoder_set_scissor_rect(
    handle: WGPURenderPassEncoder,
    x: UInt32,
    y: UInt32,
    width: UInt32,
    height: UInt32,
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderSetScissorRect(handle, x, y, width, height)


var _wgpuRenderPassEncoderSetVertexBuffer = _wgpu.get_function[
    fn (WGPURenderPassEncoder, UInt32, WGPUBuffer, UInt64, UInt64) -> None
]("wgpuRenderPassEncoderSetVertexBuffer")


fn render_pass_encoder_set_vertex_buffer(
    handle: WGPURenderPassEncoder,
    slot: UInt32,
    offset: UInt64,
    size: UInt64,
    buffer: WGPUBuffer = WGPUBuffer(),
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderSetVertexBuffer(
        handle, slot, buffer, offset, size
    )


var _wgpuRenderPassEncoderSetIndexBuffer = _wgpu.get_function[
    fn (WGPURenderPassEncoder, WGPUBuffer, IndexFormat, UInt64, UInt64) -> None
]("wgpuRenderPassEncoderSetIndexBuffer")


fn render_pass_encoder_set_index_buffer(
    handle: WGPURenderPassEncoder,
    buffer: WGPUBuffer,
    format: IndexFormat,
    offset: UInt64,
    size: UInt64,
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderSetIndexBuffer(
        handle, buffer, format, offset, size
    )


var _wgpuRenderPassEncoderBeginOcclusionQuery = _wgpu.get_function[
    fn (WGPURenderPassEncoder, UInt32) -> None
]("wgpuRenderPassEncoderBeginOcclusionQuery")


fn render_pass_encoder_begin_occlusion_query(
    handle: WGPURenderPassEncoder, query_index: UInt32
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderBeginOcclusionQuery(handle, query_index)


var _wgpuRenderPassEncoderEndOcclusionQuery = _wgpu.get_function[
    fn (WGPURenderPassEncoder,) -> None
]("wgpuRenderPassEncoderEndOcclusionQuery")


fn render_pass_encoder_end_occlusion_query(
    handle: WGPURenderPassEncoder,
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderEndOcclusionQuery(
        handle,
    )


var _wgpuRenderPassEncoderEnd = _wgpu.get_function[
    fn (WGPURenderPassEncoder,) -> None
]("wgpuRenderPassEncoderEnd")


fn render_pass_encoder_end(
    handle: WGPURenderPassEncoder,
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderEnd(
        handle,
    )


var _wgpuRenderPassEncoderSetLabel = _wgpu.get_function[
    fn (WGPURenderPassEncoder, UnsafePointer[Int8]) -> None
]("wgpuRenderPassEncoderSetLabel")


fn render_pass_encoder_set_label(
    handle: WGPURenderPassEncoder, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuRenderPassEncoderSetLabel(handle, label)


struct _RenderPipelineImpl:
    pass


alias WGPURenderPipeline = UnsafePointer[_RenderPipelineImpl]


fn render_pipeline_release(handle: WGPURenderPipeline):
    _wgpu.get_function[fn (UnsafePointer[_RenderPipelineImpl]) -> None](
        "wgpuRenderPipelineRelease"
    )(handle)


var _wgpuRenderPipelineGetBindGroupLayout = _wgpu.get_function[
    fn (WGPURenderPipeline, UInt32) -> WGPUBindGroupLayout
]("wgpuRenderPipelineGetBindGroupLayout")


fn render_pipeline_get_bind_group_layout(
    handle: WGPURenderPipeline, group_index: UInt32
) -> WGPUBindGroupLayout:
    """
    TODO
    """
    return _wgpuRenderPipelineGetBindGroupLayout(handle, group_index)


var _wgpuRenderPipelineSetLabel = _wgpu.get_function[
    fn (WGPURenderPipeline, UnsafePointer[Int8]) -> None
]("wgpuRenderPipelineSetLabel")


fn render_pipeline_set_label(
    handle: WGPURenderPipeline, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuRenderPipelineSetLabel(handle, label)


struct _SamplerImpl:
    pass


alias WGPUSampler = UnsafePointer[_SamplerImpl]


fn sampler_release(handle: WGPUSampler):
    _wgpu.get_function[fn (UnsafePointer[_SamplerImpl]) -> None](
        "wgpuSamplerRelease"
    )(handle)


var _wgpuSamplerSetLabel = _wgpu.get_function[
    fn (WGPUSampler, UnsafePointer[Int8]) -> None
]("wgpuSamplerSetLabel")


fn sampler_set_label(handle: WGPUSampler, label: UnsafePointer[Int8]) -> None:
    """
    TODO
    """
    return _wgpuSamplerSetLabel(handle, label)


struct _ShaderModuleImpl:
    pass


alias WGPUShaderModule = UnsafePointer[_ShaderModuleImpl]


fn shader_module_release(handle: WGPUShaderModule):
    _wgpu.get_function[fn (UnsafePointer[_ShaderModuleImpl]) -> None](
        "wgpuShaderModuleRelease"
    )(handle)


var _wgpuShaderModuleGetCompilationInfo = _wgpu.get_function[
    fn (
        WGPUShaderModule,
        fn (
            CompilationInfoRequestStatus,
            UnsafePointer[WGPUCompilationInfo],
            UnsafePointer[NoneType],
        ) -> None,
        UnsafePointer[NoneType],
    ) -> None
]("wgpuShaderModuleGetCompilationInfo")


fn shader_module_get_compilation_info(
    handle: WGPUShaderModule,
    callback: fn (
        CompilationInfoRequestStatus,
        UnsafePointer[WGPUCompilationInfo],
        UnsafePointer[NoneType],
    ) -> None,
    user_data: UnsafePointer[NoneType],
) -> None:
    """
    TODO
    """
    return _wgpuShaderModuleGetCompilationInfo(handle, callback, user_data)


var _wgpuShaderModuleSetLabel = _wgpu.get_function[
    fn (WGPUShaderModule, UnsafePointer[Int8]) -> None
]("wgpuShaderModuleSetLabel")


fn shader_module_set_label(
    handle: WGPUShaderModule, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuShaderModuleSetLabel(handle, label)


struct _SurfaceImpl:
    pass


alias WGPUSurface = UnsafePointer[_SurfaceImpl]


fn surface_release(handle: WGPUSurface):
    _wgpu.get_function[fn (UnsafePointer[_SurfaceImpl]) -> None](
        "wgpuSurfaceRelease"
    )(handle)


var _wgpuSurfaceConfigure = _wgpu.get_function[
    fn (WGPUSurface, UnsafePointer[WGPUSurfaceConfiguration]) -> None
]("wgpuSurfaceConfigure")


fn surface_configure(
    handle: WGPUSurface, config: WGPUSurfaceConfiguration
) -> None:
    """
    TODO
    """
    return _wgpuSurfaceConfigure(handle, UnsafePointer.address_of(config))


var _wgpuSurfaceGetCapabilities = _wgpu.get_function[
    fn (
        WGPUSurface, WGPUAdapter, UnsafePointer[WGPUSurfaceCapabilities]
    ) -> None
]("wgpuSurfaceGetCapabilities")

var _wgpuSurfaceCapabilitiesFreeMembers = _wgpu.get_function[
    fn (UnsafePointer[WGPUSurfaceCapabilities]) -> None
]("wgpuSurfaceCapabilitiesFreeMembers")


fn surface_capabilities_free_members(capabilities: WGPUSurfaceCapabilities):
    _wgpuSurfaceCapabilitiesFreeMembers(UnsafePointer.address_of(capabilities))


fn surface_get_capabilities(
    handle: WGPUSurface,
    adapter: WGPUAdapter,
    capabilities: WGPUSurfaceCapabilities,
) -> None:
    """
    TODO
    """
    return _wgpuSurfaceGetCapabilities(
        handle, adapter, UnsafePointer.address_of(capabilities)
    )


var _wgpuSurfaceGetCurrentTexture = _wgpu.get_function[
    fn (WGPUSurface, UnsafePointer[WGPUSurfaceTexture]) -> None
]("wgpuSurfaceGetCurrentTexture")


fn surface_get_current_texture(
    handle: WGPUSurface, surface_texture: WGPUSurfaceTexture
) -> None:
    """
    TODO
    """
    return _wgpuSurfaceGetCurrentTexture(
        handle, UnsafePointer.address_of(surface_texture)
    )


var _wgpuSurfacePresent = _wgpu.get_function[fn (WGPUSurface,) -> None](
    "wgpuSurfacePresent"
)


fn surface_present(
    handle: WGPUSurface,
) -> None:
    """
    TODO
    """
    return _wgpuSurfacePresent(
        handle,
    )


var _wgpuSurfaceUnconfigure = _wgpu.get_function[fn (WGPUSurface,) -> None](
    "wgpuSurfaceUnconfigure"
)


fn surface_unconfigure(
    handle: WGPUSurface,
) -> None:
    """
    TODO
    """
    return _wgpuSurfaceUnconfigure(
        handle,
    )


var _wgpuSurfaceSetLabel = _wgpu.get_function[
    fn (WGPUSurface, UnsafePointer[Int8]) -> None
]("wgpuSurfaceSetLabel")


fn surface_set_label(handle: WGPUSurface, label: UnsafePointer[Int8]) -> None:
    """
    TODO
    """
    return _wgpuSurfaceSetLabel(handle, label)


struct _TextureImpl:
    pass


alias WGPUTexture = UnsafePointer[_TextureImpl]


fn texture_release(handle: WGPUTexture):
    _wgpu.get_function[fn (UnsafePointer[_TextureImpl]) -> None](
        "wgpuTextureRelease"
    )(handle)


var _wgpuTextureCreateView = _wgpu.get_function[
    fn (
        WGPUTexture, UnsafePointer[WGPUTextureViewDescriptor]
    ) -> WGPUTextureView
]("wgpuTextureCreateView")


fn texture_create_view(
    handle: WGPUTexture,
    descriptor: WGPUTextureViewDescriptor = WGPUTextureViewDescriptor(),
) -> WGPUTextureView:
    """
    TODO
    """
    return _wgpuTextureCreateView(handle, UnsafePointer.address_of(descriptor))


var _wgpuTextureSetLabel = _wgpu.get_function[
    fn (WGPUTexture, UnsafePointer[Int8]) -> None
]("wgpuTextureSetLabel")


fn texture_set_label(handle: WGPUTexture, label: UnsafePointer[Int8]) -> None:
    """
    TODO
    """
    return _wgpuTextureSetLabel(handle, label)


var _wgpuTextureGetWidth = _wgpu.get_function[fn (WGPUTexture,) -> UInt32](
    "wgpuTextureGetWidth"
)


fn texture_get_width(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return _wgpuTextureGetWidth(
        handle,
    )


var _wgpuTextureGetHeight = _wgpu.get_function[fn (WGPUTexture,) -> UInt32](
    "wgpuTextureGetHeight"
)


fn texture_get_height(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return _wgpuTextureGetHeight(
        handle,
    )


var _wgpuTextureGetDepthOrArrayLayers = _wgpu.get_function[
    fn (WGPUTexture,) -> UInt32
]("wgpuTextureGetDepthOrArrayLayers")


fn texture_get_depth_or_array_layers(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return _wgpuTextureGetDepthOrArrayLayers(
        handle,
    )


var _wgpuTextureGetMipLevelCount = _wgpu.get_function[
    fn (WGPUTexture,) -> UInt32
]("wgpuTextureGetMipLevelCount")


fn texture_get_mip_level_count(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return _wgpuTextureGetMipLevelCount(
        handle,
    )


var _wgpuTextureGetSampleCount = _wgpu.get_function[
    fn (WGPUTexture,) -> UInt32
]("wgpuTextureGetSampleCount")


fn texture_get_sample_count(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return _wgpuTextureGetSampleCount(
        handle,
    )


var _wgpuTextureGetDimension = _wgpu.get_function[
    fn (WGPUTexture,) -> TextureDimension
]("wgpuTextureGetDimension")


fn texture_get_dimension(
    handle: WGPUTexture,
) -> TextureDimension:
    """
    TODO
    """
    return _wgpuTextureGetDimension(
        handle,
    )


var _wgpuTextureGetFormat = _wgpu.get_function[
    fn (WGPUTexture,) -> TextureFormat
]("wgpuTextureGetFormat")


fn texture_get_format(
    handle: WGPUTexture,
) -> TextureFormat:
    """
    TODO
    """
    return _wgpuTextureGetFormat(
        handle,
    )


var _wgpuTextureGetUsage = _wgpu.get_function[
    fn (WGPUTexture,) -> TextureUsage
]("wgpuTextureGetUsage")


fn texture_get_usage(
    handle: WGPUTexture,
) -> TextureUsage:
    """
    TODO
    """
    return _wgpuTextureGetUsage(
        handle,
    )


var _wgpuTextureDestroy = _wgpu.get_function[fn (WGPUTexture,) -> None](
    "wgpuTextureDestroy"
)


fn texture_destroy(
    handle: WGPUTexture,
) -> None:
    """
    TODO
    """
    return _wgpuTextureDestroy(
        handle,
    )


struct _TextureViewImpl:
    pass


alias WGPUTextureView = UnsafePointer[_TextureViewImpl]


fn texture_view_release(handle: WGPUTextureView):
    _wgpu.get_function[fn (UnsafePointer[_TextureViewImpl]) -> None](
        "wgpuTextureViewRelease"
    )(handle)


var _wgpuTextureViewSetLabel = _wgpu.get_function[
    fn (WGPUTextureView, UnsafePointer[Int8]) -> None
]("wgpuTextureViewSetLabel")


fn texture_view_set_label(
    handle: WGPUTextureView, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    return _wgpuTextureViewSetLabel(handle, label)


@value
struct WGPURequestAdapterOptions:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var compatible_surface: WGPUSurface
    var power_preference: PowerPreference
    var backend_type: BackendType
    var force_fallback_adapter: Bool

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        compatible_surface: WGPUSurface = WGPUSurface(),
        power_preference: PowerPreference = PowerPreference(0),
        backend_type: BackendType = BackendType(0),
        force_fallback_adapter: Bool = False,
    ):
        self.next_in_chain = next_in_chain
        self.compatible_surface = compatible_surface
        self.power_preference = power_preference
        self.backend_type = backend_type
        self.force_fallback_adapter = force_fallback_adapter


@value
struct WGPUAdapterInfo:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStructOut]
    var vendor: UnsafePointer[Int8]
    var architecture: UnsafePointer[Int8]
    var device: UnsafePointer[Int8]
    var description: UnsafePointer[Int8]
    var backend_type: BackendType
    var adapter_type: AdapterType
    var vendor_ID: UInt32
    var device_ID: UInt32

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStructOut] = UnsafePointer[
            ChainedStructOut
        ](),
        vendor: UnsafePointer[Int8] = UnsafePointer[Int8](),
        architecture: UnsafePointer[Int8] = UnsafePointer[Int8](),
        device: UnsafePointer[Int8] = UnsafePointer[Int8](),
        description: UnsafePointer[Int8] = UnsafePointer[Int8](),
        backend_type: BackendType = BackendType(0),
        adapter_type: AdapterType = AdapterType(0),
        vendor_ID: UInt32 = UInt32(),
        device_ID: UInt32 = UInt32(),
    ):
        self.next_in_chain = next_in_chain
        self.vendor = vendor
        self.architecture = architecture
        self.device = device
        self.description = description
        self.backend_type = backend_type
        self.adapter_type = adapter_type
        self.vendor_ID = vendor_ID
        self.device_ID = device_ID


@value
struct WGPUDeviceDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var required_feature_count: Int
    var required_features: UnsafePointer[FeatureName]
    var required_limits: UnsafePointer[WGPURequiredLimits]
    var default_queue: WGPUQueueDescriptor
    var device_lost_callback: UnsafePointer[NoneType]
    var device_lost_userdata: UnsafePointer[NoneType]
    var uncaptured_error_callback_info: UnsafePointer[NoneType]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        required_feature_count: Int = Int(),
        required_features: UnsafePointer[FeatureName] = UnsafePointer[
            FeatureName
        ](),
        required_limits: UnsafePointer[WGPURequiredLimits] = UnsafePointer[
            WGPURequiredLimits
        ](),
        owned default_queue: WGPUQueueDescriptor = WGPUQueueDescriptor(),
        device_lost_callback: UnsafePointer[NoneType] = UnsafePointer[
            NoneType
        ](),
        device_lost_userdata: UnsafePointer[NoneType] = UnsafePointer[
            NoneType
        ](),
        uncaptured_error_callback_info: UnsafePointer[NoneType] = UnsafePointer[
            NoneType
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.required_feature_count = required_feature_count
        self.required_features = required_features
        self.required_limits = required_limits
        self.default_queue = default_queue^
        self.device_lost_callback = device_lost_callback
        self.device_lost_userdata = device_lost_userdata
        self.uncaptured_error_callback_info = uncaptured_error_callback_info


@value
struct WGPUBindGroupEntry:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var binding: UInt32
    var buffer: WGPUBuffer
    var offset: UInt64
    var size: UInt64
    var sampler: WGPUSampler
    var texture_view: WGPUTextureView

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        binding: UInt32 = UInt32(),
        buffer: WGPUBuffer = WGPUBuffer(),
        offset: UInt64 = UInt64(),
        size: UInt64 = UInt64(),
        sampler: WGPUSampler = WGPUSampler(),
        texture_view: WGPUTextureView = WGPUTextureView(),
    ):
        self.next_in_chain = next_in_chain
        self.binding = binding
        self.buffer = buffer
        self.offset = offset
        self.size = size
        self.sampler = sampler
        self.texture_view = texture_view


@value
struct WGPUBindGroupDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var layout: WGPUBindGroupLayout
    var entrie_count: Int
    var entries: UnsafePointer[WGPUBindGroupEntry]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        layout: WGPUBindGroupLayout = WGPUBindGroupLayout(),
        entrie_count: Int = Int(),
        entries: UnsafePointer[WGPUBindGroupEntry] = UnsafePointer[
            WGPUBindGroupEntry
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.layout = layout
        self.entrie_count = entrie_count
        self.entries = entries


@value
struct WGPUBufferBindingLayout:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var type: BufferBindingType
    var has_dynamic_offset: Bool
    var min_binding_size: UInt64

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        type: BufferBindingType = BufferBindingType(0),
        has_dynamic_offset: Bool = False,
        min_binding_size: UInt64 = UInt64(),
    ):
        self.next_in_chain = next_in_chain
        self.type = type
        self.has_dynamic_offset = has_dynamic_offset
        self.min_binding_size = min_binding_size


@value
struct WGPUSamplerBindingLayout:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var type: SamplerBindingType

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        type: SamplerBindingType = SamplerBindingType(0),
    ):
        self.next_in_chain = next_in_chain
        self.type = type


@value
struct WGPUTextureBindingLayout:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var sample_type: TextureSampleType
    var view_dimension: TextureViewDimension
    var multisampled: Bool

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        sample_type: TextureSampleType = TextureSampleType(0),
        view_dimension: TextureViewDimension = TextureViewDimension(0),
        multisampled: Bool = False,
    ):
        self.next_in_chain = next_in_chain
        self.sample_type = sample_type
        self.view_dimension = view_dimension
        self.multisampled = multisampled


@value
struct WGPUSurfaceCapabilities:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStructOut]
    var usages: TextureUsage
    var format_count: Int
    var formats: UnsafePointer[TextureFormat]
    var present_mode_count: Int
    var present_modes: UnsafePointer[PresentMode]
    var alpha_mode_count: Int
    var alpha_modes: UnsafePointer[CompositeAlphaMode]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStructOut] = UnsafePointer[
            ChainedStructOut
        ](),
        usages: TextureUsage = TextureUsage(0),
        format_count: Int = Int(),
        formats: UnsafePointer[TextureFormat] = UnsafePointer[TextureFormat](),
        present_mode_count: Int = Int(),
        present_modes: UnsafePointer[PresentMode] = UnsafePointer[
            PresentMode
        ](),
        alpha_mode_count: Int = Int(),
        alpha_modes: UnsafePointer[CompositeAlphaMode] = UnsafePointer[
            CompositeAlphaMode
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.usages = usages
        self.format_count = format_count
        self.formats = formats
        self.present_mode_count = present_mode_count
        self.present_modes = present_modes
        self.alpha_mode_count = alpha_mode_count
        self.alpha_modes = alpha_modes


@value
struct WGPUSurfaceConfiguration:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var device: WGPUDevice
    var format: TextureFormat
    var usage: TextureUsage
    var view_format_count: Int
    var view_formats: UnsafePointer[TextureFormat]
    var alpha_mode: CompositeAlphaMode
    var width: UInt32
    var height: UInt32
    var present_mode: PresentMode

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        device: WGPUDevice = WGPUDevice(),
        format: TextureFormat = TextureFormat(0),
        usage: TextureUsage = TextureUsage(0),
        view_format_count: Int = Int(),
        view_formats: UnsafePointer[TextureFormat] = UnsafePointer[
            TextureFormat
        ](),
        alpha_mode: CompositeAlphaMode = CompositeAlphaMode(0),
        width: UInt32 = UInt32(),
        height: UInt32 = UInt32(),
        present_mode: PresentMode = PresentMode(0),
    ):
        self.next_in_chain = next_in_chain
        self.device = device
        self.format = format
        self.usage = usage
        self.view_format_count = view_format_count
        self.view_formats = view_formats
        self.alpha_mode = alpha_mode
        self.width = width
        self.height = height
        self.present_mode = present_mode


@value
struct WGPUStorageTextureBindingLayout:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var access: StorageTextureAccess
    var format: TextureFormat
    var view_dimension: TextureViewDimension

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        access: StorageTextureAccess = StorageTextureAccess(0),
        format: TextureFormat = TextureFormat(0),
        view_dimension: TextureViewDimension = TextureViewDimension(0),
    ):
        self.next_in_chain = next_in_chain
        self.access = access
        self.format = format
        self.view_dimension = view_dimension


@value
struct WGPUBindGroupLayoutEntry:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var binding: UInt32
    var visibility: ShaderStage
    var buffer: WGPUBufferBindingLayout
    var sampler: WGPUSamplerBindingLayout
    var texture: WGPUTextureBindingLayout
    var storage_texture: WGPUStorageTextureBindingLayout

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        binding: UInt32 = UInt32(),
        visibility: ShaderStage = ShaderStage(0),
        owned buffer: WGPUBufferBindingLayout = WGPUBufferBindingLayout(),
        owned sampler: WGPUSamplerBindingLayout = WGPUSamplerBindingLayout(),
        owned texture: WGPUTextureBindingLayout = WGPUTextureBindingLayout(),
        owned storage_texture: WGPUStorageTextureBindingLayout = WGPUStorageTextureBindingLayout(),
    ):
        self.next_in_chain = next_in_chain
        self.binding = binding
        self.visibility = visibility
        self.buffer = buffer^
        self.sampler = sampler^
        self.texture = texture^
        self.storage_texture = storage_texture^


@value
struct WGPUBindGroupLayoutDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var entrie_count: Int
    var entries: UnsafePointer[WGPUBindGroupLayoutEntry]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        entrie_count: Int = Int(),
        entries: UnsafePointer[WGPUBindGroupLayoutEntry] = UnsafePointer[
            WGPUBindGroupLayoutEntry
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.entrie_count = entrie_count
        self.entries = entries


@value
struct WGPUBlendComponent:
    """
    TODO
    """

    var operation: BlendOperation
    var src_factor: BlendFactor
    var dst_factor: BlendFactor

    fn __init__(
        out self,
        operation: BlendOperation = BlendOperation(0),
        src_factor: BlendFactor = BlendFactor(0),
        dst_factor: BlendFactor = BlendFactor(0),
    ):
        self.operation = operation
        self.src_factor = src_factor
        self.dst_factor = dst_factor


@value
struct WGPUBufferDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var usage: BufferUsage
    var size: UInt64
    var mapped_at_creation: Bool

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        usage: BufferUsage = BufferUsage(0),
        size: UInt64 = UInt64(),
        mapped_at_creation: Bool = False,
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.usage = usage
        self.size = size
        self.mapped_at_creation = mapped_at_creation


@value
struct WGPUColor:
    """
    TODO
    """

    var r: Float64
    var g: Float64
    var b: Float64
    var a: Float64

    fn __init__(
        out self,
        r: Float64 = Float64(),
        g: Float64 = Float64(),
        b: Float64 = Float64(),
        a: Float64 = Float64(),
    ):
        self.r = r
        self.g = g
        self.b = b
        self.a = a


@value
struct WGPUConstantEntry:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var key: UnsafePointer[Int8]
    var value: Float64

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        key: UnsafePointer[Int8] = UnsafePointer[Int8](),
        value: Float64 = Float64(),
    ):
        self.next_in_chain = next_in_chain
        self.key = key
        self.value = value


@value
struct WGPUCommandBufferDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label


@value
struct WGPUCommandEncoderDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label


@value
struct WGPUCompilationInfo:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var message_count: Int
    var messages: UnsafePointer[WGPUCompilationMessage]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        message_count: Int = Int(),
        messages: UnsafePointer[WGPUCompilationMessage] = UnsafePointer[
            WGPUCompilationMessage
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.message_count = message_count
        self.messages = messages


@value
struct WGPUCompilationMessage:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var message: UnsafePointer[Int8]
    var type: CompilationMessageType
    var line_num: UInt64
    var line_pos: UInt64
    var offset: UInt64
    var length: UInt64
    var utf16_line_pos: UInt64
    var utf16_offset: UInt64
    var utf16_length: UInt64

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        message: UnsafePointer[Int8] = UnsafePointer[Int8](),
        type: CompilationMessageType = CompilationMessageType(0),
        line_num: UInt64 = UInt64(),
        line_pos: UInt64 = UInt64(),
        offset: UInt64 = UInt64(),
        length: UInt64 = UInt64(),
        utf16_line_pos: UInt64 = UInt64(),
        utf16_offset: UInt64 = UInt64(),
        utf16_length: UInt64 = UInt64(),
    ):
        self.next_in_chain = next_in_chain
        self.message = message
        self.type = type
        self.line_num = line_num
        self.line_pos = line_pos
        self.offset = offset
        self.length = length
        self.utf16_line_pos = utf16_line_pos
        self.utf16_offset = utf16_offset
        self.utf16_length = utf16_length


@value
struct WGPUComputePassDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var timestamp_writes: UnsafePointer[WGPUComputePassTimestampWrites]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        timestamp_writes: UnsafePointer[
            WGPUComputePassTimestampWrites
        ] = UnsafePointer[WGPUComputePassTimestampWrites](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.timestamp_writes = timestamp_writes


@value
struct WGPUComputePassTimestampWrites:
    """
    TODO
    """

    var query_set: WGPUQuerySet
    var beginning_of_pass_write_index: UInt32
    var end_of_pass_write_index: UInt32

    fn __init__(
        out self,
        query_set: WGPUQuerySet = WGPUQuerySet(),
        beginning_of_pass_write_index: UInt32 = UInt32(),
        end_of_pass_write_index: UInt32 = UInt32(),
    ):
        self.query_set = query_set
        self.beginning_of_pass_write_index = beginning_of_pass_write_index
        self.end_of_pass_write_index = end_of_pass_write_index


@value
struct WGPUComputePipelineDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var layout: WGPUPipelineLayout
    var compute: WGPUProgrammableStageDescriptor

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        layout: WGPUPipelineLayout = WGPUPipelineLayout(),
        owned compute: WGPUProgrammableStageDescriptor = WGPUProgrammableStageDescriptor(),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.layout = layout
        self.compute = compute^


@value
struct WGPULimits:
    """
    TODO
    """

    var max_texture_dimension_1D: UInt32
    var max_texture_dimension_2D: UInt32
    var max_texture_dimension_3D: UInt32
    var max_texture_array_layers: UInt32
    var max_bind_groups: UInt32
    var max_bind_groups_plus_vertex_buffers: UInt32
    var max_bindings_per_bind_group: UInt32
    var max_dynamic_uniform_buffers_per_pipeline_layout: UInt32
    var max_dynamic_storage_buffers_per_pipeline_layout: UInt32
    var max_sampled_textures_per_shader_stage: UInt32
    var max_samplers_per_shader_stage: UInt32
    var max_storage_buffers_per_shader_stage: UInt32
    var max_storage_textures_per_shader_stage: UInt32
    var max_uniform_buffers_per_shader_stage: UInt32
    var max_uniform_buffer_binding_size: UInt64
    var max_storage_buffer_binding_size: UInt64
    var min_uniform_buffer_offset_alignment: UInt32
    var min_storage_buffer_offset_alignment: UInt32
    var max_vertex_buffers: UInt32
    var max_buffer_size: UInt64
    var max_vertex_attributes: UInt32
    var max_vertex_buffer_array_stride: UInt32
    var max_inter_stage_shader_components: UInt32
    var max_inter_stage_shader_variables: UInt32
    var max_color_attachments: UInt32
    var max_color_attachment_bytes_per_sample: UInt32
    var max_compute_workgroup_storage_size: UInt32
    var max_compute_invocations_per_workgroup: UInt32
    var max_compute_workgroup_size_x: UInt32
    var max_compute_workgroup_size_y: UInt32
    var max_compute_workgroup_size_z: UInt32
    var max_compute_workgroups_per_dimension: UInt32

    fn __init__(
        out self,
        max_texture_dimension_1D: UInt32 = UInt32(),
        max_texture_dimension_2D: UInt32 = UInt32(),
        max_texture_dimension_3D: UInt32 = UInt32(),
        max_texture_array_layers: UInt32 = UInt32(),
        max_bind_groups: UInt32 = UInt32(),
        max_bind_groups_plus_vertex_buffers: UInt32 = UInt32(),
        max_bindings_per_bind_group: UInt32 = UInt32(),
        max_dynamic_uniform_buffers_per_pipeline_layout: UInt32 = UInt32(),
        max_dynamic_storage_buffers_per_pipeline_layout: UInt32 = UInt32(),
        max_sampled_textures_per_shader_stage: UInt32 = UInt32(),
        max_samplers_per_shader_stage: UInt32 = UInt32(),
        max_storage_buffers_per_shader_stage: UInt32 = UInt32(),
        max_storage_textures_per_shader_stage: UInt32 = UInt32(),
        max_uniform_buffers_per_shader_stage: UInt32 = UInt32(),
        max_uniform_buffer_binding_size: UInt64 = UInt64(),
        max_storage_buffer_binding_size: UInt64 = UInt64(),
        min_uniform_buffer_offset_alignment: UInt32 = UInt32(),
        min_storage_buffer_offset_alignment: UInt32 = UInt32(),
        max_vertex_buffers: UInt32 = UInt32(),
        max_buffer_size: UInt64 = UInt64(),
        max_vertex_attributes: UInt32 = UInt32(),
        max_vertex_buffer_array_stride: UInt32 = UInt32(),
        max_inter_stage_shader_components: UInt32 = UInt32(),
        max_inter_stage_shader_variables: UInt32 = UInt32(),
        max_color_attachments: UInt32 = UInt32(),
        max_color_attachment_bytes_per_sample: UInt32 = UInt32(),
        max_compute_workgroup_storage_size: UInt32 = UInt32(),
        max_compute_invocations_per_workgroup: UInt32 = UInt32(),
        max_compute_workgroup_size_x: UInt32 = UInt32(),
        max_compute_workgroup_size_y: UInt32 = UInt32(),
        max_compute_workgroup_size_z: UInt32 = UInt32(),
        max_compute_workgroups_per_dimension: UInt32 = UInt32(),
    ):
        self.max_texture_dimension_1D = max_texture_dimension_1D
        self.max_texture_dimension_2D = max_texture_dimension_2D
        self.max_texture_dimension_3D = max_texture_dimension_3D
        self.max_texture_array_layers = max_texture_array_layers
        self.max_bind_groups = max_bind_groups
        self.max_bind_groups_plus_vertex_buffers = (
            max_bind_groups_plus_vertex_buffers
        )
        self.max_bindings_per_bind_group = max_bindings_per_bind_group
        self.max_dynamic_uniform_buffers_per_pipeline_layout = (
            max_dynamic_uniform_buffers_per_pipeline_layout
        )
        self.max_dynamic_storage_buffers_per_pipeline_layout = (
            max_dynamic_storage_buffers_per_pipeline_layout
        )
        self.max_sampled_textures_per_shader_stage = (
            max_sampled_textures_per_shader_stage
        )
        self.max_samplers_per_shader_stage = max_samplers_per_shader_stage
        self.max_storage_buffers_per_shader_stage = (
            max_storage_buffers_per_shader_stage
        )
        self.max_storage_textures_per_shader_stage = (
            max_storage_textures_per_shader_stage
        )
        self.max_uniform_buffers_per_shader_stage = (
            max_uniform_buffers_per_shader_stage
        )
        self.max_uniform_buffer_binding_size = max_uniform_buffer_binding_size
        self.max_storage_buffer_binding_size = max_storage_buffer_binding_size
        self.min_uniform_buffer_offset_alignment = (
            min_uniform_buffer_offset_alignment
        )
        self.min_storage_buffer_offset_alignment = (
            min_storage_buffer_offset_alignment
        )
        self.max_vertex_buffers = max_vertex_buffers
        self.max_buffer_size = max_buffer_size
        self.max_vertex_attributes = max_vertex_attributes
        self.max_vertex_buffer_array_stride = max_vertex_buffer_array_stride
        self.max_inter_stage_shader_components = (
            max_inter_stage_shader_components
        )
        self.max_inter_stage_shader_variables = max_inter_stage_shader_variables
        self.max_color_attachments = max_color_attachments
        self.max_color_attachment_bytes_per_sample = (
            max_color_attachment_bytes_per_sample
        )
        self.max_compute_workgroup_storage_size = (
            max_compute_workgroup_storage_size
        )
        self.max_compute_invocations_per_workgroup = (
            max_compute_invocations_per_workgroup
        )
        self.max_compute_workgroup_size_x = max_compute_workgroup_size_x
        self.max_compute_workgroup_size_y = max_compute_workgroup_size_y
        self.max_compute_workgroup_size_z = max_compute_workgroup_size_z
        self.max_compute_workgroups_per_dimension = (
            max_compute_workgroups_per_dimension
        )


@value
struct WGPURequiredLimits:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var limits: WGPULimits

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        owned limits: WGPULimits = WGPULimits(),
    ):
        self.next_in_chain = next_in_chain
        self.limits = limits^


@value
struct WGPUSupportedLimits:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStructOut]
    var limits: WGPULimits

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStructOut] = UnsafePointer[
            ChainedStructOut
        ](),
        owned limits: WGPULimits = WGPULimits(),
    ):
        self.next_in_chain = next_in_chain
        self.limits = limits^


@value
struct WGPUExtent3D:
    """
    TODO
    """

    var width: UInt32
    var height: UInt32
    var depth_or_array_layers: UInt32

    fn __init__(
        out self,
        width: UInt32 = UInt32(),
        height: UInt32 = UInt32(),
        depth_or_array_layers: UInt32 = UInt32(),
    ):
        self.width = width
        self.height = height
        self.depth_or_array_layers = depth_or_array_layers


@value
struct WGPUImageCopyBuffer:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var layout: WGPUTextureDataLayout
    var buffer: WGPUBuffer

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        owned layout: WGPUTextureDataLayout = WGPUTextureDataLayout(),
        buffer: WGPUBuffer = WGPUBuffer(),
    ):
        self.next_in_chain = next_in_chain
        self.layout = layout^
        self.buffer = buffer


@value
struct WGPUImageCopyTexture:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var texture: WGPUTexture
    var mip_level: UInt32
    var origin: WGPUOrigin3D
    var aspect: TextureAspect

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        texture: WGPUTexture = WGPUTexture(),
        mip_level: UInt32 = UInt32(),
        owned origin: WGPUOrigin3D = WGPUOrigin3D(),
        aspect: TextureAspect = TextureAspect(0),
    ):
        self.next_in_chain = next_in_chain
        self.texture = texture
        self.mip_level = mip_level
        self.origin = origin^
        self.aspect = aspect


@value
struct WGPUInstanceDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
    ):
        self.next_in_chain = next_in_chain


@value
struct WGPUVertexAttribute:
    """
    TODO
    """

    var format: VertexFormat
    var offset: UInt64
    var shader_location: UInt32

    fn __init__(
        out self,
        format: VertexFormat = VertexFormat(0),
        offset: UInt64 = UInt64(),
        shader_location: UInt32 = UInt32(),
    ):
        self.format = format
        self.offset = offset
        self.shader_location = shader_location


@value
struct WGPUVertexBufferLayout:
    """
    TODO
    """

    var array_stride: UInt64
    var step_mode: VertexStepMode
    var attribute_count: Int
    var attributes: UnsafePointer[WGPUVertexAttribute]

    fn __init__(
        out self,
        array_stride: UInt64 = UInt64(),
        step_mode: VertexStepMode = VertexStepMode(0),
        attribute_count: Int = Int(),
        attributes: UnsafePointer[WGPUVertexAttribute] = UnsafePointer[
            WGPUVertexAttribute
        ](),
    ):
        self.array_stride = array_stride
        self.step_mode = step_mode
        self.attribute_count = attribute_count
        self.attributes = attributes


@value
struct WGPUOrigin3D:
    """
    TODO
    """

    var x: UInt32
    var y: UInt32
    var z: UInt32

    fn __init__(
        out self,
        x: UInt32 = UInt32(),
        y: UInt32 = UInt32(),
        z: UInt32 = UInt32(),
    ):
        self.x = x
        self.y = y
        self.z = z


@value
struct WGPUPipelineLayoutDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var bind_group_layout_count: Int
    var bind_group_layouts: UnsafePointer[WGPUBindGroupLayout]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        bind_group_layout_count: Int = Int(),
        bind_group_layouts: UnsafePointer[WGPUBindGroupLayout] = UnsafePointer[
            WGPUBindGroupLayout
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.bind_group_layout_count = bind_group_layout_count
        self.bind_group_layouts = bind_group_layouts


@value
struct WGPUProgrammableStageDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var module: WGPUShaderModule
    var entry_point: UnsafePointer[Int8]
    var constant_count: Int
    var constants: UnsafePointer[WGPUConstantEntry]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        module: WGPUShaderModule = WGPUShaderModule(),
        entry_point: UnsafePointer[Int8] = UnsafePointer[Int8](),
        constant_count: Int = Int(),
        constants: UnsafePointer[WGPUConstantEntry] = UnsafePointer[
            WGPUConstantEntry
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.module = module
        self.entry_point = entry_point
        self.constant_count = constant_count
        self.constants = constants


@value
struct WGPUQuerySetDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var type: QueryType
    var count: UInt32

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        type: QueryType = QueryType(0),
        count: UInt32 = UInt32(),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.type = type
        self.count = count


@value
struct WGPUQueueDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label


@value
struct WGPURenderBundleDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label


@value
struct WGPURenderBundleEncoderDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var color_format_count: Int
    var color_formats: UnsafePointer[TextureFormat]
    var depth_stencil_format: TextureFormat
    var sample_count: UInt32
    var depth_read_only: Bool
    var stencil_read_only: Bool

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        color_format_count: Int = Int(),
        color_formats: UnsafePointer[TextureFormat] = UnsafePointer[
            TextureFormat
        ](),
        depth_stencil_format: TextureFormat = TextureFormat(0),
        sample_count: UInt32 = UInt32(),
        depth_read_only: Bool = False,
        stencil_read_only: Bool = False,
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.color_format_count = color_format_count
        self.color_formats = color_formats
        self.depth_stencil_format = depth_stencil_format
        self.sample_count = sample_count
        self.depth_read_only = depth_read_only
        self.stencil_read_only = stencil_read_only


@value
struct WGPURenderPassColorAttachment:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var view: WGPUTextureView
    var depth_slice: UInt32
    var resolve_target: WGPUTextureView
    var load_op: LoadOp
    var store_op: StoreOp
    var clear_value: WGPUColor

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        view: WGPUTextureView = WGPUTextureView(),
        depth_slice: UInt32 = UInt32(),
        resolve_target: WGPUTextureView = WGPUTextureView(),
        load_op: LoadOp = LoadOp(0),
        store_op: StoreOp = StoreOp(0),
        clear_value: WGPUColor = WGPUColor(),
    ):
        self.next_in_chain = next_in_chain
        self.view = view
        self.depth_slice = depth_slice
        self.resolve_target = resolve_target
        self.load_op = load_op
        self.store_op = store_op
        self.clear_value = clear_value


@value
struct WGPURenderPassDepthStencilAttachment:
    """
    TODO
    """

    var view: WGPUTextureView
    var depth_load_op: LoadOp
    var depth_store_op: StoreOp
    var depth_clear_value: Float32
    var depth_read_only: Bool
    var stencil_load_op: LoadOp
    var stencil_store_op: StoreOp
    var stencil_clear_value: UInt32
    var stencil_read_only: Bool

    fn __init__(
        out self,
        view: WGPUTextureView = WGPUTextureView(),
        depth_load_op: LoadOp = LoadOp(0),
        depth_store_op: StoreOp = StoreOp(0),
        depth_clear_value: Float32 = Float32(),
        depth_read_only: Bool = False,
        stencil_load_op: LoadOp = LoadOp(0),
        stencil_store_op: StoreOp = StoreOp(0),
        stencil_clear_value: UInt32 = UInt32(),
        stencil_read_only: Bool = False,
    ):
        self.view = view
        self.depth_load_op = depth_load_op
        self.depth_store_op = depth_store_op
        self.depth_clear_value = depth_clear_value
        self.depth_read_only = depth_read_only
        self.stencil_load_op = stencil_load_op
        self.stencil_store_op = stencil_store_op
        self.stencil_clear_value = stencil_clear_value
        self.stencil_read_only = stencil_read_only


@value
struct WGPURenderPassDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var color_attachment_count: Int
    var color_attachments: UnsafePointer[WGPURenderPassColorAttachment]
    var depth_stencil_attachment: UnsafePointer[
        WGPURenderPassDepthStencilAttachment
    ]
    var occlusion_query_set: WGPUQuerySet
    var timestamp_writes: UnsafePointer[WGPURenderPassTimestampWrites]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        color_attachment_count: Int = Int(),
        color_attachments: UnsafePointer[
            WGPURenderPassColorAttachment
        ] = UnsafePointer[WGPURenderPassColorAttachment](),
        depth_stencil_attachment: UnsafePointer[
            WGPURenderPassDepthStencilAttachment
        ] = UnsafePointer[WGPURenderPassDepthStencilAttachment](),
        occlusion_query_set: WGPUQuerySet = WGPUQuerySet(),
        timestamp_writes: UnsafePointer[
            WGPURenderPassTimestampWrites
        ] = UnsafePointer[WGPURenderPassTimestampWrites](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.color_attachment_count = color_attachment_count
        self.color_attachments = color_attachments
        self.depth_stencil_attachment = depth_stencil_attachment
        self.occlusion_query_set = occlusion_query_set
        self.timestamp_writes = timestamp_writes


@value
struct WGPURenderPassDescriptorMaxDrawCount:
    """
    TODO
    """

    var chain: ChainedStruct
    var max_draw_count: UInt64

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        max_draw_count: UInt64 = UInt64(),
    ):
        self.chain = chain
        self.max_draw_count = max_draw_count


@value
struct WGPURenderPassTimestampWrites:
    """
    TODO
    """

    var query_set: WGPUQuerySet
    var beginning_of_pass_write_index: UInt32
    var end_of_pass_write_index: UInt32

    fn __init__(
        out self,
        query_set: WGPUQuerySet = WGPUQuerySet(),
        beginning_of_pass_write_index: UInt32 = UInt32(),
        end_of_pass_write_index: UInt32 = UInt32(),
    ):
        self.query_set = query_set
        self.beginning_of_pass_write_index = beginning_of_pass_write_index
        self.end_of_pass_write_index = end_of_pass_write_index


@value
struct WGPUVertexState:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var module: WGPUShaderModule
    var entry_point: UnsafePointer[Int8]
    var constant_count: Int
    var constants: UnsafePointer[WGPUConstantEntry]
    var buffer_count: Int
    var buffers: UnsafePointer[WGPUVertexBufferLayout]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        module: WGPUShaderModule = WGPUShaderModule(),
        entry_point: UnsafePointer[Int8] = UnsafePointer[Int8](),
        constant_count: Int = Int(),
        constants: UnsafePointer[WGPUConstantEntry] = UnsafePointer[
            WGPUConstantEntry
        ](),
        buffer_count: Int = Int(),
        buffers: UnsafePointer[WGPUVertexBufferLayout] = UnsafePointer[
            WGPUVertexBufferLayout
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.module = module
        self.entry_point = entry_point
        self.constant_count = constant_count
        self.constants = constants
        self.buffer_count = buffer_count
        self.buffers = buffers


@value
struct WGPUPrimitiveState:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var topology: PrimitiveTopology
    var strip_index_format: IndexFormat
    var front_face: FrontFace
    var cull_mode: CullMode

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        topology: PrimitiveTopology = PrimitiveTopology(0),
        strip_index_format: IndexFormat = IndexFormat(0),
        front_face: FrontFace = FrontFace(0),
        cull_mode: CullMode = CullMode(0),
    ):
        self.next_in_chain = next_in_chain
        self.topology = topology
        self.strip_index_format = strip_index_format
        self.front_face = front_face
        self.cull_mode = cull_mode


@value
struct WGPUPrimitiveDepthClipControl:
    """
    TODO
    """

    var chain: ChainedStruct
    var unclipped_depth: Bool

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        unclipped_depth: Bool = False,
    ):
        self.chain = chain
        self.unclipped_depth = unclipped_depth


@value
struct WGPUDepthStencilState:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var format: TextureFormat
    var depth_write_enabled: Bool
    var depth_compare: CompareFunction
    var stencil_front: WGPUStencilFaceState
    var stencil_back: WGPUStencilFaceState
    var stencil_read_mask: UInt32
    var stencil_write_mask: UInt32
    var depth_bias: Int32
    var depth_bias_slope_scale: Float32
    var depth_bias_clamp: Float32

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        format: TextureFormat = TextureFormat(0),
        depth_write_enabled: Bool = False,
        depth_compare: CompareFunction = CompareFunction(0),
        owned stencil_front: WGPUStencilFaceState = WGPUStencilFaceState(),
        owned stencil_back: WGPUStencilFaceState = WGPUStencilFaceState(),
        stencil_read_mask: UInt32 = UInt32(),
        stencil_write_mask: UInt32 = UInt32(),
        depth_bias: Int32 = Int32(),
        depth_bias_slope_scale: Float32 = Float32(),
        depth_bias_clamp: Float32 = Float32(),
    ):
        self.next_in_chain = next_in_chain
        self.format = format
        self.depth_write_enabled = depth_write_enabled
        self.depth_compare = depth_compare
        self.stencil_front = stencil_front^
        self.stencil_back = stencil_back^
        self.stencil_read_mask = stencil_read_mask
        self.stencil_write_mask = stencil_write_mask
        self.depth_bias = depth_bias
        self.depth_bias_slope_scale = depth_bias_slope_scale
        self.depth_bias_clamp = depth_bias_clamp


@value
struct WGPUMultisampleState:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var count: UInt32
    var mask: UInt32
    var alpha_to_coverage_enabled: Bool

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        count: UInt32 = UInt32(),
        mask: UInt32 = UInt32(),
        alpha_to_coverage_enabled: Bool = False,
    ):
        self.next_in_chain = next_in_chain
        self.count = count
        self.mask = mask
        self.alpha_to_coverage_enabled = alpha_to_coverage_enabled


@value
struct WGPUFragmentState:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var module: WGPUShaderModule
    var entry_point: UnsafePointer[Int8]
    var constant_count: Int
    var constants: UnsafePointer[WGPUConstantEntry]
    var target_count: Int
    var targets: UnsafePointer[WGPUColorTargetState]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        module: WGPUShaderModule = WGPUShaderModule(),
        entry_point: UnsafePointer[Int8] = UnsafePointer[Int8](),
        constant_count: Int = Int(),
        constants: UnsafePointer[WGPUConstantEntry] = UnsafePointer[
            WGPUConstantEntry
        ](),
        target_count: Int = Int(),
        targets: UnsafePointer[WGPUColorTargetState] = UnsafePointer[
            WGPUColorTargetState
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.module = module
        self.entry_point = entry_point
        self.constant_count = constant_count
        self.constants = constants
        self.target_count = target_count
        self.targets = targets


@value
struct WGPUColorTargetState:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var format: TextureFormat
    var blend: UnsafePointer[WGPUBlendState]
    var write_mask: ColorWriteMask

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        format: TextureFormat = TextureFormat(0),
        blend: UnsafePointer[WGPUBlendState] = UnsafePointer[WGPUBlendState](),
        write_mask: ColorWriteMask = ColorWriteMask(0),
    ):
        self.next_in_chain = next_in_chain
        self.format = format
        self.blend = blend
        self.write_mask = write_mask


@value
struct WGPUBlendState:
    """
    TODO
    """

    var color: WGPUBlendComponent
    var alpha: WGPUBlendComponent

    fn __init__(
        out self,
        owned color: WGPUBlendComponent = WGPUBlendComponent(),
        owned alpha: WGPUBlendComponent = WGPUBlendComponent(),
    ):
        self.color = color^
        self.alpha = alpha^


@value
struct WGPURenderPipelineDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var layout: WGPUPipelineLayout
    var vertex: WGPUVertexState
    var primitive: WGPUPrimitiveState
    var depth_stencil: UnsafePointer[WGPUDepthStencilState]
    var multisample: WGPUMultisampleState
    var fragment: UnsafePointer[WGPUFragmentState]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        layout: WGPUPipelineLayout = WGPUPipelineLayout(),
        owned vertex: WGPUVertexState = WGPUVertexState(),
        owned primitive: WGPUPrimitiveState = WGPUPrimitiveState(),
        depth_stencil: UnsafePointer[WGPUDepthStencilState] = UnsafePointer[
            WGPUDepthStencilState
        ](),
        owned multisample: WGPUMultisampleState = WGPUMultisampleState(),
        fragment: UnsafePointer[WGPUFragmentState] = UnsafePointer[
            WGPUFragmentState
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.layout = layout
        self.vertex = vertex^
        self.primitive = primitive^
        self.depth_stencil = depth_stencil
        self.multisample = multisample^
        self.fragment = fragment


@value
struct WGPUSamplerDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
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

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        address_mode_u: AddressMode = AddressMode(0),
        address_mode_v: AddressMode = AddressMode(0),
        address_mode_w: AddressMode = AddressMode(0),
        mag_filter: FilterMode = FilterMode(0),
        min_filter: FilterMode = FilterMode(0),
        mipmap_filter: MipmapFilterMode = MipmapFilterMode(0),
        lod_min_clamp: Float32 = Float32(),
        lod_max_clamp: Float32 = Float32(),
        compare: CompareFunction = CompareFunction(0),
        max_anisotropy: UInt16 = UInt16(),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.address_mode_u = address_mode_u
        self.address_mode_v = address_mode_v
        self.address_mode_w = address_mode_w
        self.mag_filter = mag_filter
        self.min_filter = min_filter
        self.mipmap_filter = mipmap_filter
        self.lod_min_clamp = lod_min_clamp
        self.lod_max_clamp = lod_max_clamp
        self.compare = compare
        self.max_anisotropy = max_anisotropy


@value
struct WGPUShaderModuleDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var hint_count: Int
    var hints: UnsafePointer[WGPUShaderModuleCompilationHint]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        hint_count: Int = Int(),
        hints: UnsafePointer[WGPUShaderModuleCompilationHint] = UnsafePointer[
            WGPUShaderModuleCompilationHint
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.hint_count = hint_count
        self.hints = hints


@value
struct WGPUShaderModuleCompilationHint:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var entry_point: UnsafePointer[Int8]
    var layout: WGPUPipelineLayout

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        entry_point: UnsafePointer[Int8] = UnsafePointer[Int8](),
        layout: WGPUPipelineLayout = WGPUPipelineLayout(),
    ):
        self.next_in_chain = next_in_chain
        self.entry_point = entry_point
        self.layout = layout


@value
struct WGPUShaderModuleSpirvDescriptor:
    """
    TODO
    """

    var chain: ChainedStruct
    var code_size: UInt32
    var code: UInt32

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        code_size: UInt32 = UInt32(),
        code: UInt32 = UInt32(),
    ):
        self.chain = chain
        self.code_size = code_size
        self.code = code


@value
struct WGPUShaderModuleWgslDescriptor:
    """
    TODO
    """

    var chain: ChainedStruct
    var code: UnsafePointer[Int8]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        code: UnsafePointer[Int8] = UnsafePointer[Int8](),
    ):
        self.chain = chain
        self.code = code


@value
struct WGPUStencilFaceState:
    """
    TODO
    """

    var compare: CompareFunction
    var fail_op: StencilOperation
    var depth_fail_op: StencilOperation
    var pass_op: StencilOperation

    fn __init__(
        out self,
        compare: CompareFunction = CompareFunction(0),
        fail_op: StencilOperation = StencilOperation(0),
        depth_fail_op: StencilOperation = StencilOperation(0),
        pass_op: StencilOperation = StencilOperation(0),
    ):
        self.compare = compare
        self.fail_op = fail_op
        self.depth_fail_op = depth_fail_op
        self.pass_op = pass_op


@value
struct WGPUSurfaceDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label


@value
struct WGPUSurfaceDescriptorFromAndroidNativeWindow:
    """
    TODO
    """

    var chain: ChainedStruct
    var window: UnsafePointer[NoneType]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        window: UnsafePointer[NoneType] = UnsafePointer[NoneType](),
    ):
        self.chain = chain
        self.window = window


@value
struct WGPUSurfaceDescriptorFromCanvasHtmlSelector:
    """
    TODO
    """

    var chain: ChainedStruct
    var selector: UnsafePointer[Int8]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        selector: UnsafePointer[Int8] = UnsafePointer[Int8](),
    ):
        self.chain = chain
        self.selector = selector


@value
struct WGPUSurfaceDescriptorFromMetalLayer:
    """
    TODO
    """

    var chain: ChainedStruct
    var layer: UnsafePointer[NoneType]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        layer: UnsafePointer[NoneType] = UnsafePointer[NoneType](),
    ):
        self.chain = chain
        self.layer = layer


@value
struct WGPUSurfaceDescriptorFromWindowsHwnd:
    """
    TODO
    """

    var chain: ChainedStruct
    var hinstance: UnsafePointer[NoneType]
    var hwnd: UnsafePointer[NoneType]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        hinstance: UnsafePointer[NoneType] = UnsafePointer[NoneType](),
        hwnd: UnsafePointer[NoneType] = UnsafePointer[NoneType](),
    ):
        self.chain = chain
        self.hinstance = hinstance
        self.hwnd = hwnd


@value
struct WGPUSurfaceDescriptorFromXcbWindow:
    """
    TODO
    """

    var chain: ChainedStruct
    var connection: UnsafePointer[NoneType]
    var window: UInt32

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        connection: UnsafePointer[NoneType] = UnsafePointer[NoneType](),
        window: UInt32 = UInt32(),
    ):
        self.chain = chain
        self.connection = connection
        self.window = window


@value
struct WGPUSurfaceDescriptorFromXlibWindow:
    """
    TODO
    """

    var chain: ChainedStruct
    var display: UnsafePointer[NoneType]
    var window: UInt64

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        display: UnsafePointer[NoneType] = UnsafePointer[NoneType](),
        window: UInt64 = UInt64(),
    ):
        self.chain = chain
        self.display = display
        self.window = window


@value
struct WGPUSurfaceDescriptorFromWaylandSurface:
    """
    TODO
    """

    var chain: ChainedStruct
    var display: UnsafePointer[NoneType]
    var surface: UnsafePointer[NoneType]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        display: UnsafePointer[NoneType] = UnsafePointer[NoneType](),
        surface: UnsafePointer[NoneType] = UnsafePointer[NoneType](),
    ):
        self.chain = chain
        self.display = display
        self.surface = surface


@value
struct WGPUSurfaceTexture:
    """
    TODO
    """

    var texture: WGPUTexture
    var suboptimal: Bool
    var status: SurfaceGetCurrentTextureStatus

    fn __init__(
        out self,
        texture: WGPUTexture = WGPUTexture(),
        suboptimal: Bool = False,
        status: SurfaceGetCurrentTextureStatus = SurfaceGetCurrentTextureStatus(
            0
        ),
    ):
        self.texture = texture
        self.suboptimal = suboptimal
        self.status = status


@value
struct WGPUTextureDataLayout:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var offset: UInt64
    var bytes_per_row: UInt32
    var rows_per_image: UInt32

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        offset: UInt64 = UInt64(),
        bytes_per_row: UInt32 = UInt32(),
        rows_per_image: UInt32 = UInt32(),
    ):
        self.next_in_chain = next_in_chain
        self.offset = offset
        self.bytes_per_row = bytes_per_row
        self.rows_per_image = rows_per_image


@value
struct WGPUTextureDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var usage: TextureUsage
    var dimension: TextureDimension
    var size: WGPUExtent3D
    var format: TextureFormat
    var mip_level_count: UInt32
    var sample_count: UInt32
    var view_format_count: Int
    var view_formats: UnsafePointer[TextureFormat]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        usage: TextureUsage = TextureUsage(0),
        dimension: TextureDimension = TextureDimension(0),
        owned size: WGPUExtent3D = WGPUExtent3D(),
        format: TextureFormat = TextureFormat(0),
        mip_level_count: UInt32 = UInt32(),
        sample_count: UInt32 = UInt32(),
        view_format_count: Int = Int(),
        view_formats: UnsafePointer[TextureFormat] = UnsafePointer[
            TextureFormat
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.usage = usage
        self.dimension = dimension
        self.size = size^
        self.format = format
        self.mip_level_count = mip_level_count
        self.sample_count = sample_count
        self.view_format_count = view_format_count
        self.view_formats = view_formats


@value
struct WGPUTextureViewDescriptor:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var format: TextureFormat
    var dimension: TextureViewDimension
    var base_mip_level: UInt32
    var mip_level_count: UInt32
    var base_array_layer: UInt32
    var array_layer_count: UInt32
    var aspect: TextureAspect

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        label: UnsafePointer[Int8] = UnsafePointer[Int8](),
        format: TextureFormat = TextureFormat(0),
        dimension: TextureViewDimension = TextureViewDimension(0),
        base_mip_level: UInt32 = UInt32(),
        mip_level_count: UInt32 = MIP_LEVEL_COUNT_UNDEFINED,
        base_array_layer: UInt32 = UInt32(),
        array_layer_count: UInt32 = ARRAY_LAYER_COUNT_UNDEFINED,
        aspect: TextureAspect = TextureAspect(0),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.format = format
        self.dimension = dimension
        self.base_mip_level = base_mip_level
        self.mip_level_count = mip_level_count
        self.base_array_layer = base_array_layer
        self.array_layer_count = array_layer_count
        self.aspect = aspect


@value
struct WGPUUncapturedErrorCallbackInfo:
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var callback: UnsafePointer[NoneType]
    var userdata: UnsafePointer[NoneType]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = UnsafePointer[
            ChainedStruct
        ](),
        callback: UnsafePointer[NoneType] = UnsafePointer[NoneType](),
        userdata: UnsafePointer[NoneType] = UnsafePointer[NoneType](),
    ):
        self.next_in_chain = next_in_chain
        self.callback = callback
        self.userdata = userdata


var _wgpuCreateInstance = _wgpu.get_function[
    fn (UnsafePointer[WGPUInstanceDescriptor]) -> WGPUInstance
]("wgpuCreateInstance")


fn create_instance(
    descriptor: WGPUInstanceDescriptor = WGPUInstanceDescriptor(),
) -> WGPUInstance:
    """
    TODO
    """
    return _wgpuCreateInstance(UnsafePointer.address_of(descriptor))


alias DeviceLostCallback = fn (
    DeviceLostReason,
    UnsafePointer[Int8],
    UnsafePointer[NoneType],
    UnsafePointer[NoneType],
) -> None

alias ErrorCallback = fn (
    ErrorType,
    UnsafePointer[Int8],
    UnsafePointer[NoneType],
    UnsafePointer[NoneType],
) -> None


# WGPU SPECIFIC DEFS


@value
struct WGPUInstanceExtras:
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


@value
struct WGPUDeviceExtras:
    var chain: ChainedStruct
    var trace_path: UnsafePointer[Int8]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        trace_path: UnsafePointer[Int8] = UnsafePointer[Int8](),
    ):
        self.chain = chain
        self.trace_path = trace_path


@value
struct WGPUNativeLimits:
    var max_push_constant_size: UInt32
    var max_non_sampler_bindings: UInt32

    fn __init__(
        out self,
        max_push_constant_size: UInt32 = 0,
        max_non_sampler_bindings: UInt32 = 0,
    ):
        self.max_push_constant_size = max_push_constant_size
        self.max_non_sampler_bindings = max_non_sampler_bindings


@value
struct WGPURequiredLimitsExtras:
    var chain: ChainedStruct
    var limits: WGPUNativeLimits

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        limits: WGPUNativeLimits = WGPUNativeLimits(),
    ):
        self.chain = chain
        self.limits = limits


@value
struct WGPUSupportedLimitsExtras:
    var chain: ChainedStruct
    var limits: WGPUNativeLimits

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        limits: WGPUNativeLimits = WGPUNativeLimits(),
    ):
        self.chain = chain
        self.limits = limits


@value
struct WGPUPushConstantRange:
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


@value
struct WGPUPipelineLayoutExtras:
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


@value
struct WGPUWrappedSubmissionIndex:
    var queue: WGPUQueue
    var submission_index: WGPUSubmissionIndex

    fn __init__(
        out self,
        queue: WGPUQueue = WGPUQueue(),
        submission_index: WGPUSubmissionIndex = WGPUSubmissionIndex(),
    ):
        self.queue = queue
        self.submission_index = submission_index


@value
struct WGPUShaderDefine:
    var name: UnsafePointer[Int8]
    var value: UnsafePointer[Int8]

    fn __init__(
        out self,
        name: UnsafePointer[Int8] = UnsafePointer[Int8](),
        value: UnsafePointer[Int8] = UnsafePointer[Int8](),
    ):
        self.name = name
        self.value = value


@value
struct WGPUShaderModuleGLSLDescriptor:
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


@value
struct WGPURegistryReport:
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


@value
struct WGPUHubReport:
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


@value
struct WGPUGlobalReport:
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


@value
struct WGPUInstanceEnumerateAdapterOptions:
    var chain: ChainedStruct
    var backends: InstanceBackend

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        backends: InstanceBackend = InstanceBackend.all,
    ):
        self.chain = chain
        self.backends = backends


@value
struct WGPUBindGroupEntryExtras:
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


@value
struct WGPUBindGroupLayoutEntryExtras:
    var chain: ChainedStruct
    var count: UInt32

    fn __init__(
        out self, chain: ChainedStruct = ChainedStruct(), count: UInt32 = 0
    ):
        self.chain = chain
        self.count = count


@value
struct WGPUQuerySetDescriptorExtras:
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


@value
struct WGPUSurfaceConfigurationExtras:
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


fn generate_report(instance: WGPUInstance, report: WGPUGlobalReport):
    _wgpu.get_function[
        fn (WGPUInstance, UnsafePointer[WGPUGlobalReport]) -> None
    ]("wgpuGenerateReport")(instance, UnsafePointer.address_of(report))


fn instance_enumerate_adapters(
    instance: WGPUInstance,
    options: WGPUInstanceEnumerateAdapterOptions,
    adapters: UnsafePointer[WGPUAdapter],
) -> Int:
    return _wgpu.get_function[
        fn (
            WGPUInstance,
            UnsafePointer[WGPUInstanceEnumerateAdapterOptions],
            UnsafePointer[WGPUAdapter],
        ) -> Int
    ]("wgpuInstanceEnumerateAdapters")(
        instance, UnsafePointer.address_of(options), adapters
    )


fn queue_submit_for_index(
    queue: WGPUQueue,
    command_count: Int,
    commands: UnsafePointer[WGPUCommandBuffer],
) -> WGPUSubmissionIndex:
    return _wgpu.get_function[
        fn (
            WGPUQueue, Int, UnsafePointer[WGPUCommandBuffer]
        ) -> WGPUSubmissionIndex
    ]("wgpuQueueSubmitForIndex")(queue, command_count, commands)


fn device_poll(
    device: WGPUDevice,
    wait: Bool = False,
    wrapped_submission_index: Optional[WGPUWrappedSubmissionIndex] = None,
) -> Bool:
    """Returns true if the queue is empty, or false if there are more queue submissions still in flight.
    """
    return _wgpu.get_function[
        fn (WGPUDevice, Bool, UnsafePointer[WGPUWrappedSubmissionIndex]) -> Bool
    ]("wgpuDevicePoll")(
        device,
        wait,
        UnsafePointer[WGPUWrappedSubmissionIndex, mut=False](),
    )


fn set_log_callback(
    callback: WGPULogCallback, userdata: UnsafePointer[NoneType]
):
    _wgpu.get_function[fn (WGPULogCallback, UnsafePointer[NoneType]) -> None](
        "wgpuSetLogCallback"
    )(callback, userdata)


fn set_log_level(level: LogLevel):
    _wgpu.get_function[fn (Int) -> None]("wgpuSetLogLevel")(level.value)


fn get_version() -> UInt32:
    return _wgpu.get_function[fn () -> UInt32]("wgpuGetVersion")()


fn render_pass_encoder_set_push_constants(
    encoder: WGPURenderPassEncoder,
    stages: ShaderStage,
    offset: UInt32,
    size_bytes: UInt32,
    data: UnsafePointer[NoneType],
):
    _wgpu.get_function[
        fn (
            WGPURenderPassEncoder,
            ShaderStage,
            UInt32,
            UInt32,
            UnsafePointer[NoneType],
        ) -> None
    ]("wgpuRenderPassEncoderSetPushConstants")(
        encoder, stages, offset, size_bytes, data
    )


fn render_pass_encoder_multi_draw_indirect(
    encoder: WGPURenderPassEncoder,
    buffer: WGPUBuffer,
    offset: UInt64,
    count: UInt32,
):
    _wgpu.get_function[
        fn (WGPURenderPassEncoder, WGPUBuffer, UInt64, UInt32) -> None
    ]("wgpuRenderPassEncoderMultiDrawIndirect")(encoder, buffer, offset, count)


fn render_pass_encoder_multi_draw_indexed_indirect(
    encoder: WGPURenderPassEncoder,
    buffer: WGPUBuffer,
    offset: UInt64,
    count: UInt32,
):
    _wgpu.get_function[
        fn (WGPURenderPassEncoder, WGPUBuffer, UInt64, UInt32) -> None
    ]("wgpuRenderPassEncoderMultiDrawIndexedIndirect")(
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
    _wgpu.get_function[
        fn (
            WGPURenderPassEncoder,
            WGPUBuffer,
            UInt64,
            WGPUBuffer,
            UInt64,
            UInt32,
        ) -> None
    ]("wgpuRenderPassEncoderMultiDrawIndirectCount")(
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
    _wgpu.get_function[
        fn (
            WGPURenderPassEncoder,
            WGPUBuffer,
            UInt64,
            WGPUBuffer,
            UInt64,
            UInt32,
        ) -> None
    ]("wgpuRenderPassEncoderMultiDrawIndexedIndirectCount")(
        encoder, buffer, offset, count_buffer, count_buffer_offset, max_count
    )


fn compute_pass_encoder_begin_pipeline_statistics_query(
    compute_pass_encoder: WGPUComputePassEncoder,
    query_set: WGPUQuerySet,
    query_index: UInt32,
):
    _wgpu.get_function[
        fn (WGPUComputePassEncoder, WGPUQuerySet, UInt32) -> None
    ]("wgpuComputePassEncoderBeginPipelineStatisticsQuery")(
        compute_pass_encoder, query_set, query_index
    )


fn compute_pass_encoder_end_pipeline_statistics_query(
    compute_pass_encoder: WGPUComputePassEncoder,
):
    _wgpu.get_function[fn (WGPUComputePassEncoder) -> None](
        "wgpuComputePassEncoderEndPipelineStatisticsQuery"
    )(compute_pass_encoder)


fn render_pass_encoder_begin_pipeline_statistics_query(
    render_pass_encoder: WGPURenderPassEncoder,
    query_set: WGPUQuerySet,
    query_index: UInt32,
):
    _wgpu.get_function[
        fn (WGPURenderPassEncoder, WGPUQuerySet, UInt32) -> None
    ]("wgpuRenderPassEncoderBeginPipelineStatisticsQuery")(
        render_pass_encoder, query_set, query_index
    )


fn render_pass_encoder_end_pipeline_statistics_query(
    render_pass_encoder: WGPURenderPassEncoder,
):
    _wgpu.get_function[fn (WGPURenderPassEncoder) -> None](
        "wgpuRenderPassEncoderEndPipelineStatisticsQuery"
    )(render_pass_encoder)
