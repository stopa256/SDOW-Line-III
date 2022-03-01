using UnityEngine;
using UnityEngine.UI;
using DG.Tweening;
using System.Collections;

public class OverMenu : MonoBehaviour
{
    public MainLine line;
    public Text LevelNameZh_CNLabel;
    public Text DiamondLabel;
    public Animator Crown1, Crown2, Crown3;
    [HideInInspector] public static bool perfact = false;
    public Sprite perfectCrown;
    public Image ProgressImage;
    public Text ProgressText;
    public Image PerfectImage;

    private void Start()
    {
        PerfectImage.gameObject.SetActive(false);
    }

    public void GameOver(bool win, int Percentage, int PickDimaondCount, int PickCrownCount)
    {
        ProgressImage.DOFillAmount(float.Parse(Percentage.ToString()) / 100, 2f);
        ProgressText.text = Percentage.ToString() + "%";
        DiamondLabel.text = line.PickDiamondCount.ToString() + "/10";

    }
    private void Update()
    {
        StartCoroutine(ShowNcrown());
        if (line.NowPercentage >= 100 && line.PickDiamondCount >= 10 && line.PickCrown >= 3)
        {
            perfact = true;
            PerfectImage.gameObject.SetActive(true);
        }
        if (line.NowPercentage < 100 && line.PickDiamondCount < 10 && line.PickCrown < 3)
        {
            perfact = false;
            PerfectImage.gameObject.SetActive(false);
        }
    }
    public IEnumerator ShowNcrown()
    {

        if (line.PickCrown <= 0)
        {

            Crown1.gameObject.SetActive(false);
            Crown2.gameObject.SetActive(false);
            Crown3.gameObject.SetActive(false);
        }
        if (line.PickCrown == 1)
        {
            yield return new WaitForSeconds(0.3f);
            Crown1.gameObject.SetActive(true);
            Crown2.gameObject.SetActive(false);
            Crown3.gameObject.SetActive(false);
        }
        if (line.PickCrown == 2)
        {
            yield return new WaitForSeconds(0.3f);
            Crown1.gameObject.SetActive(true);
            yield return new WaitForSeconds(0.5f);
            Crown2.gameObject.SetActive(true);
            Crown3.gameObject.SetActive(false);
        }
        if (line.PickCrown >= 3)
        {
            if (line.PickDiamondCount >= 10)
            {
                Crown1.GetComponent<Image>().sprite = perfectCrown;
                Crown2.GetComponent<Image>().sprite = perfectCrown;
                Crown3.GetComponent<Image>().sprite = perfectCrown;
            }
            yield return new WaitForSeconds(0.3f);
            Crown1.gameObject.SetActive(true);
            yield return new WaitForSeconds(0.5f);
            Crown2.gameObject.SetActive(true);
            yield return new WaitForSeconds(0.5f);
            Crown3.gameObject.SetActive(true);
        }
    }
}
