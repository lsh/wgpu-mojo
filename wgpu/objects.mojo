import sys
from memory import Span, UnsafePointer
from collections.string import StringSlice
from memory import ArcPointer

from .bitflags import *
from .constants import *
from .enums import *
from .structs import *

import . _cffi as _c
import .glfw


struct Adapter:
    var _handle: _c.WGPUAdapter

    fn __init__(out self, unsafe_ptr: _c.WGPUAdapter):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUAdapter()

    fn __del__(owned self):
        if self._handle:
            _c.adapter_release(self._handle)

    # fn limits(self) -> Limits:
    #     pass

    # fn adapter_get_limits(handle: WGPUAdapter, limits: WGPUSupportedLimits) -> Bool:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPUAdapter, UnsafePointer[WGPUSupportedLimits]) -> Bool
    #     ]("wgpuAdapterGetLimits")(handle, UnsafePointer.address_of(limits))

    fn has_feature(self, feature: FeatureName) -> Bool:
        """
        TODO
        """
        return _c.adapter_has_feature(self._handle, feature)

    # fn adapter_enumerate_features(
    #     handle: WGPUAdapter, features: FeatureName
    # ) -> UInt:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPUAdapter, FeatureName) -> UInt](
    #         "wgpuAdapterEnumerateFeatures"
    #     )(handle, features)

    # fn adapter_get_info(handle: WGPUAdapter, info: WGPUAdapterInfo) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPUAdapter, UnsafePointer[WGPUAdapterInfo]) -> None
    #     ]("wgpuAdapterGetInfo")(handle, UnsafePointer.address_of(info))

    fn adapter_request_device(
        self,
        label: String = "",
        required_features: List[FeatureName] = List[FeatureName](),
        limits: Limits = Limits(),
        default_queue: QueueDescriptor = QueueDescriptor(),
    ) raises -> Device:
        """
        TODO
        """

        user_data = (_c.WGPUDevice(), False)

        fn _req(
            status: RequestDeviceStatus,
            device: _c.WGPUDevice,
            message: UnsafePointer[Int8],
            user_data: UnsafePointer[NoneType],
        ):
            u_data = user_data.bitcast[Tuple[_c.WGPUDevice, Bool]]()
            u_data[][0] = device
            u_data[][1] = True

        var lim = _c.WGPURequiredLimits(limits=limits)
        _c.adapter_request_device(
            self._handle,
            _req,
            UnsafePointer.address_of(user_data).bitcast[NoneType](),
            # _c.WGPUDeviceDescriptor(
            #     label=label.unsafe_cstr_ptr(),
            #     required_features_count=len(required_features),
            #     required_features=required_features.unsafe_ptr(),
            #     required_limits=UnsafePointer.address_of(lim),
            #     default_queue=_c.WGPUQueueDescriptor(
            #         label=default_queue.label.unsafe_cstr_ptr(),
            # #     ),
            # ),
        )
        _ = lim^
        device = user_data[0]
        debug_assert(user_data[1], "Expected device callback to be done")

        _ = user_data^
        if not device:
            raise Error("failed to get device.")
        return Device(device)


struct BindGroup:
    var _handle: _c.WGPUBindGroup

    fn __init__(out self, unsafe_ptr: _c.WGPUBindGroup):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUBindGroup()

    fn __del__(owned self):
        if self._handle:
            _c.bind_group_release(self._handle)

    fn set_label(self, label: StringSlice):
        _c.bind_group_set_label(
            self._handle, label.unsafe_ptr().bitcast[Int8]()
        )


struct BindGroupLayout:
    var _handle: _c.WGPUBindGroupLayout

    fn __init__(out self, unsafe_ptr: _c.WGPUBindGroupLayout):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUBindGroupLayout()

    fn __del__(owned self):
        if self._handle:
            _c.bind_group_layout_release(self._handle)

    fn set_label(self, label: StringSlice):
        """
        TODO
        """
        _c.bind_group_layout_set_label(
            self._handle, label.unsafe_ptr().bitcast[Int8]()
        )


struct Buffer:
    var _handle: _c.WGPUBuffer

    fn __init__(out self, unsafe_ptr: _c.WGPUBuffer):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUBuffer()

    fn __del__(owned self):
        if self._handle:
            _c.buffer_release(self._handle)

    # fn buffer_map_async(
    #     handle: WGPUBuffer,
    #     mode: MapMode,
    #     offset: UInt,
    #     size: UInt,
    #     callback: fn (BufferMapAsyncStatus, UnsafePointer[NoneType]) -> None,
    #     user_data: UnsafePointer[NoneType],
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (
    #             WGPUBuffer,
    #             MapMode,
    #             UInt,
    #             UInt,
    #             fn (BufferMapAsyncStatus, UnsafePointer[NoneType]) -> None,
    #             UnsafePointer[NoneType],
    #         ) -> None
    #     ]("wgpuBufferMapAsync")(handle, mode, offset, size, callback, user_data)

    fn get_mapped_range(
        self,
        offset: UInt,
        size: UInt
    ) -> UnsafePointer[NoneType]:
        """
        TODO
        """
        return _c.buffer_get_mapped_range(
            self._handle,
            offset,
            size
        )

    # fn buffer_get_const_mapped_range(
    #     handle: WGPUBuffer, offset: UInt, size: UInt
    # ) -> UnsafePointer[NoneType]:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPUBuffer, UInt, UInt) -> UnsafePointer[NoneType]
    #     ]("wgpuBufferGetConstMappedRange")(handle, offset, size)

    fn set_label(self, label: StringSlice):
        """
        TODO
        """
        _c.buffer_set_label(self._handle, label.unsafe_ptr().bitcast[Int8]())

    fn get_usage(self) -> BufferUsage:
        """
        TODO
        """
        return _c.buffer_get_usage(self._handle)

    fn get_size(self) -> UInt64:
        """
        TODO
        """
        return _c.buffer_get_size(self._handle)

    fn get_map_state(self) -> BufferMapState:
        """
        TODO
        """
        return _c.buffer_get_map_state(self._handle)

    fn unmap(self):
        """
        TODO
        """
        _c.buffer_unmap(self._handle)

    fn destroy(self):
        """
        TODO
        """
        _c.buffer_destroy(self._handle)


struct CommandBuffer:
    var _handle: _c.WGPUCommandBuffer

    fn __init__(out self, unsafe_ptr: _c.WGPUCommandBuffer):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUCommandBuffer()

    fn __del__(owned self):
        if self._handle:
            _c.command_buffer_release(self._handle)

    fn set_label(self, label: StringSlice):
        """
        TODO
        """
        _c.command_buffer_set_label(
            self._handle, label.unsafe_ptr().bitcast[Int8]()
        )


struct CommandEncoder:
    var _handle: _c.WGPUCommandEncoder

    fn __init__(out self, unsafe_ptr: _c.WGPUCommandEncoder):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUCommandEncoder()

    fn __del__(owned self):
        if self._handle:
            _c.command_encoder_release(self._handle)

    fn finish(self, label: StringLiteral = "") -> CommandBuffer:
        """
        TODO
        """
        return CommandBuffer(
            _c.command_encoder_finish(
                self._handle,
                _c.WGPUCommandBufferDescriptor(label=label.unsafe_cstr_ptr()),
            )
        )

    # fn command_encoder_begin_compute_pass(
    #     handle: WGPUCommandEncoder,
    #     descriptor: WGPUComputePassDescriptor = WGPUComputePassDescriptor(),
    # ) -> WGPUComputePassEncoder:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (
    #             WGPUCommandEncoder, UnsafePointer[WGPUComputePassDescriptor]
    #         ) -> WGPUComputePassEncoder
    #     ]("wgpuCommandEncoderBeginComputePass")(
    #         handle, UnsafePointer.address_of(descriptor)
    #     )

    fn begin_render_pass(
        self,
        color_attachments: Span[RenderPassColorAttachment],
        depth_stencil_attachment: Optional[
            RenderPassDepthStencilAttachment
        ] = None,
        label: StringLiteral = "",
    ) -> RenderPassEncoder:
        """
        TODO
        """
        attachments = List[_c.WGPURenderPassColorAttachment](
            capacity=len(color_attachments)
        )
        for attachment in color_attachments:
            resolve_target_opt = attachment[].resolve_target
            resolve_target = (
                resolve_target_opt.value()[]._handle if resolve_target_opt else _c.WGPUTextureView()
            )
            attachments.append(
                _c.WGPURenderPassColorAttachment(
                    view=attachment[].view[]._handle,
                    depth_slice=attachment[].depth_slice,
                    resolve_target=resolve_target,
                    load_op=attachment[].load_op,
                    store_op=attachment[].store_op,
                    clear_value=attachment[].clear_value,
                )
            )
        handle = _c.command_encoder_begin_render_pass(
            self._handle,
            _c.WGPURenderPassDescriptor(
                label=label.unsafe_cstr_ptr(),
                color_attachment_count=len(attachments),
                color_attachments=attachments.unsafe_ptr(),
            ),
        )
        _ = attachments
        return RenderPassEncoder(handle)

    fn copy_buffer_to_buffer(
        self,
        source: Buffer,
        source_offset: UInt64,
        destination: Buffer,
        destination_offset: UInt64,
        size: UInt64,
    ):
        """
        TODO
        """
        _c.command_encoder_copy_buffer_to_buffer(
            self._handle,
            source._handle,
            source_offset,
            destination._handle,
            destination_offset,
            size,
        )


# fn command_encoder_copy_buffer_to_texture(
#     handle: WGPUCommandEncoder,
#     source: WGPUImageCopyBuffer,
#     destination: WGPUImageCopyTexture,
#     copy_size: WGPUExtent3D,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPUCommandEncoder,
#             UnsafePointer[WGPUImageCopyBuffer],
#             UnsafePointer[WGPUImageCopyTexture],
#             UnsafePointer[WGPUExtent3D],
#         ) -> None
#     ]("wgpuCommandEncoderCopyBufferToTexture")(
#         handle,
#         UnsafePointer.address_of(source),
#         UnsafePointer.address_of(destination),
#         UnsafePointer.address_of(copy_size),
#     )


# fn command_encoder_copy_texture_to_buffer(
#     handle: WGPUCommandEncoder,
#     source: WGPUImageCopyTexture,
#     destination: WGPUImageCopyBuffer,
#     copy_size: WGPUExtent3D,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPUCommandEncoder,
#             UnsafePointer[WGPUImageCopyTexture],
#             UnsafePointer[WGPUImageCopyBuffer],
#             UnsafePointer[WGPUExtent3D],
#         ) -> None
#     ]("wgpuCommandEncoderCopyTextureToBuffer")(
#         handle,
#         UnsafePointer.address_of(source),
#         UnsafePointer.address_of(destination),
#         UnsafePointer.address_of(copy_size),
#     )


# fn command_encoder_copy_texture_to_texture(
#     handle: WGPUCommandEncoder,
#     source: WGPUImageCopyTexture,
#     destination: WGPUImageCopyTexture,
#     copy_size: WGPUExtent3D,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPUCommandEncoder,
#             UnsafePointer[WGPUImageCopyTexture],
#             UnsafePointer[WGPUImageCopyTexture],
#             UnsafePointer[WGPUExtent3D],
#         ) -> None
#     ]("wgpuCommandEncoderCopyTextureToTexture")(
#         handle,
#         UnsafePointer.address_of(source),
#         UnsafePointer.address_of(destination),
#         UnsafePointer.address_of(copy_size),
#     )


# fn command_encoder_clear_buffer(
#     handle: WGPUCommandEncoder, buffer: WGPUBuffer, offset: UInt64, size: UInt64
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUCommandEncoder, WGPUBuffer, UInt64, UInt64) -> None
#     ]("wgpuCommandEncoderClearBuffer")(handle, buffer, offset, size)


# fn command_encoder_insert_debug_marker(
#     handle: WGPUCommandEncoder, marker_label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUCommandEncoder, UnsafePointer[Int8]) -> None
#     ]("wgpuCommandEncoderInsertDebugMarker")(handle, marker_label)


# fn command_encoder_pop_debug_group(
#     handle: WGPUCommandEncoder,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUCommandEncoder,) -> None](
#         "wgpuCommandEncoderPopDebugGroup"
#     )(
#         handle,
#     )


# fn command_encoder_push_debug_group(
#     handle: WGPUCommandEncoder, group_label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUCommandEncoder, UnsafePointer[Int8]) -> None
#     ]("wgpuCommandEncoderPushDebugGroup")(handle, group_label)


# fn command_encoder_resolve_query_set(
#     handle: WGPUCommandEncoder,
#     query_set: WGPUQuerySet,
#     first_query: UInt32,
#     query_count: UInt32,
#     destination: WGPUBuffer,
#     destination_offset: UInt64,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPUCommandEncoder, WGPUQuerySet, UInt32, UInt32, WGPUBuffer, UInt64
#         ) -> None
#     ]("wgpuCommandEncoderResolveQuerySet")(
#         handle,
#         query_set,
#         first_query,
#         query_count,
#         destination,
#         destination_offset,
#     )


# fn command_encoder_write_timestamp(
#     handle: WGPUCommandEncoder, query_set: WGPUQuerySet, query_index: UInt32
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUCommandEncoder, WGPUQuerySet, UInt32) -> None
#     ]("wgpuCommandEncoderWriteTimestamp")(handle, query_set, query_index)


# fn command_encoder_set_label(
#     handle: WGPUCommandEncoder, label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUCommandEncoder, UnsafePointer[Int8]) -> None
#     ]("wgpuCommandEncoderSetLabel")(handle, label)


# struct _ComputePassEncoderImpl:
#     pass


# alias WGPUComputePassEncoder = UnsafePointer[_ComputePassEncoderImpl]


# fn compute_pass_encoder_release(handle: WGPUComputePassEncoder):
#     _wgpu.get_function[fn (UnsafePointer[_ComputePassEncoderImpl]) -> None](
#         "wgpuComputePassEncoderRelease"
#     )(handle)


# fn compute_pass_encoder_insert_debug_marker(
#     handle: WGPUComputePassEncoder, marker_label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUComputePassEncoder, UnsafePointer[Int8]) -> None
#     ]("wgpuComputePassEncoderInsertDebugMarker")(handle, marker_label)


# fn compute_pass_encoder_pop_debug_group(
#     handle: WGPUComputePassEncoder,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUComputePassEncoder,) -> None](
#         "wgpuComputePassEncoderPopDebugGroup"
#     )(
#         handle,
#     )


# fn compute_pass_encoder_push_debug_group(
#     handle: WGPUComputePassEncoder, group_label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUComputePassEncoder, UnsafePointer[Int8]) -> None
#     ]("wgpuComputePassEncoderPushDebugGroup")(handle, group_label)


# fn compute_pass_encoder_set_pipeline(
#     handle: WGPUComputePassEncoder, pipeline: WGPUComputePipeline
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUComputePassEncoder, WGPUComputePipeline) -> None
#     ]("wgpuComputePassEncoderSetPipeline")(handle, pipeline)


# fn compute_pass_encoder_set_bind_group(
#     handle: WGPUComputePassEncoder,
#     group_index: UInt32,
#     dynamic_offsets_count: Int,
#     dynamic_offsets: UnsafePointer[UInt32],
#     group: WGPUBindGroup = WGPUBindGroup(),
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPUComputePassEncoder,
#             UInt32,
#             WGPUBindGroup,
#             Int32,
#             UnsafePointer[UInt32],
#         ) -> None
#     ]("wgpuComputePassEncoderSetBindGroup")(
#         handle, group_index, group, dynamic_offsets_count, dynamic_offsets
#     )


# fn compute_pass_encoder_dispatch_workgroups(
#     handle: WGPUComputePassEncoder,
#     workgroupCountX: UInt32,
#     workgroupCountY: UInt32,
#     workgroupCountZ: UInt32,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUComputePassEncoder, UInt32, UInt32, UInt32) -> None
#     ]("wgpuComputePassEncoderDispatchWorkgroups")(
#         handle, workgroupCountX, workgroupCountY, workgroupCountZ
#     )


# fn compute_pass_encoder_dispatch_workgroups_indirect(
#     handle: WGPUComputePassEncoder,
#     indirect_buffer: WGPUBuffer,
#     indirect_offset: UInt64,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUComputePassEncoder, WGPUBuffer, UInt64) -> None
#     ]("wgpuComputePassEncoderDispatchWorkgroupsIndirect")(
#         handle, indirect_buffer, indirect_offset
#     )


# fn compute_pass_encoder_end(
#     handle: WGPUComputePassEncoder,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUComputePassEncoder,) -> None](
#         "wgpuComputePassEncoderEnd"
#     )(
#         handle,
#     )


# fn compute_pass_encoder_set_label(
#     handle: WGPUComputePassEncoder, label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUComputePassEncoder, UnsafePointer[Int8]) -> None
#     ]("wgpuComputePassEncoderSetLabel")(handle, label)


# struct _ComputePipelineImpl:
#     pass


# alias WGPUComputePipeline = UnsafePointer[_ComputePipelineImpl]


# fn compute_pipeline_release(handle: WGPUComputePipeline):
#     _wgpu.get_function[fn (UnsafePointer[_ComputePipelineImpl]) -> None](
#         "wgpuComputePipelineRelease"
#     )(handle)


# fn compute_pipeline_get_bind_group_layout(
#     handle: WGPUComputePipeline, group_index: UInt32
# ) -> WGPUBindGroupLayout:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUComputePipeline, UInt32) -> WGPUBindGroupLayout
#     ]("wgpuComputePipelineGetBindGroupLayout")(handle, group_index)


# fn compute_pipeline_set_label(
#     handle: WGPUComputePipeline, label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUComputePipeline, UnsafePointer[Int8]) -> None
#     ]("wgpuComputePipelineSetLabel")(handle, label)


struct Device:
    var _handle: _c.WGPUDevice

    fn __init__(out self, unsafe_ptr: _c.WGPUDevice):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUDevice()

    fn __del__(owned self):
        if self._handle:
            _c.device_release(self._handle)

    fn create_bind_group(self, descriptor: BindGroupDescriptor) -> BindGroup:
        """
        TODO
        """
        entries = List[_c.WGPUBindGroupEntry]()
        for entry in descriptor.entries:
            entries.append(
                _c.WGPUBindGroupEntry(
                    binding=entry[].binding,
                    buffer=entry[].buffer[]._handle,
                    offset=entry[].offset,
                    size=entry[].size,
                    sampler=entry[].sampler[]._handle,
                    texture_view=entry[].texture_view[]._handle,
                )
            )
        handle = _c.device_create_bind_group(
            self._handle,
            _c.WGPUBindGroupDescriptor(
                label=descriptor.label.unsafe_cstr_ptr(),
                layout=descriptor.layout._handle,
                entrie_count=len(descriptor.entries),
                entries=entries.unsafe_ptr(),
            ),
        )
        _ = entries
        return BindGroup(handle)

    fn create_bind_group_layout(
        self, descriptor: BindGroupLayoutDescriptor
    ) -> BindGroupLayout:
        """
        TODO
        """
        entries = List[_c.WGPUBindGroupLayoutEntry]()
        # for entry in descriptor.entries:
        #     entries.append(
        #         # _c.WGPUBindGroupLayoutEntry(
        #         #     binding=entry[].binding,
        #         #     visibility=entry[].visibility,
        #         #     buffer=_c.WGPUBufferBindingLayout(
        #         #         # type: BufferBindingType
        #         #         # has_dynamic_offset: Bool
        #         #         # min_binding_size: UInt64
        #         #         type=entry[].buffer.type,),
        #         #     # var buffer= WGPUBufferBindingLayout
        #         #     # var sampler= WGPUSamplerBindingLayout
        #         #     # var texture= WGPUTextureBindingLayout
        #         #     # var storage_texture= WGPUStorageTextureBindingLayout
        #         # )
        #     )
        return BindGroupLayout(
            _c.device_create_bind_group_layout(
                self._handle,
                _c.WGPUBindGroupLayoutDescriptor(
                    label=descriptor.label.unsafe_cstr_ptr(),
                    entrie_count=len(descriptor.entries),
                    entries=UnsafePointer[_c.WGPUBindGroupLayoutEntry](),
                ),
            )
        )

    #     return _wgpu.get_function[
    #         fn (
    #             WGPUDevice, UnsafePointer[WGPUBindGroupLayoutDescriptor]
    #         ) -> WGPUBindGroupLayout
    #     ]("wgpuDeviceCreateBindGroupLayout")(
    #         handle, UnsafePointer.address_of(descriptor)
    #     )

    fn create_buffer(self, descriptor: BufferDescriptor) -> Buffer:
        """
        TODO
        """
        return Buffer(
            _c.device_create_buffer(
                self._handle,
                _c.WGPUBufferDescriptor(
                    label=descriptor.label.unsafe_cstr_ptr(),
                    usage=descriptor.usage,
                    size=descriptor.size,
                    mapped_at_creation=descriptor.mapped_at_creation,
                ),
            )
        )

    fn create_command_encoder(
        self, label: StringLiteral = ""
    ) -> CommandEncoder:
        """
        TODO
        """
        return CommandEncoder(
            _c.device_create_command_encoder(
                self._handle,
                _c.WGPUCommandEncoderDescriptor(label=label.unsafe_cstr_ptr()),
            )
        )

    # fn device_create_compute_pipeline(
    #     handle: WGPUDevice, descriptor: WGPUComputePipelineDescriptor
    # ) -> WGPUComputePipeline:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (
    #             WGPUDevice, UnsafePointer[WGPUComputePipelineDescriptor]
    #         ) -> WGPUComputePipeline
    #     ]("wgpuDeviceCreateComputePipeline")(
    #         handle, UnsafePointer.address_of(descriptor)
    #     )

    # fn device_create_compute_pipeline_async(
    #     handle: WGPUDevice,
    #     descriptor: WGPUComputePipelineDescriptor,
    #     callback: fn (
    #         CreatePipelineAsyncStatus,
    #         WGPUComputePipeline,
    #         UnsafePointer[Int8],
    #         UnsafePointer[NoneType],
    #     ) -> None,
    #     user_data: UnsafePointer[NoneType],
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (
    #             WGPUDevice,
    #             UnsafePointer[WGPUComputePipelineDescriptor],
    #             fn (
    #                 CreatePipelineAsyncStatus,
    #                 WGPUComputePipeline,
    #                 UnsafePointer[Int8],
    #                 UnsafePointer[NoneType],
    #             ) -> None,
    #             UnsafePointer[NoneType],
    #         ) -> None
    #     ]("wgpuDeviceCreateComputePipelineAsync")(
    #         handle, UnsafePointer.address_of(descriptor), callback, user_data
    #     )

    fn create_pipeline_layout(self, label: StringLiteral) -> PipelineLayout:
        """
        TODO
        """
        return PipelineLayout(
            _c.device_create_pipeline_layout(
                self._handle,
                _c.WGPUPipelineLayoutDescriptor(label=label.unsafe_cstr_ptr()),
            )
        )

    fn create_query_set(self, descriptor: QuerySetDescriptor) -> QuerySet:
        """
        TODO
        """
        return QuerySet(
            _c.device_create_query_set(
                self._handle,
                _c.WGPUQuerySetDescriptor(
                    label=descriptor.label.unsafe_cstr_ptr(),
                    type=descriptor.type,
                    count=descriptor.count,
                ),
            )
        )

    # fn device_create_render_pipeline_async(
    #     handle: WGPUDevice,
    #     descriptor: WGPURenderPipelineDescriptor,
    #     callback: fn (
    #         CreatePipelineAsyncStatus,
    #         WGPURenderPipeline,
    #         UnsafePointer[Int8],
    #         UnsafePointer[NoneType],
    #     ) -> None,
    #     user_data: UnsafePointer[NoneType],
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (
    #             WGPUDevice,
    #             UnsafePointer[WGPURenderPipelineDescriptor],
    #             fn (
    #                 CreatePipelineAsyncStatus,
    #                 WGPURenderPipeline,
    #                 UnsafePointer[Int8],
    #                 UnsafePointer[NoneType],
    #             ) -> None,
    #             UnsafePointer[NoneType],
    #         ) -> None
    #     ]("wgpuDeviceCreateRenderPipelineAsync")(
    #         handle, UnsafePointer.address_of(descriptor), callback, user_data
    #     )

    # fn device_create_render_bundle_encoder(
    #     handle: WGPUDevice, descriptor: WGPURenderBundleEncoderDescriptor
    # ) -> WGPURenderBundleEncoder:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (
    #             WGPUDevice, UnsafePointer[WGPURenderBundleEncoderDescriptor]
    #         ) -> WGPURenderBundleEncoder
    #     ]("wgpuDeviceCreateRenderBundleEncoder")(
    #         handle, UnsafePointer.address_of(descriptor)
    #     )

    fn create_render_pipeline(
        self, descriptor: RenderPipelineDescriptor
    ) -> RenderPipeline:
        """
        TODO
        """
        v_buf_len = len(descriptor.vertex.buffers)
        buffers = List[_c.WGPUVertexBufferLayout]()
        for buf in descriptor.vertex.buffers:
            buffers.append(
                _c.WGPUVertexBufferLayout(
                    array_stride=buf[].array_stride,
                    step_mode=buf[].step_mode,
                    attribute_count=len(buf[].attributes),
                    attributes=buf[].attributes.unsafe_ptr(),
                )
            )
        frag = _c.WGPUFragmentState()
        targets = List[_c.WGPUColorTargetState]()
        if descriptor.fragment:
            for target in descriptor.fragment.value().targets:
                blend = UnsafePointer.address_of(target[].blend.value())
                targets.append(
                    _c.WGPUColorTargetState(
                        format=target[].format,
                        blend=blend,
                        write_mask=target[].write_mask,
                    )
                )
            frag = _c.WGPUFragmentState(
                module=descriptor.fragment.value().module[]._handle,
                entry_point=descriptor.fragment.value()
                .entry_point.unsafe_ptr()
                .bitcast[Int8](),
                target_count=len(targets),
                targets=targets.unsafe_ptr(),
            )

        handle = _c.device_create_render_pipeline(
            self._handle,
            _c.WGPURenderPipelineDescriptor(
                label=descriptor.label.unsafe_cstr_ptr(),
                vertex=_c.WGPUVertexState(
                    module=descriptor.vertex.module[]._handle,
                    entry_point=descriptor.vertex.entry_point.unsafe_ptr().bitcast[
                        Int8
                    ](),
                    buffer_count=len(buffers),
                    buffers=buffers.unsafe_ptr(),
                ),
                layout=_c.WGPUPipelineLayout(),
                depth_stencil=UnsafePointer[_c.WGPUDepthStencilState](),
                multisample=_c.WGPUMultisampleState(count=1, mask=0xFFFFFFFF),
                primitive=_c.WGPUPrimitiveState(
                    topology=descriptor.primitive.topology,
                    strip_index_format=descriptor.primitive.strip_index_format,
                    front_face=descriptor.primitive.front_face,
                    cull_mode=descriptor.primitive.cull_mode,
                ),
                fragment=UnsafePointer.address_of(frag),
            ),
        )
        _ = buffers^
        _ = frag^
        _ = targets^
        return RenderPipeline(handle)

    fn create_sampler(self, descriptor: SamplerDescriptor) -> Sampler:
        """
        TODO
        """
        return Sampler(
            _c.device_create_sampler(
                self._handle,
                _c.WGPUSamplerDescriptor(
                    label=descriptor.label.unsafe_cstr_ptr(),
                    address_mode_u=descriptor.address_mode_u,
                    address_mode_v=descriptor.address_mode_v,
                    address_mode_w=descriptor.address_mode_w,
                    mag_filter=descriptor.mag_filter,
                    min_filter=descriptor.min_filter,
                    mipmap_filter=descriptor.mipmap_filter,
                    lod_min_clamp=descriptor.lod_min_clamp,
                    lod_max_clamp=descriptor.lod_max_clamp,
                    compare=descriptor.compare,
                    max_anisotropy=descriptor.max_anisotropy,
                ),
            )
        )

    fn create_wgsl_shader_module(
        self, code: StringSlice
    ) raises -> ShaderModule:
        """
        TODO
        """

        wgsl_shader = _c.WGPUShaderModuleWgslDescriptor(
            chain=_c.ChainedStruct(s_type=SType.shader_module_wgsl_descriptor),
            code=code.unsafe_ptr().bitcast[Int8](),
        )
        handle = _c.device_create_shader_module(
            self._handle,
            _c.WGPUShaderModuleDescriptor(
                next_in_chain=UnsafePointer.address_of(wgsl_shader).bitcast[
                    _c.ChainedStruct
                ]()
            ),
        )
        _ = wgsl_shader^
        if not handle:
            raise Error("failed to create shader module.")
        return ShaderModule(handle)

    fn create_texture(self, descriptor: TextureDescriptor) -> Texture:
        """
        TODO
        """
        return Texture(
            _c.device_create_texture(
                self._handle,
                _c.WGPUTextureDescriptor(
                    label=descriptor.label.unsafe_cstr_ptr(),
                    usage=descriptor.usage,
                    dimension=descriptor.dimension,
                    size=descriptor.size,
                    format=descriptor.format,
                    mip_level_count=descriptor.mip_level_count,
                    sample_count=descriptor.sample_count,
                    view_format_count=len(descriptor.view_formats),
                    view_formats=descriptor.view_formats.unsafe_ptr(),
                ),
            )
        )

    fn destroy(self):
        """
        TODO
        """
        _c.device_destroy(self._handle)

    # fn device_get_limits(handle: WGPUDevice, limits: WGPUSupportedLimits) -> Bool:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPUDevice, UnsafePointer[WGPUSupportedLimits]) -> Bool
    #     ]("wgpuDeviceGetLimits")(handle, UnsafePointer.address_of(limits))

    fn has_feature(self, feature: FeatureName) -> Bool:
        """
        TODO
        """
        return _c.device_has_feature(self._handle, feature)

    fn enumerate_features(self, features: FeatureName) -> UInt:
        """
        TODO
        """
        return _c.device_enumerate_features(self._handle, features)

    fn get_queue(self) -> Queue:
        """
        TODO
        """
        return Queue(_c.device_get_queue(self._handle))


# fn device_push_error_scope(handle: WGPUDevice, filter: ErrorFilter) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUDevice, ErrorFilter) -> None](
#         "wgpuDevicePushErrorScope"
#     )(handle, filter)


# fn device_pop_error_scope(
#     handle: WGPUDevice,
#     callback: ErrorCallback,
#     userdata: UnsafePointer[NoneType],
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUDevice, ErrorCallback, UnsafePointer[NoneType]) -> None
#     ]("wgpuDevicePopErrorScope")(handle, callback, userdata)


# fn device_set_label(handle: WGPUDevice, label: UnsafePointer[Int8]) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUDevice, UnsafePointer[Int8]) -> None](
#         "wgpuDeviceSetLabel"
#     )(handle, label)


struct Instance:
    var _handle: _c.WGPUInstance

    fn __init__(out self) raises:
        self._handle = _c.create_instance()
        if not self._handle:
            raise Error("failed to create instance.")

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUInstance()

    fn __del__(owned self):
        if self._handle:
            _c.instance_release(self._handle)

    fn create_surface(
        self, window: glfw.Window
    ) raises -> Surface[__origin_of(window)]:
        """
        TODO
        """
        surface = _glfw_get_wgpu_surface(self._handle, window)
        if not surface:
            raise Error("failed to get surface.")
        return Surface[__origin_of(window)](surface)

    fn has_wgsl_language_feature(self, feature: WgslFeatureName) -> Bool:
        """
        TODO
        """
        return _c.instance_has_WGSL_language_feature(self._handle, feature)

    fn process_events(self):
        _c.instance_process_events(self._handle)

    fn request_adapter_sync(
        self,
        power_preference: PowerPreference = PowerPreference.undefined,
        force_fallback_adapter: Bool = False,
    ) raises -> Adapter:
        adapter = _request_adapter_sync(self._handle)
        if not adapter:
            raise Error("failed to get adapter.")
        return Adapter(adapter)

    fn request_adapter_sync(
        self,
        surface: Surface,
        power_preference: PowerPreference = PowerPreference.undefined,
        force_fallback_adapter: Bool = False,
    ) raises -> Adapter:
        adapter = _request_adapter_sync(
            self._handle,
            _c.WGPURequestAdapterOptions(compatible_surface=surface._handle),
        )
        if not adapter:
            raise Error("failed to get adapter.")
        return Adapter(adapter)

    fn generate_report(self) -> _c.WGPUGlobalReport:
        report = _c.WGPUGlobalReport()
        _c.generate_report(self._handle, report)
        return report

    fn enumerate_adapters(self) -> Span[_c.WGPUAdapter, __origin_of(self)]:
        ptr = UnsafePointer[_c.WGPUAdapter]()
        len = _c.instance_enumerate_adapters(
            self._handle, _c.WGPUInstanceEnumerateAdapterOptions(), ptr
        )
        return Span[_c.WGPUAdapter, __origin_of(self)](ptr=ptr, length=len)


struct PipelineLayout:
    var _handle: _c.WGPUPipelineLayout

    fn __init__(out self, unsafe_ptr: _c.WGPUPipelineLayout):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUPipelineLayout()

    fn __del__(owned self):
        if self._handle:
            _c.pipeline_layout_release(self._handle)


# fn pipeline_layout_release(handle: WGPUPipelineLayout):
#     _wgpu.get_function[fn (UnsafePointer[_PipelineLayoutImpl]) -> None](
#         "wgpuPipelineLayoutRelease"
#     )(handle)


# fn pipeline_layout_set_label(
#     handle: WGPUPipelineLayout, label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUPipelineLayout, UnsafePointer[Int8]) -> None
#     ]("wgpuPipelineLayoutSetLabel")(handle, label)


# struct _QuerySetImpl:
#     pass


struct QuerySet:
    var _handle: _c.WGPUQuerySet

    fn __init__(out self, unsafe_ptr: _c.WGPUQuerySet):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUQuerySet()

    fn __del__(owned self):
        if self._handle:
            _c.query_set_release(self._handle)


# fn query_set_set_label(
#     handle: WGPUQuerySet, label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUQuerySet, UnsafePointer[Int8]) -> None](
#         "wgpuQuerySetSetLabel"
#     )(handle, label)


# fn query_set_get_type(
#     handle: WGPUQuerySet,
# ) -> QueryType:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUQuerySet,) -> QueryType](
#         "wgpuQuerySetGetType"
#     )(
#         handle,
#     )


# fn query_set_get_count(
#     handle: WGPUQuerySet,
# ) -> UInt32:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUQuerySet,) -> UInt32](
#         "wgpuQuerySetGetCount"
#     )(
#         handle,
#     )


# fn query_set_destroy(
#     handle: WGPUQuerySet,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUQuerySet,) -> None](
#         "wgpuQuerySetDestroy"
#     )(
#         handle,
#     )


struct Queue:
    var _handle: _c.WGPUQueue

    fn __init__(out self, unsafe_ptr: _c.WGPUQueue):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUQueue()

    fn __del__(owned self):
        if self._handle:
            _c.queue_release(self._handle)

    fn submit(
        self,
        command: CommandBuffer,
    ) -> None:
        """
        TODO
        """
        _c.queue_submit(
            self._handle, 1, UnsafePointer.address_of(command._handle)
        )


# fn queue_on_submitted_work_done(
#     handle: WGPUQueue,
#     callback: fn (QueueWorkDoneStatus, UnsafePointer[NoneType]) -> None,
#     user_data: UnsafePointer[NoneType],
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPUQueue,
#             fn (QueueWorkDoneStatus, UnsafePointer[NoneType]) -> None,
#             UnsafePointer[NoneType],
#         ) -> None
#     ]("wgpuQueueOnSubmittedWorkDone")(handle, callback, user_data)


# fn queue_write_buffer(
#     handle: WGPUQueue,
#     buffer: WGPUBuffer,
#     buffer_offset: UInt64,
#     data: UnsafePointer[NoneType],
#     size: UInt,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPUQueue, WGPUBuffer, UInt64, UnsafePointer[NoneType], UInt
#         ) -> None
#     ]("wgpuQueueWriteBuffer")(handle, buffer, buffer_offset, data, size)


# fn queue_write_texture(
#     handle: WGPUQueue,
#     destination: WGPUImageCopyTexture,
#     data: UnsafePointer[NoneType],
#     data_size: UInt,
#     data_layout: WGPUTextureDataLayout,
#     write_size: WGPUExtent3D,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPUQueue,
#             UnsafePointer[WGPUImageCopyTexture],
#             UnsafePointer[NoneType],
#             UInt,
#             UnsafePointer[WGPUTextureDataLayout],
#             UnsafePointer[WGPUExtent3D],
#         ) -> None
#     ]("wgpuQueueWriteTexture")(
#         handle,
#         UnsafePointer.address_of(destination),
#         data,
#         data_size,
#         UnsafePointer.address_of(data_layout),
#         UnsafePointer.address_of(write_size),
#     )


# fn queue_set_label(handle: WGPUQueue, label: UnsafePointer[Int8]) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUQueue, UnsafePointer[Int8]) -> None](
#         "wgpuQueueSetLabel"
#     )(handle, label)


# struct _RenderBundleImpl:
#     pass


# alias WGPURenderBundle = UnsafePointer[_RenderBundleImpl]


# fn render_bundle_release(handle: WGPURenderBundle):
#     _wgpu.get_function[fn (UnsafePointer[_RenderBundleImpl]) -> None](
#         "wgpuRenderBundleRelease"
#     )(handle)


# fn render_bundle_set_label(
#     handle: WGPURenderBundle, label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderBundle, UnsafePointer[Int8]) -> None
#     ]("wgpuRenderBundleSetLabel")(handle, label)


# struct _RenderBundleEncoderImpl:
#     pass


# alias WGPURenderBundleEncoder = UnsafePointer[_RenderBundleEncoderImpl]


# fn render_bundle_encoder_release(handle: WGPURenderBundleEncoder):
#     _wgpu.get_function[fn (UnsafePointer[_RenderBundleEncoderImpl]) -> None](
#         "wgpuRenderBundleEncoderRelease"
#     )(handle)


# fn render_bundle_encoder_set_pipeline(
#     handle: WGPURenderBundleEncoder, pipeline: WGPURenderPipeline
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderBundleEncoder, WGPURenderPipeline) -> None
#     ]("wgpuRenderBundleEncoderSetPipeline")(handle, pipeline)


# fn render_bundle_encoder_set_bind_group(
#     handle: WGPURenderBundleEncoder,
#     group_index: UInt32,
#     dynamic_offsets_count: Int,
#     dynamic_offsets: UnsafePointer[UInt32],
#     group: WGPUBindGroup = WGPUBindGroup(),
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPURenderBundleEncoder,
#             UInt32,
#             WGPUBindGroup,
#             Int32,
#             UnsafePointer[UInt32],
#         ) -> None
#     ]("wgpuRenderBundleEncoderSetBindGroup")(
#         handle, group_index, group, dynamic_offsets_count, dynamic_offsets
#     )


# fn render_bundle_encoder_draw(
#     handle: WGPURenderBundleEncoder,
#     vertex_count: UInt32,
#     instance_count: UInt32,
#     first_vertex: UInt32,
#     first_instance: UInt32,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderBundleEncoder, UInt32, UInt32, UInt32, UInt32) -> None
#     ]("wgpuRenderBundleEncoderDraw")(
#         handle, vertex_count, instance_count, first_vertex, first_instance
#     )


# fn render_bundle_encoder_draw_indexed(
#     handle: WGPURenderBundleEncoder,
#     index_count: UInt32,
#     instance_count: UInt32,
#     first_index: UInt32,
#     base_vertex: Int32,
#     first_instance: UInt32,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPURenderBundleEncoder, UInt32, UInt32, UInt32, Int32, UInt32
#         ) -> None
#     ]("wgpuRenderBundleEncoderDrawIndexed")(
#         handle,
#         index_count,
#         instance_count,
#         first_index,
#         base_vertex,
#         first_instance,
#     )


# fn render_bundle_encoder_draw_indirect(
#     handle: WGPURenderBundleEncoder,
#     indirect_buffer: WGPUBuffer,
#     indirect_offset: UInt64,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderBundleEncoder, WGPUBuffer, UInt64) -> None
#     ]("wgpuRenderBundleEncoderDrawIndirect")(
#         handle, indirect_buffer, indirect_offset
#     )


# fn render_bundle_encoder_draw_indexed_indirect(
#     handle: WGPURenderBundleEncoder,
#     indirect_buffer: WGPUBuffer,
#     indirect_offset: UInt64,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderBundleEncoder, WGPUBuffer, UInt64) -> None
#     ]("wgpuRenderBundleEncoderDrawIndexedIndirect")(
#         handle, indirect_buffer, indirect_offset
#     )


# fn render_bundle_encoder_insert_debug_marker(
#     handle: WGPURenderBundleEncoder, marker_label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderBundleEncoder, UnsafePointer[Int8]) -> None
#     ]("wgpuRenderBundleEncoderInsertDebugMarker")(handle, marker_label)


# fn render_bundle_encoder_pop_debug_group(
#     handle: WGPURenderBundleEncoder,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPURenderBundleEncoder,) -> None](
#         "wgpuRenderBundleEncoderPopDebugGroup"
#     )(
#         handle,
#     )


# fn render_bundle_encoder_push_debug_group(
#     handle: WGPURenderBundleEncoder, group_label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderBundleEncoder, UnsafePointer[Int8]) -> None
#     ]("wgpuRenderBundleEncoderPushDebugGroup")(handle, group_label)


# fn render_bundle_encoder_set_vertex_buffer(
#     handle: WGPURenderBundleEncoder,
#     slot: UInt32,
#     offset: UInt64,
#     size: UInt64,
#     buffer: WGPUBuffer = WGPUBuffer(),
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderBundleEncoder, UInt32, WGPUBuffer, UInt64, UInt64) -> None
#     ]("wgpuRenderBundleEncoderSetVertexBuffer")(
#         handle, slot, buffer, offset, size
#     )


# fn render_bundle_encoder_set_index_buffer(
#     handle: WGPURenderBundleEncoder,
#     buffer: WGPUBuffer,
#     format: IndexFormat,
#     offset: UInt64,
#     size: UInt64,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPURenderBundleEncoder, WGPUBuffer, IndexFormat, UInt64, UInt64
#         ) -> None
#     ]("wgpuRenderBundleEncoderSetIndexBuffer")(
#         handle, buffer, format, offset, size
#     )


# fn render_bundle_encoder_finish(
#     handle: WGPURenderBundleEncoder,
#     descriptor: WGPURenderBundleDescriptor = WGPURenderBundleDescriptor(),
# ) -> WGPURenderBundle:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPURenderBundleEncoder, UnsafePointer[WGPURenderBundleDescriptor]
#         ) -> WGPURenderBundle
#     ]("wgpuRenderBundleEncoderFinish")(
#         handle, UnsafePointer.address_of(descriptor)
#     )


# fn render_bundle_encoder_set_label(
#     handle: WGPURenderBundleEncoder, label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderBundleEncoder, UnsafePointer[Int8]) -> None
#     ]("wgpuRenderBundleEncoderSetLabel")(handle, label)


struct RenderPassEncoder:
    var _handle: _c.WGPURenderPassEncoder

    fn __init__(out self, unsafe_ptr: _c.WGPURenderPassEncoder):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPURenderPassEncoder()

    fn __del__(owned self):
        if self._handle:
            _c.render_pass_encoder_release(self._handle)

    fn set_pipeline(self, pipeline: RenderPipeline):
        """
        TODO
        """
        _c.render_pass_encoder_set_pipeline(self._handle, pipeline._handle)

    # fn render_pass_encoder_set_bind_group(
    #     handle: WGPURenderPassEncoder,
    #     group_index: UInt32,
    #     dynamic_offsets_count: Int,
    #     dynamic_offsets: UnsafePointer[UInt32],
    #     group: WGPUBindGroup = WGPUBindGroup(),
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (
    #             WGPURenderPassEncoder,
    #             UInt32,
    #             WGPUBindGroup,
    #             Int32,
    #             UnsafePointer[UInt32],
    #         ) -> None
    #     ]("wgpuRenderPassEncoderSetBindGroup")(
    #         handle, group_index, group, dynamic_offsets_count, dynamic_offsets
    #     )

    fn draw(
        self,
        vertex_count: UInt32,
        instance_count: UInt32,
        first_vertex: UInt32,
        first_instance: UInt32,
    ):
        """
        TODO
        """
        _c.render_pass_encoder_draw(
            self._handle,
            vertex_count,
            instance_count,
            first_vertex,
            first_instance,
        )

    # fn render_pass_encoder_draw_indexed(
    #     handle: WGPURenderPassEncoder,
    #     index_count: UInt32,
    #     instance_count: UInt32,
    #     first_index: UInt32,
    #     base_vertex: Int32,
    #     first_instance: UInt32,
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (
    #             WGPURenderPassEncoder, UInt32, UInt32, UInt32, Int32, UInt32
    #         ) -> None
    #     ]("wgpuRenderPassEncoderDrawIndexed")(
    #         handle,
    #         index_count,
    #         instance_count,
    #         first_index,
    #         base_vertex,
    #         first_instance,
    #     )

    # fn render_pass_encoder_draw_indirect(
    #     handle: WGPURenderPassEncoder,
    #     indirect_buffer: WGPUBuffer,
    #     indirect_offset: UInt64,
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPURenderPassEncoder, WGPUBuffer, UInt64) -> None
    #     ]("wgpuRenderPassEncoderDrawIndirect")(
    #         handle, indirect_buffer, indirect_offset
    #     )

    # fn render_pass_encoder_draw_indexed_indirect(
    #     handle: WGPURenderPassEncoder,
    #     indirect_buffer: WGPUBuffer,
    #     indirect_offset: UInt64,
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPURenderPassEncoder, WGPUBuffer, UInt64) -> None
    #     ]("wgpuRenderPassEncoderDrawIndexedIndirect")(
    #         handle, indirect_buffer, indirect_offset
    #     )

    # fn render_pass_encoder_execute_bundles(
    #     handle: WGPURenderPassEncoder,
    #     bundles_count: Int,
    #     bundles: UnsafePointer[WGPURenderBundle],
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (
    #             WGPURenderPassEncoder, Int32, UnsafePointer[WGPURenderBundle]
    #         ) -> None
    #     ]("wgpuRenderPassEncoderExecuteBundles")(handle, bundles_count, bundles)

    # fn render_pass_encoder_insert_debug_marker(
    #     handle: WGPURenderPassEncoder, marker_label: UnsafePointer[Int8]
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPURenderPassEncoder, UnsafePointer[Int8]) -> None
    #     ]("wgpuRenderPassEncoderInsertDebugMarker")(handle, marker_label)

    # fn render_pass_encoder_pop_debug_group(
    #     handle: WGPURenderPassEncoder,
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPURenderPassEncoder,) -> None](
    #         "wgpuRenderPassEncoderPopDebugGroup"
    #     )(
    #         handle,
    #     )

    # fn render_pass_encoder_push_debug_group(
    #     handle: WGPURenderPassEncoder, group_label: UnsafePointer[Int8]
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPURenderPassEncoder, UnsafePointer[Int8]) -> None
    #     ]("wgpuRenderPassEncoderPushDebugGroup")(handle, group_label)

    # fn render_pass_encoder_set_stencil_reference(
    #     handle: WGPURenderPassEncoder, reference: UInt32
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPURenderPassEncoder, UInt32) -> None](
    #         "wgpuRenderPassEncoderSetStencilReference"
    #     )(handle, reference)

    # fn render_pass_encoder_set_blend_constant(
    #     handle: WGPURenderPassEncoder, color: WGPUColor
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPURenderPassEncoder, UnsafePointer[WGPUColor]) -> None
    #     ]("wgpuRenderPassEncoderSetBlendConstant")(
    #         handle, UnsafePointer.address_of(color)
    #     )

    # fn render_pass_encoder_set_viewport(
    #     handle: WGPURenderPassEncoder,
    #     x: Float32,
    #     y: Float32,
    #     width: Float32,
    #     height: Float32,
    #     min_depth: Float32,
    #     max_depth: Float32,
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (
    #             WGPURenderPassEncoder,
    #             Float32,
    #             Float32,
    #             Float32,
    #             Float32,
    #             Float32,
    #             Float32,
    #         ) -> None
    #     ]("wgpuRenderPassEncoderSetViewport")(
    #         handle, x, y, width, height, min_depth, max_depth
    #     )

    # fn render_pass_encoder_set_scissor_rect(
    #     handle: WGPURenderPassEncoder,
    #     x: UInt32,
    #     y: UInt32,
    #     width: UInt32,
    #     height: UInt32,
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPURenderPassEncoder, UInt32, UInt32, UInt32, UInt32) -> None
    #     ]("wgpuRenderPassEncoderSetScissorRect")(handle, x, y, width, height)

    fn set_vertex_buffer(
        self,
        slot: UInt32,
        offset: UInt64,
        size: UInt64,
        buffer: Buffer
    ):
        """
        TODO
        """
        _c.render_pass_encoder_set_vertex_buffer(
            self._handle,
            slot,
            offset,
            size,
            buffer._handle
        )

    # fn render_pass_encoder_set_index_buffer(
    #     handle: WGPURenderPassEncoder,
    #     buffer: WGPUBuffer,
    #     format: IndexFormat,
    #     offset: UInt64,
    #     size: UInt64,
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (
    #             WGPURenderPassEncoder, WGPUBuffer, IndexFormat, UInt64, UInt64
    #         ) -> None
    #     ]("wgpuRenderPassEncoderSetIndexBuffer")(
    #         handle, buffer, format, offset, size
    #     )

    # fn render_pass_encoder_begin_occlusion_query(
    #     handle: WGPURenderPassEncoder, query_index: UInt32
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPURenderPassEncoder, UInt32) -> None](
    #         "wgpuRenderPassEncoderBeginOcclusionQuery"
    #     )(handle, query_index)

    # fn render_pass_encoder_end_occlusion_query(
    #     handle: WGPURenderPassEncoder,
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPURenderPassEncoder,) -> None](
    #         "wgpuRenderPassEncoderEndOcclusionQuery"
    #     )(
    #         handle,
    #     )

    fn end(self):
        """
        TODO
        """
        _c.render_pass_encoder_end(self._handle)


# fn render_pass_encoder_set_label(
#     handle: WGPURenderPassEncoder, label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderPassEncoder, UnsafePointer[Int8]) -> None
#     ]("wgpuRenderPassEncoderSetLabel")(handle, label)


struct RenderPipeline:
    var _handle: _c.WGPURenderPipeline

    fn __init__(out self, unsafe_ptr: _c.WGPURenderPipeline):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPURenderPipeline()

    fn __del__(owned self):
        if self._handle:
            _c.render_pipeline_release(self._handle)


# fn render_pipeline_release(handle: WGPURenderPipeline):
#     _wgpu.get_function[fn (UnsafePointer[_RenderPipelineImpl]) -> None](
#         "wgpuRenderPipelineRelease"
#     )(handle)


# fn render_pipeline_get_bind_group_layout(
#     handle: WGPURenderPipeline, group_index: UInt32
# ) -> WGPUBindGroupLayout:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderPipeline, UInt32) -> WGPUBindGroupLayout
#     ]("wgpuRenderPipelineGetBindGroupLayout")(handle, group_index)


# fn render_pipeline_set_label(
#     handle: WGPURenderPipeline, label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderPipeline, UnsafePointer[Int8]) -> None
#     ]("wgpuRenderPipelineSetLabel")(handle, label)


# struct _SamplerImpl:
#     pass


struct Sampler:
    var _handle: _c.WGPUSampler

    fn __init__(out self, unsafe_ptr: _c.WGPUSampler):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUSampler()

    fn __del__(owned self):
        if self._handle:
            _c.sampler_release(self._handle)

    fn set_label(self, label: StringSlice):
        """
        TODO
        """
        _c.sampler_set_label(self._handle, label.unsafe_ptr().bitcast[Int8]())


struct ShaderModule:
    var _handle: _c.WGPUShaderModule

    fn __init__(out self, unsafe_ptr: _c.WGPUShaderModule):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUShaderModule()

    fn __del__(owned self):
        if self._handle:
            _c.shader_module_release(self._handle)


# fn shader_module_get_compilation_info(
#     handle: WGPUShaderModule,
#     callback: fn (
#         CompilationInfoRequestStatus,
#         UnsafePointer[WGPUCompilationInfo],
#         UnsafePointer[NoneType],
#     ) -> None,
#     user_data: UnsafePointer[NoneType],
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (
#             WGPUShaderModule,
#             fn (
#                 CompilationInfoRequestStatus,
#                 UnsafePointer[WGPUCompilationInfo],
#                 UnsafePointer[NoneType],
#             ) -> None,
#             UnsafePointer[NoneType],
#         ) -> None
#     ]("wgpuShaderModuleGetCompilationInfo")(handle, callback, user_data)


# fn shader_module_set_label(
#     handle: WGPUShaderModule, label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUShaderModule, UnsafePointer[Int8]) -> None
#     ]("wgpuShaderModuleSetLabel")(handle, label)


struct Surface[window: ImmutableOrigin]:
    var _handle: _c.WGPUSurface

    fn __init__(out self, unsafe_ptr: _c.WGPUSurface):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUSurface()

    fn __del__(owned self):
        if self._handle:
            _c.surface_release(self._handle)

    fn configure(
        self,
        *,
        device: Device,
        format: TextureFormat,
        usage: TextureUsage,
        width: UInt32,
        height: UInt32,
        view_formats: List[TextureFormat] = List[TextureFormat](),
        alpha_mode: CompositeAlphaMode = wgpu.CompositeAlphaMode.auto,
        present_mode: PresentMode = PresentMode.fifo,
    ):
        """
        TODO
        """
        _c.surface_configure(
            self._handle,
            _c.WGPUSurfaceConfiguration(
                device=device._handle,
                format=format,
                usage=usage,
                view_format_count=len(view_formats),
                view_formats=view_formats.unsafe_ptr(),
                alpha_mode=alpha_mode,
                width=width,
                height=height,
                present_mode=present_mode,
            ),
        )

    fn get_capabilities(
        self,
        adapter: Adapter,
    ) -> SurfaceCapabilities:
        """
        TODO
        """
        caps = _c.WGPUSurfaceCapabilities()
        _c.surface_get_capabilities(self._handle, adapter._handle, caps)
        return SurfaceCapabilities(caps)

    #     return _wgpu.get_function[
    #         fn (
    #             WGPUSurface, WGPUAdapter, UnsafePointer[WGPUSurfaceCapabilities]
    #         ) -> None
    #     ]("wgpuSurfaceGetCapabilities")(
    #         handle, adapter, UnsafePointer.address_of(capabilities)
    #     )

    fn get_current_texture(self) -> SurfaceTexture:
        """
        TODO
        """
        tex = _c.WGPUSurfaceTexture()
        _c.surface_get_current_texture(self._handle, tex)
        return SurfaceTexture(
            texture=ArcPointer(Texture(tex.texture)),
            suboptimal=tex.suboptimal,
            status=tex.status,
        )

    fn present(self):
        """
        TODO
        """
        _c.surface_present(self._handle)

    fn surface_unconfigure(self) -> None:
        """
        TODO
        """
        _c.surface_unconfigure(self._handle)


# fn surface_set_label(handle: WGPUSurface, label: UnsafePointer[Int8]) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUSurface, UnsafePointer[Int8]) -> None](
#         "wgpuSurfaceSetLabel"
#     )(handle, label)


struct Texture:
    var _handle: _c.WGPUTexture

    fn __init__(out self, unsafe_ptr: _c.WGPUTexture):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUTexture()

    fn __del__(owned self):
        if self._handle:
            _c.texture_release(self._handle)

    fn create_view(
        self,
        *,
        format: TextureFormat,
        dimension: TextureViewDimension,
        label: StringLiteral = "",
        base_mip_level: UInt32 = 0,
        mip_level_count: UInt32 = MIP_LEVEL_COUNT_UNDEFINED,
        base_array_layer: UInt32 = 0,
        array_layer_count: UInt32 = ARRAY_LAYER_COUNT_UNDEFINED,
        aspect: TextureAspect = TextureAspect.all,
    ) -> ArcPointer[TextureView]:
        """
        TODO
        """
        return TextureView(
            _c.texture_create_view(
                self._handle,
                _c.WGPUTextureViewDescriptor(
                    label=label.unsafe_cstr_ptr(),
                    format=format,
                    dimension=dimension,
                    base_mip_level=base_mip_level,
                    mip_level_count=mip_level_count,
                    base_array_layer=base_array_layer,
                    array_layer_count=array_layer_count,
                    aspect=aspect,
                ),
            )
        )

    # fn texture_set_label(handle: WGPUTexture, label: UnsafePointer[Int8]) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPUTexture, UnsafePointer[Int8]) -> None](
    #         "wgpuTextureSetLabel"
    #     )(handle, label)

    # fn texture_get_width(
    #     handle: WGPUTexture,
    # ) -> UInt32:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPUTexture,) -> UInt32](
    #         "wgpuTextureGetWidth"
    #     )(
    #         handle,
    #     )

    # fn texture_get_height(
    #     handle: WGPUTexture,
    # ) -> UInt32:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPUTexture,) -> UInt32](
    #         "wgpuTextureGetHeight"
    #     )(
    #         handle,
    #     )

    # fn texture_get_depth_or_array_layers(
    #     handle: WGPUTexture,
    # ) -> UInt32:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPUTexture,) -> UInt32](
    #         "wgpuTextureGetDepthOrArrayLayers"
    #     )(
    #         handle,
    #     )

    # fn texture_get_mip_level_count(
    #     handle: WGPUTexture,
    # ) -> UInt32:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPUTexture,) -> UInt32](
    #         "wgpuTextureGetMipLevelCount"
    #     )(
    #         handle,
    #     )

    # fn texture_get_sample_count(
    #     handle: WGPUTexture,
    # ) -> UInt32:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPUTexture,) -> UInt32](
    #         "wgpuTextureGetSampleCount"
    #     )(
    #         handle,
    #     )

    # fn texture_get_dimension(
    #     handle: WGPUTexture,
    # ) -> TextureDimension:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPUTexture,) -> TextureDimension](
    #         "wgpuTextureGetDimension"
    #     )(
    #         handle,
    #     )

    fn get_format(self) -> TextureFormat:
        """
        TODO
        """
        return _c.texture_get_format(self._handle)


# fn texture_get_usage(
#     handle: WGPUTexture,
# ) -> TextureUsage:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUTexture,) -> TextureUsage](
#         "wgpuTextureGetUsage"
#     )(
#         handle,
#     )


# fn texture_destroy(
#     handle: WGPUTexture,
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[fn (WGPUTexture,) -> None]("wgpuTextureDestroy")(
#         handle,
#     )


# struct _TextureViewImpl:
#     pass


struct TextureView:
    var _handle: _c.WGPUTextureView

    fn __init__(out self, unsafe_ptr: _c.WGPUTextureView):
        self._handle = unsafe_ptr

    fn __moveinit__(mut self, owned rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUTextureView()

    fn __del__(owned self):
        if self._handle:
            _c.texture_view_release(self._handle)


# fn texture_view_release(handle: WGPUTextureView):
#     _wgpu.get_function[fn (UnsafePointer[_TextureViewImpl]) -> None](
#         "wgpuTextureViewRelease"
#     )(handle)


# fn texture_view_set_label(
#     handle: WGPUTextureView, label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPUTextureView, UnsafePointer[Int8]) -> None
#     ]("wgpuTextureViewSetLabel")(handle, label)


fn _glfw_get_wgpu_surface(
    instance: _c.WGPUInstance, window: glfw.Window
) -> _c.WGPUSurface:
    platform = glfw.get_platform()
    if platform == glfw.Platform.cocoa:
        objc = sys.ffi.DLHandle("libobjc.A.dylib")

        fn sel(name: String) -> UnsafePointer[NoneType]:
            return objc.get_function[
                fn (UnsafePointer[Int8]) -> UnsafePointer[NoneType]
            ]("sel_registerName")(name.unsafe_cstr_ptr())

        fn get_class(name: String) -> UnsafePointer[NoneType]:
            return objc.get_function[
                fn (UnsafePointer[Int8]) -> UnsafePointer[NoneType]
            ]("objc_getClass")(name.unsafe_cstr_ptr())

        objc_msg_send = objc.get_function[
            fn (
                UnsafePointer[NoneType], UnsafePointer[NoneType]
            ) -> UnsafePointer[NoneType]
        ]("objc_msgSend")
        objc_msg_send_bool = objc.get_function[
            fn (UnsafePointer[NoneType], UnsafePointer[NoneType], Bool) -> None
        ]("objc_msgSend")

        objc_msg_send_ptr = objc.get_function[
            fn (
                UnsafePointer[NoneType],
                UnsafePointer[NoneType],
                UnsafePointer[NoneType],
            ) -> None
        ]("objc_msgSend")

        cls = get_class("CAMetalLayer")
        metal_layer = objc_msg_send(cls, sel("layer"))
        ns_window = window.get_cocoa_window().bitcast[NoneType]()
        getter = sel("contentView")
        content_view = objc_msg_send(ns_window, getter)
        set_wants_layer = sel("setWantsLayer:")
        set_layer = sel("setLayer:")
        objc_msg_send_bool(content_view, set_wants_layer, True)
        objc_msg_send_ptr(content_view, set_layer, metal_layer)
        from_metal_layer = wgpu._cffi.WGPUSurfaceDescriptorFromMetalLayer(
            chain=wgpu._cffi.ChainedStruct(
                s_type=wgpu.SType.surface_descriptor_from_metal_layer,
            ),
            layer=metal_layer,
        )
        descriptor = wgpu._cffi.WGPUSurfaceDescriptor(
            next_in_chain=UnsafePointer.address_of(from_metal_layer).bitcast[
                wgpu._cffi.ChainedStruct
            ](),
            label=UnsafePointer[Int8](),
        )
        surf = _c.instance_create_surface(instance, descriptor)
        _ = from_metal_layer^  # keep layer alive
        return surf
    # elif platform == glfw.Platform.x11:
    #     pass
    # elif platform == glfw.Platform.wayland:
    #     pass
    else:
        return _c.WGPUSurface()


fn _request_adapter_sync(
    instance: _c.WGPUInstance,
    opts: _c.WGPURequestAdapterOptions = _c.WGPURequestAdapterOptions(),
) -> _c.WGPUAdapter:
    adapter_user_data = (_c.WGPUAdapter(), False)

    fn _req_adapter(
        status: RequestAdapterStatus,
        adapter: _c.WGPUAdapter,
        message: UnsafePointer[Int8],
        user_data: UnsafePointer[NoneType],
    ):
        u_data = user_data.bitcast[Tuple[_c.WGPUAdapter, Bool]]()
        u_data[][0] = adapter
        u_data[][1] = True

    _c.instance_request_adapter(
        instance,
        _req_adapter,
        UnsafePointer.address_of(adapter_user_data).bitcast[NoneType](),
        opts,
    )
    debug_assert(adapter_user_data[1], "adapter request did not finish")
    adapter = adapter_user_data[0]
    return adapter
