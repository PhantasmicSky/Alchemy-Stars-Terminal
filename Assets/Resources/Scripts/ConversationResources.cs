using UnityEngine;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Net;
using System;

public class ConversationResources : MonoBehaviour
{
    [SerializeField] private TextAsset charList;
    //public CharacterNames charNames = new CharacterNames();
    public Dictionary<int,string> characterNames = new Dictionary<int,string>();
    [SerializeField] private TextAsset convoStart;
    [SerializeField] private TextAsset convoFlow;
    [SerializeField] private TextAsset convoContent1;
    public Dictionary<int, ConvoStartMeta> conversationStart;
    public Dictionary<int, ConvoFlowMeta> conversationFlow;
    [SerializeField] private TextAsset convoContent2;
    public Dictionary<string,string> conversationContent = new Dictionary<string,string>();
    public Dictionary<string, string> conversationContentTemp = new Dictionary<string, string>();
    private Dictionary<int, CharacterDetails> loggedChar = new Dictionary<int, CharacterDetails>();
    private List<int> unitsInside = new List<int>();
    [SerializeField] GameObject contentField;
    [SerializeField] GameObject charPrefab;
    private void Awake()
    {
        //charNames.characterNames = JsonConvert.DeserializeObject<Dictionary<int, string>>(charList.text);
        characterNames = JsonConvert.DeserializeObject<Dictionary<int, string>>(charList.text);
        Debug.Log(characterNames[150055]);
        conversationContent = JsonConvert.DeserializeObject<Dictionary<string, string>>(convoContent1.text);
        conversationContentTemp = JsonConvert.DeserializeObject<Dictionary<string, string>>(convoContent2.text);
        foreach (var kvp in conversationContentTemp)
        {
            if (!conversationContent.ContainsKey(kvp.Key))
            {
                conversationContent.Add(kvp.Key, kvp.Value);
            }
        }
        conversationStart = JsonConvert.DeserializeObject<Dictionary<int, ConvoStartMeta>>(convoStart.text);
        conversationFlow = JsonConvert.DeserializeObject<Dictionary<int, ConvoFlowMeta>>(convoFlow.text);
        //str_quest_chat_17767001
        //Debug.Log(conversationContent["str_quest_chat_17767001"]);
        //Debug.Log(conversationContent["str_quest_chat01_19885007"]);
        testPrint(17767);
    }
    private void Start()
    {
        foreach (var kvp in conversationStart)
        {
            if (!unitsInside.Contains(kvp.Value.SpeakerId / 10)){
                GameObject temp = Instantiate(charPrefab, contentField.transform);
                try
                {
                    temp.GetComponent<CharacterDetails>().setupEntry(kvp.Value.SpeakerId / 10, characterNames[kvp.Value.SpeakerId / 10]);
                }
                catch
                {
                    temp.GetComponent<CharacterDetails>().setupEntry(kvp.Value.SpeakerId / 10, "UNKNOWN");
                }
                unitsInside.Add(kvp.Value.SpeakerId / 10);
                loggedChar.Add(kvp.Value.SpeakerId / 10, temp.GetComponent<CharacterDetails>());
            }
            loggedChar[kvp.Value.SpeakerId / 10].addStoryId(kvp.Key);
        }
    }
    private void testPrint(int id)
    {
        int cNameId = conversationStart[id].SpeakerId / 10;
        string cName = characterNames[cNameId];
        int currLine = conversationStart[id].FirstWord;
        bool continuingConversation = true;
        while (continuingConversation)
        {
            if (conversationFlow[currLine].IsMainActorWord == 0) 
            {
                Debug.Log(cName + " : " + conversationContent[conversationFlow[currLine].ChatWord]);
            }
            else
            {
                Debug.Log("Navigator : " + conversationContent[conversationFlow[currLine].ChatWord]);
            }
            if (conversationFlow[currLine].AnswerID.Count > 0)
            {
                Debug.Log("Branching Path:");
                int count = 0;
                foreach(int lineNum in conversationFlow[currLine].AnswerID)
                {
                    Debug.Log(count.ToString() + " -> " + conversationContent[conversationFlow[conversationFlow[currLine].AnswerID[count]].ChatWord]);
                    count++;
                }
                string answer = Console.ReadLine();
                int answerI = Convert.ToInt32(answer);
                currLine = conversationFlow[currLine].AnswerID[answerI];
                //currLine = conversationFlow[currLine].AnswerID[0];
            }
            else if (conversationFlow[currLine].NextWord > 0)
            {
                currLine = conversationFlow[currLine].NextWord;
            }
            else 
            {
                continuingConversation = false;
            }
        }
    }
}
