
//show_debug_overlay(true)

global.show_bboxes = false;
global.show_ui = true;


#region models

vbuff_cat = load_vbuff("cat");
vbuff_cat_jump = load_vbuff("cat_jump");
vbuff_cat_sit = load_vbuff("cat_sit");
vbuff_man_stand = load_vbuff("man_stand");
vbuff_man_step = load_vbuff("man_step");
vbuff_man_air = load_vbuff("man_air");
vbuff_car = load_vbuff("car");
vbuff_jet = load_vbuff("jet");
vbuff_shockwave = load_vbuff("shockwave");
vbuff_moonsphere = load_vbuff("moonsphere");
startex = sprite_get_texture(sp_stars,0);

#endregion


controlshake = 0;
shake = 0;
layer_set_visible(layer_get_id("hideme"),false);


application_surface_draw_enable(false);
gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
gpu_set_alphatestenable(true);
draw_set_font(fnt_kongtext);
gpu_set_tex_mip_enable(mip_on);
//lighting

draw_set_lighting(true);


draw_light_define_direction(1, .25,.15,45, c_white);
draw_light_enable(1,true);

skycol_top = #1a7ae2;
skycol_bottom = #f3ef7d;
cloudy = -75;
clouddist = 400;

drawpoints = 0;
menualph = 0;
menumode = 0;
mouselock = false;
mousedx = 0;
mousedy = 0;


setup_3d_object();



#region camera

x = 10;
y = 10;
z = -10;
vecx = 1; //normalized dir of camera
vecy = 0;
vecz = 0;

pitch = 0;
pitchlimit = 89;
roll = 0;
yaw = 0;
yawscale = .1;
pitchscale = .1;
camdist = 9;

fovmax = 170;
fov_def = 60;
fov = fov_def;
fovtarg = fov;

showed_keys = false;
beenlocked = false;

lock_camera = function() {
	
	mouselock = true;
	
	mousedx = 0;
	mousedy = 0;
	/*var winw = window_get_width();
	var winh = window_get_height();
	winw = round(winw/2)*2;
	winh = round(winh/2)*2;
	window_mouse_set( winw/2, winh/2 );*/
	
	window_mouse_set_locked(true);
	
	
}
unlock_camera = function() {
	mouselock = false;
	mousedx = 0;
	mousedy = 0;
	window_mouse_set_locked(false);
}
lock_camera();


#endregion

#region create world


clouds = vertex_create_buffer();
vertex_begin(clouds,global.vformat);
	vertex_add_floor(clouds,-clouddist,-clouddist,clouddist,clouddist, cloudy,c_white,1);
vertex_end(clouds);
vertex_freeze(clouds);
cloudtex = sprite_get_texture(sp_clouds,0);

//mountaintex = sprite_get_texture(sp_mountaintex,0);
mountains = load_vbuff("mountain");



///make random grass


var col = instance_create_depth(0,0,0,obj_collider_test);
col.sprite_index = sp_map;
col.image_index = 1;


grass = vertex_create_buffer();
vertex_begin(grass,global.vformat);
grasstex = sprite_get_texture(sp_grasses,0);

var px,py,ang,lx,ly;
var b = 1;
var gheight = 1;
repeat(1000) {
	px = random_range(b,256-b);
	py = random_range(b,256-b);
	if position_meeting(px,py,col) && !position_meeting(px,py,obj_solid) {
		ang = random(360);
		lx = lengthdir_x(1,ang);
		ly = lengthdir_y(1,ang);
		px *= 2;
		py *= 2;
		vertex_add_wall(grass, px-lx,py-ly,px+lx,py+ly,0-gheight,0,,,,sp_grasses,irandom(sprite_get_number(sp_grasses)-1));
	}
}

vertex_end(grass);
vertex_freeze(grass);



#endregion