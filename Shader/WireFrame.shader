Shader "Custom/Wireframe" {
    Properties {
        [Header(Albedo)]
        [MainColor] _BaseColor("Base Color", Color) = (1.0, 1.0, 1.0, 1.0)
        [MainTexture] _BaseMap("Base Map", 2D) = "white" {}

        [Header(NormalMap)]
        [Toggle(_NORMALMAP)] _NORMALMAP("Normal Map On/Off", Int) = 0
        [NoScaleOffset] _BumpMap("Normal Map", 2D) = "bump" {}
        [HideInInspector] _BumpScale("Bump Scale", Float) = 1.0

        [Header(Occlution)]
        [Toggle(_OCCLUSIONMAP)] _OCCLUSIONMAP("Occlusion Map On/Off", Int) = 0
        [NoScaleOffset] _OcclusionMap("Occlusion Map", 2D) = "white" {}
        [HideInInspector] _OcclusionStrength("Strength", Range(0.0, 1.0)) = 1.0

        [Header(Metallic and Smoothness)]
        _Smoothness("Smoothness", Range(0.0, 1.0)) = 0.0
        _Metallic("Metallic (only not using map)", Range(0.0, 1.0)) = 0.0
        [Toggle(_METALLICSPECGLOSSMAP)] _METALLICSPECGLOSSMAP("Metallic and Smoothness Map On/Off", Int) = 0
        [NoScaleOffset] _MetallicGlossMap("Metallic and Smoothnes Map", 2D) = "white" {}

        [Header(Emission)]
        [Toggle(_EMISSION)] _EMISSION("Emission On/Off", Int) = 0
        [HDR] _EmissionColor("Emission Color", Color) = (0.0 ,0.0, 0.0)
        [NoScaleOffset] _EmissionMap("Emission Map", 2D) = "white" {}

        [Header(Wireframe)]
        _WireframeWidth("Wireframe Width", Range(1, 50)) = 1
        _WireframeColor("Wireframe Color", Color) = (0.0, 0.0, 1.0, 1.0)
        _WireframeEmissionColor("Wireframe Emission Color", Color) = (0.0, 0.0, 0.0)
        
        [Space(10)]
        [KeywordEnum(Off, Front, Back)] _Cull ("Cull", Int) = 2
    }

    SubShader {
        Tags {
            "Queue" = "Transparent" 
            "RenderType" = "Transparent"
            "RenderPipeline" = "UniversalPipeline"
            "UniversalMaterialType" = "Lit"
        }
        Blend SrcAlpha OneMinusSrcAlpha
        LOD 300
        Cull [_Cull]

        HLSLINCLUDE
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        ENDHLSL

        Pass {
            Name "Wireframe"
            Tags { "LightMode" = "UniversalForward" }

            HLSLPROGRAM

            // -------------------------------------
            // Material Keywords
            #pragma shader_feature_local _NORMALMAP
            #pragma shader_feature_local _PARALLAXMAP
            #pragma shader_feature_local _RECEIVE_SHADOWS_OFF
            #pragma shader_feature_local _ _DETAIL_MULX2 _DETAIL_SCALED
            #pragma shader_feature_local_fragment _SURFACE_TYPE_TRANSPARENT
            #pragma shader_feature_local_fragment _ALPHATEST_ON
            #pragma shader_feature_local_fragment _ _ALPHAPREMULTIPLY_ON _ALPHAMODULATE_ON
            #pragma shader_feature_local_fragment _EMISSION
            #pragma shader_feature_local_fragment _METALLICSPECGLOSSMAP
            #pragma shader_feature_local_fragment _SMOOTHNESS_TEXTURE_ALBEDO_CHANNEL_A
            #pragma shader_feature_local_fragment _OCCLUSIONMAP
            #pragma shader_feature_local_fragment _SPECULARHIGHLIGHTS_OFF
            #pragma shader_feature_local_fragment _ENVIRONMENTREFLECTIONS_OFF
            #pragma shader_feature_local_fragment _SPECULAR_SETUP

            // -------------------------------------
            // Universal Pipeline keywords
            #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
            #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
            #pragma multi_compile _ EVALUATE_SH_MIXED EVALUATE_SH_VERTEX
            #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
            #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
            #pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
            #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
            #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
            #pragma multi_compile_fragment _ _LIGHT_COOKIES
            #pragma multi_compile _ _LIGHT_LAYERS
            #pragma multi_compile _ _FORWARD_PLUS
            #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"

            // -------------------------------------
            // Unity defined keywords
            #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
            #pragma multi_compile _ SHADOWS_SHADOWMASK
            #pragma multi_compile _ DIRLIGHTMAP_COMBINED
            #pragma multi_compile _ LIGHTMAP_ON
            #pragma multi_compile _ DYNAMICLIGHTMAP_ON
            #pragma multi_compile _ USE_LEGACY_LIGHTMAPS
            #pragma multi_compile _ LOD_FADE_CROSSFADE
            #pragma multi_compile_fog
            #pragma multi_compile_fragment _ DEBUG_DISPLAY
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ProbeVolumeVariants.hlsl"

            //--------------------------------------
            // GPU Instancing
            #pragma multi_compile_instancing
            #pragma instancing_options renderinglayer
            #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"

            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitInput.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/Shaders/LitForwardPass.hlsl"

            #pragma vertex Vert
            #pragma geometry Geom
            #pragma fragment Frag

            #pragma require geometry


            // ---------------------------------------------------------------------------------------
            // 変数宣言
            // ---------------------------------------------------------------------------------------
            float _WireframeWidth;
            half4 _WireframeColor;
            half3 _WireframeEmissionColor;


            // ---------------------------------------------------------------------------------------
            // 構造体
            // ---------------------------------------------------------------------------------------
            struct v2g {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 normalWS : TEXCOORD1;
                float3 positionWS : TEXCOORD2;
                half3 vertexSH : TEXCOORD3;
                
#ifdef _NORMALMAP
                half4 tangentWS : TEXCOORD4;
#endif
            };

            struct g2f {
                float4 positionCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float3 normalWS : TEXCOORD1;
                float3 positionWS : TEXCOORD2;
                half3 vertexSH : TEXCOORD3;
                float3 baryCentricCoords : TEXCOORD4;
#ifdef _NORMALMAP
                half4 tangentWS : TEXCOORD5;
#endif
            };


            // ---------------------------------------------------------------------------------------
            // メソッド
            // ---------------------------------------------------------------------------------------
            /**
             * [ジオメトリシェーダー用]
             * パラメータをジオメトリックシェーダーの返却値となるTriangleStreamに追加する
             */
            void SetTriVerticesToStream(g2f param[3], inout TriangleStream<g2f> outStream) {
                [unroll]
                for (int i = 0; i < 3; i++) {
                    // ワイヤーフレーム描画用
                    param[i].baryCentricCoords = float3(i == 0, i == 1, i == 2);

                    outStream.Append(param[i]);
                }

                outStream.RestartStrip();
            }


            // ---------------------------------------------------------------------------------------
            // シェーダー関数
            // ---------------------------------------------------------------------------------------
            /**
             * 頂点シェーダー
             */
            v2g Vert(Attributes input) {
                v2g output;

                Varyings varyings = LitPassVertex(input);
                output.uv = varyings.uv;
                output.normalWS = varyings.normalWS;
                output.positionWS = varyings.positionWS;
                output.positionCS = varyings.positionCS;
                output.vertexSH = varyings.vertexSH;

#ifdef _NORMALMAP
                output.tangentWS = varyings.tangentWS;
#endif

                return output;
            }

            /**
             * ジオメトリシェーダー
             */
            [maxvertexcount(3)]
            void Geom(triangle v2g inputs[3], inout TriangleStream<g2f> outStream) {
                g2f outputs[3];

                [unroll]
                for (int i = 0; i < 3; i++) {
                    outputs[i].positionWS = inputs[i].positionWS;
                    outputs[i].normalWS = inputs[i].normalWS;
                    outputs[i].positionCS = inputs[i].positionCS;
                    outputs[i].uv = inputs[i].uv;
                    outputs[i].vertexSH = inputs[i].vertexSH;
#ifdef _NORMALMAP
                    outputs[i].tangentWS = inputs[i].tangentWS;
#endif
                }

                SetTriVerticesToStream(outputs, outStream);
            }

            /**
             * フラグメントシェーダー
             */
            half4 Frag(g2f input) : SV_Target {
                Varyings varyings = (Varyings)0;
                varyings.positionCS = input.positionCS;
                varyings.uv = input.uv;
                varyings.positionWS = input.positionWS;
                varyings.normalWS = input.normalWS;
                varyings.vertexSH = input.vertexSH;
#ifdef _NORMALMAP
                varyings.tangentWS = input.tangentWS;
#endif

                SurfaceData surfaceData;
                InitializeStandardLitSurfaceData(input.uv, surfaceData);

                InputData inputData;
                InitializeInputData(varyings, surfaceData.normalTS, inputData);
                inputData.vertexLighting = VertexLighting(inputData.positionWS, inputData.normalWS);


                /* ワイヤーフレーム */
                // fwidthで1ピクセルの変化量を求め、ワイヤーを描く値を算出
                float3 thOfJudgingSides = fwidth(input.baryCentricCoords) * _WireframeWidth * 0.5;

                // 処理中のピクセルの座標が_WireframeWidthピクセル分で増加する値より小さい場合は描画対象
                // （重心座標系では頂点から向かいの辺に向かって座標が1→0と変化することを利用）
                float3 isOnSides = 1.0 - pow(saturate(input.baryCentricCoords / thOfJudgingSides), 4.0);
                float isOnSide = max(max(isOnSides.x, isOnSides.y), isOnSides.z);

                surfaceData.albedo = lerp(surfaceData.albedo, _WireframeColor.rgb, isOnSide);
                surfaceData.alpha = lerp(surfaceData.alpha, _WireframeColor.a, isOnSide);
                surfaceData.emission = lerp(surfaceData.emission, _WireframeEmissionColor.rgb, isOnSide);

                half4 color = UniversalFragmentPBR(inputData, surfaceData);

                clip(color.a <= 0 ? -1 : 1);

                return color;
            }

            ENDHLSL
        }
    }



    FallBack "Universal Render Pipeline/Lit"
}
