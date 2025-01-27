using UnityEngine;

public class SetNavigatorName : MonoBehaviour
{
    [SerializeField] private TMPro.TextMeshProUGUI textField;
    [SerializeField] private GameObject startScreen;
    [SerializeField] private ConversationResources conRes;

    public void setNaviName(){
        conRes.setNaviName(textField.text);
        startScreen.SetActive(false);
    }
}
