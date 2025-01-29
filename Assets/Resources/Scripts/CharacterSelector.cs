using NUnit.Framework;
using UnityEngine;
using System.Collections.Generic;
using Unity.VisualScripting;

public class CharacterSelector : MonoBehaviour
{
    public int activeCharId;
    public List<int> activeCharTerminals;
    [SerializeField] TMPro.TextMeshProUGUI charText;
    [SerializeField] UnityEngine.UI.Image charPhoto;
    [SerializeField] Transform terminalStoryBase;
    [SerializeField] Transform terminalStoryWindow;
    private ConversationResources conRes;
    [SerializeField] GameObject terminalButtonPrefab;
    [SerializeField] GameObject terminalPrefab;
    private string naviName;
    public void Awake()
    {
        conRes = GameObject.FindWithTag("Resource").GetComponent<ConversationResources>();
    }
    public void newActive(int activeId, List<int>terminalStories, Sprite aurorianPhoto)
    {
        naviName = conRes.getNaviName();
        activeCharId = activeId;
        activeCharTerminals = terminalStories;
        try
        {
            charText.text = conRes.characterNames[activeId];
        }
        catch
        {
            charText.text = "UNKNOWN";
        }
        charPhoto.sprite = aurorianPhoto;
        foreach (Transform child in this.transform)
        {
            CharacterDetails temp = child.GetComponent<CharacterDetails>();
            if(activeId != temp.charId)
            {
                if (temp.isActive())
                {
                    temp.setActiveness(false);
                }
            }
        }
        //Remove all buttons
        //foreach (Transform child in terminalStoryBase)
        //{
            int ccount = terminalStoryBase.childCount;
            //DestroyImmediate(child.gameObject);
            for (int i = ccount-1; i >= 0; i--)
            {
                GameObject.DestroyImmediate(terminalStoryBase.transform.GetChild(i).gameObject);
            }
        //}
        //Remove actual terminal
        foreach(Transform child in terminalStoryWindow)
        {
            DestroyImmediate(child.gameObject);
        }
        //Spawn the buttons
        foreach (int terminalId in activeCharTerminals)
        {
            GameObject tempBtn = Instantiate(terminalButtonPrefab, terminalStoryBase);
            string previewString = conRes.conversationContent[conRes.conversationFlow[conRes.conversationStart[terminalId].FirstWord].ChatWord];
            previewString = previewString.Replace("PlayerName", naviName);
            try
            {
                tempBtn.GetComponent<ButtonIdentity>().setBtnString(terminalId, conRes.characterNames[activeId], activeId, previewString);
            }
            catch
            {
                tempBtn.GetComponent<ButtonIdentity>().setBtnString(terminalId, "UNKNOWN", activeId, previewString);
            }
        }
    }

    public void buttonClick(int storyId)
    {
        GameObject tempTerminal = Instantiate(terminalPrefab, terminalStoryWindow);
        tempTerminal.GetComponent<DialogueInfo>().populateBaseInfo(storyId);
    }
    public void searchAurorian(string searchString){
        if(searchString != ""){
            foreach(Transform child in this.transform){
                if(!child.GetComponent<CharacterDetails>().getCharName().StartsWith(searchString)){
                    child.gameObject.SetActive(false);
                    //child.localScale = new Vector3(0,0,0);
                }
                else{
                    child.gameObject.SetActive(true);
                    //child.localScale = new Vector3(1,1,1);
                }
            }
        }
        else{
            foreach(Transform child in this.transform){
                child.gameObject.SetActive(true);
                //child.localScale = new Vector3(1,1,1);
            }
        }
    }
}
