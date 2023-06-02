#version 300 es

layout(location = 0) out lowp vec4 color;

in lowp vec2 v_texCoord;

uniform lowp vec4 u_color;
uniform sampler2D u_texture;

void main(void){
   lowp vec4 textColor = texture(u_texture,v_texCoord);
    color = textColor;
}
