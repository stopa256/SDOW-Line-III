using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.PostProcessing;
using UnityEngine.Rendering.PostProcessing;

public class PostProcessingInLevel : MonoBehaviour
{
    private PostProcessingBehaviour Behaviour;
    private PostProcessVolume PPV;
    private void Start()
    {
        if(PostProcessingControl.EnabledPost == false)
        {
            if (FindObjectOfType<PostProcessingBehaviour>()) Behaviour = FindObjectOfType<PostProcessingBehaviour>();
            if (FindObjectOfType<PostProcessVolume>()) PPV = FindObjectOfType<PostProcessVolume>();
            if (Behaviour) Behaviour.enabled = false;
            if (PPV) PPV.enabled = false;
        }
        
    }

}
