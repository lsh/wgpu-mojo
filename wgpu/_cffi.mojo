from glfw._cffi import FFIPointer

from sys.ffi import external_call
from .enums import *
from .bitflags import *
from .constants import *


@register_passable("trivial")
struct ChainedStruct(Copyable, ImplicitlyCopyable, Movable):
    var next: FFIPointer[Self, mut=True]
    var s_type: SType

    fn __init__(
        out self,
        next: FFIPointer[Self, mut=True] = {},
        s_type: SType = SType.invalid,
    ):
        self.next = next
        self.s_type = s_type


@register_passable("trivial")
struct ChainedStructOut(Copyable, ImplicitlyCopyable, Movable):
    var next: FFIPointer[Self, mut=True]
    var s_type: SType

    fn __init__(
        out self,
        next: FFIPointer[Self, mut=True] = {},
        s_type: SType = SType.invalid,
    ):
        self.next = next
        self.s_type = s_type


struct _AdapterImpl:
    pass


comptime WGPUAdapter = FFIPointer[_AdapterImpl, mut=True]


fn adapter_release(handle: WGPUAdapter):
    _ = external_call["wgpuAdapterRelease", NoneType, type_of(handle)](handle)


fn adapter_get_limits(
    handle: WGPUAdapter, limits: FFIPointer[WGPUSupportedLimits, mut=True]
) -> Bool:
    """
    TODO
    """
    return external_call[
        "wgpuAdapterGetLimits", Bool, type_of(handle), type_of(limits)
    ](handle, limits)


fn adapter_has_feature(handle: WGPUAdapter, feature: FeatureName) -> Bool:
    """
    TODO
    """
    return external_call[
        "wgpuAdapterHasFeature", Bool, type_of(handle), type_of(feature)
    ](handle, feature)


fn adapter_enumerate_features(
    handle: WGPUAdapter, features: FeatureName
) -> Int:
    """
    TODO
    """
    return external_call[
        "wgpuAdapterEnumerateFeatures", Int, type_of(handle), type_of(features)
    ](handle, features)


fn adapter_get_info(
    handle: WGPUAdapter, info: FFIPointer[WGPUAdapterInfo, mut=True]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuAdapterGetInfo", NoneType, type_of(handle), type_of(info)
    ](handle, info)


fn adapter_request_device(
    handle: WGPUAdapter,
    callback: fn (
        RequestDeviceStatus,
        WGPUDevice,
        FFIPointer[Int8, mut=False],
        FFIPointer[NoneType, mut=True],
    ) -> None,
    user_data: FFIPointer[NoneType, mut=True],
    descriptor: FFIPointer[WGPUDeviceDescriptor, mut=True] = {},
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuAdapterRequestDevice",
        NoneType,
        type_of(handle),
        type_of(descriptor),
        type_of(callback),
        type_of(user_data),
    ](handle, descriptor, callback, user_data)


struct _BindGroupImpl:
    pass


comptime WGPUBindGroup = FFIPointer[_BindGroupImpl, mut=True]


fn bind_group_release(handle: WGPUBindGroup):
    _ = external_call["wgpuBindGroupRelease", NoneType, type_of(handle)](handle)


fn bind_group_set_label(
    handle: WGPUBindGroup, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuBindGroupSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _BindGroupLayoutImpl:
    pass


comptime WGPUBindGroupLayout = FFIPointer[_BindGroupLayoutImpl, mut=True]


fn bind_group_layout_release(handle: WGPUBindGroupLayout):
    _ = external_call["wgpuBindGroupLayoutRelease", NoneType, type_of(handle)](
        handle
    )


fn bind_group_layout_set_label(
    handle: WGPUBindGroupLayout, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuBindGroupLayoutSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _BufferImpl:
    pass


comptime WGPUBuffer = FFIPointer[_BufferImpl, mut=True]


fn buffer_release(handle: WGPUBuffer):
    _ = external_call["wgpuBufferRelease", NoneType, type_of(handle)](handle)


fn buffer_map_async(
    handle: WGPUBuffer,
    mode: MapMode,
    offset: Int,
    size: Int,
    callback: fn (BufferMapAsyncStatus, FFIPointer[NoneType, mut=True]) -> None,
    user_data: FFIPointer[NoneType, mut=True],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuBufferMapAsync",
        NoneType,
        type_of(handle),
        type_of(mode),
        type_of(offset),
        type_of(size),
        type_of(callback),
        type_of(user_data),
    ](handle, mode, offset, size, callback, user_data)


fn buffer_get_mapped_range(
    handle: WGPUBuffer, offset: Int, size: Int
) -> FFIPointer[NoneType, mut=True]:
    """
    TODO
    """
    return external_call[
        "wgpuBufferGetMappedRange",
        FFIPointer[NoneType, mut=True],
        type_of(handle),
        type_of(offset),
        type_of(size),
    ](handle, offset, size)


fn buffer_get_const_mapped_range(
    handle: WGPUBuffer, offset: Int, size: Int
) -> FFIPointer[NoneType, mut=True]:
    """
    TODO
    """
    return external_call[
        "wgpuBufferGetConstMappedRange",
        FFIPointer[NoneType, mut=True],
        type_of(handle),
        type_of(offset),
        type_of(size),
    ](handle, offset, size)


fn buffer_set_label(
    handle: WGPUBuffer, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuBufferSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


fn buffer_get_usage(
    handle: WGPUBuffer,
) -> BufferUsage:
    """
    TODO
    """
    return external_call["wgpuBufferGetUsage", BufferUsage, type_of(handle)](
        handle
    )


fn buffer_get_size(
    handle: WGPUBuffer,
) -> UInt64:
    """
    TODO
    """
    return external_call["wgpuBufferGetSize", UInt64, type_of(handle)](handle)


fn buffer_get_map_state(
    handle: WGPUBuffer,
) -> BufferMapState:
    """
    TODO
    """
    return external_call[
        "wgpuBufferGetMapState", BufferMapState, type_of(handle)
    ](handle)


fn buffer_unmap(
    handle: WGPUBuffer,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuBufferUnmap", NoneType, type_of(handle)](handle)


fn buffer_destroy(
    handle: WGPUBuffer,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuBufferDestroy", NoneType, type_of(handle)](handle)


struct _CommandBufferImpl:
    pass


comptime WGPUCommandBuffer = FFIPointer[_CommandBufferImpl, mut=True]


fn command_buffer_release(handle: WGPUCommandBuffer):
    _ = external_call["wgpuCommandBufferRelease", NoneType, type_of(handle)](
        handle
    )


fn command_buffer_set_label(
    handle: WGPUCommandBuffer, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandBufferSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _CommandEncoderImpl:
    pass


comptime WGPUCommandEncoder = FFIPointer[_CommandEncoderImpl, mut=True]


fn command_encoder_release(handle: WGPUCommandEncoder):
    _ = external_call["wgpuCommandEncoderRelease", NoneType, type_of(handle)](
        handle
    )


fn command_encoder_finish(
    handle: WGPUCommandEncoder,
    descriptor: FFIPointer[WGPUCommandBufferDescriptor, mut=True] = {},
) -> WGPUCommandBuffer:
    """
    TODO
    """
    return external_call[
        "wgpuCommandEncoderFinish",
        WGPUCommandBuffer,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn command_encoder_begin_compute_pass(
    handle: WGPUCommandEncoder,
    descriptor: FFIPointer[WGPUComputePassDescriptor, mut=True] = {},
) -> WGPUComputePassEncoder:
    """
    TODO
    """
    return external_call[
        "wgpuCommandEncoderBeginComputePass",
        WGPUComputePassEncoder,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn command_encoder_begin_render_pass(
    handle: WGPUCommandEncoder,
    descriptor: FFIPointer[WGPURenderPassDescriptor, mut=True],
) -> WGPURenderPassEncoder:
    """
    TODO
    """
    return external_call[
        "wgpuCommandEncoderBeginRenderPass",
        WGPURenderPassEncoder,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


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
        type_of(handle),
        type_of(source),
        type_of(source_offset),
        type_of(destination),
        type_of(destination_offset),
        type_of(size),
    ](handle, source, source_offset, destination, destination_offset, size)


fn command_encoder_copy_buffer_to_texture(
    handle: WGPUCommandEncoder,
    source: FFIPointer[WGPUImageCopyBuffer, mut=True],
    destination: FFIPointer[WGPUImageCopyTexture, mut=True],
    copy_size: FFIPointer[WGPUExtent3D, mut=True],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderCopyBufferToTexture",
        NoneType,
        type_of(handle),
        type_of(source),
        type_of(destination),
        type_of(copy_size),
    ](handle, source, destination, copy_size)


fn command_encoder_copy_texture_to_buffer(
    handle: WGPUCommandEncoder,
    source: FFIPointer[WGPUImageCopyTexture, mut=True],
    destination: FFIPointer[WGPUImageCopyBuffer, mut=True],
    copy_size: FFIPointer[WGPUExtent3D, mut=True],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderCopyTextureToBuffer",
        NoneType,
        type_of(handle),
        type_of(source),
        type_of(destination),
        type_of(copy_size),
    ](handle, source, destination, copy_size)


fn command_encoder_copy_texture_to_texture(
    handle: WGPUCommandEncoder,
    source: FFIPointer[WGPUImageCopyTexture, mut=True],
    destination: FFIPointer[WGPUImageCopyTexture, mut=True],
    copy_size: FFIPointer[WGPUExtent3D, mut=True],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderCopyTextureToTexture",
        NoneType,
        type_of(handle),
        type_of(source),
        type_of(destination),
        type_of(copy_size),
    ](handle, source, destination, copy_size)


fn command_encoder_clear_buffer(
    handle: WGPUCommandEncoder, buffer: WGPUBuffer, offset: UInt64, size: UInt64
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderClearBuffer",
        NoneType,
        type_of(handle),
        type_of(buffer),
        type_of(offset),
        type_of(size),
    ](handle, buffer, offset, size)


fn command_encoder_insert_debug_marker(
    handle: WGPUCommandEncoder, marker_label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderInsertDebugMarker",
        NoneType,
        type_of(handle),
        type_of(marker_label),
    ](handle, marker_label)


fn command_encoder_pop_debug_group(
    handle: WGPUCommandEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderPopDebugGroup", NoneType, type_of(handle)
    ](handle)


fn command_encoder_push_debug_group(
    handle: WGPUCommandEncoder, group_label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderPushDebugGroup",
        NoneType,
        type_of(handle),
        type_of(group_label),
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
        type_of(handle),
        type_of(query_set),
        type_of(first_query),
        type_of(query_count),
        type_of(destination),
        type_of(destination_offset),
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
        type_of(handle),
        type_of(query_set),
        type_of(query_index),
    ](handle, query_set, query_index)


fn command_encoder_set_label(
    handle: WGPUCommandEncoder, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuCommandEncoderSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _ComputePassEncoderImpl:
    pass


comptime WGPUComputePassEncoder = FFIPointer[_ComputePassEncoderImpl, mut=True]


fn compute_pass_encoder_release(handle: WGPUComputePassEncoder):
    _ = external_call[
        "wgpuComputePassEncoderRelease", NoneType, type_of(handle)
    ](handle)


fn compute_pass_encoder_insert_debug_marker(
    handle: WGPUComputePassEncoder, marker_label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderInsertDebugMarker",
        NoneType,
        type_of(handle),
        type_of(marker_label),
    ](handle, marker_label)


fn compute_pass_encoder_pop_debug_group(
    handle: WGPUComputePassEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderPopDebugGroup", NoneType, type_of(handle)
    ](handle)


fn compute_pass_encoder_push_debug_group(
    handle: WGPUComputePassEncoder, group_label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderPushDebugGroup",
        NoneType,
        type_of(handle),
        type_of(group_label),
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
        type_of(handle),
        type_of(pipeline),
    ](handle, pipeline)


fn compute_pass_encoder_set_bind_group(
    handle: WGPUComputePassEncoder,
    group_index: UInt32,
    dynamic_offset_count: Int,
    dynamic_offsets: FFIPointer[UInt32, mut=False],
    group: WGPUBindGroup = {},
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderSetBindGroup",
        NoneType,
        type_of(handle),
        type_of(group_index),
        type_of(group),
        type_of(dynamic_offset_count),
        type_of(dynamic_offsets),
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
        type_of(handle),
        type_of(workgroupCountX),
        type_of(workgroupCountY),
        type_of(workgroupCountZ),
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
        type_of(handle),
        type_of(indirect_buffer),
        type_of(indirect_offset),
    ](handle, indirect_buffer, indirect_offset)


fn compute_pass_encoder_end(
    handle: WGPUComputePassEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuComputePassEncoderEnd", NoneType, type_of(handle)](
        handle
    )


fn compute_pass_encoder_set_label(
    handle: WGPUComputePassEncoder, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePassEncoderSetLabel",
        NoneType,
        type_of(handle),
        type_of(label),
    ](handle, label)


struct _ComputePipelineImpl:
    pass


comptime WGPUComputePipeline = FFIPointer[_ComputePipelineImpl, mut=True]


fn compute_pipeline_release(handle: WGPUComputePipeline):
    _ = external_call["wgpuComputePipelineRelease", NoneType, type_of(handle)](
        handle
    )


fn compute_pipeline_get_bind_group_layout(
    handle: WGPUComputePipeline, group_index: UInt32
) -> WGPUBindGroupLayout:
    """
    TODO
    """
    return external_call[
        "wgpuComputePipelineGetBindGroupLayout",
        WGPUBindGroupLayout,
        type_of(handle),
        type_of(group_index),
    ](handle, group_index)


fn compute_pipeline_set_label(
    handle: WGPUComputePipeline, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuComputePipelineSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _DeviceImpl:
    pass


comptime WGPUDevice = FFIPointer[_DeviceImpl, mut=True]


fn device_release(handle: WGPUDevice):
    _ = external_call["wgpuDeviceRelease", NoneType, type_of(handle)](handle)


fn device_create_bind_group(
    handle: WGPUDevice,
    descriptor: FFIPointer[WGPUBindGroupDescriptor, mut=True],
) -> WGPUBindGroup:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateBindGroup",
        WGPUBindGroup,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn device_create_bind_group_layout(
    handle: WGPUDevice,
    descriptor: FFIPointer[WGPUBindGroupLayoutDescriptor, mut=True],
) -> WGPUBindGroupLayout:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateBindGroupLayout",
        WGPUBindGroupLayout,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn device_create_buffer(
    handle: WGPUDevice, descriptor: FFIPointer[WGPUBufferDescriptor, mut=True]
) -> WGPUBuffer:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateBuffer",
        WGPUBuffer,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn device_create_command_encoder(
    handle: WGPUDevice,
    descriptor: FFIPointer[WGPUCommandEncoderDescriptor, mut=True] = {},
) -> WGPUCommandEncoder:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateCommandEncoder",
        WGPUCommandEncoder,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn device_create_compute_pipeline(
    handle: WGPUDevice,
    descriptor: FFIPointer[WGPUComputePipelineDescriptor, mut=True],
) -> WGPUComputePipeline:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateComputePipeline",
        WGPUComputePipeline,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn device_create_compute_pipeline_async(
    handle: WGPUDevice,
    descriptor: FFIPointer[WGPUComputePipelineDescriptor, mut=True],
    callback: fn (
        CreatePipelineAsyncStatus,
        WGPUComputePipeline,
        FFIPointer[Int8, mut=False],
        FFIPointer[NoneType, mut=True],
    ) -> None,
    user_data: FFIPointer[NoneType, mut=True],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuDeviceCreateComputePipelineAsync",
        NoneType,
        type_of(handle),
        type_of(descriptor),
        type_of(callback),
        type_of(user_data),
    ](handle, descriptor, callback, user_data)


fn device_create_pipeline_layout(
    handle: WGPUDevice,
    descriptor: FFIPointer[WGPUPipelineLayoutDescriptor, mut=True],
) -> WGPUPipelineLayout:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreatePipelineLayout",
        WGPUPipelineLayout,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn device_create_query_set(
    handle: WGPUDevice, descriptor: FFIPointer[WGPUQuerySetDescriptor, mut=True]
) -> WGPUQuerySet:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateQuerySet",
        WGPUQuerySet,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn device_create_render_pipeline_async(
    handle: WGPUDevice,
    descriptor: FFIPointer[WGPURenderPipelineDescriptor, mut=True],
    callback: fn (
        CreatePipelineAsyncStatus,
        WGPURenderPipeline,
        FFIPointer[Int8, mut=False],
        FFIPointer[NoneType, mut=True],
    ) -> None,
    user_data: FFIPointer[NoneType, mut=True],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuDeviceCreateRenderPipelineAsync",
        NoneType,
        type_of(handle),
        type_of(descriptor),
        type_of(callback),
        type_of(user_data),
    ](handle, descriptor, callback, user_data)


fn device_create_render_bundle_encoder(
    handle: WGPUDevice,
    descriptor: FFIPointer[WGPURenderBundleEncoderDescriptor, mut=True],
) -> WGPURenderBundleEncoder:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateRenderBundleEncoder",
        WGPURenderBundleEncoder,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn device_create_render_pipeline(
    handle: WGPUDevice,
    descriptor: FFIPointer[WGPURenderPipelineDescriptor, mut=True],
) -> WGPURenderPipeline:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateRenderPipeline",
        WGPURenderPipeline,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn device_create_sampler(
    handle: WGPUDevice,
    descriptor: FFIPointer[WGPUSamplerDescriptor, mut=True] = {},
) -> WGPUSampler:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateSampler",
        WGPUSampler,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn device_create_shader_module(
    handle: WGPUDevice,
    descriptor: FFIPointer[WGPUShaderModuleDescriptor, mut=True],
) -> WGPUShaderModule:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateShaderModule",
        WGPUShaderModule,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn device_create_texture(
    handle: WGPUDevice, descriptor: FFIPointer[WGPUTextureDescriptor, mut=True]
) -> WGPUTexture:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceCreateTexture",
        WGPUTexture,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn device_destroy(
    handle: WGPUDevice,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuDeviceDestroy", NoneType, type_of(handle)](handle)


fn device_get_limits(
    handle: WGPUDevice, limits: FFIPointer[WGPUSupportedLimits, mut=True]
) -> Bool:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceGetLimits", Bool, type_of(handle), type_of(limits)
    ](handle, limits)


fn device_has_feature(handle: WGPUDevice, feature: FeatureName) -> Bool:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceHasFeature", Bool, type_of(handle), type_of(feature)
    ](handle, feature)


fn device_enumerate_features(handle: WGPUDevice, features: FeatureName) -> Int:
    """
    TODO
    """
    return external_call[
        "wgpuDeviceEnumerateFeatures", Int, type_of(handle), type_of(features)
    ](handle, features)


fn device_get_queue(
    handle: WGPUDevice,
) -> WGPUQueue:
    """
    TODO
    """
    return external_call["wgpuDeviceGetQueue", WGPUQueue, type_of(handle)](
        handle
    )


fn device_push_error_scope(handle: WGPUDevice, filter: ErrorFilter) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuDevicePushErrorScope", NoneType, type_of(handle), type_of(filter)
    ](handle, filter)


fn device_pop_error_scope(
    handle: WGPUDevice,
    callback: ErrorCallback,
    userdata: FFIPointer[NoneType, mut=True],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuDevicePopErrorScope",
        NoneType,
        type_of(handle),
        type_of(callback),
        type_of(userdata),
    ](handle, callback, userdata)


fn device_set_label(
    handle: WGPUDevice, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuDeviceSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _InstanceImpl:
    pass


comptime WGPUInstance = FFIPointer[_InstanceImpl, mut=True]


fn instance_release(handle: WGPUInstance):
    _ = external_call["wgpuInstanceRelease", NoneType, type_of(handle)](handle)


fn instance_create_surface(
    handle: WGPUInstance,
    descriptor: FFIPointer[WGPUSurfaceDescriptor, mut=True],
) -> WGPUSurface:
    """
    TODO
    """
    return external_call[
        "wgpuInstanceCreateSurface",
        WGPUSurface,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn instance_has_WGSL_language_feature(
    handle: WGPUInstance, feature: WgslFeatureName
) -> Bool:
    """
    TODO
    """
    return external_call[
        "wgpuInstanceHasWgslLanguageFeature",
        Bool,
        type_of(handle),
        type_of(feature),
    ](handle, feature)


fn instance_process_events(
    handle: WGPUInstance,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuInstanceProcessEvents", NoneType, type_of(handle)](
        handle
    )


fn instance_request_adapter(
    handle: WGPUInstance,
    callback: fn (
        RequestAdapterStatus,
        WGPUAdapter,
        FFIPointer[Int8, mut=False],
        FFIPointer[NoneType, mut=True],
    ) -> None,
    user_data: FFIPointer[NoneType, mut=True],
    options: FFIPointer[WGPURequestAdapterOptions, mut=True] = {},
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuInstanceRequestAdapter",
        NoneType,
        type_of(handle),
        type_of(options),
        type_of(callback),
        type_of(user_data),
    ](handle, options, callback, user_data)


struct _PipelineLayoutImpl:
    pass


comptime WGPUPipelineLayout = FFIPointer[_PipelineLayoutImpl, mut=True]


fn pipeline_layout_release(handle: WGPUPipelineLayout):
    _ = external_call["wgpuPipelineLayoutRelease", NoneType, type_of(handle)](
        handle
    )


fn pipeline_layout_set_label(
    handle: WGPUPipelineLayout, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuPipelineLayoutSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _QuerySetImpl:
    pass


comptime WGPUQuerySet = FFIPointer[_QuerySetImpl, mut=True]


fn query_set_release(handle: WGPUQuerySet):
    _ = external_call["wgpuQuerySetRelease", NoneType, type_of(handle)](handle)


fn query_set_set_label(
    handle: WGPUQuerySet, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuQuerySetSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


fn query_set_get_type(
    handle: WGPUQuerySet,
) -> QueryType:
    """
    TODO
    """
    return external_call["wgpuQuerySetGetType", QueryType, type_of(handle)](
        handle
    )


fn query_set_get_count(
    handle: WGPUQuerySet,
) -> UInt32:
    """
    TODO
    """
    return external_call["wgpuQuerySetGetCount", UInt32, type_of(handle)](
        handle
    )


fn query_set_destroy(
    handle: WGPUQuerySet,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuQuerySetDestroy", NoneType, type_of(handle)](handle)


struct _QueueImpl:
    pass


comptime WGPUQueue = FFIPointer[_QueueImpl, mut=True]


fn queue_release(handle: WGPUQueue):
    _ = external_call["wgpuQueueRelease", NoneType, type_of(handle)](handle)


fn queue_submit(
    handle: WGPUQueue,
    command_count: Int,
    commands: FFIPointer[WGPUCommandBuffer, mut=False],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuQueueSubmit",
        NoneType,
        type_of(handle),
        type_of(command_count),
        type_of(commands),
    ](handle, command_count, commands)


fn queue_on_submitted_work_done(
    handle: WGPUQueue,
    callback: fn (QueueWorkDoneStatus, FFIPointer[NoneType, mut=True]) -> None,
    user_data: FFIPointer[NoneType, mut=True],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuQueueOnSubmittedWorkDone",
        NoneType,
        type_of(handle),
        type_of(callback),
        type_of(user_data),
    ](handle, callback, user_data)


fn queue_write_buffer(
    handle: WGPUQueue,
    buffer: WGPUBuffer,
    buffer_offset: UInt64,
    data: FFIPointer[NoneType, mut=True],
    size: Int,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuQueueWriteBuffer",
        NoneType,
        type_of(handle),
        type_of(buffer),
        type_of(buffer_offset),
        type_of(data),
        type_of(size),
    ](handle, buffer, buffer_offset, data, size)


fn queue_write_texture(
    handle: WGPUQueue,
    destination: FFIPointer[WGPUImageCopyTexture, mut=True],
    data: FFIPointer[NoneType, mut=True],
    data_size: Int,
    data_layout: FFIPointer[WGPUTextureDataLayout, mut=True],
    write_size: FFIPointer[WGPUExtent3D, mut=True],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuQueueWriteTexture",
        NoneType,
        type_of(handle),
        type_of(destination),
        type_of(data),
        type_of(data_size),
        type_of(data_layout),
        type_of(write_size),
    ](handle, destination, data, data_size, data_layout, write_size)


fn queue_set_label(
    handle: WGPUQueue, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuQueueSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _RenderBundleImpl:
    pass


comptime WGPURenderBundle = FFIPointer[_RenderBundleImpl, mut=True]


fn render_bundle_release(handle: WGPURenderBundle):
    _ = external_call["wgpuRenderBundleRelease", NoneType, type_of(handle)](
        handle
    )


fn render_bundle_set_label(
    handle: WGPURenderBundle, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _RenderBundleEncoderImpl:
    pass


comptime WGPURenderBundleEncoder = FFIPointer[
    _RenderBundleEncoderImpl, mut=True
]


fn render_bundle_encoder_release(handle: WGPURenderBundleEncoder):
    _ = external_call[
        "wgpuRenderBundleEncoderRelease", NoneType, type_of(handle)
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
        type_of(handle),
        type_of(pipeline),
    ](handle, pipeline)


fn render_bundle_encoder_set_bind_group(
    handle: WGPURenderBundleEncoder,
    group_index: UInt32,
    dynamic_offset_count: Int,
    dynamic_offsets: FFIPointer[UInt32, mut=False],
    group: WGPUBindGroup = {},
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderSetBindGroup",
        NoneType,
        type_of(handle),
        type_of(group_index),
        type_of(group),
        type_of(dynamic_offset_count),
        type_of(dynamic_offsets),
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
        type_of(handle),
        type_of(vertex_count),
        type_of(instance_count),
        type_of(first_vertex),
        type_of(first_instance),
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
        type_of(handle),
        type_of(index_count),
        type_of(instance_count),
        type_of(first_index),
        type_of(base_vertex),
        type_of(first_instance),
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
        type_of(handle),
        type_of(indirect_buffer),
        type_of(indirect_offset),
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
        type_of(handle),
        type_of(indirect_buffer),
        type_of(indirect_offset),
    ](handle, indirect_buffer, indirect_offset)


fn render_bundle_encoder_insert_debug_marker(
    handle: WGPURenderBundleEncoder, marker_label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderInsertDebugMarker",
        NoneType,
        type_of(handle),
        type_of(marker_label),
    ](handle, marker_label)


fn render_bundle_encoder_pop_debug_group(
    handle: WGPURenderBundleEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderPopDebugGroup", NoneType, type_of(handle)
    ](handle)


fn render_bundle_encoder_push_debug_group(
    handle: WGPURenderBundleEncoder, group_label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderPushDebugGroup",
        NoneType,
        type_of(handle),
        type_of(group_label),
    ](handle, group_label)


fn render_bundle_encoder_set_vertex_buffer(
    handle: WGPURenderBundleEncoder,
    slot: UInt32,
    offset: UInt64,
    size: UInt64,
    buffer: WGPUBuffer = {},
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderSetVertexBuffer",
        NoneType,
        type_of(handle),
        type_of(slot),
        type_of(buffer),
        type_of(offset),
        type_of(size),
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
        type_of(handle),
        type_of(buffer),
        type_of(format),
        type_of(offset),
        type_of(size),
    ](handle, buffer, format, offset, size)


fn render_bundle_encoder_finish(
    handle: WGPURenderBundleEncoder,
    descriptor: FFIPointer[WGPURenderBundleDescriptor, mut=True] = {},
) -> WGPURenderBundle:
    """
    TODO
    """
    return external_call[
        "wgpuRenderBundleEncoderFinish",
        WGPURenderBundle,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn render_bundle_encoder_set_label(
    handle: WGPURenderBundleEncoder, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderBundleEncoderSetLabel",
        NoneType,
        type_of(handle),
        type_of(label),
    ](handle, label)


struct _RenderPassEncoderImpl:
    pass


comptime WGPURenderPassEncoder = FFIPointer[_RenderPassEncoderImpl, mut=True]


fn render_pass_encoder_release(handle: WGPURenderPassEncoder):
    _ = external_call[
        "wgpuRenderPassEncoderRelease", NoneType, type_of(handle)
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
        type_of(handle),
        type_of(pipeline),
    ](handle, pipeline)


fn render_pass_encoder_set_bind_group(
    handle: WGPURenderPassEncoder,
    group_index: UInt32,
    dynamic_offset_count: Int,
    dynamic_offsets: FFIPointer[UInt32, mut=False],
    group: WGPUBindGroup = {},
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderSetBindGroup",
        NoneType,
        type_of(handle),
        type_of(group_index),
        type_of(group),
        type_of(dynamic_offset_count),
        type_of(dynamic_offsets),
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
        type_of(handle),
        type_of(vertex_count),
        type_of(instance_count),
        type_of(first_vertex),
        type_of(first_instance),
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
        type_of(handle),
        type_of(index_count),
        type_of(instance_count),
        type_of(first_index),
        type_of(base_vertex),
        type_of(first_instance),
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
        type_of(handle),
        type_of(indirect_buffer),
        type_of(indirect_offset),
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
        type_of(handle),
        type_of(indirect_buffer),
        type_of(indirect_offset),
    ](handle, indirect_buffer, indirect_offset)


fn render_pass_encoder_execute_bundles(
    handle: WGPURenderPassEncoder,
    bundle_count: Int,
    bundles: FFIPointer[WGPURenderBundle, mut=False],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderExecuteBundles",
        NoneType,
        type_of(handle),
        type_of(bundle_count),
        type_of(bundles),
    ](handle, bundle_count, bundles)


fn render_pass_encoder_insert_debug_marker(
    handle: WGPURenderPassEncoder, marker_label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderInsertDebugMarker",
        NoneType,
        type_of(handle),
        type_of(marker_label),
    ](handle, marker_label)


fn render_pass_encoder_pop_debug_group(
    handle: WGPURenderPassEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderPopDebugGroup", NoneType, type_of(handle)
    ](handle)


fn render_pass_encoder_push_debug_group(
    handle: WGPURenderPassEncoder, group_label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderPushDebugGroup",
        NoneType,
        type_of(handle),
        type_of(group_label),
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
        type_of(handle),
        type_of(reference),
    ](handle, reference)


fn render_pass_encoder_set_blend_constant(
    handle: WGPURenderPassEncoder, color: FFIPointer[WGPUColor, mut=True]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderSetBlendConstant",
        NoneType,
        type_of(handle),
        type_of(color),
    ](handle, color)


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
        type_of(handle),
        type_of(x),
        type_of(y),
        type_of(width),
        type_of(height),
        type_of(min_depth),
        type_of(max_depth),
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
        type_of(handle),
        type_of(x),
        type_of(y),
        type_of(width),
        type_of(height),
    ](handle, x, y, width, height)


fn render_pass_encoder_set_vertex_buffer(
    handle: WGPURenderPassEncoder,
    slot: UInt32,
    offset: UInt64,
    size: UInt64,
    buffer: WGPUBuffer = {},
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderSetVertexBuffer",
        NoneType,
        type_of(handle),
        type_of(slot),
        type_of(buffer),
        type_of(offset),
        type_of(size),
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
        type_of(handle),
        type_of(buffer),
        type_of(format),
        type_of(offset),
        type_of(size),
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
        type_of(handle),
        type_of(query_index),
    ](handle, query_index)


fn render_pass_encoder_end_occlusion_query(
    handle: WGPURenderPassEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderEndOcclusionQuery", NoneType, type_of(handle)
    ](handle)


fn render_pass_encoder_end(
    handle: WGPURenderPassEncoder,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuRenderPassEncoderEnd", NoneType, type_of(handle)](
        handle
    )


fn render_pass_encoder_set_label(
    handle: WGPURenderPassEncoder, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPassEncoderSetLabel",
        NoneType,
        type_of(handle),
        type_of(label),
    ](handle, label)


struct _RenderPipelineImpl:
    pass


comptime WGPURenderPipeline = FFIPointer[_RenderPipelineImpl, mut=True]


fn render_pipeline_release(handle: WGPURenderPipeline):
    _ = external_call["wgpuRenderPipelineRelease", NoneType, type_of(handle)](
        handle
    )


fn render_pipeline_get_bind_group_layout(
    handle: WGPURenderPipeline, group_index: UInt32
) -> WGPUBindGroupLayout:
    """
    TODO
    """
    return external_call[
        "wgpuRenderPipelineGetBindGroupLayout",
        WGPUBindGroupLayout,
        type_of(handle),
        type_of(group_index),
    ](handle, group_index)


fn render_pipeline_set_label(
    handle: WGPURenderPipeline, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuRenderPipelineSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _SamplerImpl:
    pass


comptime WGPUSampler = FFIPointer[_SamplerImpl, mut=True]


fn sampler_release(handle: WGPUSampler):
    _ = external_call["wgpuSamplerRelease", NoneType, type_of(handle)](handle)


fn sampler_set_label(
    handle: WGPUSampler, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuSamplerSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _ShaderModuleImpl:
    pass


comptime WGPUShaderModule = FFIPointer[_ShaderModuleImpl, mut=True]


fn shader_module_release(handle: WGPUShaderModule):
    _ = external_call["wgpuShaderModuleRelease", NoneType, type_of(handle)](
        handle
    )


fn shader_module_get_compilation_info(
    handle: WGPUShaderModule,
    callback: fn (
        CompilationInfoRequestStatus,
        FFIPointer[WGPUCompilationInfo, mut=True],
        FFIPointer[NoneType, mut=True],
    ) -> None,
    user_data: FFIPointer[NoneType, mut=True],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuShaderModuleGetCompilationInfo",
        NoneType,
        type_of(handle),
        type_of(callback),
        type_of(user_data),
    ](handle, callback, user_data)


fn shader_module_set_label(
    handle: WGPUShaderModule, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuShaderModuleSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _SurfaceImpl:
    pass


comptime WGPUSurface = FFIPointer[_SurfaceImpl, mut=True]


fn surface_release(handle: WGPUSurface):
    _ = external_call["wgpuSurfaceRelease", NoneType, type_of(handle)](handle)


fn surface_configure(
    handle: WGPUSurface, config: FFIPointer[WGPUSurfaceConfiguration, mut=True]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuSurfaceConfigure", NoneType, type_of(handle), type_of(config)
    ](handle, config)


fn surface_get_capabilities(
    handle: WGPUSurface,
    adapter: WGPUAdapter,
    capabilities: FFIPointer[WGPUSurfaceCapabilities, mut=True],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuSurfaceGetCapabilities",
        NoneType,
        type_of(handle),
        type_of(adapter),
        type_of(capabilities),
    ](handle, adapter, capabilities)


fn surface_get_current_texture(
    handle: WGPUSurface,
    surface_texture: FFIPointer[WGPUSurfaceTexture, mut=True],
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuSurfaceGetCurrentTexture",
        NoneType,
        type_of(handle),
        type_of(surface_texture),
    ](handle, surface_texture)


fn surface_present(
    handle: WGPUSurface,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuSurfacePresent", NoneType, type_of(handle)](handle)


fn surface_unconfigure(
    handle: WGPUSurface,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuSurfaceUnconfigure", NoneType, type_of(handle)](
        handle
    )


fn surface_set_label(
    handle: WGPUSurface, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuSurfaceSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct _TextureImpl:
    pass


comptime WGPUTexture = FFIPointer[_TextureImpl, mut=True]


fn texture_release(handle: WGPUTexture):
    _ = external_call["wgpuTextureRelease", NoneType, type_of(handle)](handle)


fn texture_create_view(
    handle: WGPUTexture,
    descriptor: FFIPointer[WGPUTextureViewDescriptor, mut=True] = {},
) -> WGPUTextureView:
    """
    TODO
    """
    return external_call[
        "wgpuTextureCreateView",
        WGPUTextureView,
        type_of(handle),
        type_of(descriptor),
    ](handle, descriptor)


fn texture_set_label(
    handle: WGPUTexture, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuTextureSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


fn texture_get_width(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return external_call["wgpuTextureGetWidth", UInt32, type_of(handle)](handle)


fn texture_get_height(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return external_call["wgpuTextureGetHeight", UInt32, type_of(handle)](
        handle
    )


fn texture_get_depth_or_array_layers(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return external_call[
        "wgpuTextureGetDepthOrArrayLayers", UInt32, type_of(handle)
    ](handle)


fn texture_get_mip_level_count(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return external_call[
        "wgpuTextureGetMipLevelCount", UInt32, type_of(handle)
    ](handle)


fn texture_get_sample_count(
    handle: WGPUTexture,
) -> UInt32:
    """
    TODO
    """
    return external_call["wgpuTextureGetSampleCount", UInt32, type_of(handle)](
        handle
    )


fn texture_get_dimension(
    handle: WGPUTexture,
) -> TextureDimension:
    """
    TODO
    """
    return external_call[
        "wgpuTextureGetDimension", TextureDimension, type_of(handle)
    ](handle)


fn texture_get_format(
    handle: WGPUTexture,
) -> TextureFormat:
    """
    TODO
    """
    return external_call[
        "wgpuTextureGetFormat", TextureFormat, type_of(handle)
    ](handle)


fn texture_get_usage(
    handle: WGPUTexture,
) -> TextureUsage:
    """
    TODO
    """
    return external_call["wgpuTextureGetUsage", TextureUsage, type_of(handle)](
        handle
    )


fn texture_destroy(
    handle: WGPUTexture,
) -> None:
    """
    TODO
    """
    _ = external_call["wgpuTextureDestroy", NoneType, type_of(handle)](handle)


struct _TextureViewImpl:
    pass


comptime WGPUTextureView = FFIPointer[_TextureViewImpl, mut=True]


fn texture_view_release(handle: WGPUTextureView):
    _ = external_call["wgpuTextureViewRelease", NoneType, type_of(handle)](
        handle
    )


fn texture_view_set_label(
    handle: WGPUTextureView, label: FFIPointer[Int8, mut=False]
) -> None:
    """
    TODO
    """
    _ = external_call[
        "wgpuTextureViewSetLabel", NoneType, type_of(handle), type_of(label)
    ](handle, label)


struct WGPURequestAdapterOptions(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var compatible_surface: WGPUSurface
    var power_preference: PowerPreference
    var backend_type: BackendType
    var force_fallback_adapter: Bool

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStructOut, mut=True]
    var vendor: FFIPointer[Int8, mut=False]
    var architecture: FFIPointer[Int8, mut=False]
    var device: FFIPointer[Int8, mut=False]
    var description: FFIPointer[Int8, mut=False]
    var backend_type: BackendType
    var adapter_type: AdapterType
    var vendor_ID: UInt32
    var device_ID: UInt32

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStructOut, mut=True] = {},
        vendor: FFIPointer[Int8, mut=False] = {},
        architecture: FFIPointer[Int8, mut=False] = {},
        device: FFIPointer[Int8, mut=False] = {},
        description: FFIPointer[Int8, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var required_feature_count: Int
    var required_features: FFIPointer[FeatureName, mut=False]
    var required_limits: FFIPointer[WGPURequiredLimits, mut=True]
    var default_queue: WGPUQueueDescriptor
    var device_lost_callback: FFIPointer[NoneType, mut=True]
    var device_lost_userdata: FFIPointer[NoneType, mut=True]
    var uncaptured_error_callback_info: FFIPointer[NoneType, mut=True]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
        required_feature_count: Int = Int(),
        required_features: FFIPointer[FeatureName, mut=False] = {},
        required_limits: FFIPointer[WGPURequiredLimits, mut=True] = {},
        var default_queue: WGPUQueueDescriptor = {},
        device_lost_callback: FFIPointer[NoneType, mut=True] = {},
        device_lost_userdata: FFIPointer[NoneType, mut=True] = {},
        uncaptured_error_callback_info: FFIPointer[NoneType, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var binding: UInt32
    var buffer: WGPUBuffer
    var offset: UInt64
    var size: UInt64
    var sampler: WGPUSampler
    var texture_view: WGPUTextureView

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var layout: WGPUBindGroupLayout
    var entrie_count: Int
    var entries: FFIPointer[WGPUBindGroupEntry, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
        layout: WGPUBindGroupLayout = {},
        entrie_count: Int = Int(),
        entries: FFIPointer[WGPUBindGroupEntry, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var type: BufferBindingType
    var has_dynamic_offset: Bool
    var min_binding_size: UInt64

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var type: SamplerBindingType

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        type: SamplerBindingType = SamplerBindingType(0),
    ):
        self.next_in_chain = next_in_chain
        self.type = type


struct WGPUTextureBindingLayout(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var sample_type: TextureSampleType
    var view_dimension: TextureViewDimension
    var multisampled: Bool

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStructOut, mut=True]
    var usages: TextureUsage
    var format_count: Int
    var formats: FFIPointer[TextureFormat, mut=False]
    var present_mode_count: Int
    var present_modes: FFIPointer[PresentMode, mut=False]
    var alpha_mode_count: Int
    var alpha_modes: FFIPointer[CompositeAlphaMode, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStructOut, mut=True] = {},
        usages: TextureUsage = TextureUsage(0),
        format_count: Int = Int(),
        formats: FFIPointer[TextureFormat, mut=False] = {},
        present_mode_count: Int = Int(),
        present_modes: FFIPointer[PresentMode, mut=False] = {},
        alpha_mode_count: Int = Int(),
        alpha_modes: FFIPointer[CompositeAlphaMode, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var device: WGPUDevice
    var format: TextureFormat
    var usage: TextureUsage
    var view_format_count: Int
    var view_formats: FFIPointer[TextureFormat, mut=False]
    var alpha_mode: CompositeAlphaMode
    var width: UInt32
    var height: UInt32
    var present_mode: PresentMode

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        device: WGPUDevice = {},
        format: TextureFormat = TextureFormat(0),
        usage: TextureUsage = TextureUsage(0),
        view_format_count: Int = Int(),
        view_formats: FFIPointer[TextureFormat, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var access: StorageTextureAccess
    var format: TextureFormat
    var view_dimension: TextureViewDimension

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var binding: UInt32
    var visibility: ShaderStage
    var buffer: WGPUBufferBindingLayout
    var sampler: WGPUSamplerBindingLayout
    var texture: WGPUTextureBindingLayout
    var storage_texture: WGPUStorageTextureBindingLayout

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var entrie_count: Int
    var entries: FFIPointer[WGPUBindGroupLayoutEntry, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
        entrie_count: Int = Int(),
        entries: FFIPointer[WGPUBindGroupLayoutEntry, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var usage: BufferUsage
    var size: UInt64
    var mapped_at_creation: Bool

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var key: FFIPointer[Int8, mut=False]
    var value: Float64

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        key: FFIPointer[Int8, mut=False] = {},
        value: Float64 = {},
    ):
        self.next_in_chain = next_in_chain
        self.key = key
        self.value = value


struct WGPUCommandBufferDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label


struct WGPUCommandEncoderDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label


struct WGPUCompilationInfo(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var message_count: Int
    var messages: FFIPointer[WGPUCompilationMessage, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        message_count: Int = Int(),
        messages: FFIPointer[WGPUCompilationMessage, mut=False] = {},
    ):
        self.next_in_chain = next_in_chain
        self.message_count = message_count
        self.messages = messages


struct WGPUCompilationMessage(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var message: FFIPointer[Int8, mut=False]
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
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        message: FFIPointer[Int8, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var timestamp_writes: FFIPointer[WGPUComputePassTimestampWrites, mut=True]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
        timestamp_writes: FFIPointer[
            WGPUComputePassTimestampWrites, mut=True
        ] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var layout: WGPUPipelineLayout
    var compute: WGPUProgrammableStageDescriptor

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var limits: WGPULimits

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        var limits: WGPULimits = {},
    ):
        self.next_in_chain = next_in_chain
        self.limits = limits^


struct WGPUSupportedLimits(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: FFIPointer[ChainedStructOut, mut=True]
    var limits: WGPULimits

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStructOut, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var layout: WGPUTextureDataLayout
    var buffer: WGPUBuffer

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var texture: WGPUTexture
    var mip_level: UInt32
    var origin: WGPUOrigin3D
    var aspect: TextureAspect

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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
    var attributes: FFIPointer[WGPUVertexAttribute, mut=False]

    fn __init__(
        out self,
        array_stride: UInt64 = {},
        step_mode: VertexStepMode = VertexStepMode(0),
        attribute_count: Int = Int(),
        attributes: FFIPointer[WGPUVertexAttribute, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var bind_group_layout_count: Int
    var bind_group_layouts: FFIPointer[WGPUBindGroupLayout, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
        bind_group_layout_count: Int = Int(),
        bind_group_layouts: FFIPointer[WGPUBindGroupLayout, mut=False] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.bind_group_layout_count = bind_group_layout_count
        self.bind_group_layouts = bind_group_layouts


struct WGPUProgrammableStageDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var module: WGPUShaderModule
    var entry_point: FFIPointer[Int8, mut=False]
    var constant_count: Int
    var constants: FFIPointer[WGPUConstantEntry, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        module: WGPUShaderModule = {},
        entry_point: FFIPointer[Int8, mut=False] = {},
        constant_count: Int = Int(),
        constants: FFIPointer[WGPUConstantEntry, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var type: QueryType
    var count: UInt32

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label


struct WGPURenderBundleDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label


struct WGPURenderBundleEncoderDescriptor(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var color_format_count: Int
    var color_formats: FFIPointer[TextureFormat, mut=False]
    var depth_stencil_format: TextureFormat
    var sample_count: UInt32
    var depth_read_only: Bool
    var stencil_read_only: Bool

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
        color_format_count: Int = Int(),
        color_formats: FFIPointer[TextureFormat, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var view: WGPUTextureView
    var depth_slice: UInt32
    var resolve_target: WGPUTextureView
    var load_op: LoadOp
    var store_op: StoreOp
    var clear_value: WGPUColor

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var color_attachment_count: Int
    var color_attachments: FFIPointer[WGPURenderPassColorAttachment, mut=False]
    var depth_stencil_attachment: FFIPointer[
        WGPURenderPassDepthStencilAttachment, mut=True
    ]
    var occlusion_query_set: WGPUQuerySet
    var timestamp_writes: FFIPointer[WGPURenderPassTimestampWrites, mut=True]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
        color_attachment_count: Int = Int(),
        color_attachments: FFIPointer[
            WGPURenderPassColorAttachment, mut=False
        ] = {},
        depth_stencil_attachment: FFIPointer[
            WGPURenderPassDepthStencilAttachment, mut=True
        ] = {},
        occlusion_query_set: WGPUQuerySet = {},
        timestamp_writes: FFIPointer[
            WGPURenderPassTimestampWrites, mut=True
        ] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var module: WGPUShaderModule
    var entry_point: FFIPointer[Int8, mut=False]
    var constant_count: Int
    var constants: FFIPointer[WGPUConstantEntry, mut=False]
    var buffer_count: Int
    var buffers: FFIPointer[WGPUVertexBufferLayout, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        module: WGPUShaderModule = {},
        entry_point: FFIPointer[Int8, mut=False] = {},
        constant_count: Int = Int(),
        constants: FFIPointer[WGPUConstantEntry, mut=False] = {},
        buffer_count: Int = Int(),
        buffers: FFIPointer[WGPUVertexBufferLayout, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var topology: PrimitiveTopology
    var strip_index_format: IndexFormat
    var front_face: FrontFace
    var cull_mode: CullMode

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
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
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var count: UInt32
    var mask: UInt32
    var alpha_to_coverage_enabled: Bool

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var module: WGPUShaderModule
    var entry_point: FFIPointer[Int8, mut=False]
    var constant_count: Int
    var constants: FFIPointer[WGPUConstantEntry, mut=False]
    var target_count: Int
    var targets: FFIPointer[WGPUColorTargetState, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        module: WGPUShaderModule = {},
        entry_point: FFIPointer[Int8, mut=False] = {},
        constant_count: Int = Int(),
        constants: FFIPointer[WGPUConstantEntry, mut=False] = {},
        target_count: Int = Int(),
        targets: FFIPointer[WGPUColorTargetState, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var format: TextureFormat
    var blend: FFIPointer[WGPUBlendState, mut=True]
    var write_mask: ColorWriteMask

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        format: TextureFormat = TextureFormat(0),
        blend: FFIPointer[WGPUBlendState, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var layout: WGPUPipelineLayout
    var vertex: WGPUVertexState
    var primitive: WGPUPrimitiveState
    var depth_stencil: FFIPointer[WGPUDepthStencilState, mut=True]
    var multisample: WGPUMultisampleState
    var fragment: FFIPointer[WGPUFragmentState, mut=True]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
        layout: WGPUPipelineLayout = {},
        var vertex: WGPUVertexState = {},
        var primitive: WGPUPrimitiveState = {},
        depth_stencil: FFIPointer[WGPUDepthStencilState, mut=True] = {},
        var multisample: WGPUMultisampleState = {},
        fragment: FFIPointer[WGPUFragmentState, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
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
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var hint_count: Int
    var hints: FFIPointer[WGPUShaderModuleCompilationHint, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
        hint_count: Int = Int(),
        hints: FFIPointer[WGPUShaderModuleCompilationHint, mut=False] = {},
    ):
        self.next_in_chain = next_in_chain
        self.label = label
        self.hint_count = hint_count
        self.hints = hints


struct WGPUShaderModuleCompilationHint(Copyable, ImplicitlyCopyable, Movable):
    """
    TODO
    """

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var entry_point: FFIPointer[Int8, mut=False]
    var layout: WGPUPipelineLayout

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        entry_point: FFIPointer[Int8, mut=False] = {},
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
    var code: FFIPointer[Int8, mut=False]

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        code: FFIPointer[Int8, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
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
    var window: FFIPointer[NoneType, mut=True]

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        window: FFIPointer[NoneType, mut=True] = {},
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
    var selector: FFIPointer[Int8, mut=False]

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        selector: FFIPointer[Int8, mut=False] = {},
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
    var layer: FFIPointer[NoneType, mut=True]

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        layer: FFIPointer[NoneType, mut=True] = {},
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
    var hinstance: FFIPointer[NoneType, mut=True]
    var hwnd: FFIPointer[NoneType, mut=True]

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        hinstance: FFIPointer[NoneType, mut=True] = {},
        hwnd: FFIPointer[NoneType, mut=True] = {},
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
    var connection: FFIPointer[NoneType, mut=True]
    var window: UInt32

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        connection: FFIPointer[NoneType, mut=True] = {},
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
    var display: FFIPointer[NoneType, mut=True]
    var window: UInt64

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        display: FFIPointer[NoneType, mut=True] = {},
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
    var display: FFIPointer[NoneType, mut=True]
    var surface: FFIPointer[NoneType, mut=True]

    fn __init__(
        out self,
        chain: ChainedStruct = {},
        display: FFIPointer[NoneType, mut=True] = {},
        surface: FFIPointer[NoneType, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var offset: UInt64
    var bytes_per_row: UInt32
    var rows_per_image: UInt32

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var usage: TextureUsage
    var dimension: TextureDimension
    var size: WGPUExtent3D
    var format: TextureFormat
    var mip_level_count: UInt32
    var sample_count: UInt32
    var view_format_count: Int
    var view_formats: FFIPointer[TextureFormat, mut=False]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
        usage: TextureUsage = TextureUsage(0),
        dimension: TextureDimension = TextureDimension(0),
        var size: WGPUExtent3D = {},
        format: TextureFormat = TextureFormat(0),
        mip_level_count: UInt32 = {},
        sample_count: UInt32 = {},
        view_format_count: Int = Int(),
        view_formats: FFIPointer[TextureFormat, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var label: FFIPointer[Int8, mut=False]
    var format: TextureFormat
    var dimension: TextureViewDimension
    var base_mip_level: UInt32
    var mip_level_count: UInt32
    var base_array_layer: UInt32
    var array_layer_count: UInt32
    var aspect: TextureAspect

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        label: FFIPointer[Int8, mut=False] = {},
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

    var next_in_chain: FFIPointer[ChainedStruct, mut=True]
    var callback: FFIPointer[NoneType, mut=True]
    var userdata: FFIPointer[NoneType, mut=True]

    fn __init__(
        out self,
        next_in_chain: FFIPointer[ChainedStruct, mut=True] = {},
        callback: FFIPointer[NoneType, mut=True] = {},
        userdata: FFIPointer[NoneType, mut=True] = {},
    ):
        self.next_in_chain = next_in_chain
        self.callback = callback
        self.userdata = userdata


fn create_instance(
    descriptor: FFIPointer[WGPUInstanceDescriptor, mut=True] = {}
) -> WGPUInstance:
    """
    TODO
    """
    return external_call[
        "wgpuCreateInstance", WGPUInstance, type_of(descriptor)
    ](descriptor)


comptime DeviceLostCallback = fn (
    DeviceLostReason,
    FFIPointer[Int8, mut=False],
    FFIPointer[NoneType, mut=True],
    FFIPointer[NoneType, mut=True],
) -> None

comptime ErrorCallback = fn (
    ErrorType,
    FFIPointer[Int8, mut=False],
    FFIPointer[NoneType, mut=True],
    FFIPointer[NoneType, mut=True],
) -> None


# WGPU SPECIFIC DEFS


struct WGPUInstanceExtras(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var backends: InstanceBackend
    var flags: InstanceFlag
    var dx12_shader_compiler: Dx12Compiler
    var gl_es_3_minor_version: Gles3MinorVersion
    var dxil_path: FFIPointer[Int8, mut=False]
    var dxc_path: FFIPointer[Int8, mut=False]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        backends: InstanceBackend = InstanceBackend.all,
        flags: InstanceFlag = InstanceFlag.default,
        dx12_shader_compiler: Dx12Compiler = Dx12Compiler.undefined,
        gl_es_3_minor_version: Gles3MinorVersion = Gles3MinorVersion.automatic,
        dxil_path: FFIPointer[Int8, mut=False] = {},
        dxc_path: FFIPointer[Int8, mut=False] = {},
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
    var trace_path: FFIPointer[Int8, mut=False]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        trace_path: FFIPointer[Int8, mut=False] = {},
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
    var push_constant_ranges: FFIPointer[WGPUPushConstantRange, mut=True]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        push_constant_range_count: Int = 0,
        push_constant_ranges: FFIPointer[WGPUPushConstantRange, mut=True] = {},
    ):
        self.chain = chain
        self.push_constant_range_count = push_constant_range_count
        self.push_constant_ranges = push_constant_ranges


comptime WGPUSubmissionIndex = UInt64


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
    var name: FFIPointer[Int8, mut=False]
    var value: FFIPointer[Int8, mut=False]

    fn __init__(
        out self,
        name: FFIPointer[Int8, mut=False] = {},
        value: FFIPointer[Int8, mut=False] = {},
    ):
        self.name = name
        self.value = value


struct WGPUShaderModuleGLSLDescriptor(Copyable, ImplicitlyCopyable, Movable):
    var chain: ChainedStruct
    var stage: ShaderStage
    var code: FFIPointer[Int8, mut=False]
    var define_count: UInt32
    var defines: FFIPointer[WGPUShaderDefine, mut=True]

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        stage: ShaderStage = ShaderStage.none,
        code: FFIPointer[Int8, mut=False] = {},
        define_count: UInt32 = 0,
        defines: FFIPointer[WGPUShaderDefine, mut=True] = {},
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
    var buffers: FFIPointer[WGPUBuffer, mut=True]
    var buffer_count: Int
    var samplers: FFIPointer[WGPUSampler, mut=True]
    var sampler_count: Int
    var texture_views: FFIPointer[WGPUTextureView, mut=True]
    var texture_view_count: Int

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        buffers: FFIPointer[WGPUBuffer, mut=True] = {},
        buffer_count: Int = 0,
        samplers: FFIPointer[WGPUSampler, mut=True] = {},
        sampler_count: Int = 0,
        texture_views: FFIPointer[WGPUTextureView, mut=True] = {},
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
    var pipeline_statistics: FFIPointer[PipelineStatisticName, mut=True]
    var pipeline_statistics_count: Int

    fn __init__(
        out self,
        chain: ChainedStruct = ChainedStruct(),
        pipeline_statistics: FFIPointer[PipelineStatisticName, mut=True] = {},
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


comptime WGPULogCallback = fn (
    level: LogLevel,
    message: FFIPointer[Int8, mut=True],
    userdata: FFIPointer[NoneType, mut=True],
) -> None


fn generate_report(
    instance: WGPUInstance, report: FFIPointer[WGPUGlobalReport]
):
    external_call[
        "wgpuGenerateReport",
        NoneType,
        WGPUInstance,
        type_of(report),
    ](instance, report)


fn instance_enumerate_adapters(
    instance: WGPUInstance,
    options: FFIPointer[WGPUInstanceEnumerateAdapterOptions],
    adapters: FFIPointer[WGPUAdapter],
) -> Int:
    return external_call[
        "wgpuInstanceEnumerateAdapters",
        Int,
        WGPUInstance,
        type_of(options),
        type_of(adapters),
    ](instance, options, adapters)


fn queue_submit_for_index(
    queue: WGPUQueue,
    command_count: Int,
    commands: FFIPointer[WGPUCommandBuffer],
) -> WGPUSubmissionIndex:
    return external_call[
        "wgpuQueueSubmitForIndex",
        WGPUSubmissionIndex,
        WGPUQueue,
        Int,
        type_of(commands),
    ](queue, command_count, commands)


fn device_poll(
    device: WGPUDevice,
    wait: Bool = False,
    wrapped_submission_index: FFIPointer[WGPUWrappedSubmissionIndex] = {},
) -> Bool:
    """Returns true if the queue is empty, or false if there are more queue submissions still in flight.
    """
    return external_call[
        "wgpuDevicePoll",
        Bool,
        WGPUDevice,
        Bool,
        type_of(wrapped_submission_index),
    ](
        device,
        wait,
        wrapped_submission_index,
    )


fn set_log_callback(
    callback: WGPULogCallback, userdata: FFIPointer[NoneType, mut=True]
):
    _ = external_call[
        "wgpuSetLogCallback",
        NoneType,
        WGPULogCallback,
        type_of(userdata),
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
    data: FFIPointer[NoneType, mut=True],
):
    _ = external_call[
        "wgpuRenderPassEncoderSetPushConstants",
        NoneType,
        WGPURenderPassEncoder,
        ShaderStage,
        UInt32,
        UInt32,
        FFIPointer[NoneType, mut=True],
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
    capabilities: FFIPointer[WGPUSurfaceCapabilities],
):
    external_call[
        "wgpuSurfaceCapabilitiesFreeMembers", NoneType, type_of(capabilities)
    ](capabilities)
