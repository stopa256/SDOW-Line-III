using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ParticleStartColor : MonoBehaviour
{
    public ParticleSystem Par;
    private MainLine Line;
    private Material Mat;
    // Start is called before the first frame update
    void Start()
    {
        Line = FindObjectOfType<MainLine>();
        Mat = Line.GetComponent<MeshRenderer>().sharedMaterial;
    }

    // Update is called once per frame
    void Update()
    {
        if(Par.startColor!= Mat.color){
            Par.startColor= Mat.color;
        }
    }
}
