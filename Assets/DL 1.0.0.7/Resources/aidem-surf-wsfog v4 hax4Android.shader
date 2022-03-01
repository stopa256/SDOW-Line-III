Shader "Aidem/Surface/World Space Fog v4 hax4Android" {
Properties {
 _Color ("color", Color) = (1,1,1,1)
 _FogColor ("fog color", Color) = (0,0,0,0)
 _FogMaxHeight ("fog start (distance to camera)", Float) = 0
 _FogMinHeight ("fog end (distance to camera)", Float) = -1
 _UnityFogStartOffset ("unity FogStart offset (distance in units)", Float) = 0
 _UnityFogEndOffset ("unity FogEnd offset (distance in units)", Float) = 0
 hax_unity_FogColor ("unity fog color hax00r", Color) = (0,0,0,0)
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "RenderType"="Opaque" }
  Fog {
   Mode Linear
  }
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 x_4;
  x_4 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_4, x_4));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp vec4 c_6;
  c_6.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_6.w = tmpvar_3;
  c_1.w = c_6.w;
  c_1.xyz = (c_6.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  lowp vec4 color_7;
  color_7.w = c_1.w;
  lowp vec3 fogc_8;
  highp float tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_9)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_9)
  ), 0.0, 1.0)));
  fogc_8 = tmpvar_10;
  color_7.xyz = fogc_8;
  c_1 = color_7;
  gl_FragData[0] = color_7;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 x_4;
  x_4 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_4, x_4));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
in highp vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp vec4 c_6;
  c_6.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_6.w = tmpvar_3;
  c_1.w = c_6.w;
  c_1.xyz = (c_6.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  lowp vec4 color_7;
  color_7.w = c_1.w;
  lowp vec3 fogc_8;
  highp float tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_9)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_9)
  ), 0.0, 1.0)));
  fogc_8 = tmpvar_10;
  color_7.xyz = fogc_8;
  c_1 = color_7;
  _glesFragData[0] = color_7;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  c_1.xyz = (tmpvar_2 * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.w = tmpvar_3;
  lowp vec4 color_6;
  color_6.w = c_1.w;
  lowp vec3 fogc_7;
  highp float tmpvar_8;
  tmpvar_8 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_8)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_8)
  ), 0.0, 1.0)));
  fogc_7 = tmpvar_9;
  color_6.xyz = fogc_7;
  c_1 = color_6;
  gl_FragData[0] = color_6;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  c_1.xyz = (tmpvar_2 * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c_1.w = tmpvar_3;
  lowp vec4 color_6;
  color_6.w = c_1.w;
  lowp vec3 fogc_7;
  highp float tmpvar_8;
  tmpvar_8 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_9;
  tmpvar_9 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_8)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_8)
  ), 0.0, 1.0)));
  fogc_7 = tmpvar_9;
  color_6.xyz = fogc_7;
  c_1 = color_6;
  _glesFragData[0] = color_6;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  mediump vec3 lm_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_6 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * lm_6);
  c_1.xyz = tmpvar_8;
  c_1.w = tmpvar_3;
  lowp vec4 color_9;
  color_9.w = c_1.w;
  lowp vec3 fogc_10;
  highp float tmpvar_11;
  tmpvar_11 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_11)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_11)
  ), 0.0, 1.0)));
  fogc_10 = tmpvar_12;
  color_9.xyz = fogc_10;
  c_1 = color_9;
  gl_FragData[0] = color_9;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  mediump vec3 lm_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_6 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_2 * lm_6);
  c_1.xyz = tmpvar_8;
  c_1.w = tmpvar_3;
  lowp vec4 color_9;
  color_9.w = c_1.w;
  lowp vec3 fogc_10;
  highp float tmpvar_11;
  tmpvar_11 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_11)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_11)
  ), 0.0, 1.0)));
  fogc_10 = tmpvar_12;
  color_9.xyz = fogc_10;
  c_1 = color_9;
  _glesFragData[0] = color_9;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 x_4;
  x_4 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  highp vec4 cse_23;
  cse_23 = (_Object2World * _glesVertex);
  xlv_TEXCOORD0 = cse_23;
  xlv_TEXCOORD1 = sqrt(dot (x_4, x_4));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_23);
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp float tmpvar_6;
  mediump float lightShadowDataX_7;
  highp float dist_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((dist_8 > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), lightShadowDataX_7);
  tmpvar_6 = tmpvar_11;
  lowp vec4 c_12;
  c_12.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz))
   * tmpvar_6) * 2.0));
  c_12.w = tmpvar_3;
  c_1.w = c_12.w;
  c_1.xyz = (c_12.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  lowp vec4 color_13;
  color_13.w = c_1.w;
  lowp vec3 fogc_14;
  highp float tmpvar_15;
  tmpvar_15 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_15)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_15)
  ), 0.0, 1.0)));
  fogc_14 = tmpvar_16;
  color_13.xyz = fogc_14;
  c_1 = color_13;
  gl_FragData[0] = color_13;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  highp vec4 cse_2;
  cse_2 = (_Object2World * _glesVertex);
  xlv_TEXCOORD0 = cse_2;
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_2);
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp float tmpvar_6;
  mediump float lightShadowDataX_7;
  highp float dist_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((dist_8 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_7);
  tmpvar_6 = tmpvar_11;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz), vec3((tmpvar_6 * 2.0))));
  c_1.w = tmpvar_3;
  lowp vec4 color_12;
  color_12.w = c_1.w;
  lowp vec3 fogc_13;
  highp float tmpvar_14;
  tmpvar_14 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_14)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_14)
  ), 0.0, 1.0)));
  fogc_13 = tmpvar_15;
  color_12.xyz = fogc_13;
  c_1 = color_12;
  gl_FragData[0] = color_12;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  highp vec4 cse_2;
  cse_2 = (_Object2World * _glesVertex);
  xlv_TEXCOORD0 = cse_2;
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_2);
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp float tmpvar_6;
  mediump float lightShadowDataX_7;
  highp float dist_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((dist_8 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_7);
  tmpvar_6 = tmpvar_11;
  mediump vec3 lm_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_12 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = vec3((tmpvar_6 * 2.0));
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_2 * min (lm_12, tmpvar_14));
  c_1.xyz = tmpvar_15;
  c_1.w = tmpvar_3;
  lowp vec4 color_16;
  color_16.w = c_1.w;
  lowp vec3 fogc_17;
  highp float tmpvar_18;
  tmpvar_18 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_19;
  tmpvar_19 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_18)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_18)
  ), 0.0, 1.0)));
  fogc_17 = tmpvar_19;
  color_16.xyz = fogc_17;
  c_1 = color_16;
  gl_FragData[0] = color_16;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 x_4;
  x_4 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  highp vec4 cse_23;
  cse_23 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - cse_23.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - cse_23.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - cse_23.z);
  highp vec4 tmpvar_27;
  tmpvar_27 = (((tmpvar_24 * tmpvar_24) + (tmpvar_25 * tmpvar_25)) + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_24 * tmpvar_6.x) + (tmpvar_25 * tmpvar_6.y)) + (tmpvar_26 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_27)
  )) * (1.0/((1.0 + 
    (tmpvar_27 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_3 + ((
    ((unity_LightColor[0].xyz * tmpvar_28.x) + (unity_LightColor[1].xyz * tmpvar_28.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_28.z)
  ) + (unity_LightColor[3].xyz * tmpvar_28.w)));
  tmpvar_3 = tmpvar_29;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_23;
  xlv_TEXCOORD1 = sqrt(dot (x_4, x_4));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp vec4 c_6;
  c_6.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_6.w = tmpvar_3;
  c_1.w = c_6.w;
  c_1.xyz = (c_6.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  lowp vec4 color_7;
  color_7.w = c_1.w;
  lowp vec3 fogc_8;
  highp float tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_9)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_9)
  ), 0.0, 1.0)));
  fogc_8 = tmpvar_10;
  color_7.xyz = fogc_8;
  c_1 = color_7;
  gl_FragData[0] = color_7;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 x_4;
  x_4 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  highp vec4 cse_23;
  cse_23 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - cse_23.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - cse_23.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - cse_23.z);
  highp vec4 tmpvar_27;
  tmpvar_27 = (((tmpvar_24 * tmpvar_24) + (tmpvar_25 * tmpvar_25)) + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_24 * tmpvar_6.x) + (tmpvar_25 * tmpvar_6.y)) + (tmpvar_26 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_27)
  )) * (1.0/((1.0 + 
    (tmpvar_27 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_3 + ((
    ((unity_LightColor[0].xyz * tmpvar_28.x) + (unity_LightColor[1].xyz * tmpvar_28.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_28.z)
  ) + (unity_LightColor[3].xyz * tmpvar_28.w)));
  tmpvar_3 = tmpvar_29;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_23;
  xlv_TEXCOORD1 = sqrt(dot (x_4, x_4));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
in highp vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp vec4 c_6;
  c_6.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_6.w = tmpvar_3;
  c_1.w = c_6.w;
  c_1.xyz = (c_6.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  lowp vec4 color_7;
  color_7.w = c_1.w;
  lowp vec3 fogc_8;
  highp float tmpvar_9;
  tmpvar_9 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_9)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_9)
  ), 0.0, 1.0)));
  fogc_8 = tmpvar_10;
  color_7.xyz = fogc_8;
  c_1 = color_7;
  _glesFragData[0] = color_7;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 x_4;
  x_4 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  highp vec4 cse_23;
  cse_23 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - cse_23.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - cse_23.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - cse_23.z);
  highp vec4 tmpvar_27;
  tmpvar_27 = (((tmpvar_24 * tmpvar_24) + (tmpvar_25 * tmpvar_25)) + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_24 * tmpvar_6.x) + (tmpvar_25 * tmpvar_6.y)) + (tmpvar_26 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_27)
  )) * (1.0/((1.0 + 
    (tmpvar_27 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_3 + ((
    ((unity_LightColor[0].xyz * tmpvar_28.x) + (unity_LightColor[1].xyz * tmpvar_28.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_28.z)
  ) + (unity_LightColor[3].xyz * tmpvar_28.w)));
  tmpvar_3 = tmpvar_29;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_23;
  xlv_TEXCOORD1 = sqrt(dot (x_4, x_4));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_23);
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp float tmpvar_6;
  mediump float lightShadowDataX_7;
  highp float dist_8;
  lowp float tmpvar_9;
  tmpvar_9 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x;
  dist_8 = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = _LightShadowData.x;
  lightShadowDataX_7 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = max (float((dist_8 > 
    (xlv_TEXCOORD4.z / xlv_TEXCOORD4.w)
  )), lightShadowDataX_7);
  tmpvar_6 = tmpvar_11;
  lowp vec4 c_12;
  c_12.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz))
   * tmpvar_6) * 2.0));
  c_12.w = tmpvar_3;
  c_1.w = c_12.w;
  c_1.xyz = (c_12.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  lowp vec4 color_13;
  color_13.w = c_1.w;
  lowp vec3 fogc_14;
  highp float tmpvar_15;
  tmpvar_15 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_15)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_15)
  ), 0.0, 1.0)));
  fogc_14 = tmpvar_16;
  color_13.xyz = fogc_14;
  c_1 = color_13;
  gl_FragData[0] = color_13;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 x_4;
  x_4 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  highp vec4 cse_23;
  cse_23 = (_Object2World * _glesVertex);
  xlv_TEXCOORD0 = cse_23;
  xlv_TEXCOORD1 = sqrt(dot (x_4, x_4));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_23);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp float shadow_6;
  lowp float tmpvar_7;
  tmpvar_7 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_8;
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz))
   * shadow_6) * 2.0));
  c_9.w = tmpvar_3;
  c_1.w = c_9.w;
  c_1.xyz = (c_9.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  lowp vec4 color_10;
  color_10.w = c_1.w;
  lowp vec3 fogc_11;
  highp float tmpvar_12;
  tmpvar_12 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_12)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_12)
  ), 0.0, 1.0)));
  fogc_11 = tmpvar_13;
  color_10.xyz = fogc_11;
  c_1 = color_10;
  gl_FragData[0] = color_10;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 x_4;
  x_4 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  highp vec4 cse_23;
  cse_23 = (_Object2World * _glesVertex);
  xlv_TEXCOORD0 = cse_23;
  xlv_TEXCOORD1 = sqrt(dot (x_4, x_4));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_23);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
in highp vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp float shadow_6;
  mediump float tmpvar_7;
  tmpvar_7 = texture (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  lowp float tmpvar_8;
  tmpvar_8 = tmpvar_7;
  highp float tmpvar_9;
  tmpvar_9 = (_LightShadowData.x + (tmpvar_8 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_9;
  lowp vec4 c_10;
  c_10.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz))
   * shadow_6) * 2.0));
  c_10.w = tmpvar_3;
  c_1.w = c_10.w;
  c_1.xyz = (c_10.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  lowp vec4 color_11;
  color_11.w = c_1.w;
  lowp vec3 fogc_12;
  highp float tmpvar_13;
  tmpvar_13 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_13)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_13)
  ), 0.0, 1.0)));
  fogc_12 = tmpvar_14;
  color_11.xyz = fogc_12;
  c_1 = color_11;
  _glesFragData[0] = color_11;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  highp vec4 cse_2;
  cse_2 = (_Object2World * _glesVertex);
  xlv_TEXCOORD0 = cse_2;
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_2);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp float shadow_6;
  lowp float tmpvar_7;
  tmpvar_7 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_8;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz), vec3((shadow_6 * 2.0))));
  c_1.w = tmpvar_3;
  lowp vec4 color_9;
  color_9.w = c_1.w;
  lowp vec3 fogc_10;
  highp float tmpvar_11;
  tmpvar_11 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_11)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_11)
  ), 0.0, 1.0)));
  fogc_10 = tmpvar_12;
  color_9.xyz = fogc_10;
  c_1 = color_9;
  gl_FragData[0] = color_9;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  highp vec4 cse_2;
  cse_2 = (_Object2World * _glesVertex);
  xlv_TEXCOORD0 = cse_2;
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_2);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp float shadow_6;
  mediump float tmpvar_7;
  tmpvar_7 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_8;
  tmpvar_8 = tmpvar_7;
  highp float tmpvar_9;
  tmpvar_9 = (_LightShadowData.x + (tmpvar_8 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_9;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz), vec3((shadow_6 * 2.0))));
  c_1.w = tmpvar_3;
  lowp vec4 color_10;
  color_10.w = c_1.w;
  lowp vec3 fogc_11;
  highp float tmpvar_12;
  tmpvar_12 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_12)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_12)
  ), 0.0, 1.0)));
  fogc_11 = tmpvar_13;
  color_10.xyz = fogc_11;
  c_1 = color_10;
  _glesFragData[0] = color_10;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  highp vec4 cse_2;
  cse_2 = (_Object2World * _glesVertex);
  xlv_TEXCOORD0 = cse_2;
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_2);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D unity_Lightmap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp float shadow_6;
  lowp float tmpvar_7;
  tmpvar_7 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_8;
  mediump vec3 lm_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_9 = tmpvar_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = vec3((shadow_6 * 2.0));
  mediump vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_2 * min (lm_9, tmpvar_11));
  c_1.xyz = tmpvar_12;
  c_1.w = tmpvar_3;
  lowp vec4 color_13;
  color_13.w = c_1.w;
  lowp vec3 fogc_14;
  highp float tmpvar_15;
  tmpvar_15 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_15)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_15)
  ), 0.0, 1.0)));
  fogc_14 = tmpvar_16;
  color_13.xyz = fogc_14;
  c_1 = color_13;
  gl_FragData[0] = color_13;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  highp vec4 cse_2;
  cse_2 = (_Object2World * _glesVertex);
  xlv_TEXCOORD0 = cse_2;
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_2);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D unity_Lightmap;
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp float shadow_6;
  mediump float tmpvar_7;
  tmpvar_7 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_8;
  tmpvar_8 = tmpvar_7;
  highp float tmpvar_9;
  tmpvar_9 = (_LightShadowData.x + (tmpvar_8 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_9;
  mediump vec3 lm_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_10 = tmpvar_11;
  lowp vec3 tmpvar_12;
  tmpvar_12 = vec3((shadow_6 * 2.0));
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_2 * min (lm_10, tmpvar_12));
  c_1.xyz = tmpvar_13;
  c_1.w = tmpvar_3;
  lowp vec4 color_14;
  color_14.w = c_1.w;
  lowp vec3 fogc_15;
  highp float tmpvar_16;
  tmpvar_16 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_17;
  tmpvar_17 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_16)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_16)
  ), 0.0, 1.0)));
  fogc_15 = tmpvar_17;
  color_14.xyz = fogc_15;
  c_1 = color_14;
  _glesFragData[0] = color_14;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 x_4;
  x_4 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  highp vec4 cse_23;
  cse_23 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - cse_23.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - cse_23.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - cse_23.z);
  highp vec4 tmpvar_27;
  tmpvar_27 = (((tmpvar_24 * tmpvar_24) + (tmpvar_25 * tmpvar_25)) + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_24 * tmpvar_6.x) + (tmpvar_25 * tmpvar_6.y)) + (tmpvar_26 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_27)
  )) * (1.0/((1.0 + 
    (tmpvar_27 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_3 + ((
    ((unity_LightColor[0].xyz * tmpvar_28.x) + (unity_LightColor[1].xyz * tmpvar_28.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_28.z)
  ) + (unity_LightColor[3].xyz * tmpvar_28.w)));
  tmpvar_3 = tmpvar_29;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_23;
  xlv_TEXCOORD1 = sqrt(dot (x_4, x_4));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_23);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying lowp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp float shadow_6;
  lowp float tmpvar_7;
  tmpvar_7 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  highp float tmpvar_8;
  tmpvar_8 = (_LightShadowData.x + (tmpvar_7 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_8;
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz))
   * shadow_6) * 2.0));
  c_9.w = tmpvar_3;
  c_1.w = c_9.w;
  c_1.xyz = (c_9.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  lowp vec4 color_10;
  color_10.w = c_1.w;
  lowp vec3 fogc_11;
  highp float tmpvar_12;
  tmpvar_12 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_12)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_12)
  ), 0.0, 1.0)));
  fogc_11 = tmpvar_13;
  color_10.xyz = fogc_11;
  c_1 = color_10;
  gl_FragData[0] = color_10;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out lowp vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec3 shlight_1;
  lowp vec3 tmpvar_2;
  lowp vec3 tmpvar_3;
  highp vec3 x_4;
  x_4 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal_9;
  normal_9 = tmpvar_7;
  highp float vC_10;
  mediump vec3 x3_11;
  mediump vec3 x2_12;
  mediump vec3 x1_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHAr, normal_9);
  x1_13.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAg, normal_9);
  x1_13.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAb, normal_9);
  x1_13.z = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17 = (normal_9.xyzz * normal_9.yzzx);
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHBr, tmpvar_17);
  x2_12.x = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBg, tmpvar_17);
  x2_12.y = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBb, tmpvar_17);
  x2_12.z = tmpvar_20;
  mediump float tmpvar_21;
  tmpvar_21 = ((normal_9.x * normal_9.x) - (normal_9.y * normal_9.y));
  vC_10 = tmpvar_21;
  highp vec3 tmpvar_22;
  tmpvar_22 = (unity_SHC.xyz * vC_10);
  x3_11 = tmpvar_22;
  tmpvar_8 = ((x1_13 + x2_12) + x3_11);
  shlight_1 = tmpvar_8;
  tmpvar_3 = shlight_1;
  highp vec4 cse_23;
  cse_23 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_24;
  tmpvar_24 = (unity_4LightPosX0 - cse_23.x);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosY0 - cse_23.y);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosZ0 - cse_23.z);
  highp vec4 tmpvar_27;
  tmpvar_27 = (((tmpvar_24 * tmpvar_24) + (tmpvar_25 * tmpvar_25)) + (tmpvar_26 * tmpvar_26));
  highp vec4 tmpvar_28;
  tmpvar_28 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_24 * tmpvar_6.x) + (tmpvar_25 * tmpvar_6.y)) + (tmpvar_26 * tmpvar_6.z))
   * 
    inversesqrt(tmpvar_27)
  )) * (1.0/((1.0 + 
    (tmpvar_27 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_29;
  tmpvar_29 = (tmpvar_3 + ((
    ((unity_LightColor[0].xyz * tmpvar_28.x) + (unity_LightColor[1].xyz * tmpvar_28.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_28.z)
  ) + (unity_LightColor[3].xyz * tmpvar_28.w)));
  tmpvar_3 = tmpvar_29;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_23;
  xlv_TEXCOORD1 = sqrt(dot (x_4, x_4));
  xlv_TEXCOORD2 = tmpvar_2;
  xlv_TEXCOORD3 = tmpvar_3;
  xlv_TEXCOORD4 = (unity_World2Shadow[0] * cse_23);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
in highp vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD2;
in lowp vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_4 = _Color.xyz;
  tmpvar_2 = tmpvar_4;
  mediump float tmpvar_5;
  tmpvar_5 = _Color.w;
  tmpvar_3 = tmpvar_5;
  lowp float shadow_6;
  mediump float tmpvar_7;
  tmpvar_7 = texture (_ShadowMapTexture, xlv_TEXCOORD4.xyz);
  lowp float tmpvar_8;
  tmpvar_8 = tmpvar_7;
  highp float tmpvar_9;
  tmpvar_9 = (_LightShadowData.x + (tmpvar_8 * (1.0 - _LightShadowData.x)));
  shadow_6 = tmpvar_9;
  lowp vec4 c_10;
  c_10.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz))
   * shadow_6) * 2.0));
  c_10.w = tmpvar_3;
  c_1.w = c_10.w;
  c_1.xyz = (c_10.xyz + (tmpvar_2 * xlv_TEXCOORD3));
  lowp vec4 color_11;
  color_11.w = c_1.w;
  lowp vec3 fogc_12;
  highp float tmpvar_13;
  tmpvar_13 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_14;
  tmpvar_14 = mix (_FogColor.xyz, c_1.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_13)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_13)
  ), 0.0, 1.0)));
  fogc_12 = tmpvar_14;
  color_11.xyz = fogc_12;
  c_1 = color_11;
  _glesFragData[0] = color_11;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Mode Linear
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 x_3;
  x_3 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceLightPos0.xyz - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_7;
  xlv_TEXCOORD1 = sqrt(dot (x_3, x_3));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * cse_7).xyz;
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = _Color.w;
  tmpvar_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, lightDir_2))
   * texture2D (_LightTexture0, vec2(tmpvar_8)).w) * 2.0));
  c_9.w = tmpvar_4;
  c_1.xyz = c_9.xyz;
  c_1.w = 0.0;
  lowp vec4 color_10;
  color_10.w = c_1.w;
  lowp vec3 fogc_11;
  highp float tmpvar_12;
  tmpvar_12 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_FogColor.xyz, c_9.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_12)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_12)
  ), 0.0, 1.0)));
  fogc_11 = tmpvar_13;
  color_10.xyz = fogc_11;
  c_1 = color_10;
  gl_FragData[0] = color_10;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 x_3;
  x_3 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceLightPos0.xyz - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_7;
  xlv_TEXCOORD1 = sqrt(dot (x_3, x_3));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * cse_7).xyz;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
in highp vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = _Color.w;
  tmpvar_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, lightDir_2))
   * texture (_LightTexture0, vec2(tmpvar_8)).w) * 2.0));
  c_9.w = tmpvar_4;
  c_1.xyz = c_9.xyz;
  c_1.w = 0.0;
  lowp vec4 color_10;
  color_10.w = c_1.w;
  lowp vec3 fogc_11;
  highp float tmpvar_12;
  tmpvar_12 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_FogColor.xyz, c_9.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_12)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_12)
  ), 0.0, 1.0)));
  fogc_11 = tmpvar_13;
  color_10.xyz = fogc_11;
  c_1 = color_10;
  _glesFragData[0] = color_10;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 x_3;
  x_3 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_3, x_3));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = _Color.w;
  tmpvar_4 = tmpvar_6;
  lightDir_2 = xlv_TEXCOORD3;
  lowp vec4 c_7;
  c_7.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD2, lightDir_2)
  ) * 2.0));
  c_7.w = tmpvar_4;
  c_1.xyz = c_7.xyz;
  c_1.w = 0.0;
  lowp vec4 color_8;
  color_8.w = c_1.w;
  lowp vec3 fogc_9;
  highp float tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (_FogColor.xyz, c_7.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_10)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_10)
  ), 0.0, 1.0)));
  fogc_9 = tmpvar_11;
  color_8.xyz = fogc_9;
  c_1 = color_8;
  gl_FragData[0] = color_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 x_3;
  x_3 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_3, x_3));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
in highp vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = _Color.w;
  tmpvar_4 = tmpvar_6;
  lightDir_2 = xlv_TEXCOORD3;
  lowp vec4 c_7;
  c_7.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD2, lightDir_2)
  ) * 2.0));
  c_7.w = tmpvar_4;
  c_1.xyz = c_7.xyz;
  c_1.w = 0.0;
  lowp vec4 color_8;
  color_8.w = c_1.w;
  lowp vec3 fogc_9;
  highp float tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (_FogColor.xyz, c_7.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_10)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_10)
  ), 0.0, 1.0)));
  fogc_9 = tmpvar_11;
  color_8.xyz = fogc_9;
  c_1 = color_8;
  _glesFragData[0] = color_8;
}



#endif"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 x_3;
  x_3 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceLightPos0.xyz - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_7;
  xlv_TEXCOORD1 = sqrt(dot (x_3, x_3));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * cse_7);
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = _Color.w;
  tmpvar_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) + 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD4.xyz, xlv_TEXCOORD4.xyz);
  lowp float atten_10;
  atten_10 = ((float(
    (xlv_TEXCOORD4.z > 0.0)
  ) * texture2D (_LightTexture0, P_8).w) * texture2D (_LightTextureB0, vec2(tmpvar_9)).w);
  lowp vec4 c_11;
  c_11.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, lightDir_2))
   * atten_10) * 2.0));
  c_11.w = tmpvar_4;
  c_1.xyz = c_11.xyz;
  c_1.w = 0.0;
  lowp vec4 color_12;
  color_12.w = c_1.w;
  lowp vec3 fogc_13;
  highp float tmpvar_14;
  tmpvar_14 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (_FogColor.xyz, c_11.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_14)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_14)
  ), 0.0, 1.0)));
  fogc_13 = tmpvar_15;
  color_12.xyz = fogc_13;
  c_1 = color_12;
  gl_FragData[0] = color_12;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 x_3;
  x_3 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceLightPos0.xyz - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_7;
  xlv_TEXCOORD1 = sqrt(dot (x_3, x_3));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * cse_7);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
in highp vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = _Color.w;
  tmpvar_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_7;
  highp vec2 P_8;
  P_8 = ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) + 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (xlv_TEXCOORD4.xyz, xlv_TEXCOORD4.xyz);
  lowp float atten_10;
  atten_10 = ((float(
    (xlv_TEXCOORD4.z > 0.0)
  ) * texture (_LightTexture0, P_8).w) * texture (_LightTextureB0, vec2(tmpvar_9)).w);
  lowp vec4 c_11;
  c_11.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, lightDir_2))
   * atten_10) * 2.0));
  c_11.w = tmpvar_4;
  c_1.xyz = c_11.xyz;
  c_1.w = 0.0;
  lowp vec4 color_12;
  color_12.w = c_1.w;
  lowp vec3 fogc_13;
  highp float tmpvar_14;
  tmpvar_14 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (_FogColor.xyz, c_11.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_14)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_14)
  ), 0.0, 1.0)));
  fogc_13 = tmpvar_15;
  color_12.xyz = fogc_13;
  c_1 = color_12;
  _glesFragData[0] = color_12;
}



#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 x_3;
  x_3 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceLightPos0.xyz - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_7;
  xlv_TEXCOORD1 = sqrt(dot (x_3, x_3));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * cse_7).xyz;
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = _Color.w;
  tmpvar_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, lightDir_2))
   * 
    (texture2D (_LightTextureB0, vec2(tmpvar_8)).w * textureCube (_LightTexture0, xlv_TEXCOORD4).w)
  ) * 2.0));
  c_9.w = tmpvar_4;
  c_1.xyz = c_9.xyz;
  c_1.w = 0.0;
  lowp vec4 color_10;
  color_10.w = c_1.w;
  lowp vec3 fogc_11;
  highp float tmpvar_12;
  tmpvar_12 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_FogColor.xyz, c_9.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_12)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_12)
  ), 0.0, 1.0)));
  fogc_11 = tmpvar_13;
  color_10.xyz = fogc_11;
  c_1 = color_10;
  gl_FragData[0] = color_10;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 x_3;
  x_3 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = (_WorldSpaceLightPos0.xyz - cse_7.xyz);
  tmpvar_2 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_7;
  xlv_TEXCOORD1 = sqrt(dot (x_3, x_3));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * cse_7).xyz;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
in highp vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec3 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = _Color.w;
  tmpvar_4 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = normalize(xlv_TEXCOORD3);
  lightDir_2 = tmpvar_7;
  highp float tmpvar_8;
  tmpvar_8 = dot (xlv_TEXCOORD4, xlv_TEXCOORD4);
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, lightDir_2))
   * 
    (texture (_LightTextureB0, vec2(tmpvar_8)).w * texture (_LightTexture0, xlv_TEXCOORD4).w)
  ) * 2.0));
  c_9.w = tmpvar_4;
  c_1.xyz = c_9.xyz;
  c_1.w = 0.0;
  lowp vec4 color_10;
  color_10.w = c_1.w;
  lowp vec3 fogc_11;
  highp float tmpvar_12;
  tmpvar_12 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_13;
  tmpvar_13 = mix (_FogColor.xyz, c_9.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_12)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_12)
  ), 0.0, 1.0)));
  fogc_11 = tmpvar_13;
  color_10.xyz = fogc_11;
  c_1 = color_10;
  _glesFragData[0] = color_10;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 x_3;
  x_3 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_7;
  xlv_TEXCOORD1 = sqrt(dot (x_3, x_3));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * cse_7).xy;
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD2;
varying mediump vec3 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = _Color.w;
  tmpvar_4 = tmpvar_6;
  lightDir_2 = xlv_TEXCOORD3;
  lowp vec4 c_7;
  c_7.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, lightDir_2))
   * texture2D (_LightTexture0, xlv_TEXCOORD4).w) * 2.0));
  c_7.w = tmpvar_4;
  c_1.xyz = c_7.xyz;
  c_1.w = 0.0;
  lowp vec4 color_8;
  color_8.w = c_1.w;
  lowp vec3 fogc_9;
  highp float tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (_FogColor.xyz, c_7.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_10)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_10)
  ), 0.0, 1.0)));
  fogc_9 = tmpvar_11;
  color_8.xyz = fogc_9;
  c_1 = color_8;
  gl_FragData[0] = color_8;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out mediump vec3 xlv_TEXCOORD3;
out highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec3 tmpvar_1;
  mediump vec3 tmpvar_2;
  highp vec3 x_3;
  x_3 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_5;
  highp vec3 tmpvar_6;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_6 = _WorldSpaceLightPos0.xyz;
  tmpvar_2 = tmpvar_6;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = cse_7;
  xlv_TEXCOORD1 = sqrt(dot (x_3, x_3));
  xlv_TEXCOORD2 = tmpvar_1;
  xlv_TEXCOORD3 = tmpvar_2;
  xlv_TEXCOORD4 = (_LightMatrix0 * cse_7).xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
in highp vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD2;
in mediump vec3 xlv_TEXCOORD3;
in highp vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec3 tmpvar_5;
  tmpvar_5 = _Color.xyz;
  tmpvar_3 = tmpvar_5;
  mediump float tmpvar_6;
  tmpvar_6 = _Color.w;
  tmpvar_4 = tmpvar_6;
  lightDir_2 = xlv_TEXCOORD3;
  lowp vec4 c_7;
  c_7.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD2, lightDir_2))
   * texture (_LightTexture0, xlv_TEXCOORD4).w) * 2.0));
  c_7.w = tmpvar_4;
  c_1.xyz = c_7.xyz;
  c_1.w = 0.0;
  lowp vec4 color_8;
  color_8.w = c_1.w;
  lowp vec3 fogc_9;
  highp float tmpvar_10;
  tmpvar_10 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (_FogColor.xyz, c_7.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_10)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_10)
  ), 0.0, 1.0)));
  fogc_9 = tmpvar_11;
  color_8.xyz = fogc_9;
  c_1 = color_8;
  _glesFragData[0] = color_8;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 x_2;
  x_2 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_2, x_2));
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 res_1;
  res_1.xyz = ((xlv_TEXCOORD2 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec3 tmpvar_1;
  highp vec3 x_2;
  x_2 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp mat3 tmpvar_3;
  tmpvar_3[0] = _Object2World[0].xyz;
  tmpvar_3[1] = _Object2World[1].xyz;
  tmpvar_3[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_2, x_2));
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 res_1;
  res_1.xyz = ((xlv_TEXCOORD2 * 0.5) + 0.5);
  res_1.w = 0.0;
  _glesFragData[0] = res_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Mode Linear
  }
Program "vp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 x_2;
  x_2 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  tmpvar_1 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_2, x_2));
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = _Color.w;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + xlv_TEXCOORD3);
  light_3.xyz = tmpvar_10;
  lowp vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * light_3.xyz);
  c_11.xyz = tmpvar_12;
  c_11.w = tmpvar_5;
  c_2 = c_11;
  lowp vec4 color_13;
  color_13 = c_2;
  lowp vec3 fogc_14;
  highp float tmpvar_15;
  tmpvar_15 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (_FogColor.xyz, color_13.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_15)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_15)
  ), 0.0, 1.0)));
  fogc_14 = tmpvar_16;
  color_13.xyz = fogc_14;
  c_2 = color_13;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 x_2;
  x_2 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  tmpvar_1 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_2, x_2));
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D _LightBuffer;
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = _Color.w;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = textureProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + xlv_TEXCOORD3);
  light_3.xyz = tmpvar_10;
  lowp vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * light_3.xyz);
  c_11.xyz = tmpvar_12;
  c_11.w = tmpvar_5;
  c_2 = c_11;
  lowp vec4 color_13;
  color_13 = c_2;
  lowp vec3 fogc_14;
  highp float tmpvar_15;
  tmpvar_15 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (_FogColor.xyz, color_13.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_15)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_15)
  ), 0.0, 1.0)));
  fogc_14 = tmpvar_16;
  color_13.xyz = fogc_14;
  c_2 = color_13;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 cse_2;
  cse_2 = (glstate_matrix_modelview0 * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = ((cse_7.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-(cse_2.z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = cse_7;
  xlv_TEXCOORD1 = sqrt(dot (cse_2.xyz, cse_2.xyz));
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _Color.xyz;
  tmpvar_7 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = _Color.w;
  tmpvar_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_12.w;
  highp float tmpvar_13;
  tmpvar_13 = ((sqrt(
    dot (xlv_TEXCOORD4, xlv_TEXCOORD4)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz);
  lmFull_4 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD3).xyz);
  lmIndirect_3 = tmpvar_15;
  light_6.xyz = (tmpvar_12.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_7 * light_6.xyz);
  c_16.xyz = tmpvar_17;
  c_16.w = tmpvar_8;
  c_2 = c_16;
  lowp vec4 color_18;
  color_18 = c_2;
  lowp vec3 fogc_19;
  highp float tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (_FogColor.xyz, color_18.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_20)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_20)
  ), 0.0, 1.0)));
  fogc_19 = tmpvar_21;
  color_18.xyz = fogc_19;
  c_2 = color_18;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 cse_2;
  cse_2 = (glstate_matrix_modelview0 * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = ((cse_7.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-(cse_2.z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = cse_7;
  xlv_TEXCOORD1 = sqrt(dot (cse_2.xyz, cse_2.xyz));
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _Color.xyz;
  tmpvar_7 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = _Color.w;
  tmpvar_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = textureProj (_LightBuffer, xlv_TEXCOORD2);
  light_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_12.w;
  highp float tmpvar_13;
  tmpvar_13 = ((sqrt(
    dot (xlv_TEXCOORD4, xlv_TEXCOORD4)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz);
  lmFull_4 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD3).xyz);
  lmIndirect_3 = tmpvar_15;
  light_6.xyz = (tmpvar_12.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_7 * light_6.xyz);
  c_16.xyz = tmpvar_17;
  c_16.w = tmpvar_8;
  c_2 = c_16;
  lowp vec4 color_18;
  color_18 = c_2;
  lowp vec3 fogc_19;
  highp float tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (_FogColor.xyz, color_18.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_20)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_20)
  ), 0.0, 1.0)));
  fogc_19 = tmpvar_21;
  color_18.xyz = fogc_19;
  c_2 = color_18;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = o_3;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = _Color.w;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_8;
  mediump vec3 lm_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz);
  lm_9 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = lm_9;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (-(log2(
    max (light_3, vec4(0.001, 0.001, 0.001, 0.001))
  )) + tmpvar_11);
  light_3 = tmpvar_12;
  lowp vec4 c_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_4 * tmpvar_12.xyz);
  c_13.xyz = tmpvar_14;
  c_13.w = tmpvar_5;
  c_2 = c_13;
  lowp vec4 color_15;
  color_15 = c_2;
  lowp vec3 fogc_16;
  highp float tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColor.xyz, color_15.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_17)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_17)
  ), 0.0, 1.0)));
  fogc_16 = tmpvar_18;
  color_15.xyz = fogc_16;
  c_2 = color_15;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = o_3;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = _Color.w;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = textureProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_8;
  mediump vec3 lm_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz);
  lm_9 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = lm_9;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (-(log2(
    max (light_3, vec4(0.001, 0.001, 0.001, 0.001))
  )) + tmpvar_11);
  light_3 = tmpvar_12;
  lowp vec4 c_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_4 * tmpvar_12.xyz);
  c_13.xyz = tmpvar_14;
  c_13.w = tmpvar_5;
  c_2 = c_13;
  lowp vec4 color_15;
  color_15 = c_2;
  lowp vec3 fogc_16;
  highp float tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColor.xyz, color_15.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_17)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_17)
  ), 0.0, 1.0)));
  fogc_16 = tmpvar_18;
  color_15.xyz = fogc_16;
  c_2 = color_15;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 x_2;
  x_2 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  tmpvar_1 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_2, x_2));
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D _LightBuffer;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = _Color.w;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + xlv_TEXCOORD3);
  light_3.xyz = tmpvar_10;
  lowp vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * light_3.xyz);
  c_11.xyz = tmpvar_12;
  c_11.w = tmpvar_5;
  c_2 = c_11;
  lowp vec4 color_13;
  color_13 = c_2;
  lowp vec3 fogc_14;
  highp float tmpvar_15;
  tmpvar_15 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (_FogColor.xyz, color_13.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_15)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_15)
  ), 0.0, 1.0)));
  fogc_14 = tmpvar_16;
  color_13.xyz = fogc_14;
  c_2 = color_13;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec3 x_2;
  x_2 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  tmpvar_1 = tmpvar_9;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_2, x_2));
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD3 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D _LightBuffer;
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = _Color.w;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = textureProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_9.w;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + xlv_TEXCOORD3);
  light_3.xyz = tmpvar_10;
  lowp vec4 c_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_4 * light_3.xyz);
  c_11.xyz = tmpvar_12;
  c_11.w = tmpvar_5;
  c_2 = c_11;
  lowp vec4 color_13;
  color_13 = c_2;
  lowp vec3 fogc_14;
  highp float tmpvar_15;
  tmpvar_15 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_16;
  tmpvar_16 = mix (_FogColor.xyz, color_13.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_15)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_15)
  ), 0.0, 1.0)));
  fogc_14 = tmpvar_16;
  color_13.xyz = fogc_14;
  c_2 = color_13;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 cse_2;
  cse_2 = (glstate_matrix_modelview0 * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = ((cse_7.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-(cse_2.z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = cse_7;
  xlv_TEXCOORD1 = sqrt(dot (cse_2.xyz, cse_2.xyz));
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _Color.xyz;
  tmpvar_7 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = _Color.w;
  tmpvar_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_12.w;
  highp float tmpvar_13;
  tmpvar_13 = ((sqrt(
    dot (xlv_TEXCOORD4, xlv_TEXCOORD4)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz);
  lmFull_4 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD3).xyz);
  lmIndirect_3 = tmpvar_15;
  light_6.xyz = (tmpvar_12.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_7 * light_6.xyz);
  c_16.xyz = tmpvar_17;
  c_16.w = tmpvar_8;
  c_2 = c_16;
  lowp vec4 color_18;
  color_18 = c_2;
  lowp vec3 fogc_19;
  highp float tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (_FogColor.xyz, color_18.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_20)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_20)
  ), 0.0, 1.0)));
  fogc_19 = tmpvar_21;
  color_18.xyz = fogc_19;
  c_2 = color_18;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
out highp vec4 xlv_TEXCOORD4;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 cse_2;
  cse_2 = (glstate_matrix_modelview0 * _glesVertex);
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_3.zw;
  highp vec4 cse_7;
  cse_7 = (_Object2World * _glesVertex);
  tmpvar_1.xyz = ((cse_7.xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_1.w = (-(cse_2.z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = cse_7;
  xlv_TEXCOORD1 = sqrt(dot (cse_2.xyz, cse_2.xyz));
  xlv_TEXCOORD2 = o_4;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD4 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
in highp vec4 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = _Color.xyz;
  tmpvar_7 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = _Color.w;
  tmpvar_8 = tmpvar_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = textureProj (_LightBuffer, xlv_TEXCOORD2);
  light_6 = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_12.w;
  highp float tmpvar_13;
  tmpvar_13 = ((sqrt(
    dot (xlv_TEXCOORD4, xlv_TEXCOORD4)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz);
  lmFull_4 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD3).xyz);
  lmIndirect_3 = tmpvar_15;
  light_6.xyz = (tmpvar_12.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_16;
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_7 * light_6.xyz);
  c_16.xyz = tmpvar_17;
  c_16.w = tmpvar_8;
  c_2 = c_16;
  lowp vec4 color_18;
  color_18 = c_2;
  lowp vec3 fogc_19;
  highp float tmpvar_20;
  tmpvar_20 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_21;
  tmpvar_21 = mix (_FogColor.xyz, color_18.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_20)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_20)
  ), 0.0, 1.0)));
  fogc_19 = tmpvar_21;
  color_18.xyz = fogc_19;
  c_2 = color_18;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
varying highp vec4 xlv_TEXCOORD0;
varying highp float xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = o_3;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = _Color.w;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_8;
  mediump vec3 lm_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD3).xyz);
  lm_9 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = lm_9;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_11);
  light_3 = tmpvar_12;
  lowp vec4 c_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_4 * tmpvar_12.xyz);
  c_13.xyz = tmpvar_14;
  c_13.w = tmpvar_5;
  c_2 = c_13;
  lowp vec4 color_15;
  color_15 = c_2;
  lowp vec3 fogc_16;
  highp float tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColor.xyz, color_15.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_17)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_17)
  ), 0.0, 1.0)));
  fogc_16 = tmpvar_18;
  color_15.xyz = fogc_16;
  c_2 = color_15;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
out highp vec4 xlv_TEXCOORD0;
out highp float xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  highp vec3 x_1;
  x_1 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = (_Object2World * _glesVertex);
  xlv_TEXCOORD1 = sqrt(dot (x_1, x_1));
  xlv_TEXCOORD2 = o_3;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec3 _WorldSpaceCameraPos;
uniform mediump vec4 _Color;
uniform mediump vec4 _FogColor;
uniform mediump float _FogMaxHeight;
uniform mediump float _FogMinHeight;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
in highp vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec3 tmpvar_6;
  tmpvar_6 = _Color.xyz;
  tmpvar_4 = tmpvar_6;
  mediump float tmpvar_7;
  tmpvar_7 = _Color.w;
  tmpvar_5 = tmpvar_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = textureProj (_LightBuffer, xlv_TEXCOORD2);
  light_3 = tmpvar_8;
  mediump vec3 lm_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD3).xyz);
  lm_9 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = lm_9;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_11);
  light_3 = tmpvar_12;
  lowp vec4 c_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_4 * tmpvar_12.xyz);
  c_13.xyz = tmpvar_14;
  c_13.w = tmpvar_5;
  c_2 = c_13;
  lowp vec4 color_15;
  color_15 = c_2;
  lowp vec3 fogc_16;
  highp float tmpvar_17;
  tmpvar_17 = (_WorldSpaceCameraPos.y + _FogMinHeight);
  highp vec3 tmpvar_18;
  tmpvar_18 = mix (_FogColor.xyz, color_15.xyz, vec3(clamp ((
    (xlv_TEXCOORD0.y - tmpvar_17)
   / 
    ((_WorldSpaceCameraPos.y + _FogMaxHeight) - tmpvar_17)
  ), 0.0, 1.0)));
  fogc_16 = tmpvar_18;
  color_15.xyz = fogc_16;
  c_2 = color_15;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}
}
 }
}
Fallback "Diffuse"
}