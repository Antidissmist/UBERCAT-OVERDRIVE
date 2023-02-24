
//show_debug_overlay(true)

global.show_bboxes = false;


#region models

vbuff_cat = load_vbuff("cat");
vbuff_cat_jump = load_vbuff("cat_jump");
vbuff_cat_sit = load_vbuff("cat_sit");
vbuff_man_stand = load_vbuff("man_stand");
vbuff_man_step = load_vbuff("man_step");
vbuff_man_air = load_vbuff("man_air");
vbuff_car = load_vbuff("car");

#endregion


shake = 0;
layer_set_visible(layer_get_id("hideme"),false);


application_surface_draw_enable(false);
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);
draw_set_font(fnt_kongtext);
//lighting

draw_set_lighting(true);


draw_light_define_direction(1, .25,.15,45, c_white);
draw_light_enable(1,true);

skycol_top = #1a7ae2;
skycol_bottom = #f3ef7d;
cloudy = -75;
clouddist = 400;

mouselock = false;
mousex = 0;
mousey = 0;
mxprev = 0;
myprev = 0;
mousedx = 0;
mousedy = 0;


setup_3d_object();

x = 10;
y = 10;
z = -10;

pitch = 0;
pitchlimit = 89;
roll = 0;
yaw = 0;
yawscale = .1;
pitchscale = .1;
camdist = 9;
fov = 60;

#region create world

ground = vertex_create_buffer();
vertex_begin(ground,global.vformat);

var size = 10;
var step = 10;
for(var xx=-size/2; xx<size; xx++) {
	for(var yy=-size/2; yy<size; yy++) {
		vertex_add_floor(ground,
			xx*step,
			yy*step,
			xx*step+step,
			yy*step+step,0,
			make_color_hsv(93+random_range(-5,5),random_range(100,255),random_range(100,255))
			,1);
	}
}


vertex_end(ground);
vertex_freeze(ground);



clouds = vertex_create_buffer();
vertex_begin(clouds,global.vformat);
	vertex_add_floor(clouds,-clouddist,-clouddist,clouddist,clouddist, cloudy,c_white,1);
vertex_end(clouds);
vertex_freeze(clouds);
cloudtex = sprite_get_texture(sp_clouds,0);

#endregion