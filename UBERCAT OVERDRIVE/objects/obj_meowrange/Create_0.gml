

setup_3d_object();
height = 5;

z += height/2; //center around cat

scale = 1/4;
meowpower = 0;
lifetimer = 90;

meow = function() {
	
	if meowpower==1 {
		scale = .4;
	}
	else if meowpower>=2 {
		scale = .65;
	}
	
	image_xscale = scale;
	image_yscale = image_xscale;
	var arr = instance_place_3d_list(x,y,z,obj_hitmeow);
	
	var len = alen(arr);
	var e;
	for(var i=0; i<len; i++) {
		e = arr[i];
		e.hitmeow(meowpower);
	}
	
	//instance_destroy();
	
}