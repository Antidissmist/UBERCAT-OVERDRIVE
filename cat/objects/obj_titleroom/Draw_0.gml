


var hov = point_in_rectangle(mouse_x,mouse_y,355,716,1022,room_height);


var c = hov ? #b60e39 : #870c33;
draw_center(true);
dtext(room_width/2,room_height-50,"made by antidissmist",2,1,c);
draw_center();

if hov
&& mouse_check_button_pressed(mb_left) {
	url_open("https://antidissmist.github.io/");
}
