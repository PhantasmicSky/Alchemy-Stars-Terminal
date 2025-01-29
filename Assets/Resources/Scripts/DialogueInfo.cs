using NUnit.Framework;
using UnityEngine;
using System.Collections.Generic;
using System;
using System.Collections;
using UnityEngine.InputSystem.LowLevel;

public class DialogueInfo: MonoBehaviour
{
    private ConversationResources conRes;
    [SerializeField] private GameObject navigatorBox;
    [SerializeField] private GameObject aurorianBox;
    [SerializeField] private int dialogueBaseId;
    [SerializeField] private int currentDialogueId;
    [SerializeField] private bool awaitingResponse = false;
    [SerializeField] private List<int> responseOptions;
    [SerializeField] private string aurorianName;
    [SerializeField] private GameObject replyButton;
    [SerializeField] private Transform dialogueLocation;
    [SerializeField] private GameObject replyBox;
    [SerializeField] private GameObject replyButtonPrefab;
    [SerializeField] private GameObject dialogueEndLine;
    [SerializeField] private string navigatorName;

    private void Awake()
    {
        conRes = GameObject.FindWithTag("Resource").GetComponent<ConversationResources>();
    }

    public void populateBaseInfo(int baseId)
    {
        navigatorName = conRes.getNaviName();
        dialogueBaseId = baseId;
        setupBox();
    }

    private void setupBox()
    {
        //int cNameId = conRes.conversationStart[dialogueBaseId].SpeakerId / 10;
        int cNameId = conRes.conversationStart[dialogueBaseId].SpeakerId;
        try
        {
            aurorianName = conRes.characterNames[cNameId];
        }
        catch
        {
            aurorianName = "???";
        }
        currentDialogueId = conRes.conversationStart[dialogueBaseId].FirstWord;
        StartCoroutine(printDialogueBox());
    }

    //WORKING BUT DEFUNC FUNCTION AHEAD
    public IEnumerator printDialogueBoxBlitz()
    {
        while (currentDialogueId > 0)
        {
            if (conRes.conversationFlow[currentDialogueId].IsMainActorWord == 0)
            {
                GameObject tempTalk = Instantiate(aurorianBox, dialogueLocation);
                tempTalk.GetComponent<DialogueFill>().fillDetails(aurorianName, conRes.conversationContent[conRes.conversationFlow[currentDialogueId].ChatWord]);
                //Debug.Log(cName + " : " + conRes.conversationContent[conRes.conversationFlow[currLine].ChatWord]);
            }
            else
            {
                GameObject tempTalk = Instantiate(navigatorBox, dialogueLocation);
                tempTalk.GetComponent<DialogueFill>().fillDetails("", conRes.conversationContent[conRes.conversationFlow[currentDialogueId].ChatWord]);
                //Debug.Log("Navigator : " + conRes.conversationContent[conRes.conversationFlow[currLine].ChatWord]);
            }
            if (conRes.conversationFlow[currentDialogueId].AnswerID.Count > 0)
            {
                /*Debug.Log("Branching Path:");
                int count = 0;
                foreach (int lineNum in conRes.conversationFlow[currLine].AnswerID)
                {
                    Debug.Log(count.ToString() + " -> " + conRes.conversationContent[conRes.conversationFlow[conRes.conversationFlow[currLine].AnswerID[count]].ChatWord]);
                    count++;
                }
                string answer = Console.ReadLine();
                int answerI = Convert.ToInt32(answer);
                currLine = conRes.conversationFlow[currLine].AnswerID[answerI];*/
                //currLine = conversationFlow[currLine].AnswerID[0];
                currentDialogueId = conRes.conversationFlow[currentDialogueId].AnswerID[0];
            }
            else
            {
                currentDialogueId = conRes.conversationFlow[currentDialogueId].NextWord;
            }
            yield return new WaitForSeconds(0.2f);
        }
        yield return null;
        if(currentDialogueId == 0){
            Instantiate(dialogueEndLine, dialogueLocation);
        }//Debug.Log(currentDialogueId);
    }

    //DEFUNC BUT WORKING FUNCTION END
    public IEnumerator printDialogueBox()
    {
        yield return null;
        while (currentDialogueId > 0 && !awaitingResponse)
        {
            if (conRes.conversationFlow[currentDialogueId].IsMainActorWord == 0)
            {
                GameObject tempTalk = Instantiate(aurorianBox, dialogueLocation);
                string tempChatWord = conRes.conversationContent[conRes.conversationFlow[currentDialogueId].ChatWord];
                tempChatWord = tempChatWord.Replace("PlayerName", navigatorName); 
                tempTalk.GetComponent<DialogueFill>().fillDetails(aurorianName, tempChatWord);
                //Debug.Log(cName + " : " + conRes.conversationContent[conRes.conversationFlow[currLine].ChatWord]);
            }
            else
            {
                GameObject tempTalk = Instantiate(navigatorBox, dialogueLocation);
                string tempChatWord = conRes.conversationContent[conRes.conversationFlow[currentDialogueId].ChatWord];
                tempChatWord = tempChatWord.Replace("PlayerName", navigatorName); 
                tempTalk.GetComponent<DialogueFill>().fillDetails("", tempChatWord);
                //Debug.Log("Navigator : " + conRes.conversationContent[conRes.conversationFlow[currLine].ChatWord]);
            }
            if (conRes.conversationFlow[currentDialogueId].AnswerID.Count > 0)
            {
                int ccount = replyBox.transform.childCount;
                for (int i = ccount-1; i >= 0; i--)
                {
                    GameObject.DestroyImmediate(replyBox.transform.GetChild(i).gameObject);
                }
                yield return null;
                foreach(int answer in conRes.conversationFlow[currentDialogueId].AnswerID){
                    GameObject tempReply = Instantiate(replyButtonPrefab, replyBox.transform);
                    string tempChatWord = conRes.conversationContent[conRes.conversationFlow[answer].ChatWord];
                    tempChatWord = tempChatWord.Replace("PlayerName", navigatorName);
                    tempReply.GetComponent<ButtonIdentity>().setBtnReply(answer, tempChatWord,this);
                }
                replyButton.GetComponent<UnityEngine.UI.Button>().interactable = true;
                awaitingResponse = true;
            }
            else
            {
                currentDialogueId = conRes.conversationFlow[currentDialogueId].NextWord;
            }
            yield return new WaitForSeconds(0.2f);
        }
        yield return null;
        if(currentDialogueId == 0){
            Instantiate(dialogueEndLine, dialogueLocation);
        }
    }

    public void continueTerminal(int reply){
        replyButton.GetComponent<UnityEngine.UI.Button>().interactable = false;
        currentDialogueId = reply;
        awaitingResponse = false;
        //Debug.Log(currentDialogueId);
        StartCoroutine(printDialogueBox());
    }
    public void closeTerminal()
    {
        Destroy(this.gameObject); 
    }
    public void toggleReply()
    {
        replyBox.SetActive(!replyBox.activeSelf);
    }
}
