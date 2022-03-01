Shader "Hidden/NFAA" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _BlurTex ("Base (RGB)", 2D) = "white" {}
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _OffsetScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec2 xlv_TEXCOORD0_2;
varying highp vec2 xlv_TEXCOORD0_3;
varying highp vec2 xlv_TEXCOORD0_4;
varying highp vec2 xlv_TEXCOORD0_5;
varying highp vec2 xlv_TEXCOORD0_6;
varying highp vec2 xlv_TEXCOORD0_7;
void main ()
{
  highp vec2 uv_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  uv_1 = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 0.0;
  tmpvar_3.y = _MainTex_TexelSize.y;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _OffsetScale);
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _MainTex_TexelSize.x;
  highp vec2 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _OffsetScale);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (uv_1 + tmpvar_4);
  xlv_TEXCOORD0_1 = (uv_1 - tmpvar_4);
  xlv_TEXCOORD0_2 = (uv_1 + tmpvar_6);
  xlv_TEXCOORD0_3 = (uv_1 - tmpvar_6);
  xlv_TEXCOORD0_4 = ((uv_1 - tmpvar_6) + tmpvar_4);
  xlv_TEXCOORD0_5 = ((uv_1 - tmpvar_6) - tmpvar_4);
  xlv_TEXCOORD0_6 = ((uv_1 + tmpvar_6) + tmpvar_4);
  xlv_TEXCOORD0_7 = ((uv_1 + tmpvar_6) - tmpvar_4);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _BlurRadius;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec2 xlv_TEXCOORD0_2;
varying highp vec2 xlv_TEXCOORD0_3;
varying highp vec2 xlv_TEXCOORD0_4;
varying highp vec2 xlv_TEXCOORD0_5;
varying highp vec2 xlv_TEXCOORD0_6;
varying highp vec2 xlv_TEXCOORD0_7;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 returnColor_2;
  highp float rightTopL_3;
  highp float rightBottomL_4;
  highp float leftBottomL_5;
  highp float leftTopL_6;
  highp float leftL_7;
  highp float rightL_8;
  highp float bottomL_9;
  highp float topL_10;
  lowp float tmpvar_11;
  tmpvar_11 = dot (texture2D (_MainTex, xlv_TEXCOORD0).xyz, vec3(0.22, 0.707, 0.071));
  topL_10 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = dot (texture2D (_MainTex, xlv_TEXCOORD0_1).xyz, vec3(0.22, 0.707, 0.071));
  bottomL_9 = tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_13 = dot (texture2D (_MainTex, xlv_TEXCOORD0_2).xyz, vec3(0.22, 0.707, 0.071));
  rightL_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = dot (texture2D (_MainTex, xlv_TEXCOORD0_3).xyz, vec3(0.22, 0.707, 0.071));
  leftL_7 = tmpvar_14;
  lowp float tmpvar_15;
  tmpvar_15 = dot (texture2D (_MainTex, xlv_TEXCOORD0_4).xyz, vec3(0.22, 0.707, 0.071));
  leftTopL_6 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = dot (texture2D (_MainTex, xlv_TEXCOORD0_5).xyz, vec3(0.22, 0.707, 0.071));
  leftBottomL_5 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = dot (texture2D (_MainTex, xlv_TEXCOORD0_6).xyz, vec3(0.22, 0.707, 0.071));
  rightBottomL_4 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = dot (texture2D (_MainTex, xlv_TEXCOORD0_7).xyz, vec3(0.22, 0.707, 0.071));
  rightTopL_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19.x = rightTopL_3;
  tmpvar_19.y = bottomL_9;
  tmpvar_19.z = leftTopL_6;
  highp vec3 tmpvar_20;
  tmpvar_20.x = leftBottomL_5;
  tmpvar_20.y = topL_10;
  tmpvar_20.z = rightBottomL_4;
  highp vec3 tmpvar_21;
  tmpvar_21.x = leftTopL_6;
  tmpvar_21.y = rightL_8;
  tmpvar_21.z = leftBottomL_5;
  highp vec3 tmpvar_22;
  tmpvar_22.x = rightBottomL_4;
  tmpvar_22.y = leftL_7;
  tmpvar_22.z = rightTopL_3;
  highp vec2 tmpvar_23;
  tmpvar_23.x = (dot (vec3(1.0, 1.0, 1.0), tmpvar_19) - dot (vec3(1.0, 1.0, 1.0), tmpvar_20));
  tmpvar_23.y = (dot (vec3(1.0, 1.0, 1.0), tmpvar_22) - dot (vec3(1.0, 1.0, 1.0), tmpvar_21));
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * (_MainTex_TexelSize.xy * _BlurRadius));
  highp vec2 tmpvar_25;
  tmpvar_25 = ((xlv_TEXCOORD0 + xlv_TEXCOORD0_1) * 0.5);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture2D (_MainTex, tmpvar_25);
  returnColor_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (tmpvar_25 + tmpvar_24);
  tmpvar_27 = texture2D (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (tmpvar_25 - tmpvar_24);
  tmpvar_29 = texture2D (_MainTex, P_30);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_24.x;
  tmpvar_31.y = -(tmpvar_24.y);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (tmpvar_25 + tmpvar_31);
  tmpvar_32 = texture2D (_MainTex, P_33);
  highp vec2 tmpvar_34;
  tmpvar_34.x = tmpvar_24.x;
  tmpvar_34.y = -(tmpvar_24.y);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (tmpvar_25 - tmpvar_34);
  tmpvar_35 = texture2D (_MainTex, P_36);
  highp vec4 tmpvar_37;
  tmpvar_37 = (((
    (returnColor_2 + tmpvar_27)
   + tmpvar_29) + tmpvar_32) + tmpvar_35);
  returnColor_2 = tmpvar_37;
  tmpvar_1 = (tmpvar_37 * 0.2);
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _OffsetScale;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD0_1;
out highp vec2 xlv_TEXCOORD0_2;
out highp vec2 xlv_TEXCOORD0_3;
out highp vec2 xlv_TEXCOORD0_4;
out highp vec2 xlv_TEXCOORD0_5;
out highp vec2 xlv_TEXCOORD0_6;
out highp vec2 xlv_TEXCOORD0_7;
void main ()
{
  highp vec2 uv_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  uv_1 = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 0.0;
  tmpvar_3.y = _MainTex_TexelSize.y;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _OffsetScale);
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _MainTex_TexelSize.x;
  highp vec2 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _OffsetScale);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (uv_1 + tmpvar_4);
  xlv_TEXCOORD0_1 = (uv_1 - tmpvar_4);
  xlv_TEXCOORD0_2 = (uv_1 + tmpvar_6);
  xlv_TEXCOORD0_3 = (uv_1 - tmpvar_6);
  xlv_TEXCOORD0_4 = ((uv_1 - tmpvar_6) + tmpvar_4);
  xlv_TEXCOORD0_5 = ((uv_1 - tmpvar_6) - tmpvar_4);
  xlv_TEXCOORD0_6 = ((uv_1 + tmpvar_6) + tmpvar_4);
  xlv_TEXCOORD0_7 = ((uv_1 + tmpvar_6) - tmpvar_4);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _BlurRadius;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD0_1;
in highp vec2 xlv_TEXCOORD0_2;
in highp vec2 xlv_TEXCOORD0_3;
in highp vec2 xlv_TEXCOORD0_4;
in highp vec2 xlv_TEXCOORD0_5;
in highp vec2 xlv_TEXCOORD0_6;
in highp vec2 xlv_TEXCOORD0_7;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 returnColor_2;
  highp float rightTopL_3;
  highp float rightBottomL_4;
  highp float leftBottomL_5;
  highp float leftTopL_6;
  highp float leftL_7;
  highp float rightL_8;
  highp float bottomL_9;
  highp float topL_10;
  lowp float tmpvar_11;
  tmpvar_11 = dot (texture (_MainTex, xlv_TEXCOORD0).xyz, vec3(0.22, 0.707, 0.071));
  topL_10 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = dot (texture (_MainTex, xlv_TEXCOORD0_1).xyz, vec3(0.22, 0.707, 0.071));
  bottomL_9 = tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_13 = dot (texture (_MainTex, xlv_TEXCOORD0_2).xyz, vec3(0.22, 0.707, 0.071));
  rightL_8 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = dot (texture (_MainTex, xlv_TEXCOORD0_3).xyz, vec3(0.22, 0.707, 0.071));
  leftL_7 = tmpvar_14;
  lowp float tmpvar_15;
  tmpvar_15 = dot (texture (_MainTex, xlv_TEXCOORD0_4).xyz, vec3(0.22, 0.707, 0.071));
  leftTopL_6 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = dot (texture (_MainTex, xlv_TEXCOORD0_5).xyz, vec3(0.22, 0.707, 0.071));
  leftBottomL_5 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = dot (texture (_MainTex, xlv_TEXCOORD0_6).xyz, vec3(0.22, 0.707, 0.071));
  rightBottomL_4 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = dot (texture (_MainTex, xlv_TEXCOORD0_7).xyz, vec3(0.22, 0.707, 0.071));
  rightTopL_3 = tmpvar_18;
  highp vec3 tmpvar_19;
  tmpvar_19.x = rightTopL_3;
  tmpvar_19.y = bottomL_9;
  tmpvar_19.z = leftTopL_6;
  highp vec3 tmpvar_20;
  tmpvar_20.x = leftBottomL_5;
  tmpvar_20.y = topL_10;
  tmpvar_20.z = rightBottomL_4;
  highp vec3 tmpvar_21;
  tmpvar_21.x = leftTopL_6;
  tmpvar_21.y = rightL_8;
  tmpvar_21.z = leftBottomL_5;
  highp vec3 tmpvar_22;
  tmpvar_22.x = rightBottomL_4;
  tmpvar_22.y = leftL_7;
  tmpvar_22.z = rightTopL_3;
  highp vec2 tmpvar_23;
  tmpvar_23.x = (dot (vec3(1.0, 1.0, 1.0), tmpvar_19) - dot (vec3(1.0, 1.0, 1.0), tmpvar_20));
  tmpvar_23.y = (dot (vec3(1.0, 1.0, 1.0), tmpvar_22) - dot (vec3(1.0, 1.0, 1.0), tmpvar_21));
  highp vec2 tmpvar_24;
  tmpvar_24 = (tmpvar_23 * (_MainTex_TexelSize.xy * _BlurRadius));
  highp vec2 tmpvar_25;
  tmpvar_25 = ((xlv_TEXCOORD0 + xlv_TEXCOORD0_1) * 0.5);
  lowp vec4 tmpvar_26;
  tmpvar_26 = texture (_MainTex, tmpvar_25);
  returnColor_2 = tmpvar_26;
  lowp vec4 tmpvar_27;
  highp vec2 P_28;
  P_28 = (tmpvar_25 + tmpvar_24);
  tmpvar_27 = texture (_MainTex, P_28);
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  P_30 = (tmpvar_25 - tmpvar_24);
  tmpvar_29 = texture (_MainTex, P_30);
  highp vec2 tmpvar_31;
  tmpvar_31.x = tmpvar_24.x;
  tmpvar_31.y = -(tmpvar_24.y);
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  P_33 = (tmpvar_25 + tmpvar_31);
  tmpvar_32 = texture (_MainTex, P_33);
  highp vec2 tmpvar_34;
  tmpvar_34.x = tmpvar_24.x;
  tmpvar_34.y = -(tmpvar_24.y);
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  P_36 = (tmpvar_25 - tmpvar_34);
  tmpvar_35 = texture (_MainTex, P_36);
  highp vec4 tmpvar_37;
  tmpvar_37 = (((
    (returnColor_2 + tmpvar_27)
   + tmpvar_29) + tmpvar_32) + tmpvar_35);
  returnColor_2 = tmpvar_37;
  tmpvar_1 = (tmpvar_37 * 0.2);
  _glesFragData[0] = tmpvar_1;
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
  ZTest Always
  ZWrite Off
  Cull Off
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _OffsetScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec2 xlv_TEXCOORD0_2;
varying highp vec2 xlv_TEXCOORD0_3;
varying highp vec2 xlv_TEXCOORD0_4;
varying highp vec2 xlv_TEXCOORD0_5;
varying highp vec2 xlv_TEXCOORD0_6;
varying highp vec2 xlv_TEXCOORD0_7;
void main ()
{
  highp vec2 uv_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  uv_1 = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 0.0;
  tmpvar_3.y = _MainTex_TexelSize.y;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _OffsetScale);
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _MainTex_TexelSize.x;
  highp vec2 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _OffsetScale);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (uv_1 + tmpvar_4);
  xlv_TEXCOORD0_1 = (uv_1 - tmpvar_4);
  xlv_TEXCOORD0_2 = (uv_1 + tmpvar_6);
  xlv_TEXCOORD0_3 = (uv_1 - tmpvar_6);
  xlv_TEXCOORD0_4 = ((uv_1 - tmpvar_6) + tmpvar_4);
  xlv_TEXCOORD0_5 = ((uv_1 - tmpvar_6) - tmpvar_4);
  xlv_TEXCOORD0_6 = ((uv_1 + tmpvar_6) + tmpvar_4);
  xlv_TEXCOORD0_7 = ((uv_1 + tmpvar_6) - tmpvar_4);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _BlurRadius;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec2 xlv_TEXCOORD0_2;
varying highp vec2 xlv_TEXCOORD0_3;
varying highp vec2 xlv_TEXCOORD0_4;
varying highp vec2 xlv_TEXCOORD0_5;
varying highp vec2 xlv_TEXCOORD0_6;
varying highp vec2 xlv_TEXCOORD0_7;
void main ()
{
  mediump vec4 tmpvar_1;
  highp float rightTopL_2;
  highp float rightBottomL_3;
  highp float leftBottomL_4;
  highp float leftTopL_5;
  highp float leftL_6;
  highp float rightL_7;
  highp float bottomL_8;
  highp float topL_9;
  lowp float tmpvar_10;
  tmpvar_10 = dot (texture2D (_MainTex, xlv_TEXCOORD0).xyz, vec3(0.22, 0.707, 0.071));
  topL_9 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = dot (texture2D (_MainTex, xlv_TEXCOORD0_1).xyz, vec3(0.22, 0.707, 0.071));
  bottomL_8 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = dot (texture2D (_MainTex, xlv_TEXCOORD0_2).xyz, vec3(0.22, 0.707, 0.071));
  rightL_7 = tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_13 = dot (texture2D (_MainTex, xlv_TEXCOORD0_3).xyz, vec3(0.22, 0.707, 0.071));
  leftL_6 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = dot (texture2D (_MainTex, xlv_TEXCOORD0_4).xyz, vec3(0.22, 0.707, 0.071));
  leftTopL_5 = tmpvar_14;
  lowp float tmpvar_15;
  tmpvar_15 = dot (texture2D (_MainTex, xlv_TEXCOORD0_5).xyz, vec3(0.22, 0.707, 0.071));
  leftBottomL_4 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = dot (texture2D (_MainTex, xlv_TEXCOORD0_6).xyz, vec3(0.22, 0.707, 0.071));
  rightBottomL_3 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = dot (texture2D (_MainTex, xlv_TEXCOORD0_7).xyz, vec3(0.22, 0.707, 0.071));
  rightTopL_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = rightTopL_2;
  tmpvar_18.y = bottomL_8;
  tmpvar_18.z = leftTopL_5;
  highp vec3 tmpvar_19;
  tmpvar_19.x = leftBottomL_4;
  tmpvar_19.y = topL_9;
  tmpvar_19.z = rightBottomL_3;
  highp vec3 tmpvar_20;
  tmpvar_20.x = leftTopL_5;
  tmpvar_20.y = rightL_7;
  tmpvar_20.z = leftBottomL_4;
  highp vec3 tmpvar_21;
  tmpvar_21.x = rightBottomL_3;
  tmpvar_21.y = leftL_6;
  tmpvar_21.z = rightTopL_2;
  highp vec2 tmpvar_22;
  tmpvar_22.x = (dot (vec3(1.0, 1.0, 1.0), tmpvar_18) - dot (vec3(1.0, 1.0, 1.0), tmpvar_19));
  tmpvar_22.y = (dot (vec3(1.0, 1.0, 1.0), tmpvar_21) - dot (vec3(1.0, 1.0, 1.0), tmpvar_20));
  highp vec3 tmpvar_23;
  tmpvar_23.z = 1.0;
  tmpvar_23.xy = (tmpvar_22 * _BlurRadius);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalize(((tmpvar_23 * 0.5) + 0.5));
  tmpvar_1 = tmpvar_24;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_TexelSize;
uniform highp float _OffsetScale;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD0_1;
out highp vec2 xlv_TEXCOORD0_2;
out highp vec2 xlv_TEXCOORD0_3;
out highp vec2 xlv_TEXCOORD0_4;
out highp vec2 xlv_TEXCOORD0_5;
out highp vec2 xlv_TEXCOORD0_6;
out highp vec2 xlv_TEXCOORD0_7;
void main ()
{
  highp vec2 uv_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  uv_1 = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3.x = 0.0;
  tmpvar_3.y = _MainTex_TexelSize.y;
  highp vec2 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * _OffsetScale);
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _MainTex_TexelSize.x;
  highp vec2 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * _OffsetScale);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (uv_1 + tmpvar_4);
  xlv_TEXCOORD0_1 = (uv_1 - tmpvar_4);
  xlv_TEXCOORD0_2 = (uv_1 + tmpvar_6);
  xlv_TEXCOORD0_3 = (uv_1 - tmpvar_6);
  xlv_TEXCOORD0_4 = ((uv_1 - tmpvar_6) + tmpvar_4);
  xlv_TEXCOORD0_5 = ((uv_1 - tmpvar_6) - tmpvar_4);
  xlv_TEXCOORD0_6 = ((uv_1 + tmpvar_6) + tmpvar_4);
  xlv_TEXCOORD0_7 = ((uv_1 + tmpvar_6) - tmpvar_4);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _BlurRadius;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD0_1;
in highp vec2 xlv_TEXCOORD0_2;
in highp vec2 xlv_TEXCOORD0_3;
in highp vec2 xlv_TEXCOORD0_4;
in highp vec2 xlv_TEXCOORD0_5;
in highp vec2 xlv_TEXCOORD0_6;
in highp vec2 xlv_TEXCOORD0_7;
void main ()
{
  mediump vec4 tmpvar_1;
  highp float rightTopL_2;
  highp float rightBottomL_3;
  highp float leftBottomL_4;
  highp float leftTopL_5;
  highp float leftL_6;
  highp float rightL_7;
  highp float bottomL_8;
  highp float topL_9;
  lowp float tmpvar_10;
  tmpvar_10 = dot (texture (_MainTex, xlv_TEXCOORD0).xyz, vec3(0.22, 0.707, 0.071));
  topL_9 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = dot (texture (_MainTex, xlv_TEXCOORD0_1).xyz, vec3(0.22, 0.707, 0.071));
  bottomL_8 = tmpvar_11;
  lowp float tmpvar_12;
  tmpvar_12 = dot (texture (_MainTex, xlv_TEXCOORD0_2).xyz, vec3(0.22, 0.707, 0.071));
  rightL_7 = tmpvar_12;
  lowp float tmpvar_13;
  tmpvar_13 = dot (texture (_MainTex, xlv_TEXCOORD0_3).xyz, vec3(0.22, 0.707, 0.071));
  leftL_6 = tmpvar_13;
  lowp float tmpvar_14;
  tmpvar_14 = dot (texture (_MainTex, xlv_TEXCOORD0_4).xyz, vec3(0.22, 0.707, 0.071));
  leftTopL_5 = tmpvar_14;
  lowp float tmpvar_15;
  tmpvar_15 = dot (texture (_MainTex, xlv_TEXCOORD0_5).xyz, vec3(0.22, 0.707, 0.071));
  leftBottomL_4 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = dot (texture (_MainTex, xlv_TEXCOORD0_6).xyz, vec3(0.22, 0.707, 0.071));
  rightBottomL_3 = tmpvar_16;
  lowp float tmpvar_17;
  tmpvar_17 = dot (texture (_MainTex, xlv_TEXCOORD0_7).xyz, vec3(0.22, 0.707, 0.071));
  rightTopL_2 = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18.x = rightTopL_2;
  tmpvar_18.y = bottomL_8;
  tmpvar_18.z = leftTopL_5;
  highp vec3 tmpvar_19;
  tmpvar_19.x = leftBottomL_4;
  tmpvar_19.y = topL_9;
  tmpvar_19.z = rightBottomL_3;
  highp vec3 tmpvar_20;
  tmpvar_20.x = leftTopL_5;
  tmpvar_20.y = rightL_7;
  tmpvar_20.z = leftBottomL_4;
  highp vec3 tmpvar_21;
  tmpvar_21.x = rightBottomL_3;
  tmpvar_21.y = leftL_6;
  tmpvar_21.z = rightTopL_2;
  highp vec2 tmpvar_22;
  tmpvar_22.x = (dot (vec3(1.0, 1.0, 1.0), tmpvar_18) - dot (vec3(1.0, 1.0, 1.0), tmpvar_19));
  tmpvar_22.y = (dot (vec3(1.0, 1.0, 1.0), tmpvar_21) - dot (vec3(1.0, 1.0, 1.0), tmpvar_20));
  highp vec3 tmpvar_23;
  tmpvar_23.z = 1.0;
  tmpvar_23.xy = (tmpvar_22 * _BlurRadius);
  highp vec4 tmpvar_24;
  tmpvar_24.w = 1.0;
  tmpvar_24.xyz = normalize(((tmpvar_23 * 0.5) + 0.5));
  tmpvar_1 = tmpvar_24;
  _glesFragData[0] = tmpvar_1;
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
}
Fallback Off
}