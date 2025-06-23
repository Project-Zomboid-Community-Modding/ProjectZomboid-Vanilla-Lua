--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

if not isClient() then return end

ISAdminPowerUI = ISPanel:derive("ISAdminPowerUI");
ISAdminPowerUI.messages = {};

ISAdminPowerUI.cheatTooltips = {}

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISAdminPowerUI:initialise
--**
--************************************************************************--

function ISAdminPowerUI:initialise()
    ISPanel.initialise(self);
    local btnWid = 100

    self.ok = ISButton:new(UI_BORDER_SPACING+1, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_RadioSave"), self, ISAdminPowerUI.onClick);
    self.ok.internal = "SAVE";
    self.ok.anchorTop = false
    self.ok.anchorBottom = true
    self.ok:initialise();
    self.ok:instantiate();
    self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.ok);
    
    self.tickBox = ISTickBox:new(UI_BORDER_SPACING+1, FONT_HGT_MEDIUM+UI_BORDER_SPACING*2+1, 100, BUTTON_HGT, "Admin Powers", self, self.onTicked)
    self.tickBox.backgroundColor.a = 1
    self.tickBox.background = false
    self.tickBox.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBox.leftMargin = 2
    self.tickBox:setFont(UIFont.Small)
    self:addChild(self.tickBox);

    self.richText = ISRichTextLayout:new(self.width-(UI_BORDER_SPACING+1)*2)
    self.richText.marginLeft = 0
    self.richText.marginTop = 0
    self.richText.marginRight = 0
    self.richText.marginBottom = 0
    self.richText:setText(getText("IGUI_AdminPanel_ShowAdminTag"))
    self.richText:initialise()
    self.richText:paginate()

    self:addAdminPowerOptions()

end

function ISAdminPowerUI:addAdminPowerOptions()
    self.setFunction = {}
    if self.player:getRole():hasCapability(Capability.ToggleInvisibleHimself) then
        self:addOption(getText("IGUI_AdminPanel_Invisible"), self.player:isInvisible(), function(self, selected)
            self.player:setInvisible(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_Invisible")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.ToggleInvisibleHimself:name())
    end
    --if self.player:getRole():hasCapability(Capability.ToggleInvincibleHimself) then
    --    self:addOption(getText("IGUI_AdminPanel_Invincible"), self.player:isInvincible(), function(self, selected)
    --        self.player:setInvincible(selected);
    --    end);
    --    ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_Invincible")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.ToggleInvincibleHimself:name())
    --end
    if self.player:getRole():hasCapability(Capability.ToggleGodModHimself) then
        self:addOption(getText("IGUI_AdminPanel_GodMode"), self.player:isGodMod(), function(self, selected)
            self.player:setGodMod(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_GodMode")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.ToggleGodModHimself:name())
    end
    if self.player:getRole():hasCapability(Capability.ToggleNoclipHimself) then
        self:addOption(getText("IGUI_AdminPanel_NoClip"), self.player:isNoClip(), function(self, selected)
            self.player:setNoClip(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_NoClip")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.ToggleNoclipHimself:name())
    end
    if self.player:getRole():hasCapability(Capability.UseTimedActionInstantCheat) then
        self:addOption(getText("IGUI_AdminPanel_TimedActionInstant"), self.player:isTimedActionInstantCheat(), function(self, selected)
            self.player:setTimedActionInstantCheat(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_TimedActionInstant")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.UseTimedActionInstantCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.ToggleUnlimitedCarry) then
        self:addOption(getText("IGUI_AdminPanel_UnlimitedCarry"), self.player:isUnlimitedCarry(), function(self, selected)
            self.player:setUnlimitedCarry(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_UnlimitedCarry")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.ToggleUnlimitedCarry:name())
    end
    if self.player:getRole():hasCapability(Capability.ToggleUnlimitedEndurance) then
        self:addOption(getText("IGUI_AdminPanel_UnlimitedEndurance"), self.player:isUnlimitedEndurance(), function(self, selected)
            self.player:setUnlimitedEndurance(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_UnlimitedEndurance")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.ToggleUnlimitedEndurance:name())
    end
    if self.player:getRole():hasCapability(Capability.ToggleUnlimitedAmmo) then
        self:addOption(getText("IGUI_AdminPanel_UnlimitedAmmo"), self.player:isUnlimitedAmmo(), function(self, selected)
            self.player:setUnlimitedAmmo(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_UnlimitedAmmo")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.ToggleUnlimitedAmmo:name())
    end
    if self.player:getRole():hasCapability(Capability.ToggleKnowAllRecipes) then
        self:addOption(getText("IGUI_AdminPanel_KnowAllRecipes"), self.player:isKnowAllRecipes(), function(self, selected)
            self.player:setKnowAllRecipes(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_KnowAllRecipes")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.ToggleKnowAllRecipes:name())
    end
    if self.player:getRole():hasCapability(Capability.UseFastMoveCheat) then
        self:addOption(getText("IGUI_AdminPanel_FastMove"), ISFastTeleportMove.cheat, function(self, selected)
            ISFastTeleportMove.cheat = selected;
            self.player:setFastMoveCheat(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_FastMove")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.UseFastMoveCheat:name()) .. "\n" .. getText("IGUI_AdminPanel_Tooltip_FastMove")
    end
    if self.player:getRole():hasCapability(Capability.UseBuildCheat) then
        self:addOption(getText("IGUI_AdminPanel_BuildCheat"), ISBuildMenu.cheat, function(self, selected)
            ISBuildMenu.cheat = selected;
            self.player:setBuildCheat(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_BuildCheat")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.UseBuildCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.UseFarmingCheat) then
        self:addOption(getText("IGUI_AdminPanel_FarmingCheat"), ISFarmingMenu.cheat, function(self, selected)
            ISFarmingMenu.cheat = selected;
            self.player:setFarmingCheat(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_FarmingCheat")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.UseFarmingCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.UseFishingCheat) then
        self:addOption(getText("IGUI_AdminPanel_FishingCheat"), self.player:isFishingCheat(), function(self, selected)
            self.player:setFishingCheat(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_FishingCheat")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.UseFishingCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.UseHealthCheat) then
        self:addOption(getText("IGUI_AdminPanel_HealthCheat"), ISHealthPanel.cheat, function(self, selected)
            ISHealthPanel.cheat = selected;
            self.player:setHealthCheat(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_HealthCheat")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.UseHealthCheat:name())
    end
    -- disable mechanics cheat for non-debug
    if getDebug() and self.player:getRole():hasCapability(Capability.UseMechanicsCheat) then
        self:addOption(getText("IGUI_AdminPanel_MechanicsCheat"), ISVehicleMechanics.cheat, function(self, selected)
            ISVehicleMechanics.cheat = selected;
            self.player:setMechanicsCheat(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_MechanicsCheat")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.UseMechanicsCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.UseMovablesCheat) then
        self:addOption(getText("IGUI_AdminPanel_MoveableCheat"), ISMoveableDefinitions.cheat, function(self, selected)
            ISMoveableDefinitions.cheat = selected;
            self.player:setMovablesCheat(selected);
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_MoveableCheat")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.UseMovablesCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.CanSeeAll) then
        self:addOption(getText("IGUI_AdminPanel_CanSeeAll"), self.player:canSeeAll(), function(self, selected)
            self.player:setCanSeeAll(selected)
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_CanSeeAll")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.CanSeeAll:name())
    end
    if self.player:getRole():hasCapability(Capability.CanHearAll) then
        self:addOption(getText("IGUI_AdminPanel_CanHearAll"), self.player:canHearAll(), function(self, selected)
            self.player:setCanHearAll(selected)
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_CanHearAll")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.CanHearAll:name())
    end
    if self.player:getRole():hasCapability(Capability.ManipulateZombie) then
        self:addOption(getText("IGUI_AdminPanel_ZombiesDontAttack"), self.player:isZombiesDontAttack(), function(self, selected)
            self.player:setZombiesDontAttack(selected)
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_ZombiesDontAttack")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.ManipulateZombie:name())
    end
    if self.player:getRole():hasCapability(Capability.GetStatistic) then
        self:addOption(getText("IGUI_AdminPanel_ShowMPInfos"), self.player:isShowMPInfos(), function(self, selected)
            self.player:setShowMPInfos(selected)
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_ShowMPInfos")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.GetStatistic:name())
    end
    if self.player:getRole():hasCapability(Capability.UseBrushToolManager) then
        self:addOption(getText("IGUI_AdminPanel_BrushTool"), BrushToolManager.cheat, function(self, selected)
            BrushToolManager.cheat = selected;
            self.player:setCanUseBrushTool(selected)
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_BrushTool")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.UseBrushToolManager:name())
    end
    if self.player:getRole():hasCapability(Capability.UseLootTool) then
        self:addOption(getText("IGUI_AdminPanel_LootTool"), ISLootZed.cheat, function(self, selected)
            ISLootZed.cheat = selected;
            ISLootLog.cheat = selected
            self.player:setCanUseLootTool(selected)
        end);
        ISAdminPowerUI.cheatTooltips[getText("IGUI_AdminPanel_LootTool")] = getText("IGUI_AdminPanel_Tooltip_Capability", Capability.UseLootTool:name())
    end

    --for some reason, sorting A-Z makes the options appear Z-A, so i reversed the sorting.
    --sort should be done for every table inside the tickBox
    --table.sort(self.tickBox.options, function(a, b) return string.sort(b, a) end)

    self.tickBox:setWidthToFit()

    self:setHeight(self.tickBox:getBottom() + self.richText:getHeight() + self.ok:getHeight() + UI_BORDER_SPACING*3+1)
end

function ISAdminPowerUI:addOption(text, selected, setFunction)
    local n = self.tickBox:addOption(text)
    self.tickBox:setSelected(n, selected)
    self.setFunction[n] = setFunction
end

function ISAdminPowerUI:onTicked(index, selected)
end

function ISAdminPowerUI:render()
    if self.tickBox:isMouseOver() and ISAdminPowerUI.cheatTooltips[self.tickBox.optionsIndex[self.tickBox.mouseOverOption]] ~= nil then
        local text = ISAdminPowerUI.cheatTooltips[self.tickBox.optionsIndex[self.tickBox.mouseOverOption]]
        if not self.tickBox.tooltipUI then
            self.tickBox.tooltipUI = ISToolTip:new()
            self.tickBox.tooltipUI:setOwner(self.tickBox)
            self.tickBox.tooltipUI:setVisible(false)
            self.tickBox.tooltipUI:setAlwaysOnTop(true)
        end
        if not self.tickBox.tooltipUI:getIsVisible() then
            if string.contains(text, "\n") then
                self.tickBox.tooltipUI.maxLineWidth = 1000 -- don't wrap the lines
            else
                self.tickBox.tooltipUI.maxLineWidth = 300
            end
            self.tickBox.tooltipUI:addToUIManager()
            self.tickBox.tooltipUI:setVisible(true)
        end
        self.tickBox.tooltipUI.description = text
        self.tickBox.tooltipUI:setX(self.tickBox:getMouseX() + 23)
        self.tickBox.tooltipUI:setY(self.tickBox:getMouseY() + 23)
    else
        if self.tickBox.tooltipUI and self.tickBox.tooltipUI:getIsVisible() then
            self.tickBox.tooltipUI:setVisible(false)
            self.tickBox.tooltipUI:removeFromUIManager()
        end
    end
end

function ISAdminPowerUI:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText(getText("IGUI_AdminPanel_AdminPower"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AdminPanel_AdminPower")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);

    self.richText:render(UI_BORDER_SPACING+1, self.ok.y - UI_BORDER_SPACING - self.richText:getHeight(), self)
end

function ISAdminPowerUI:onClick(button)
    if button.internal == "SAVE" then
        if not self.player:isDead() then
            for i=1,#self.tickBox.options do
                self.setFunction[i](self, self.tickBox:isSelected(i))
            end
            sendPlayerExtraInfo(self.player)
        end
    
        self:setVisible(false);
        self:removeFromUIManager();
    end
end

ISAdminPowerUI.onGameStart = function()
    ISBuildMenu.cheat = getPlayer():isBuildCheat();
    ISFarmingMenu.cheat = getPlayer():isFarmingCheat();
    ISHealthPanel.cheat = getPlayer():isHealthCheat();
    ISMoveableDefinitions.cheat = getPlayer():isMovablesCheat();
    BrushToolManager.cheat = getPlayer():isCanUseBrushTool();
    ISFastTeleportMove.cheat = getPlayer():isFastMoveCheat();
    -- disable mechanics cheat for non-debug
    if getDebug() then
        ISVehicleMechanics.cheat = getPlayer():isMechanicsCheat();
    end
end

--************************************************************************--
--** ISAdminPowerUI:new
--**
--************************************************************************--
function ISAdminPowerUI:new(x, y, width, height, player)
    local o = {}
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.height = height;
    o.player = player;
    o.moveWithMouse = true;
    ISAdminPowerUI.instance = o;
    return o;
end

Events.OnGameStart.Add(ISAdminPowerUI.onGameStart)
Events.RefreshCheats.Add(ISAdminPowerUI.onGameStart)
