Shader "Custom/UnlitTransparentTint" {
Properties {
 _Color ("Color Tint Mult", Color) = (0,0,0,1)
 _AddColor ("Color Tint Add", Color) = (0,0,0,0)
 _MainTex ("Base (RGB) Alpha (A)", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  SetTexture [_MainTex] { ConstantColor [_Color] combine texture * constant }
  SetTexture [_MainTex] { ConstantColor [_AddColor] combine previous + constant }
 }
}
}