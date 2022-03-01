Shader "Hidden/FXAA III (Console)" {
Properties {
 _MainTex ("-", 2D) = "white" {}
 _EdgeThresholdMin ("Edge threshold min", Float) = 0.125
 _EdgeThreshold ("Edge Threshold", Float) = 0.25
 _EdgeSharpness ("Edge sharpness", Float) = 4
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
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 rcpSize_1;
  highp vec4 extents_2;
  highp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = _glesMultiTexCoord0.xy;
  tmpvar_3 = tmpvar_5;
  highp vec2 cse_6;
  cse_6 = (_MainTex_TexelSize.xy * 0.5);
  extents_2.xy = (_glesMultiTexCoord0.xy - cse_6);
  extents_2.zw = (_glesMultiTexCoord0.xy + cse_6);
  rcpSize_1.xy = (-(_MainTex_TexelSize.xy) * 0.5);
  rcpSize_1.zw = cse_6;
  tmpvar_4.xy = (rcpSize_1.xy * 4.0);
  tmpvar_4.zw = (cse_6 * 4.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = extents_2;
  xlv_TEXCOORD2 = rcpSize_1;
  xlv_TEXCOORD3 = tmpvar_4;
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

uniform sampler2D _MainTex;
uniform mediump float _EdgeThresholdMin;
uniform mediump float _EdgeThreshold;
uniform mediump float _EdgeSharpness;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec2 dir_2;
  mediump float lumaCentre_3;
  mediump float tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = dot (impl_texture2DLodEXT (_MainTex, xlv_TEXCOORD1.xy, 0.0).xyz, vec3(0.22, 0.707, 0.071));
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = dot (impl_texture2DLodEXT (_MainTex, xlv_TEXCOORD1.xw, 0.0).xyz, vec3(0.22, 0.707, 0.071));
  tmpvar_6 = tmpvar_7;
  mediump float tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = dot (impl_texture2DLodEXT (_MainTex, xlv_TEXCOORD1.zy, 0.0).xyz, vec3(0.22, 0.707, 0.071));
  tmpvar_8 = tmpvar_9;
  mediump float tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = dot (impl_texture2DLodEXT (_MainTex, xlv_TEXCOORD1.zw, 0.0).xyz, vec3(0.22, 0.707, 0.071));
  tmpvar_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = impl_texture2DLodEXT (_MainTex, xlv_TEXCOORD0, 0.0);
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12.xyz;
  lowp vec3 c_14;
  c_14 = tmpvar_13;
  lowp float tmpvar_15;
  tmpvar_15 = dot (c_14, vec3(0.22, 0.707, 0.071));
  lumaCentre_3 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (tmpvar_8 + 0.00260417);
  mediump float tmpvar_17;
  tmpvar_17 = max (max (tmpvar_16, tmpvar_10), max (tmpvar_4, tmpvar_6));
  mediump float tmpvar_18;
  tmpvar_18 = min (min (tmpvar_16, tmpvar_10), min (tmpvar_4, tmpvar_6));
  mediump float tmpvar_19;
  tmpvar_19 = max (_EdgeThresholdMin, (tmpvar_17 * _EdgeThreshold));
  mediump float tmpvar_20;
  tmpvar_20 = (tmpvar_6 - tmpvar_16);
  mediump float tmpvar_21;
  tmpvar_21 = (max (tmpvar_17, lumaCentre_3) - min (tmpvar_18, lumaCentre_3));
  mediump float tmpvar_22;
  tmpvar_22 = (tmpvar_10 - tmpvar_4);
  if ((tmpvar_21 < tmpvar_19)) {
    tmpvar_1 = tmpvar_13;
  } else {
    dir_2.x = (tmpvar_20 + tmpvar_22);
    dir_2.y = (tmpvar_20 - tmpvar_22);
    mediump vec2 tmpvar_23;
    tmpvar_23 = normalize(dir_2);
    highp vec4 tmpvar_24;
    tmpvar_24.zw = vec2(0.0, 0.0);
    tmpvar_24.xy = (xlv_TEXCOORD0 - (tmpvar_23 * xlv_TEXCOORD2.zw));
    lowp vec4 tmpvar_25;
    tmpvar_25 = impl_texture2DLodEXT (_MainTex, tmpvar_24.xy, 0.0);
    mediump vec3 tmpvar_26;
    tmpvar_26 = tmpvar_25.xyz;
    highp vec4 tmpvar_27;
    tmpvar_27.zw = vec2(0.0, 0.0);
    tmpvar_27.xy = (xlv_TEXCOORD0 + (tmpvar_23 * xlv_TEXCOORD2.zw));
    lowp vec4 tmpvar_28;
    tmpvar_28 = impl_texture2DLodEXT (_MainTex, tmpvar_27.xy, 0.0);
    mediump vec3 tmpvar_29;
    tmpvar_29 = tmpvar_28.xyz;
    mediump vec2 tmpvar_30;
    tmpvar_30 = clamp ((tmpvar_23 / (
      min (abs(tmpvar_23.x), abs(tmpvar_23.y))
     * _EdgeSharpness)), vec2(-2.0, -2.0), vec2(2.0, 2.0));
    dir_2 = tmpvar_30;
    highp vec4 tmpvar_31;
    tmpvar_31.zw = vec2(0.0, 0.0);
    tmpvar_31.xy = (xlv_TEXCOORD0 - (tmpvar_30 * xlv_TEXCOORD3.zw));
    lowp vec4 tmpvar_32;
    tmpvar_32 = impl_texture2DLodEXT (_MainTex, tmpvar_31.xy, 0.0);
    mediump vec3 tmpvar_33;
    tmpvar_33 = tmpvar_32.xyz;
    highp vec4 tmpvar_34;
    tmpvar_34.zw = vec2(0.0, 0.0);
    tmpvar_34.xy = (xlv_TEXCOORD0 + (tmpvar_30 * xlv_TEXCOORD3.zw));
    lowp vec4 tmpvar_35;
    tmpvar_35 = impl_texture2DLodEXT (_MainTex, tmpvar_34.xy, 0.0);
    mediump vec3 tmpvar_36;
    tmpvar_36 = tmpvar_35.xyz;
    mediump vec3 tmpvar_37;
    tmpvar_37 = (tmpvar_26 + tmpvar_29);
    mediump vec3 tmpvar_38;
    tmpvar_38 = (((tmpvar_33 + tmpvar_36) * 0.25) + (tmpvar_37 * 0.25));
    lowp vec3 c_39;
    c_39 = tmpvar_37;
    lowp float tmpvar_40;
    tmpvar_40 = dot (c_39, vec3(0.22, 0.707, 0.071));
    bool tmpvar_41;
    if ((tmpvar_40 < tmpvar_18)) {
      tmpvar_41 = bool(1);
    } else {
      lowp vec3 c_42;
      c_42 = tmpvar_38;
      tmpvar_41 = (dot (c_42, vec3(0.22, 0.707, 0.071)) > tmpvar_17);
    };
    if (tmpvar_41) {
      tmpvar_1 = (tmpvar_37 * 0.5);
    } else {
      tmpvar_1 = tmpvar_38;
    };
  };
  mediump vec4 tmpvar_43;
  tmpvar_43.w = 1.0;
  tmpvar_43.xyz = tmpvar_1;
  gl_FragData[0] = tmpvar_43;
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
out highp vec4 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec4 rcpSize_1;
  highp vec4 extents_2;
  highp vec2 tmpvar_3;
  highp vec4 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_5 = _glesMultiTexCoord0.xy;
  tmpvar_3 = tmpvar_5;
  highp vec2 cse_6;
  cse_6 = (_MainTex_TexelSize.xy * 0.5);
  extents_2.xy = (_glesMultiTexCoord0.xy - cse_6);
  extents_2.zw = (_glesMultiTexCoord0.xy + cse_6);
  rcpSize_1.xy = (-(_MainTex_TexelSize.xy) * 0.5);
  rcpSize_1.zw = cse_6;
  tmpvar_4.xy = (rcpSize_1.xy * 4.0);
  tmpvar_4.zw = (cse_6 * 4.0);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD1 = extents_2;
  xlv_TEXCOORD2 = rcpSize_1;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump float _EdgeThresholdMin;
uniform mediump float _EdgeThreshold;
uniform mediump float _EdgeSharpness;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec3 tmpvar_1;
  mediump vec2 dir_2;
  mediump float lumaCentre_3;
  mediump float tmpvar_4;
  lowp float tmpvar_5;
  tmpvar_5 = dot (textureLod (_MainTex, xlv_TEXCOORD1.xy, 0.0).xyz, vec3(0.22, 0.707, 0.071));
  tmpvar_4 = tmpvar_5;
  mediump float tmpvar_6;
  lowp float tmpvar_7;
  tmpvar_7 = dot (textureLod (_MainTex, xlv_TEXCOORD1.xw, 0.0).xyz, vec3(0.22, 0.707, 0.071));
  tmpvar_6 = tmpvar_7;
  mediump float tmpvar_8;
  lowp float tmpvar_9;
  tmpvar_9 = dot (textureLod (_MainTex, xlv_TEXCOORD1.zy, 0.0).xyz, vec3(0.22, 0.707, 0.071));
  tmpvar_8 = tmpvar_9;
  mediump float tmpvar_10;
  lowp float tmpvar_11;
  tmpvar_11 = dot (textureLod (_MainTex, xlv_TEXCOORD1.zw, 0.0).xyz, vec3(0.22, 0.707, 0.071));
  tmpvar_10 = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureLod (_MainTex, xlv_TEXCOORD0, 0.0);
  mediump vec3 tmpvar_13;
  tmpvar_13 = tmpvar_12.xyz;
  lowp vec3 c_14;
  c_14 = tmpvar_13;
  lowp float tmpvar_15;
  tmpvar_15 = dot (c_14, vec3(0.22, 0.707, 0.071));
  lumaCentre_3 = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = (tmpvar_8 + 0.00260417);
  mediump float tmpvar_17;
  tmpvar_17 = max (max (tmpvar_16, tmpvar_10), max (tmpvar_4, tmpvar_6));
  mediump float tmpvar_18;
  tmpvar_18 = min (min (tmpvar_16, tmpvar_10), min (tmpvar_4, tmpvar_6));
  mediump float tmpvar_19;
  tmpvar_19 = max (_EdgeThresholdMin, (tmpvar_17 * _EdgeThreshold));
  mediump float tmpvar_20;
  tmpvar_20 = (tmpvar_6 - tmpvar_16);
  mediump float tmpvar_21;
  tmpvar_21 = (max (tmpvar_17, lumaCentre_3) - min (tmpvar_18, lumaCentre_3));
  mediump float tmpvar_22;
  tmpvar_22 = (tmpvar_10 - tmpvar_4);
  if ((tmpvar_21 < tmpvar_19)) {
    tmpvar_1 = tmpvar_13;
  } else {
    dir_2.x = (tmpvar_20 + tmpvar_22);
    dir_2.y = (tmpvar_20 - tmpvar_22);
    mediump vec2 tmpvar_23;
    tmpvar_23 = normalize(dir_2);
    highp vec4 tmpvar_24;
    tmpvar_24.zw = vec2(0.0, 0.0);
    tmpvar_24.xy = (xlv_TEXCOORD0 - (tmpvar_23 * xlv_TEXCOORD2.zw));
    lowp vec4 tmpvar_25;
    tmpvar_25 = textureLod (_MainTex, tmpvar_24.xy, 0.0);
    mediump vec3 tmpvar_26;
    tmpvar_26 = tmpvar_25.xyz;
    highp vec4 tmpvar_27;
    tmpvar_27.zw = vec2(0.0, 0.0);
    tmpvar_27.xy = (xlv_TEXCOORD0 + (tmpvar_23 * xlv_TEXCOORD2.zw));
    lowp vec4 tmpvar_28;
    tmpvar_28 = textureLod (_MainTex, tmpvar_27.xy, 0.0);
    mediump vec3 tmpvar_29;
    tmpvar_29 = tmpvar_28.xyz;
    mediump vec2 tmpvar_30;
    tmpvar_30 = clamp ((tmpvar_23 / (
      min (abs(tmpvar_23.x), abs(tmpvar_23.y))
     * _EdgeSharpness)), vec2(-2.0, -2.0), vec2(2.0, 2.0));
    dir_2 = tmpvar_30;
    highp vec4 tmpvar_31;
    tmpvar_31.zw = vec2(0.0, 0.0);
    tmpvar_31.xy = (xlv_TEXCOORD0 - (tmpvar_30 * xlv_TEXCOORD3.zw));
    lowp vec4 tmpvar_32;
    tmpvar_32 = textureLod (_MainTex, tmpvar_31.xy, 0.0);
    mediump vec3 tmpvar_33;
    tmpvar_33 = tmpvar_32.xyz;
    highp vec4 tmpvar_34;
    tmpvar_34.zw = vec2(0.0, 0.0);
    tmpvar_34.xy = (xlv_TEXCOORD0 + (tmpvar_30 * xlv_TEXCOORD3.zw));
    lowp vec4 tmpvar_35;
    tmpvar_35 = textureLod (_MainTex, tmpvar_34.xy, 0.0);
    mediump vec3 tmpvar_36;
    tmpvar_36 = tmpvar_35.xyz;
    mediump vec3 tmpvar_37;
    tmpvar_37 = (tmpvar_26 + tmpvar_29);
    mediump vec3 tmpvar_38;
    tmpvar_38 = (((tmpvar_33 + tmpvar_36) * 0.25) + (tmpvar_37 * 0.25));
    lowp vec3 c_39;
    c_39 = tmpvar_37;
    lowp float tmpvar_40;
    tmpvar_40 = dot (c_39, vec3(0.22, 0.707, 0.071));
    bool tmpvar_41;
    if ((tmpvar_40 < tmpvar_18)) {
      tmpvar_41 = bool(1);
    } else {
      lowp vec3 c_42;
      c_42 = tmpvar_38;
      tmpvar_41 = (dot (c_42, vec3(0.22, 0.707, 0.071)) > tmpvar_17);
    };
    if (tmpvar_41) {
      tmpvar_1 = (tmpvar_37 * 0.5);
    } else {
      tmpvar_1 = tmpvar_38;
    };
  };
  mediump vec4 tmpvar_43;
  tmpvar_43.w = 1.0;
  tmpvar_43.xyz = tmpvar_1;
  _glesFragData[0] = tmpvar_43;
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