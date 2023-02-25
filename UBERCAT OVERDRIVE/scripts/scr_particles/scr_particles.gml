//worst way to do particles






function particle_create(xx,yy,zz,sprite) {
	var p = instance_create(xx,yy,zz,obj_particle);
	p.sprite_index = sprite;
	
	return p;
}
function decal_create(xx,yy,zz) {
	var p = instance_create(xx,yy,zz,obj_decal);
	
	return p;
}