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

    var surface_capabilities = surface.get_capabilities(adapter)

    # Copy the first format from capabilities before the struct is destroyed
    var formats = surface_capabilities.formats()
    surface_format = (
        formats[0] if len(formats) > 0 else wgpu.TextureFormat.bgra8_unorm
    )

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
            @location(0) color: vec4<f32>,
        };

        @vertex
        fn vs_main(@location(0) in_pos: vec3<f32>, @location(1) in_color: vec4<f32>) -> VertexOutput {
            var p = in_pos;
            return VertexOutput(vec4<f32>(p, 1.0), in_color);
        }

        @fragment
        fn fs_main(@location(0) in_color: vec4<f32>) -> @location(0) vec4<f32> {
            let t = cos(time * 0.1) * 0.5 + 0.5;
            let color = in_color + vec4<f32>(t, t, t, 1.0);
            return color;
        }
        """

    shader_module = device.create_wgsl_shader_module(code=shader_code)

    var vertex_attributes = [
        VertexAttribute(
            format=VertexFormat.float32x3, offset=0, shader_location=0
        ),
        VertexAttribute(
            format=VertexFormat.float32x4,
            offset=size_of[Vec3](),
            shader_location=1,
        ),
    ]

    var vertex_buffer_layouts = [
        VertexBufferLayout(
            array_stride=size_of[MyVertex](),
            step_mode=VertexStepMode.vertex,
            attributes=vertex_attributes^,
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
    var bg_layout = ArcPointer(
        device.create_bind_group_layout(
            {
                "bind group layout",
                bind_group_entries,
            }
        )
    )
    # var bg_layout_ptr = ArcPointer(bg_layout^)

    var bind_group_layouts: List[ArcPointer[BindGroupLayout]] = [bg_layout]

    pipeline_layout = device.create_pipeline_layout(
        {
            "pipeline layout",
            Span(bind_group_layouts),
        }
    )

    uniform_buffer = device.create_buffer[Float32](
        {
            "uniform buffer",
            BufferUsage.uniform | BufferUsage.copy_dst,
            size_of[Float32](),
            True,  # Don't map at creation since we'll use write_buffer
        }
    )
    with uniform_buffer.get_mapped_range[Float32](
        0, size_of[Float32]()
    ) as uniform_host:
        uniform_host[0] = 0
    uniform_bind_group_entries = [
        BindGroupEntry(0, BufferBinding(uniform_buffer, 0, size_of[Float32]()))
    ]
    uniform_bind_group = device.create_bind_group(
        {
            "bind group",
            bg_layout,
            uniform_bind_group_entries,
        }
    )
    var targets = [
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

    var fragment_state = wgpu.FragmentState(
        module=shader_module,
        entry_point="fs_main",
        targets=Span(targets),
    )

    pipeline = device.create_render_pipeline(
        {
            label = "render pipeline",
            vertex = wgpu.VertexState(
                entry_point="vs_main",
                module=shader_module,
                buffers=Span(vertex_buffer_layouts).get_immutable(),
            ),
            fragment = fragment_state^,
            primitive = wgpu.PrimitiveState(
                topology=wgpu.PrimitiveTopology.triangle_list,
            ),
            multisample = wgpu.MultisampleState(),
            layout = Pointer(to=pipeline_layout).get_immutable(),
            depth_stencil = None,
        }
    )

    vertices: List[MyVertex] = [
        {Vec3(-0.5, -0.5, 0.0), MyColor(1, 0, 0, 1)},
        {Vec3(0.5, -0.5, 0.0), MyColor(0, 1, 0, 1)},
        {Vec3(0.0, 0.5, 0.0), MyColor(0, 0, 1, 1)},
    ]
    vertex_buffer = device.create_buffer[MyVertex](
        {
            "vertex buffer",
            BufferUsage.vertex,
            len(vertices) * size_of[MyVertex](),
            True,
        }
    )
    with vertex_buffer.get_mapped_range[MyVertex](
        0, len(vertices) * size_of[MyVertex]()
    ) as vertex_host:
        for i in range(len(vertex_host)):
            vertex_host[i] = vertices[i]

    u_time = Float32(0)
    while not window.should_close():
        glfw.poll_events()
        with surface.get_current_texture() as surface_tex:
            var target_view = surface_tex.texture.create_view(
                {
                    format = surface_format,  # Use the format we set during surface configuration
                    dimension = wgpu.TextureViewDimension.d2,
                    base_mip_level = 0,
                    mip_level_count = 1,
                    base_array_layer = 0,
                    array_layer_count = 1,
                    aspect = wgpu.TextureAspect.all,
                }
            )
            var encoder = device.create_command_encoder({})

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
                Span[UInt8, origin_of(u_time)](
                    ptr=UnsafePointer(to=u_time).bitcast[UInt8](),
                    length=size_of[Float32](),
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

            queue.submit(command)
            surface.present()
            u_time += 0.05

    glfw.terminate()
