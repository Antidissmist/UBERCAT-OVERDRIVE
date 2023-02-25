

event_inherited();
height = 2;
sprite_index = sp_bbox_cat;

vbuff = obj_camera.vbuff_cat;
vbuff_jump = obj_camera.vbuff_cat_jump;
vbuff_sit = obj_camera.vbuff_cat_sit;
tex = sprite_get_texture(sp_tex_cat2,0);

zang = random(360);
zangtarg = zang;

image_xscale = 1/10;
image_yscale = image_xscale;

shake = 0;
squish = 1;
grounded = true;
dropped = false;

blowawayspeed *= 3;

hitmeow = function(mpower) {
	
	
	audio_play_sound(snd_scaredcat,0,false);
	
	if mpower<1 {
		shake = .2;
		squish = 2.5;
		if z>=zstart {
			zsp = -.25;
		}
	}
	else {
		shake = 1;
		squish = 3.5
		if z>=zstart {
			zsp = -.32;
		}
		zang -= choose(360,720);
		zangtarg = PLAYERDIR+90;
	}
	
	
	instance_create(x,y,z-4,obj_alert);
	if !dropped {
		
		instance_create(x,y,z-.5,obj_catfood);
		
		dropped = true;
	}
	
	if mpower>=2 {
		
		var p;
		var v;
		repeat(8) {
			p = particle_create(x,y,z,sp_yeet_trail);
			v = random_range(.5,.7);
			p.scale = random_range(3,6)/20;
			p.xsp = random_range(-v,v);
			p.ysp = random_range(-v,v);
			p.zsp = random_range(-v,v);
			p.image_index = irandom(2);
			p.image_speed = random_range(.8,1.1);
		}
		
		if z>=zstart {
			decal_create(x,y,z);
		}
		
		yeet();
	}
}
