///@desc draw everything




update_camera();


draw_clear_alpha(c_white,0);



//vertex_submit(ground,pr_trianglelist,-1);
draw_sprite_ext(sp_map,0,0,0, global.mapscale,global.mapscale, 0,c_white,1);

draw_set_lighting(false);
gpu_set_tex_repeat(true);
shader_set(shd_triplanar);
shader_set_uniform_f(shader_get_uniform(shd_triplanar,"scale"),1/10);
	with obj_treebox { event_perform(ev_draw,0); }
shader_set_uniform_f(shader_get_uniform(shd_triplanar,"scale"),1/6);
	with obj_solid { if dotriplanar {event_perform(ev_draw,0);} }
shader_reset();

	with obj_solid { if !dotriplanar {event_perform(ev_draw,0);} }
gpu_set_tex_repeat(false);
draw_set_lighting(true);


draw_light_define_ambient(#c7e8fc);
with obj_cat { event_perform(ev_draw,0); }
//draw_light_define_ambient(#14181a);


matrix_set(matrix_world,matrix_build(0,0,-.01, 0,0,0, 1,1,1));
var wav = (sin(current_time/300)/2+.5);
dc(c_dkgray);
with obj_catfood { //ground shadows
	draw_circle(x-sprite_width*.3,y-sprite_height*.3,wav/2+.4,false);
}
dc(c_white);
matrix_reset();
with obj_catfood { event_perform(ev_draw,0); }
with obj_alert { event_perform(ev_draw,0); }


with obj_billboard { event_perform(ev_draw,0); }
with obj_decal { event_perform(ev_draw,0); }




matrix_set(matrix_world,matrix_build(x,y,0, 0,0,0, 1,1,1)); //move with camera
gpu_set_cullmode(cull_noculling);
gpu_set_tex_repeat(true);
shader_set(shd_clouds);
shader_set_uniform_f(shader_get_uniform(shd_clouds,"itime"),current_time/10000);
shader_set_uniform_f(shader_get_uniform(shd_clouds,"campos"),x,y);
	vertex_submit(clouds,pr_trianglelist,cloudtex);
shader_reset();
gpu_set_tex_repeat(false);
matrix_reset();