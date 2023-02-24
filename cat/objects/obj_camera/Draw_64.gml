

//draw_rectangle_color(0,0,gw,gh, skycol_top,skycol_top,skycol_bottom,skycol_bottom, false);




gpu_set_blendenable(false);
draw_surface_ext(application_surface,0,0, 1,1, 0,c_white,1);
gpu_set_blendenable(true);




////ui
var scale = 3;
var guw = gw/scale;
var guh = gh/scale;

matrix_set(matrix_world,matrix_build(0,0,0, 0,0,0, scale,scale,scale));

var pspc = 2.5;
var wid = obj_cat.points*pspc;
var px = guw/2;
var py = guh;
draw_sprite(sp_powerlevel,0, px,py);

var len = alen(obj_cat.unlocks);
var k;
for(var i=0; i<len; i++) {
	k = obj_cat.unlocks[i];
	if is_struct(k) {
		draw_sprite(sp_powerlevel_unlock,0,px-126+5+pspc*i,py-14);
	}
}

draw_sprite_stretched(sp_powerlevelbar,0,px-126,py-14,5+wid,12);

matrix_reset();


with obj_cat {
	if !won {
		var i=0;
		var tx = 10;
		var ty = 10;
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



if obj_cat.won {
	da(obj_cat.fadeout);
	draw_rectangle(0,0,gw,gh,false);
	da(1);
}

