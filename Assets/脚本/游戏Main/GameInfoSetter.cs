using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GameInfoSetter : MonoBehaviour
{
    public GameMain Main;
    public Text Info;
   
    void Update()
    {
        Info.text = Main.游戏信息.AboutGame;
    }
}
