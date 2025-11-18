import sys
import glfw
from os import abort
from memory import Span, UnsafePointer
from collections.string import StringSlice
from memory import ArcPointer

from .bitflags import *
from .constants import *
from .enums import *
from .structs import *

import . _cffi as _c
from ._cffi import UnsafePointer


struct Adapter(Movable):
    var _handle: _c.WGPUAdapter

    fn __init__(out self, unsafe_ptr: _c.WGPUAdapter):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUAdapter()

    fn __del__(deinit self):
        if self._handle:
            _c.adapter_release(self._handle)

    fn limits(self) raises -> Limits:
        var limits = _cffi.WGPUSupportedLimits()
        if (
            _cffi.adapter_get_limits(self._handle, UnsafePointer(to=limits))
            != 0
        ):
            raise Error("Failed to get limits")
        return limits.limits

    fn has_feature(self, feature: FeatureName) -> Bool:
        """
        TODO
        """
        return _c.adapter_has_feature(self._handle, feature)

    # fn enumerate_features(
    #     handle: WGPUAdapter, features: FeatureName
    # ) -> UInt:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPUAdapter, FeatureName) -> UInt](
    #         "wgpuAdapterEnumerateFeatures"
    #     )(handle, features)

    # fn get_info(handle: WGPUAdapter, info: WGPUAdapterInfo) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPUAdapter, UnsafePointer[WGPUAdapterInfo]) -> None
    #     ]("wgpuAdapterGetInfo")(handle, UnsafePointer(to=info))

    fn request_device(self, var descriptor: DeviceDescriptor) raises -> Device:
        """
        TODO
        """

        user_data = (_c.WGPUDevice(), False, String(""))

        fn _req(
            status: RequestDeviceStatus,
            device: _c.WGPUDevice,
            message: _c.FFIPointer[Int8, mut=False],
            user_data: _c.FFIPointer[NoneType, mut=True],
        ):
            u_data = user_data.unsafe_ptr().bitcast[
                Tuple[_c.WGPUDevice, Bool, String]
            ]()
            u_data[][0] = device
            u_data[][1] = True
            if message:
                u_data[][2] = String(message.unsafe_ptr())

        var desc = _c.WGPUDeviceDescriptor(
            label=descriptor.label.unsafe_cstr_ptr(),
            required_feature_count=len(
                descriptor.required_features.value()
            ) if descriptor.required_features else 0,
            required_features=descriptor.required_features.value().unsafe_ptr() if descriptor.required_features else {},
            required_limits={},
        )

        _c.adapter_request_device(
            self._handle,
            _req,
            UnsafePointer(to=user_data).bitcast[NoneType](),
            UnsafePointer(to=desc),
        )
        device = user_data[0]
        error_msg = user_data[2]
        debug_assert(user_data[1], "Expected device callback to be done")

        _ = user_data^
        _ = desc^
        if not device:
            if error_msg:
                raise Error("failed to get device: " + error_msg)
            raise Error("failed to get device.")
        return Device(device)


@fieldwise_init
struct BindGroup(Movable):
    var _handle: _c.WGPUBindGroup
    var _layout: ArcPointer[BindGroupLayout]

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        self._layout = rhs._layout
        rhs._handle = _c.WGPUBindGroup()

    fn __del__(deinit self):
        if self._handle:
            _c.bind_group_release(self._handle)

    fn set_label(self, label: StringSlice):
        _c.bind_group_set_label(
            self._handle, label.unsafe_ptr().bitcast[Int8]()
        )


struct BindGroupLayout(Movable):
    var _handle: _c.WGPUBindGroupLayout

    fn __init__(out self, unsafe_ptr: _c.WGPUBindGroupLayout):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUBindGroupLayout()

    fn __del__(deinit self):
        if self._handle:
            _c.bind_group_layout_release(self._handle)

    fn set_label(self, label: StringSlice):
        """
        TODO
        """
        _c.bind_group_layout_set_label(
            self._handle, label.unsafe_ptr().bitcast[Int8]()
        )


struct Buffer(Movable, Sized):
    var _handle: _c.WGPUBuffer

    fn __init__(out self, unsafe_ptr: _c.WGPUBuffer):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUBuffer()

    fn __del__(deinit self):
        if self._handle:
            _c.buffer_release(self._handle)

    # fn buffer_map_async(
    #     handle: WGPUBuffer,
    #     mode: MapMode,
    #     offset: Int,
    #     size: Int,
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
    #             Int,
    #             Int,
    #             fn (BufferMapAsyncStatus, UnsafePointer[NoneType]) -> None,
    #             UnsafePointer[NoneType],
    #         ) -> None
    #     ]("wgpuBufferMapAsync")(handle, mode, offset, size, callback, user_data)

    fn get_mapped_range[
        type: AnyType
    ](mut self, offset: Int, size: Int) -> MappedBuffer[type, origin_of(self)]:
        """
        TODO
        """
        return MappedBuffer[type, origin_of(self)](
            self,
            _c.buffer_get_mapped_range(self._handle, offset, size)
            .unsafe_ptr()
            .bitcast[type](),
            offset,
            size,
        )

    # fn buffer_get_const_mapped_range(
    #     handle: WGPUBuffer, offset: Int, size: UInt
    # ) -> UnsafePointer[NoneType]:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPUBuffer, Int, UInt) -> UnsafePointer[NoneType]
    #     ]("wgpuBufferGetConstMappedRange")(handle, offset, size)

    fn set_label(self, var label: String):
        """
        TODO
        """
        _c.buffer_set_label(self._handle, label.unsafe_cstr_ptr())

    fn usage(self) -> BufferUsage:
        """
        TODO
        """
        return _c.buffer_get_usage(self._handle)

    fn size(self) -> UInt64:
        """
        TODO
        """
        return _c.buffer_get_size(self._handle)

    fn __len__(self) -> Int:
        return Int(self.size())

    fn map_state(self) -> BufferMapState:
        """
        TODO
        """
        return _c.buffer_get_map_state(self._handle)

    fn unmap(mut self):
        """
        TODO
        """
        _c.buffer_unmap(self._handle)

    fn destroy(self):
        """
        TODO
        """
        _c.buffer_destroy(self._handle)


@fieldwise_init
struct MappedBuffer[type: AnyType, origin: MutOrigin](Copyable, Movable, Sized):
    var _buffer_handle: _c.WGPUBuffer
    var _ptr: UnsafePointer[type, MutOrigin.external]
    var _offset: Int
    var _size: Int

    fn __init__(
        out self,
        ref [origin]buffer: Buffer,
        ptr: UnsafePointer[type, MutOrigin.external],
        offset: Int,
        size: Int,
    ):
        self._buffer_handle = buffer._handle
        self._ptr = ptr
        self._offset = offset
        self._size = size

    fn __enter__(var self) -> Self:
        return self^

    fn __getitem__[
        IndexType: Indexer
    ](ref self, i: IndexType) -> ref [self] type:
        return self._ptr[i]

    fn __getitem__[i: Int](ref self) -> ref [self] type:
        return self._ptr[i]

    fn __del__(deinit self):
        _c.buffer_unmap(self._buffer_handle)

    fn __len__(self) -> Int:
        return self._size - self._offset


struct CommandBuffer(Movable):
    var _handle: _c.WGPUCommandBuffer

    fn __init__(out self, unsafe_ptr: _c.WGPUCommandBuffer):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUCommandBuffer()

    fn __del__(deinit self):
        if self._handle:
            _c.command_buffer_release(self._handle)

    fn set_label(self, label: StringSlice):
        """
        TODO
        """
        _c.command_buffer_set_label(
            self._handle, label.unsafe_ptr().bitcast[Int8]()
        )


@explicit_destroy("CommandEncoder requires destruction via `finish()`")
struct CommandEncoder(Movable):
    var _handle: _c.WGPUCommandEncoder

    fn __init__(out self, unsafe_ptr: _c.WGPUCommandEncoder):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUCommandEncoder()

    fn finish(deinit self) -> CommandBuffer:
        """
        TODO
        """
        var buffer = CommandBuffer(_c.command_encoder_finish(self._handle, {}))
        if self._handle:
            _c.command_encoder_release(self._handle)
        return buffer^

    # fn begin_compute_pass(
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
    #         handle, UnsafePointer(to=descriptor)
    #     )

    fn begin_render_pass[
        tex: ImmutOrigin
    ](mut self, var descriptor: RenderPassDescriptor[tex]) -> RenderPass[
        origin_of(self)
    ]:
        """
        TODO
        """
        attachments = List[_c.WGPURenderPassColorAttachment](
            capacity=len(descriptor.color_attachments)
        )
        for attachment in descriptor.color_attachments:
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

        desc = _c.WGPURenderPassDescriptor(
            label=descriptor.label.unsafe_cstr_ptr(),
            color_attachment_count=len(attachments),
            color_attachments=attachments.unsafe_ptr(),
        )
        handle = _c.command_encoder_begin_render_pass(
            self._handle, UnsafePointer(to=desc)
        )
        _ = attachments
        _ = desc
        return RenderPass[origin_of(self)](handle)

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

    fn copy_buffer_to_texture(
        mut self,
        mut source: ImageCopyBuffer,
        mut destination: ImageCopyTexture,
        mut copy_size: Extent3D,
    ):
        var dest = _cffi.WGPUImageCopyTexture(
            texture=destination.texture[]._handle,
            mip_level=destination.mip_level,
            origin=destination.origin,
            aspect=destination.aspect,
        )
        var src = _cffi.WGPUImageCopyBuffer(
            layout=_cffi.WGPUTextureDataLayout(
                offset=source.layout.offset,
                bytes_per_row=source.layout.bytes_per_row.or_else(0),
                rows_per_image=source.layout.rows_per_image.or_else(0),
            ),
            buffer=source.buffer[]._handle,
        )
        _cffi.command_encoder_copy_buffer_to_texture(
            self._handle,
            UnsafePointer(to=src),
            UnsafePointer(to=dest),
            UnsafePointer(to=copy_size),
        )
        _ = dest
        _ = src

    fn copy_texture_to_buffer(
        mut self,
        mut source: ImageCopyTexture,
        mut destination: ImageCopyBuffer,
        mut copy_size: Extent3D,
    ):
        var src = _cffi.WGPUImageCopyTexture(
            texture=source.texture[]._handle,
            mip_level=source.mip_level,
            origin=source.origin,
            aspect=source.aspect,
        )
        var dest = _cffi.WGPUImageCopyBuffer(
            layout=_cffi.WGPUTextureDataLayout(
                offset=destination.layout.offset,
                bytes_per_row=destination.layout.bytes_per_row.or_else(0),
                rows_per_image=destination.layout.rows_per_image.or_else(0),
            ),
            buffer=destination.buffer[]._handle,
        )
        _cffi.command_encoder_copy_texture_to_buffer(
            self._handle,
            UnsafePointer(to=src),
            UnsafePointer(to=dest),
            UnsafePointer(to=copy_size),
        )
        _ = dest
        _ = src


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
#         UnsafePointer(to=source),
#         UnsafePointer(to=destination),
#         UnsafePointer(to=copy_size),
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


struct Device(Movable):
    var _handle: _c.WGPUDevice

    fn __init__(out self, unsafe_ptr: _c.WGPUDevice):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUDevice()

    fn __del__(deinit self):
        if self._handle:
            _c.device_release(self._handle)

    fn create_bind_group(
        self, var descriptor: BindGroupDescriptor
    ) -> BindGroup:
        """
        TODO
        """
        entries = List[_c.WGPUBindGroupEntry]()
        for entry in descriptor.entries:
            if entry.resource.is_buffer():
                entries.append(
                    _c.WGPUBindGroupEntry(
                        binding=entry.binding,
                        buffer=entry.resource.buffer().buffer[]._handle,
                        offset=entry.resource.buffer().offset,
                        size=entry.resource.buffer().size,
                    )
                )
            elif entry.resource.is_texture_view():
                entries.append(
                    _c.WGPUBindGroupEntry(
                        binding=entry.binding,
                        texture_view=entry.resource.texture_view()._handle,
                    )
                )
            elif entry.resource.is_sampler():
                entries.append(
                    _c.WGPUBindGroupEntry(
                        binding=entry.binding,
                        sampler=entry.resource.sampler()._handle,
                    )
                )
        desc = _c.WGPUBindGroupDescriptor(
            label=descriptor.label.unsafe_cstr_ptr(),
            layout=descriptor.layout[]._handle,
            entrie_count=len(descriptor.entries),
            entries=entries.unsafe_ptr(),
        )
        handle = _c.device_create_bind_group(
            self._handle, UnsafePointer(to=desc)
        )
        _ = desc^
        _ = entries^
        return BindGroup(handle, descriptor.layout)

    fn create_bind_group_layout(
        self, var descriptor: BindGroupLayoutDescriptor
    ) -> BindGroupLayout:
        """
        TODO
        """
        entries = List[_c.WGPUBindGroupLayoutEntry]()
        for entry in descriptor.entries:
            c_entry = _c.WGPUBindGroupLayoutEntry(
                binding=entry.binding,
                visibility=entry.visibility,
            )
            if entry.type.is_buffer():
                c_entry.buffer = _c.WGPUBufferBindingLayout(
                    type=entry.type.buffer().type,
                    has_dynamic_offset=entry.type.buffer().has_dynamic_offset,
                    min_binding_size=entry.type.buffer().min_binding_size,
                )
            elif entry.type.is_sampler():
                c_entry.sampler = _c.WGPUSamplerBindingLayout(
                    type=entry.type.sampler().type
                )
            elif entry.type.is_texture():
                c_entry.texture = _c.WGPUTextureBindingLayout(
                    sample_type=entry.type.texture().sample_type,
                    view_dimension=entry.type.texture().view_dimension,
                    multisampled=entry.type.texture().multisampled,
                )
            elif entry.type.is_storage_texture():
                c_entry.storage_texture = _c.WGPUStorageTextureBindingLayout(
                    access=entry.type.storage_texture().access,
                    format=entry.type.storage_texture().format,
                    view_dimension=entry.type.storage_texture().view_dimension,
                )
            entries.append(c_entry)

        desc = _c.WGPUBindGroupLayoutDescriptor(
            label=descriptor.label.unsafe_cstr_ptr(),
            entrie_count=len(descriptor.entries),
            entries=entries.unsafe_ptr(),
        )
        layout = BindGroupLayout(
            _c.device_create_bind_group_layout(
                self._handle, UnsafePointer(to=desc)
            )
        )
        _ = desc^
        _ = entries^
        return layout^

    fn create_buffer[
        T: Copyable & Movable
    ](self, var descriptor: BufferDescriptor) -> Buffer:
        """
        TODO
        """

        var desc = _c.WGPUBufferDescriptor(
            label=descriptor.label.unsafe_cstr_ptr(),
            usage=descriptor.usage,
            size=descriptor.size,
            mapped_at_creation=descriptor.mapped_at_creation,
        )
        var buffer = Buffer(
            _c.device_create_buffer(self._handle, UnsafePointer(to=desc))
        )
        _ = desc^
        return buffer^

    fn create_command_encoder(
        self, var descriptor: CommandEncoderDescriptor
    ) -> CommandEncoder:
        """
        TODO
        """

        var desc = _c.WGPUCommandEncoderDescriptor(
            label=descriptor.label.unsafe_cstr_ptr()
        )
        var encoder = CommandEncoder(
            _c.device_create_command_encoder(
                self._handle, UnsafePointer(to=desc)
            )
        )
        _ = desc^
        return encoder^

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
    #         handle, UnsafePointer(to=descriptor)
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
    #         handle, UnsafePointer(to=descriptor), callback, user_data
    #     )

    fn create_pipeline_layout(
        self, var descriptor: PipelineLayoutDescriptor
    ) -> PipelineLayout:
        """
        TODO
        """
        layouts = List[_c.WGPUBindGroupLayout](
            capacity=len(descriptor.bind_group_layouts)
        )
        for layout in descriptor.bind_group_layouts:
            layouts.append(layout[]._handle)

        desc = _c.WGPUPipelineLayoutDescriptor(
            label=descriptor.label.unsafe_cstr_ptr(),
            bind_group_layout_count=len(descriptor.bind_group_layouts),
            bind_group_layouts=layouts.unsafe_ptr(),
        )
        layout = PipelineLayout(
            _c.device_create_pipeline_layout(
                self._handle, UnsafePointer(to=desc)
            )
        )
        _ = desc^
        _ = layouts^
        return layout^

    fn create_query_set(self, var descriptor: QuerySetDescriptor) -> QuerySet:
        """
        TODO
        """
        desc = _c.WGPUQuerySetDescriptor(
            label=descriptor.label.unsafe_cstr_ptr(),
            type=descriptor.type,
            count=descriptor.count,
        )

        query_set = QuerySet(
            _c.device_create_query_set(self._handle, UnsafePointer(to=desc))
        )
        _ = desc
        return query_set^

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
    #         handle, UnsafePointer(to=descriptor), callback, user_data
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
    #         handle, UnsafePointer(to=descriptor)
    #     )

    fn create_render_pipeline(
        self, var descriptor: RenderPipelineDescriptor
    ) -> RenderPipeline:
        """
        TODO
        """
        buffers = List[_c.WGPUVertexBufferLayout]()
        for buf in descriptor.vertex.buffers:
            buffers.append(
                _c.WGPUVertexBufferLayout(
                    array_stride=buf.array_stride,
                    step_mode=buf.step_mode,
                    attribute_count=len(buf.attributes),
                    attributes=buf.attributes.unsafe_ptr(),
                )
            )
        frag = _c.WGPUFragmentState()
        targets = List[_c.WGPUColorTargetState]()
        if descriptor.fragment:
            for ref target in descriptor.fragment.value().targets:
                blend = UnsafePointer(to=target.blend.value())
                targets.append(
                    _c.WGPUColorTargetState(
                        format=target.format,
                        blend=blend,
                        write_mask=target.write_mask,
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

        layout_ptr = _c.WGPUPipelineLayout()
        if descriptor.layout:
            layout_ptr = descriptor.layout.value()[]._handle

        multisample = _c.WGPUMultisampleState(
            count=descriptor.multisample.count,
            mask=descriptor.multisample.mask,
            alpha_to_coverage_enabled=descriptor.multisample.alpha_to_coverage_enabled,
        )

        depth_stencil = UnsafePointer[
            _c.WGPUDepthStencilState, MutOrigin.external
        ]()

        desc = _c.WGPURenderPipelineDescriptor(
            label=descriptor.label.unsafe_cstr_ptr(),
            vertex=_c.WGPUVertexState(
                module=descriptor.vertex.module[]._handle,
                entry_point=descriptor.vertex.entry_point.unsafe_ptr().bitcast[
                    Int8
                ](),
                buffer_count=len(buffers),
                buffers=buffers.unsafe_ptr(),
            ),
            layout=layout_ptr,
            depth_stencil=depth_stencil,
            multisample=multisample,
            primitive=_c.WGPUPrimitiveState(
                topology=descriptor.primitive.topology,
                strip_index_format=descriptor.primitive.strip_index_format,
                front_face=descriptor.primitive.front_face,
                cull_mode=descriptor.primitive.cull_mode,
            ),
            fragment=UnsafePointer(to=frag),
        )
        handle = _c.device_create_render_pipeline(
            self._handle, UnsafePointer(to=desc)
        )
        _ = desc
        _ = buffers
        _ = frag
        _ = targets
        return RenderPipeline(handle)

    fn create_sampler(self, var descriptor: SamplerDescriptor) -> Sampler:
        """
        TODO
        """

        desc = _c.WGPUSamplerDescriptor(
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
        )
        sampler = Sampler(
            _c.device_create_sampler(self._handle, UnsafePointer(to=desc))
        )
        _ = desc
        return sampler^

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
        desc = _c.WGPUShaderModuleDescriptor(
            next_in_chain=UnsafePointer(to=wgsl_shader).bitcast[
                _c.ChainedStruct
            ]()
        )
        handle = _c.device_create_shader_module(
            self._handle, UnsafePointer(to=desc)
        )
        _ = desc
        _ = wgsl_shader^
        if not handle:
            raise Error("failed to create shader module.")
        return ShaderModule(handle)

    fn create_texture(self, var descriptor: TextureDescriptor) -> Texture:
        """
        TODO
        """
        desc = _c.WGPUTextureDescriptor(
            label=descriptor.label.unsafe_cstr_ptr(),
            usage=descriptor.usage,
            dimension=descriptor.dimension,
            size=descriptor.size,
            format=descriptor.format,
            mip_level_count=descriptor.mip_level_count,
            sample_count=descriptor.sample_count,
            view_format_count=len(descriptor.view_formats),
            view_formats=descriptor.view_formats.unsafe_ptr(),
        )
        tex = Texture(
            _c.device_create_texture(self._handle, UnsafePointer(to=desc))
        )
        _ = desc
        return tex^

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
    #     ]("wgpuDeviceGetLimits")(handle, UnsafePointer(to=limits))

    fn has_feature(self, feature: FeatureName) -> Bool:
        """
        TODO
        """
        return _c.device_has_feature(self._handle, feature)

    # fn enumerate_features(self, features: FeatureName) -> UInt:
    #     """
    #     TODO
    #     """
    #     return _c.device_enumerate_features(self._handle, features)

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


struct Instance(Movable):
    var _handle: _c.WGPUInstance

    fn __init__(out self) raises:
        # Create instance extras for proper backend configuration (especially for Metal on macOS)
        extras = _c.WGPUInstanceExtras(
            chain=_c.ChainedStruct(
                s_type=SType(NativeSType.instance_extras.value)
            ),
            backends=InstanceBackend.all,
            flags=InstanceFlag.default,
        )

        descriptor = _c.WGPUInstanceDescriptor(
            next_in_chain=UnsafePointer(to=extras).bitcast[_c.ChainedStruct]()
        )

        self._handle = _c.create_instance(UnsafePointer(to=descriptor))
        _ = extras^
        _ = descriptor^
        if not self._handle:
            raise Error("failed to create instance.")

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUInstance()

    fn __del__(deinit self):
        if self._handle:
            _c.instance_release(self._handle)

    fn create_surface(self, window: glfw.Window) raises -> Surface:
        """
        TODO
        """
        surface = _glfw_get_wgpu_surface(self._handle, window)
        if not surface:
            raise Error("failed to get surface.")
        return Surface(surface)

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
        adapter = _request_adapter_sync(
            self._handle,
            _c.WGPURequestAdapterOptions(
                power_preference=power_preference,
                force_fallback_adapter=force_fallback_adapter,
            ),
        )
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
            _c.WGPURequestAdapterOptions(
                compatible_surface=surface._handle,
                power_preference=power_preference,
                force_fallback_adapter=force_fallback_adapter,
            ),
        )
        if not adapter:
            raise Error("failed to get adapter.")
        return Adapter(adapter)

    fn generate_report(self) -> _c.WGPUGlobalReport:
        report = _c.WGPUGlobalReport()
        _c.generate_report(self._handle, UnsafePointer(to=report))
        return report

    fn enumerate_adapters(self) -> Span[_c.WGPUAdapter, MutOrigin.external]:
        ptr = _c.FFIPointer[_c.WGPUAdapter, mut=True]()
        options = _c.WGPUInstanceEnumerateAdapterOptions()
        len = _c.instance_enumerate_adapters(
            self._handle, UnsafePointer(to=options), ptr
        )
        return Span[_c.WGPUAdapter, MutOrigin.external](
            ptr=ptr.unsafe_ptr(), length=len
        )


struct PipelineLayout(Movable):
    var _handle: _c.WGPUPipelineLayout

    fn __init__(out self, unsafe_ptr: _c.WGPUPipelineLayout):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUPipelineLayout()

    fn __del__(deinit self):
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


struct QuerySet(Movable):
    var _handle: _c.WGPUQuerySet

    fn __init__(out self, unsafe_ptr: _c.WGPUQuerySet):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUQuerySet()

    fn __del__(deinit self):
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


struct Queue(Movable):
    var _handle: _c.WGPUQueue

    fn __init__(out self, unsafe_ptr: _c.WGPUQueue):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUQueue()

    fn __del__(deinit self):
        if self._handle:
            _c.queue_release(self._handle)

    fn submit(mut self, command: CommandBuffer) -> None:
        """
        TODO
        """
        _c.queue_submit(
            self._handle,
            1,
            UnsafePointer(to=command._handle),
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

    fn write_buffer(
        mut self,
        buffer: Buffer,
        offset: UInt64,
        data: Span[mut=True, UInt8],
    ) -> None:
        """
        TODO
        """
        return _c.queue_write_buffer(
            self._handle,
            buffer._handle,
            offset,
            data.unsafe_ptr().bitcast[NoneType](),
            len(data),
        )

    fn write_texture(
        mut self,
        mut destination: ImageCopyTexture,
        mut data: Span[mut=True, UInt8],
        mut data_layout: TextureDataLayout,
        mut write_size: Extent3D,
    ) -> None:
        var dest = _cffi.WGPUImageCopyTexture(
            texture=destination.texture[]._handle,
            mip_level=destination.mip_level,
            origin=destination.origin,
            aspect=destination.aspect,
        )
        var data_lyt = _cffi.WGPUTextureDataLayout(
            offset=data_layout.offset,
            bytes_per_row=data_layout.bytes_per_row.or_else(0),
            rows_per_image=data_layout.rows_per_image.or_else(0),
        )
        _cffi.queue_write_texture(
            self._handle,
            UnsafePointer(to=dest),
            data.unsafe_ptr().bitcast[NoneType](),
            len(data),
            UnsafePointer(to=data_lyt),
            UnsafePointer(to=write_size),
        )
        _ = data_lyt
        _ = dest


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
#         handle, UnsafePointer(to=descriptor)
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


@fieldwise_init
struct RenderPass[encoder: ImmutOrigin](Movable):
    var _handle: _c.WGPURenderPassEncoder

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPURenderPassEncoder()

    fn set_pipeline(mut self, pipeline: RenderPipeline):
        """
        TODO
        """
        _c.render_pass_encoder_set_pipeline(self._handle, pipeline._handle)

    fn set_bind_group(
        mut self,
        index: UInt32,
        group: BindGroup,
        dynamic_offsets: Span[UInt32],
    ) -> None:
        """
        TODO
        """
        return _c.render_pass_encoder_set_bind_group(
            self._handle,
            index,
            len(dynamic_offsets),
            dynamic_offsets.unsafe_ptr(),
            group._handle,
        )

    fn draw(
        mut self,
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

    fn draw_indexed(
        mut self,
        index_count: UInt32,
        instance_count: UInt32,
        first_index: UInt32,
        base_vertex: Int32,
        first_instance: UInt32,
    ) -> None:
        """
        TODO
        """
        return _cffi.render_pass_encoder_draw_indexed(
            self._handle,
            index_count,
            instance_count,
            first_index,
            base_vertex,
            first_instance,
        )

    # fn draw_indirect(
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

    # fn draw_indexed_indirect(
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

    # fn execute_bundles(
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

    # fn insert_debug_marker(
    #     handle: WGPURenderPassEncoder, marker_label: UnsafePointer[Int8]
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPURenderPassEncoder, UnsafePointer[Int8]) -> None
    #     ]("wgpuRenderPassEncoderInsertDebugMarker")(handle, marker_label)

    # fn pop_debug_group(
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

    # fn push_debug_group(
    #     handle: WGPURenderPassEncoder, group_label: UnsafePointer[Int8]
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPURenderPassEncoder, UnsafePointer[Int8]) -> None
    #     ]("wgpuRenderPassEncoderPushDebugGroup")(handle, group_label)

    # fn set_stencil_reference(
    #     handle: WGPURenderPassEncoder, reference: UInt32
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPURenderPassEncoder, UInt32) -> None](
    #         "wgpuRenderPassEncoderSetStencilReference"
    #     )(handle, reference)

    # fn set_blend_constant(
    #     handle: WGPURenderPassEncoder, color: WGPUColor
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPURenderPassEncoder, UnsafePointer[WGPUColor]) -> None
    #     ]("wgpuRenderPassEncoderSetBlendConstant")(
    #         handle, UnsafePointer(to=color)
    #     )

    # fn set_viewport(
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

    # fn set_scissor_rect(
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
        mut self, slot: UInt32, offset: UInt64, size: UInt64, buffer: Buffer
    ):
        """
        TODO
        """
        _c.render_pass_encoder_set_vertex_buffer(
            self._handle, slot, offset, size, buffer._handle
        )

    fn set_index_buffer(
        mut self,
        buffer: Buffer,
        format: IndexFormat,
        offset: UInt64,
        size: UInt64,
    ) -> None:
        """
        TODO
        """
        return _cffi.render_pass_encoder_set_index_buffer(
            self._handle, buffer._handle, format, offset, size
        )

    # fn begin_occlusion_query(
    #     handle: WGPURenderPassEncoder, query_index: UInt32
    # ) -> None:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[fn (WGPURenderPassEncoder, UInt32) -> None](
    #         "wgpuRenderPassEncoderBeginOcclusionQuery"
    #     )(handle, query_index)

    # fn end_occlusion_query(
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

    fn end(deinit self):
        """
        TODO
        """
        _c.render_pass_encoder_end(self._handle)
        _c.render_pass_encoder_release(self._handle)

    fn __del__(deinit self):
        if self._handle:
            _c.render_pass_encoder_end(self._handle)
            _c.render_pass_encoder_release(self._handle)


# fn set_label(
#     handle: WGPURenderPassEncoder, label: UnsafePointer[Int8]
# ) -> None:
#     """
#     TODO
#     """
#     return _wgpu.get_function[
#         fn (WGPURenderPassEncoder, UnsafePointer[Int8]) -> None
#     ]("wgpuRenderPassEncoderSetLabel")(handle, label)


struct RenderPipeline(Movable):
    var _handle: _c.WGPURenderPipeline

    fn __init__(out self, unsafe_ptr: _c.WGPURenderPipeline):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPURenderPipeline()

    fn __del__(deinit self):
        if self._handle:
            _c.render_pipeline_release(self._handle)

    # fn render_pipeline_get_bind_group_layout(
    #     handle: WGPURenderPipeline, group_index: UInt32
    # ) -> WGPUBindGroupLayout:
    #     """
    #     TODO
    #     """
    #     return _wgpu.get_function[
    #         fn (WGPURenderPipeline, UInt32) -> WGPUBindGroupLayout
    #     ]("wgpuRenderPipelineGetBindGroupLayout")(handle, group_index)

    fn set_label(mut self, var label: String) -> None:
        """
        TODO
        """
        return _cffi.render_pipeline_set_label(
            self._handle, label.unsafe_cstr_ptr()
        )


struct Sampler(Movable):
    var _handle: _c.WGPUSampler

    fn __init__(out self, unsafe_ptr: _c.WGPUSampler):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUSampler()

    fn __del__(deinit self):
        if self._handle:
            _c.sampler_release(self._handle)

    fn set_label(self, label: StringSlice):
        """
        TODO
        """
        _c.sampler_set_label(self._handle, label.unsafe_ptr().bitcast[Int8]())


struct ShaderModule(Movable):
    var _handle: _c.WGPUShaderModule

    fn __init__(out self, unsafe_ptr: _c.WGPUShaderModule):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUShaderModule()

    fn __del__(deinit self):
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


struct Surface:
    var _handle: _c.WGPUSurface

    fn __init__(out self, unsafe_ptr: _c.WGPUSurface):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUSurface()

    fn __del__(deinit self):
        if self._handle:
            _c.surface_release(self._handle)

    fn configure(
        self,
        device: Device,
        config: SurfaceConfiguration,
    ):
        """
        TODO
        """
        var desc = _c.WGPUSurfaceConfiguration(
            device=device._handle,
            format=config.format,
            usage=config.usage,
            view_format_count=len(config.view_formats),
            view_formats=config.view_formats.unsafe_ptr(),
            alpha_mode=config.alpha_mode,
            width=config.width,
            height=config.height,
            present_mode=config.present_mode,
        )
        _c.surface_configure(self._handle, UnsafePointer(to=desc))
        _ = desc

    fn get_capabilities(
        self,
        adapter: Adapter,
    ) -> SurfaceCapabilities:
        """
        TODO
        """
        var caps = _c.WGPUSurfaceCapabilities()
        _c.surface_get_capabilities(
            self._handle,
            adapter._handle,
            UnsafePointer(to=caps),
        )
        return SurfaceCapabilities(caps^)

    fn get_current_texture(self) raises -> SurfaceTexture:
        """
        TODO
        """
        tex = _c.WGPUSurfaceTexture()
        _c.surface_get_current_texture(self._handle, UnsafePointer(to=tex))
        if tex.status != wgpu.SurfaceGetCurrentTextureStatus.success:
            raise Error("failed to get surface tex")
        return SurfaceTexture(
            texture=Texture(tex.texture),
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

    fn surface_set_label(mut self, var label: String):
        """
        TODO
        """
        _cffi.surface_set_label(self._handle, label.unsafe_cstr_ptr())


struct Texture(Movable):
    var _handle: _c.WGPUTexture

    fn __init__(out self, unsafe_ptr: _c.WGPUTexture):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUTexture()

    fn __del__(deinit self):
        if self._handle:
            _c.texture_release(self._handle)

    fn create_view(self, var descriptor: TextureViewDescriptor) -> TextureView:
        """
        TODO
        """

        var desc = _c.WGPUTextureViewDescriptor(
            label=descriptor.label.unsafe_cstr_ptr(),
            format=descriptor.format,
            dimension=descriptor.dimension,
            base_mip_level=descriptor.base_mip_level,
            mip_level_count=descriptor.mip_level_count,
            base_array_layer=descriptor.base_array_layer,
            array_layer_count=descriptor.array_layer_count,
            aspect=descriptor.aspect,
        )
        view = TextureView(
            _c.texture_create_view(self._handle, UnsafePointer(to=desc))
        )
        _ = desc
        return view^

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

    fn get_usage(self) -> TextureUsage:
        """
        TODO
        """
        return _cffi.texture_get_usage(self._handle)

    fn destroy(deinit self) -> None:
        """
        TODO
        """
        return _cffi.texture_destroy(self._handle)


struct TextureView(Movable):
    var _handle: _c.WGPUTextureView

    fn __init__(out self, unsafe_ptr: _c.WGPUTextureView):
        self._handle = unsafe_ptr

    fn __moveinit__(out self, deinit rhs: Self):
        self._handle = rhs._handle
        rhs._handle = _c.WGPUTextureView()

    fn __del__(deinit self):
        if self._handle:
            _c.texture_view_release(self._handle)

    fn set_label(mut self, var label: String):
        _cffi.texture_view_set_label(self._handle, label.unsafe_cstr_ptr())


fn _glfw_get_wgpu_surface(
    instance: _c.WGPUInstance, window: glfw.Window
) raises -> _c.WGPUSurface:
    @parameter
    if sys.CompilationTarget.is_macos():
        objc = sys.ffi.OwnedDLHandle("libobjc.A.dylib")

        @parameter
        fn sel(var name: String) -> _c.FFIPointer[NoneType, mut=True]:
            return objc.get_function[
                fn (
                    _c.FFIPointer[Int8, mut=False]
                ) -> _c.FFIPointer[NoneType, mut=True]
            ]("sel_registerName")(name.unsafe_cstr_ptr().as_immutable())

        @parameter
        fn get_class(var name: String) -> _c.FFIPointer[NoneType, mut=True]:
            return objc.get_function[
                fn (
                    _c.FFIPointer[Int8, mut=False]
                ) -> _c.FFIPointer[NoneType, mut=True]
            ]("objc_getClass")(name.unsafe_cstr_ptr())

        objc_msg_send = objc.get_function[
            fn (
                _c.FFIPointer[NoneType, mut=True],
                _c.FFIPointer[NoneType, mut=True],
            ) -> _c.FFIPointer[NoneType, mut=True]
        ]("objc_msgSend")
        objc_msg_send_bool = objc.get_function[
            fn (
                _c.FFIPointer[NoneType, mut=True],
                _c.FFIPointer[NoneType, mut=True],
                Bool,
            ) -> None
        ]("objc_msgSend")

        objc_msg_send_ptr = objc.get_function[
            fn (
                _c.FFIPointer[NoneType, mut=True],
                _c.FFIPointer[NoneType, mut=True],
                _c.FFIPointer[NoneType, mut=True],
            ) -> None
        ]("objc_msgSend")

        var cls_str = "CAMetalLayer"
        var cls = get_class(cls_str)
        var layer_str = "layer"
        var metal_layer = objc_msg_send(cls, sel(layer_str))
        var ns_window = window.get_cocoa_window()
        var content_view_str = "contentView"
        var getter = sel(content_view_str)
        var content_view = objc_msg_send(ns_window, getter)
        var set_wants_layer_str = "setWantsLayer:"
        var set_wants_layer = sel(set_wants_layer_str)
        var set_layer_str = "setLayer:"
        var set_layer = sel(set_layer_str)
        objc_msg_send_bool(content_view, set_wants_layer, True)
        objc_msg_send_ptr(content_view, set_layer, metal_layer)
        var from_metal_layer = wgpu._cffi.WGPUSurfaceDescriptorFromMetalLayer(
            chain=wgpu._cffi.ChainedStruct(
                s_type=wgpu.SType.surface_descriptor_from_metal_layer,
            ),
            layer=metal_layer,
        )
        var descriptor = wgpu._cffi.WGPUSurfaceDescriptor(
            next_in_chain=UnsafePointer(to=from_metal_layer).bitcast[
                wgpu._cffi.ChainedStruct
            ](),
            label=UnsafePointer[Int8, ImmutOrigin.external](),
        )
        var surf = _c.instance_create_surface(
            instance, UnsafePointer(to=descriptor)
        )
        _ = descriptor^
        _ = from_metal_layer^
        return surf
    # elif platform == glfw.Platform.x11:
    #     pass
    # elif platform == glfw.Platform.wayland:
    #     pass
    else:
        return _c.WGPUSurface()


fn _request_adapter_sync(
    instance: _c.WGPUInstance,
    var opts: _c.WGPURequestAdapterOptions = _c.WGPURequestAdapterOptions(),
) -> _c.WGPUAdapter:
    adapter_user_data = (_c.WGPUAdapter(), False)

    fn _req_adapter(
        status: RequestAdapterStatus,
        adapter: _c.WGPUAdapter,
        message: _c.FFIPointer[Int8, mut=False],
        user_data: _c.FFIPointer[NoneType, mut=True],
    ):
        u_data = user_data.unsafe_ptr().bitcast[Tuple[_c.WGPUAdapter, Bool]]()
        u_data[][0] = adapter
        u_data[][1] = True

    _c.instance_request_adapter(
        instance,
        _req_adapter,
        UnsafePointer(to=adapter_user_data).bitcast[NoneType](),
        UnsafePointer(to=opts),
    )
    debug_assert(adapter_user_data[1], "adapter request did not finish")
    adapter = adapter_user_data[0]
    return adapter
