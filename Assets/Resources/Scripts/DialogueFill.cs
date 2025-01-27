using UnityEngine;

public class DialogueFill : MonoBehaviour
{
    [SerializeField] private TMPro.TextMeshProUGUI aurorianName;
    [SerializeField] private TMPro.TextMeshProUGUI aurorianTalk;

    public void fillDetails(string aName, string aTalk)
    {
        try
        {
            aurorianName.text = aName;
        }
        catch { }
        aurorianTalk.text = aTalk;
    }
}
