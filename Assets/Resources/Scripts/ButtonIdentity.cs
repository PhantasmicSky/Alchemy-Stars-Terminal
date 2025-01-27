using UnityEngine;

public class ButtonIdentity: MonoBehaviour
{
    public int btnId;
    public string btnName;
    public int btnCharId;
    [SerializeField] private TMPro.TextMeshProUGUI btnText;
    [SerializeField] private DialogueInfo dialogueRef;



    public void setBtnString(int btId, string btName, int btCharId)
    {
        this.GetComponent<UnityEngine.UI.Button>().onClick.AddListener(showStory);
        btnId = btId;
        btnName = btName;
        btnCharId = btCharId;
        btnText.text = btId.ToString();
    }
    public void setBtnReply(int btId, string btText, DialogueInfo di){
        this.GetComponent<UnityEngine.UI.Button>().onClick.AddListener(replyToTerminal);
        btnId = btId;
        btnText.text = btText;
        dialogueRef = di;
    }
    //Used for Terminal
    void showStory()
    {
        this.GetComponentInParent<CharacterSelector>().buttonClick(btnId);
    }
    void replyToTerminal(){
        dialogueRef.continueTerminal(btnId);
        dialogueRef.toggleReply();
    }

    //Used for Reply

}
