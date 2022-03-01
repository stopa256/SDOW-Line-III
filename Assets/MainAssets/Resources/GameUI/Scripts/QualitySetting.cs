using UnityEngine;
using UnityEngine.UI;
public class QualitySetting : MonoBehaviour
{
    public Text shower;
    [HideInInspector] private string vl = "超不好看", l = "不好看", m = "一般", h = "好看", vh = "挺好看", u = "超好看";
    [HideInInspector] public int id;
    // Start is called before the first frame update
    void Start()
    {
        id = QualitySettings.GetQualityLevel()+1;
    }
    public void click()
    {
        id += 1;
    }
    // Update is called once per frame
    void Update()
    {
        if(id<=1)
        {
            QualitySettings.SetQualityLevel(0);
            shower.text = "画面好看度：" + vl;
        }
        if (id == 2)
        {
            QualitySettings.SetQualityLevel(1);
            shower.text = "画面好看度：" + l;
        }
        if (id == 3)
        {
            QualitySettings.SetQualityLevel(2);
            shower.text = "画面好看度：" + m;
        }
        if (id ==4)
        {
            QualitySettings.SetQualityLevel(3);
            shower.text = "画面好看度：" + h;
        }
        if (id == 5)
        {
            QualitySettings.SetQualityLevel(4);
            shower.text = "画面好看度：" + vh;
        }
        if (id >= 6)
        {
            QualitySettings.SetQualityLevel(5);
            shower.text = "画面好看度：" + u;
        }
        if(id>6)
        {
            id = 1;
        }
        if(id<1)
        {
            id = 1;
        }
    }
}
