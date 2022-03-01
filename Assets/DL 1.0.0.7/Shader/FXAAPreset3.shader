Shader "Hidden/FXAA Preset 3" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
Program "vp" {
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp vec4 _MainTex_TexelSize;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 rcpFrame_1;
  rcpFrame_1 = _MainTex_TexelSize.xy;
  highp vec3 tmpvar_2;
  bool doneP_4;
  bool doneN_5;
  highp float lumaEndP_6;
  highp float lumaEndN_7;
  highp vec2 offNP_8;
  highp vec2 posP_9;
  highp vec2 posN_10;
  highp float gradientN_11;
  highp float lengthSign_12;
  highp float lumaS_13;
  highp float lumaN_14;
  highp vec4 tmpvar_15;
  tmpvar_15.zw = vec2(0.0, 0.0);
  tmpvar_15.xy = (xlv_TEXCOORD0 + (vec2(0.0, -1.0) * _MainTex_TexelSize.xy));
  highp vec4 tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = textureLod (_MainTex, tmpvar_15.xy, 0.0);
  tmpvar_16 = tmpvar_17;
  highp vec4 tmpvar_18;
  tmpvar_18.zw = vec2(0.0, 0.0);
  tmpvar_18.xy = (xlv_TEXCOORD0 + (vec2(-1.0, 0.0) * _MainTex_TexelSize.xy));
  highp vec4 tmpvar_19;
  lowp vec4 tmpvar_20;
  tmpvar_20 = textureLod (_MainTex, tmpvar_18.xy, 0.0);
  tmpvar_19 = tmpvar_20;
  highp vec4 tmpvar_21;
  lowp vec4 tmpvar_22;
  tmpvar_22 = textureLod (_MainTex, xlv_TEXCOORD0, 0.0);
  tmpvar_21 = tmpvar_22;
  highp vec4 tmpvar_23;
  tmpvar_23.zw = vec2(0.0, 0.0);
  tmpvar_23.xy = (xlv_TEXCOORD0 + (vec2(1.0, 0.0) * _MainTex_TexelSize.xy));
  highp vec4 tmpvar_24;
  lowp vec4 tmpvar_25;
  tmpvar_25 = textureLod (_MainTex, tmpvar_23.xy, 0.0);
  tmpvar_24 = tmpvar_25;
  highp vec4 tmpvar_26;
  tmpvar_26.zw = vec2(0.0, 0.0);
  tmpvar_26.xy = (xlv_TEXCOORD0 + (vec2(0.0, 1.0) * _MainTex_TexelSize.xy));
  highp vec4 tmpvar_27;
  lowp vec4 tmpvar_28;
  tmpvar_28 = textureLod (_MainTex, tmpvar_26.xy, 0.0);
  tmpvar_27 = tmpvar_28;
  highp float tmpvar_29;
  tmpvar_29 = ((tmpvar_16.y * 1.96321) + tmpvar_16.x);
  lumaN_14 = tmpvar_29;
  highp float tmpvar_30;
  tmpvar_30 = ((tmpvar_19.y * 1.96321) + tmpvar_19.x);
  highp float tmpvar_31;
  tmpvar_31 = ((tmpvar_21.y * 1.96321) + tmpvar_21.x);
  highp float tmpvar_32;
  tmpvar_32 = ((tmpvar_24.y * 1.96321) + tmpvar_24.x);
  highp float tmpvar_33;
  tmpvar_33 = ((tmpvar_27.y * 1.96321) + tmpvar_27.x);
  lumaS_13 = tmpvar_33;
  highp float tmpvar_34;
  tmpvar_34 = max (tmpvar_31, max (max (tmpvar_29, tmpvar_30), max (tmpvar_33, tmpvar_32)));
  highp float tmpvar_35;
  tmpvar_35 = (tmpvar_34 - min (tmpvar_31, min (
    min (tmpvar_29, tmpvar_30)
  , 
    min (tmpvar_33, tmpvar_32)
  )));
  highp float tmpvar_36;
  tmpvar_36 = max (0.0416667, (tmpvar_34 * 0.125));
  if ((tmpvar_35 < tmpvar_36)) {
    tmpvar_2 = tmpvar_21.xyz;
  } else {
    highp float tmpvar_37;
    tmpvar_37 = min (0.75, (max (0.0, 
      ((abs((
        ((((tmpvar_29 + tmpvar_30) + tmpvar_32) + tmpvar_33) * 0.25)
       - tmpvar_31)) / tmpvar_35) - 0.25)
    ) * 1.33333));
    highp vec4 tmpvar_38;
    tmpvar_38.zw = vec2(0.0, 0.0);
    tmpvar_38.xy = (xlv_TEXCOORD0 - _MainTex_TexelSize.xy);
    highp vec4 tmpvar_39;
    lowp vec4 tmpvar_40;
    tmpvar_40 = textureLod (_MainTex, tmpvar_38.xy, 0.0);
    tmpvar_39 = tmpvar_40;
    highp vec4 tmpvar_41;
    tmpvar_41.zw = vec2(0.0, 0.0);
    tmpvar_41.xy = (xlv_TEXCOORD0 + (vec2(1.0, -1.0) * _MainTex_TexelSize.xy));
    highp vec4 tmpvar_42;
    lowp vec4 tmpvar_43;
    tmpvar_43 = textureLod (_MainTex, tmpvar_41.xy, 0.0);
    tmpvar_42 = tmpvar_43;
    highp vec4 tmpvar_44;
    tmpvar_44.zw = vec2(0.0, 0.0);
    tmpvar_44.xy = (xlv_TEXCOORD0 + (vec2(-1.0, 1.0) * _MainTex_TexelSize.xy));
    highp vec4 tmpvar_45;
    lowp vec4 tmpvar_46;
    tmpvar_46 = textureLod (_MainTex, tmpvar_44.xy, 0.0);
    tmpvar_45 = tmpvar_46;
    highp vec4 tmpvar_47;
    tmpvar_47.zw = vec2(0.0, 0.0);
    tmpvar_47.xy = (xlv_TEXCOORD0 + _MainTex_TexelSize.xy);
    highp vec4 tmpvar_48;
    lowp vec4 tmpvar_49;
    tmpvar_49 = textureLod (_MainTex, tmpvar_47.xy, 0.0);
    tmpvar_48 = tmpvar_49;
    highp vec3 tmpvar_50;
    tmpvar_50 = (((
      (((tmpvar_16.xyz + tmpvar_19.xyz) + tmpvar_21.xyz) + tmpvar_24.xyz)
     + tmpvar_27.xyz) + (
      ((tmpvar_39.xyz + tmpvar_42.xyz) + tmpvar_45.xyz)
     + tmpvar_48.xyz)) * vec3(0.111111, 0.111111, 0.111111));
    highp float tmpvar_51;
    tmpvar_51 = ((tmpvar_39.y * 1.96321) + tmpvar_39.x);
    highp float tmpvar_52;
    tmpvar_52 = ((tmpvar_42.y * 1.96321) + tmpvar_42.x);
    highp float tmpvar_53;
    tmpvar_53 = ((tmpvar_45.y * 1.96321) + tmpvar_45.x);
    highp float tmpvar_54;
    tmpvar_54 = ((tmpvar_48.y * 1.96321) + tmpvar_48.x);
    bool tmpvar_55;
    tmpvar_55 = (((
      abs((((0.25 * tmpvar_51) + (-0.5 * tmpvar_30)) + (0.25 * tmpvar_53)))
     + 
      abs((((0.5 * tmpvar_29) - tmpvar_31) + (0.5 * tmpvar_33)))
    ) + abs(
      (((0.25 * tmpvar_52) + (-0.5 * tmpvar_32)) + (0.25 * tmpvar_54))
    )) >= ((
      abs((((0.25 * tmpvar_51) + (-0.5 * tmpvar_29)) + (0.25 * tmpvar_52)))
     + 
      abs((((0.5 * tmpvar_30) - tmpvar_31) + (0.5 * tmpvar_32)))
    ) + abs(
      (((0.25 * tmpvar_53) + (-0.5 * tmpvar_33)) + (0.25 * tmpvar_54))
    )));
    highp float tmpvar_56;
    if (tmpvar_55) {
      tmpvar_56 = -(_MainTex_TexelSize.y);
    } else {
      tmpvar_56 = -(_MainTex_TexelSize.x);
    };
    lengthSign_12 = tmpvar_56;
    if (!(tmpvar_55)) {
      lumaN_14 = tmpvar_30;
    };
    if (!(tmpvar_55)) {
      lumaS_13 = tmpvar_32;
    };
    highp float tmpvar_57;
    tmpvar_57 = abs((lumaN_14 - tmpvar_31));
    gradientN_11 = tmpvar_57;
    highp float tmpvar_58;
    tmpvar_58 = abs((lumaS_13 - tmpvar_31));
    lumaN_14 = ((lumaN_14 + tmpvar_31) * 0.5);
    highp float tmpvar_59;
    tmpvar_59 = ((lumaS_13 + tmpvar_31) * 0.5);
    lumaS_13 = tmpvar_59;
    bool tmpvar_60;
    tmpvar_60 = (tmpvar_57 >= tmpvar_58);
    if (!(tmpvar_60)) {
      lumaN_14 = tmpvar_59;
    };
    if (!(tmpvar_60)) {
      gradientN_11 = tmpvar_58;
    };
    if (!(tmpvar_60)) {
      lengthSign_12 = -(tmpvar_56);
    };
    highp float tmpvar_61;
    if (tmpvar_55) {
      tmpvar_61 = 0.0;
    } else {
      tmpvar_61 = (lengthSign_12 * 0.5);
    };
    posN_10.x = (xlv_TEXCOORD0.x + tmpvar_61);
    highp float tmpvar_62;
    if (tmpvar_55) {
      tmpvar_62 = (lengthSign_12 * 0.5);
    } else {
      tmpvar_62 = 0.0;
    };
    posN_10.y = (xlv_TEXCOORD0.y + tmpvar_62);
    gradientN_11 = (gradientN_11 * 0.25);
    posP_9 = posN_10;
    highp vec2 tmpvar_63;
    if (tmpvar_55) {
      highp vec2 tmpvar_64;
      tmpvar_64.y = 0.0;
      tmpvar_64.x = rcpFrame_1.x;
      tmpvar_63 = tmpvar_64;
    } else {
      highp vec2 tmpvar_65;
      tmpvar_65.x = 0.0;
      tmpvar_65.y = rcpFrame_1.y;
      tmpvar_63 = tmpvar_65;
    };
    offNP_8 = tmpvar_63;
    lumaEndN_7 = lumaN_14;
    lumaEndP_6 = lumaN_14;
    doneN_5 = bool(0);
    doneP_4 = bool(0);
    posN_10 = (posN_10 - tmpvar_63);
    posP_9 = (posP_9 + tmpvar_63);
    for (int i_3 = 0; i_3 < 16; i_3++) {
      if (!(doneN_5)) {
        highp vec4 tmpvar_66;
        lowp vec4 tmpvar_67;
        tmpvar_67 = textureLod (_MainTex, posN_10, 0.0);
        tmpvar_66 = tmpvar_67;
        lumaEndN_7 = ((tmpvar_66.y * 1.96321) + tmpvar_66.x);
      };
      if (!(doneP_4)) {
        highp vec4 tmpvar_68;
        lowp vec4 tmpvar_69;
        tmpvar_69 = textureLod (_MainTex, posP_9, 0.0);
        tmpvar_68 = tmpvar_69;
        lumaEndP_6 = ((tmpvar_68.y * 1.96321) + tmpvar_68.x);
      };
      bool tmpvar_70;
      if (doneN_5) {
        tmpvar_70 = bool(1);
      } else {
        highp float tmpvar_71;
        tmpvar_71 = abs((lumaEndN_7 - lumaN_14));
        tmpvar_70 = (tmpvar_71 >= gradientN_11);
      };
      doneN_5 = tmpvar_70;
      bool tmpvar_72;
      if (doneP_4) {
        tmpvar_72 = bool(1);
      } else {
        highp float tmpvar_73;
        tmpvar_73 = abs((lumaEndP_6 - lumaN_14));
        tmpvar_72 = (tmpvar_73 >= gradientN_11);
      };
      doneP_4 = tmpvar_72;
      if ((tmpvar_70 && tmpvar_72)) {
        break;
      };
      if (!(tmpvar_70)) {
        posN_10 = (posN_10 - offNP_8);
      };
      if (!(tmpvar_72)) {
        posP_9 = (posP_9 + offNP_8);
      };
    };
    highp float tmpvar_74;
    if (tmpvar_55) {
      tmpvar_74 = (xlv_TEXCOORD0.x - posN_10.x);
    } else {
      tmpvar_74 = (xlv_TEXCOORD0.y - posN_10.y);
    };
    highp float tmpvar_75;
    if (tmpvar_55) {
      tmpvar_75 = (posP_9.x - xlv_TEXCOORD0.x);
    } else {
      tmpvar_75 = (posP_9.y - xlv_TEXCOORD0.y);
    };
    bool tmpvar_76;
    tmpvar_76 = (tmpvar_74 < tmpvar_75);
    highp float tmpvar_77;
    if (tmpvar_76) {
      tmpvar_77 = lumaEndN_7;
    } else {
      tmpvar_77 = lumaEndP_6;
    };
    lumaEndN_7 = tmpvar_77;
    if ((((tmpvar_31 - lumaN_14) < 0.0) == ((tmpvar_77 - lumaN_14) < 0.0))) {
      lengthSign_12 = 0.0;
    };
    highp float tmpvar_78;
    tmpvar_78 = (tmpvar_75 + tmpvar_74);
    highp float tmpvar_79;
    if (tmpvar_76) {
      tmpvar_79 = tmpvar_74;
    } else {
      tmpvar_79 = tmpvar_75;
    };
    highp float tmpvar_80;
    tmpvar_80 = ((0.5 + (tmpvar_79 * 
      (-1.0 / tmpvar_78)
    )) * lengthSign_12);
    highp float tmpvar_81;
    if (tmpvar_55) {
      tmpvar_81 = 0.0;
    } else {
      tmpvar_81 = tmpvar_80;
    };
    highp float tmpvar_82;
    if (tmpvar_55) {
      tmpvar_82 = tmpvar_80;
    } else {
      tmpvar_82 = 0.0;
    };
    highp vec2 tmpvar_83;
    tmpvar_83.x = (xlv_TEXCOORD0.x + tmpvar_81);
    tmpvar_83.y = (xlv_TEXCOORD0.y + tmpvar_82);
    highp vec4 tmpvar_84;
    lowp vec4 tmpvar_85;
    tmpvar_85 = textureLod (_MainTex, tmpvar_83, 0.0);
    tmpvar_84 = tmpvar_85;
    highp vec3 tmpvar_86;
    tmpvar_86.x = -(tmpvar_37);
    tmpvar_86.y = -(tmpvar_37);
    tmpvar_86.z = -(tmpvar_37);
    tmpvar_2 = ((tmpvar_86 * tmpvar_84.xyz) + ((tmpvar_50 * vec3(tmpvar_37)) + tmpvar_84.xyz));
  };
  highp vec4 tmpvar_87;
  tmpvar_87.w = 0.0;
  tmpvar_87.xyz = tmpvar_2;
  _glesFragData[0] = tmpvar_87;
}



#endif"
}
}
Program "fp" {
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
}
Fallback "Hidden/FXAA II"
}