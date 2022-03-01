Shader "PluginManager/PMMaskedTexture" {
Properties {
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
 _Mask ("Culling Mask", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" }
  ZWrite Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
  SetTexture [_Mask] { combine texture }
  SetTexture [_MainTex] { combine texture, previous alpha * texture alpha }
 }
}
}