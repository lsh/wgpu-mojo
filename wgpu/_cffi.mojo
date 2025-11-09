from sys.ffi import external_call
from .enums import *
from .bitflags import *
from .constants import *


struct ChainedStruct(Copyable, ImplicitlyCopyable, Movable):
    var next: UnsafePointer[Self]
    var s_type: SType

    fn __init__(
        out self,
        next: UnsafePointer[Self] = UnsafePointer[Self](),
        s_type: SType = SType.invalid,
    ):
        self.next = next
        self.s_type = s_type


struct ChainedStructOut(Copyable, ImplicitlyCopyable, Movable):
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
    _ = external_call[
        "wgpuAdapterRelease", NoneType, UnsafePointer[_AdapterImpl]
    ](handle)


fn adapter_get_limits(handle: WGPUAdapter, limits: WGPUSupportedLimits) -> Bool:
    """
    TODO
    """
    return external_call[
        "wgpuAdapterGetLimits",
        Bool,
        WGPUAdapter,
        UnsafePointer[WGPUSupportedLimits],
    ](handle, UnsafePointer(to=limits))


fn adapter_has_feature(handle: WGPUAdapter, feature: FeatureName) -> Bool:
    """
    TODO
    """
    return external_call[
        "wgpuAdapterHasFeature", Bool, WGPUAdapter, FeatureName
    ](handle, feature)


fn adapter_enumerate_features(
    handle: WGPUAdapter, features: FeatureName
) -> Int:
    """
    TODO
    """
    return external_call[
        "wgpuAdapterEnumerateFeatures", Int, WGPUAdapter, FeatureName
    ](handle, features)


fn adapter_get_info(handle: WGPUAdapter, info: WGPUAdapterInfo) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuAdapterGetInfo",
        NoneType,
        WGPUAdapter,
        UnsafePointer[WGPUAdapterInfo],
    ](handle, UnsafePointer(to=info))


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
    _ = external_call[
        "wgpuAdapterRequestDevice",
        NoneType,
        WGPUAdapter,
        UnsafePointer[WGPUDeviceDescriptor],
        fn (
            RequestDeviceStatus,
            WGPUDevice,
            UnsafePointer[Int8],
            UnsafePointer[NoneType],
        ) -> None,
        UnsafePointer[NoneType],
    ](handle, UnsafePointer(to=descriptor), callback, user_data)


struct _BindGroupImpl:
    pass


alias WGPUBindGroup = UnsafePointer[_BindGroupImpl]


fn bind_group_release(handle: WGPUBindGroup):
    _ = external_call[
        "wgpuBindGroupRelease", NoneType, UnsafePointer[_BindGroupImpl]
    ](handle)


fn bind_group_set_label(
    handle: WGPUBindGroup, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuBindGroupSetLabel", NoneType, WGPUBindGroup, UnsafePointer[Int8]
    ](handle, label)


struct _BindGroupLayoutImpl:
    pass


alias WGPUBindGroupLayout = UnsafePointer[_BindGroupLayoutImpl]


fn bind_group_layout_release(handle: WGPUBindGroupLayout):
    _ = external_call[
        "wgpuBindGroupLayoutRelease",
        NoneType,
        UnsafePointer[_BindGroupLayoutImpl],
    ](handle)


fn bind_group_layout_set_label(
    handle: WGPUBindGroupLayout, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuBindGroupLayoutSetLabel",
        NoneType,
        WGPUBindGroupLayout,
        UnsafePointer[Int8],
    ](handle, label)


struct _BufferImpl:
    pass


alias WGPUBuffer = UnsafePointer[_BufferImpl]


fn buffer_release(handle: WGPUBuffer):
    _ = external_call[
        "wgpuBufferRelease", NoneType, UnsafePointer[_BufferImpl]
    ](handle)


fn buffer_map_async(
    handle: WGPUBuffer,
    mode: MapMode,
    offset: Int,
    size: Int,
    callback: fn (BufferMapAsyncStatus, UnsafePointer[NoneType]) -> None,
    user_data: UnsafePointer[NoneType],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuBufferMapAsync",
        NoneType,
        WGPUBuffer,
        MapMode,
        Int,
        Int,
        fn (BufferMapAsyncStatus, UnsafePointer[NoneType]) -> None,
        UnsafePointer[NoneType],
    ](handle, mode, offset, size, callback, user_data)


fn buffer_get_mapped_range(
    handle: WGPUBuffer, offset: Int, size: Int
) -> UnsafePointer[NoneType]:
    """
    TODO
    """
    return external_call[
        "wgpuBufferGetMappedRange",
        UnsafePointer[NoneType],
        WGPUBuffer,
        Int,
        Int,
    ](handle, offset, size)


fn buffer_get_const_mapped_range(
    handle: WGPUBuffer, offset: Int, size: Int
) -> UnsafePointer[NoneType]:
    """
    TODO
    """
    return external_call[
        "wgpuBufferGetConstMappedRange",
        UnsafePointer[NoneType],
        WGPUBuffer,
        Int,
        Int,
    ](handle, offset, size)


fn buffer_set_label(handle: WGPUBuffer, label: UnsafePointer[Int8]) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuBufferSetLabel", NoneType, WGPUBuffer, UnsafePointer[Int8]
    ](handle, label)


fn buffer_get_usage(
    handle: WGPUBuffer,
) -> BufferUsage:
    """
    TODO
    """
    return external_call["wgpuBufferGetUsage", BufferUsage, WGPUBuffer,](
        handle,
    )


fn buffer_get_size(
    handle: WGPUBuffer,
) -> UInt64:
    """
    TODO
    """
    return external_call["wgpuBufferGetSize", UInt64, WGPUBuffer,](
        handle,
    )


fn buffer_get_map_state(
    handle: WGPUBuffer,
) -> BufferMapState:
    """
    TODO
    """
    return external_call["wgpuBufferGetMapState", BufferMapState, WGPUBuffer,](
        handle,
    )


fn buffer_unmap(
    handle: WGPUBuffer,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuBufferUnmap", NoneType, WGPUBuffer,](
        handle,
    )


fn buffer_destroy(
    handle: WGPUBuffer,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuBufferDestroy", NoneType, WGPUBuffer,](
        handle,
    )


struct _CommandBufferImpl:
    pass


alias WGPUCommandBuffer = UnsafePointer[_CommandBufferImpl]


fn command_buffer_release(handle: WGPUCommandBuffer):
    _ = external_call[
        "wgpuCommandBufferRelease", NoneType, UnsafePointer[_CommandBufferImpl]
    ](handle)


fn command_buffer_set_label(
    handle: WGPUCommandBuffer, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandBufferSetLabel",
        NoneType,
        WGPUCommandBuffer,
        UnsafePointer[Int8],
    ](handle, label)


struct _CommandEncoderImpl:
    pass


alias WGPUCommandEncoder = UnsafePointer[_CommandEncoderImpl]


fn command_encoder_release(handle: WGPUCommandEncoder):
    _ = external_call[
        "wgpuCommandEncoderRelease",
        NoneType,
        UnsafePointer[_CommandEncoderImpl],
    ](handle)


fn command_encoder_finish(
    handle: WGPUCommandEncoder,
    descriptor: WGPUCommandBufferDescriptor = WGPUCommandBufferDescriptor(),
) -> WGPUCommandBuffer:
    """
    TODO
    """
    return external_call[
        "wgpuCommandEncoderFinish",
        WGPUCommandBuffer,
        WGPUCommandEncoder,
        UnsafePointer[WGPUCommandBufferDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn command_encoder_begin_compute_pass(
    handle: WGPUCommandEncoder,
    descriptor: WGPUComputePassDescriptor = WGPUComputePassDescriptor(),
) -> WGPUComputePassEncoder:
    """
    TODO
    """
    return external_call[
        "wgpuCommandEncoderBeginComputePass",
        WGPUComputePassEncoder,
        WGPUCommandEncoder,
        UnsafePointer[WGPUComputePassDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn command_encoder_begin_render_pass(
    handle: WGPUCommandEncoder, descriptor: WGPURenderPassDescriptor
) -> WGPURenderPassEncoder:
    """
    TODO
    """
    return external_call[
        "wgpuCommandEncoderBeginRenderPass",
        WGPURenderPassEncoder,
        WGPUCommandEncoder,
        UnsafePointer[WGPURenderPassDescriptor],
    ](handle, UnsafePointer(to=descriptor))


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
    _ = external_call[
        "wgpuCommandEncoderCopyBufferToBuffer",
        NoneType,
        WGPUCommandEncoder,
        WGPUBuffer,
        UInt64,
        WGPUBuffer,
        UInt64,
        UInt64,
    ](handle, source, source_offset, destination, destination_offset, size)


fn command_encoder_copy_buffer_to_texture(
    handle: WGPUCommandEncoder,
    source: WGPUImageCopyBuffer,
    destination: WGPUImageCopyTexture,
    copy_size: WGPUExtent3D,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderCopyBufferToTexture",
        NoneType,
        WGPUCommandEncoder,
        UnsafePointer[WGPUImageCopyBuffer],
        UnsafePointer[WGPUImageCopyTexture],
        UnsafePointer[WGPUExtent3D],
    ](
        handle,
        UnsafePointer(to=source),
        UnsafePointer(to=destination),
        UnsafePointer(to=copy_size),
    )


fn command_encoder_copy_texture_to_buffer(
    handle: WGPUCommandEncoder,
    source: WGPUImageCopyTexture,
    destination: WGPUImageCopyBuffer,
    copy_size: WGPUExtent3D,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderCopyTextureToBuffer",
        NoneType,
        WGPUCommandEncoder,
        UnsafePointer[WGPUImageCopyTexture],
        UnsafePointer[WGPUImageCopyBuffer],
        UnsafePointer[WGPUExtent3D],
    ](
        handle,
        UnsafePointer(to=source),
        UnsafePointer(to=destination),
        UnsafePointer(to=copy_size),
    )


fn command_encoder_copy_texture_to_texture(
    handle: WGPUCommandEncoder,
    source: WGPUImageCopyTexture,
    destination: WGPUImageCopyTexture,
    copy_size: WGPUExtent3D,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderCopyTextureToTexture",
        NoneType,
        WGPUCommandEncoder,
        UnsafePointer[WGPUImageCopyTexture],
        UnsafePointer[WGPUImageCopyTexture],
        UnsafePointer[WGPUExtent3D],
    ](
        handle,
        UnsafePointer(to=source),
        UnsafePointer(to=destination),
        UnsafePointer(to=copy_size),
    )


fn command_encoder_clear_buffer(
    handle: WGPUCommandEncoder, buffer: WGPUBuffer, offset: UInt64, size: UInt64
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderClearBuffer",
        NoneType,
        WGPUCommandEncoder,
        WGPUBuffer,
        UInt64,
        UInt64,
    ](handle, buffer, offset, size)


fn command_encoder_insert_debug_marker(
    handle: WGPUCommandEncoder, marker_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderInsertDebugMarker",
        NoneType,
        WGPUCommandEncoder,
        UnsafePointer[Int8],
    ](handle, marker_label)


fn command_encoder_pop_debug_group(
    handle: WGPUCommandEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderPopDebugGroup",
        NoneType,
        WGPUCommandEncoder,
    ](
        handle,
    )


fn command_encoder_push_debug_group(
    handle: WGPUCommandEncoder, group_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderPushDebugGroup",
        NoneType,
        WGPUCommandEncoder,
        UnsafePointer[Int8],
    ](handle, group_label)


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
    _ = external_call[
        "wgpuCommandEncoderResolveQuerySet",
        NoneType,
        WGPUCommandEncoder,
        WGPUQuerySet,
        UInt32,
        UInt32,
        WGPUBuffer,
        UInt64,
    ](
        handle,
        query_set,
        first_query,
        query_count,
        destination,
        destination_offset,
    )


fn command_encoder_write_timestamp(
    handle: WGPUCommandEncoder, query_set: WGPUQuerySet, query_index: UInt32
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderWriteTimestamp",
        NoneType,
        WGPUCommandEncoder,
        WGPUQuerySet,
        UInt32,
    ](handle, query_set, query_index)


fn command_encoder_set_label(
    handle: WGPUCommandEncoder, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderSetLabel",
        NoneType,
        WGPUCommandEncoder,
        UnsafePointer[Int8],
    ](handle, label)


struct _ComputePassEncoderImpl:
    pass


alias WGPUComputePassEncoder = UnsafePointer[_ComputePassEncoderImpl]


fn compute_pass_encoder_release(handle: WGPUComputePassEncoder):
    _ = external_call[
        "wgpuComputePassEncoderRelease",
        NoneType,
        UnsafePointer[_ComputePassEncoderImpl],
    ](handle)


fn compute_pass_encoder_insert_debug_marker(
    handle: WGPUComputePassEncoder, marker_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderInsertDebugMarker",
        NoneType,
        WGPUComputePassEncoder,
        UnsafePointer[Int8],
    ](handle, marker_label)


fn compute_pass_encoder_pop_debug_group(
    handle: WGPUComputePassEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderPopDebugGroup",
        NoneType,
        WGPUComputePassEncoder,
    ](
        handle,
    )


fn compute_pass_encoder_push_debug_group(
    handle: WGPUComputePassEncoder, group_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderPushDebugGroup",
        NoneType,
        WGPUComputePassEncoder,
        UnsafePointer[Int8],
    ](handle, group_label)


fn compute_pass_encoder_set_pipeline(
    handle: WGPUComputePassEncoder, pipeline: WGPUComputePipeline
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderSetPipeline",
        NoneType,
        WGPUComputePassEncoder,
        WGPUComputePipeline,
    ](handle, pipeline)


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
    _ = external_call[
        "wgpuComputePassEncoderSetBindGroup",
        NoneType,
        WGPUComputePassEncoder,
        UInt32,
        WGPUBindGroup,
        Int32,
        UnsafePointer[UInt32],
    ](handle, group_index, group, dynamic_offset_count, dynamic_offsets)


fn compute_pass_encoder_dispatch_workgroups(
    handle: WGPUComputePassEncoder,
    workgroupCountX: UInt32,
    workgroupCountY: UInt32,
    workgroupCountZ: UInt32,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderDispatchWorkgroups",
        NoneType,
        WGPUComputePassEncoder,
        UInt32,
        UInt32,
        UInt32,
    ](handle, workgroupCountX, workgroupCountY, workgroupCountZ)


fn compute_pass_encoder_dispatch_workgroups_indirect(
    handle: WGPUComputePassEncoder,
    indirect_buffer: WGPUBuffer,
    indirect_offset: UInt64,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderDispatchWorkgroupsIndirect",
        NoneType,
        WGPUComputePassEncoder,
        WGPUBuffer,
        UInt64,
    ](handle, indirect_buffer, indirect_offset)


fn compute_pass_encoder_end(
    handle: WGPUComputePassEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderEnd",
        NoneType,
        WGPUComputePassEncoder,
    ](
        handle,
    )


fn compute_pass_encoder_set_label(
    handle: WGPUComputePassEncoder, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderSetLabel",
        NoneType,
        WGPUComputePassEncoder,
        UnsafePointer[Int8],
    ](handle, label)


struct _ComputePipelineImpl:
    pass


alias WGPUComputePipeline = UnsafePointer[_ComputePipelineImpl]


fn compute_pipeline_release(handle: WGPUComputePipeline):
    _ = external_call[
        "wgpuComputePipelineRelease",
        NoneType,
        UnsafePointer[_ComputePipelineImpl],
    ](handle)


fn compute_pipeline_get_bind_group_layout(
    handle: WGPUComputePipeline, group_index: UInt32
) -> WGPUBindGroupLayout:
    """
    TODO
    """
    return external_call[
        "wgpuComputePipelineGetBindGroupLayout",
        WGPUBindGroupLayout,
        WGPUComputePipeline,
        UInt32,
    ](handle, group_index)


fn compute_pipeline_set_label(
    handle: WGPUComputePipeline, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePipelineSetLabel",
        NoneType,
        WGPUComputePipeline,
        UnsafePointer[Int8],
    ](handle, label)


struct _DeviceImpl:
    pass


alias WGPUDevice = UnsafePointer[_DeviceImpl]


fn device_release(handle: WGPUDevice):
    _ = external_call[
        "wgpuDeviceRelease", NoneType, UnsafePointer[_DeviceImpl]
    ](handle)


fn device_create_bind_group(
    handle: WGPUDevice, descriptor: WGPUBindGroupDescriptor
) -> WGPUBindGroup:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateBindGroup",
        WGPUBindGroup,
        WGPUDevice,
        UnsafePointer[WGPUBindGroupDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn device_create_bind_group_layout(
    handle: WGPUDevice, descriptor: WGPUBindGroupLayoutDescriptor
) -> WGPUBindGroupLayout:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateBindGroupLayout",
        WGPUBindGroupLayout,
        WGPUDevice,
        UnsafePointer[WGPUBindGroupLayoutDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn device_create_buffer(
    handle: WGPUDevice, descriptor: WGPUBufferDescriptor
) -> WGPUBuffer:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateBuffer",
        WGPUBuffer,
        WGPUDevice,
        UnsafePointer[WGPUBufferDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn device_create_command_encoder(
    handle: WGPUDevice,
    descriptor: WGPUCommandEncoderDescriptor = WGPUCommandEncoderDescriptor(),
) -> WGPUCommandEncoder:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateCommandEncoder",
        WGPUCommandEncoder,
        WGPUDevice,
        UnsafePointer[WGPUCommandEncoderDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn device_create_compute_pipeline(
    handle: WGPUDevice, descriptor: WGPUComputePipelineDescriptor
) -> WGPUComputePipeline:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateComputePipeline",
        WGPUComputePipeline,
        WGPUDevice,
        UnsafePointer[WGPUComputePipelineDescriptor],
    ](handle, UnsafePointer(to=descriptor))


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
    _ = external_call[
        "wgpuDeviceCreateComputePipelineAsync",
        NoneType,
        WGPUDevice,
        UnsafePointer[WGPUComputePipelineDescriptor],
        fn (
            CreatePipelineAsyncStatus,
            WGPUComputePipeline,
            UnsafePointer[Int8],
            UnsafePointer[NoneType],
        ) -> None,
        UnsafePointer[NoneType],
    ](handle, UnsafePointer(to=descriptor), callback, user_data)


fn device_create_pipeline_layout(
    handle: WGPUDevice, descriptor: WGPUPipelineLayoutDescriptor
) -> WGPUPipelineLayout:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreatePipelineLayout",
        WGPUPipelineLayout,
        WGPUDevice,
        UnsafePointer[WGPUPipelineLayoutDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn device_create_query_set(
    handle: WGPUDevice, descriptor: WGPUQuerySetDescriptor
) -> WGPUQuerySet:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateQuerySet",
        WGPUQuerySet,
        WGPUDevice,
        UnsafePointer[WGPUQuerySetDescriptor],
    ](handle, UnsafePointer(to=descriptor))


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
    _ = external_call[
        "wgpuDeviceCreateRenderPipelineAsync",
        NoneType,
        WGPUDevice,
        UnsafePointer[WGPURenderPipelineDescriptor],
        fn (
            CreatePipelineAsyncStatus,
            WGPURenderPipeline,
            UnsafePointer[Int8],
            UnsafePointer[NoneType],
        ) -> None,
        UnsafePointer[NoneType],
    ](handle, UnsafePointer(to=descriptor), callback, user_data)


fn device_create_render_bundle_encoder(
    handle: WGPUDevice, descriptor: WGPURenderBundleEncoderDescriptor
) -> WGPURenderBundleEncoder:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateRenderBundleEncoder",
        WGPURenderBundleEncoder,
        WGPUDevice,
        UnsafePointer[WGPURenderBundleEncoderDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn device_create_render_pipeline(
    handle: WGPUDevice, descriptor: WGPURenderPipelineDescriptor
) -> WGPURenderPipeline:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateRenderPipeline",
        WGPURenderPipeline,
        WGPUDevice,
        UnsafePointer[WGPURenderPipelineDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn device_create_sampler(
    handle: WGPUDevice,
    descriptor: WGPUSamplerDescriptor = WGPUSamplerDescriptor(),
) -> WGPUSampler:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateSampler",
        WGPUSampler,
        WGPUDevice,
        UnsafePointer[WGPUSamplerDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn device_create_shader_module(
    handle: WGPUDevice, descriptor: WGPUShaderModuleDescriptor
) -> WGPUShaderModule:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateShaderModule",
        WGPUShaderModule,
        WGPUDevice,
        UnsafePointer[WGPUShaderModuleDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn device_create_texture(
    handle: WGPUDevice, descriptor: WGPUTextureDescriptor
) -> WGPUTexture:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateTexture",
        WGPUTexture,
        WGPUDevice,
        UnsafePointer[WGPUTextureDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn device_destroy(
    handle: WGPUDevice,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuDeviceDestroy", NoneType, WGPUDevice,](
        handle,
    )


fn device_get_limits(handle: WGPUDevice, limits: WGPUSupportedLimits) -> Bool:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceGetLimits",
        Bool,
        WGPUDevice,
        UnsafePointer[WGPUSupportedLimits],
    ](handle, UnsafePointer(to=limits))


fn device_has_feature(handle: WGPUDevice, feature: FeatureName) -> Bool:
    """
    TODO
    """
    return external_call["wgpuDeviceHasFeature", Bool, WGPUDevice, FeatureName](
        handle, feature
    )


fn device_enumerate_features(handle: WGPUDevice, features: FeatureName) -> Int:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceEnumerateFeatures", Int, WGPUDevice, FeatureName
    ](handle, features)


fn device_get_queue(
    handle: WGPUDevice,
) -> WGPUQueue:
    """
    TODO
    """
    return external_call["wgpuDeviceGetQueue", WGPUQueue, WGPUDevice,](
        handle,
    )


fn device_push_error_scope(handle: WGPUDevice, filter: ErrorFilter) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuDevicePushErrorScope", NoneType, WGPUDevice, ErrorFilter
    ](handle, filter)


fn device_pop_error_scope(
    handle: WGPUDevice,
    callback: ErrorCallback,
    userdata: UnsafePointer[NoneType],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuDevicePopErrorScope",
        NoneType,
        WGPUDevice,
        ErrorCallback,
        UnsafePointer[NoneType],
    ](handle, callback, userdata)


fn device_set_label(handle: WGPUDevice, label: UnsafePointer[Int8]) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuDeviceSetLabel", NoneType, WGPUDevice, UnsafePointer[Int8]
    ](handle, label)


struct _InstanceImpl:
    pass


alias WGPUInstance = UnsafePointer[_InstanceImpl]


fn instance_release(handle: WGPUInstance):
    _ = external_call[
        "wgpuInstanceRelease", NoneType, UnsafePointer[_InstanceImpl]
    ](handle)


fn instance_create_surface(
    handle: WGPUInstance, descriptor: WGPUSurfaceDescriptor
) -> WGPUSurface:
    """
    TODO
    """
    return external_call[
        "wgpuInstanceCreateSurface",
        WGPUSurface,
        WGPUInstance,
        UnsafePointer[WGPUSurfaceDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn instance_has_WGSL_language_feature(
    handle: WGPUInstance, feature: WgslFeatureName
) -> Bool:
    """
    TODO
    """
    return external_call[
        "wgpuInstanceHasWgslLanguageFeature",
        Bool,
        WGPUInstance,
        WgslFeatureName,
    ](handle, feature)


fn instance_process_events(
    handle: WGPUInstance,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuInstanceProcessEvents", NoneType, WGPUInstance,](
        handle,
    )


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
    _ = external_call[
        "wgpuInstanceRequestAdapter",
        NoneType,
        WGPUInstance,
        UnsafePointer[WGPURequestAdapterOptions],
        fn (
            RequestAdapterStatus,
            WGPUAdapter,
            UnsafePointer[Int8],
            UnsafePointer[NoneType],
        ) -> None,
        UnsafePointer[NoneType],
    ](handle, UnsafePointer(to=options), callback, user_data)


struct _PipelineLayoutImpl:
    pass


alias WGPUPipelineLayout = UnsafePointer[_PipelineLayoutImpl]


fn pipeline_layout_release(handle: WGPUPipelineLayout):
    _ = external_call[
        "wgpuPipelineLayoutRelease",
        NoneType,
        UnsafePointer[_PipelineLayoutImpl],
    ](handle)


fn pipeline_layout_set_label(
    handle: WGPUPipelineLayout, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuPipelineLayoutSetLabel",
        NoneType,
        WGPUPipelineLayout,
        UnsafePointer[Int8],
    ](handle, label)


struct _QuerySetImpl:
    pass


alias WGPUQuerySet = UnsafePointer[_QuerySetImpl]


fn query_set_release(handle: WGPUQuerySet):
    _ = external_call[
        "wgpuQuerySetRelease", NoneType, UnsafePointer[_QuerySetImpl]
    ](handle)


fn query_set_set_label(
    handle: WGPUQuerySet, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuQuerySetSetLabel", NoneType, WGPUQuerySet, UnsafePointer[Int8]
    ](handle, label)


fn query_set_get_type(
    handle: WGPUQuerySet,
) -> QueryType:
    """
    TODO
    """
    return external_call["wgpuQuerySetGetType", QueryType, WGPUQuerySet,](
        handle,
    )


fn query_set_get_count(
    handle: WGPUQuerySet,
) -> UInt32:
    """
    TODO
    """
    return external_call["wgpuQuerySetGetCount", UInt32, WGPUQuerySet,](
        handle,
    )


fn query_set_destroy(
    handle: WGPUQuerySet,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuQuerySetDestroy", NoneType, WGPUQuerySet,](
        handle,
    )


struct _QueueImpl:
    pass


alias WGPUQueue = UnsafePointer[_QueueImpl]


fn queue_release(handle: WGPUQueue):
    _ = external_call["wgpuQueueRelease", NoneType, UnsafePointer[_QueueImpl]](
        handle
    )


fn queue_submit(
    handle: WGPUQueue,
    command_count: Int,
    commands: UnsafePointer[WGPUCommandBuffer],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuQueueSubmit",
        NoneType,
        WGPUQueue,
        Int32,
        UnsafePointer[WGPUCommandBuffer],
    ](handle, command_count, commands)


fn queue_on_submitted_work_done(
    handle: WGPUQueue,
    callback: fn (QueueWorkDoneStatus, UnsafePointer[NoneType]) -> None,
    user_data: UnsafePointer[NoneType],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuQueueOnSubmittedWorkDone",
        NoneType,
        WGPUQueue,
        fn (QueueWorkDoneStatus, UnsafePointer[NoneType]) -> None,
        UnsafePointer[NoneType],
    ](handle, callback, user_data)


fn queue_write_buffer(
    handle: WGPUQueue,
    buffer: WGPUBuffer,
    buffer_offset: UInt64,
    data: UnsafePointer[NoneType],
    size: Int,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuQueueWriteBuffer",
        NoneType,
        WGPUQueue,
        WGPUBuffer,
        UInt64,
        UnsafePointer[NoneType],
        Int,
    ](handle, buffer, buffer_offset, data, size)


fn queue_write_texture(
    handle: WGPUQueue,
    destination: WGPUImageCopyTexture,
    data: UnsafePointer[NoneType],
    data_size: Int,
    data_layout: WGPUTextureDataLayout,
    write_size: WGPUExtent3D,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuQueueWriteTexture",
        NoneType,
        WGPUQueue,
        UnsafePointer[WGPUImageCopyTexture],
        UnsafePointer[NoneType],
        Int,
        UnsafePointer[WGPUTextureDataLayout],
        UnsafePointer[WGPUExtent3D],
    ](
        handle,
        UnsafePointer(to=destination),
        data,
        data_size,
        UnsafePointer(to=data_layout),
        UnsafePointer(to=write_size),
    )


fn queue_set_label(handle: WGPUQueue, label: UnsafePointer[Int8]) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuQueueSetLabel", NoneType, WGPUQueue, UnsafePointer[Int8]
    ](handle, label)


struct _RenderBundleImpl:
    pass


alias WGPURenderBundle = UnsafePointer[_RenderBundleImpl]


fn render_bundle_release(handle: WGPURenderBundle):
    _ = external_call[
        "wgpuRenderBundleRelease", NoneType, UnsafePointer[_RenderBundleImpl]
    ](handle)


fn render_bundle_set_label(
    handle: WGPURenderBundle, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleSetLabel",
        NoneType,
        WGPURenderBundle,
        UnsafePointer[Int8],
    ](handle, label)


struct _RenderBundleEncoderImpl:
    pass


alias WGPURenderBundleEncoder = UnsafePointer[_RenderBundleEncoderImpl]


fn render_bundle_encoder_release(handle: WGPURenderBundleEncoder):
    _ = external_call[
        "wgpuRenderBundleEncoderRelease",
        NoneType,
        UnsafePointer[_RenderBundleEncoderImpl],
    ](handle)


fn render_bundle_encoder_set_pipeline(
    handle: WGPURenderBundleEncoder, pipeline: WGPURenderPipeline
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderSetPipeline",
        NoneType,
        WGPURenderBundleEncoder,
        WGPURenderPipeline,
    ](handle, pipeline)


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
    _ = external_call[
        "wgpuRenderBundleEncoderSetBindGroup",
        NoneType,
        WGPURenderBundleEncoder,
        UInt32,
        WGPUBindGroup,
        Int32,
        UnsafePointer[UInt32],
    ](handle, group_index, group, dynamic_offset_count, dynamic_offsets)


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
    _ = external_call[
        "wgpuRenderBundleEncoderDraw",
        NoneType,
        WGPURenderBundleEncoder,
        UInt32,
        UInt32,
        UInt32,
        UInt32,
    ](handle, vertex_count, instance_count, first_vertex, first_instance)


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
    _ = external_call[
        "wgpuRenderBundleEncoderDrawIndexed",
        NoneType,
        WGPURenderBundleEncoder,
        UInt32,
        UInt32,
        UInt32,
        Int32,
        UInt32,
    ](
        handle,
        index_count,
        instance_count,
        first_index,
        base_vertex,
        first_instance,
    )


fn render_bundle_encoder_draw_indirect(
    handle: WGPURenderBundleEncoder,
    indirect_buffer: WGPUBuffer,
    indirect_offset: UInt64,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderDrawIndirect",
        NoneType,
        WGPURenderBundleEncoder,
        WGPUBuffer,
        UInt64,
    ](handle, indirect_buffer, indirect_offset)


fn render_bundle_encoder_draw_indexed_indirect(
    handle: WGPURenderBundleEncoder,
    indirect_buffer: WGPUBuffer,
    indirect_offset: UInt64,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderDrawIndexedIndirect",
        NoneType,
        WGPURenderBundleEncoder,
        WGPUBuffer,
        UInt64,
    ](handle, indirect_buffer, indirect_offset)


fn render_bundle_encoder_insert_debug_marker(
    handle: WGPURenderBundleEncoder, marker_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderInsertDebugMarker",
        NoneType,
        WGPURenderBundleEncoder,
        UnsafePointer[Int8],
    ](handle, marker_label)


fn render_bundle_encoder_pop_debug_group(
    handle: WGPURenderBundleEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderPopDebugGroup",
        NoneType,
        WGPURenderBundleEncoder,
    ](
        handle,
    )


fn render_bundle_encoder_push_debug_group(
    handle: WGPURenderBundleEncoder, group_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderPushDebugGroup",
        NoneType,
        WGPURenderBundleEncoder,
        UnsafePointer[Int8],
    ](handle, group_label)


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
    _ = external_call[
        "wgpuRenderBundleEncoderSetVertexBuffer",
        NoneType,
        WGPURenderBundleEncoder,
        UInt32,
        WGPUBuffer,
        UInt64,
        UInt64,
    ](handle, slot, buffer, offset, size)


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
    _ = external_call[
        "wgpuRenderBundleEncoderSetIndexBuffer",
        NoneType,
        WGPURenderBundleEncoder,
        WGPUBuffer,
        IndexFormat,
        UInt64,
        UInt64,
    ](handle, buffer, format, offset, size)


fn render_bundle_encoder_finish(
    handle: WGPURenderBundleEncoder,
    descriptor: WGPURenderBundleDescriptor = WGPURenderBundleDescriptor(),
) -> WGPURenderBundle:
    """
    TODO
    """
    return external_call[
        "wgpuRenderBundleEncoderFinish",
        WGPURenderBundle,
        WGPURenderBundleEncoder,
        UnsafePointer[WGPURenderBundleDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn render_bundle_encoder_set_label(
    handle: WGPURenderBundleEncoder, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderSetLabel",
        NoneType,
        WGPURenderBundleEncoder,
        UnsafePointer[Int8],
    ](handle, label)


struct _RenderPassEncoderImpl:
    pass


alias WGPURenderPassEncoder = UnsafePointer[_RenderPassEncoderImpl]


fn render_pass_encoder_release(handle: WGPURenderPassEncoder):
    _ = external_call[
        "wgpuRenderPassEncoderRelease",
        NoneType,
        UnsafePointer[_RenderPassEncoderImpl],
    ](handle)


fn render_pass_encoder_set_pipeline(
    handle: WGPURenderPassEncoder, pipeline: WGPURenderPipeline
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderSetPipeline",
        NoneType,
        WGPURenderPassEncoder,
        WGPURenderPipeline,
    ](handle, pipeline)


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
    _ = external_call[
        "wgpuRenderPassEncoderSetBindGroup",
        NoneType,
        WGPURenderPassEncoder,
        UInt32,
        WGPUBindGroup,
        Int32,
        UnsafePointer[UInt32],
    ](handle, group_index, group, dynamic_offset_count, dynamic_offsets)


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
    _ = external_call[
        "wgpuRenderPassEncoderDraw",
        NoneType,
        WGPURenderPassEncoder,
        UInt32,
        UInt32,
        UInt32,
        UInt32,
    ](handle, vertex_count, instance_count, first_vertex, first_instance)


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
    _ = external_call[
        "wgpuRenderPassEncoderDrawIndexed",
        NoneType,
        WGPURenderPassEncoder,
        UInt32,
        UInt32,
        UInt32,
        Int32,
        UInt32,
    ](
        handle,
        index_count,
        instance_count,
        first_index,
        base_vertex,
        first_instance,
    )


fn render_pass_encoder_draw_indirect(
    handle: WGPURenderPassEncoder,
    indirect_buffer: WGPUBuffer,
    indirect_offset: UInt64,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderDrawIndirect",
        NoneType,
        WGPURenderPassEncoder,
        WGPUBuffer,
        UInt64,
    ](handle, indirect_buffer, indirect_offset)


fn render_pass_encoder_draw_indexed_indirect(
    handle: WGPURenderPassEncoder,
    indirect_buffer: WGPUBuffer,
    indirect_offset: UInt64,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderDrawIndexedIndirect",
        NoneType,
        WGPURenderPassEncoder,
        WGPUBuffer,
        UInt64,
    ](handle, indirect_buffer, indirect_offset)


fn render_pass_encoder_execute_bundles(
    handle: WGPURenderPassEncoder,
    bundle_count: Int,
    bundles: UnsafePointer[WGPURenderBundle],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderExecuteBundles",
        NoneType,
        WGPURenderPassEncoder,
        Int32,
        UnsafePointer[WGPURenderBundle],
    ](handle, bundle_count, bundles)


fn render_pass_encoder_insert_debug_marker(
    handle: WGPURenderPassEncoder, marker_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderInsertDebugMarker",
        NoneType,
        WGPURenderPassEncoder,
        UnsafePointer[Int8],
    ](handle, marker_label)


fn render_pass_encoder_pop_debug_group(
    handle: WGPURenderPassEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderPopDebugGroup",
        NoneType,
        WGPURenderPassEncoder,
    ](
        handle,
    )


fn render_pass_encoder_push_debug_group(
    handle: WGPURenderPassEncoder, group_label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderPushDebugGroup",
        NoneType,
        WGPURenderPassEncoder,
        UnsafePointer[Int8],
    ](handle, group_label)


fn render_pass_encoder_set_stencil_reference(
    handle: WGPURenderPassEncoder, reference: UInt32
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderSetStencilReference",
        NoneType,
        WGPURenderPassEncoder,
        UInt32,
    ](handle, reference)


fn render_pass_encoder_set_blend_constant(
    handle: WGPURenderPassEncoder, color: WGPUColor
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderSetBlendConstant",
        NoneType,
        WGPURenderPassEncoder,
        UnsafePointer[WGPUColor],
    ](handle, UnsafePointer(to=color))


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
    _ = external_call[
        "wgpuRenderPassEncoderSetViewport",
        NoneType,
        WGPURenderPassEncoder,
        Float32,
        Float32,
        Float32,
        Float32,
        Float32,
        Float32,
    ](handle, x, y, width, height, min_depth, max_depth)


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
    _ = external_call[
        "wgpuRenderPassEncoderSetScissorRect",
        NoneType,
        WGPURenderPassEncoder,
        UInt32,
        UInt32,
        UInt32,
        UInt32,
    ](handle, x, y, width, height)


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
    _ = external_call[
        "wgpuRenderPassEncoderSetVertexBuffer",
        NoneType,
        WGPURenderPassEncoder,
        UInt32,
        WGPUBuffer,
        UInt64,
        UInt64,
    ](handle, slot, buffer, offset, size)


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
    _ = external_call[
        "wgpuRenderPassEncoderSetIndexBuffer",
        NoneType,
        WGPURenderPassEncoder,
        WGPUBuffer,
        IndexFormat,
        UInt64,
        UInt64,
    ](handle, buffer, format, offset, size)


fn render_pass_encoder_begin_occlusion_query(
    handle: WGPURenderPassEncoder, query_index: UInt32
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderBeginOcclusionQuery",
        NoneType,
        WGPURenderPassEncoder,
        UInt32,
    ](handle, query_index)


fn render_pass_encoder_end_occlusion_query(
    handle: WGPURenderPassEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderEndOcclusionQuery",
        NoneType,
        WGPURenderPassEncoder,
    ](
        handle,
    )


fn render_pass_encoder_end(
    handle: WGPURenderPassEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderEnd",
        NoneType,
        WGPURenderPassEncoder,
    ](
        handle,
    )


fn render_pass_encoder_set_label(
    handle: WGPURenderPassEncoder, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderSetLabel",
        NoneType,
        WGPURenderPassEncoder,
        UnsafePointer[Int8],
    ](handle, label)


struct _RenderPipelineImpl:
    pass


alias WGPURenderPipeline = UnsafePointer[_RenderPipelineImpl]


fn render_pipeline_release(handle: WGPURenderPipeline):
    _ = external_call[
        "wgpuRenderPipelineRelease",
        NoneType,
        UnsafePointer[_RenderPipelineImpl],
    ](handle)


fn render_pipeline_get_bind_group_layout(
    handle: WGPURenderPipeline, group_index: UInt32
) -> WGPUBindGroupLayout:
    """
    TODO
    """
    return external_call[
        "wgpuRenderPipelineGetBindGroupLayout",
        WGPUBindGroupLayout,
        WGPURenderPipeline,
        UInt32,
    ](handle, group_index)


fn render_pipeline_set_label(
    handle: WGPURenderPipeline, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPipelineSetLabel",
        NoneType,
        WGPURenderPipeline,
        UnsafePointer[Int8],
    ](handle, label)


struct _SamplerImpl:
    pass


alias WGPUSampler = UnsafePointer[_SamplerImpl]


fn sampler_release(handle: WGPUSampler):
    _ = external_call[
        "wgpuSamplerRelease", NoneType, UnsafePointer[_SamplerImpl]
    ](handle)


fn sampler_set_label(handle: WGPUSampler, label: UnsafePointer[Int8]) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuSamplerSetLabel", NoneType, WGPUSampler, UnsafePointer[Int8]
    ](handle, label)


struct _ShaderModuleImpl:
    pass


alias WGPUShaderModule = UnsafePointer[_ShaderModuleImpl]


fn shader_module_release(handle: WGPUShaderModule):
    _ = external_call[
        "wgpuShaderModuleRelease", NoneType, UnsafePointer[_ShaderModuleImpl]
    ](handle)


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
    _ = external_call[
        "wgpuShaderModuleGetCompilationInfo",
        NoneType,
        WGPUShaderModule,
        fn (
            CompilationInfoRequestStatus,
            UnsafePointer[WGPUCompilationInfo],
            UnsafePointer[NoneType],
        ) -> None,
        UnsafePointer[NoneType],
    ](handle, callback, user_data)


fn shader_module_set_label(
    handle: WGPUShaderModule, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuShaderModuleSetLabel",
        NoneType,
        WGPUShaderModule,
        UnsafePointer[Int8],
    ](handle, label)


struct _SurfaceImpl:
    pass


alias WGPUSurface = UnsafePointer[_SurfaceImpl]


fn surface_release(handle: WGPUSurface):
    _ = external_call[
        "wgpuSurfaceRelease", NoneType, UnsafePointer[_SurfaceImpl]
    ](handle)


fn surface_configure(
    handle: WGPUSurface, config: WGPUSurfaceConfiguration
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuSurfaceConfigure",
        NoneType,
        WGPUSurface,
        UnsafePointer[WGPUSurfaceConfiguration],
    ](handle, UnsafePointer(to=config))


fn surface_get_capabilities(
    handle: WGPUSurface,
    adapter: WGPUAdapter,
    capabilities: WGPUSurfaceCapabilities,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuSurfaceGetCapabilities",
        NoneType,
        WGPUSurface,
        WGPUAdapter,
        UnsafePointer[WGPUSurfaceCapabilities],
    ](handle, adapter, UnsafePointer(to=capabilities))


fn surface_get_current_texture(
    handle: WGPUSurface, surface_texture: WGPUSurfaceTexture
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuSurfaceGetCurrentTexture",
        NoneType,
        WGPUSurface,
        UnsafePointer[WGPUSurfaceTexture],
    ](handle, UnsafePointer(to=surface_texture))


fn surface_present(
    handle: WGPUSurface,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuSurfacePresent", NoneType, WGPUSurface,](
        handle,
    )


fn surface_unconfigure(
    handle: WGPUSurface,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuSurfaceUnconfigure", NoneType, WGPUSurface,](
        handle,
    )


fn surface_set_label(handle: WGPUSurface, label: UnsafePointer[Int8]) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuSurfaceSetLabel", NoneType, WGPUSurface, UnsafePointer[Int8]
    ](handle, label)


struct _TextureImpl:
    pass


alias WGPUTexture = UnsafePointer[_TextureImpl]


fn texture_release(handle: WGPUTexture):
    _ = external_call[
        "wgpuTextureRelease", NoneType, UnsafePointer[_TextureImpl]
    ](handle)


fn texture_create_view(
    handle: WGPUTexture,
    descriptor: WGPUTextureViewDescriptor = WGPUTextureViewDescriptor(),
) -> WGPUTextureView:
    """
    TODO
    """
    return external_call[
        "wgpuTextureCreateView",
        WGPUTextureView,
        WGPUTexture,
        UnsafePointer[WGPUTextureViewDescriptor],
    ](handle, UnsafePointer(to=descriptor))


fn texture_set_label(handle: WGPUTexture, label: UnsafePointer[Int8]) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuTextureSetLabel", NoneType, WGPUTexture, UnsafePointer[Int8]
    ](handle, label)


fn texture_get_width(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return external_call["wgpuTextureGetWidth", UInt32, WGPUTexture,](
        handle,
    )


fn texture_get_height(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return external_call["wgpuTextureGetHeight", UInt32, WGPUTexture,](
        handle,
    )


fn texture_get_depth_or_array_layers(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return external_call[
        "wgpuTextureGetDepthOrArrayLayers",
        UInt32,
        WGPUTexture,
    ](
        handle,
    )


fn texture_get_mip_level_count(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return external_call["wgpuTextureGetMipLevelCount", UInt32, WGPUTexture,](
        handle,
    )


fn texture_get_sample_count(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return external_call["wgpuTextureGetSampleCount", UInt32, WGPUTexture,](
        handle,
    )


fn texture_get_dimension(
    handle: WGPUTexture,
) -> TextureDimension:
    """
    TODO
    """
    return external_call[
        "wgpuTextureGetDimension",
        TextureDimension,
        WGPUTexture,
    ](
        handle,
    )


fn texture_get_format(
    handle: WGPUTexture,
) -> TextureFormat:
    """
    TODO
    """
    return external_call["wgpuTextureGetFormat", TextureFormat, WGPUTexture,](
        handle,
    )


fn texture_get_usage(
    handle: WGPUTexture,
) -> TextureUsage:
    """
    TODO
    """
    return external_call["wgpuTextureGetUsage", TextureUsage, WGPUTexture,](
        handle,
    )


fn texture_destroy(
    handle: WGPUTexture,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuTextureDestroy", NoneType, WGPUTexture,](
        handle,
    )


struct _TextureViewImpl:
    pass


alias WGPUTextureView = UnsafePointer[_TextureViewImpl]


fn texture_view_release(handle: WGPUTextureView):
    _ = external_call[
        "wgpuTextureViewRelease", NoneType, UnsafePointer[_TextureViewImpl]
    ](handle)


fn texture_view_set_label(
    handle: WGPUTextureView, label: UnsafePointer[Int8]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuTextureViewSetLabel",
        NoneType,
        WGPUTextureView,
        UnsafePointer[Int8],
    ](handle, label)


struct WGPURequestAdapterOptions(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        compatible_surface: WGPUSurface = {},
        power_preference: PowerPreference = PowerPreference(0),
        backend_type: BackendType = BackendType(0),
        force_fallback_adapter: Bool = False,
    ):
        self.next_in_chain = next_in_chain
        self.compatible_surface = compatible_surface
        self.power_preference = power_preference
        self.backend_type = backend_type
        self.force_fallback_adapter = force_fallback_adapter


struct WGPUAdapterInfo(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStructOut] = {},
        vendor: UnsafePointer[Int8] = {},
        architecture: UnsafePointer[Int8] = {},
        device: UnsafePointer[Int8] = {},
        description: UnsafePointer[Int8] = {},
        backend_type: BackendType = BackendType(0),
        adapter_type: AdapterType = AdapterType(0),
        vendor_ID: UInt32 = {},
        device_ID: UInt32 = {},
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


struct WGPUDeviceDescriptor(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        required_feature_count: Int = Int(),
        required_features: UnsafePointer[FeatureName] = UnsafePointer[
            FeatureName
        ](),
        required_limits: UnsafePointer[WGPURequiredLimits] = {},
        var default_queue: WGPUQueueDescriptor = {},
        device_lost_callback: UnsafePointer[NoneType] = {},
        device_lost_userdata: UnsafePointer[NoneType] = {},
        uncaptured_error_callback_info: UnsafePointer[NoneType] = {},
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


struct WGPUBindGroupEntry(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        binding: UInt32 = {},
        buffer: WGPUBuffer = {},
        offset: UInt64 = {},
        size: UInt64 = {},
        sampler: WGPUSampler = {},
        texture_view: WGPUTextureView = {},
    ):
        self.next_in_chain = next_in_chain
        self.binding = binding
        self.buffer = buffer
        self.offset = offset
        self.size = size
        self.sampler = sampler
        self.texture_view = texture_view


struct WGPUBindGroupDescriptor(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        layout: WGPUBindGroupLayout = {},
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


struct WGPUBufferBindingLayout(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var type: BufferBindingType
    var has_dynamic_offset: Bool
    var min_binding_size: UInt64

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        type: BufferBindingType = BufferBindingType(0),
        has_dynamic_offset: Bool = False,
        min_binding_size: UInt64 = {},
    ):
        self.next_in_chain = next_in_chain
        self.type = type
        self.has_dynamic_offset = has_dynamic_offset
        self.min_binding_size = min_binding_size


struct WGPUSamplerBindingLayout(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var type: SamplerBindingType

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        type: SamplerBindingType = SamplerBindingType(0),
    ):
        self.next_in_chain = next_in_chain
        self.type = type


struct WGPUTextureBindingLayout(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var sample_type: TextureSampleType
    var view_dimension: TextureViewDimension
    var multisampled: Bool

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        sample_type: TextureSampleType = TextureSampleType(0),
        view_dimension: TextureViewDimension = TextureViewDimension(0),
        multisampled: Bool = False,
    ):
        self.next_in_chain = next_in_chain
        self.sample_type = sample_type
        self.view_dimension = view_dimension
        self.multisampled = multisampled


struct WGPUSurfaceCapabilities(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStructOut] = {},
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


struct WGPUSurfaceConfiguration(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        device: WGPUDevice = {},
        format: TextureFormat = TextureFormat(0),
        usage: TextureUsage = TextureUsage(0),
        view_format_count: Int = Int(),
        view_formats: UnsafePointer[TextureFormat] = UnsafePointer[
            TextureFormat
        ](),
        alpha_mode: CompositeAlphaMode = CompositeAlphaMode(0),
        width: UInt32 = {},
        height: UInt32 = {},
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


struct WGPUStorageTextureBindingLayout(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var access: StorageTextureAccess
    var format: TextureFormat
    var view_dimension: TextureViewDimension

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        access: StorageTextureAccess = StorageTextureAccess(0),
        format: TextureFormat = TextureFormat(0),
        view_dimension: TextureViewDimension = TextureViewDimension(0),
    ):
        self.next_in_chain = next_in_chain
        self.access = access
        self.format = format
        self.view_dimension = view_dimension


struct WGPUBindGroupLayoutEntry(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        binding: UInt32 = {},
        visibility: ShaderStage = ShaderStage(0),
        var buffer: WGPUBufferBindingLayout = {},
        var sampler: WGPUSamplerBindingLayout = {},
        var texture: WGPUTextureBindingLayout = {},
        var storage_texture: WGPUStorageTextureBindingLayout = {},
    ):
        self.next_in_chain = next_in_chain
        self.binding = binding
        self.visibility = visibility
        self.buffer = buffer^
        self.sampler = sampler^
        self.texture = texture^
        self.storage_texture = storage_texture^


struct WGPUBindGroupLayoutDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var entrie_count: Int
    var entries: UnsafePointer[WGPUBindGroupLayoutEntry]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        entrie_count: Int = Int(),
        entries: UnsafePointer[WGPUBindGroupLayoutEntry] = UnsafePointer[
            WGPUBindGroupLayoutEntry
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.entrie_count = entrie_count
        self.entries = entries


struct WGPUBlendComponent(Copyable, ImplicitlyCopyable, Movable):
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


struct WGPUBufferDescriptor(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        usage: BufferUsage = BufferUsage(0),
        size: UInt64 = {},
        mapped_at_creation: Bool = False,
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.usage = usage
        self.size = size
        self.mapped_at_creation = mapped_at_creation


struct WGPUColor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var r: Float64
    var g: Float64
    var b: Float64
    var a: Float64

    fn __init__(
        out self,
        r: Float64 = {},
        g: Float64 = {},
        b: Float64 = {},
        a: Float64 = {},
    ):
        self.r = r
        self.g = g
        self.b = b
        self.a = a


struct WGPUConstantEntry(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var key: UnsafePointer[Int8]
    var value: Float64

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        key: UnsafePointer[Int8] = {},
        value: Float64 = {},
    ):
        self.next_in_chain = next_in_chain
        self.key = key
        self.value = value


struct WGPUCommandBufferDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label


struct WGPUCommandEncoderDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label


struct WGPUCompilationInfo(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var message_count: Int
    var messages: UnsafePointer[WGPUCompilationMessage]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        message_count: Int = Int(),
        messages: UnsafePointer[WGPUCompilationMessage] = UnsafePointer[
            WGPUCompilationMessage
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.message_count = message_count
        self.messages = messages


struct WGPUCompilationMessage(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        message: UnsafePointer[Int8] = {},
        type: CompilationMessageType = CompilationMessageType(0),
        line_num: UInt64 = {},
        line_pos: UInt64 = {},
        offset: UInt64 = {},
        length: UInt64 = {},
        utf16_line_pos: UInt64 = {},
        utf16_offset: UInt64 = {},
        utf16_length: UInt64 = {},
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


struct WGPUComputePassDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var timestamp_writes: UnsafePointer[WGPUComputePassTimestampWrites]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        timestamp_writes: UnsafePointer[WGPUComputePassTimestampWrites] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.timestamp_writes = timestamp_writes


struct WGPUComputePassTimestampWrites(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var query_set: WGPUQuerySet
    var beginning_of_pass_write_index: UInt32
    var end_of_pass_write_index: UInt32

    fn __init__(
        out self,
        query_set: WGPUQuerySet = {},
        beginning_of_pass_write_index: UInt32 = {},
        end_of_pass_write_index: UInt32 = {},
    ):
        self.query_set = query_set
        self.beginning_of_pass_write_index = beginning_of_pass_write_index
        self.end_of_pass_write_index = end_of_pass_write_index


struct WGPUComputePipelineDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var layout: WGPUPipelineLayout
    var compute: WGPUProgrammableStageDescriptor

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        layout: WGPUPipelineLayout = {},
        var compute: WGPUProgrammableStageDescriptor = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.layout = layout
        self.compute = compute^


struct WGPULimits(Copyable, ImplicitlyCopyable, Movable):
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
        max_texture_dimension_1D: UInt32 = {},
        max_texture_dimension_2D: UInt32 = {},
        max_texture_dimension_3D: UInt32 = {},
        max_texture_array_layers: UInt32 = {},
        max_bind_groups: UInt32 = {},
        max_bind_groups_plus_vertex_buffers: UInt32 = {},
        max_bindings_per_bind_group: UInt32 = {},
        max_dynamic_uniform_buffers_per_pipeline_layout: UInt32 = {},
        max_dynamic_storage_buffers_per_pipeline_layout: UInt32 = {},
        max_sampled_textures_per_shader_stage: UInt32 = {},
        max_samplers_per_shader_stage: UInt32 = {},
        max_storage_buffers_per_shader_stage: UInt32 = {},
        max_storage_textures_per_shader_stage: UInt32 = {},
        max_uniform_buffers_per_shader_stage: UInt32 = {},
        max_uniform_buffer_binding_size: UInt64 = {},
        max_storage_buffer_binding_size: UInt64 = {},
        min_uniform_buffer_offset_alignment: UInt32 = {},
        min_storage_buffer_offset_alignment: UInt32 = {},
        max_vertex_buffers: UInt32 = {},
        max_buffer_size: UInt64 = {},
        max_vertex_attributes: UInt32 = {},
        max_vertex_buffer_array_stride: UInt32 = {},
        max_inter_stage_shader_components: UInt32 = {},
        max_inter_stage_shader_variables: UInt32 = {},
        max_color_attachments: UInt32 = {},
        max_color_attachment_bytes_per_sample: UInt32 = {},
        max_compute_workgroup_storage_size: UInt32 = {},
        max_compute_invocations_per_workgroup: UInt32 = {},
        max_compute_workgroup_size_x: UInt32 = {},
        max_compute_workgroup_size_y: UInt32 = {},
        max_compute_workgroup_size_z: UInt32 = {},
        max_compute_workgroups_per_dimension: UInt32 = {},
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


struct WGPURequiredLimits(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var limits: WGPULimits

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        var limits: WGPULimits = {},
    ):
        self.next_in_chain = next_in_chain
        self.limits = limits^


struct WGPUSupportedLimits(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStructOut]
    var limits: WGPULimits

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStructOut] = {},
        var limits: WGPULimits = {},
    ):
        self.next_in_chain = next_in_chain
        self.limits = limits^


struct WGPUExtent3D(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var width: UInt32
    var height: UInt32
    var depth_or_array_layers: UInt32

    fn __init__(
        out self,
        width: UInt32 = {},
        height: UInt32 = {},
        depth_or_array_layers: UInt32 = {},
    ):
        self.width = width
        self.height = height
        self.depth_or_array_layers = depth_or_array_layers


struct WGPUImageCopyBuffer(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var layout: WGPUTextureDataLayout
    var buffer: WGPUBuffer

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        var layout: WGPUTextureDataLayout = {},
        buffer: WGPUBuffer = {},
    ):
        self.next_in_chain = next_in_chain
        self.layout = layout^
        self.buffer = buffer


struct WGPUImageCopyTexture(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        texture: WGPUTexture = {},
        mip_level: UInt32 = {},
        var origin: WGPUOrigin3D = {},
        aspect: TextureAspect = TextureAspect(0),
    ):
        self.next_in_chain = next_in_chain
        self.texture = texture
        self.mip_level = mip_level
        self.origin = origin^
        self.aspect = aspect


struct WGPUInstanceDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
    ):
        self.next_in_chain = next_in_chain


struct WGPUVertexAttribute(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var format: VertexFormat
    var offset: UInt64
    var shader_location: UInt32

    fn __init__(
        out self,
        format: VertexFormat = VertexFormat(0),
        offset: UInt64 = {},
        shader_location: UInt32 = {},
    ):
        self.format = format
        self.offset = offset
        self.shader_location = shader_location


struct WGPUVertexBufferLayout(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var array_stride: UInt64
    var step_mode: VertexStepMode
    var attribute_count: Int
    var attributes: UnsafePointer[WGPUVertexAttribute]

    fn __init__(
        out self,
        array_stride: UInt64 = {},
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


struct WGPUOrigin3D(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var x: UInt32
    var y: UInt32
    var z: UInt32

    fn __init__(
        out self,
        x: UInt32 = {},
        y: UInt32 = {},
        z: UInt32 = {},
    ):
        self.x = x
        self.y = y
        self.z = z


struct WGPUPipelineLayoutDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var bind_group_layout_count: Int
    var bind_group_layouts: UnsafePointer[WGPUBindGroupLayout]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        bind_group_layout_count: Int = Int(),
        bind_group_layouts: UnsafePointer[WGPUBindGroupLayout] = UnsafePointer[
            WGPUBindGroupLayout
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.bind_group_layout_count = bind_group_layout_count
        self.bind_group_layouts = bind_group_layouts


struct WGPUProgrammableStageDescriptor(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        module: WGPUShaderModule = {},
        entry_point: UnsafePointer[Int8] = {},
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


struct WGPUQuerySetDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var type: QueryType
    var count: UInt32

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        type: QueryType = QueryType(0),
        count: UInt32 = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.type = type
        self.count = count


struct WGPUQueueDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label


struct WGPURenderBundleDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label


struct WGPURenderBundleEncoderDescriptor(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        color_format_count: Int = Int(),
        color_formats: UnsafePointer[TextureFormat] = UnsafePointer[
            TextureFormat
        ](),
        depth_stencil_format: TextureFormat = TextureFormat(0),
        sample_count: UInt32 = {},
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


struct WGPURenderPassColorAttachment(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        view: WGPUTextureView = {},
        depth_slice: UInt32 = {},
        resolve_target: WGPUTextureView = {},
        load_op: LoadOp = LoadOp(0),
        store_op: StoreOp = StoreOp(0),
        var clear_value: WGPUColor = {},
    ):
        self.next_in_chain = next_in_chain
        self.view = view
        self.depth_slice = depth_slice
        self.resolve_target = resolve_target
        self.load_op = load_op
        self.store_op = store_op
        self.clear_value = clear_value^


struct WGPURenderPassDepthStencilAttachment(
    Copyable, ImplicitlyCopyable, Movable
):
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
        view: WGPUTextureView = {},
        depth_load_op: LoadOp = LoadOp(0),
        depth_store_op: StoreOp = StoreOp(0),
        depth_clear_value: Float32 = {},
        depth_read_only: Bool = False,
        stencil_load_op: LoadOp = LoadOp(0),
        stencil_store_op: StoreOp = StoreOp(0),
        stencil_clear_value: UInt32 = {},
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


struct WGPURenderPassDescriptor(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        color_attachment_count: Int = Int(),
        color_attachments: UnsafePointer[
            WGPURenderPassColorAttachment
        ] = UnsafePointer[WGPURenderPassColorAttachment](),
        depth_stencil_attachment: UnsafePointer[
            WGPURenderPassDepthStencilAttachment
        ] = {},
        occlusion_query_set: WGPUQuerySet = {},
        timestamp_writes: UnsafePointer[WGPURenderPassTimestampWrites] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.color_attachment_count = color_attachment_count
        self.color_attachments = color_attachments
        self.depth_stencil_attachment = depth_stencil_attachment
        self.occlusion_query_set = occlusion_query_set
        self.timestamp_writes = timestamp_writes


struct WGPURenderPassDescriptorMaxDrawCount(
    Copyable, ImplicitlyCopyable, Movable
):
    """
    TODO
    """

    var chain: ChainedStruct
    var max_draw_count: UInt64

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        max_draw_count: UInt64 = {},
    ):
        self.chain = chain
        self.max_draw_count = max_draw_count


struct WGPURenderPassTimestampWrites(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var query_set: WGPUQuerySet
    var beginning_of_pass_write_index: UInt32
    var end_of_pass_write_index: UInt32

    fn __init__(
        out self,
        query_set: WGPUQuerySet = {},
        beginning_of_pass_write_index: UInt32 = {},
        end_of_pass_write_index: UInt32 = {},
    ):
        self.query_set = query_set
        self.beginning_of_pass_write_index = beginning_of_pass_write_index
        self.end_of_pass_write_index = end_of_pass_write_index


struct WGPUVertexState(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        module: WGPUShaderModule = {},
        entry_point: UnsafePointer[Int8] = {},
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


struct WGPUPrimitiveState(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
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


struct WGPUPrimitiveDepthClipControl(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var chain: ChainedStruct
    var unclipped_depth: Bool

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        unclipped_depth: Bool = False,
    ):
        self.chain = chain
        self.unclipped_depth = unclipped_depth


struct WGPUDepthStencilState(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        format: TextureFormat = TextureFormat(0),
        depth_write_enabled: Bool = False,
        depth_compare: CompareFunction = CompareFunction(0),
        var stencil_front: WGPUStencilFaceState = {},
        var stencil_back: WGPUStencilFaceState = {},
        stencil_read_mask: UInt32 = {},
        stencil_write_mask: UInt32 = {},
        depth_bias: Int32 = {},
        depth_bias_slope_scale: Float32 = {},
        depth_bias_clamp: Float32 = {},
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


struct WGPUMultisampleState(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var count: UInt32
    var mask: UInt32
    var alpha_to_coverage_enabled: Bool

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        count: UInt32 = {},
        mask: UInt32 = {},
        alpha_to_coverage_enabled: Bool = False,
    ):
        self.next_in_chain = next_in_chain
        self.count = count
        self.mask = mask
        self.alpha_to_coverage_enabled = alpha_to_coverage_enabled


struct WGPUFragmentState(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        module: WGPUShaderModule = {},
        entry_point: UnsafePointer[Int8] = {},
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


struct WGPUColorTargetState(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var format: TextureFormat
    var blend: UnsafePointer[WGPUBlendState]
    var write_mask: ColorWriteMask

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        format: TextureFormat = TextureFormat(0),
        blend: UnsafePointer[WGPUBlendState] = {},
        write_mask: ColorWriteMask = ColorWriteMask(0),
    ):
        self.next_in_chain = next_in_chain
        self.format = format
        self.blend = blend
        self.write_mask = write_mask


struct WGPUBlendState(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var color: WGPUBlendComponent
    var alpha: WGPUBlendComponent

    fn __init__(
        out self,
        var color: WGPUBlendComponent = {},
        var alpha: WGPUBlendComponent = {},
    ):
        self.color = color^
        self.alpha = alpha^


struct WGPURenderPipelineDescriptor(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        layout: WGPUPipelineLayout = {},
        var vertex: WGPUVertexState = {},
        var primitive: WGPUPrimitiveState = {},
        depth_stencil: UnsafePointer[WGPUDepthStencilState] = {},
        var multisample: WGPUMultisampleState = {},
        fragment: UnsafePointer[WGPUFragmentState] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.layout = layout
        self.vertex = vertex^
        self.primitive = primitive^
        self.depth_stencil = depth_stencil
        self.multisample = multisample^
        self.fragment = fragment


struct WGPUSamplerDescriptor(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        address_mode_u: AddressMode = AddressMode(0),
        address_mode_v: AddressMode = AddressMode(0),
        address_mode_w: AddressMode = AddressMode(0),
        mag_filter: FilterMode = FilterMode(0),
        min_filter: FilterMode = FilterMode(0),
        mipmap_filter: MipmapFilterMode = MipmapFilterMode(0),
        lod_min_clamp: Float32 = {},
        lod_max_clamp: Float32 = {},
        compare: CompareFunction = CompareFunction(0),
        max_anisotropy: UInt16 = {},
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


struct WGPUShaderModuleDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]
    var hint_count: Int
    var hints: UnsafePointer[WGPUShaderModuleCompilationHint]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        hint_count: Int = Int(),
        hints: UnsafePointer[WGPUShaderModuleCompilationHint] = UnsafePointer[
            WGPUShaderModuleCompilationHint
        ](),
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.hint_count = hint_count
        self.hints = hints


struct WGPUShaderModuleCompilationHint(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var entry_point: UnsafePointer[Int8]
    var layout: WGPUPipelineLayout

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        entry_point: UnsafePointer[Int8] = {},
        layout: WGPUPipelineLayout = {},
    ):
        self.next_in_chain = next_in_chain
        self.entry_point = entry_point
        self.layout = layout


struct WGPUShaderModuleSpirvDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var chain: ChainedStruct
    var code_size: UInt32
    var code: UInt32

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        code_size: UInt32 = {},
        code: UInt32 = {},
    ):
        self.chain = chain
        self.code_size = code_size
        self.code = code


struct WGPUShaderModuleWgslDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var chain: ChainedStruct
    var code: UnsafePointer[Int8]

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        code: UnsafePointer[Int8] = {},
    ):
        self.chain = chain
        self.code = code


struct WGPUStencilFaceState(Copyable, ImplicitlyCopyable, Movable):
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


struct WGPUSurfaceDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var label: UnsafePointer[Int8]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label


struct WGPUSurfaceDescriptorFromAndroidNativeWindow(
    Copyable, ImplicitlyCopyable, Movable
):
    """
    TODO
    """

    var chain: ChainedStruct
    var window: UnsafePointer[NoneType]

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        window: UnsafePointer[NoneType] = {},
    ):
        self.chain = chain
        self.window = window


struct WGPUSurfaceDescriptorFromCanvasHtmlSelector(
    Copyable, ImplicitlyCopyable, Movable
):
    """
    TODO
    """

    var chain: ChainedStruct
    var selector: UnsafePointer[Int8]

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        selector: UnsafePointer[Int8] = {},
    ):
        self.chain = chain
        self.selector = selector


struct WGPUSurfaceDescriptorFromMetalLayer(
    Copyable, ImplicitlyCopyable, Movable
):
    """
    TODO
    """

    var chain: ChainedStruct
    var layer: UnsafePointer[NoneType]

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        layer: UnsafePointer[NoneType] = {},
    ):
        self.chain = chain
        self.layer = layer


struct WGPUSurfaceDescriptorFromWindowsHwnd(
    Copyable, ImplicitlyCopyable, Movable
):
    """
    TODO
    """

    var chain: ChainedStruct
    var hinstance: UnsafePointer[NoneType]
    var hwnd: UnsafePointer[NoneType]

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        hinstance: UnsafePointer[NoneType] = {},
        hwnd: UnsafePointer[NoneType] = {},
    ):
        self.chain = chain
        self.hinstance = hinstance
        self.hwnd = hwnd


struct WGPUSurfaceDescriptorFromXcbWindow(
    Copyable, ImplicitlyCopyable, Movable
):
    """
    TODO
    """

    var chain: ChainedStruct
    var connection: UnsafePointer[NoneType]
    var window: UInt32

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        connection: UnsafePointer[NoneType] = {},
        window: UInt32 = {},
    ):
        self.chain = chain
        self.connection = connection
        self.window = window


struct WGPUSurfaceDescriptorFromXlibWindow(
    Copyable, ImplicitlyCopyable, Movable
):
    """
    TODO
    """

    var chain: ChainedStruct
    var display: UnsafePointer[NoneType]
    var window: UInt64

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        display: UnsafePointer[NoneType] = {},
        window: UInt64 = {},
    ):
        self.chain = chain
        self.display = display
        self.window = window


struct WGPUSurfaceDescriptorFromWaylandSurface(
    Copyable, ImplicitlyCopyable, Movable
):
    """
    TODO
    """

    var chain: ChainedStruct
    var display: UnsafePointer[NoneType]
    var surface: UnsafePointer[NoneType]

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        display: UnsafePointer[NoneType] = {},
        surface: UnsafePointer[NoneType] = {},
    ):
        self.chain = chain
        self.display = display
        self.surface = surface


struct WGPUSurfaceTexture(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var texture: WGPUTexture
    var suboptimal: Bool
    var status: SurfaceGetCurrentTextureStatus

    fn __init__(
        out self,
        texture: WGPUTexture = {},
        suboptimal: Bool = False,
        status: SurfaceGetCurrentTextureStatus = SurfaceGetCurrentTextureStatus(
            0
        ),
    ):
        self.texture = texture
        self.suboptimal = suboptimal
        self.status = status


struct WGPUTextureDataLayout(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var offset: UInt64
    var bytes_per_row: UInt32
    var rows_per_image: UInt32

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        offset: UInt64 = {},
        bytes_per_row: UInt32 = {},
        rows_per_image: UInt32 = {},
    ):
        self.next_in_chain = next_in_chain
        self.offset = offset
        self.bytes_per_row = bytes_per_row
        self.rows_per_image = rows_per_image


struct WGPUTextureDescriptor(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        usage: TextureUsage = TextureUsage(0),
        dimension: TextureDimension = TextureDimension(0),
        var size: WGPUExtent3D = {},
        format: TextureFormat = TextureFormat(0),
        mip_level_count: UInt32 = {},
        sample_count: UInt32 = {},
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


struct WGPUTextureViewDescriptor(Copyable, ImplicitlyCopyable, Movable):
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
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        label: UnsafePointer[Int8] = {},
        format: TextureFormat = TextureFormat(0),
        dimension: TextureViewDimension = TextureViewDimension(0),
        base_mip_level: UInt32 = {},
        mip_level_count: UInt32 = {},
        base_array_layer: UInt32 = {},
        array_layer_count: UInt32 = {},
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


struct WGPUUncapturedErrorCallbackInfo(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: UnsafePointer[ChainedStruct]
    var callback: UnsafePointer[NoneType]
    var userdata: UnsafePointer[NoneType]

    fn __init__(
        out self,
        next_in_chain: UnsafePointer[ChainedStruct] = {},
        callback: UnsafePointer[NoneType] = {},
        userdata: UnsafePointer[NoneType] = {},
    ):
        self.next_in_chain = next_in_chain
        self.callback = callback
        self.userdata = userdata


fn create_instance(
    descriptor: WGPUInstanceDescriptor = WGPUInstanceDescriptor(),
) -> WGPUInstance:
    """
    TODO
    """
    return external_call[
        "wgpuCreateInstance",
        WGPUInstance,
        UnsafePointer[WGPUInstanceDescriptor],
    ](UnsafePointer(to=descriptor))


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


struct WGPUInstanceEnumerateAdapterOptions(
    Copyable, ImplicitlyCopyable, Movable
):
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


fn generate_report(
    instance: WGPUInstance, report: UnsafePointer[WGPUGlobalReport]
):
    external_call[
        "wgpuGenerateReport",
        NoneType,
        WGPUInstance,
        UnsafePointer[WGPUGlobalReport],
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
    ](instance, options, adapters)


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
    """Returns true if the queue is empty, or false if there are more queue submissions still in flight.
    """
    return external_call[
        "wgpuDevicePoll",
        Bool,
        WGPUDevice,
        Bool,
        UnsafePointer[WGPUWrappedSubmissionIndex],
    ](
        device,
        wait,
        wrapped_submission_index,
    )


fn set_log_callback(
    callback: WGPULogCallback, userdata: UnsafePointer[NoneType]
):
    _ = external_call[
        "wgpuSetLogCallback", NoneType, WGPULogCallback, UnsafePointer[NoneType]
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
    ](encoder, stages, offset, size_bytes, data)


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
    ](encoder, buffer, offset, count)


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
    ](encoder, buffer, offset, count_buffer, count_buffer_offset, max_count)


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
    ](encoder, buffer, offset, count_buffer, count_buffer_offset, max_count)


fn compute_pass_encoder_begin_pipeline_statistics_query(
    compute_pass_encoder: WGPUComputePassEncoder,
    query_set: WGPUQuerySet,
    query_index: UInt32,
):
    _ = external_call[
        "wgpuComputePassEncoderBeginPipelineStatisticsQuery",
        NoneType,
        WGPUComputePassEncoder,
        WGPUQuerySet,
        UInt32,
    ](compute_pass_encoder, query_set, query_index)


fn compute_pass_encoder_end_pipeline_statistics_query(
    compute_pass_encoder: WGPUComputePassEncoder,
):
    _ = external_call[
        "wgpuComputePassEncoderEndPipelineStatisticsQuery",
        NoneType,
        WGPUComputePassEncoder,
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
    ](render_pass_encoder, query_set, query_index)


fn render_pass_encoder_end_pipeline_statistics_query(
    render_pass_encoder: WGPURenderPassEncoder,
):
    _ = external_call[
        "wgpuRenderPassEncoderEndPipelineStatisticsQuery",
        NoneType,
        WGPURenderPassEncoder,
    ](render_pass_encoder)


fn surface_capabilities_free_members(
    capabilities: UnsafePointer[WGPUSurfaceCapabilities],
):
    external_call[
        "wgpuSurfaceCapabilitiesFreeMembers",
        NoneType,
        UnsafePointer[WGPUSurfaceCapabilities],
    ](capabilities)
