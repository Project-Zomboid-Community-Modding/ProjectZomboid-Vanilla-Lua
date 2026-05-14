ISVersionWaterMark = {};

WaterMarkUI = ISPanel:derive("WaterMarkUI");
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)

ISVersionWaterMark.doMsg = function()
    local panel = WaterMarkUI:new(0, 0, 10, FONT_HGT_SMALL + 5);
    panel:initialise();
    panel:addToUIManager();
    panel:setVisible(true);
end

function WaterMarkUI:render()
    ISPanel.render(self);

    self:setWidth(self.revButton:getWidth());
    self:setX(getCore():getScreenWidth() - 10 - self.width);
    self:setY(getCore():getScreenHeight() - 10 - self.revButton:getHeight());

    local y = -FONT_HGT_SMALL - 3;
    local alpha = 0.3;
    self:drawTextRight("x: ".. math.floor(self.chr:getX()) .. " , y: " .. math.floor(self.chr:getY()) .. ", z: " .. math.floor(self.chr:getZ()) .. " ; " .. getPlayerScreenWidth(self.chr:getIndex()) .. "x" .. getPlayerScreenHeight(self.chr:getIndex()) .. "@" .. getPerformance():getFramerate(), self.revButton:getWidth(), y, 1, 1, 1, 1, UIFont.NewSmall);
    y = y - FONT_HGT_SMALL - 3;
    if isClient() then
        local statusData = getMPStatus()
        if tonumber(getMaxPlayers()) > 32 then
            self:drawTextRight(getText("UI_MaxPlayers_Notification"), self.revButton:getWidth(), y, 1, 1, 1, 1, UIFont.NewSmall);
            y = y - FONT_HGT_SMALL - 3;
        end

        if isShowServerInfo() then
            self:drawTextRight(getText("UI_ServerTime", statusData.serverTime, statusData.lastPing), self.revButton:getWidth(), y, 1, 1, 1, 1, UIFont.NewSmall);
            y = y - FONT_HGT_SMALL - 3;
        end

        if isShowConnectionInfo() then
            self:drawTextRight("\"" .. getServerName() .. "\" (" .. getServerIP() .. ":" .. getServerPort() .. ")", self.revButton:getWidth(), y, 1, 1, 1, 1, UIFont.NewSmall);
            y = y - FONT_HGT_SMALL - 3;
        end
    end

    local cheats = getCheatTypes()
    for i=0,cheats:size()-1 do
        local cheat = cheats:get(i)
        if self.chr:isCheatSet(cheat) then
            self:drawTextRight(getText("IGUI_CheatPanel_"..cheat:getTooltip()), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
            y = y - FONT_HGT_SMALL - 3;
        end
    end
end

function WaterMarkUI:initialise()
    ISPanel.initialise(self);
end

function WaterMarkUI:createChildren()
    self.revButton = ISButton:new(1, 1, 100, FONT_HGT_SMALL + 3 * 2, self.version, self, self.copyRev);
    self.revButton:initialise();
    self.revButton.borderColor.a = 0.0;
    self.revButton.backgroundColor.a = 0;
    self.revButton.backgroundColorMouseOver.a = 0;
    self:addChild(self.revButton);
end

function WaterMarkUI:copyRev()
    Clipboard.setClipboard(getCore():getGitSha())
end

function WaterMarkUI:new(x, y, width, height)
    local o = ISPanel.new(self, x, y, width, height);
    o.refreshNeeded = true
    o.borderColor = {r=0, g=0, b=0, a=0};
    o.backgroundColor = {r=0, g=0, b=0, a=0};
    o.chr = getPlayer();
    o.version = getCore():getVersion() .. " " .. "pzBullet(" .. getCore():getBulletVersion() .. ")";
    return o;
end

Events.OnGameStart.Add(ISVersionWaterMark.doMsg);
