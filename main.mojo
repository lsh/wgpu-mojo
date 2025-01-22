import wgpu
from wgpu import glfw, VertexAttribute, VertexFormat, Color, VertexBufferLayout, BufferUsage, BufferDescriptor, VertexStepMode
from sys.info import sizeof

from memory import Span
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
    window = glfw.Window(640, 480, "Hello, WebGPU")

    instance = wgpu.Instance()
    surface = instance.create_surface(window)

    adapter = instance.request_adapter_sync()

    device = adapter.adapter_request_device()

    queue = device.get_queue()

    surface_capabilies = surface.get_capabilities(adapter)
    surface_format = surface_capabilies.formats()[0]
    surface.configure(
        width=640,
        height=480,
        usage=wgpu.TextureUsage.render_attachment,
        format=surface_format,
        device=device,
        alpha_mode=wgpu.CompositeAlphaMode.auto,
        present_mode=wgpu.PresentMode.fifo,
    )

    shader_code = """
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
            // Convert color from u32 to f32
            //let color = vec4<f32>(f32(in_color.x) / 255.0, f32(in_color.y) / 255.0, f32(in_color.z) / 255.0, f32(in_color.w) / 255.0);
            return in_color;
        }
        """

    shader_module = device.create_wgsl_shader_module(code=shader_code)

    vertex_attributes = List[VertexAttribute](
        VertexAttribute(format=VertexFormat.float32x3, offset=0, shader_location=0),
        VertexAttribute(format=VertexFormat.float32x4, offset=sizeof[Vec3](), shader_location=1)
    )

    vertex_buffer_layout = VertexBufferLayout[StaticConstantOrigin](
        array_stride=sizeof[MyVertex](),
        step_mode=VertexStepMode.vertex,
        attributes=Span[VertexAttribute, StaticConstantOrigin](ptr=vertex_attributes.unsafe_ptr(), length=len(vertex_attributes))
    )

    desc = wgpu.RenderPipelineDescriptor(
        label="render pipeline",
        vertex=wgpu.VertexState(
            entry_point="vs_main",
            module=shader_module,
            buffers=List[VertexBufferLayout[StaticConstantOrigin]](vertex_buffer_layout),
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
        layout=Optional[Pointer[wgpu.PipelineLayout, StaticConstantOrigin]](
            None
        ),
        depth_stencil=None,
    )
    pipeline = device.create_render_pipeline(descriptor=desc)

    vertices = List[MyVertex](
        MyVertex(Vec3(-0.5, -0.5, 0.0), MyColor(1, 0, 0, 1)),
        MyVertex(Vec3(0.5, -0.5, 0.0), MyColor(0, 1, 0, 1)),
        MyVertex(Vec3(0.0, 0.5, 0.0), MyColor(0, 0, 1, 1))
    )
    vertices_size_bytes = len(vertices) * sizeof[MyVertex]()
    vertex_buffer = device.create_buffer(BufferDescriptor(
        "vertex buffer",
        BufferUsage.vertex,
        vertices_size_bytes,
        True
    ))
    dst = vertex_buffer.get_mapped_range(0, vertices_size_bytes).bitcast[MyVertex]()
    for i in range(len(vertices)):
        dst[i] = vertices[i]
    vertex_buffer.unmap()

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

            rp = encoder.begin_render_pass(color_attachments=color_attachments)
            rp.set_pipeline(pipeline)
            rp.set_vertex_buffer(0, 0, vertex_buffer.get_size(), vertex_buffer)
            rp.draw(3, 1, 0, 0)
            rp.end()

            command = encoder.finish()

            queue.submit(command)
            surface.present()

    glfw.terminate()
