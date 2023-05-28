


#macro CAM view_camera[0]
#macro vw camera_get_view_width(CAM)
#macro vh camera_get_view_height(CAM)
#macro gw display_get_gui_width()
#macro gh display_get_gui_height()

#macro alen array_length
#macro dsize ds_list_size

#macro dc draw_set_color
#macro da draw_set_alpha

#macro log show_debug_message

#macro PLAYERDIR point_direction(x,y,obj_cat.x,obj_cat.y)
#macro PLAYERDIST point_distance(x,y,obj_cat.x,obj_cat.y)
#macro PLAYERDIST3D point_distance_3d(x,y,z,obj_cat.x,obj_cat.y,obj_cat.z)
#macro image_randomize image_index=irandom(image_number-1)

function matrix_reset() {
	static mat = matrix_build_identity();
	matrix_set(matrix_world,mat);
}
function matrix_set_top() {
	matrix_set(matrix_world,matrix_stack_top());
}
function lerp_angle(a,targ,amt) {
	return a+angle_difference(targ,a)*amt;
}

global.mapscale = 2;
#macro MAPSCALE global.mapscale
function scaletoroom() {
	var sc = MAPSCALE;
	x *= sc;
	y *= sc;
	image_xscale *= sc;
	image_yscale *= sc;
}
function scalepostoroom() {
	var sc = MAPSCALE;
	x *= sc;
	y *= sc;
}

function putonbuildings() {
	
	var list = instplacelist;
	ds_list_clear(list);
	instance_place_list(x,y,obj_solid,list,false);
	instance_place_list(x,y,obj_house,list,false);
	instance_place_list(x,y,obj_house2,list,false);
	instance_place_list(x,y,obj_house3,list,false);
	
	
	for(var i=0; i<dsize(list); i++) {
		var el = list[| i];
		zstart = min(zstart, el.z-el.height );
	}
	
	z = zstart+.01;
	
	
}

function interval(n) {
	if PAUSED {
		return false;
	}
	return (floor(cur_time/100) % n) == 0;
}

function path_getx(pt,perc) {
	return path_get_x(pt,perc)*global.mapscale;
}
function path_gety(pt,perc) {
	return path_get_y(pt,perc)*global.mapscale;
}

function object_in_room(inst=id) {
	return point_in_rectangle(inst.x,inst.y,0,0,room_width,room_height);
}


function draw_bbox() {
	draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,true)
}


function draw_center(h=false,v=false) {
	draw_set_halign(h ? fa_center : fa_left);
	draw_set_valign(v ? fa_middle : fa_top);
}
function announce(text) {
	var p = instance_create_depth(0,0,0,obj_announcer);
	p.text = text;
	return p;
}
function collectnum(text) {
	var p = instance_create_depth(0,0,0,obj_collectnumber);
	p.text = string(text);
	return p;
}



function dtext(x,y,str,sc=2,alph=1,c=c_white) {
	draw_text_transformed_color(x,y,str,sc,sc, 0, c,c,c,c,alph);
}
function dtext_outlined(x,y,str,sc=2,alph=1,color=c_white) {
	
	var c = c_black;
	var s = sc*2;
	draw_text_transformed_color(x-s,y,str,sc,sc, 0, c,c,c,c,alph);
	draw_text_transformed_color(x+s,y,str,sc,sc, 0, c,c,c,c,alph);
	draw_text_transformed_color(x,y-s,str,sc,sc, 0, c,c,c,c,alph);
	draw_text_transformed_color(x,y+s,str,sc,sc, 0, c,c,c,c,alph);
	c = color;
	draw_text_transformed_color(x,y,str,sc,sc, 0, c,c,c,c,alph);
}




function instance_create(_x,_y,_z,obj) {
	var p = instance_create_depth(_x,_y,0,obj);
	p.z = _z;
	return p;
}




