using DG.Tweening;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CrazyScale : MonoBehaviour
{
    public float timeBetweenScales = 1f;
    public float scaleA = 1f;
    public float scaleB = 2f;
    public bool scaleX, scaleY, scaleZ;
    public Ease ease = Ease.InOutSine;
    private Transform transform;
    public Transform TRANSFORM
    {
        get
        {
            return transform;
        }
        set
        {
            transform = value;
        }
    }
    public void Start()
    {
        TRANSFORM = GetComponent<Transform>();
        doScaleA();
    }
    public void doScaleA()
    {
        if(scaleX) TRANSFORM.DOScaleX(scaleA, timeBetweenScales).SetEase(ease);
        if(scaleY) TRANSFORM.DOScaleY(scaleA, timeBetweenScales).SetEase(ease);
        if (scaleZ) TRANSFORM.DOScaleZ(scaleA, timeBetweenScales).SetEase(ease);
        Invoke("doScaleB", timeBetweenScales);
    }
    public void doScaleB()
    {
        if (scaleX) TRANSFORM.DOScaleX(scaleB, timeBetweenScales).SetEase(ease);
        if (scaleY) TRANSFORM.DOScaleY(scaleB, timeBetweenScales).SetEase(ease);
        if (scaleZ) TRANSFORM.DOScaleZ(scaleB, timeBetweenScales).SetEase(ease);
        Invoke("doScaleA", timeBetweenScales);
    }
}
