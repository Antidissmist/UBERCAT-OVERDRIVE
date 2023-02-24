



var hov = position_meeting(mouse_x,mouse_y,id);

if hov && mouse_check_button_pressed(mb_left) {
	onclick();
}

var b = hov*4;
draw_sprite_stretched(sprite_index,image_index,x-b,y-b,sprite_width+b*2,sprite_height+b*2);


