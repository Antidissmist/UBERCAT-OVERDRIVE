

if menumode==0 {
	
	dtext(20,20,global.version,1,,c_text_darkred);
	if button(115,70,"changelog >",1) {
		url_open(global.changelog_link);
	}
	
	if os_type==os_gxgames {
		draw_set_halign(fa_right);
		dtext(gw-20,20, "hold ESCAPE to exit fullscreen",1,,c_text_darkred );
		draw_center();
	}
	

	var i=0;
	var spc = 70;
	var tx = gw/2;
	var ty = 350;
	var sc = 2;
	

	if button(tx,ty+spc*i++, "Start", sc) {
		var t = transition(rm_game,,,"catspin");
		sound_set_gain(global.music,0,t.half_frames);
		sfx_play(snd_startgame);
	}
	if button(tx,ty+spc*i++, "Settings", sc) {
		menumode = 1;
		global.noclicking = true;
	}
	if button(tx,ty+spc*i++, "About", sc) {
		menumode = 2;
		global.noclicking = true;
	}
	if os_type!=os_gxgames && button(tx,ty+spc*i++, "Exit", sc) {
		game_end();
	}
	
	
}
else if menumode==1 {
	
	if draw_settings() {
		menumode = 0;
		global.noclicking = true;
	}
}
else if menumode==2 {
	
	
	
	var i=0;
	var spc = 70;
	var tx = gw/2;
	var ty = gh*.125;
	var sc = 2;
	
	
	if button(90,40, "Back", sc) || key_pressed(vk_escape) {
		menumode = 0;
		global.noclicking = true;
	}
	
	
	draw_center(1,1);
	
	dtext_outlined(tx,ty+spc*i++, "About", sc );
	
	
	var c = c_text_darkred;
	
	i+=.5
	dtext(tx,ty+spc*i++, "Game made by Antidissmist", sc,,c );
	i+=.25
	dtext(tx,ty+spc*i++, "Made for the 2023 Ludwig Game Jam", sc,,c );
	i+=.5
	dtext(tx,ty+spc*i++, "Huge Thanks to Ludwig, \nOttomated, QTCinderella, \nMichael Reeves,", sc,,c );
	dtext(tx,ty+spc*i++, "and everyone for playing!", sc,,c );
	
	i += .5;
	
	dtext(tx,ty+spc*i++, "Made with GameMaker", sc,,c );
	
	
	if button(tx,ty+spc*i++, "See more of my games >", sc) {
		url_open("https://antidissmist.itch.io/");
	}
	if button(tx,ty+spc*i++, "Audio credit", sc) {
		menumode = 3;
		global.noclicking = true;
	}

	
	draw_center();
	
}
else if menumode==3 {
	
	var i=0;
	
	var tx = gw/2;
	var ty = gh*.125;
	var sc = 2;
	var spc = 35*sc;
	
	
	if button(90,40, "Back", sc) || key_pressed(vk_escape) {
		menumode = 2;
		global.noclicking = true;
	}
	
	
	draw_center(1,1);
	
	dtext_outlined(tx,ty+spc*i++, "Audio credit", sc );
	
	sc *= .75;
	
	var c = c_text_darkred;
	
	dtext(tx,ty+spc*i++, "Some sounds used from", sc,,c );
	dtext(tx,ty+spc*i++, "jorickhoofd, Soundholder, Halleck, YleArkisto", sc,,c );
	dtext(tx,ty+spc*i++, "(freesound.org)", sc,,c );
	

	
	draw_center();
}