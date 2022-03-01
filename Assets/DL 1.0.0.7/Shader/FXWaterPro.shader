Shader "FX/Water" {
Properties {
 _WaveScale ("Wave scale", Range(0.02,0.15)) = 0.063
 _ReflDistort ("Reflection distort", Range(0,1.5)) = 0.44
 _RefrDistort ("Refraction distort", Range(0,1.5)) = 0.4
 _RefrColor ("Refraction color", Color) = (0.34,0.85,0.92,1)
 _Fresnel ("Fresnel (A) ", 2D) = "gray" {}
 _BumpMap ("Normalmap ", 2D) = "bump" {}
 WaveSpeed ("Wave speed (map1 x,y; map2 x,y)", Vector) = (19,9,-16,-7)
 _ReflectiveColor ("Reflective color (RGB) fresnel (A) ", 2D) = "" {}
 _ReflectiveColorCube ("Reflective color cube (RGB) fresnel (A)", CUBE) = "" { TexGen CubeReflect }
 _HorizonColor ("Simple water horizon color", Color) = (0.172,0.463,0.435,1)
 _MainTex ("Fallback texture", 2D) = "" {}
 _ReflectionTex ("Internal Reflection", 2D) = "" {}
 _RefractionTex ("Internal Refraction", 2D) = "" {}
}
SubShader { 
 Tags { "RenderType"="Opaque" "WaterMode"="Refractive" }
 Pass {
  Tags { "RenderType"="Opaque" "WaterMode"="Refractive" }
Program "vp" {
SubProgram "gles " {
Keywords { "WATER_REFRACTIVE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 _WaveScale4;
uniform highp vec4 _WaveOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  temp_1 = (((_glesVertex.xzxz * _WaveScale4) / unity_Scale.w) + _WaveOffset);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_4;
  xlv_TEXCOORD1 = temp_1.xy;
  xlv_TEXCOORD2 = temp_1.wz;
  xlv_TEXCOORD3 = (((_World2Object * tmpvar_3).xyz * unity_Scale.w) - _glesVertex.xyz).xzy;
}



#endif
#ifdef FRAGMENT

uniform highp float _ReflDistort;
uniform highp float _RefrDistort;
uniform sampler2D _ReflectionTex;
uniform sampler2D _Fresnel;
uniform sampler2D _RefractionTex;
uniform highp vec4 _RefrColor;
uniform sampler2D _BumpMap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float fresnel_1;
  mediump vec4 refr_2;
  highp vec4 uv2_3;
  mediump vec4 refl_4;
  highp vec4 uv1_5;
  mediump float fresnelFac_6;
  mediump vec3 bump2_7;
  mediump vec3 bump1_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  bump1_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture2D (_BumpMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
  bump2_7 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((bump1_8 + bump2_7) * 0.5);
  highp float tmpvar_12;
  tmpvar_12 = dot (normalize(xlv_TEXCOORD3), tmpvar_11);
  fresnelFac_6 = tmpvar_12;
  uv1_5.zw = xlv_TEXCOORD0.zw;
  uv1_5.xy = (xlv_TEXCOORD0.xy + (tmpvar_11 * _ReflDistort).xy);
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2DProj (_ReflectionTex, uv1_5);
  refl_4 = tmpvar_13;
  uv2_3.zw = xlv_TEXCOORD0.zw;
  uv2_3.xy = (xlv_TEXCOORD0.xy - (tmpvar_11 * _RefrDistort).xy);
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2DProj (_RefractionTex, uv2_3);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * _RefrColor);
  refr_2 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = texture2D (_Fresnel, vec2(fresnelFac_6)).w;
  fresnel_1 = tmpvar_16;
  gl_FragData[0] = mix (refr_2, refl_4, vec4(fresnel_1));
}



#endif"
}
SubProgram "gles3 " {
Keywords { "WATER_REFRACTIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 _WaveScale4;
uniform highp vec4 _WaveOffset;
out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  temp_1 = (((_glesVertex.xzxz * _WaveScale4) / unity_Scale.w) + _WaveOffset);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_4;
  xlv_TEXCOORD1 = temp_1.xy;
  xlv_TEXCOORD2 = temp_1.wz;
  xlv_TEXCOORD3 = (((_World2Object * tmpvar_3).xyz * unity_Scale.w) - _glesVertex.xyz).xzy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _ReflDistort;
uniform highp float _RefrDistort;
uniform sampler2D _ReflectionTex;
uniform sampler2D _Fresnel;
uniform sampler2D _RefractionTex;
uniform highp vec4 _RefrColor;
uniform sampler2D _BumpMap;
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump float fresnel_1;
  mediump vec4 refr_2;
  highp vec4 uv2_3;
  mediump vec4 refl_4;
  highp vec4 uv1_5;
  mediump float fresnelFac_6;
  mediump vec3 bump2_7;
  mediump vec3 bump1_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  bump1_8 = tmpvar_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((texture (_BumpMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
  bump2_7 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = ((bump1_8 + bump2_7) * 0.5);
  highp float tmpvar_12;
  tmpvar_12 = dot (normalize(xlv_TEXCOORD3), tmpvar_11);
  fresnelFac_6 = tmpvar_12;
  uv1_5.zw = xlv_TEXCOORD0.zw;
  uv1_5.xy = (xlv_TEXCOORD0.xy + (tmpvar_11 * _ReflDistort).xy);
  lowp vec4 tmpvar_13;
  tmpvar_13 = textureProj (_ReflectionTex, uv1_5);
  refl_4 = tmpvar_13;
  uv2_3.zw = xlv_TEXCOORD0.zw;
  uv2_3.xy = (xlv_TEXCOORD0.xy - (tmpvar_11 * _RefrDistort).xy);
  lowp vec4 tmpvar_14;
  tmpvar_14 = textureProj (_RefractionTex, uv2_3);
  highp vec4 tmpvar_15;
  tmpvar_15 = (tmpvar_14 * _RefrColor);
  refr_2 = tmpvar_15;
  lowp float tmpvar_16;
  tmpvar_16 = texture (_Fresnel, vec2(fresnelFac_6)).w;
  fresnel_1 = tmpvar_16;
  _glesFragData[0] = mix (refr_2, refl_4, vec4(fresnel_1));
}



#endif"
}
SubProgram "gles " {
Keywords { "WATER_REFLECTIVE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 _WaveScale4;
uniform highp vec4 _WaveOffset;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  temp_1 = (((_glesVertex.xzxz * _WaveScale4) / unity_Scale.w) + _WaveOffset);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_4;
  xlv_TEXCOORD1 = temp_1.xy;
  xlv_TEXCOORD2 = temp_1.wz;
  xlv_TEXCOORD3 = (((_World2Object * tmpvar_3).xyz * unity_Scale.w) - _glesVertex.xyz).xzy;
}



#endif
#ifdef FRAGMENT

uniform highp float _ReflDistort;
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectiveColor;
uniform sampler2D _BumpMap;
varying highp vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 water_1;
  mediump vec4 color_2;
  mediump vec4 refl_3;
  highp vec4 uv1_4;
  mediump float fresnelFac_5;
  mediump vec3 bump2_6;
  mediump vec3 bump1_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  bump1_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture2D (_BumpMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
  bump2_6 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = ((bump1_7 + bump2_6) * 0.5);
  highp float tmpvar_11;
  tmpvar_11 = dot (normalize(xlv_TEXCOORD3), tmpvar_10);
  fresnelFac_5 = tmpvar_11;
  uv1_4.zw = xlv_TEXCOORD0.zw;
  uv1_4.xy = (xlv_TEXCOORD0.xy + (tmpvar_10 * _ReflDistort).xy);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DProj (_ReflectionTex, uv1_4);
  refl_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture2D (_ReflectiveColor, vec2(fresnelFac_5));
  water_1 = tmpvar_13;
  color_2.xyz = mix (water_1.xyz, refl_3.xyz, water_1.www);
  color_2.w = (refl_3.w * water_1.w);
  gl_FragData[0] = color_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "WATER_REFLECTIVE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 _WaveScale4;
uniform highp vec4 _WaveOffset;
out highp vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  highp vec4 temp_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  temp_1 = (((_glesVertex.xzxz * _WaveScale4) / unity_Scale.w) + _WaveOffset);
  highp vec4 tmpvar_3;
  tmpvar_3.w = 1.0;
  tmpvar_3.xyz = _WorldSpaceCameraPos;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = o_4;
  xlv_TEXCOORD1 = temp_1.xy;
  xlv_TEXCOORD2 = temp_1.wz;
  xlv_TEXCOORD3 = (((_World2Object * tmpvar_3).xyz * unity_Scale.w) - _glesVertex.xyz).xzy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _ReflDistort;
uniform sampler2D _ReflectionTex;
uniform sampler2D _ReflectiveColor;
uniform sampler2D _BumpMap;
in highp vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 water_1;
  mediump vec4 color_2;
  mediump vec4 refl_3;
  highp vec4 uv1_4;
  mediump float fresnelFac_5;
  mediump vec3 bump2_6;
  mediump vec3 bump1_7;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((texture (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  bump1_7 = tmpvar_8;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((texture (_BumpMap, xlv_TEXCOORD2).xyz * 2.0) - 1.0);
  bump2_6 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = ((bump1_7 + bump2_6) * 0.5);
  highp float tmpvar_11;
  tmpvar_11 = dot (normalize(xlv_TEXCOORD3), tmpvar_10);
  fresnelFac_5 = tmpvar_11;
  uv1_4.zw = xlv_TEXCOORD0.zw;
  uv1_4.xy = (xlv_TEXCOORD0.xy + (tmpvar_10 * _ReflDistort).xy);
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureProj (_ReflectionTex, uv1_4);
  refl_3 = tmpvar_12;
  lowp vec4 tmpvar_13;
  tmpvar_13 = texture (_ReflectiveColor, vec2(fresnelFac_5));
  water_1 = tmpvar_13;
  color_2.xyz = mix (water_1.xyz, refl_3.xyz, water_1.www);
  color_2.w = (refl_3.w * water_1.w);
  _glesFragData[0] = color_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "WATER_SIMPLE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 _WaveScale4;
uniform highp vec4 _WaveOffset;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 temp_1;
  temp_1 = (((_glesVertex.xzxz * _WaveScale4) / unity_Scale.w) + _WaveOffset);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = temp_1.xy;
  xlv_TEXCOORD1 = temp_1.wz;
  xlv_TEXCOORD2 = (((_World2Object * tmpvar_2).xyz * unity_Scale.w) - _glesVertex.xyz).xzy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _ReflectiveColor;
uniform highp vec4 _HorizonColor;
uniform sampler2D _BumpMap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 water_1;
  mediump vec4 color_2;
  mediump float fresnelFac_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture2D (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture2D (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (normalize(xlv_TEXCOORD2), tmpvar_8);
  fresnelFac_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_ReflectiveColor, vec2(fresnelFac_3));
  water_1 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_1.xyz, _HorizonColor.xyz, water_1.www);
  color_2.xyz = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = _HorizonColor.w;
  color_2.w = tmpvar_12;
  gl_FragData[0] = color_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "WATER_SIMPLE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _World2Object;
uniform highp vec4 unity_Scale;
uniform highp vec4 _WaveScale4;
uniform highp vec4 _WaveOffset;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec4 temp_1;
  temp_1 = (((_glesVertex.xzxz * _WaveScale4) / unity_Scale.w) + _WaveOffset);
  highp vec4 tmpvar_2;
  tmpvar_2.w = 1.0;
  tmpvar_2.xyz = _WorldSpaceCameraPos;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = temp_1.xy;
  xlv_TEXCOORD1 = temp_1.wz;
  xlv_TEXCOORD2 = (((_World2Object * tmpvar_2).xyz * unity_Scale.w) - _glesVertex.xyz).xzy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _ReflectiveColor;
uniform highp vec4 _HorizonColor;
uniform sampler2D _BumpMap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 water_1;
  mediump vec4 color_2;
  mediump float fresnelFac_3;
  mediump vec3 bump2_4;
  mediump vec3 bump1_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = ((texture (_BumpMap, xlv_TEXCOORD0).xyz * 2.0) - 1.0);
  bump1_5 = tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = ((texture (_BumpMap, xlv_TEXCOORD1).xyz * 2.0) - 1.0);
  bump2_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = ((bump1_5 + bump2_4) * 0.5);
  highp float tmpvar_9;
  tmpvar_9 = dot (normalize(xlv_TEXCOORD2), tmpvar_8);
  fresnelFac_3 = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture (_ReflectiveColor, vec2(fresnelFac_3));
  water_1 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (water_1.xyz, _HorizonColor.xyz, water_1.www);
  color_2.xyz = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = _HorizonColor.w;
  color_2.w = tmpvar_12;
  _glesFragData[0] = color_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "WATER_REFRACTIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "WATER_REFRACTIVE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "WATER_REFLECTIVE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "WATER_REFLECTIVE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "WATER_SIMPLE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "WATER_SIMPLE" }
"!!GLES3"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="Opaque" "WaterMode"="Simple" }
 Pass {
  Tags { "RenderType"="Opaque" "WaterMode"="Simple" }
  Color (0.5,0.5,0.5,0.5)
  SetTexture [_MainTex] { Matrix [_WaveMatrix] combine texture * primary }
  SetTexture [_MainTex] { Matrix [_WaveMatrix2] combine texture * primary + previous }
  SetTexture [_ReflectiveColorCube] { Matrix [_Reflection] combine texture +- previous, primary alpha }
 }
}
SubShader { 
 Tags { "RenderType"="Opaque" "WaterMode"="Simple" }
 Pass {
  Tags { "RenderType"="Opaque" "WaterMode"="Simple" }
  Color (0.5,0.5,0.5,0.5)
  SetTexture [_MainTex] { Matrix [_WaveMatrix] combine texture }
  SetTexture [_ReflectiveColorCube] { Matrix [_Reflection] combine texture +- previous, primary alpha }
 }
}
SubShader { 
 Tags { "RenderType"="Opaque" "WaterMode"="Simple" }
 Pass {
  Tags { "RenderType"="Opaque" "WaterMode"="Simple" }
  Color (0.5,0.5,0.5,0)
  SetTexture [_MainTex] { Matrix [_WaveMatrix] combine texture, primary alpha }
 }
}
}