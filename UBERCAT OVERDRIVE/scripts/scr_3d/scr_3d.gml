



#region vertex stuff

vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_texcoord();
	vertex_format_add_color();
global.vformat = vertex_format_end();

function vertex_add_point(vbuff,xx,yy,zz, nx,ny,nz, utex,vtex, color=c_white, alpha=1) {
	vertex_position_3d(vbuff, xx, yy, zz);
	vertex_normal(vbuff, nx, ny, nz);
	vertex_texcoord(vbuff, utex, vtex);
	vertex_color(vbuff, color, alpha);
}
function vertex_add_floor(vbuff, x1,y1,x2,y2, z, color=c_white,alpha=1) {
	var nx = 0;
	var ny = 0;
	var nz = -1;
	vertex_add_point(vbuff, x1,y1,z, nx,ny,nz, 0,0, color,alpha);
	vertex_add_point(vbuff, x1,y2,z, nx,ny,nz, 0,1, color,alpha);
	vertex_add_point(vbuff, x2,y2,z, nx,ny,nz, 1,1, color,alpha);
	
	vertex_add_point(vbuff, x1,y1,z, nx,ny,nz, 0,0, color,alpha);
	vertex_add_point(vbuff, x2,y1,z, nx,ny,nz, 1,0, color,alpha);
	vertex_add_point(vbuff, x2,y2,z, nx,ny,nz, 1,1, color,alpha);
}


function vertex_add_wall(vbuff, x1,y1,x2,y2, z1,z2, color=c_white,alpha=1,flipnorm=0,sprite=-1,spind=0) { //jank
	var nx = !flipnorm; //x direction
	var ny = flipnorm; //y direction
	var nz = 0;
	
	var ux1 = 0;
	var uy1 = 0;
	var ux2 = 1;
	var uy2 = 1;
	if sprite_exists(sprite) {
		var u = sprite_get_uvs(sprite,spind);
		ux1 = u[0]
		uy1 = u[1];
		ux2 = u[2];
		uy2 = u[3];
	}
	
	vertex_add_point(vbuff, x1,y1,z1, nx,ny,nz, ux1,uy1, color,alpha);
	vertex_add_point(vbuff, x2,y2,z1, nx,ny,nz, ux2,uy1, color,alpha);
	vertex_add_point(vbuff, x1,y1,z2, nx,ny,nz, ux1,uy2, color,alpha);
	
	vertex_add_point(vbuff, x2,y2,z1, nx,ny,nz, ux2,uy1, color,alpha);
	vertex_add_point(vbuff, x2,y2,z2, nx,ny,nz, ux2,uy2, color,alpha);
	vertex_add_point(vbuff, x1,y1,z2, nx,ny,nz, ux1,uy2, color,alpha);
	
}


function vertex_add_box(vbuff, x,y,z, size, height, color=c_white,alpha=1) {
	vertex_add_floor(vbuff,x-size,y-size,x+size,y+size,z, color,alpha);//bottom
	vertex_add_floor(vbuff,x-size,y-size,x+size,y+size,z-height, color,alpha);//top
	
	vertex_add_wall(vbuff,x-size,y-size,x+size,y-size,z-height,z, color,alpha);
	vertex_add_wall(vbuff,x-size,y+size,x+size,y+size,z-height,z, color,alpha);
	
	vertex_add_wall(vbuff,x-size,y-size,x-size,y+size,z-height,z, color,alpha,1);
	vertex_add_wall(vbuff,x+size,y-size,x+size,y+size,z-height,z, color,alpha,1);
	
}
function vertex_add_box_wh(vbuff, x,y,z, xsize,ysize, height, color=c_white,alpha=1) {
	vertex_add_floor(vbuff,x-xsize,y-ysize,x+xsize,y+ysize,z, color,alpha);//bottom
	vertex_add_floor(vbuff,x-xsize,y-ysize,x+xsize,y+ysize,z-height, color,alpha);//top
	
	vertex_add_wall(vbuff,x-xsize,y-ysize,x+xsize,y-ysize,z-height,z, color,alpha);
	vertex_add_wall(vbuff,x-xsize,y+ysize,x+xsize,y+ysize,z-height,z, color,alpha);
	
	vertex_add_wall(vbuff,x-xsize,y-ysize,x-xsize,y+ysize,z-height,z, color,alpha,1);
	vertex_add_wall(vbuff,x+xsize,y-ysize,x+xsize,y+ysize,z-height,z, color,alpha,1);
	
}
function vertex_add_box_nofloors(vbuff, x,y,z, size, height, color=c_white,alpha=1,sprite=-1) {
	//vertex_add_floor(vbuff,x-size,y-size,x+size,y+size,z, color,alpha);//bottom
	//vertex_add_floor(vbuff,x-size,y-size,x+size,y+size,z-height, color,alpha);//top
	
	vertex_add_wall(vbuff,x-size,y-size,x+size,y-size,z-height,z, color,alpha,,sprite);
	vertex_add_wall(vbuff,x-size,y+size,x+size,y+size,z-height,z, color,alpha,,sprite);
	
	vertex_add_wall(vbuff,x-size,y-size,x-size,y+size,z-height,z, color,alpha,1,sprite);
	vertex_add_wall(vbuff,x+size,y-size,x+size,y+size,z-height,z, color,alpha,1,sprite);
	
}


#endregion



function load_vbuff(fname,format=global.vformat) {
	fname = string_replace(fname,".vbuff","");
	var buff = buffer_load("gamedata/"+fname+".vbuff");
	var m = vertex_create_buffer_from_buffer(buff, format);
	buffer_delete(buff);
	return m;
}
function setup_3d_object() {
	//x = x; //position
	//y = y;
	if !variable_instance_exists(id,"z") {
		z = 0;
	}
	zstart = z;
	xsp = 0; //speed
	ysp = 0;
	zsp = 0;
	if !variable_instance_exists(id,"height") {
		height = 1; //collision
	}
	blowaway = false; //for flying outta the map
	blowx = x;
	blowy = y;
	blowawayspeed = 4;
	yeettimer = 0;
	onground = function(){
		//
	}
	collides = true;
}
function draw_bbox_3d(scale=1,mode=0) {
	//worst possible way you could do this
	

	if mode==0 {
		var x1 = x-(x-bbox_left)/scale;
		var y1 = y-(y-bbox_top)/scale;
		var x2 = x-(x-bbox_right)/scale;
		var y2 = y-(y-bbox_bottom)/scale;
	
	
		//var x1 = bbox_left;
		//var y1 = bbox_top;
		//var x2 = bbox_right;
		//var y2 = bbox_bottom;
		var z1 = z;
		var z2 = z-height;
	
		//base
		draw_line_3d(x1,y1,z1, x2,y1,z1);
		draw_line_3d(x1,y1,z1, x1,y2,z1);
		draw_line_3d(x1,y2,z1, x2,y2,z1);
		draw_line_3d(x2,y1,z1, x2,y2,z1);
	
		//top
		draw_line_3d(x1,y1,z2, x2,y1,z2);
		draw_line_3d(x1,y1,z2, x1,y2,z2);
		draw_line_3d(x1,y2,z2, x2,y2,z2);
		draw_line_3d(x2,y1,z2, x2,y2,z2);
	
		//edges
		draw_line_3d(x1,y1,z1, x1,y1,z2);
		draw_line_3d(x2,y1,z1, x2,y1,z2);
		draw_line_3d(x1,y2,z1, x1,y2,z2);
		draw_line_3d(x2,y2,z1, x2,y2,z2);
	}
	
	//use sprite
	else if mode==1 {
		
		var zstep = .1;
		for(var zz=0; zz<height; zz+=zstep;) {
			matrix_set(matrix_world,matrix_build(x,y,z-zz, 0,0,0, 1,1,1));
			draw_sprite_ext(sprite_index,0,0,0, image_xscale,image_yscale,image_angle,c_white,.1);
		}
		gpu_set_cullmode(cull_noculling);
	}
}
function yeet(inst=id) {
	audio_play_sound(snd_explosion2,0,false);
	screenshake(2);
	with inst {
		if !blowaway {
			blowaway = true;
			blowx = obj_cat.x;
			blowy = obj_cat.y;
			collides = false;
		}
	}
}
function get_yeet() {
	if blowaway {
		yeettimer++
		blowawayspeed += .2;
		var bdir = point_direction(blowx,blowy,x,y);
		var bsp = blowawayspeed;
		x += lengthdir_x(bsp,bdir);
		y += lengthdir_y(bsp,bdir);
		z -= bsp/2;
		
		xsp = 0;
		ysp = 0;
		zsp = 0;
		
		particle_create(x,y,z,sp_yeet_trail);
		
		
		if !object_in_room() && yeettimer>100 {
			
			var p;
			var v;
			repeat(10) {
				p = particle_create(x,y,z,sp_yeet_trail);
				v = random_range(.5,.7);
				p.scale = random_range(3,6);
				p.xsp = random_range(-v,v);
				p.ysp = random_range(-v,v);
				p.zsp = random_range(-v,v);
				p.image_index = irandom(2);
				p.image_speed = random_range(.8,1.1);
			}
			screenshake(.25);
			
			audio_play_sound(snd_distantboom,0,false);
			
			instance_destroy();
		}
	}
}


function point_direction_3d( x1,y1,z1, x2,y2,z2 ) {
	
	/// [yaw, pitch]
	/*
	return [
		radtodeg(arctan2(xx,yy))+180,
		//point_direction(0,0,xx,yy),
		radtodeg(arcsin(-clamp(zz,-1,1)))
	];*/
	
	
	var len = point_distance_3d(x1,y1,z1,x2,y2,z2);
	var normal_z = (z2-z1) / len;
	var yaw = point_direction(x1,y1,x2,y2)
	try { //bruh
		var pitch = darcsin(clamp(normal_z,-1,1));
	}
	catch(e) {
		//log(e);
		var pitch = 0;
	}

	return [yaw,pitch];
	
}
function draw_line_3d(x1,y1,z1,x2,y2,z2) {
	
	
	var len = point_distance_3d(x1,y1,z1,x2,y2,z2);
	var pdir = point_direction_3d(x1,y1,z1,x2,y2,z2);
	var yaw = pdir[0];
	var pitch = pdir[1];



	matrix_stack_push(matrix_build(x1,y1,z1, 0,0,yaw, 1,1,1));
	matrix_stack_push(matrix_build(0,0,0, 0,pitch,0, 1,1,1));
	matrix_set_top();
		draw_sprite_ext(sp_wireframeline,0,0,0, len,1/20, 0, c_white,1);
	matrix_stack_pop();
	matrix_stack_pop();
	matrix_set_top();
	
}



/////camera
function update_camera() {
	with obj_camera {
		
		var targ = obj_cat;
		var state = targ.state;
		
		var xto = targ.x	+random_range(-shake,shake);
		var yto = targ.y	+random_range(-shake,shake);
		var zto = targ.z	+random_range(-shake,shake);
		
		if state=="walking" {
			zto -= 2;
			pitch = max(pitch,-15);
		}
		else if state=="flying" {
			
		}
		
		
		var plx = lengthdir_x(1,pitch);
		var ply = lengthdir_x(1,pitch);
		
		
		if obj_cat.won {
			camdist += .17;
			camdist = min(camdist,50);
		}
		
		var cdist = camdist;
		do {
			x = xto+lengthdir_x(cdist,yaw) *plx;
			y = yto+lengthdir_y(cdist,yaw) *ply;
			z = zto+lengthdir_y(cdist,pitch);
			cdist -= .25;
		} until ( (!position_solid(x,y,z) && z<-0.15) || cdist<=.5 );
		
		
		//camera direction vector
		vecx = -lengthdir_x(1,yaw) *plx;
		vecy = -lengthdir_y(1,yaw) *ply;
		vecz = -lengthdir_y(1,pitch);
		
		var vmat = matrix_build_lookat(x,y,z, xto,yto,zto, 0,0,1);
		var pmat = matrix_build_projection_perspective_fov(fov,vw/vh, .01,3200);
		
		camera_set_view_mat(CAM,vmat);
		camera_set_proj_mat(CAM,pmat);
		camera_apply(CAM);
		
		
		audio_listener_position(x,y,z);
		audio_listener_orientation(xto-x,yto-y,zto-z, 0,0,-1);
		audio_listener_velocity(obj_cat.xsp*global.listener_speedmult,obj_cat.ysp*global.listener_speedmult,obj_cat.zsp*global.listener_speedmult);
		
	}
}
function screenshake(amt=1) {
	obj_camera.shake = max(amt,obj_camera.shake);
}


//collision




function move3d() {
	
	
	if !place_solid(x+xsp,y,z) {
		x += xsp;
	}
	else {
		var s = sign(xsp)*.1;
		while !place_solid(x+s,y,z) {
			x += s;
		}
		xsp = 0;
	}
	if !place_solid(x,y+ysp,z) {
		y += ysp;
	}
	else {
		var s = sign(ysp)*.1;
		while !place_solid(x,y+s,z) {
			y += s;
		}
		ysp = 0;
	}
	
	if !place_solid(x,y,z+zsp) {
		z += zsp;
	}
	else {
		var s = sign(zsp)*.1;
		while !place_solid(x,y,z+s) {
			z += s;
		}
		zsp = 0;
	}
	var gcheck = place_solid(x,y,z+.1);
	if gcheck {
		if !grounded && zsp>=0 {
			grounded = true;
			onground();
		}
	}
	else {
		grounded = false;
	}
	/*if grounded && zsp>=0 {
		while !place_solid(x,y,z+.1) {
			z += .1;
		}
	}*/
	
	
	/*
	if mode==0 {
		if !(place_solid(x,y,z+zsp) || z+zsp>=0) {
			z += zsp;
		}
		else {
			while !(place_solid(x,y,z+zsp) || z+zsp>=0) {
				z += sign(zsp)/4;
			}
			if z+zsp>=0 {
				z = 0;
			}
			zsp = 0;
			//onground();
		}
	}
	else {
		if !(place_solid(x,y,z+zsp) || z+zsp>=0) {
			z += zsp;
		}
		else {
			while !(place_solid(x,y,z+zsp) || z+zsp>=0) {
				z += sign(zsp)/4;
			}
			if z+zsp>=0 {
				z = 0;
			}
			zsp = 0;
			//onground();
			//grounded = true;
		}
	}
	*/
	
	
}




function win_game() {
	with obj_cat {
		won = true;
	}
	if global.speedrun_timer && global.speedrun.running {
		global.speedrun.finish = cur_time;
		global.speedrun.running = false;
	}
}

function num_label(val,total,dec) {
	return string_replace_all(string_format(val,total,dec)," ","0");
}
function numbertimelabel(mstime) {
	
	var totalseconds = mstime/1000;
	var seconds = floor(totalseconds % 60);
	var minutes = floor(totalseconds div 60);
	var ms = floor(totalseconds*1000 % 1000);
	
	// M:SS.MMM
	return num_label(minutes,2,0)+":"+num_label(seconds,2,0)+"."+num_label(ms/10,2,0);
}



global._instplacelist = ds_list_create();
#macro instplacelist global._instplacelist
function place_solid(xx,yy,zz,obj=obj_solid) {
	
	if zz>0 {
		return true;
	}
	
	if place_meeting(xx,yy,obj) {
		
		var list = instplacelist;
		ds_list_clear(list);
		instance_place_list(xx,yy,obj,list,false);
		var len = dsize(list);
		var c;
		for(var i=0; i<len; i++) {
			c = list[| i];
			if c.collides && rectangle_in_rectangle( 0,zz-height,1,zz, 0,c.z-c.height,1,c.z) {
				return true;
			}
		}
		
	}
	if instance_exists(obj_moon) && point_distance_3d(x,y,z, obj_moon.x,obj_moon.y,obj_moon.z)<(obj_moon.radius-.5) {
		if id==obj_cat.id {
			win_game();
		}
		return true;
	}
	
	return false;
	
}
function place_meeting_3d(xx,yy,zz,obj) {
	
	if place_meeting(xx,yy,obj) {
		
		var list = instplacelist;
		ds_list_clear(list);
		instance_place_list(xx,yy,obj,list,false);
		var len = dsize(list);
		var c;
		for(var i=0; i<len; i++) {
			c = list[| i];
			if c.collides && rectangle_in_rectangle( 0,zz-height,1,zz, 0,c.z-c.height,1,c.z) {
				return true;
			}
		}
		
	}
	
	return false;
	
}


function ride_setup(xoff,yoff,zoff) {
	ride_xoff = xoff;
	ride_yoff = yoff;
	ride_zoff = zoff;
}

function yeet_place(xx,yy,zz) {
	
	
	var list = instplacelist;
	ds_list_clear(list);
		
	instance_place_list(xx,yy,obj_house,list,false);
	instance_place_list(xx,yy,obj_bush,list,false);
	instance_place_list(xx,yy,obj_hitmeow,list,false);
		
	var len = dsize(list);
	var c;
	for(var i=0; i<len; i++) {
		c = list[| i];
		if c.collides && rectangle_in_rectangle( 0,zz-height,1,zz, 0,c.z-c.height,1,c.z) {
			yeet(c);
		}
	}
	
	
}
function instance_place_3d(xx,yy,zz,obj=obj_solid) {
	
	
	if place_meeting(xx,yy,obj) {
		
		var list = instplacelist;
		ds_list_clear(list);
		instance_place_list(xx,yy,obj,list,false);
		var len = dsize(list);
		var c;
		for(var i=0; i<len; i++) {
			c = list[| i];
			if rectangle_in_rectangle( 0,zz-height,1,zz, 0,c.z-c.height,1,c.z) {
				return c.id;
			}
		}
		
	}
	
	return noone;
	
}
function instance_place_3d_list(xx,yy,zz,obj=obj_solid) {
	
	var ret = [];
	if place_meeting(xx,yy,obj) {
		
		var s = 1; //nvm
		var list = instplacelist;
		ds_list_clear(list);
		instance_place_list(xx,yy,obj,list,false);
		var len = dsize(list);
		var c;
		for(var i=0; i<len; i++) {
			c = list[| i];
			if rectangle_in_rectangle( 0,zz-height,1,zz, 0,c.z-c.height,1,c.z) {
				array_push(ret,c);
			}
		}
		
	}
	
	return ret;
	
}
function position_solid(xx,yy,zz,obj=obj_solid) {
	
	
	if position_meeting(xx,yy,obj) {
		
		var list = instplacelist;
		ds_list_clear(list);
		instance_position_list(xx,yy,obj,list,false);
		var len = dsize(list);
		var c;
		for(var i=0; i<len; i++) {
			c = list[| i];
			if rectangle_in_rectangle( 0,zz,1,zz+1, 0,c.z-c.height,1,c.z) {
				return true;
			}
		}
		
	}
	
	return false;
	
}











