using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[CreateAssetMenu(fileName = "GameMain", menuName = "ScriptableObjects/GameMain", order = 1)]
public class GameMain : ScriptableObject
{
    [System.Serializable]
    public class SdowInfo
    {
        public string GameVersion;
        [TextArea(20,40) ]
        public string AboutGame;
    }
    [System.Serializable]
    public class Skin
    {
        public GameObject LineHead;
        public Vector3 HeadOffset;
        public GameObject TapEffect;
        public Vector3 TapEffectOffset;
        public GameObject Tail;
        public GameObject StaticEffect; 
    }
    public SdowInfo 游戏信息;
    [TextArea(20, 40)]
    public string ReleaseLog;
    public Skin[] 游戏皮肤;
}
