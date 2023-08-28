

///first time setup

check = function() {
	if audio_system_is_initialised() && audio_system_is_available() {
		adjust_volume();
		
		room_goto(rm_title);
	}
}
check();

