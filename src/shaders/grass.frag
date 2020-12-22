#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

layout (location = 0) in vec4 fs_normal;

layout(location = 0) out vec4 outColor;

void main() {
    // TODO: Compute fragment color
    vec3 lightDir = vec3(0.5, -0.7, 0.5);
    float cosTheta = dot(lightDir, fs_normal.xyz);
    cosTheta = mix(0.7, 1.0, cosTheta);

    outColor = vec4(0.773, 0.984, 0.477, 1.0) * cosTheta;
}
