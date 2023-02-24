//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

uniform float altitude;

varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying float spacepercent;


const vec3 high_top = vec3(0.);
const vec3 high_bottom = vec3(0.125,0.357,0.784);
const vec3 low_top = vec3(0.392,0.769,1.);
const vec3 low_bottom = vec3(0.208,0.886,0.855);




void main()
{
    vec4 object_space_pos = vec4( in_Position.xyz, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
	float spherepercent = clamp(object_space_pos.z/4., -.5,1.5);
	vec3 highcol = mix( high_top,high_bottom, spherepercent );
	vec3 lowcol = mix( low_top,low_bottom, spherepercent );
	
	float skypercent = clamp((altitude-70.)/300., 0.,1.);
	
	vec3 outcol = mix( lowcol,highcol, skypercent );
	
    v_vColour = vec4(outcol,1.0);
    v_vTexcoord = in_TextureCoord;
	spacepercent = skypercent;
}
