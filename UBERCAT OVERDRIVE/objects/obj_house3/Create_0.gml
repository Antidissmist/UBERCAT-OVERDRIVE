


dotriplanar = false;
sprite_index = sp_house3_top;
image_xscale = 1/10;
image_yscale = image_xscale;
setup_3d_object();
scaletoroom();

height = 30;


vbuff = vertex_create_buffer();
vertex_begin(vbuff,global.vformat);
vbuff_roof = vertex_create_buffer();
vertex_begin(vbuff_roof,global.vformat);

var size = sprite_width/2;
vertex_add_box_nofloors(vbuff, x,y,z, size, height,,,sp_house3_side);
vertex_add_floor(vbuff_roof,x-size,y-size,x+size,y+size,z-height);//top

vertex_end(vbuff);
vertex_freeze(vbuff);
vertex_end(vbuff_roof);
vertex_freeze(vbuff_roof);


tex1 = sprite_get_texture(sp_house3_side,0);
tex2 = sprite_get_texture(sp_house3_top,0);

