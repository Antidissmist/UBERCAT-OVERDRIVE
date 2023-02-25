

var sx = 0;
var sy = 0;
var sz = 0;
if obj_cat.won {
	var s = 1;
	sx = random_range(-s,s);
	sy = random_range(-s,s);
	sz = random_range(-s,s);
}


gpu_set_texrepeat(true);
matrix_set(matrix_world,matrix_build( x+sx,y+sy,z+sz, 0,0,0, scale,scale,scale ));
	vertex_submit(vbuff,pr_trianglelist,tex);
matrix_reset();
gpu_set_texrepeat(false);
