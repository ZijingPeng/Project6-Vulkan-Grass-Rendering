#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(quads, equal_spacing, ccw) in;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// tessellation evaluation shader inputs and outputs
layout (location = 0) in vec4[] tese_v0;
layout (location = 1) in vec4[] tese_v1;
layout (location = 2) in vec4[] tese_v2;
layout (location = 3) in vec4[] tese_up;

layout (location = 0) out vec4 fs_normal;

void main() {
    float u = gl_TessCoord.x;
    float v = gl_TessCoord.y;

    vec3 input_pos = vec3(gl_in[0].gl_Position);

	// Use u and v to parameterize along the grass blade and output positions for each vertex of the grass blade
    mat4 viewProj = camera.proj * camera.view;

    vec3 v0 =  tese_v0[0].xyz;
    vec3 v1 =  tese_v1[0].xyz;
    vec3 v2 =  tese_v2[0].xyz;
    vec3 up =  tese_up[0].xyz;

    float w = tese_v2[0].w;
    float direction = tese_v0[0].w;
    vec3 t1 = vec3(cos(direction), 0.0, sin(direction));

    vec3 a = v0 + v * (v1 - v0);
    vec3 b = v1 + v * (v2 - v1);
    vec3 c = a + v * (b - a);
    vec3 c0 = c - w * t1;
    vec3 c1 = c + w * t1;

    fs_normal = vec4(cross(up, t1), v);
    
    float t = u + 0.5 * v - u * v;

    //t = u;

    vec3 position = (1.0 - t) * c0 + t * c1;

    gl_Position = viewProj * vec4(input_pos + position, 1.0);
}
