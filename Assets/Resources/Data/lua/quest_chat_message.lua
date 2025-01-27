-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 ./quest_chat_message.luac 
-- params : ...
-- function num : 0 , upvalues : _ENV
require("message_def")
local quest_chatMessageDef = {
    CLSID_CEventQuestChat_GetActiveReq = 29000,
    CLSID_CEventQuestChat_GetActiveAsw = 29001,
    CLSID_CEventQuestChat_SpeakerHistoryReq = 29002,
    CLSID_CEventQuestChat_SpeakerHistoryAsw = 29003,
    CLSID_CEventQuestChat_UpdateChatAnswerReq = 29004,
    CLSID_CEventQuestChat_UpdateChatAnswerAsw = 29005,
    CLSID_CEventQuestChat_SetTalkReadedReq = 29006,
    CLSID_CEventQuestChat_SetTalkReadedAsw = 29007,
    CLSID_CEventQuestChat_UpdateSpeakerNameReq = 29008,
    CLSID_CEventQuestChat_UpdateSpeakerNameAsw = 29009,
    CLSID_CEventQuestChat_TriggerRandomChatReq = 29010,
    CLSID_CEventQuestChat_TriggerRandomChatAsw = 29011,
    CLSID_CEventQuestChat_CompleteReq = 29012,
    CLSID_CEventQuestChat_CompleteAsw = 29013,
    CLSID_CEventQuestChat_PushSpeakerData = 29014,
    CLSID_CEventQuestChat_AllHistoryReq = 29015,
    CLSID_CEventQuestChat_AllHistoryAsw = 29016
};
(table.append)(MessageDef, quest_chatMessageDef)
local EnumErrorCode_QuestChat = {
    E_Error_QuestChat_Unknown = -1,
    E_Error_QuestChat_Succ = 0,
    E_Error_QuestChat_Fail = 1,
    E_Error_QuestChat_SpeakerID = 2,
    E_Error_QuestChat_ChatID = 3,
    E_Error_QuestChat_TalkID = 4,
    E_Error_QuestChat_AnswerID = 5,
    E_Error_QuestChat_RandomEmpty = 6,
    E_Error_QuestChat_RandomTime = 7,
    E_Error_QuestChat_RandomValid = 8,
    E_Error_QuestChat_ReadFlag = 9,
    E_Error_QuestChat_SpeakerName = 10,
    E_Error_QuestChat_SpeakerNameLen = 11,
    E_Error_QuestChat_SpeakerNameWord = 12,
    E_Error_QuestChat_ConditionEnable = 13
}
_enum("EnumErrorCode_QuestChat", EnumErrorCode_QuestChat)
_class("CEventQuestChat_GetActiveReq", CCallRequestEvent)
CEventQuestChat_GetActiveReq = CEventQuestChat_GetActiveReq
-- DECOMPILER ERROR at PC54: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_GetActiveReq.Constructor = function(self)
    -- function num : 0_0
    self.m_nSpeakerID = 0
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_GetActiveReq._proto = {[1] = {"m_nSpeakerID", "int"}}
_class("CEventQuestChat_GetActiveAsw", CCallReplyEvent)
CEventQuestChat_GetActiveAsw = CEventQuestChat_GetActiveAsw
-- DECOMPILER ERROR at PC71: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_GetActiveAsw.Constructor = function(self)
    -- function num : 0_1
    self.m_nResult = 0
    self.m_mapQuestChatData = {}
end

-- DECOMPILER ERROR at PC84: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_GetActiveAsw._proto = {
    [1] = {"m_nResult", "int"},
    [2] = {"m_mapQuestChatData", "map<int,DQuestChatData_Speaker>"}
}
_class("CEventQuestChat_SpeakerHistoryReq", CCallRequestEvent)
CEventQuestChat_SpeakerHistoryReq = CEventQuestChat_SpeakerHistoryReq
-- DECOMPILER ERROR at PC93: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_SpeakerHistoryReq.Constructor = function(self)
    -- function num : 0_2
    self.m_nSpeakerID = 0
    self.m_nChatID = 0
end

-- DECOMPILER ERROR at PC106: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_SpeakerHistoryReq._proto = {[1] = {"m_nSpeakerID", "int"}, [2] = {"m_nChatID", "int"}}
_class("CEventQuestChat_SpeakerHistoryAsw", CCallReplyEvent)
CEventQuestChat_SpeakerHistoryAsw = CEventQuestChat_SpeakerHistoryAsw
-- DECOMPILER ERROR at PC115: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_SpeakerHistoryAsw.Constructor = function(self)
    -- function num : 0_3 , upvalues : _ENV
    self.m_nResult = 0
    self.m_speakerChatData = DQuestChatData_Speaker:New()
end

-- DECOMPILER ERROR at PC128: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_SpeakerHistoryAsw._proto = {
    [1] = {"m_nResult", "int"},
    [2] = {"m_speakerChatData", "DQuestChatData_Speaker"}
}
_class("CEventQuestChat_UpdateChatAnswerReq", CCallRequestEvent)
CEventQuestChat_UpdateChatAnswerReq = CEventQuestChat_UpdateChatAnswerReq
-- DECOMPILER ERROR at PC137: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_UpdateChatAnswerReq.Constructor = function(self)
    -- function num : 0_4
    self.m_nSpeakerID = 0
    self.m_nChatID = 0
    self.m_nQuestionID = 0
    self.m_nAnswerID = 0
end

-- DECOMPILER ERROR at PC160: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_UpdateChatAnswerReq._proto = {
    [1] = {"m_nSpeakerID", "int"},
    [2] = {"m_nChatID", "int"},
    [3] = {"m_nQuestionID", "int"},
    [4] = {"m_nAnswerID", "int"}
}
_class("CEventQuestChat_UpdateChatAnswerAsw", CCallReplyEvent)
CEventQuestChat_UpdateChatAnswerAsw = CEventQuestChat_UpdateChatAnswerAsw
-- DECOMPILER ERROR at PC169: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_UpdateChatAnswerAsw.Constructor = function(self)
    -- function num : 0_5
    self.m_nResult = 0
    self.m_nSpeakerID = 0
    self.m_nChatID = 0
    self.m_vecTalkID = {}
    self.m_nStatus = 0
end

-- DECOMPILER ERROR at PC197: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_UpdateChatAnswerAsw._proto = {
    [1] = {"m_nResult", "int"},
    [2] = {"m_nSpeakerID", "int"},
    [3] = {"m_nChatID", "int"},
    [4] = {"m_vecTalkID", "list<int>"},
    [5] = {"m_nStatus", "int"}
}
_class("CEventQuestChat_SetTalkReadedReq", CCallRequestEvent)
CEventQuestChat_SetTalkReadedReq = CEventQuestChat_SetTalkReadedReq
-- DECOMPILER ERROR at PC206: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_SetTalkReadedReq.Constructor = function(self)
    -- function num : 0_6
    self.m_nSpeakerID = 0
    self.m_nChatID = 0
    self.m_nTalkID = 0
end

-- DECOMPILER ERROR at PC224: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_SetTalkReadedReq._proto = {
    [1] = {"m_nSpeakerID", "int"},
    [2] = {"m_nChatID", "int"},
    [3] = {"m_nTalkID", "int"}
}
_class("CEventQuestChat_SetTalkReadedAsw", CCallReplyEvent)
CEventQuestChat_SetTalkReadedAsw = CEventQuestChat_SetTalkReadedAsw
-- DECOMPILER ERROR at PC233: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_SetTalkReadedAsw.Constructor = function(self)
    -- function num : 0_7
    self.m_nResult = 0
    self.m_nStatus = 0
end

-- DECOMPILER ERROR at PC246: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_SetTalkReadedAsw._proto = {[1] = {"m_nResult", "int"}, [2] = {"m_nStatus", "int"}}
_class("CEventQuestChat_UpdateSpeakerNameReq", CCallRequestEvent)
CEventQuestChat_UpdateSpeakerNameReq = CEventQuestChat_UpdateSpeakerNameReq
-- DECOMPILER ERROR at PC255: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_UpdateSpeakerNameReq.Constructor = function(self)
    -- function num : 0_8
    self.m_nSpeakerID = 0
    self.m_stSpeakerName = ""
end

-- DECOMPILER ERROR at PC268: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_UpdateSpeakerNameReq._proto = {[1] = {"m_nSpeakerID", "int"}, [2] = {"m_stSpeakerName", "string"}}
_class("CEventQuestChat_UpdateSpeakerNameAsw", CCallReplyEvent)
CEventQuestChat_UpdateSpeakerNameAsw = CEventQuestChat_UpdateSpeakerNameAsw
-- DECOMPILER ERROR at PC277: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_UpdateSpeakerNameAsw.Constructor = function(self)
    -- function num : 0_9
    self.m_nResult = 0
end

-- DECOMPILER ERROR at PC285: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_UpdateSpeakerNameAsw._proto = {[1] = {"m_nResult", "int"}}
_class("CEventQuestChat_TriggerRandomChatReq", CCallRequestEvent)
CEventQuestChat_TriggerRandomChatReq = CEventQuestChat_TriggerRandomChatReq
-- DECOMPILER ERROR at PC294: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_TriggerRandomChatReq.Constructor = function(self)
    -- function num : 0_10
    self.m_nSpeakerID = 0
end

-- DECOMPILER ERROR at PC302: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_TriggerRandomChatReq._proto = {[1] = {"m_nSpeakerID", "int"}}
_class("CEventQuestChat_TriggerRandomChatAsw", CCallReplyEvent)
CEventQuestChat_TriggerRandomChatAsw = CEventQuestChat_TriggerRandomChatAsw
-- DECOMPILER ERROR at PC311: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_TriggerRandomChatAsw.Constructor = function(self)
    -- function num : 0_11 , upvalues : _ENV
    self.m_nResult = 0
    self.m_speakerChatData = DQuestChatData_Speaker:New()
end

-- DECOMPILER ERROR at PC324: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_TriggerRandomChatAsw._proto = {
    [1] = {"m_nResult", "int"},
    [2] = {"m_speakerChatData", "DQuestChatData_Speaker"}
}
_class("CEventQuestChat_CompleteReq", CCallRequestEvent)
CEventQuestChat_CompleteReq = CEventQuestChat_CompleteReq
-- DECOMPILER ERROR at PC333: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_CompleteReq.Constructor = function(self)
    -- function num : 0_12
    self.m_nChatID = 0
    self.m_nStatus = 0
end

-- DECOMPILER ERROR at PC346: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_CompleteReq._proto = {[1] = {"m_nChatID", "int"}, [2] = {"m_nStatus", "int"}}
_class("CEventQuestChat_CompleteAsw", CCallReplyEvent)
CEventQuestChat_CompleteAsw = CEventQuestChat_CompleteAsw
-- DECOMPILER ERROR at PC355: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_CompleteAsw.Constructor = function(self)
    -- function num : 0_13
    self.m_nResult = 0
end

-- DECOMPILER ERROR at PC363: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_CompleteAsw._proto = {[1] = {"m_nResult", "int"}}
_class("CEventQuestChat_PushSpeakerData", CSvrPushEvent)
CEventQuestChat_PushSpeakerData = CEventQuestChat_PushSpeakerData
-- DECOMPILER ERROR at PC372: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_PushSpeakerData.Constructor = function(self)
    -- function num : 0_14
    self.m_nResult = 0
    self.m_bRandom = 0
    self.m_mapQuestChatData = {}
    self.m_persistid = 0
end

-- DECOMPILER ERROR at PC395: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_PushSpeakerData._proto = {
    [1] = {"m_nResult", "int"},
    [2] = {"m_bRandom", "int"},
    [3] = {"m_mapQuestChatData", "map<int,DQuestChatData_Speaker>"},
    [4] = {"m_persistid", "int64"}
}
_class("CEventQuestChat_AllHistoryReq", CCallRequestEvent)
CEventQuestChat_AllHistoryReq = CEventQuestChat_AllHistoryReq
-- DECOMPILER ERROR at PC404: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_AllHistoryReq.Constructor = function(self)
    -- function num : 0_15
    self.m_nSpeakerID = 0
end

-- DECOMPILER ERROR at PC412: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_AllHistoryReq._proto = {[1] = {"m_nSpeakerID", "int"}}
_class("CEventQuestChat_AllHistoryAsw", CCallReplyEvent)
CEventQuestChat_AllHistoryAsw = CEventQuestChat_AllHistoryAsw
-- DECOMPILER ERROR at PC421: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_AllHistoryAsw.Constructor = function(self)
    -- function num : 0_16
    self.m_nResult = 0
    self.m_mapQuestChatData = {}
end

-- DECOMPILER ERROR at PC434: Confused about usage of register: R2 in 'UnsetPending'

CEventQuestChat_AllHistoryAsw._proto = {
    [1] = {"m_nResult", "int"},
    [2] = {"m_mapQuestChatData", "map<int,DQuestChatData_Speaker>"}
}
