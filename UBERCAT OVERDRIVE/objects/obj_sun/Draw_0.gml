

var xoff = 250;
var yoff = 0;
var pdir = point_direction(0,0,xoff,yoff)+90;

matrix_stack_push(matrix_build(
	obj_camera.x,obj_camera.y,obj_camera.z,
	0,0,0,
	1,1,1
));
matrix_stack_push(matrix_build(
	xoff,yoff,-100, 90+10,0,pdir, 1,1,1
));

matrix_set_top();
var sc = .6;
draw_sprite_ext(sprite_index,image_index, 0,0, sc,sc, 0,c_white,1);

matrix_stack_pop();
matrix_stack_pop();
matrix_set_top();