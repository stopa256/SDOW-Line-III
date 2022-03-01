using UnityEngine;

public class AudioSpectrum : MonoBehaviour
{
    public bool OK;

    private void Update()
    {
        if (OK)
        {
            AudioListener.GetSpectrumData(m_audioSpectrum, 0, FFTWindow.Hamming);
            spectrumValue = m_audioSpectrum[0] * 100;
        }
    }

    private void Start()
    {
        m_audioSpectrum = new float[256];
    }

    public static float spectrumValue {get; private set;}

    private float[] m_audioSpectrum;
}
