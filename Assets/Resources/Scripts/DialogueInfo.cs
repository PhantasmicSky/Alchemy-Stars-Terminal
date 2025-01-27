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

    private void Awake()
    {
        conRes = GameObject.FindWithTag("Resource").GetComponent<ConversationResources>();
    }

    public void populateBaseInfo(int baseId)
    {
        dialogueBaseId = baseId;
        setupBox();
    }

    private void setupBox()
    {
        int cNameId = conRes.conversationStart[dialogueBaseId].SpeakerId / 10;
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
    public IEnumerator printDialogueBox()
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
    }
    private void testPrint(int id)
    {
        int cNameId = conRes.conversationStart[id].SpeakerId / 10;
        string cName = conRes.characterNames[cNameId];
        int currLine = conRes.conversationStart[id].FirstWord;
        bool continuingConversation = true;
        while (continuingConversation)
        {
            if (conRes.conversationFlow[currLine].IsMainActorWord == 0)
            {
                Debug.Log(cName + " : " + conRes.conversationContent[conRes.conversationFlow[currLine].ChatWord]);
            }
            else
            {
                Debug.Log("Navigator : " + conRes.conversationContent[conRes.conversationFlow[currLine].ChatWord]);
            }
            if (conRes.conversationFlow[currLine].AnswerID.Count > 0)
            {
                Debug.Log("Branching Path:");
                int count = 0;
                foreach (int lineNum in conRes.conversationFlow[currLine].AnswerID)
                {
                    Debug.Log(count.ToString() + " -> " + conRes.conversationContent[conRes.conversationFlow[conRes.conversationFlow[currLine].AnswerID[count]].ChatWord]);
                    count++;
                }
                string answer = Console.ReadLine();
                int answerI = Convert.ToInt32(answer);
                currLine = conRes.conversationFlow[currLine].AnswerID[answerI];
                //currLine = conversationFlow[currLine].AnswerID[0];
            }
            else if (conRes.conversationFlow[currLine].NextWord > 0)
            {
                currLine = conRes.conversationFlow[currLine].NextWord;
            }
            else
            {
                continuingConversation = false;
            }
        }
    }
    public void closeTerminal()
    {
        Destroy(this.gameObject); 
    }
}
