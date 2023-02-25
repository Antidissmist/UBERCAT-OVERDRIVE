

//var d = point_direction(x,y,obj_camera.x,obj_camera.y)-90//current_time/10;
var yaw = obj_camera.yaw;
var pitch = obj_camera.pitch;
var v = point_distance_3d(0,0,0, obj_cat.xsp,obj_cat.ysp,obj_cat.zsp);
if v<1 {
	instance_destroy();
}


var pdir = point_direction_3d(0,0,0, obj_cat.xsp,obj_cat.ysp,obj_cat.zsp);
yaw = pdir[0];
pitch = pdir[1];


var sc = scale;

matrix_stack_push(matrix_build(x,y,z, 0,0,yaw, sc,sc,sc));
matrix_stack_push(matrix_build(0,0,0, 0,pitch,0, 1,1,1));
matrix_set_top();
	draw_sprite_ext(sprite_index,image_index,0,0, sc*image_xscale,sc*image_yscale, ang, c_white,1);
matrix_stack_pop();
matrix_stack_pop();
matrix_set_top();

