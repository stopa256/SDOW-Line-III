using UnityEngine;
using UnityEngine.UI;
public class MenuSettings : MonoBehaviour
{
    public Text NameShower;
    public Text DiamondShower, PerShower,作者, 音乐作者, LevelNum;
    public LRButton Left, Right;
    public GameObject LevelModelHolder;
    public LevelMassage[] LevelInfos;
    public static string LevelNameString { get; set; }

    [HideInInspector] public Vector3 LV3Next, LV3Last;
    [HideInInspector] public static int NowLevelId = 0;
    [HideInInspector] public static float NowLevelModelX;
    [HideInInspector] public int SceneId;
    [HideInInspector] public int NowPer, NowDia, NowCro;
    [HideInInspector] public string Get_Per, Get_Dia, Get_Cro;
    [HideInInspector] public Camera MainCamera;
    [HideInInspector] public PlayLevel PlayButton;
    [HideInInspector] public AudioSource AudioPlayer;
    private float X;
    private int NOWLEVERID{
        get{
            return NowLevelId;
        }
        set{
            NowLevelId = value;
        }
    }
    private void Awake()
    {
        NOWLEVERID = PlayerPrefs.GetInt("LevelID", 0);
        for (int a = 0; a < LevelInfos.Length; a++)
        {
            LevelInfos[a].LevelID = a;
        }
    }
    void Start()
    {

        X = NOWLEVERID*-45;
        Vector3 NewPos = new Vector3(X, 0,0);
        LevelModelHolder.transform.position = NewPos;
        MainCamera.backgroundColor = LevelInfos[NowLevelId].ThisLevelCameraBackColor;
        MainCamera = GameObject.FindObjectOfType<Camera>();
        PlayButton = GameObject.FindObjectOfType<PlayLevel>();
        AudioPlayer = GameObject.FindObjectOfType<AudioSource>();
        AudioPlayer.clip = LevelInfos[NowLevelId].ThisLevelSound;
        MainCamera.transform.GetChild(0).GetComponent<ParticleSystem>().Play();
        AudioPlayer.Play();
        LevelModelHolder.transform.position = new Vector3(NowLevelModelX, 0, 0);
    }

    public void MassageSeter()
    {
        if (PlayerPrefs.GetInt(Get_Per) >= NowPer)
        {
            NowPer = PlayerPrefs.GetInt(Get_Per);
        }
        if (PlayerPrefs.GetInt(Get_Dia) >= NowDia)
        {
            NowDia = PlayerPrefs.GetInt(Get_Dia);
        }
        if (PlayerPrefs.GetInt(Get_Cro) >= NowCro)
        {
            NowCro = PlayerPrefs.GetInt(Get_Cro);
        }
    }

    public void MassageChanger()
    {
        LevelNameString = LevelInfos[NowLevelId].LevelNames;
        AudioPlayer.clip = LevelInfos[NowLevelId].ThisLevelSound;
        NameShower.text = LevelInfos[NowLevelId].LevelNames;
        作者.text = "关卡作者："+LevelInfos[NowLevelId].作者;
        if (LevelInfos[NowLevelId].音乐作者 != "") 音乐作者.text = "音乐作者：" + LevelInfos[NowLevelId].音乐作者;
        else 音乐作者.text = "";
        LevelNum.text = NowLevelId+1 + "/" + LevelInfos.Length;
        SceneId = LevelInfos[NowLevelId].SceneId;
        Get_Per = LevelInfos[NowLevelId].ThisLevelPerGeter;
        Get_Dia = LevelInfos[NowLevelId].ThisLevelDiamondGeter;
        Get_Cro = LevelInfos[NowLevelId].ThisLevelCrownGeter;
        NowPer = PlayerPrefs.GetInt(LevelInfos[NowLevelId].ThisLevelPerGeter);
        NowDia = PlayerPrefs.GetInt(LevelInfos[NowLevelId].ThisLevelDiamondGeter);
        NowCro = PlayerPrefs.GetInt(LevelInfos[NowLevelId].ThisLevelCrownGeter);
    }

    public void PDC_TextChanger()
    {
        DiamondShower.text = NowDia.ToString() + "/10";
        PerShower.text = NowPer.ToString() + "%";
    }
    private void LevelPosSeter(){
        X = Mathf.Lerp(X,NowLevelId*-45, 7f*Time.deltaTime);
        Vector3 NewPos = new Vector3(X, 0,0);
        LevelModelHolder.transform.position = NewPos;
        PlayerPrefs.SetInt("LevelID", NowLevelId);
    }
    void Update()
    {
        MassageSeter();
        MassageChanger();
        PDC_TextChanger();
        LevelPosSeter();
        NowLevelModelX = LevelModelHolder.transform.position.x;

        if (NowLevelId <= 0)
        {
            Left.GetComponent<Image>().color = new Color(0.5882353f, 0.5882353f, 0.5882353f, 1f);
            Left.GetComponent<Button>().enabled = false;
        }
        else
        {
            Left.GetComponent<Image>().color = new Color(1f, 1f, 1f, 1f);
            Left.GetComponent<Button>().enabled = true;
        }
        if(NowLevelId >= LevelInfos.Length-1)
        {
            Right.GetComponent<Image>().color = new Color(0.5882353f, 0.5882353f, 0.5882353f, 1f);
            Right.GetComponent<Button>().enabled = false;
        }
        else
        {
            Right.GetComponent<Image>().color = new Color(1f, 1f, 1f, 1f);
            Right.GetComponent<Button>().enabled = true;
        }       

        if(NowCro < 1)
        {
            LevelInfos[NowLevelId].ThisLevelCrownModel1.SetActive(false);
            LevelInfos[NowLevelId].ThisLevelCrownModel2.SetActive(false);
            LevelInfos[NowLevelId].ThisLevelCrownModel3.SetActive(false);
        }
        if (NowCro == 1)
        {
            LevelInfos[NowLevelId].ThisLevelCrownModel1.SetActive(true);
            LevelInfos[NowLevelId].ThisLevelCrownModel2.SetActive(false);
            LevelInfos[NowLevelId].ThisLevelCrownModel3.SetActive(false);
        }
        if (NowCro == 2)
        {
            LevelInfos[NowLevelId].ThisLevelCrownModel1.SetActive(true);
            LevelInfos[NowLevelId].ThisLevelCrownModel2.SetActive(true);
            LevelInfos[NowLevelId].ThisLevelCrownModel3.SetActive(false);
        }
        if (NowCro >= 3)
        {
            LevelInfos[NowLevelId].ThisLevelCrownModel1.SetActive(true);
            LevelInfos[NowLevelId].ThisLevelCrownModel2.SetActive(true);
            LevelInfos[NowLevelId].ThisLevelCrownModel3.SetActive(true);
        }

        if(NowCro >=3 && NowDia >= 10 && NowPer >= 100)
        {
            LevelInfos[NowLevelId].ThisLevelCrownModel1.SetActive(false);
            LevelInfos[NowLevelId].ThisLevelCrownModel2.SetActive(false);
            LevelInfos[NowLevelId].ThisLevelCrownModel3.SetActive(false);
            LevelInfos[NowLevelId].ThisLevelPerfactCrownHolder.SetActive(true);
        }
        else
        {
            LevelInfos[NowLevelId].ThisLevelPerfactCrownHolder.SetActive(false);
        }

        LV3Next = new Vector3(LevelModelHolder.transform.position.x + 45, LevelModelHolder.transform.position.y, LevelModelHolder.transform.position.z);
        LV3Last = new Vector3(LevelModelHolder.transform.position.x - 45, LevelModelHolder.transform.position.y, LevelModelHolder.transform.position.z);
    }
}
