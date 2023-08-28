///@desc draw everything


if PAUSED exit;


//mountains
var sc = 40;
draw_set_lighting(true);
draw_light_define_ambient(#125359);
draw_light_define_direction(2, -.5,.2,.3, #00651e);
draw_light_enable(2,true);
draw_light_enable(1,false);
matrix_set(matrix_world,matrix_build(256,256,20, 0,0,0, sc,sc,sc));
	vertex_submit(mountains,pr_trianglelist,-1);
matrix_reset();
draw_light_enable(2,false);
draw_light_enable(1,true);


//ground
draw_sprite_ext(sp_map,0,0,0, global.mapscale,global.mapscale, 0,c_white,1);

draw_set_lighting(false);
gpu_set_tex_repeat(true);
shader_set(shd_triplanar);
shader_set_uniform_f(shader_get_uniform(shd_triplanar,"scale"),1/10);
	with obj_treebox { event_perform(ev_draw,0); }
shader_set_uniform_f(shader_get_uniform(shd_triplanar,"scale"),1/6);
	with obj_solid { if dotriplanar {event_perform(ev_draw,0);} }
shader_reset();


/*shader_set(shd_inviswall);
with obj_inviswall { vertex_submit(vbuff,pr_trianglelist,tex); }
shader_reset();
*/

	with obj_solid { if !dotriplanar {event_perform(ev_draw,0);} }
gpu_set_tex_repeat(false);

vertex_submit(grass,pr_trianglelist,grasstex);

draw_set_lighting(true);




draw_light_define_ambient(#c7e8fc);
with obj_cat { event_perform(ev_draw,0); }
//draw_light_define_ambient(#14181a);


matrix_set(matrix_world,matrix_build(0,0,-.03, 0,0,0, 1,1,1));
var wav = (sin(cur_time/300)/2+.5);
dc(c_dkgray);
if os_type==os_gxgames {
	with obj_catfood { //ground shadows
		draw_circle(x,y,wav/2+.4,false);
	}
}
else {
	with obj_catfood { //ground shadows
		draw_circle(x-sprite_width*.3,y-sprite_height*.3,wav/2+.4,false);
	}
}
dc(c_white);
matrix_reset();
with obj_alert { event_perform(ev_draw,0); }



shader_set(shd_billboard);
	with obj_catfood { event_perform(ev_draw,0); }
	with obj_billboard { if dobillboard { event_perform(ev_draw,0); } }
shader_reset();
with obj_billboard { if !dobillboard { event_perform(ev_draw,0); } }
with obj_decal { event_perform(ev_draw,0); }
with obj_shockwave { event_perform(ev_draw,0); }



matrix_set(matrix_world,matrix_build(128*global.mapscale,128*global.mapscale,0, 0,0,0, 1,1,1)); //move with camera
gpu_set_cullmode(cull_noculling);
gpu_set_tex_repeat(true);
shader_set(shd_clouds);
shader_set_uniform_f(shader_get_uniform(shd_clouds,"itime"),cur_time/10000);
shader_set_uniform_f(shader_get_uniform(shd_clouds,"campos"),0,0);
	vertex_submit(clouds,pr_trianglelist,cloudtex);
shader_reset();
gpu_set_tex_repeat(false);
matrix_reset();




if global.show_bboxes {
	gpu_set_ztestenable(false);
	with obj_cat { draw_bbox_3d(2); }
	with obj_solid { draw_bbox_3d(); }
	with obj_hitmeow { draw_bbox_3d(2); }
	with obj_meowrange { draw_bbox_3d(,1); }
	with obj_catfood { draw_bbox_3d(2); }
	gpu_set_ztestenable(true);
}



