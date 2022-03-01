Shader "GUI/3D Text Fog Shader" {
Properties {
 _MainTex ("Font Texture", 2D) = "white" {}
 _Color ("Text Color", Color) = (1,1,1,1)
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  Color [_Color]
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  SetTexture [_MainTex] { combine primary, texture alpha * primary alpha }
 }
}
}