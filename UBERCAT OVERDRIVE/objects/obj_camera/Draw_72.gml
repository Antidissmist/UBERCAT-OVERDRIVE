

if PAUSED exit;


update_camera();


draw_clear_alpha(c_white,0);


//skybox
gpu_set_ztestenable(false);
gpu_set_texrepeat(true);
shader_set(shd_skybox);
shader_set_uniform_f(shader_get_uniform(shd_skybox,"altitude"),-obj_cat.z);
matrix_set(matrix_world,matrix_build( x,y,z, 0,0,0, 100,100,100));
	vertex_submit(vbuff_moonsphere,pr_trianglelist,startex);
matrix_reset();
shader_reset();
gpu_set_texrepeat(false);
gpu_set_ztestenable(true);
