
//var d = point_direction(x,y,obj_camera.x,obj_camera.y)-90//current_time/10;
var sc = scale;

matrix_set(matrix_world,matrix_build(x,y,z, 00,0,0, sc,sc,-sc));
draw_sprite_ext(sprite_index,image_index,0,0, sc*image_xscale,sc*image_yscale, ang, c_white,1);
matrix_reset();