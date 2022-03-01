Shader "Hidden/FXAA II" {
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
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  pos_1 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  highp vec4 posPos_2;
  posPos_2.xy = ((pos_1 * 0.5) + 0.5);
  posPos_2.zw = (posPos_2.xy - (_MainTex_TexelSize.xy * 0.75));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = posPos_2;
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shader_texture_lod : enable
vec4 impl_texture2DLodEXT(sampler2D sampler, vec2 coord, float lod)
{
#if defined(GL_EXT_shader_texture_lod)
 return texture2DLodEXT(sampler, coord, lod);
#else
 return texture2D(sampler, coord, lod);
#endif
}

uniform highp vec4 _MainTex_TexelSize;
uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec2 dir_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = impl_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.zw, 0.0);
  highp vec3 tmpvar_4;
  tmpvar_4 = tmpvar_3.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = (xlv_TEXCOORD0.zw + (vec2(1.0, 0.0) * _MainTex_TexelSize.xy));
  lowp vec4 tmpvar_6;
  tmpvar_6 = impl_texture2DLodEXT (_MainTex, tmpvar_5.xy, 0.0);
  highp vec3 tmpvar_7;
  tmpvar_7 = tmpvar_6.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = (xlv_TEXCOORD0.zw + (vec2(0.0, 1.0) * _MainTex_TexelSize.xy));
  lowp vec4 tmpvar_9;
  tmpvar_9 = impl_texture2DLodEXT (_MainTex, tmpvar_8.xy, 0.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = tmpvar_9.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = (xlv_TEXCOORD0.zw + _MainTex_TexelSize.xy);
  lowp vec4 tmpvar_12;
  tmpvar_12 = impl_texture2DLodEXT (_MainTex, tmpvar_11.xy, 0.0);
  highp vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = impl_texture2DLodEXT (_MainTex, xlv_TEXCOORD0.xy, 0.0);
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_14.xyz;
  highp float tmpvar_16;
  tmpvar_16 = dot (tmpvar_4, vec3(0.299, 0.587, 0.114));
  highp float tmpvar_17;
  tmpvar_17 = dot (tmpvar_7, vec3(0.299, 0.587, 0.114));
  highp float tmpvar_18;
  tmpvar_18 = dot (tmpvar_10, vec3(0.299, 0.587, 0.114));
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_13, vec3(0.299, 0.587, 0.114));
  highp float tmpvar_20;
  tmpvar_20 = dot (tmpvar_15, vec3(0.299, 0.587, 0.114));
  highp float tmpvar_21;
  tmpvar_21 = min (tmpvar_20, min (min (tmpvar_16, tmpvar_17), min (tmpvar_18, tmpvar_19)));
  highp float tmpvar_22;
  tmpvar_22 = max (tmpvar_20, max (max (tmpvar_16, tmpvar_17), max (tmpvar_18, tmpvar_19)));
  dir_2.x = ((tmpvar_18 + tmpvar_19) - (tmpvar_16 + tmpvar_17));
  dir_2.y = ((tmpvar_16 + tmpvar_18) - (tmpvar_17 + tmpvar_19));
  highp vec2 tmpvar_23;
  tmpvar_23 = (min (vec2(8.0, 8.0), max (vec2(-8.0, -8.0), 
    (dir_2 * (1.0/((min (
      abs(dir_2.x)
    , 
      abs(dir_2.y)
    ) + max (
      ((((tmpvar_16 + tmpvar_17) + tmpvar_18) + tmpvar_19) * 0.03125)
    , 0.0078125)))))
  )) * _MainTex_TexelSize.xy);
  dir_2 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (xlv_TEXCOORD0.xy + (tmpvar_23 * -0.166667));
  lowp vec4 tmpvar_25;
  tmpvar_25 = impl_texture2DLodEXT (_MainTex, tmpvar_24.xy, 0.0);
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (xlv_TEXCOORD0.xy + (tmpvar_23 * 0.166667));
  lowp vec4 tmpvar_27;
  tmpvar_27 = impl_texture2DLodEXT (_MainTex, tmpvar_26.xy, 0.0);
  highp vec3 tmpvar_28;
  tmpvar_28 = (0.5 * (tmpvar_25.xyz + tmpvar_27.xyz));
  highp vec4 tmpvar_29;
  tmpvar_29.zw = vec2(0.0, 0.0);
  tmpvar_29.xy = (xlv_TEXCOORD0.xy + (tmpvar_23 * -0.5));
  lowp vec4 tmpvar_30;
  tmpvar_30 = impl_texture2DLodEXT (_MainTex, tmpvar_29.xy, 0.0);
  highp vec4 tmpvar_31;
  tmpvar_31.zw = vec2(0.0, 0.0);
  tmpvar_31.xy = (xlv_TEXCOORD0.xy + (tmpvar_23 * 0.5));
  lowp vec4 tmpvar_32;
  tmpvar_32 = impl_texture2DLodEXT (_MainTex, tmpvar_31.xy, 0.0);
  highp vec3 tmpvar_33;
  tmpvar_33 = ((tmpvar_28 * 0.5) + (0.25 * (tmpvar_30.xyz + tmpvar_32.xyz)));
  highp float tmpvar_34;
  tmpvar_34 = dot (tmpvar_33, vec3(0.299, 0.587, 0.114));
  if (((tmpvar_34 < tmpvar_21) || (tmpvar_34 > tmpvar_22))) {
    tmpvar_1 = tmpvar_28;
  } else {
    tmpvar_1 = tmpvar_33;
  };
  highp vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = tmpvar_1;
  gl_FragData[0] = tmpvar_35;
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
out highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec2 pos_1;
  pos_1 = ((_glesMultiTexCoord0.xy * 2.0) - 1.0);
  highp vec4 posPos_2;
  posPos_2.xy = ((pos_1 * 0.5) + 0.5);
  posPos_2.zw = (posPos_2.xy - (_MainTex_TexelSize.xy * 0.75));
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = posPos_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _MainTex_TexelSize;
uniform sampler2D _MainTex;
in highp vec4 xlv_TEXCOORD0;
void main ()
{
  highp vec3 tmpvar_1;
  highp vec2 dir_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = textureLod (_MainTex, xlv_TEXCOORD0.zw, 0.0);
  highp vec3 tmpvar_4;
  tmpvar_4 = tmpvar_3.xyz;
  highp vec4 tmpvar_5;
  tmpvar_5.zw = vec2(0.0, 0.0);
  tmpvar_5.xy = (xlv_TEXCOORD0.zw + (vec2(1.0, 0.0) * _MainTex_TexelSize.xy));
  lowp vec4 tmpvar_6;
  tmpvar_6 = textureLod (_MainTex, tmpvar_5.xy, 0.0);
  highp vec3 tmpvar_7;
  tmpvar_7 = tmpvar_6.xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = (xlv_TEXCOORD0.zw + (vec2(0.0, 1.0) * _MainTex_TexelSize.xy));
  lowp vec4 tmpvar_9;
  tmpvar_9 = textureLod (_MainTex, tmpvar_8.xy, 0.0);
  highp vec3 tmpvar_10;
  tmpvar_10 = tmpvar_9.xyz;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 0.0);
  tmpvar_11.xy = (xlv_TEXCOORD0.zw + _MainTex_TexelSize.xy);
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureLod (_MainTex, tmpvar_11.xy, 0.0);
  highp vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12.xyz;
  lowp vec4 tmpvar_14;
  tmpvar_14 = textureLod (_MainTex, xlv_TEXCOORD0.xy, 0.0);
  highp vec3 tmpvar_15;
  tmpvar_15 = tmpvar_14.xyz;
  highp float tmpvar_16;
  tmpvar_16 = dot (tmpvar_4, vec3(0.299, 0.587, 0.114));
  highp float tmpvar_17;
  tmpvar_17 = dot (tmpvar_7, vec3(0.299, 0.587, 0.114));
  highp float tmpvar_18;
  tmpvar_18 = dot (tmpvar_10, vec3(0.299, 0.587, 0.114));
  highp float tmpvar_19;
  tmpvar_19 = dot (tmpvar_13, vec3(0.299, 0.587, 0.114));
  highp float tmpvar_20;
  tmpvar_20 = dot (tmpvar_15, vec3(0.299, 0.587, 0.114));
  highp float tmpvar_21;
  tmpvar_21 = min (tmpvar_20, min (min (tmpvar_16, tmpvar_17), min (tmpvar_18, tmpvar_19)));
  highp float tmpvar_22;
  tmpvar_22 = max (tmpvar_20, max (max (tmpvar_16, tmpvar_17), max (tmpvar_18, tmpvar_19)));
  dir_2.x = ((tmpvar_18 + tmpvar_19) - (tmpvar_16 + tmpvar_17));
  dir_2.y = ((tmpvar_16 + tmpvar_18) - (tmpvar_17 + tmpvar_19));
  highp vec2 tmpvar_23;
  tmpvar_23 = (min (vec2(8.0, 8.0), max (vec2(-8.0, -8.0), 
    (dir_2 * (1.0/((min (
      abs(dir_2.x)
    , 
      abs(dir_2.y)
    ) + max (
      ((((tmpvar_16 + tmpvar_17) + tmpvar_18) + tmpvar_19) * 0.03125)
    , 0.0078125)))))
  )) * _MainTex_TexelSize.xy);
  dir_2 = tmpvar_23;
  highp vec4 tmpvar_24;
  tmpvar_24.zw = vec2(0.0, 0.0);
  tmpvar_24.xy = (xlv_TEXCOORD0.xy + (tmpvar_23 * -0.166667));
  lowp vec4 tmpvar_25;
  tmpvar_25 = textureLod (_MainTex, tmpvar_24.xy, 0.0);
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (xlv_TEXCOORD0.xy + (tmpvar_23 * 0.166667));
  lowp vec4 tmpvar_27;
  tmpvar_27 = textureLod (_MainTex, tmpvar_26.xy, 0.0);
  highp vec3 tmpvar_28;
  tmpvar_28 = (0.5 * (tmpvar_25.xyz + tmpvar_27.xyz));
  highp vec4 tmpvar_29;
  tmpvar_29.zw = vec2(0.0, 0.0);
  tmpvar_29.xy = (xlv_TEXCOORD0.xy + (tmpvar_23 * -0.5));
  lowp vec4 tmpvar_30;
  tmpvar_30 = textureLod (_MainTex, tmpvar_29.xy, 0.0);
  highp vec4 tmpvar_31;
  tmpvar_31.zw = vec2(0.0, 0.0);
  tmpvar_31.xy = (xlv_TEXCOORD0.xy + (tmpvar_23 * 0.5));
  lowp vec4 tmpvar_32;
  tmpvar_32 = textureLod (_MainTex, tmpvar_31.xy, 0.0);
  highp vec3 tmpvar_33;
  tmpvar_33 = ((tmpvar_28 * 0.5) + (0.25 * (tmpvar_30.xyz + tmpvar_32.xyz)));
  highp float tmpvar_34;
  tmpvar_34 = dot (tmpvar_33, vec3(0.299, 0.587, 0.114));
  if (((tmpvar_34 < tmpvar_21) || (tmpvar_34 > tmpvar_22))) {
    tmpvar_1 = tmpvar_28;
  } else {
    tmpvar_1 = tmpvar_33;
  };
  highp vec4 tmpvar_35;
  tmpvar_35.w = 0.0;
  tmpvar_35.xyz = tmpvar_1;
  _glesFragData[0] = tmpvar_35;
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