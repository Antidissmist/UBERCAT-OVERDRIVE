


x += xsp;
y += ysp;
z += zsp;

lifetime--
if lifetime<=0 {
	instance_destroy();
}