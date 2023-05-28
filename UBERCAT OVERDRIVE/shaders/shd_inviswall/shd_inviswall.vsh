//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

const float scale = 1./8.;

void main()
{
    vec4 object_space_pos = vec4( in_Position.xyz, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
	
	object_space_pos *= scale;
	if (in_Normal.z!=0.0) {
		v_vTexcoord = object_space_pos.xy;
	}
	else if (in_Normal.y!=0.0) {
		v_vTexcoord = object_space_pos.yz;
	}
	else {
		v_vTexcoord = object_space_pos.xz;
	}
}
