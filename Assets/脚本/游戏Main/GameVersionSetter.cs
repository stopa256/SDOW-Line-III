using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GameVersionSetter : MonoBehaviour
{
    public GameMain Main;
    public Text Version;

    void Update()
    {
        Version.text = "V"+Main.游戏信息.GameVersion;
    }
}
