using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using DG.Tweening;

public class uproad : MonoBehaviour
{
    public float diffdis=0.1f;
    public float needtime=0.1f;
    public Vector3 updis=new Vector3(0,1,0);
    private MainLine line;
    private bool OK=true;
    // Start is called before the first frame update
    void Start()
    {
        line=GameObject.FindGameObjectWithTag("line").GetComponent<MainLine>();
        transform.Translate(-updis);
    }

    // Update is called once per frame
    void Update()
    {
        if((Mathf.Abs(line.transform.position.x-this.transform.position.x)<=diffdis ||Mathf.Abs(line.transform.position.z-this.transform.position.z)<=diffdis)&&OK)
        {
            OK=false;
            this.transform.DOMove(transform.position+updis,needtime);
        }
    }
}
