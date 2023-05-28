
dotriplanar = false;
setup_3d_object();
scaletoroom();

height = 9999;



vbuff = vertex_create_buffer();
vertex_begin(vbuff,global.vformat);

var sizex = sprite_width/2;
var sizey = sprite_height/2;
vertex_add_box_wh(vbuff, x,y,z, sizex,sizey, height);

vertex_end(vbuff);
vertex_freeze(vbuff);

tex = sprite_get_texture(sp_inviswalltex,0);

