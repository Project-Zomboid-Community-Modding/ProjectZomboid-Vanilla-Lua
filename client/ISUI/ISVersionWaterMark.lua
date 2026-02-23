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
    self:drawTextRight("x: ".. math.floor(self.chr:getX()) .. " , y: " .. math.floor(self.chr:getY()) .. ", z: " .. math.floor(self.chr:getZ()), self.revButton:getWidth(), y, 1, 1, 1, 1, UIFont.NewSmall);
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

    if ISBuildMenu.cheat then
        self:drawTextRight(getText("IGUI_CheatPanel_BuildCheat"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if self.chr:isInvisible() then
        self:drawTextRight(getText("IGUI_CheatPanel_Invisible"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if self.chr:isGodMod() then
        self:drawTextRight(getText("IGUI_CheatPanel_GodMod"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if self.chr:isNoClip() then
        self:drawTextRight(getText("IGUI_CheatPanel_NoClip"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if ISFastTeleportMove.cheat then
        self:drawTextRight(getText("IGUI_CheatPanel_FastMove"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if self.chr:isTimedActionInstantCheat() then
        self:drawTextRight(getText("IGUI_CheatPanel_TimedActionInstant"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if self.chr:isUnlimitedCarry() then
        self:drawTextRight(getText("IGUI_CheatPanel_UnlimitedCarry"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if self.chr:isUnlimitedEndurance() then
        self:drawTextRight(getText("IGUI_CheatPanel_UnlimitedEndurance"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if self.chr:isUnlimitedAmmo() then
        self:drawTextRight(getText("IGUI_CheatPanel_UnlimitedAmmo"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if self.chr:isKnowAllRecipes() then
        self:drawTextRight(getText("IGUI_CheatPanel_KnowAllRecipes"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if ISFarmingMenu.cheat then
        self:drawTextRight(getText("IGUI_CheatPanel_FarmingCheat"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if ISHealthPanel.cheat then
        self:drawTextRight(getText("IGUI_CheatPanel_HealthCheat"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if ISVehicleMechanics.cheat then
        self:drawTextRight(getText("IGUI_CheatPanel_MechanicsCheat"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if ISMoveableDefinitions.cheat then
        self:drawTextRight(getText("IGUI_CheatPanel_MoveableCheat"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
    end
    if AnimalContextMenu.cheat then
        self:drawTextRight(getText("IGUI_CheatPanel_AnimalCheat"), self.revButton:getWidth(), y, 1, 1, 1, alpha, UIFont.NewSmall);
        y = y - FONT_HGT_SMALL - 3;
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
