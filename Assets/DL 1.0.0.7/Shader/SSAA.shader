Shader "Hidden/SSAA" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec2 xlv_TEXCOORD0_2;
varying highp vec2 xlv_TEXCOORD0_3;
varying highp vec2 xlv_TEXCOORD0_4;
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
  tmpvar_4 = (tmpvar_3 * 1.75);
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _MainTex_TexelSize.x;
  highp vec2 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * 1.75);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (uv_1 - tmpvar_4);
  xlv_TEXCOORD0_1 = (uv_1 - tmpvar_6);
  xlv_TEXCOORD0_2 = (uv_1 + tmpvar_6);
  xlv_TEXCOORD0_3 = (uv_1 + tmpvar_4);
  xlv_TEXCOORD0_4 = uv_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
varying highp vec2 xlv_TEXCOORD0_2;
varying highp vec2 xlv_TEXCOORD0_3;
varying highp vec2 xlv_TEXCOORD0_4;
void main ()
{
  highp float nl_1;
  mediump vec2 n_2;
  highp float b_3;
  highp float r_4;
  highp float l_5;
  highp float t_6;
  mediump vec4 outColor_7;
  lowp float tmpvar_8;
  tmpvar_8 = dot (texture2D (_MainTex, xlv_TEXCOORD0).xyz, vec3(0.22, 0.707, 0.071));
  t_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = dot (texture2D (_MainTex, xlv_TEXCOORD0_1).xyz, vec3(0.22, 0.707, 0.071));
  l_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = dot (texture2D (_MainTex, xlv_TEXCOORD0_2).xyz, vec3(0.22, 0.707, 0.071));
  r_4 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = dot (texture2D (_MainTex, xlv_TEXCOORD0_3).xyz, vec3(0.22, 0.707, 0.071));
  b_3 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = (b_3 - t_6);
  tmpvar_12.y = (r_4 - l_5);
  n_2 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = sqrt(dot (n_2, n_2));
  nl_1 = tmpvar_13;
  if ((nl_1 < 0.0625)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture2D (_MainTex, xlv_TEXCOORD0_4);
    outColor_7 = tmpvar_14;
  } else {
    mediump vec4 t3_15;
    mediump vec4 t2_16;
    mediump vec4 t1_17;
    mediump vec4 t0_18;
    mediump vec4 o_19;
    highp vec2 tmpvar_20;
    tmpvar_20 = (n_2 * (_MainTex_TexelSize.xy / nl_1));
    n_2 = tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture2D (_MainTex, xlv_TEXCOORD0_4);
    o_19 = tmpvar_21;
    highp vec2 P_22;
    P_22 = (xlv_TEXCOORD0_4 + (n_2 * 0.5));
    lowp vec4 tmpvar_23;
    tmpvar_23 = (texture2D (_MainTex, P_22) * 0.9);
    t0_18 = tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD0_4 - (n_2 * 0.5));
    lowp vec4 tmpvar_25;
    tmpvar_25 = (texture2D (_MainTex, P_24) * 0.9);
    t1_17 = tmpvar_25;
    highp vec2 P_26;
    P_26 = (xlv_TEXCOORD0_4 + n_2);
    lowp vec4 tmpvar_27;
    tmpvar_27 = (texture2D (_MainTex, P_26) * 0.75);
    t2_16 = tmpvar_27;
    highp vec2 P_28;
    P_28 = (xlv_TEXCOORD0_4 - n_2);
    lowp vec4 tmpvar_29;
    tmpvar_29 = (texture2D (_MainTex, P_28) * 0.75);
    t3_15 = tmpvar_29;
    outColor_7 = (((
      ((o_19 + t0_18) + t1_17)
     + t2_16) + t3_15) / 4.3);
  };
  gl_FragData[0] = outColor_7;
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
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD0_1;
out highp vec2 xlv_TEXCOORD0_2;
out highp vec2 xlv_TEXCOORD0_3;
out highp vec2 xlv_TEXCOORD0_4;
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
  tmpvar_4 = (tmpvar_3 * 1.75);
  highp vec2 tmpvar_5;
  tmpvar_5.y = 0.0;
  tmpvar_5.x = _MainTex_TexelSize.x;
  highp vec2 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * 1.75);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (uv_1 - tmpvar_4);
  xlv_TEXCOORD0_1 = (uv_1 - tmpvar_6);
  xlv_TEXCOORD0_2 = (uv_1 + tmpvar_6);
  xlv_TEXCOORD0_3 = (uv_1 + tmpvar_4);
  xlv_TEXCOORD0_4 = uv_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD0_1;
in highp vec2 xlv_TEXCOORD0_2;
in highp vec2 xlv_TEXCOORD0_3;
in highp vec2 xlv_TEXCOORD0_4;
void main ()
{
  highp float nl_1;
  mediump vec2 n_2;
  highp float b_3;
  highp float r_4;
  highp float l_5;
  highp float t_6;
  mediump vec4 outColor_7;
  lowp float tmpvar_8;
  tmpvar_8 = dot (texture (_MainTex, xlv_TEXCOORD0).xyz, vec3(0.22, 0.707, 0.071));
  t_6 = tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = dot (texture (_MainTex, xlv_TEXCOORD0_1).xyz, vec3(0.22, 0.707, 0.071));
  l_5 = tmpvar_9;
  lowp float tmpvar_10;
  tmpvar_10 = dot (texture (_MainTex, xlv_TEXCOORD0_2).xyz, vec3(0.22, 0.707, 0.071));
  r_4 = tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = dot (texture (_MainTex, xlv_TEXCOORD0_3).xyz, vec3(0.22, 0.707, 0.071));
  b_3 = tmpvar_11;
  highp vec2 tmpvar_12;
  tmpvar_12.x = (b_3 - t_6);
  tmpvar_12.y = (r_4 - l_5);
  n_2 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = sqrt(dot (n_2, n_2));
  nl_1 = tmpvar_13;
  if ((nl_1 < 0.0625)) {
    lowp vec4 tmpvar_14;
    tmpvar_14 = texture (_MainTex, xlv_TEXCOORD0_4);
    outColor_7 = tmpvar_14;
  } else {
    mediump vec4 t3_15;
    mediump vec4 t2_16;
    mediump vec4 t1_17;
    mediump vec4 t0_18;
    mediump vec4 o_19;
    highp vec2 tmpvar_20;
    tmpvar_20 = (n_2 * (_MainTex_TexelSize.xy / nl_1));
    n_2 = tmpvar_20;
    lowp vec4 tmpvar_21;
    tmpvar_21 = texture (_MainTex, xlv_TEXCOORD0_4);
    o_19 = tmpvar_21;
    highp vec2 P_22;
    P_22 = (xlv_TEXCOORD0_4 + (n_2 * 0.5));
    lowp vec4 tmpvar_23;
    tmpvar_23 = (texture (_MainTex, P_22) * 0.9);
    t0_18 = tmpvar_23;
    highp vec2 P_24;
    P_24 = (xlv_TEXCOORD0_4 - (n_2 * 0.5));
    lowp vec4 tmpvar_25;
    tmpvar_25 = (texture (_MainTex, P_24) * 0.9);
    t1_17 = tmpvar_25;
    highp vec2 P_26;
    P_26 = (xlv_TEXCOORD0_4 + n_2);
    lowp vec4 tmpvar_27;
    tmpvar_27 = (texture (_MainTex, P_26) * 0.75);
    t2_16 = tmpvar_27;
    highp vec2 P_28;
    P_28 = (xlv_TEXCOORD0_4 - n_2);
    lowp vec4 tmpvar_29;
    tmpvar_29 = (texture (_MainTex, P_28) * 0.75);
    t3_15 = tmpvar_29;
    outColor_7 = (((
      ((o_19 + t0_18) + t1_17)
     + t2_16) + t3_15) / 4.3);
  };
  _glesFragData[0] = outColor_7;
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