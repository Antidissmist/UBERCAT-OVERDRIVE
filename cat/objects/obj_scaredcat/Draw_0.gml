



var ws = (1-squish)*.6+1;


matrix_set(matrix_world,matrix_build(x,y,z, 90,0,zang, ws,ws,squish));

var vb = grounded ? vbuff : vbuff_jump;
vb = dropped ? vb : vbuff_sit;
vertex_submit(vb,pr_trianglelist,tex);

matrix_reset();

