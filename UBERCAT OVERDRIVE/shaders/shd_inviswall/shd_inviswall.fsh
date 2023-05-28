//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 incol = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 col = incol;
	
	col.a = (gl_FragCoord.w*4.);
	
	if (col.a<=0.1 || incol.a<=0.1) {
		discard;
	}
	
    gl_FragColor = col;
}
