require "ISUI/ISPanelJoypad"

local FONT = UIFont.NewSmall
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local TEXT_OFFSET = (BUTTON_HGT - FONT_HGT_SMALL)/2

local SCROLLBAR = 13

ISStatisticsUI = ISCollapsableWindow:derive("ISStatisticsUI");
ISStatisticsPanel = ISPanel:derive("ISStatisticsPanel");

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

    --PERFORMANCE
    if ISStatisticsUI.instance.showPerformance then

        local performanceLocal = getPerformanceLocal()
        local performanceRemote = getPerformanceRemote()

        entries = 8 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("Performance", lC, "Client", cC, "Server", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Free (MB) :", lC, tostring(performanceLocal["memory-free"]), cC, tostring(performanceRemote["memory-free"]), sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Used (MB) :", lC, tostring(performanceLocal["memory-used"]), cC, tostring(performanceRemote["memory-used"]), sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Total (MB) :", lC, tostring(performanceLocal["memory-total"]), cC, tostring(performanceRemote["memory-total"]), sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Max (MB) :", lC, tostring(performanceLocal["memory-max"]), cC, tostring(performanceRemote["memory-max"]), sC, y, dR, dG, dB, dA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("FPS :", lC, tostring(performanceLocal["fps"]), cC, tostring(performanceRemote["fps"]), sC, y, dR, dG, dB, dA, true)
        y = y + UI_BORDER_SPACING
    end

    --NETWORK
    if ISStatisticsUI.instance.showNetwork then

        local networkLocal = getNetworkLocal()
        local networkRemote = getNetworkRemote()

        entries = 11 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("Network", lC, "Client", cC, "Server", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("RX (P) :", lC, tostring(networkLocal["received-packets"]), cC, tostring(networkRemote["received-packets"]), sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("TX (P) :", lC, tostring(networkLocal["sent-packets"]), cC, tostring(networkRemote["sent-packets"]), sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("RX (KB) :", lC, tostring(networkLocal["received-bytes"]), cC, tostring(networkRemote["received-bytes"]), sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("TX (KB) :", lC, tostring(networkLocal["sent-bytes"]), cC, tostring(networkRemote["sent-bytes"]), sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("RAKNET RX (KB) :", lC, tostring(networkLocal["last-actual-bytes-received"]), cC, tostring(networkRemote["last-actual-bytes-received"]), sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("RAKNET TX (KB) :", lC, tostring(networkLocal["last-actual-bytes-sent"]), cC, tostring(networkRemote["last-actual-bytes-sent"]), sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("RAKNET Resent (KB) :", lC, tostring(networkLocal["last-user-message-bytes-resent"]), cC, tostring(networkRemote["last-user-message-bytes-resent"]), sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("RAKNET Loss (%) :", lC, tostring(networkLocal["packet-loss-last-second"]), cC, tostring(networkRemote["packet-loss-last-second"]), sC, y, dR, dG, dB, dA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("VOIP RX (KB) :", lC, tostring(networkLocal["voip-received"]), cC, tostring(networkRemote["voip-received"]), sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("VOIP TX (KB) :", lC, tostring(networkLocal["voip-sent"]), cC, tostring(networkRemote["voip-sent"]), sC, y, dR, dG, dB, dA, false)
        y = y + UI_BORDER_SPACING
    end

    --CHARACTERS
    if ISStatisticsUI.instance.showCharacters then

        local gameLocal = getGameLocal()
        local gameRemote = getGameRemote()

        entries = 9 --include title row
        self:drawRect(lC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --first vertical line
        self:drawRect(cC + UI_BORDER_SPACING, y-TEXT_OFFSET, 1, BUTTON_HGT*entries, lA, lR, lG, lB); --second vertical line
        y = self:drawRow("Characters", lC, "Client", cC, "Server", sC, y, hR, hG, hB, hA, false)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Players Connected :", lC, tostring(gameLocal["players"]), cC, tostring(gameRemote["players"]), sC, y, dR, dG, dB, dA, true)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Animals Objects :", lC, tostring(gameLocal["animals-objects"]), cC, tostring(gameRemote["animals-objects"]), sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Animals Instances :", lC, tostring(gameLocal["animals-instances"]), cC, tostring(gameRemote["animals-instances"]), sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Animals Owned :", lC, tostring(gameLocal["animals-owned"]), cC, tostring(gameRemote["animals-owned"]), sC, y, dR, dG, dB, dA, true)
        self:drawRect(0, y-TEXT_OFFSET, width, 1, lA, lR, lG, lB); --horizontal line between header
        y = self:drawRow("Zombies Total :", lC, tostring(gameLocal["zombies-total"]), cC, tostring(gameRemote["zombies-total"]), sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Zombies Loaded :", lC, tostring(gameLocal["zombies-loaded"]), cC, tostring(gameRemote["zombies-loaded"]), sC, y, dR, dG, dB, dA, false)
        y = self:drawRow("Zombies Simulated :", lC, tostring(gameLocal["zombies-simulated"]), cC, tostring(gameRemote["zombies-simulated"]), sC, y, dR, dG, dB, dA, true)
        y = self:drawRow("Zombies Culled :", lC, tostring(gameLocal["zombies-culled"]), cC, tostring(gameRemote["zombies-culled"]), sC, y, dR, dG, dB, dA, false)
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

function ISStatisticsUI:onTickedLeft(index, selected)
    if index == 1 then
        self.showPerformance = selected
    end
end

function ISStatisticsUI:onTickedCenter(index, selected)
    if index == 1 then
            self.showNetwork = selected
        end
end

function ISStatisticsUI:onTickedRight(index, selected)
    if index == 1 then
        self.showCharacters = selected
    end
end

function ISStatisticsUI:createChildren()
    ISCollapsableWindow.createChildren(self)

    local y = self:titleBarHeight() + UI_BORDER_SPACING
    local tickBoxWidth = BUTTON_HGT + UI_BORDER_SPACING + math.max(
        getTextManager():MeasureStringX(UIFont.Medium, "Performance"),
        getTextManager():MeasureStringX(UIFont.Medium, "Network"),
        getTextManager():MeasureStringX(UIFont.Medium, "Characters")
    )
    local tickBoxHeight = getTextManager():getFontHeight(UIFont.Small)
    local width = self.width - SCROLLBAR;

    self.tickBoxLeft = ISTickBox:new(UI_BORDER_SPACING, y, tickBoxWidth, tickBoxHeight, "Settings left", self, self.onTickedLeft)
    self.tickBoxLeft.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxLeft:setFont(UIFont.NewSmall)
    self:addChild(self.tickBoxLeft)

    self.tickBoxCenter = ISTickBox:new(width/2 - tickBoxWidth/2 + UI_BORDER_SPACING, y, tickBoxWidth, tickBoxHeight, "Settings center", self, self.onTickedCenter)
    self.tickBoxCenter.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxCenter:setFont(UIFont.NewSmall)
    self:addChild(self.tickBoxCenter)

    self.tickBoxRight = ISTickBox:new(width - tickBoxWidth - UI_BORDER_SPACING, y, tickBoxWidth, tickBoxHeight, "Settings right", self, self.onTickedRight)
    self.tickBoxRight.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxRight:setFont(UIFont.NewSmall)
    self:addChild(self.tickBoxRight)

    local n

    n = self.tickBoxLeft:addOption("Performance")
    self.tickBoxLeft:setSelected(n, self.showPerformance)

    n = self.tickBoxCenter:addOption("Network")
    self.tickBoxCenter:setSelected(n, self.showNetwork)

    n = self.tickBoxRight:addOption("Characters")
    self.tickBoxRight:setSelected(n, self.showCharacters)

    y = y + UI_BORDER_SPACING

    self.panel = ISStatisticsPanel:new(0, self:titleBarHeight() + y, self.width+UI_BORDER_SPACING, self.height-self:titleBarHeight()-self:resizeWidgetHeight()-y)
    self.panel.anchorBottom = true
    self.panel.anchorRight = true
    self.panel.playerNum = self.playerNum
    self.panel.player = self.player
    self.panel:initialise()
    self.panel:instantiate()
    self.panel.backgroundColor.a = 0
    self.panel:setScrollChildren(true)
    self:addChild(self.panel)

    self.panel:addScrollBars()
end

function ISStatisticsUI:close()
    self:setVisible(false);
    self:removeFromUIManager();
    ISStatisticsUI.instance = nil
    toggleStatisticsTransmission()
end

function ISStatisticsUI:prerender()
    ISCollapsableWindow.prerender(self);
    local tickBoxWidth = BUTTON_HGT + UI_BORDER_SPACING + math.max(
        getTextManager():MeasureStringX(UIFont.Medium, "Performance"),
        getTextManager():MeasureStringX(UIFont.Medium, "Network"),
        getTextManager():MeasureStringX(UIFont.Medium, "Characters")
    )
    local width = self.width - SCROLLBAR;
    self.tickBoxRight:setX(width - tickBoxWidth - UI_BORDER_SPACING)
    self.tickBoxCenter:setX(width/2 - tickBoxWidth/2 + UI_BORDER_SPACING)

end

function ISStatisticsUI:initialise()
    ISCollapsableWindow.initialise(self)
    self.title = getText("IGUI_AdminPanel_HeaderShowStatistics")
end

function ISStatisticsUI:render()
    ISCollapsableWindow.render(self);
end

function ISStatisticsUI:new(x, y, player)
    local width = 300+(getCore():getOptionFontSizeReal()*100)
    local height = 730
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

    o.showPerformance = true
    o.showNetwork = true
    o.showCharacters = true

    ISStatisticsUI.instance = o
    toggleStatisticsTransmission()
    return o;
end
