//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.xyz, 1.0);
	
	mat4 worldview = gm_Matrices[MATRIX_WORLD_VIEW];
	worldview[0][0] = 1.0;
	worldview[0][1] = 0.0;
	worldview[0][2] = 0.0;
	
	worldview[1][0] = 0.0;
	worldview[1][1] = 1.0;
	worldview[1][2] = 0.0;
	
	worldview[2][0] = 0.0;
	worldview[2][1] = 0.0;
	worldview[2][2] = 1.0;
	
	
	
    gl_Position = (gm_Matrices[MATRIX_PROJECTION]) * (worldview * object_space_pos);
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}
