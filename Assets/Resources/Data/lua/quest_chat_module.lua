-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 ./quest_chat_module.luac 
-- params : ...
-- function num : 0 , upvalues : _ENV
_class("QuestChatModule", GameModule)
QuestChatModule = QuestChatModule
-- DECOMPILER ERROR at PC8: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.Constructor = function(self)
    -- function num : 0_0 , upvalues : _ENV
    self.m_mapChatData = {}
    self.weChatProxy = WeChatProxy:New(self)
end

-- DECOMPILER ERROR at PC11: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.Dispose = function(self)
    -- function num : 0_1 , upvalues : _ENV
    if self.weChatProxy then
        (self.weChatProxy):Dispose()
        self.weChatProxy = nil
    end
    (self.caller):UnRegisterPushHandler(CEventQuestChat_PushSpeakerData);
    ((QuestChatModule.super).Dispose)(self)
end

-- DECOMPILER ERROR at PC14: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.Init = function(self)
    -- function num : 0_2 , upvalues : _ENV
    (self.caller):RegisterPushHandler(CEventQuestChat_PushSpeakerData, self.OnRecvMsg_QuestChat, self)
end

-- DECOMPILER ERROR at PC17: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.Update = function(self, deltaTimeMS)
    -- function num : 0_3
end

-- DECOMPILER ERROR at PC20: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.GetPetChatState = function(self, nSpeakerID, nChatID)
    -- function num : 0_4 , upvalues : _ENV
    local chat_data = self:_FindChatData(nSpeakerID, nChatID)
    if chat_data == nil then
        return QuestChatStatus.E_ChatState_NotFind
    end
    return chat_data.m_nStatus
end

-- DECOMPILER ERROR at PC23: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.FindUnReadCount = function(self, nSpeakerID, nChatID)
    -- function num : 0_5
    local pFindChatData = self:_FindChatData(nSpeakerID, nChatID)
    if pFindChatData == nil then
        return 0
    end
    return self:_StatUnReadCount(pFindChatData)
end

-- DECOMPILER ERROR at PC26: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.FindActiveChatID = function(self, nSpeakerID)
    -- function num : 0_6 , upvalues : _ENV
    local pFindSpeaker = self:_FindSpeakerData(nSpeakerID)
    if pFindSpeaker == nil then
        return 0, 0
    end
    local nChatCount = (table.count)(pFindSpeaker.m_vecChatData)
    for i = 1, nChatCount do
        local chatData = (pFindSpeaker.m_vecChatData)[i]
        if self:_IsChatWorking(chatData) then
            return chatData.m_nChatID, self:_StatUnReadCount(chatData)
        end
    end
    return 0, 0
end

-- DECOMPILER ERROR at PC29: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule._StatUnReadCount = function(self, chatData)
    -- function num : 0_7 , upvalues : _ENV
    local nTalkCount = (table.count)(chatData.m_vecTalkData)
    local nReturn = 0
    for i = 1, nTalkCount do
        local talkData = (chatData.m_vecTalkData)[i]
        if talkData.m_bReaded == false then
            nReturn = nReturn + 1
        end
    end
    return nReturn
end

-- DECOMPILER ERROR at PC32: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule._IsChatWorking = function(self, chatData)
    -- function num : 0_8 , upvalues : _ENV
    if QuestChatStatus.E_ChatState_Ready < chatData.m_nStatus and chatData.m_nStatus <
        QuestChatStatus.E_ChatState_Completed then
        return true
    end
    return false
end

-- DECOMPILER ERROR at PC35: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule._FindSpeakerData = function(self, nSpeakerID)
    -- function num : 0_9
    return (self.m_mapChatData)[nSpeakerID]
end

-- DECOMPILER ERROR at PC38: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule._FindChatData = function(self, nSpeakerID, nChatID)
    -- function num : 0_10
    local pSpeakerData = self:_FindSpeakerData(nSpeakerID)
    if pSpeakerData == nil then
        return nil
    end
    return self:_FindChatDataBySpeakerData(pSpeakerData, nChatID)
end

-- DECOMPILER ERROR at PC41: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule._FindTalkData = function(self, nSpeakerID, nChatID, nTalkID)
    -- function num : 0_11 , upvalues : _ENV
    local pChatData = self:_FindChatData(nSpeakerID, nChatID)
    if pChatData == nil then
        return nil
    end
    local nTalkCount = (table.count)(pChatData.m_vecTalkData)
    for i = 1, nTalkCount do
        local talkData = (pChatData.m_vecTalkData)[i]
        if nTalkID == talkData.m_nTalkID then
            return talkData
        end
    end
    return nil
end

-- DECOMPILER ERROR at PC44: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule._FindChatDataBySpeakerData = function(self, pSpeakerData, nChatID)
    -- function num : 0_12 , upvalues : _ENV
    local nChatCount = (table.count)(pSpeakerData.m_vecChatData)
    for i = 1, nChatCount do
        local chatData = (pSpeakerData.m_vecChatData)[i]
        if chatData.m_nChatID == nChatID then
            return chatData
        end
    end
    return nil
end

-- DECOMPILER ERROR at PC47: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule._SaveChatData = function(self, pSpeakerData, recvChatData, nDataSource)
    -- function num : 0_13 , upvalues : _ENV
    local pChatData_Chat = self:_FindChatDataBySpeakerData(pSpeakerData, recvChatData.m_nChatID)
    if pChatData_Chat == nil then
        (table.insert)(pSpeakerData.m_vecChatData, recvChatData);
        (self.weChatProxy):AddChat(pSpeakerData.m_nSpeakerID, recvChatData, nDataSource);
        (Log.debug)("[QuestChat] AddChat ChatData, nSpeakerID = ", pSpeakerData.m_nSpeakerID, ", nChatID = ",
            recvChatData.m_nChatID)
        return
    end
    pChatData_Chat = recvChatData;
    (self.weChatProxy):UpdateChat(pSpeakerData.m_nSpeakerID, recvChatData, nDataSource);
    (Log.debug)("[QuestChat] UpdateChat ChatData, nSpeakerID = ", pSpeakerData.m_nSpeakerID, ", nChatID = ",
        recvChatData.m_nChatID)
end

-- DECOMPILER ERROR at PC50: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule._SaveSpeakerData = function(self, recvSpeakerData, nDataSource)
    -- function num : 0_14 , upvalues : _ENV
    if self.weChatProxy == nil then
        return
    end
    local nSpeakerID = recvSpeakerData.m_nSpeakerID
    local pSpeakerData = self:_FindSpeakerData(nSpeakerID)
    if pSpeakerData == nil then
        local inner = false
        for key, value in pairs(recvSpeakerData.m_vecChatData) do
            local chatid = value.m_nChatID
            if (Cfg.cfg_quest_chat)[chatid] then
                inner = true
                break
            end
        end
        do
            if inner then
                pSpeakerData = (table.cloneconf)(recvSpeakerData) -- DECOMPILER ERROR at PC33: Confused about usage of register: R6 in 'UnsetPending'
                ;
                (self.m_mapChatData)[nSpeakerID] = pSpeakerData
                if self:_IsChatWorking(recvSpeakerData.m_randomChat) then
                    self:_SaveChatData(pSpeakerData, recvSpeakerData.m_randomChat, nDataSource)
                end
                pSpeakerData.m_randomChat = nil
                if nDataSource == 1 then
                    for i = #recvSpeakerData.m_vecChatData, 1, -1 do
                        if ((recvSpeakerData.m_vecChatData)[i]).m_nStatus < 2 then
                            (table.remove)(recvSpeakerData.m_vecChatData, i)
                        end
                    end
                end
                do
                    do

                        (self.weChatProxy):UpdateRole(nSpeakerID, recvSpeakerData)
                        do
                            return
                        end
                        if nDataSource == 1 then
                            for i = #recvSpeakerData.m_vecChatData, 1, -1 do
                                if ((recvSpeakerData.m_vecChatData)[i]).m_nStatus < 2 then
                                    (table.remove)(recvSpeakerData.m_vecChatData, i)
                                end
                            end
                        end
                        do
                            local nChatCount = (table.count)(recvSpeakerData.m_vecChatData)
                            for i = 1, nChatCount do
                                local chatData = (recvSpeakerData.m_vecChatData)[i]
                                self:_SaveChatData(pSpeakerData, chatData, nDataSource)
                            end
                        end
                    end
                end
            end
        end
    end
end

-- DECOMPILER ERROR at PC53: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule._Request_Packet = function(self, TT, packetRequest)
    -- function num : 0_15 , upvalues : _ENV
    local res = AsyncRequestRes:New()
    local reply = self:Call(TT, packetRequest)
    if reply.res ~= CallResultType.Normal then
        if reply.msg then
            res:SetResult((reply.msg).m_nResult)
        else
            res:SetResult(EnumErrorCode_QuestChat.E_Error_QuestChat_Fail)
        end
        return res, nil
    end
    res:SetSucc(true)
    return res, reply.msg
end

-- DECOMPILER ERROR at PC56: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.Request_GetActiveChat = function(self, TT)
    -- function num : 0_16
    return self:Request_GetActiveChatBySpeakerID(TT, 0)
end

-- DECOMPILER ERROR at PC59: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.Request_GetActiveChatBySpeakerID = function(self, TT, nSpeakerID)
    -- function num : 0_17 , upvalues : _ENV
    local request = (NetMessageFactory:GetInstance()):CreateMessage(CEventQuestChat_GetActiveReq)
    request.m_nSpeakerID = nSpeakerID
    local res, replyMsg = self:_Request_Packet(TT, request)
    if replyMsg then
        local recvPacket = replyMsg
        for key, value in pairs(recvPacket.m_mapQuestChatData) do
            self:_SaveSpeakerData(value, 0)
        end
    end
    do
        return res
    end
end

-- DECOMPILER ERROR at PC62: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.Request_SpeakerHistory = function(self, TT, nSpeakerID)
    -- function num : 0_18 , upvalues : _ENV
    local request = (NetMessageFactory:GetInstance()):CreateMessage(CEventQuestChat_SpeakerHistoryReq)
    request.m_nSpeakerID = nSpeakerID
    request.m_nChatID = 0
    local res, replyMsg = self:_Request_Packet(TT, request)
    do
        if replyMsg then
            local recvPacket = replyMsg
            self:_SaveSpeakerData(recvPacket.m_speakerChatData, 1)
        end
        return res
    end
end

-- DECOMPILER ERROR at PC65: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.Request_AllHistory = function(self, TT)
    -- function num : 0_19 , upvalues : _ENV
    local request = (NetMessageFactory:GetInstance()):CreateMessage(CEventQuestChat_AllHistoryReq)
    request.m_nSpeakerID = 0
    local res, replyMsg = self:_Request_Packet(TT, request)
    if replyMsg then
        local recvPacket = replyMsg
        for key, value in pairs(recvPacket.m_mapQuestChatData) do
            self:_SaveSpeakerData(value, 0)
        end
    end
    do
        return res
    end
end

-- DECOMPILER ERROR at PC68: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.Request_UpdateChatAnswer = function(self, TT, nSpeakerID, nChatID, nQuestionID, nAnswerID)
    -- function num : 0_20 , upvalues : _ENV
    local request = (NetMessageFactory:GetInstance()):CreateMessage(CEventQuestChat_UpdateChatAnswerReq)
    request.m_nSpeakerID = nSpeakerID
    request.m_nChatID = nChatID
    request.m_nQuestionID = nQuestionID
    request.m_nAnswerID = nAnswerID
    local res, replyMsg = self:_Request_Packet(TT, request)
    if replyMsg then
        local recvPacket = replyMsg
        if recvPacket.m_nResult == EnumErrorCode_QuestChat.E_Error_QuestChat_Succ then
            local pFindChatData = self:_FindChatData(recvPacket.m_nSpeakerID, recvPacket.m_nChatID)
            if pFindChatData then
                local talkAnswer = DQuestChatData_Talk:New()
                talkAnswer.m_nTalkID = nAnswerID
                talkAnswer.m_bReaded = true;
                (table.insert)(pFindChatData.m_vecTalkData, talkAnswer)
                pFindChatData.m_nStatus = recvPacket.m_nStatus;
                (self.weChatProxy):AddTalk(recvPacket.m_nSpeakerID, recvPacket.m_nChatID, pFindChatData.m_nStatus,
                    pFindChatData.m_nCount, talkAnswer, false)
                local nRecvCount = (table.count)(recvPacket.m_vecTalkID)
                if nRecvCount == 0 then
                    (self.weChatProxy):SetInitState(recvPacket.m_nSpeakerID, true)
                end
                for i = 1, nRecvCount do
                    local talkData = DQuestChatData_Talk:New()
                    talkData.m_nTalkID = (recvPacket.m_vecTalkID)[i]
                    talkData.m_bReaded = false;
                    (table.insert)(pFindChatData.m_vecTalkData, talkData);
                    (self.weChatProxy):AddTalk(recvPacket.m_nSpeakerID, recvPacket.m_nChatID, pFindChatData.m_nStatus,
                        pFindChatData.m_nCount, talkData, true)
                end
            end
        end
    end
    do
        return res
    end
end

-- DECOMPILER ERROR at PC71: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.Request_UpdateSpeakerName = function(self, TT, nSpeakerID, stSpeakerName)
    -- function num : 0_21 , upvalues : _ENV
    local request = (NetMessageFactory:GetInstance()):CreateMessage(CEventQuestChat_UpdateSpeakerNameReq)
    request.m_nSpeakerID = nSpeakerID
    request.m_stSpeakerName = stSpeakerName
    local res, replyMsg = self:_Request_Packet(TT, request)
    do
        if replyMsg then
            local pSpeakerData = self:_FindSpeakerData(nSpeakerID)
            if pSpeakerData then
                pSpeakerData.m_stSpeakerName = stSpeakerName
            else

                (Log.debug)("[QuestChat] 修改SpeakerName时没有找到对应", nSpeakerID, "的交互信息")
            end
            return res, replyMsg.m_nResult
        end
        return res, EnumErrorCode_QuestChat.E_Error_QuestChat_Fail
    end
end

-- DECOMPILER ERROR at PC74: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.Request_SetTalkReaded = function(self, TT, nSpeakerID, nChatID, nTalkID, triggerIndex)
    -- function num : 0_22 , upvalues : _ENV
    local request = (NetMessageFactory:GetInstance()):CreateMessage(CEventQuestChat_SetTalkReadedReq)
    request.m_nSpeakerID = nSpeakerID
    request.m_nChatID = nChatID
    request.m_nTalkID = nTalkID
    local res, replyMsg = self:_Request_Packet(TT, request)
    if replyMsg then
        local recvPacket = replyMsg
        if EnumErrorCode_QuestChat.E_Error_QuestChat_Succ == recvPacket.m_nResult then
            local pTalkData = self:_FindTalkData(nSpeakerID, nChatID, nTalkID)
            if pTalkData then
                pTalkData.m_bReaded = true;
                (self.weChatProxy):SetTalkReaded(nSpeakerID, nChatID, nTalkID, triggerIndex)
            end
            local pChatData = self:_FindChatData(nSpeakerID, nChatID)
            if pChatData then
                pChatData.m_nStatus = recvPacket.m_nStatus
            end
        end
    end
    do
        res:SetSucc(true)
        return res
    end
end

-- DECOMPILER ERROR at PC77: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.Request_CompleteChat = function(self, TT, nChatID, nStatus)
    -- function num : 0_23 , upvalues : _ENV
    local request = (NetMessageFactory:GetInstance()):CreateMessage(CEventQuestChat_CompleteReq)
    if not nStatus then
        request.m_nStatus = QuestChatStatus.E_ChatState_Completed
        request.m_nChatID = nChatID
        local res, replyMsg = self:_Request_Packet(TT, request)
        do
            if replyMsg then
                local recvPacket = replyMsg
            end
            res:SetSucc(true)
            return res
        end
    end
end

-- DECOMPILER ERROR at PC80: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.OnRecvMsg_QuestChat = function(self, msg)
    -- function num : 0_24 , upvalues : _ENV
    ((GameGlobal.TaskManager)()):StartTask(QuestChatModule.HandleQuestChatPushEvent, self, msg)
end

-- DECOMPILER ERROR at PC83: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.HandleQuestChatPushEvent = function(self, TT, msg)
    -- function num : 0_25 , upvalues : _ENV
    if self.weChatProxy == nil then
        return
    end
    if self.allHistoryTaskId and (TaskHelper:GetInstance()):IsTaskFinished(self.allHistoryTaskId) == false then
        YIELD(TT)
        while (TaskHelper:GetInstance()):IsTaskFinished(self.allHistoryTaskId) == false do
            YIELD(TT)
        end
        self:InitEachSpeaker(TT, msg)
    else
        self.allHistoryTaskId = (self.weChatProxy):InitAllLocalSpeaker(msg.m_persistid)
        while 1 do
            if self.allHistoryTaskId and (TaskHelper:GetInstance()):IsTaskFinished(self.allHistoryTaskId) == false then
                if (TaskHelper:GetInstance()):IsTaskFinished(self.allHistoryTaskId) == false then
                    YIELD(TT)
                    -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC62: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
        self.allHistoryTaskId = nil
    end
    self:InitEachSpeaker(TT, msg)
    local isShow = ((GameGlobal.UIStateManager)()):IsShow("UIMainLobbyController")
    if isShow then
        ((GameGlobal.EventDispatcher)()):Dispatch(GameEventType.UpdateWeChatRed);
        ((GameGlobal.EventDispatcher)()):Dispatch(GameEventType.UpdateWeChatMainTalk)
    end
end

-- DECOMPILER ERROR at PC86: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.InitEachSpeaker = function(self, TT, msg)
    -- function num : 0_26 , upvalues : _ENV
    if not self.weChatProxy then
        return
    end
    local waitHistoryTaskId = {}
    for nSpeakerID, speakerData in pairs(msg.m_mapQuestChatData) do
        local taskId = (self.weChatProxy):InitLocalSpeaker(nSpeakerID, msg.m_persistid, speakerData)
        while 1 do
            if taskId and taskId > 0 then
                if (TaskHelper:GetInstance()):IsTaskFinished(taskId) == false then
                    YIELD(TT)
                    -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC30: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
        (table.insert)(waitHistoryTaskId, taskId)
    end
    local count = #waitHistoryTaskId
    while count > 0 and not (TaskHelper:GetInstance()):IsAllTaskFinished(waitHistoryTaskId) do
        YIELD(TT)
    end
    for nSpeakerID, speakerData in pairs(msg.m_mapQuestChatData) do
        self:_SaveSpeakerData(speakerData, 0);
        (self.weChatProxy):UpdateRoleName(speakerData.m_nSpeakerID, speakerData.m_stSpeakerName)
    end
end

-- DECOMPILER ERROR at PC89: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.UI_GetChatSummaryList = function(self)
    -- function num : 0_27
end

-- DECOMPILER ERROR at PC92: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.UI_GetSpeakerChat = function(self, nSpeakerID, nChatID)
    -- function num : 0_28
end

-- DECOMPILER ERROR at PC95: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.UI_GetSpeakerHistory = function(self, nSpeakerID)
    -- function num : 0_29
end

-- DECOMPILER ERROR at PC98: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.UI_IsChatEnd = function(self, nChatID)
    -- function num : 0_30 , upvalues : _ENV
    local cfgChat = (Cfg.cfg_quest_chat)[nChatID]
    if cfgChat == nil then
        (Log.error)("[Quest_Chat] UI_IsChatEnd中发现错误的ChatID = ", nChatID)
        return false
    end
    local nSpeakerID = cfgChat.SpeakerID
    local pFindChatData = self:_FindChatData(nSpeakerID, nChatID)
    if pFindChatData == nil then
        if (self.weChatProxy):IsChatInHistory(nSpeakerID, nChatID) == true then
            return true
        end
        (Log.info)("[Quest_Chat] UI_IsChatEnd中发现错误的ChatID = ", nChatID, ", SpeakerID = ", nSpeakerID)
        return false
    end
    if pFindChatData.m_nStatus < QuestChatStatus.E_ChatState_Completed then
        return false
    end
    if QuestChatStatus.E_ChatState_Taken < pFindChatData.m_nStatus then
        return false
    end
    return true
end

-- DECOMPILER ERROR at PC101: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.UI_TestDebug = function(self)
    -- function num : 0_31 , upvalues : _ENV
    local nSpeakerID = 2100106
    local nChatID = 30302
    local nFindTalkID = 30302001
    local listTalkID = {}
    while 1 do
        if nFindTalkID > 0 then
            (table.insert)(listTalkID, nFindTalkID)
            local pFindTalk = (Cfg.cfg_quest_talk)[nFindTalkID]
            if pFindTalk ~= nil then
                do
                    nFindTalkID = pFindTalk.NextWord
                    -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

                    -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_THEN_STMT

                    -- DECOMPILER ERROR at PC19: LeaveBlock: unexpected jumping out IF_STMT

                end
            end
        end
    end
    if nFindTalkID ~= nil then
        do
            for i = 1, #listTalkID do
                local nTalkID = listTalkID[i];
                (TaskManager:GetInstance()):StartTask(function(TT)
                    -- function num : 0_31_0 , upvalues : self, nSpeakerID, nChatID, nTalkID, i
                    self:Request_SetTalkReaded(TT, nSpeakerID, nChatID, nTalkID, i)
                end)
            end
        end
    end
end

-- DECOMPILER ERROR at PC104: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.UI_StatCompleteTalkInChat = function(self, chaitd, talkid)
    -- function num : 0_32 , upvalues : _ENV
    local cfg = (Cfg.cfg_quest_chat)[chaitd]
    if not cfg then
        (Log.error)("###[QuestChatModule] cfg_quest_chat is nil ! id --> ", chaitd)
        return false
    end
    local speakerid = cfg.SpeakerID
    local role = (self.weChatProxy):GetRole(speakerid)
    if role then
        local chats = role.chats
        if chats then
            for i = 1, #chats do
                local chat = chats[i]
                if chat then
                    local _chatid = chat.chatId
                    if _chatid == chaitd then
                        local talks = chat.talks
                        if talks then
                            for j = 1, #talks do
                                local talk = talks[j]
                                if talk then
                                    local _talkid = talk.talkId
                                    if _talkid == talkid and talk.readed then
                                        return true
                                    end
                                    break
                                end
                            end
                        end
                        break
                    end
                end
            end
        end
    end
end

-- DECOMPILER ERROR at PC107: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.UI_StatCompleteCount = function(self, nFindSpeakerID)
    -- function num : 0_33 , upvalues : _ENV
    local nCount = 0
    local role = (self.weChatProxy).roles
    if role == nil then
        return nCount
    end
    for vid, speakerData in pairs(role) do
        if nFindSpeakerID == 0 or nFindSpeakerID == speakerData.speakerId then
            local chats = speakerData:GetChats()
            for key, value in pairs(chats) do
                if QuestChatStatus.E_ChatState_Completed <= value.state and value.state <=
                    QuestChatStatus.E_ChatState_Taken then
                    nCount = nCount + 1
                end
            end
        end
    end
    do
        if nFindSpeakerID == 0 then
            return nCount
        end
    end
end

-- DECOMPILER ERROR at PC110: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.GetErrorMsg = function(self, nErrorCode)
    -- function num : 0_34 , upvalues : _ENV
    local vecErrorMsg = {
        [EnumErrorCode_QuestChat.E_Error_QuestChat_Succ] = (StringTable.Get)("str_extra_mission_error_success"),
        [EnumErrorCode_QuestChat.E_Error_QuestChat_Unknown] = (StringTable.Get)("str_extra_mission_error_fail"),
        [EnumErrorCode_QuestChat.E_Error_QuestChat_SpeakerName] = (StringTable.Get)(
            "str_guide_ROLE_ERROR_CHANGE_NICK_SPE"),
        [EnumErrorCode_QuestChat.E_Error_QuestChat_SpeakerNameWord] = (StringTable.Get)(
            "str_guide_ROLE_ERROR_DIRTY_NICK")
    }
    local stErrorMsg = vecErrorMsg[nErrorCode]
    if stErrorMsg == nil then
        return "Unknown ErrorCode"
    end
    return stErrorMsg
end

-- DECOMPILER ERROR at PC113: Confused about usage of register: R0 in 'UnsetPending'

QuestChatModule.GetWeChatProxy = function(self)
    -- function num : 0_35
    return self.weChatProxy
end
