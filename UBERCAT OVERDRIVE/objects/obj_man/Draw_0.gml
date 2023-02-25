

var tx = tex;
var walkind = floor(walktimer/12 % 4);
var stepup = walktimer>0 && (walkind==0 || walkind==2);
var xscale = 1;
if !grounded {
	stepup = 0;
}
if walkind == 2 {
	xscale = -1;
	tx = tex_flip;
}

var ws = (1-squish)*.6+1;


matrix_stack_push(matrix_build(x,y,z-stepup/3, 90,0,zang, ws,ws,squish));
matrix_stack_push(matrix_build(0,0,0, 0,0,0, xscale,1,1));
matrix_set_top();

if grounded || scarelevel<=0 {
	if walktimer>0 {
		vertex_submit(anim_walk[walkind],pr_trianglelist,tx);
	}
	//standing
	else {
		vertex_submit(vbuff,pr_trianglelist,tx);
	}
}
else {
	tx = tex_scared;
	vertex_submit(vbuff_air,pr_trianglelist,tx);
}

matrix_stack_pop();
matrix_stack_pop();
matrix_set_top();
