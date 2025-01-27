using NUnit.Framework;
using UnityEngine;
using System.Collections.Generic;
using UnityEngine.EventSystems;

public class CharacterDetails : MonoBehaviour, IPointerEnterHandler, IPointerExitHandler, IPointerClickHandler
{
    [SerializeField] private TMPro.TextMeshProUGUI charName;
    [SerializeField] private TMPro.TextMeshProUGUI charEcho;
    [SerializeField] private TMPro.TextMeshProUGUI storyCount;
    [SerializeField] public int charId;
    [SerializeField] private string charNameStr;
    [SerializeField] private GameObject[] activeIndicators;
    private List<int> conversationCollection = new List<int>();
    private bool active = false;
    public void setupEntry(int resId, string charStr)
    {
        charNameStr = charStr;
        charName.text = charStr;
        charEcho.text = charStr.ToUpper();
        charId = resId;
    }
    public void addStoryId(int storyId)
    {
        conversationCollection.Add(storyId);
        storyCount.text = conversationCollection.Count.ToString(); 
    }

    public void OnPointerEnter(PointerEventData eventData)
    {
        this.transform.GetChild(0).GetComponent<Transform>().localPosition = new Vector3(30.0f,0f,0f);
        //throw new System.NotImplementedException();
    }

    public void OnPointerExit(PointerEventData eventData)
    {
        if (!active)
        {
            this.transform.GetChild(0).GetComponent<Transform>().localPosition = new Vector3(0f, 0f, 0f);
        }
    }
    public void setActiveness(bool act)
    {
        active = act;
        foreach (GameObject activeFX in activeIndicators)
        {
            activeFX.SetActive(act);
        }
        if (!active)
        {
            this.transform.GetChild(0).GetComponent<Transform>().localPosition = new Vector3(0f, 0f, 0f);
        }
    }

    public void OnPointerClick(PointerEventData eventData)
    {
        Debug.Log("click!");
        this.transform.GetChild(0).GetComponent<Transform>().localPosition = new Vector3(30.0f, 0f, 0f);
        setActiveness(true);
        this.transform.GetComponentInParent<CharacterSelector>().newActive(charId, conversationCollection);
    }
    public bool isActive() 
    {
        return active;
    }
    public string getCharName(){
        return charNameStr;
    }
}
