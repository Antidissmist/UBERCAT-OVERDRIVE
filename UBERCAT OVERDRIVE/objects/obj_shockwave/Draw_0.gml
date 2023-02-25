

dc(c_white);
matrix_set(matrix_world,matrix_build( x,y,z, 90,0,zang, scalew*scalescale,scalew*scalescale,scalez*scalescale ));
	vertex_submit(vbuff,pr_trianglelist,-1);
matrix_reset();

