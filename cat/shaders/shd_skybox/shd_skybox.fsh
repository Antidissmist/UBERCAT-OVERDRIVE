//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying float spacepercent;

void main()
{
    gl_FragColor = v_vColour + texture2D( gm_BaseTexture, v_vTexcoord*4. ).a*spacepercent;
}
