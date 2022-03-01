Shader "Hidden/DLAA" {
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  uv_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = uv_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 sDownRight_2;
  highp vec4 sDownLeft_3;
  highp vec4 sUpRight_4;
  highp vec4 sUpLeft_5;
  highp vec4 sCenter_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  sCenter_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 - _MainTex_TexelSize.xy);
  tmpvar_8 = texture2D (_MainTex, P_9);
  sUpLeft_5 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (vec2(1.0, -1.0) * _MainTex_TexelSize.xy));
  tmpvar_10 = texture2D (_MainTex, P_11);
  sUpRight_4 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (vec2(-1.0, 1.0) * _MainTex_TexelSize.xy));
  tmpvar_12 = texture2D (_MainTex, P_13);
  sDownLeft_3 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + _MainTex_TexelSize.xy);
  tmpvar_14 = texture2D (_MainTex, P_15);
  sDownRight_2 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = sCenter_6.xyz;
  tmpvar_16.w = dot ((4.0 * abs(
    ((((sUpLeft_5 + sUpRight_4) + sDownLeft_3) + sDownRight_2) - (4.0 * sCenter_6))
  )).xyz, vec3(0.33, 0.33, 0.33));
  tmpvar_1 = tmpvar_16;
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
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  uv_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = uv_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 sDownRight_2;
  highp vec4 sDownLeft_3;
  highp vec4 sUpRight_4;
  highp vec4 sUpLeft_5;
  highp vec4 sCenter_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  sCenter_6 = tmpvar_7;
  lowp vec4 tmpvar_8;
  highp vec2 P_9;
  P_9 = (xlv_TEXCOORD0 - _MainTex_TexelSize.xy);
  tmpvar_8 = texture (_MainTex, P_9);
  sUpLeft_5 = tmpvar_8;
  lowp vec4 tmpvar_10;
  highp vec2 P_11;
  P_11 = (xlv_TEXCOORD0 + (vec2(1.0, -1.0) * _MainTex_TexelSize.xy));
  tmpvar_10 = texture (_MainTex, P_11);
  sUpRight_4 = tmpvar_10;
  lowp vec4 tmpvar_12;
  highp vec2 P_13;
  P_13 = (xlv_TEXCOORD0 + (vec2(-1.0, 1.0) * _MainTex_TexelSize.xy));
  tmpvar_12 = texture (_MainTex, P_13);
  sDownLeft_3 = tmpvar_12;
  lowp vec4 tmpvar_14;
  highp vec2 P_15;
  P_15 = (xlv_TEXCOORD0 + _MainTex_TexelSize.xy);
  tmpvar_14 = texture (_MainTex, P_15);
  sDownRight_2 = tmpvar_14;
  highp vec4 tmpvar_16;
  tmpvar_16.xyz = sCenter_6.xyz;
  tmpvar_16.w = dot ((4.0 * abs(
    ((((sUpLeft_5 + sUpRight_4) + sDownLeft_3) + sDownRight_2) - (4.0 * sCenter_6))
  )).xyz, vec3(0.33, 0.33, 0.33));
  tmpvar_1 = tmpvar_16;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  uv_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = uv_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 bottom_2;
  highp vec4 top_3;
  highp vec4 right_4;
  highp vec4 left_5;
  highp vec4 v7_6;
  highp vec4 v6_7;
  highp vec4 v5_8;
  highp vec4 v4_9;
  highp vec4 v3_10;
  highp vec4 v2_11;
  highp vec4 v1_12;
  highp vec4 v0_13;
  highp vec4 h7_14;
  highp vec4 h6_15;
  highp vec4 h5_16;
  highp vec4 h4_17;
  highp vec4 h3_18;
  highp vec4 h2_19;
  highp vec4 h1_20;
  highp vec4 h0_21;
  highp vec4 clr_22;
  highp vec4 bottom_01_23;
  highp vec4 top_01_24;
  highp vec4 right_01_25;
  highp vec4 left_01_26;
  highp vec4 center_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MainTex, xlv_TEXCOORD0);
  center_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  highp vec2 cse_31;
  cse_31 = (vec2(-1.5, 0.0) * _MainTex_TexelSize.xy);
  P_30 = (xlv_TEXCOORD0 + cse_31);
  tmpvar_29 = texture2D (_MainTex, P_30);
  left_01_26 = tmpvar_29;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  highp vec2 cse_34;
  cse_34 = (vec2(1.5, 0.0) * _MainTex_TexelSize.xy);
  P_33 = (xlv_TEXCOORD0 + cse_34);
  tmpvar_32 = texture2D (_MainTex, P_33);
  right_01_25 = tmpvar_32;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  highp vec2 cse_37;
  cse_37 = (vec2(0.0, -1.5) * _MainTex_TexelSize.xy);
  P_36 = (xlv_TEXCOORD0 + cse_37);
  tmpvar_35 = texture2D (_MainTex, P_36);
  top_01_24 = tmpvar_35;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  highp vec2 cse_40;
  cse_40 = (vec2(0.0, 1.5) * _MainTex_TexelSize.xy);
  P_39 = (xlv_TEXCOORD0 + cse_40);
  tmpvar_38 = texture2D (_MainTex, P_39);
  bottom_01_23 = tmpvar_38;
  highp vec4 tmpvar_41;
  tmpvar_41 = (2.0 * (left_01_26 + right_01_25));
  highp vec4 tmpvar_42;
  tmpvar_42 = (2.0 * (top_01_24 + bottom_01_23));
  highp vec4 tmpvar_43;
  tmpvar_43 = ((tmpvar_41 + (2.0 * center_27)) / 6.0);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_42 + (2.0 * center_27)) / 6.0);
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (mix (center_27, tmpvar_43, vec4(clamp (
    (((3.0 * dot (
      (abs((tmpvar_42 - (4.0 * center_27))) / 4.0)
    .xyz, vec3(0.33, 0.33, 0.33))) - 0.1) / dot (tmpvar_43.xyz, vec3(0.33, 0.33, 0.33)))
  , 0.0, 1.0))), tmpvar_44, vec4(clamp ((
    ((3.0 * dot ((
      abs((tmpvar_41 - (4.0 * center_27)))
     / 4.0).xyz, vec3(0.33, 0.33, 0.33))) - 0.1)
   / 
    dot (tmpvar_44.xyz, vec3(0.33, 0.33, 0.33))
  ), 0.0, 1.0)));
  clr_22 = tmpvar_45;
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = (xlv_TEXCOORD0 + cse_34);
  tmpvar_46 = texture2D (_MainTex, P_47);
  h0_21 = tmpvar_46;
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (xlv_TEXCOORD0 + (vec2(3.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_48 = texture2D (_MainTex, P_49);
  h1_20 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = (xlv_TEXCOORD0 + (vec2(5.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_50 = texture2D (_MainTex, P_51);
  h2_19 = tmpvar_50;
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (xlv_TEXCOORD0 + (vec2(7.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_52 = texture2D (_MainTex, P_53);
  h3_18 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = (xlv_TEXCOORD0 + cse_31);
  tmpvar_54 = texture2D (_MainTex, P_55);
  h4_17 = tmpvar_54;
  lowp vec4 tmpvar_56;
  highp vec2 P_57;
  P_57 = (xlv_TEXCOORD0 + (vec2(-3.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_56 = texture2D (_MainTex, P_57);
  h5_16 = tmpvar_56;
  lowp vec4 tmpvar_58;
  highp vec2 P_59;
  P_59 = (xlv_TEXCOORD0 + (vec2(-5.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_58 = texture2D (_MainTex, P_59);
  h6_15 = tmpvar_58;
  lowp vec4 tmpvar_60;
  highp vec2 P_61;
  P_61 = (xlv_TEXCOORD0 + (vec2(-7.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_60 = texture2D (_MainTex, P_61);
  h7_14 = tmpvar_60;
  lowp vec4 tmpvar_62;
  highp vec2 P_63;
  P_63 = (xlv_TEXCOORD0 + cse_40);
  tmpvar_62 = texture2D (_MainTex, P_63);
  v0_13 = tmpvar_62;
  lowp vec4 tmpvar_64;
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD0 + (vec2(0.0, 3.5) * _MainTex_TexelSize.xy));
  tmpvar_64 = texture2D (_MainTex, P_65);
  v1_12 = tmpvar_64;
  lowp vec4 tmpvar_66;
  highp vec2 P_67;
  P_67 = (xlv_TEXCOORD0 + (vec2(0.0, 5.5) * _MainTex_TexelSize.xy));
  tmpvar_66 = texture2D (_MainTex, P_67);
  v2_11 = tmpvar_66;
  lowp vec4 tmpvar_68;
  highp vec2 P_69;
  P_69 = (xlv_TEXCOORD0 + (vec2(0.0, 7.5) * _MainTex_TexelSize.xy));
  tmpvar_68 = texture2D (_MainTex, P_69);
  v3_10 = tmpvar_68;
  lowp vec4 tmpvar_70;
  highp vec2 P_71;
  P_71 = (xlv_TEXCOORD0 + cse_37);
  tmpvar_70 = texture2D (_MainTex, P_71);
  v4_9 = tmpvar_70;
  lowp vec4 tmpvar_72;
  highp vec2 P_73;
  P_73 = (xlv_TEXCOORD0 + (vec2(0.0, -3.5) * _MainTex_TexelSize.xy));
  tmpvar_72 = texture2D (_MainTex, P_73);
  v5_8 = tmpvar_72;
  lowp vec4 tmpvar_74;
  highp vec2 P_75;
  P_75 = (xlv_TEXCOORD0 + (vec2(0.0, -5.5) * _MainTex_TexelSize.xy));
  tmpvar_74 = texture2D (_MainTex, P_75);
  v6_7 = tmpvar_74;
  lowp vec4 tmpvar_76;
  highp vec2 P_77;
  P_77 = (xlv_TEXCOORD0 + (vec2(0.0, -7.5) * _MainTex_TexelSize.xy));
  tmpvar_76 = texture2D (_MainTex, P_77);
  v7_6 = tmpvar_76;
  highp float tmpvar_78;
  tmpvar_78 = clamp (((
    ((((
      ((((h0_21.w + h1_20.w) + h2_19.w) + h3_18.w) + h4_17.w)
     + h5_16.w) + h6_15.w) + h7_14.w) / 8.0)
   * 2.0) - 1.0), 0.0, 1.0);
  highp float tmpvar_79;
  tmpvar_79 = clamp (((
    ((((
      ((((v0_13.w + v1_12.w) + v2_11.w) + v3_10.w) + v4_9.w)
     + v5_8.w) + v6_7.w) + v7_6.w) / 8.0)
   * 2.0) - 1.0), 0.0, 1.0);
  lowp vec4 tmpvar_80;
  highp vec2 P_81;
  P_81 = (xlv_TEXCOORD0 + (vec2(-1.0, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_80 = texture2D (_MainTex, P_81);
  left_5 = tmpvar_80;
  lowp vec4 tmpvar_82;
  highp vec2 P_83;
  P_83 = (xlv_TEXCOORD0 + (vec2(1.0, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_82 = texture2D (_MainTex, P_83);
  right_4 = tmpvar_82;
  lowp vec4 tmpvar_84;
  highp vec2 P_85;
  P_85 = (xlv_TEXCOORD0 + (vec2(0.0, -1.0) * _MainTex_TexelSize.xy));
  tmpvar_84 = texture2D (_MainTex, P_85);
  top_3 = tmpvar_84;
  lowp vec4 tmpvar_86;
  highp vec2 P_87;
  P_87 = (xlv_TEXCOORD0 + (vec2(0.0, 1.0) * _MainTex_TexelSize.xy));
  tmpvar_86 = texture2D (_MainTex, P_87);
  bottom_2 = tmpvar_86;
  if (((tmpvar_78 > 0.0) || (tmpvar_79 > 0.0))) {
    highp float tmpvar_88;
    tmpvar_88 = dot (((
      ((((
        ((h0_21 + h1_20) + h2_19)
       + h3_18) + h4_17) + h5_16) + h6_15)
     + h7_14) / 8.0).xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_89;
    tmpvar_89 = dot (((
      ((((
        ((v0_13 + v1_12) + v2_11)
       + v3_10) + v4_9) + v5_8) + v6_7)
     + v7_6) / 8.0).xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_90;
    tmpvar_90 = dot (center_27.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_91;
    tmpvar_91 = dot (left_5.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_92;
    tmpvar_92 = dot (right_4.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_93;
    tmpvar_93 = dot (top_3.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_94;
    tmpvar_94 = dot (bottom_2.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_95;
    if ((tmpvar_90 == tmpvar_93)) {
      tmpvar_95 = 0.0;
    } else {
      tmpvar_95 = clamp (((tmpvar_88 - tmpvar_93) / (tmpvar_90 - tmpvar_93)), 0.0, 1.0);
    };
    highp float tmpvar_96;
    if ((tmpvar_90 == tmpvar_94)) {
      tmpvar_96 = 0.0;
    } else {
      tmpvar_96 = clamp ((1.0 + (
        (tmpvar_88 - tmpvar_90)
       / 
        (tmpvar_90 - tmpvar_94)
      )), 0.0, 1.0);
    };
    highp float tmpvar_97;
    if ((tmpvar_90 == tmpvar_91)) {
      tmpvar_97 = 0.0;
    } else {
      tmpvar_97 = clamp (((tmpvar_89 - tmpvar_91) / (tmpvar_90 - tmpvar_91)), 0.0, 1.0);
    };
    highp float tmpvar_98;
    if ((tmpvar_90 == tmpvar_92)) {
      tmpvar_98 = 0.0;
    } else {
      tmpvar_98 = clamp ((1.0 + (
        (tmpvar_89 - tmpvar_90)
       / 
        (tmpvar_90 - tmpvar_92)
      )), 0.0, 1.0);
    };
    clr_22 = mix (mix (tmpvar_45, mix (right_4, 
      mix (left_5, center_27, vec4(tmpvar_97))
    , vec4(tmpvar_98)), vec4(tmpvar_79)), mix (bottom_2, mix (top_3, center_27, vec4(tmpvar_95)), vec4(tmpvar_96)), vec4(tmpvar_78));
  };
  tmpvar_1 = clr_22;
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
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  uv_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = uv_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 bottom_2;
  highp vec4 top_3;
  highp vec4 right_4;
  highp vec4 left_5;
  highp vec4 v7_6;
  highp vec4 v6_7;
  highp vec4 v5_8;
  highp vec4 v4_9;
  highp vec4 v3_10;
  highp vec4 v2_11;
  highp vec4 v1_12;
  highp vec4 v0_13;
  highp vec4 h7_14;
  highp vec4 h6_15;
  highp vec4 h5_16;
  highp vec4 h4_17;
  highp vec4 h3_18;
  highp vec4 h2_19;
  highp vec4 h1_20;
  highp vec4 h0_21;
  highp vec4 clr_22;
  highp vec4 bottom_01_23;
  highp vec4 top_01_24;
  highp vec4 right_01_25;
  highp vec4 left_01_26;
  highp vec4 center_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture (_MainTex, xlv_TEXCOORD0);
  center_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  highp vec2 cse_31;
  cse_31 = (vec2(-1.5, 0.0) * _MainTex_TexelSize.xy);
  P_30 = (xlv_TEXCOORD0 + cse_31);
  tmpvar_29 = texture (_MainTex, P_30);
  left_01_26 = tmpvar_29;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  highp vec2 cse_34;
  cse_34 = (vec2(1.5, 0.0) * _MainTex_TexelSize.xy);
  P_33 = (xlv_TEXCOORD0 + cse_34);
  tmpvar_32 = texture (_MainTex, P_33);
  right_01_25 = tmpvar_32;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  highp vec2 cse_37;
  cse_37 = (vec2(0.0, -1.5) * _MainTex_TexelSize.xy);
  P_36 = (xlv_TEXCOORD0 + cse_37);
  tmpvar_35 = texture (_MainTex, P_36);
  top_01_24 = tmpvar_35;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  highp vec2 cse_40;
  cse_40 = (vec2(0.0, 1.5) * _MainTex_TexelSize.xy);
  P_39 = (xlv_TEXCOORD0 + cse_40);
  tmpvar_38 = texture (_MainTex, P_39);
  bottom_01_23 = tmpvar_38;
  highp vec4 tmpvar_41;
  tmpvar_41 = (2.0 * (left_01_26 + right_01_25));
  highp vec4 tmpvar_42;
  tmpvar_42 = (2.0 * (top_01_24 + bottom_01_23));
  highp vec4 tmpvar_43;
  tmpvar_43 = ((tmpvar_41 + (2.0 * center_27)) / 6.0);
  highp vec4 tmpvar_44;
  tmpvar_44 = ((tmpvar_42 + (2.0 * center_27)) / 6.0);
  highp vec4 tmpvar_45;
  tmpvar_45 = mix (mix (center_27, tmpvar_43, vec4(clamp (
    (((3.0 * dot (
      (abs((tmpvar_42 - (4.0 * center_27))) / 4.0)
    .xyz, vec3(0.33, 0.33, 0.33))) - 0.1) / dot (tmpvar_43.xyz, vec3(0.33, 0.33, 0.33)))
  , 0.0, 1.0))), tmpvar_44, vec4(clamp ((
    ((3.0 * dot ((
      abs((tmpvar_41 - (4.0 * center_27)))
     / 4.0).xyz, vec3(0.33, 0.33, 0.33))) - 0.1)
   / 
    dot (tmpvar_44.xyz, vec3(0.33, 0.33, 0.33))
  ), 0.0, 1.0)));
  clr_22 = tmpvar_45;
  lowp vec4 tmpvar_46;
  highp vec2 P_47;
  P_47 = (xlv_TEXCOORD0 + cse_34);
  tmpvar_46 = texture (_MainTex, P_47);
  h0_21 = tmpvar_46;
  lowp vec4 tmpvar_48;
  highp vec2 P_49;
  P_49 = (xlv_TEXCOORD0 + (vec2(3.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_48 = texture (_MainTex, P_49);
  h1_20 = tmpvar_48;
  lowp vec4 tmpvar_50;
  highp vec2 P_51;
  P_51 = (xlv_TEXCOORD0 + (vec2(5.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_50 = texture (_MainTex, P_51);
  h2_19 = tmpvar_50;
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (xlv_TEXCOORD0 + (vec2(7.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_52 = texture (_MainTex, P_53);
  h3_18 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = (xlv_TEXCOORD0 + cse_31);
  tmpvar_54 = texture (_MainTex, P_55);
  h4_17 = tmpvar_54;
  lowp vec4 tmpvar_56;
  highp vec2 P_57;
  P_57 = (xlv_TEXCOORD0 + (vec2(-3.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_56 = texture (_MainTex, P_57);
  h5_16 = tmpvar_56;
  lowp vec4 tmpvar_58;
  highp vec2 P_59;
  P_59 = (xlv_TEXCOORD0 + (vec2(-5.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_58 = texture (_MainTex, P_59);
  h6_15 = tmpvar_58;
  lowp vec4 tmpvar_60;
  highp vec2 P_61;
  P_61 = (xlv_TEXCOORD0 + (vec2(-7.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_60 = texture (_MainTex, P_61);
  h7_14 = tmpvar_60;
  lowp vec4 tmpvar_62;
  highp vec2 P_63;
  P_63 = (xlv_TEXCOORD0 + cse_40);
  tmpvar_62 = texture (_MainTex, P_63);
  v0_13 = tmpvar_62;
  lowp vec4 tmpvar_64;
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD0 + (vec2(0.0, 3.5) * _MainTex_TexelSize.xy));
  tmpvar_64 = texture (_MainTex, P_65);
  v1_12 = tmpvar_64;
  lowp vec4 tmpvar_66;
  highp vec2 P_67;
  P_67 = (xlv_TEXCOORD0 + (vec2(0.0, 5.5) * _MainTex_TexelSize.xy));
  tmpvar_66 = texture (_MainTex, P_67);
  v2_11 = tmpvar_66;
  lowp vec4 tmpvar_68;
  highp vec2 P_69;
  P_69 = (xlv_TEXCOORD0 + (vec2(0.0, 7.5) * _MainTex_TexelSize.xy));
  tmpvar_68 = texture (_MainTex, P_69);
  v3_10 = tmpvar_68;
  lowp vec4 tmpvar_70;
  highp vec2 P_71;
  P_71 = (xlv_TEXCOORD0 + cse_37);
  tmpvar_70 = texture (_MainTex, P_71);
  v4_9 = tmpvar_70;
  lowp vec4 tmpvar_72;
  highp vec2 P_73;
  P_73 = (xlv_TEXCOORD0 + (vec2(0.0, -3.5) * _MainTex_TexelSize.xy));
  tmpvar_72 = texture (_MainTex, P_73);
  v5_8 = tmpvar_72;
  lowp vec4 tmpvar_74;
  highp vec2 P_75;
  P_75 = (xlv_TEXCOORD0 + (vec2(0.0, -5.5) * _MainTex_TexelSize.xy));
  tmpvar_74 = texture (_MainTex, P_75);
  v6_7 = tmpvar_74;
  lowp vec4 tmpvar_76;
  highp vec2 P_77;
  P_77 = (xlv_TEXCOORD0 + (vec2(0.0, -7.5) * _MainTex_TexelSize.xy));
  tmpvar_76 = texture (_MainTex, P_77);
  v7_6 = tmpvar_76;
  highp float tmpvar_78;
  tmpvar_78 = clamp (((
    ((((
      ((((h0_21.w + h1_20.w) + h2_19.w) + h3_18.w) + h4_17.w)
     + h5_16.w) + h6_15.w) + h7_14.w) / 8.0)
   * 2.0) - 1.0), 0.0, 1.0);
  highp float tmpvar_79;
  tmpvar_79 = clamp (((
    ((((
      ((((v0_13.w + v1_12.w) + v2_11.w) + v3_10.w) + v4_9.w)
     + v5_8.w) + v6_7.w) + v7_6.w) / 8.0)
   * 2.0) - 1.0), 0.0, 1.0);
  lowp vec4 tmpvar_80;
  highp vec2 P_81;
  P_81 = (xlv_TEXCOORD0 + (vec2(-1.0, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_80 = texture (_MainTex, P_81);
  left_5 = tmpvar_80;
  lowp vec4 tmpvar_82;
  highp vec2 P_83;
  P_83 = (xlv_TEXCOORD0 + (vec2(1.0, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_82 = texture (_MainTex, P_83);
  right_4 = tmpvar_82;
  lowp vec4 tmpvar_84;
  highp vec2 P_85;
  P_85 = (xlv_TEXCOORD0 + (vec2(0.0, -1.0) * _MainTex_TexelSize.xy));
  tmpvar_84 = texture (_MainTex, P_85);
  top_3 = tmpvar_84;
  lowp vec4 tmpvar_86;
  highp vec2 P_87;
  P_87 = (xlv_TEXCOORD0 + (vec2(0.0, 1.0) * _MainTex_TexelSize.xy));
  tmpvar_86 = texture (_MainTex, P_87);
  bottom_2 = tmpvar_86;
  if (((tmpvar_78 > 0.0) || (tmpvar_79 > 0.0))) {
    highp float tmpvar_88;
    tmpvar_88 = dot (((
      ((((
        ((h0_21 + h1_20) + h2_19)
       + h3_18) + h4_17) + h5_16) + h6_15)
     + h7_14) / 8.0).xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_89;
    tmpvar_89 = dot (((
      ((((
        ((v0_13 + v1_12) + v2_11)
       + v3_10) + v4_9) + v5_8) + v6_7)
     + v7_6) / 8.0).xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_90;
    tmpvar_90 = dot (center_27.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_91;
    tmpvar_91 = dot (left_5.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_92;
    tmpvar_92 = dot (right_4.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_93;
    tmpvar_93 = dot (top_3.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_94;
    tmpvar_94 = dot (bottom_2.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_95;
    if ((tmpvar_90 == tmpvar_93)) {
      tmpvar_95 = 0.0;
    } else {
      tmpvar_95 = clamp (((tmpvar_88 - tmpvar_93) / (tmpvar_90 - tmpvar_93)), 0.0, 1.0);
    };
    highp float tmpvar_96;
    if ((tmpvar_90 == tmpvar_94)) {
      tmpvar_96 = 0.0;
    } else {
      tmpvar_96 = clamp ((1.0 + (
        (tmpvar_88 - tmpvar_90)
       / 
        (tmpvar_90 - tmpvar_94)
      )), 0.0, 1.0);
    };
    highp float tmpvar_97;
    if ((tmpvar_90 == tmpvar_91)) {
      tmpvar_97 = 0.0;
    } else {
      tmpvar_97 = clamp (((tmpvar_89 - tmpvar_91) / (tmpvar_90 - tmpvar_91)), 0.0, 1.0);
    };
    highp float tmpvar_98;
    if ((tmpvar_90 == tmpvar_92)) {
      tmpvar_98 = 0.0;
    } else {
      tmpvar_98 = clamp ((1.0 + (
        (tmpvar_89 - tmpvar_90)
       / 
        (tmpvar_90 - tmpvar_92)
      )), 0.0, 1.0);
    };
    clr_22 = mix (mix (tmpvar_45, mix (right_4, 
      mix (left_5, center_27, vec4(tmpvar_97))
    , vec4(tmpvar_98)), vec4(tmpvar_79)), mix (bottom_2, mix (top_3, center_27, vec4(tmpvar_95)), vec4(tmpvar_96)), vec4(tmpvar_78));
  };
  tmpvar_1 = clr_22;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  uv_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = uv_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 v7_2;
  highp vec4 v6_3;
  highp vec4 v5_4;
  highp vec4 v4_5;
  highp vec4 v3_6;
  highp vec4 v2_7;
  highp vec4 v1_8;
  highp vec4 v0_9;
  highp vec4 h7_10;
  highp vec4 h6_11;
  highp vec4 h5_12;
  highp vec4 h4_13;
  highp vec4 h3_14;
  highp vec4 h2_15;
  highp vec4 h1_16;
  highp vec4 h0_17;
  highp vec4 clr_18;
  highp vec4 bottom_19;
  highp vec4 top_20;
  highp vec4 right_21;
  highp vec4 left_22;
  highp vec4 bottom_01_23;
  highp vec4 top_01_24;
  highp vec4 right_01_25;
  highp vec4 left_01_26;
  highp vec4 center_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture2D (_MainTex, xlv_TEXCOORD0);
  center_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  highp vec2 cse_31;
  cse_31 = (vec2(-1.5, 0.0) * _MainTex_TexelSize.xy);
  P_30 = (xlv_TEXCOORD0 + cse_31);
  tmpvar_29 = texture2D (_MainTex, P_30);
  left_01_26 = tmpvar_29;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  highp vec2 cse_34;
  cse_34 = (vec2(1.5, 0.0) * _MainTex_TexelSize.xy);
  P_33 = (xlv_TEXCOORD0 + cse_34);
  tmpvar_32 = texture2D (_MainTex, P_33);
  right_01_25 = tmpvar_32;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  highp vec2 cse_37;
  cse_37 = (vec2(0.0, -1.5) * _MainTex_TexelSize.xy);
  P_36 = (xlv_TEXCOORD0 + cse_37);
  tmpvar_35 = texture2D (_MainTex, P_36);
  top_01_24 = tmpvar_35;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  highp vec2 cse_40;
  cse_40 = (vec2(0.0, 1.5) * _MainTex_TexelSize.xy);
  P_39 = (xlv_TEXCOORD0 + cse_40);
  tmpvar_38 = texture2D (_MainTex, P_39);
  bottom_01_23 = tmpvar_38;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (vec2(-1.0, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_41 = texture2D (_MainTex, P_42);
  left_22 = tmpvar_41;
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (vec2(1.0, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_43 = texture2D (_MainTex, P_44);
  right_21 = tmpvar_43;
  lowp vec4 tmpvar_45;
  highp vec2 P_46;
  P_46 = (xlv_TEXCOORD0 + (vec2(0.0, -1.0) * _MainTex_TexelSize.xy));
  tmpvar_45 = texture2D (_MainTex, P_46);
  top_20 = tmpvar_45;
  lowp vec4 tmpvar_47;
  highp vec2 P_48;
  P_48 = (xlv_TEXCOORD0 + (vec2(0.0, 1.0) * _MainTex_TexelSize.xy));
  tmpvar_47 = texture2D (_MainTex, P_48);
  bottom_19 = tmpvar_47;
  highp vec4 tmpvar_49;
  tmpvar_49 = (((2.0 * 
    (left_01_26 + right_01_25)
  ) + (2.0 * center_27)) / 6.0);
  highp vec4 tmpvar_50;
  tmpvar_50 = (((2.0 * 
    (top_01_24 + bottom_01_23)
  ) + (2.0 * center_27)) / 6.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (mix (center_27, tmpvar_49, vec4(clamp (
    (((3.0 * dot (
      (abs(((top_20 + bottom_19) - (2.0 * center_27))) / 2.0)
    .xyz, vec3(0.33, 0.33, 0.33))) - 0.1) / dot (tmpvar_49.xyz, vec3(0.33, 0.33, 0.33)))
  , 0.0, 1.0))), tmpvar_50, vec4((clamp (
    (((3.0 * dot (
      (abs(((left_22 + right_21) - (2.0 * center_27))) / 2.0)
    .xyz, vec3(0.33, 0.33, 0.33))) - 0.1) / dot (tmpvar_50.xyz, vec3(0.33, 0.33, 0.33)))
  , 0.0, 1.0) * 0.5)));
  clr_18 = tmpvar_51;
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (xlv_TEXCOORD0 + cse_34);
  tmpvar_52 = texture2D (_MainTex, P_53);
  h0_17 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = (xlv_TEXCOORD0 + (vec2(3.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_54 = texture2D (_MainTex, P_55);
  h1_16 = tmpvar_54;
  lowp vec4 tmpvar_56;
  highp vec2 P_57;
  P_57 = (xlv_TEXCOORD0 + (vec2(5.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_56 = texture2D (_MainTex, P_57);
  h2_15 = tmpvar_56;
  lowp vec4 tmpvar_58;
  highp vec2 P_59;
  P_59 = (xlv_TEXCOORD0 + (vec2(7.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_58 = texture2D (_MainTex, P_59);
  h3_14 = tmpvar_58;
  lowp vec4 tmpvar_60;
  highp vec2 P_61;
  P_61 = (xlv_TEXCOORD0 + cse_31);
  tmpvar_60 = texture2D (_MainTex, P_61);
  h4_13 = tmpvar_60;
  lowp vec4 tmpvar_62;
  highp vec2 P_63;
  P_63 = (xlv_TEXCOORD0 + (vec2(-3.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_62 = texture2D (_MainTex, P_63);
  h5_12 = tmpvar_62;
  lowp vec4 tmpvar_64;
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD0 + (vec2(-5.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_64 = texture2D (_MainTex, P_65);
  h6_11 = tmpvar_64;
  lowp vec4 tmpvar_66;
  highp vec2 P_67;
  P_67 = (xlv_TEXCOORD0 + (vec2(-7.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_66 = texture2D (_MainTex, P_67);
  h7_10 = tmpvar_66;
  lowp vec4 tmpvar_68;
  highp vec2 P_69;
  P_69 = (xlv_TEXCOORD0 + cse_40);
  tmpvar_68 = texture2D (_MainTex, P_69);
  v0_9 = tmpvar_68;
  lowp vec4 tmpvar_70;
  highp vec2 P_71;
  P_71 = (xlv_TEXCOORD0 + (vec2(0.0, 3.5) * _MainTex_TexelSize.xy));
  tmpvar_70 = texture2D (_MainTex, P_71);
  v1_8 = tmpvar_70;
  lowp vec4 tmpvar_72;
  highp vec2 P_73;
  P_73 = (xlv_TEXCOORD0 + (vec2(0.0, 5.5) * _MainTex_TexelSize.xy));
  tmpvar_72 = texture2D (_MainTex, P_73);
  v2_7 = tmpvar_72;
  lowp vec4 tmpvar_74;
  highp vec2 P_75;
  P_75 = (xlv_TEXCOORD0 + (vec2(0.0, 7.5) * _MainTex_TexelSize.xy));
  tmpvar_74 = texture2D (_MainTex, P_75);
  v3_6 = tmpvar_74;
  lowp vec4 tmpvar_76;
  highp vec2 P_77;
  P_77 = (xlv_TEXCOORD0 + cse_37);
  tmpvar_76 = texture2D (_MainTex, P_77);
  v4_5 = tmpvar_76;
  lowp vec4 tmpvar_78;
  highp vec2 P_79;
  P_79 = (xlv_TEXCOORD0 + (vec2(0.0, -3.5) * _MainTex_TexelSize.xy));
  tmpvar_78 = texture2D (_MainTex, P_79);
  v5_4 = tmpvar_78;
  lowp vec4 tmpvar_80;
  highp vec2 P_81;
  P_81 = (xlv_TEXCOORD0 + (vec2(0.0, -5.5) * _MainTex_TexelSize.xy));
  tmpvar_80 = texture2D (_MainTex, P_81);
  v6_3 = tmpvar_80;
  lowp vec4 tmpvar_82;
  highp vec2 P_83;
  P_83 = (xlv_TEXCOORD0 + (vec2(0.0, -7.5) * _MainTex_TexelSize.xy));
  tmpvar_82 = texture2D (_MainTex, P_83);
  v7_2 = tmpvar_82;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((
    ((((
      ((((h0_17.w + h1_16.w) + h2_15.w) + h3_14.w) + h4_13.w)
     + h5_12.w) + h6_11.w) + h7_10.w) / 8.0)
   * 2.0) - 1.0), 0.0, 1.0);
  highp float tmpvar_85;
  tmpvar_85 = clamp (((
    ((((
      ((((v0_9.w + v1_8.w) + v2_7.w) + v3_6.w) + v4_5.w)
     + v5_4.w) + v6_3.w) + v7_2.w) / 8.0)
   * 2.0) - 1.0), 0.0, 1.0);
  highp float tmpvar_86;
  tmpvar_86 = abs((tmpvar_84 - tmpvar_85));
  if ((tmpvar_86 > 0.2)) {
    highp float tmpvar_87;
    tmpvar_87 = dot (((
      ((((
        ((h0_17 + h1_16) + h2_15)
       + h3_14) + h4_13) + h5_12) + h6_11)
     + h7_10) / 8.0).xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_88;
    tmpvar_88 = dot (((
      ((((
        ((v0_9 + v1_8) + v2_7)
       + v3_6) + v4_5) + v5_4) + v6_3)
     + v7_2) / 8.0).xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_89;
    tmpvar_89 = dot (center_27.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_90;
    tmpvar_90 = dot (left_22.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_91;
    tmpvar_91 = dot (right_21.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_92;
    tmpvar_92 = dot (top_20.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_93;
    tmpvar_93 = dot (bottom_19.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_94;
    if ((tmpvar_89 == tmpvar_92)) {
      tmpvar_94 = 0.0;
    } else {
      tmpvar_94 = clamp (((tmpvar_87 - tmpvar_92) / (tmpvar_89 - tmpvar_92)), 0.0, 1.0);
    };
    highp float tmpvar_95;
    if ((tmpvar_89 == tmpvar_93)) {
      tmpvar_95 = 0.0;
    } else {
      tmpvar_95 = clamp ((1.0 + (
        (tmpvar_87 - tmpvar_89)
       / 
        (tmpvar_89 - tmpvar_93)
      )), 0.0, 1.0);
    };
    highp float tmpvar_96;
    if ((tmpvar_89 == tmpvar_90)) {
      tmpvar_96 = 0.0;
    } else {
      tmpvar_96 = clamp (((tmpvar_88 - tmpvar_90) / (tmpvar_89 - tmpvar_90)), 0.0, 1.0);
    };
    highp float tmpvar_97;
    if ((tmpvar_89 == tmpvar_91)) {
      tmpvar_97 = 0.0;
    } else {
      tmpvar_97 = clamp ((1.0 + (
        (tmpvar_88 - tmpvar_89)
       / 
        (tmpvar_89 - tmpvar_91)
      )), 0.0, 1.0);
    };
    clr_18 = mix (mix (tmpvar_51, mix (right_21, 
      mix (left_22, center_27, vec4(tmpvar_96))
    , vec4(tmpvar_97)), vec4(tmpvar_85)), mix (bottom_19, mix (top_20, center_27, vec4(tmpvar_94)), vec4(tmpvar_95)), vec4(tmpvar_84));
  };
  tmpvar_1 = clr_18;
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
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 uv_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  uv_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = uv_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 v7_2;
  highp vec4 v6_3;
  highp vec4 v5_4;
  highp vec4 v4_5;
  highp vec4 v3_6;
  highp vec4 v2_7;
  highp vec4 v1_8;
  highp vec4 v0_9;
  highp vec4 h7_10;
  highp vec4 h6_11;
  highp vec4 h5_12;
  highp vec4 h4_13;
  highp vec4 h3_14;
  highp vec4 h2_15;
  highp vec4 h1_16;
  highp vec4 h0_17;
  highp vec4 clr_18;
  highp vec4 bottom_19;
  highp vec4 top_20;
  highp vec4 right_21;
  highp vec4 left_22;
  highp vec4 bottom_01_23;
  highp vec4 top_01_24;
  highp vec4 right_01_25;
  highp vec4 left_01_26;
  highp vec4 center_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = texture (_MainTex, xlv_TEXCOORD0);
  center_27 = tmpvar_28;
  lowp vec4 tmpvar_29;
  highp vec2 P_30;
  highp vec2 cse_31;
  cse_31 = (vec2(-1.5, 0.0) * _MainTex_TexelSize.xy);
  P_30 = (xlv_TEXCOORD0 + cse_31);
  tmpvar_29 = texture (_MainTex, P_30);
  left_01_26 = tmpvar_29;
  lowp vec4 tmpvar_32;
  highp vec2 P_33;
  highp vec2 cse_34;
  cse_34 = (vec2(1.5, 0.0) * _MainTex_TexelSize.xy);
  P_33 = (xlv_TEXCOORD0 + cse_34);
  tmpvar_32 = texture (_MainTex, P_33);
  right_01_25 = tmpvar_32;
  lowp vec4 tmpvar_35;
  highp vec2 P_36;
  highp vec2 cse_37;
  cse_37 = (vec2(0.0, -1.5) * _MainTex_TexelSize.xy);
  P_36 = (xlv_TEXCOORD0 + cse_37);
  tmpvar_35 = texture (_MainTex, P_36);
  top_01_24 = tmpvar_35;
  lowp vec4 tmpvar_38;
  highp vec2 P_39;
  highp vec2 cse_40;
  cse_40 = (vec2(0.0, 1.5) * _MainTex_TexelSize.xy);
  P_39 = (xlv_TEXCOORD0 + cse_40);
  tmpvar_38 = texture (_MainTex, P_39);
  bottom_01_23 = tmpvar_38;
  lowp vec4 tmpvar_41;
  highp vec2 P_42;
  P_42 = (xlv_TEXCOORD0 + (vec2(-1.0, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_41 = texture (_MainTex, P_42);
  left_22 = tmpvar_41;
  lowp vec4 tmpvar_43;
  highp vec2 P_44;
  P_44 = (xlv_TEXCOORD0 + (vec2(1.0, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_43 = texture (_MainTex, P_44);
  right_21 = tmpvar_43;
  lowp vec4 tmpvar_45;
  highp vec2 P_46;
  P_46 = (xlv_TEXCOORD0 + (vec2(0.0, -1.0) * _MainTex_TexelSize.xy));
  tmpvar_45 = texture (_MainTex, P_46);
  top_20 = tmpvar_45;
  lowp vec4 tmpvar_47;
  highp vec2 P_48;
  P_48 = (xlv_TEXCOORD0 + (vec2(0.0, 1.0) * _MainTex_TexelSize.xy));
  tmpvar_47 = texture (_MainTex, P_48);
  bottom_19 = tmpvar_47;
  highp vec4 tmpvar_49;
  tmpvar_49 = (((2.0 * 
    (left_01_26 + right_01_25)
  ) + (2.0 * center_27)) / 6.0);
  highp vec4 tmpvar_50;
  tmpvar_50 = (((2.0 * 
    (top_01_24 + bottom_01_23)
  ) + (2.0 * center_27)) / 6.0);
  highp vec4 tmpvar_51;
  tmpvar_51 = mix (mix (center_27, tmpvar_49, vec4(clamp (
    (((3.0 * dot (
      (abs(((top_20 + bottom_19) - (2.0 * center_27))) / 2.0)
    .xyz, vec3(0.33, 0.33, 0.33))) - 0.1) / dot (tmpvar_49.xyz, vec3(0.33, 0.33, 0.33)))
  , 0.0, 1.0))), tmpvar_50, vec4((clamp (
    (((3.0 * dot (
      (abs(((left_22 + right_21) - (2.0 * center_27))) / 2.0)
    .xyz, vec3(0.33, 0.33, 0.33))) - 0.1) / dot (tmpvar_50.xyz, vec3(0.33, 0.33, 0.33)))
  , 0.0, 1.0) * 0.5)));
  clr_18 = tmpvar_51;
  lowp vec4 tmpvar_52;
  highp vec2 P_53;
  P_53 = (xlv_TEXCOORD0 + cse_34);
  tmpvar_52 = texture (_MainTex, P_53);
  h0_17 = tmpvar_52;
  lowp vec4 tmpvar_54;
  highp vec2 P_55;
  P_55 = (xlv_TEXCOORD0 + (vec2(3.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_54 = texture (_MainTex, P_55);
  h1_16 = tmpvar_54;
  lowp vec4 tmpvar_56;
  highp vec2 P_57;
  P_57 = (xlv_TEXCOORD0 + (vec2(5.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_56 = texture (_MainTex, P_57);
  h2_15 = tmpvar_56;
  lowp vec4 tmpvar_58;
  highp vec2 P_59;
  P_59 = (xlv_TEXCOORD0 + (vec2(7.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_58 = texture (_MainTex, P_59);
  h3_14 = tmpvar_58;
  lowp vec4 tmpvar_60;
  highp vec2 P_61;
  P_61 = (xlv_TEXCOORD0 + cse_31);
  tmpvar_60 = texture (_MainTex, P_61);
  h4_13 = tmpvar_60;
  lowp vec4 tmpvar_62;
  highp vec2 P_63;
  P_63 = (xlv_TEXCOORD0 + (vec2(-3.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_62 = texture (_MainTex, P_63);
  h5_12 = tmpvar_62;
  lowp vec4 tmpvar_64;
  highp vec2 P_65;
  P_65 = (xlv_TEXCOORD0 + (vec2(-5.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_64 = texture (_MainTex, P_65);
  h6_11 = tmpvar_64;
  lowp vec4 tmpvar_66;
  highp vec2 P_67;
  P_67 = (xlv_TEXCOORD0 + (vec2(-7.5, 0.0) * _MainTex_TexelSize.xy));
  tmpvar_66 = texture (_MainTex, P_67);
  h7_10 = tmpvar_66;
  lowp vec4 tmpvar_68;
  highp vec2 P_69;
  P_69 = (xlv_TEXCOORD0 + cse_40);
  tmpvar_68 = texture (_MainTex, P_69);
  v0_9 = tmpvar_68;
  lowp vec4 tmpvar_70;
  highp vec2 P_71;
  P_71 = (xlv_TEXCOORD0 + (vec2(0.0, 3.5) * _MainTex_TexelSize.xy));
  tmpvar_70 = texture (_MainTex, P_71);
  v1_8 = tmpvar_70;
  lowp vec4 tmpvar_72;
  highp vec2 P_73;
  P_73 = (xlv_TEXCOORD0 + (vec2(0.0, 5.5) * _MainTex_TexelSize.xy));
  tmpvar_72 = texture (_MainTex, P_73);
  v2_7 = tmpvar_72;
  lowp vec4 tmpvar_74;
  highp vec2 P_75;
  P_75 = (xlv_TEXCOORD0 + (vec2(0.0, 7.5) * _MainTex_TexelSize.xy));
  tmpvar_74 = texture (_MainTex, P_75);
  v3_6 = tmpvar_74;
  lowp vec4 tmpvar_76;
  highp vec2 P_77;
  P_77 = (xlv_TEXCOORD0 + cse_37);
  tmpvar_76 = texture (_MainTex, P_77);
  v4_5 = tmpvar_76;
  lowp vec4 tmpvar_78;
  highp vec2 P_79;
  P_79 = (xlv_TEXCOORD0 + (vec2(0.0, -3.5) * _MainTex_TexelSize.xy));
  tmpvar_78 = texture (_MainTex, P_79);
  v5_4 = tmpvar_78;
  lowp vec4 tmpvar_80;
  highp vec2 P_81;
  P_81 = (xlv_TEXCOORD0 + (vec2(0.0, -5.5) * _MainTex_TexelSize.xy));
  tmpvar_80 = texture (_MainTex, P_81);
  v6_3 = tmpvar_80;
  lowp vec4 tmpvar_82;
  highp vec2 P_83;
  P_83 = (xlv_TEXCOORD0 + (vec2(0.0, -7.5) * _MainTex_TexelSize.xy));
  tmpvar_82 = texture (_MainTex, P_83);
  v7_2 = tmpvar_82;
  highp float tmpvar_84;
  tmpvar_84 = clamp (((
    ((((
      ((((h0_17.w + h1_16.w) + h2_15.w) + h3_14.w) + h4_13.w)
     + h5_12.w) + h6_11.w) + h7_10.w) / 8.0)
   * 2.0) - 1.0), 0.0, 1.0);
  highp float tmpvar_85;
  tmpvar_85 = clamp (((
    ((((
      ((((v0_9.w + v1_8.w) + v2_7.w) + v3_6.w) + v4_5.w)
     + v5_4.w) + v6_3.w) + v7_2.w) / 8.0)
   * 2.0) - 1.0), 0.0, 1.0);
  highp float tmpvar_86;
  tmpvar_86 = abs((tmpvar_84 - tmpvar_85));
  if ((tmpvar_86 > 0.2)) {
    highp float tmpvar_87;
    tmpvar_87 = dot (((
      ((((
        ((h0_17 + h1_16) + h2_15)
       + h3_14) + h4_13) + h5_12) + h6_11)
     + h7_10) / 8.0).xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_88;
    tmpvar_88 = dot (((
      ((((
        ((v0_9 + v1_8) + v2_7)
       + v3_6) + v4_5) + v5_4) + v6_3)
     + v7_2) / 8.0).xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_89;
    tmpvar_89 = dot (center_27.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_90;
    tmpvar_90 = dot (left_22.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_91;
    tmpvar_91 = dot (right_21.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_92;
    tmpvar_92 = dot (top_20.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_93;
    tmpvar_93 = dot (bottom_19.xyz, vec3(0.33, 0.33, 0.33));
    highp float tmpvar_94;
    if ((tmpvar_89 == tmpvar_92)) {
      tmpvar_94 = 0.0;
    } else {
      tmpvar_94 = clamp (((tmpvar_87 - tmpvar_92) / (tmpvar_89 - tmpvar_92)), 0.0, 1.0);
    };
    highp float tmpvar_95;
    if ((tmpvar_89 == tmpvar_93)) {
      tmpvar_95 = 0.0;
    } else {
      tmpvar_95 = clamp ((1.0 + (
        (tmpvar_87 - tmpvar_89)
       / 
        (tmpvar_89 - tmpvar_93)
      )), 0.0, 1.0);
    };
    highp float tmpvar_96;
    if ((tmpvar_89 == tmpvar_90)) {
      tmpvar_96 = 0.0;
    } else {
      tmpvar_96 = clamp (((tmpvar_88 - tmpvar_90) / (tmpvar_89 - tmpvar_90)), 0.0, 1.0);
    };
    highp float tmpvar_97;
    if ((tmpvar_89 == tmpvar_91)) {
      tmpvar_97 = 0.0;
    } else {
      tmpvar_97 = clamp ((1.0 + (
        (tmpvar_88 - tmpvar_89)
       / 
        (tmpvar_89 - tmpvar_91)
      )), 0.0, 1.0);
    };
    clr_18 = mix (mix (tmpvar_51, mix (right_21, 
      mix (left_22, center_27, vec4(tmpvar_96))
    , vec4(tmpvar_97)), vec4(tmpvar_85)), mix (bottom_19, mix (top_20, center_27, vec4(tmpvar_94)), vec4(tmpvar_95)), vec4(tmpvar_84));
  };
  tmpvar_1 = clr_18;
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