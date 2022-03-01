using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ReleaseLogSetter : MonoBehaviour
{
    public GameMain Main;
    public Text Info;
   
    void Update()
    {
        Info.text = Main.ReleaseLog;
    }
}
