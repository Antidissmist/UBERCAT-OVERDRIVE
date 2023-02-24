

setup_3d_object();
sprite_index = sp_catfood;

points = 1;

collect = function() {
	obj_cat.points += points;
	collectnum("+"+string(points));
	log("points: "+string(obj_cat.points));
	instance_destroy();
}

image_xscale = 1/4;
image_yscale = image_xscale;