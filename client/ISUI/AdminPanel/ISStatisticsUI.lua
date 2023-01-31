require "ISUI/ISPanelJoypad"

ISStatisticsUI = ISCollapsableWindow:derive("ISStatisticsUI");

function ISStatisticsUI:createChildren()
    ISCollapsableWindow.createChildren(self)
end

function ISStatisticsUI:close()
    self:setVisible(false);
    self:removeFromUIManager();
    self.player:setShowMPInfos(false)
    ISStatisticsUI.instance = nil
end

function ISStatisticsUI:prerender()
    ISCollapsableWindow.prerender(self);
end

function ISStatisticsUI:initialise()
    ISCollapsableWindow.initialise(self)
    self.title = getText("IGUI_AdminPanel_HeaderShowStatistics")
end

local function getWorldAge()
    local h = math.floor(getGameTime():getWorldAgeHours())
    local days = math.floor(h / 24)
    local hours = h - days * 24
    return days .. "Days " .. hours .. "H"
end

function ISStatisticsUI:render()

    ISCollapsableWindow.render(self);

    if not self.isCollapsed then

        local statisticsData = getMPStatistics()

        local padding = 20
        local text_width = 80
        local field_width = 60
        local highlight_height = 20

        local a = 0.90

        local tr = 1
        local tg = 1
        local tb = 0.8

        local tar = 1
        local tag = 1
        local tab = 0.8

        local hr = 1
        local hg = 0.75
        local hb = 0.5

        local la = 0.08
        local lah = 0.3
        local lr = 0.9
        local lg = 0.9
        local lb = 0.9

        local line_lenght = text_width+field_width*2+padding*2

        local startX = padding
        local startY = padding*0.75

        posX = startX+padding
        posY = startY+padding/2

        self:drawTextRight("Client", posX+text_width+field_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        self:drawTextRight("Server", posX+text_width+field_width*2, posY, hr, hg, hb, a, UIFont.NewMedium);

        self:drawTextRight("CPU", posX+text_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight("Cores : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientCPUCores, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverCPUCores, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Load (%) : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientCPULoad, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverCPULoad, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding

        self:drawTextRight("Memory", posX+text_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight("Free (MB) : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientMemFree, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverMemFree, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Used (MB) : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientMemUsed, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverMemUsed, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Total (MB) : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientMemTotal, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverMemTotal, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Max (MB) : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientMemMax, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverMemMax, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding

        self:drawTextRight("FPS", posX+text_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight("Main : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientFPS, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverFPS, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Networking : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverNetworkingFPS, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding

        self:drawTextRight("Network", posX+text_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight("RX (KB) : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientRX, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverRX, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("TX (KB) : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientTX, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverTX, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Resent (KB) : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientResent, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverResent, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Loss (%) : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientLoss, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverLoss, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding

        self:drawTextRight("VOIP", posX+text_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight("RX (KB) : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientVOIPRX, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverVOIPRX, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("TX (KB) : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientVOIPTX, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverVOIPTX, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Source : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientVOIPSource, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientVOIPFreq, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding

        self:drawTextRight("Ping", posX+text_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight("Last : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientLastPing, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Average : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientAvgPing, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Minimum : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientMinPing, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding

        self:drawTextRight("Packet Ping", posX+text_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight("Last : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverPingLast, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Average : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverPingAvg, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Loss : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverPingLoss, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Maximum : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverPingMax, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Minimum : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverPingMin, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding

        self:drawTextRight("Time", posX+text_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight("Client : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientTime, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Server : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverTime, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, la, lr, lg, lb);
        self:drawTextRight("World : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(getWorldAge(), posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding

        self:drawRect(self.width/2, 30, 1, self.height-padding*2, lah, lr, lg, lb);

        local startX = self.width/2+1
        local startY = padding*0.75

        posX = self.width/2+padding*2
        posY = startY+padding/2

        self:drawTextRight("Client", posX+text_width+field_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        self:drawTextRight("Server", posX+text_width+field_width*2, posY, hr, hg, hb, a, UIFont.NewMedium);

        self:drawTextRight("Players", posX+text_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight("Connected : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientPlayers, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverPlayers, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding

        self:drawTextRight("Zombies", posX+text_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight("Total : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientZombiesTotal, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverZombiesTotal, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Loaded : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientZombiesLoaded, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverZombiesLoaded, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Simulated : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientZombiesSimulated, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverZombiesSimulated, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Culled : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientZombiesCulled, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverZombiesCulled, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Authorized : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientZombiesAuthorized, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverZombiesAuthorized, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Unauthorized : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientZombiesUnauthorized, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverZombiesUnauthorized, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Reusable : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientZombiesReusable, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverZombiesReusable, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding

        self:drawTextRight("Chunks", posX+text_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight("Relevant : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientRelevantChunks, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverRelevantChunks, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Stored : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientStoredChunks, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverStoredChunks, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Waiting : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverWaitingRequests, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Sent : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.clientSentRequests, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Requested1 : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.requested1, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Requested2 : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.requested2, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Pending1 : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.pending1, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Pending2 : ", posX+text_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.pending2, posX+text_width+field_width, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding

        self:drawTextRight("Version", posX+text_width, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight(statisticsData.clientRevision, posX+field_width*1.5, posY, tr, tg, tb, a, UIFont.NewMedium);
        self:drawTextRight(statisticsData.serverRevision, posX+text_width+field_width*2, posY, tr, tg, tb, a, UIFont.NewMedium);
        posY=posY+padding

        self:drawTextRight("Admin Power / Debug Options", posX+text_width+field_width*2, posY, hr, hg, hb, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, 1, lah, lr, lg, lb);
        self:drawTextRight("GodMode :", posX+text_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        self:drawTextRight(tostring(self.player:isGodMod()), posX+text_width+field_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("Invisible :", posX+text_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        self:drawTextRight(tostring(self.player:isInvisible()), posX+text_width+field_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("Invincible :", posX+text_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        self:drawTextRight(tostring(self.player:isInvincible()), posX+text_width+field_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("NoClip :", posX+text_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        self:drawTextRight(tostring(self.player:isNoClip()), posX+text_width+field_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("IsSeeEveryone :", posX+text_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        self:drawTextRight(tostring(self.player:isSeeEveryone()), posX+text_width+field_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("CanSeeEveryone :", posX+text_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        self:drawTextRight(tostring(self.player:isCanSeeAll()), posX+text_width+field_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("CanHearEveryone :", posX+text_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        self:drawTextRight(tostring(self.player:isCanHearAll()), posX+text_width+field_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("ZombiesDontAttack :", posX+text_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        self:drawTextRight(tostring(self.player:isZombiesDontAttack()), posX+text_width+field_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawTextRight("NetworkTeleport :", posX+text_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        self:drawTextRight(tostring(self.player:isNetworkTeleportEnabled()), posX+text_width+field_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        posY=posY+padding
        self:drawRect(startX, posY, line_lenght, highlight_height, la, lr, lg, lb);
        self:drawTextRight("OwnershipEachUpdate :", posX+text_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        self:drawTextRight(tostring(self.player:zombiesSwitchOwnershipEachUpdate()), posX+text_width+field_width*2, posY, tar, tag, tab, a, UIFont.NewMedium);
        posY=posY+padding

    end
end

function ISStatisticsUI:new(x, y, player)
    local o = {}
    local width = 520
    local height = 720
    o = ISCollapsableWindow:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.playerNum = player:getPlayerNum()
    if y == 0 then
        o.y = getPlayerScreenTop(o.playerNum)+(getPlayerScreenHeight(o.playerNum)-height)/2
        o:setY(o.y)
    end
    if x == 0 then
        o.x = getPlayerScreenLeft(o.playerNum)+(getPlayerScreenWidth(o.playerNum)-width)/2
        o:setX(o.x)
    end
    o.width = width
    o.height = height
    o.player = player
    o.moveWithMouse = true
    o.anchorLeft = true
    o.anchorRight = true
    o.anchorTop = true
    o.anchorBottom = true
    o.resizable = false
    player:setShowMPInfos(true)
    ISStatisticsUI.instance = o
    return o;
end
