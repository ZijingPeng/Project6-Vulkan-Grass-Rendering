#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(vertices = 1) out;

layout(set = 0, binding = 0) uniform CameraBufferObject {
    mat4 view;
    mat4 proj;
} camera;

// Declare tessellation control shader inputs and outputs
layout (location = 0) in vec4[] tesc_v0;
layout (location = 1) in vec4[] tesc_v1;
layout (location = 2) in vec4[] tesc_v2;
layout (location = 3) in vec4[] tesc_up;

layout(location = 0) out vec4[] tese_v0;
layout(location = 1) out vec4[] tese_v1;
layout(location = 2) out vec4[] tese_v2;
layout(location = 3) out vec4[] tese_up;

void main() {
	// Don't move the origin location of the patch
    gl_out[gl_InvocationID].gl_Position = gl_in[gl_InvocationID].gl_Position;

    tese_v0[gl_InvocationID] = tesc_v0[gl_InvocationID];
	tese_v1[gl_InvocationID] = tesc_v1[gl_InvocationID];
    tese_v2[gl_InvocationID] = tesc_v2[gl_InvocationID];
    tese_up[gl_InvocationID] = tesc_up[gl_InvocationID];

    vec3 viewPos = (inverse(camera.view) * vec4(0, 0, 0, 1)).xyz;
    vec3 viewDir = tesc_v0[gl_InvocationID].xyz - viewPos;
    const float MAX_DISTANCE = 20.0;
    int level = int(mix(1.0, 5.0, max(0, 1.0 - length(viewDir) / MAX_DISTANCE)));

	//  Set level of tesselation
    gl_TessLevelInner[0] = 1;
    gl_TessLevelInner[1] = level;
    gl_TessLevelOuter[0] = level;
    gl_TessLevelOuter[1] = 1;
    gl_TessLevelOuter[2] = level;
    gl_TessLevelOuter[3] = 1;
}
