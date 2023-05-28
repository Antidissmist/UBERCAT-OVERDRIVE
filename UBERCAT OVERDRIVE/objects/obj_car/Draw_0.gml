



var ws = (1-squish)*.6+1;



matrix_stack_push(matrix_build(x,y,z, 90,0,zang, ws,ws,squish));
matrix_stack_push(matrix_build(0,0,0, 0,zangdiff,zangdiff, 1,1,1));
matrix_set_top();

var vb = vbuff;
vertex_submit(vb,pr_trianglelist,tex);

with obj_cat {
	if riding==other.id {
		matrix_stack_push(matrix_build(0,6.6,0, 0,0,0, 1,1,1));
		matrix_set_top();
		vertex_submit(vbuff,pr_trianglelist,tex);
		matrix_stack_pop();
	}
}

matrix_stack_pop();
matrix_stack_pop();
matrix_set_top();

