

setup_3d_object();
sprite_index = sp_catfood;

points = 1;

collect = function() {
	obj_cat.points += points;
	collectnum("+"+string(points));
	log("points: "+string(obj_cat.points));
	
	audio_play_sound(snd_pickup,0,false);
	instance_destroy();
}

image_xscale = 1/4;
image_yscale = image_xscale;

lerping = false;
lerptime = 0;

xstart = x;
ystart = y;
zstart = z;
chan_pickup = animcurve_get_channel(ac_pickup,0);

