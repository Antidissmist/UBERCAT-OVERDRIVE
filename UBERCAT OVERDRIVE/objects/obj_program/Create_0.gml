

if instance_number(obj_program)>1 {
	instance_destroy();
	exit;
}

curtime = current_time;
curtime_prev = curtime;

