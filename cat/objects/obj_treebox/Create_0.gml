


setup_3d_object();
scaletoroom();

height = 10;


vbuff = vertex_create_buffer();
vertex_begin(vbuff,global.vformat);

var size = sprite_width/2;
vertex_add_box_nofloors(vbuff, x,y,z, size, height);

vertex_end(vbuff);
vertex_freeze(vbuff);

tex = sprite_get_texture(sp_treewall,0);
