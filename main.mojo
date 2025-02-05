import wgpu
from wgpu import (
    glfw,
    SurfaceConfiguration,
    VertexAttribute,
    VertexFormat,
    Color,
    VertexBufferLayout,
    BufferUsage,
    BufferDescriptor,
    VertexStepMode,
    TextureFormat,
    PipelineLayout,
    BindGroupLayout,
    BufferBindingLayout,
    BindGroupLayoutEntry,
    BindGroupDescriptor,
    BindGroupLayoutDescriptor,
    PipelineLayoutDescriptor,
    BindGroupEntry,
    BufferBinding,
)
from sys.info import sizeof

from memory import Span, UnsafePointer, ArcPointer
from collections import Optional


@value
struct Vec3:
    var x: Float32
    var y: Float32
    var z: Float32


@value
struct MyColor:
    var r: Float32
    var g: Float32
    var b: Float32
    var a: Float32


@value
struct MyVertex:
    var pos: Vec3
    var color: MyColor


def main():
    glfw.init()
    glfw.window_hint(glfw.CLIENT_API, glfw.NO_API)
    window = glfw.Window(640, 480, "Hello, WebGPU")

    instance = wgpu.Instance()
    surface = instance.create_surface(window)

    adapter = instance.request_adapter_sync(surface)

    device = adapter.adapter_request_device()

    queue = device.get_queue()

    surface_capabilies = surface.get_capabilities(adapter)
    surface_format = surface_capabilies.formats()[0]
    surface.configure(
        device,
        SurfaceConfiguration(
            width=640,
            height=480,
            usage=wgpu.TextureUsage.render_attachment,
            format=surface_format,
            alpha_mode=wgpu.CompositeAlphaMode.auto,
            present_mode=wgpu.PresentMode.fifo,
            view_formats=List[TextureFormat](),
        ),
    )

    shader_code = """
        @group(0) @binding(0)
        var<uniform> time: f32;

        struct VertexOutput {
            @builtin(position) position: vec4<f32>,
            @location(1) color: vec4<f32>,
        };

        @vertex
        fn vs_main(@location(0) in_pos: vec3<f32>, @location(1) in_color: vec4<f32>) -> VertexOutput {
            var p = in_pos;
            return VertexOutput(vec4<f32>(p, 1.0), in_color);
        }

        @fragment
        fn fs_main(@location(1) in_color: vec4<f32>) -> @location(0) vec4<f32> {
            let t = cos(time * 0.1) * 0.5 + 0.5;
            let color = in_color + vec4<f32>(t, t, t, 1.0);
            return color;
        }
        """

    shader_module = device.create_wgsl_shader_module(code=shader_code)

    vertex_attributes = List[VertexAttribute](
        VertexAttribute(
            format=VertexFormat.float32x3, offset=0, shader_location=0
        ),
        VertexAttribute(
            format=VertexFormat.float32x4,
            offset=sizeof[Vec3](),
            shader_location=1,
        ),
    )

    vertex_buffer_layout = VertexBufferLayout(
        array_stride=sizeof[MyVertex](),
        step_mode=VertexStepMode.vertex,
        attributes=Span(vertex_attributes),
    )

    bind_group_layout = ArcPointer(
        device.create_bind_group_layout(
            BindGroupLayoutDescriptor(
                "bind group layout",
                List[BindGroupLayoutEntry](
                    BindGroupLayoutEntry(
                        binding=0,
                        visibility=wgpu.ShaderStage.fragment
                        | wgpu.ShaderStage.vertex,
                        type=BufferBindingLayout(
                            type=wgpu.BufferBindingType.uniform,
                            has_dynamic_offset=False,
                            min_binding_size=sizeof[Float32](),
                        ),
                        count=0,
                    )
                ),
            )
        )
    )

    pipeline_layout = device.create_pipeline_layout(
        PipelineLayoutDescriptor(
            "pipeline layout",
            List[ArcPointer[BindGroupLayout]](bind_group_layout),
        )
    )
    uniform_buffer = ArcPointer(
        device.create_buffer(
            BufferDescriptor(
                "uniform buffer",
                BufferUsage.uniform | BufferUsage.copy_dst,
                sizeof[Float32](),
                True,
            )
        )
    )
    uniform_dst = (
        uniform_buffer[]
        .get_mapped_range(0, sizeof[Float32]())
        .bitcast[Float32]()
    )
    uniform_dst[0] = 0
    uniform_buffer[].unmap()

    uniform_bind_group = device.create_bind_group(
        BindGroupDescriptor(
            "bind group",
            bind_group_layout,
            List[BindGroupEntry](
                BindGroupEntry(
                    0,
                    BufferBinding(uniform_buffer, 0, sizeof[Float32]()),
                )
            ),
        )
    )

    desc = wgpu.RenderPipelineDescriptor(
        label="render pipeline",
        vertex=wgpu.VertexState(
            entry_point="vs_main",
            module=shader_module,
            buffers=List[VertexBufferLayout[__origin_of(vertex_attributes)]](
                vertex_buffer_layout
            ),
        ),
        fragment=wgpu.FragmentState(
            module=shader_module,
            entry_point="fs_main",
            targets=List[wgpu.ColorTargetState](
                wgpu.ColorTargetState(
                    blend=wgpu.BlendState(
                        color=wgpu.BlendComponent(
                            src_factor=wgpu.BlendFactor.src_alpha,
                            dst_factor=wgpu.BlendFactor.one_minus_src_alpha,
                            operation=wgpu.BlendOperation.add,
                        ),
                        alpha=wgpu.BlendComponent(
                            src_factor=wgpu.BlendFactor.zero,
                            dst_factor=wgpu.BlendFactor.one,
                            operation=wgpu.BlendOperation.add,
                        ),
                    ),
                    format=surface_format,
                    write_mask=wgpu.ColorWriteMask.all,
                )
            ),
        ),
        primitive=wgpu.PrimitiveState(
            topology=wgpu.PrimitiveTopology.triangle_list,
        ),
        multisample=wgpu.MultisampleState(),
        layout=Pointer.address_of(pipeline_layout),
        depth_stencil=None,
    )
    pipeline = device.create_render_pipeline(descriptor=desc)

    vertices = List[MyVertex](
        MyVertex(Vec3(-0.5, -0.5, 0.0), MyColor(1, 0, 0, 1)),
        MyVertex(Vec3(0.5, -0.5, 0.0), MyColor(0, 1, 0, 1)),
        MyVertex(Vec3(0.0, 0.5, 0.0), MyColor(0, 0, 1, 1)),
    )
    vertices_size_bytes = len(vertices) * sizeof[MyVertex]()
    vertex_buffer = device.create_buffer(
        BufferDescriptor(
            "vertex buffer", BufferUsage.vertex, vertices_size_bytes, True
        )
    )
    dst = vertex_buffer.get_mapped_range(0, vertices_size_bytes).bitcast[
        MyVertex
    ]()
    for i in range(len(vertices)):
        dst[i] = vertices[i]
    vertex_buffer.unmap()

    u_time = Float32(0)
    while not window.should_close():
        glfw.poll_events()
        with surface.get_current_texture() as surface_tex:
            if (
                surface_tex.status
                != wgpu.SurfaceGetCurrentTextureStatus.success
            ):
                raise Error("failed to get surface tex")
            target_view = surface_tex.texture[].create_view(
                format=surface_tex.texture[].get_format(),
                dimension=wgpu.TextureViewDimension.d2,
                base_mip_level=0,
                mip_level_count=1,
                base_array_layer=0,
                array_layer_count=1,
                aspect=wgpu.TextureAspect.all,
            )
            encoder = device.create_command_encoder()
            color_attachments = List[wgpu.RenderPassColorAttachment](
                wgpu.RenderPassColorAttachment(
                    view=target_view,
                    load_op=wgpu.LoadOp.clear,
                    store_op=wgpu.StoreOp.store,
                    clear_value=wgpu.Color(0.9, 0.1, 0.2, 1.0),
                )
            )

            queue.write_buffer(
                uniform_buffer,
                0,
                Span[UInt8, __origin_of(u_time)](
                    ptr=UnsafePointer.address_of(u_time).bitcast[UInt8](),
                    length=sizeof[Float32](),
                ),
            )
            rp = encoder.begin_render_pass(color_attachments=color_attachments)
            rp.set_pipeline(pipeline)
            rp.set_vertex_buffer(0, 0, vertex_buffer.get_size(), vertex_buffer)
            rp.set_bind_group(0, uniform_bind_group, List[UInt32]())
            rp.draw(3, 1, 0, 0)
            rp.end()

            command = encoder.finish()

            queue.submit(command)
            surface.present()
            u_time += 0.05

    glfw.terminate()
