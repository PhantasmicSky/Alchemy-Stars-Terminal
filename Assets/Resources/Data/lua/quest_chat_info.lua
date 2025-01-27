-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 ./quest_chat_info.luac 
-- params : ...
-- function num : 0 , upvalues : _ENV
local EnumQuestChatType = {E_QuestChat_Auto = 0, E_QuestChat_Time = 1, E_QuestChat_AirCraft = 2}
_enum("EnumQuestChatType", EnumQuestChatType)
local EnumQuestSpeakerType = {E_QuestSpeaker_No = 0, E_QuestSpeaker_Pet = 1, E_QuestSpeaker_Npc = 2}
_enum("EnumQuestSpeakerType", EnumQuestSpeakerType)
local EnumQuestChat_Limit = {E_MaxString_SpeackerName = 14}
_enum("EnumQuestChat_Limit", EnumQuestChat_Limit)
local QuestChatStatus = {
    E_ChatState_NotFind = -1,
    E_ChatState_Ready = 0,
    E_ChatState_Working = 1,
    E_ChatState_Completed = 2,
    E_ChatState_Taken = 3,
    E_ChatState_Timeout = 5
}
_enum("QuestChatStatus", QuestChatStatus)
local QuestChatValueID = {E_QuestChat_RandomValidRate = 100, E_QuestChat_RandomResetTime = 3600}
_enum("QuestChatValueID", QuestChatValueID)
_class("DQuestChatData_Talk", Object)
DQuestChatData_Talk = DQuestChatData_Talk
-- DECOMPILER ERROR at PC48: Confused about usage of register: R5 in 'UnsetPending'

DQuestChatData_Talk.Constructor = function(self)
    -- function num : 0_0
    self.m_nTalkID = 0
    self.m_bReaded = false
end

-- DECOMPILER ERROR at PC61: Confused about usage of register: R5 in 'UnsetPending'

DQuestChatData_Talk._proto = {[1] = {"m_nTalkID", "int"}, [2] = {"m_bReaded", "bool"}}
_class("DQuestChatData_Chat", Object)
DQuestChatData_Chat = DQuestChatData_Chat
-- DECOMPILER ERROR at PC70: Confused about usage of register: R5 in 'UnsetPending'

DQuestChatData_Chat.Constructor = function(self)
    -- function num : 0_1
    self.m_nChatID = 0
    self.m_nStatus = 0
    self.m_tmStart = 0
    self.m_nCount = 0
    self.m_vecTalkData = {}
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R5 in 'UnsetPending'

DQuestChatData_Chat._proto = {
    [1] = {"m_nChatID", "int"},
    [2] = {"m_nStatus", "int"},
    [3] = {"m_tmStart", "time"},
    [4] = {"m_nCount", "int"},
    [5] = {"m_vecTalkData", "list<DQuestChatData_Talk>"}
}
_class("DQuestChatData_Speaker", Object)
DQuestChatData_Speaker = DQuestChatData_Speaker
-- DECOMPILER ERROR at PC107: Confused about usage of register: R5 in 'UnsetPending'

DQuestChatData_Speaker.Constructor = function(self)
    -- function num : 0_2 , upvalues : _ENV
    self.m_nSpeakerID = 0
    self.m_stSpeakerName = ""
    self.m_vecChatData = {}
    self.m_tmRandomStart = 0
    self.m_randomChat = DQuestChatData_Chat:New()
end

-- DECOMPILER ERROR at PC135: Confused about usage of register: R5 in 'UnsetPending'

DQuestChatData_Speaker._proto = {
    [1] = {"m_nSpeakerID", "int"},
    [2] = {"m_stSpeakerName", "string"},
    [3] = {"m_vecChatData", "list<DQuestChatData_Chat>"},
    [4] = {"m_tmRandomStart", "time"},
    [5] = {"m_randomChat", "DQuestChatData_Chat"}
}
