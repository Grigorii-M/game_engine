struct VertexInput {
    @location(0) position: vec3<f32>,
    @location(1) color: vec4<f32>,
}

struct InstanceInput {
    @location(2) matrix_part_0: vec4<f32>,
    @location(3) matrix_part_1: vec4<f32>,
    @location(4) matrix_part_2: vec4<f32>,
    @location(5) matrix_part_3: vec4<f32>,
}

struct CameraUniform {
    position: vec3<f32>,
    view_proj: mat4x4<f32>,
}

@group(0) @binding(0) var<uniform> camera: CameraUniform;

struct VertexOutput {
    @builtin(position) clip_position: vec4<f32>,
    @location(0) color: vec4<f32>,
}

@vertex
fn vs_main(in: VertexInput, instance: InstanceInput) -> VertexOutput {
    let instance_matrix = mat4x4<f32>(
        instance.matrix_part_0,
        instance.matrix_part_1,
        instance.matrix_part_2,
        instance.matrix_part_3
    );
    let world_position: vec4<f32> = instance_matrix * vec4<f32>(in.position, 1.0);

    var out: VertexOutput;
    out.clip_position = camera.view_proj * world_position;
    out.color = in.color;
    return out;
}