
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 1, binding = 0) uniform ModelBufferObject {
    mat4 model;
};

layout (location = 0) in vec4 vs_v0;
layout (location = 1) in vec4 vs_v1;
layout (location = 2) in vec4 vs_v2;
layout (location = 3) in vec4 vs_up;

layout(location = 0) out vec4 tesc_v0;
layout(location = 1) out vec4 tesc_v1;
layout(location = 2) out vec4 tesc_v2;
layout(location = 3) out vec4 tesc_up;

out gl_PerVertex {
    vec4 gl_Position;
};

void main() {
    tesc_v0 = model * vec4(vs_v0.xyz, 1.0);
    tesc_v0.w = vs_v0.w;
    tesc_v1 = model * vec4(vs_v1.xyz, 1.0);
    tesc_v1.w = vs_v1.w;
    tesc_v2 = model * vec4(vs_v2.xyz, 1.0);
    tesc_v2.w = vs_v2.w;
    tesc_up = model * vec4(vs_up.xyz, 1.0);
    tesc_up.w = vs_up.w;
    gl_Position = vec4(tesc_v0.xyz, 1.0);
}
