Shader "Custom/Mushroom" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
		_Scale ("Scale", Float) = 1.0
		_Freq ("Frequency", Float) = 1.0
		_Speed ("Speed", Float) = 1.0
		_Center ("Center", Vector) = (0, 0, 0, 0)
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows vertex:vert
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		half _Glossiness;
		half _Metallic;
		half _Scale;
		half _Freq;
		half _Speed;
		fixed4 _Color;
		fixed4 _Center;

		UNITY_INSTANCING_CBUFFER_START(Props)

		UNITY_INSTANCING_CBUFFER_END

		void vert(inout appdata_full v, out Input o){

			v.vertex.xz += (v.vertex.xz - _Center.xz)  * sin(-_Time.y * _Speed + v.vertex.y * _Freq) * _Scale; 
			v.vertex.y = sin(-_Time.y * _Speed + v.vertex.y * _Freq / 10.0) * v.vertex.y;
			o.uv_MainTex = v.texcoord;			
		}

		void surf (Input IN, inout SurfaceOutputStandard o) {
			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
