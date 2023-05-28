



if button(gw/2,gh*.84,"Restart") {
	transition_restart();
}


	
if global.speedrun_timer && global.speedrun.finish!=undefined {
	
	var tm = global.speedrun.finish-global.speedrun.start;
	var str = numbertimelabel(tm);
	draw_center(1);
	dtext_outlined(gw-180,30,str,,,#ff6c24);
	draw_center();
	
}