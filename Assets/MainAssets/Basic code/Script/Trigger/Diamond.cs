using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Diamond : MonoBehaviour
{

    [HideInInspector] public MainLine MainLine;
    public GameObject remains;
	public GameObject PickDiamondEffect;
    //private Material mat;

    private void Start()
    {
        //mat = GetComponent<MeshRenderer>().material;
        MainLine = GameObject.FindObjectOfType<MainLine>();
    }
    void OnTriggerEnter(Collider other)
    {
		if (other.GetComponent<MainLine> () != null)
        {
            //MeshRenderer[] mrs = remains.GetComponentsInChildren<MeshRenderer>();
            //foreach(MeshRenderer r in mrs)
            //{
            //    if(r.sharedMaterial != mat)
            //    {
            //        r.material = mat;
            //    }
            //}
            MainLine.GetComponent<MainLine>().PickDiamondCount++;
            Destroy(Instantiate(remains, this.transform.position, this.transform.rotation),8);
			Destroy (Instantiate(PickDiamondEffect, this.transform.position, Quaternion.Euler(Vector3.zero)), 8);
			Destroy (this.gameObject);
		}
    }
    void Update()
    {
        this.gameObject.transform.Rotate(0, 4, 0);
    }
}
