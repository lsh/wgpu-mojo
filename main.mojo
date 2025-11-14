import wgpu
from wgpu import (
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
import glfw

from memory import ArcPointer
from sys.info import size_of


@fieldwise_init
struct Vec3(Copyable, ImplicitlyCopyable, Movable):
    var x: Float32
    var y: Float32
    var z: Float32


@fieldwise_init
struct MyColor(Copyable, ImplicitlyCopyable, Movable):
    var r: Float32
    var g: Float32
    var b: Float32
    var a: Float32


@fieldwise_init
struct MyVertex(Copyable, ImplicitlyCopyable, Movable):
    var pos: Vec3
    var color: MyColor


fn main() raises:
    glfw.init()
    glfw.Window.hint(glfw.ContextHint.client_api, glfw.ContextHint.no_api)
    title = "Hello, WebGPU"
    window = glfw.Window(640, 480, title)

    instance = wgpu.Instance()
    surface = instance.create_surface(window)

    adapter = instance.request_adapter_sync(surface)

    device = adapter.request_device({})

    queue = device.get_queue()

    surface_capabilities = surface.get_capabilities(adapter)
    surface_format = surface_capabilities.formats()[0]
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

    vertex_attributes = [
        VertexAttribute(
            format=VertexFormat.float32x3, offset=0, shader_location=0
        ),
        VertexAttribute(
            format=VertexFormat.float32x4,
            offset=size_of[Vec3](),
            shader_location=1,
        ),
    ]

    vertex_buffer_layouts = [
        VertexBufferLayout(
            array_stride=size_of[MyVertex](),
            step_mode=VertexStepMode.vertex,
            attributes=Span(vertex_attributes),
        )
    ]

    bind_group_entries = [
        BindGroupLayoutEntry(
            binding=0,
            visibility=wgpu.ShaderStage.fragment | wgpu.ShaderStage.vertex,
            type=BufferBindingLayout(
                type=wgpu.BufferBindingType.uniform,
                has_dynamic_offset=False,
                min_binding_size=size_of[Float32](),
            ),
            count=0,
        )
    ]
    bind_group_layouts = [
        ArcPointer(
            device.create_bind_group_layout(
                {"bind group layout", bind_group_entries}
            )
        )
    ]

    pipeline_layout = device.create_pipeline_layout(
        {"pipeline layout", bind_group_layouts}
    )
    uniform_buffer = device.create_buffer[Float32](
        {
            "uniform buffer",
            BufferUsage.uniform | BufferUsage.copy_dst,
            size_of[Float32](),
            True,
        }
    )

    with uniform_buffer.get_mapped_range(0, 1) as uniform_host:
        uniform_host[0] = 0
    uniform_bind_group_entries = [
        BindGroupEntry[Float32](0, BufferBinding[Float32](uniform_buffer, 0, 1))
    ]

    uniform_bind_group = device.create_bind_group(
        {"bind group", bind_group_layouts[0], uniform_bind_group_entries}
    )
    targets = [
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
    ]

    pipeline = device.create_render_pipeline(
        {
            label = "render pipeline",
            vertex = wgpu.VertexState(
                entry_point="vs_main",
                module=shader_module,
                buffers=vertex_buffer_layouts,
            ),
            fragment = wgpu.FragmentState(
                module=shader_module,
                entry_point="fs_main",
                targets=targets,
            ),
            primitive = wgpu.PrimitiveState(
                topology=wgpu.PrimitiveTopology.triangle_list,
            ),
            multisample = wgpu.MultisampleState(),
            layout = Pointer(to=pipeline_layout),
            depth_stencil = None,
        }
    )

    vertices: List[MyVertex] = [
        {Vec3(-0.5, -0.5, 0.0), MyColor(1, 0, 0, 1)},
        {Vec3(0.5, -0.5, 0.0), MyColor(0, 1, 0, 1)},
        {Vec3(0.0, 0.5, 0.0), MyColor(0, 0, 1, 1)},
    ]
    vertex_buffer = device.create_buffer[MyVertex](
        {"vertex buffer", BufferUsage.vertex, len(vertices), True}
    )
    with vertex_buffer.get_mapped_range(0, len(vertices)) as vertex_host:
        for i in range(len(vertex_host)):
            vertex_host[i] = vertices[i]

    u_time = Float32(0)
    while not window.should_close():
        glfw.poll_events()
        with surface.get_current_texture() as surface_tex:
            if (
                surface_tex.status
                != wgpu.SurfaceGetCurrentTextureStatus.success
            ):
                raise Error("failed to get surface tex")
            target_view = surface_tex.texture.create_view(
                {
                    format = surface_tex.texture.get_format(),
                    dimension = wgpu.TextureViewDimension.d2,
                    base_mip_level = 0,
                    mip_level_count = 1,
                    base_array_layer = 0,
                    array_layer_count = 1,
                    aspect = wgpu.TextureAspect.all,
                }
            )
            encoder = device.create_command_encoder({})
            color_attachments = [
                ArcPointer(
                    wgpu.RenderPassColorAttachment(
                        view=target_view,
                        load_op=wgpu.LoadOp.clear,
                        store_op=wgpu.StoreOp.store,
                        clear_value=wgpu.Color(0.9, 0.1, 0.2, 1.0),
                    )
                )
            ]

            queue.write_buffer(
                uniform_buffer,
                0,
                Span[Float32, origin_of(u_time)](
                    ptr=UnsafePointer(to=u_time), length=1
                ),
            )

            rp = encoder.begin_render_pass(
                {color_attachments = color_attachments^}
            )
            rp.set_pipeline(pipeline)
            rp.set_vertex_buffer(0, 0, len(vertex_buffer), vertex_buffer)
            rp.set_bind_group(0, uniform_bind_group, List[UInt32]())
            rp.draw(3, 1, 0, 0)

            command = encoder^.finish()

            queue.submit(command^)
            surface.present()
            u_time += 0.05

    glfw.terminate()
