require "ISUI/ISPanelJoypad"

local FONT = UIFont.NewSmall
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local TEXT_OFFSET = (BUTTON_HGT - FONT_HGT_SMALL)/2

local SCROLLBAR = 13

ISStatisticsUI = ISCollapsableWindow:derive("ISStatisticsUI");
ISStatisticsPanel = ISPanel:derive("ISStatisticsPanel");

local function getWorldAge()
    local h = math.floor(getGameTime():getWorldAgeHours())
    local days = math.floor(h / 24)
    local hours = h - days * 24
    return days .. "Days " .. hours .. "H"
end

function ISStatisticsPanel:prerender()
    self:setStencilRect(0, 0, self:getWidth(), self:getHeight())
    ISPanel.prerender(self)
end

function ISStatisticsPanel:onMouseWheel(del)
    if self:getScrollHeight() > 0 then
        self:setYScroll(self:getYScroll() - (del * 40))
        return true
    end
    return false
end

function ISStatisticsPanel:render()
    ISPanel.render(self)
    self:renderStatistics()
    self:clearStencilRect()
end

function ISStatisticsPanel:renderStatistics()
    local statisticsData = getMPStatistics()

    --base measurements
    local width = self.width - SCROLLBAR;
    local y = TEXT_OFFSET;
    local entries = 0;

    --colours
    local hR, hG, hB, hA = 1, 0.75, 0.5, 1;
    local dR, dG, dB, dA= 1, 1, 0.8, 1;
    local lR, lG, lB, lA = 0.9, 0.9, 0.9, 0.3;
    local bA = 0.08

    --column offsets
    local lC = width/2 - UI_BORDER_SPACING;
    local cC = width - (width/4) - UI_BORDER_SPACING;
    local sC = width - UI_BORDER_SPACING;

    --CPU
    if ISStatisticsUI.instance.showCPU then
        entries = 3 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("CPU", lC, "Client", cC, "Server", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Cores :", lC, statisticsData.clientCPUCores, cC, statisticsData.serverCPUCores, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Load (%) :", lC, statisticsData.clientCPULoad, cC, statisticsData.serverCPULoad, sC, y, dR, dG, dB, dA, false)
        y = y + UI_BORDER_SPACING
    end

    --MEMORY
    if ISStatisticsUI.instance.showMemory then
        entries = 5 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("Memory", lC, "Client", cC, "Server", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Free (MB) :", lC, statisticsData.clientMemFree, cC, statisticsData.serverMemFree, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Used (MB) :", lC, statisticsData.clientMemUsed, cC, statisticsData.serverMemUsed, sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Total (MB) :", lC, statisticsData.clientMemTotal, cC, statisticsData.serverMemTotal, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Max (MB) :", lC, statisticsData.clientMemMax, cC, statisticsData.serverMemMax, sC, y, dR, dG, dB, dA, false)
        y = y + UI_BORDER_SPACING
    end

    --FPS
    if ISStatisticsUI.instance.showFPS then
        entries = 3 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("FPS", lC, "Client", cC, "Server", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Main :", lC, statisticsData.clientFPS, cC, statisticsData.serverFPS, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Networking :", lC, "", cC, statisticsData.serverNetworkingFPS, sC, y, dR, dG, dB, dA, false)
        y = y + UI_BORDER_SPACING
    end

    --NETWORK
    if ISStatisticsUI.instance.showNetwork then
        entries = 5 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("Network", lC, "Client", cC, "Server", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("RX (KB) :", lC, statisticsData.clientRX, cC, statisticsData.serverRX, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("TX (KB) :", lC, statisticsData.clientTX, cC, statisticsData.serverTX, sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Resent (KB) :", lC, statisticsData.clientResent, cC, statisticsData.serverResent, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Loss (%) :", lC, statisticsData.clientLoss, cC, statisticsData.serverLoss, sC, y, dR, dG, dB, dA, false)
        y = y + UI_BORDER_SPACING
    end

    --VOIP
    if ISStatisticsUI.instance.showVOIP then
        entries = 4 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("VOIP", lC, "Client", cC, "Server", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("RX (KB) :", lC, statisticsData.clientVOIPRX, cC, statisticsData.serverVOIPRX, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("TX (KB) :", lC, statisticsData.clientVOIPTX, cC, statisticsData.serverVOIPTX, sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Source :", lC, statisticsData.clientVOIPSource, cC, statisticsData.clientVOIPFreq, sC, y, dR, dG, dB, dA, true)
        y = y + UI_BORDER_SPACING
    end

    --PING
    if ISStatisticsUI.instance.showPing then
        entries = 4 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("Ping", lC, "", cC, "", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Last :", lC, "", cC, statisticsData.clientLastPing, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Average :", lC, "", cC, statisticsData.clientAvgPing, sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Minimum :", lC, "", cC, statisticsData.clientMinPing, sC, y, dR, dG, dB, dA, true)
        y = y + UI_BORDER_SPACING
    end

    --PACKET PING
    if ISStatisticsUI.instance.showPing then
        entries = 6 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --
        y = self:drawRow("Packet Ping", lC, "", cC, "", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Last :", lC, "", cC, statisticsData.serverPingLast, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Average :", lC, "", cC, statisticsData.serverPingAvg, sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Loss :", lC, "", cC, statisticsData.serverPingLoss, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Maximum :", lC, "", cC, statisticsData.serverPingMax, sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Minimum :", lC, "", cC, statisticsData.serverPingMin, sC, y, dR, dG, dB, dA, true)
        y = y + UI_BORDER_SPACING
    end

    --TIME
    if ISStatisticsUI.instance.showTime then
        entries = 4 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --
        y = self:drawRow("Time", lC, "", cC, "", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Client :", lC, "", cC, statisticsData.clientTime, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Server :", lC, "", cC, statisticsData.serverTime, sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("World :", lC, "", cC, getWorldAge(), sC, y, dR, dG, dB, dA, true)
        y = y + UI_BORDER_SPACING
    end

    --PLAYERS
    if ISStatisticsUI.instance.showPlayers then
        entries = 2 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("Players", lC, "Client", cC, "Server", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Connected :", lC, statisticsData.clientPlayers, cC, statisticsData.serverPlayers, sC, y, dR, dG, dB, dA, true)
        y = y + UI_BORDER_SPACING
    end

    --ANIMALS
    if ISStatisticsUI.instance.showAnimals then
        entries = 3 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("Animals", lC, "Client", cC, "Server", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Objects :", lC, statisticsData.clientAnimalObjects, cC, statisticsData.serverAnimalObjects, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Instances :", lC, statisticsData.clientAnimalInstances, cC, statisticsData.serverAnimalInstances, sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Owned :", lC, statisticsData.clientAnimalOwned, cC, statisticsData.serverAnimalOwned, sC, y, dR, dG, dB, dA, true)
        y = y + UI_BORDER_SPACING
    end

    --ZOMBIES
    if ISStatisticsUI.instance.showZombies then
        entries = 8 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("Zombies", lC, "Client", cC, "Server", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Total :", lC, statisticsData.clientZombiesTotal, cC, statisticsData.serverZombiesTotal, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Loaded :", lC, statisticsData.clientZombiesLoaded, cC, statisticsData.serverZombiesLoaded, sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Simulated :", lC, statisticsData.clientZombiesSimulated, cC, statisticsData.serverZombiesSimulated, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Culled :", lC, statisticsData.clientZombiesCulled, cC, statisticsData.serverZombiesCulled, sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Authorized :", lC, statisticsData.clientZombiesAuthorized, cC, statisticsData.serverZombiesAuthorized, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Unauthorized :", lC, statisticsData.clientZombiesUnauthorized, cC, statisticsData.serverZombiesUnauthorized, sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Reusable :", lC, statisticsData.clientZombiesReusable, cC, statisticsData.serverZombiesReusable, sC, y, dR, dG, dB, dA, true)
        y = y + UI_BORDER_SPACING
    end

    --CHUNKS
    if ISStatisticsUI.instance.showChunks then
        entries = 9 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("Chunks", lC, "Client", cC, "Server", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Relevant :", lC, statisticsData.clientRelevantChunks, cC, statisticsData.serverRelevantChunks, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Stored :", lC, statisticsData.clientStoredChunks, cC, statisticsData.serverStoredChunks, sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Waiting :", lC, "", cC, statisticsData.serverWaitingRequests, sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Sent :", lC, statisticsData.clientSentRequests, cC, "", sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Requested1 :", lC, statisticsData.requested1, cC, "", sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Requested2 :", lC, statisticsData.requested2, cC, "", sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Pending1 :", lC, statisticsData.pending1, cC, "", sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Pending2 :", lC, statisticsData.pending2, cC, "", sC, y, dR, dG, dB, dA, false)
        y = y + UI_BORDER_SPACING
    end

    --VERSION
    if ISStatisticsUI.instance.showVersion then
        entries = 1 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("Version", lC, statisticsData.clientRevision, cC, statisticsData.serverRevision, sC, y, hR, hG, hB, hA, false)
        y = y + UI_BORDER_SPACING
    end

    self:setScrollHeight(y)
end

function ISStatisticsPanel:drawRow(l, lC, c, cC, s, sC, y, r, g, b, a, background)
    if background then
        self:drawRect(0, y-TEXT_OFFSET, self.width-SCROLLBAR, BUTTON_HGT, 0.08, 0.9, 0.9, 0.9);
    end
    self:drawTextRight(l, lC, y, r, g, b, a, FONT);
    self:drawTextRight(c, cC, y, r, g, b, a, FONT);
    self:drawTextRight(s, sC, y, r, g, b, a, FONT);
    y = y + BUTTON_HGT;
    return y
end

function ISStatisticsPanel:new(x, y, width, height)
    local o = ISPanel.new(self, x, y, width, height)
    return o
end

-----

function ISStatisticsUI:onTickedLeft(index, selected)
    if index == 1 then
        self.showCPU = selected
    end
    if index == 2 then
        self.showMemory = selected
    end
    if index == 3 then
        self.showFPS = selected
    end
    if index == 4 then
        self.showNetwork = selected
    end
end

function ISStatisticsUI:onTickedCenter(index, selected)
    if index == 1 then
        self.showVOIP = selected
    end
    if index == 2 then
        self.showPing = selected
    end
    if index == 3 then
        self.showTime = selected
    end
    if index == 4 then
        self.showVersion = selected
    end
end

function ISStatisticsUI:onTickedRight(index, selected)
    if index == 1 then
        self.showPlayers = selected
    end
    if index == 2 then
        self.showAnimals = selected
    end
    if index == 3 then
        self.showZombies = selected
    end
    if index == 4 then
        self.showChunks = selected
    end
end

function ISStatisticsUI:createChildren()
    ISCollapsableWindow.createChildren(self)

    local y = self:titleBarHeight() + UI_BORDER_SPACING
    local tickBoxWidth = 70
    local tickBoxHeight = getTextManager():getFontHeight(UIFont.Small)
    local width = self.width - SCROLLBAR;

    self.tickBoxLeft = ISTickBox:new(UI_BORDER_SPACING + 10, y, tickBoxWidth, tickBoxHeight, "Settings left", self, self.onTickedLeft)
    self.tickBoxLeft.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxLeft:setFont(UIFont.NewSmall)
    self:addChild(self.tickBoxLeft)

    self.tickBoxCenter = ISTickBox:new(width/2 - tickBoxWidth/2 + 10, y, tickBoxWidth, tickBoxHeight, "Settings center", self, self.onTickedCenter)
    self.tickBoxCenter.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxCenter:setFont(UIFont.NewSmall)
    self:addChild(self.tickBoxCenter)

    self.tickBoxRight = ISTickBox:new(width - tickBoxWidth - 10, y, tickBoxWidth, tickBoxHeight, "Settings right", self, self.onTickedRight)
    self.tickBoxRight.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxRight:setFont(UIFont.NewSmall)
    self:addChild(self.tickBoxRight)

    local n

    n = self.tickBoxLeft:addOption("CPU")
    self.tickBoxLeft:setSelected(n, self.showCPU)

    n = self.tickBoxLeft:addOption("Memory")
    self.tickBoxLeft:setSelected(n, self.showMemory)

    n = self.tickBoxLeft:addOption("FPS")
    self.tickBoxLeft:setSelected(n, self.showFPS)

    n = self.tickBoxLeft:addOption("Network")
    self.tickBoxLeft:setSelected(n, self.showNetwork)

    n = self.tickBoxCenter:addOption("VOIP")
    self.tickBoxCenter:setSelected(n, self.showVOIP)

    n = self.tickBoxCenter:addOption("Ping")
    self.tickBoxCenter:setSelected(n, self.showPing)

    n = self.tickBoxCenter:addOption("Time")
    self.tickBoxCenter:setSelected(n, self.showTime)

    n = self.tickBoxCenter:addOption("Version")
    self.tickBoxCenter:setSelected(n, self.showVersion)

    n = self.tickBoxRight:addOption("Players")
    self.tickBoxRight:setSelected(n, self.showPlayers)

    n = self.tickBoxRight:addOption("Animals")
    self.tickBoxRight:setSelected(n, self.showAnimals)

    n = self.tickBoxRight:addOption("Zombies")
    self.tickBoxRight:setSelected(n, self.showZombies)

    n = self.tickBoxRight:addOption("Chhunks")
    self.tickBoxRight:setSelected(n, self.showChunks)

    y = y + tickBoxHeight * 4 + UI_BORDER_SPACING * 2

    self.panel = ISStatisticsPanel:new(0, self:titleBarHeight() + y, self.width, self.height-self:titleBarHeight()-self:resizeWidgetHeight()-y)
    self.panel.anchorBottom = true
    self.panel.anchorRight = true
    self.panel.playerNum = self.playerNum
    self.panel.player = self.player
    self.panel:initialise()
    self.panel:instantiate()
    --    self.panel:noBackground()
    self.panel.backgroundColor.a = 0
    self.panel:setScrollChildren(true)
    self:addChild(self.panel)

    self.panel:addScrollBars()
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

function ISStatisticsUI:render()
    ISCollapsableWindow.render(self);
end

function ISStatisticsUI:new(x, y, player)
    local width = 280
    local height = 980
    local o = ISCollapsableWindow.new(self, x, y, width, height)
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
    o.resizable = true

    o.showCPU = true
    o.showMemory = true
    o.showFPS = true
    o.showNetwork = true
    o.showVOIP = false
    o.showPing = false
    o.showTime = false
    o.showVersion = false
    o.showPlayers = true
    o.showAnimals = true
    o.showZombies = true
    o.showChunks = false

    player:setShowMPInfos(true)
    ISStatisticsUI.instance = o
    return o;
end
