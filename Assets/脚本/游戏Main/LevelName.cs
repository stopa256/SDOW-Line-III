using UnityEngine;
using UnityEngine.UI;

public class LevelName : MonoBehaviour
{
    public string Name => MenuSettings.LevelNameString;
    public Text text => GetComponent<Text>();
    void Start()
    {
        text.text = Name;
    }
}
