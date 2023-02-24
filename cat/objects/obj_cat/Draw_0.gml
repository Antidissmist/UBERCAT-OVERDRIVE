

if global.show_bboxes {
	draw_self();
}


var walkind = floor(walktimer/12 % 4);
if walklevel==1 {
	walkind = floor(walktimer/8 % 4);
}
var stepup = walktimer>0 && (walkind==0 || walkind==2);
if !grounded {
	stepup = 0;
}


var sx = random_range(-shake,shake);
var sy = random_range(-shake,shake);
var sz = random_range(-shake,shake);
var wsquish = (1-squish)*.6+1;
matrix_stack_push(matrix_build( x+sx,y+sy,z+sz-stepup/3, 90,0,zang+90, wsquish,wsquish,squish));
matrix_set_top();

//walking
if walktimer>0 && grounded {
	vertex_submit(anim_walk[walkind],pr_trianglelist,tex);
}
//standing
else {
	vertex_submit(vbuff,pr_trianglelist,tex);
}

if meowtimer>0 {
	var sc = 1/100;
	matrix_stack_push(matrix_build(0,0,0, 0,90,0, sc,sc,sc));
	matrix_set_top();
	
	draw_sprite(sp_meow,meowind,0,0);
	
	matrix_stack_pop();
}

matrix_stack_pop();
matrix_set_top();


