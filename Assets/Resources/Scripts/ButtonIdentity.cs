using UnityEngine;

public class ButtonIdentity: MonoBehaviour
{
    public int btnId;
    public string btnName;
    public int btnCharId;
    [SerializeField] private TMPro.TextMeshProUGUI btnText;

    private void Awake()
    {
        this.GetComponent<UnityEngine.UI.Button>().onClick.AddListener(showStory);
    }

    public void setBtnString(int btId, string btName, int btCharId)
    {
        btnId = btId;
        btnName = btName;
        btnCharId = btCharId;
        btnText.text = btId.ToString();
    }
    void showStory()
    {
        this.GetComponentInParent<CharacterSelector>().buttonClick(btnId);
    }

}
