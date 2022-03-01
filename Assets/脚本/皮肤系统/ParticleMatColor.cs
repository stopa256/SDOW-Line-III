using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace SDOW屑脚本.Skin
{
    public class ParticleMatColor : MonoBehaviour
{
    public ParticleSystemRenderer Par;
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
        if(Par.sharedMaterial!= Mat){
            Par.sharedMaterial = Mat;
        }
    }
}
}

