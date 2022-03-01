using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace SDOW屑脚本.Skin
{
    public class Skin : MonoBehaviour
    {
        public GameMain Main;
        public static GameObject Head;
        public static Vector3 HeadOffset;
        public static GameObject Tail;
        public static GameObject TapEffect;
        public static Vector3 TapEffectOffset;
        public static GameObject StaticEffect;
        private void Start()
        {
            SetSkin(PlayerPrefs.GetInt("SkinID", 0));
        }

        public void SetSkin(int SkinID)
        {
            PlayerPrefs.SetInt("SkinID", SkinID);
            HeadOffset = Main.游戏皮肤[SkinID].HeadOffset;
            TapEffectOffset = Main.游戏皮肤[SkinID].TapEffectOffset;
            if (Main.游戏皮肤[SkinID].LineHead)
            {
                Head = Main.游戏皮肤[SkinID].LineHead;
            }
            else
            {
                Head = null;
            }
            if (Main.游戏皮肤[SkinID].Tail)
            {
                Tail = Main.游戏皮肤[SkinID].Tail;
            }
            else
            {
                Tail = null;
            }
            if (Main.游戏皮肤[SkinID].TapEffect)
            {
                TapEffect = Main.游戏皮肤[SkinID].TapEffect;
            }
            else
            {
                TapEffect = null;
            }
            if (Main.游戏皮肤[SkinID].StaticEffect)
            {
                StaticEffect = Main.游戏皮肤[SkinID].StaticEffect;
            }
            else
            {
                StaticEffect = null;
            }
        }
    }
}

