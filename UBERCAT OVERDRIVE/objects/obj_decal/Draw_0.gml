


if lifetimer>30 || (floor(cur_time/30) % 2 == 0) {


	var sc = scale;

	matrix_set(matrix_world,matrix_build(x,y,z-.01, 0,0,0, sc,sc,-sc));
	draw_sprite_ext(sprite_index,image_index,0,0, 1,1, ang,c_white,1);
	matrix_reset();


}