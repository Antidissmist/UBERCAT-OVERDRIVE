

//draw_rectangle_color(0,0,gw,gh, skycol_top,skycol_top,skycol_bottom,skycol_bottom, false);


var menualph_targ = PAUSED*.65;

gpu_set_blendenable(false);
if os_type==os_gxgames || !PAUSED {
	draw_surface_ext(application_surface,0,0, 1,1, 0,c_white,1);
}
/*else if os_type==os_gxgames {
	gpu_set_tex_filter(true);
	draw_sprite_stretched(sp_pausebroke,0,0,0,applwidth,applheight);
	gpu_set_tex_filter(false);
}*/
else {
	if sprite_exists(global.pausesprite) {
		draw_sprite_ext(global.pausesprite,0, 0,0, 1,1, 0,c_white,1);
	}
}
gpu_set_blendenable(true);


if !PAUSED && global.show_ui {
	////ui
	var scale = 3;
	var guw = gw/scale;
	var guh = gh/scale;

	matrix_set(matrix_world,matrix_build(0,0,0, 0,0,0, scale,scale,scale));

	//var pspc = 2.5;
	//var wid = obj_cat.points*pspc;
	var pspc = 1*252/obj_cat.uberunlock;
	drawpoints = lerp(drawpoints,obj_cat.points,.2);
	var wid = drawpoints*252/obj_cat.uberunlock;
	var px = guw/2;
	var py = guh;
	draw_sprite(sp_powerlevel,0, px,py);

	var len = alen(obj_cat.unlocks);
	var k;
	for(var i=0; i<len; i++) {
		k = obj_cat.unlocks[i];
		if is_struct(k) {
			var hide = false;
			if variable_struct_exists(k,"hide") {
				hide = k.hide;
			}
			if !hide {
				draw_sprite(sp_powerlevel_unlock,0,px-126+5+pspc*i,py-14);
			}
		}
	}

	draw_sprite_stretched(sp_powerlevelbar,0,px-126,py-14,5+wid,12);

	matrix_reset();


	with obj_cat {
		if !won {
			var i=0;
			var tx = 10;
			var ty = 10;
		
			tx += random_range(-other.controlshake,other.controlshake);
			ty += random_range(-other.controlshake,other.controlshake);
		
			var tspc = 20;
			if canmeow {
				dtext_outlined(tx,ty+i++*tspc,"LMB to meow",1);
			}
			if canjump {
				dtext_outlined(tx,ty+i++*tspc,"press SPACE to jump",1);
			}
			if flight {
				dtext_outlined(tx,ty+i++*tspc,"hold SPACE to launch",1);
				dtext_outlined(tx,ty+i++*tspc,"W + mouse to fly",1);
			}
		}
	}
	
	
	
	if !window_mouse_get_locked() {
		menualph_targ = .65;
	}

}


//announcements
var sc = 2;
draw_center(1);
with obj_announcer {
	dtext_outlined(gw/2,y,showtext, sc, image_alpha);
}
draw_center();

//collect numbers
var ty = gh-80;
var tx = 320;
with obj_collectnumber {
	dtext(tx+x,ty+y,text, 1.25, image_alpha);
}



with obj_cat {
	if won {
		da(obj_cat.fadeout);
		draw_rectangle(0,0,gw,gh,false);
		da(1);
	}
}



if global.speedrun_timer && (global.speedrun.running || global.speedrun.finish!=undefined) {
	
	var fin = global.speedrun.finish!=undefined ? global.speedrun.finish : cur_time;
	var tm = fin-global.speedrun.start;
	
	
	var str = numbertimelabel(tm);
	
	
	draw_center(1);
	dtext_outlined(gw-180,30,str,,,global.speedrun.finish!=undefined ? #ff6c24 : c_white);
	draw_center();
	
}


	
dc(c_black);
da(menualph);
draw_rectangle(0,0,gw,gh,false);
da(1);
dc(c_white);
menualph = lerp(menualph,menualph_targ,.4);


if !PAUSED && global.show_ui && !window_mouse_get_locked() {
	draw_center(1,1)
	dtext_outlined(gw/2,gh*.33,"click or type\nto lock the mouse",1.5);
	draw_center()
}

if PAUSED {
	
	if menumode==0 {
		var i=0;
		var spc = 60;
		var tx = gw/2;
		var ty = gh*.125;
		var sc = 2;
	
		draw_center(1,1);
	
		dtext_outlined(tx,ty+spc*i++, "PAUSED", sc );
		
		i++
	
		if button(tx,ty+spc*i++, "Resume", sc) {
			pause_game(false);			
		}
		if button(tx,ty+spc*i++, "Settings", sc) {
			menumode = 1;
			global.noclicking = true;
		}
		if button(tx,ty+spc*i++, "Restart game", sc) {
			transition_restart();
		}
	
		draw_center();
	}
	else if menumode==1 {
	
		if draw_settings() {
			menumode = 0;
			global.noclicking = true;
		}
	}
	
}
