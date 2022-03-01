using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class SaveObject : MonoBehaviour
{
    // Start is called before the first frame update

    private void Start()
    {
        DontDestroyOnLoad(this.gameObject);

        if (GameObject.Find(gameObject.name)
                && GameObject.Find(gameObject.name) != this.gameObject)
        {
            Destroy(GameObject.Find(gameObject.name));
        }
    }

    // Update is called once per frame
    private void Update()
    {
        
    }
}
