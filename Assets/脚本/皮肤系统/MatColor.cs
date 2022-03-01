using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace SDOW屑脚本.Skin
{
    public class MatColor : MonoBehaviour
{
    public MeshRenderer MR;
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
        if(MR.sharedMaterial!= Mat){
            MR.sharedMaterial = Mat;
        }
    }
}
}

