using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace SDOW屑脚本.Level.城市
{
    [RequireComponent(typeof(FollowCamera))]
    public class 点击随机相机角度 : MonoBehaviour
    {
        //该脚本需要搭配FollowCamera使用，与FollowCamera挂载于同一脚本
        [Header("X轴")]
        [Range(-360, 360)] public float MinAngleX, MaxAngleX;
        [Header("Y轴")]
        [Range(-360, 360)] public float MinAngleY, MaxAngleY;
        [Header("Z轴")]
        [Range(-360, 360)] public float MinAngleZ, MaxAngleZ;
        [Header("随机距离")]
        public bool 启用随机距离;
        [Range(-50, 100)] public float MinDistance, MaxDistance;
        private MainLine Line;
        private FollowCamera FC;
        private void Start()
        {
            Line = FindObjectOfType<MainLine>();
            FC = GetComponent<FollowCamera>();
        }

        void Update()
        {
            if (Line.start && !Line.Over && !Line.Win)
            {
                if (Input.GetMouseButtonDown(0) | Input.GetKeyDown(KeyCode.Space))
                {
                    FC.targetX = Random.Range(MinAngleX, MaxAngleX);
                    FC.targetY = Random.Range(MinAngleY, MaxAngleY);
                    FC.targetZ = Random.Range(MinAngleZ, MaxAngleZ);
                    if (启用随机距离)
                    {
                        FC.TargetDistance = Random.Range(MinDistance, MaxDistance);
                    }
                }
            }
        }
    }

}
