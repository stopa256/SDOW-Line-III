using UnityEngine;

public class LevelMassage : MonoBehaviour
{
    [HideInInspector] public MenuSettings Menu;
    public GameObject ThisLevelCrownModel1, ThisLevelCrownModel2, ThisLevelCrownModel3;
    public GameObject ThisLevelPerfactCrownHolder;
    public AudioClip ThisLevelSound;
    public Color ThisLevelCameraBackColor = new Color(0, 0, 0, 1);
    public string LevelNames;
    public string 作者;
    public string 音乐作者;
    public int SceneId;
    public string ThisLevelPerGeter, ThisLevelDiamondGeter, ThisLevelCrownGeter;
    [HideInInspector] public int LevelID;

    void Start()
    {
        Menu = GameObject.FindObjectOfType<MenuSettings>();
        transform.localPosition = new Vector3(LevelID * 45, 0, 0);
    }
}
