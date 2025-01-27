using NUnit.Framework;
using UnityEngine;
using System.Collections.Generic;

public class ConvoFlowMeta
{
    public string ChatWord;
    public int IsFirst;
    public int IsMainActorWord;
    public int NextWord;
    public List<int> AnswerID = new List<int>();
    public int VoiceID;
}
