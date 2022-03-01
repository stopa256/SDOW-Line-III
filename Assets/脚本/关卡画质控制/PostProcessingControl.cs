using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
public class PostProcessingControl : MonoBehaviour
{
    public Text Shower;
    public static bool EnabledPost;
    private void Start() {
        if(PlayerPrefs.GetInt("Post", 0) == 0){
            EnabledPost = false;
        }else{
            EnabledPost = true;
        }
    }
    private void FixedUpdate(){
        if(EnabledPost == false){
            Shower.text = "好康的特效："+"不开";
        }else{
            Shower.text = "好康的特效：" + "开";
        }
    }
    public void Switch(){
        if(EnabledPost){
            EnabledPost = false;
            PlayerPrefs.SetInt("Post", 0);
        }
        else{
            EnabledPost = true;
            PlayerPrefs.SetInt("Post", 1);
        }
    }
}
