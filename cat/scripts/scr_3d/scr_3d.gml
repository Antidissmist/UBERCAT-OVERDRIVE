



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


function vertex_add_wall(vbuff, x1,y1,x2,y2, z1,z2, color=c_white,alpha=1,flipnorm=0,sprite=-1) { //jank
	var nx = !flipnorm; //x direction
	var ny = flipnorm; //y direction
	var nz = 0;
	
	var ux1 = 0;
	var uy1 = 0;
	var ux2 = 1;
	var uy2 = 1;
	if sprite_exists(sprite) {
		var u = sprite_get_uvs(sprite,0);
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
	var buff = buffer_load(fname+".vbuff");
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
}
function yeet(inst=id) {
	screenshake(2);
	with inst {
		if !blowaway {
			blowaway = true;
			blowx = obj_cat.x;
			blowy = obj_cat.y;
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
			
			instance_destroy();
		}
	}
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
			pitch = max(pitch,0);
		}
		
		
		var plx = lengthdir_x(1,pitch);
		var ply = lengthdir_x(1,pitch);
		var cdist = camdist;
		do {
			x = xto+lengthdir_x(cdist,yaw) *plx;
			y = yto+lengthdir_y(cdist,yaw) *ply;
			z = zto+lengthdir_y(cdist,pitch);
			cdist -= .25;
		} until ( !position_solid(x,y,z) );
		
		var vmat = matrix_build_lookat(x,y,z, xto,yto,zto, 0,0,1);
		var pmat = matrix_build_projection_perspective_fov(fov,vw/vh, .01,3200);
		
		camera_set_view_mat(CAM,vmat);
		camera_set_proj_mat(CAM,pmat);
		camera_apply(CAM);
		
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
		xsp = 0;
	}
	if !place_solid(x,y+ysp,z) {
		y += ysp;
	}
	else {
		ysp = 0;
	}
	if !(place_solid(x,y,z+zsp) || z+zsp>=0) {
		z += zsp;
	}
	else {
		if z+zsp>=0 {
			z = 0;
		}
		zsp = 0;
	}
}








global._instplacelist = ds_list_create();
#macro instplacelist global._instplacelist
function place_solid(xx,yy,zz,obj=obj_solid) {
	
	
	if place_meeting(xx,yy,obj) {
		
		var list = instplacelist;
		ds_list_clear(list);
		instance_place_list(xx,yy,obj,list,false);
		var len = dsize(list);
		var c;
		for(var i=0; i<len; i++) {
			c = list[| i];
			if rectangle_in_rectangle( 0,zz-height,1,zz, 0,c.z-c.height,1,c.z) {
				return true;
			}
		}
		
	}
	
	return false;
	
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











