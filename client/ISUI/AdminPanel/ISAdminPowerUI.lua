ISAdminPowerUI = ISPanel:derive("ISAdminPowerUI");
ISAdminPowerUI.messages = {};

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local BUTTON_WIDTH = 100

function ISAdminPowerUI:initialise()
    ISPanel.initialise(self)

    self.tickBoxLeft = ISTickBox:new(UI_BORDER_SPACING, FONT_HGT_MEDIUM+UI_BORDER_SPACING * 2, BUTTON_WIDTH, BUTTON_HGT, "Admin Powers", self, self.onTicked)
    self.tickBoxLeft.backgroundColor.a = 1
    self.tickBoxLeft.background = false
    self.tickBoxLeft.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxLeft.leftMargin = 2
    self.tickBoxLeft:setFont(UIFont.Small)
    self:addChild(self.tickBoxLeft)

    self:addAdminPowerOptionsLeft()

    self.tickBoxRight = ISTickBox:new(UI_BORDER_SPACING * 2 + self.tickBoxLeft:getWidth(), FONT_HGT_MEDIUM+UI_BORDER_SPACING * 2, BUTTON_WIDTH, BUTTON_HGT, "Admin Powers", self, self.onTicked)
    self.tickBoxRight.backgroundColor.a = 1
    self.tickBoxRight.background = false
    self.tickBoxRight.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxRight.leftMargin = 2
    self.tickBoxRight:setFont(UIFont.Small)
    self:addChild(self.tickBoxRight)

    self:addAdminPowerOptionsRight()

    self:setWidth(self.tickBoxLeft:getWidth() + self.tickBoxRight:getWidth() + UI_BORDER_SPACING * 3)

    self.richText = ISRichTextLayout:new(self:getWidth() - UI_BORDER_SPACING * 2)
    self.richText.marginLeft = 0
    self.richText.marginTop = 0
    self.richText.marginRight = 0
    self.richText.marginBottom = 0
    self.richText:setText(getText("IGUI_AdminPanel_ShowAdminTag"))
    self.richText:initialise()
    self.richText:paginate()

    self:setHeight(FONT_HGT_MEDIUM + math.max(self.tickBoxLeft:getHeight(), self.tickBoxRight:getHeight()) + self.richText:getHeight() + BUTTON_HGT + UI_BORDER_SPACING * 5)

    self.ok = ISButton:new(self:getWidth() / 2 - UI_BORDER_SPACING / 2 - BUTTON_WIDTH, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT, BUTTON_WIDTH, BUTTON_HGT, getText("IGUI_RadioSave"), self, ISAdminPowerUI.onClick);
    self.ok.internal = "SAVE";
    self.ok:initialise();
    self.ok:instantiate();
    self.ok:enableAcceptColor()
    self:addChild(self.ok);

    self.cancel = ISButton:new(self:getWidth() / 2 + UI_BORDER_SPACING / 2, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT, BUTTON_WIDTH, BUTTON_HGT, getText("IGUI_RadioClose"), self, ISAdminPowerUI.onClick);
    self.cancel.internal = "CLOSE";
    self.cancel:initialise();
    self.cancel:instantiate();
    self.cancel:enableCancelColor()
    self:addChild(self.cancel);
end

function ISAdminPowerUI:addOptionLeft(text, selected, setFunction)
    local n = self.tickBoxLeft:addOption(getText("IGUI_CheatPanel_"..text), text)
    self.tickBoxLeft:setSelected(n, selected)
    self.setFunctionLeft[n] = setFunction
end

function ISAdminPowerUI:addOptionRight(text, selected, setFunction)
    local n = self.tickBoxRight:addOption(getText("IGUI_CheatPanel_"..text), text)
    self.tickBoxRight:setSelected(n, selected)
    self.setFunctionRight[n] = setFunction
end

function ISAdminPowerUI:addTooltip(tooltips, name, capability)
    if isClient() then
        tooltips[getText("IGUI_CheatPanel_"..name)] = getText("IGUI_CheatPanel_"..name.."_tooltip") .. "\n" .. getText("IGUI_AdminPanel_Tooltip_Capability", capability)
    else
        tooltips[getText("IGUI_CheatPanel_"..name)] = getText("IGUI_CheatPanel_"..name.."_tooltip")
    end
end

function ISAdminPowerUI:addAdminPowerOptionsLeft()
    self.setFunctionLeft = {}
    self.cheatTooltipsLeft = {}
    if self.player:getRole():hasCapability(Capability.ToggleInvisibleHimself) then
        self:addOptionLeft("Invisible", self.player:isInvisible(), function(self, selected)
            self.player:setInvisible(selected);
        end);
        self:addTooltip(self.cheatTooltipsLeft, "Invisible", Capability.ToggleInvisibleHimself:name())
    end
    if self.player:getRole():hasCapability(Capability.ToggleGodModHimself) then
        self:addOptionLeft("GodMod", self.player:isGodMod(), function(self, selected)
            self.player:setGodMod(selected);
        end);
        self:addTooltip(self.cheatTooltipsLeft, "GodMod", Capability.ToggleGodModHimself:name())
    end
    if self.player:getRole():hasCapability(Capability.ToggleNoclipHimself) then
        self:addOptionLeft("NoClip", self.player:isNoClip(), function(self, selected)
            self.player:setNoClip(selected);
        end);
        self:addTooltip(self.cheatTooltipsLeft, "NoClip", Capability.ToggleNoclipHimself:name())
    end
    if self.player:getRole():hasCapability(Capability.UseFastMoveCheat) then
        self:addOptionLeft("FastMove", ISFastTeleportMove.cheat, function(self, selected)
            ISFastTeleportMove.cheat = selected;
            self.player:setFastMoveCheat(selected);
        end);
        self:addTooltip(self.cheatTooltipsLeft, "FastMove", Capability.UseFastMoveCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.UseTimedActionInstantCheat) then
        self:addOptionLeft("TimedActionInstant", self.player:isTimedActionInstantCheat(), function(self, selected)
            self.player:setTimedActionInstantCheat(selected);
        end);
        self:addTooltip(self.cheatTooltipsLeft, "TimedActionInstant", Capability.UseTimedActionInstantCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.ToggleUnlimitedCarry) then
        self:addOptionLeft("UnlimitedCarry", self.player:isUnlimitedCarry(), function(self, selected)
            self.player:setUnlimitedCarry(selected);
        end);
        self:addTooltip(self.cheatTooltipsLeft, "UnlimitedCarry", Capability.ToggleUnlimitedCarry:name())
    end
    if self.player:getRole():hasCapability(Capability.ToggleUnlimitedEndurance) then
        self:addOptionLeft("UnlimitedEndurance", self.player:isUnlimitedEndurance(), function(self, selected)
            self.player:setUnlimitedEndurance(selected);
        end);
        self:addTooltip(self.cheatTooltipsLeft, "UnlimitedEndurance", Capability.ToggleUnlimitedEndurance:name())
    end
    if self.player:getRole():hasCapability(Capability.ToggleUnlimitedAmmo) then
        self:addOptionLeft("UnlimitedAmmo", self.player:isUnlimitedAmmo(), function(self, selected)
            self.player:setUnlimitedAmmo(selected);
        end);
        self:addTooltip(self.cheatTooltipsLeft, "UnlimitedAmmo", Capability.ToggleUnlimitedAmmo:name())
    end
    if self.player:getRole():hasCapability(Capability.ToggleKnowAllRecipes) then
        self:addOptionLeft("KnowAllRecipes", self.player:isKnowAllRecipes(), function(self, selected)
            self.player:setKnowAllRecipes(selected);
        end);
        self:addTooltip(self.cheatTooltipsLeft, "KnowAllRecipes", Capability.ToggleKnowAllRecipes:name())
    end
    if self.player:getRole():hasCapability(Capability.UseBuildCheat) then
        self:addOptionLeft("BuildCheat", ISBuildMenu.cheat, function(self, selected)
            ISBuildMenu.cheat = selected;
            self.player:setBuildCheat(selected);
        end);
        self:addTooltip(self.cheatTooltipsLeft, "BuildCheat", Capability.UseBuildCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.UseFarmingCheat) then
        self:addOptionLeft("FarmingCheat", ISFarmingMenu.cheat, function(self, selected)
            ISFarmingMenu.cheat = selected;
            self.player:setFarmingCheat(selected);
        end);
        self:addTooltip(self.cheatTooltipsLeft, "FarmingCheat", Capability.UseFarmingCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.UseFishingCheat) then
        self:addOptionLeft("FishingCheat", self.player:isFishingCheat(), function(self, selected)
            self.player:setFishingCheat(selected);
        end);
        self:addTooltip(self.cheatTooltipsLeft, "FishingCheat", Capability.UseFishingCheat:name())
    end
    self.tickBoxLeft:setWidthToFit()
end

function ISAdminPowerUI:addAdminPowerOptionsRight()
    self.setFunctionRight = {}
    self.cheatTooltipsRight = {}
    if self.player:getRole():hasCapability(Capability.UseHealthCheat) then
        self:addOptionRight("HealthCheat", ISHealthPanel.cheat, function(self, selected)
            ISHealthPanel.cheat = selected;
            self.player:setHealthCheat(selected);
        end);
        self:addTooltip(self.cheatTooltipsRight, "HealthCheat", Capability.UseHealthCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.UseMechanicsCheat) then
        self:addOptionRight("MechanicsCheat", ISVehicleMechanics.cheat, function(self, selected)
            ISVehicleMechanics.cheat = selected;
            self.player:setMechanicsCheat(selected);
        end);
        self:addTooltip(self.cheatTooltipsRight, "MechanicsCheat", Capability.UseMechanicsCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.UseMovablesCheat) then
        self:addOptionRight("MoveableCheat", ISMoveableDefinitions.cheat, function(self, selected)
            ISMoveableDefinitions.cheat = selected;
            self.player:setMovablesCheat(selected);
        end);
        self:addTooltip(self.cheatTooltipsRight, "MoveableCheat", Capability.UseMovablesCheat:name())
    end
    if self.player:getRole():hasCapability(Capability.CanSeeAll) then
        self:addOptionRight("CanSeeAll", self.player:canSeeAll(), function(self, selected)
            self.player:setCanSeeAll(selected);
        end);
        self:addTooltip(self.cheatTooltipsRight, "CanSeeAll", Capability.CanSeeAll:name())
    end
    if self.player:getRole():hasCapability(Capability.CanHearAll) then
        self:addOptionRight("CanHearAll", self.player:canHearAll(), function(self, selected)
            self.player:setCanHearAll(selected);
        end);
        self:addTooltip(self.cheatTooltipsRight, "CanHearAll", Capability.CanHearAll:name())
    end
    if self.player:getRole():hasCapability(Capability.ManipulateZombie) then
        self:addOptionRight("ZombiesDontAttack", self.player:isZombiesDontAttack(), function(self, selected)
            self.player:setZombiesDontAttack(selected);
        end);
        self:addTooltip(self.cheatTooltipsRight, "ZombiesDontAttack", Capability.ManipulateZombie:name())
    end
    if self.player:getRole():hasCapability(Capability.UseBrushToolManager) then
        self:addOptionRight("BrushTool", BrushToolManager.cheat, function(self, selected)
            BrushToolManager.cheat = selected
            self.player:setCanUseBrushTool(selected);
        end);
        self:addTooltip(self.cheatTooltipsRight, "BrushTool", Capability.UseBrushToolManager:name())
    end
    if self.player:getRole():hasCapability(Capability.UseLootZed) then
        self:addOptionRight("LootZed", ISLootZed.cheat, function(self, selected)
            ISLootZed.cheat = selected;
            self.player:setCanUseLootZed(selected);
        end);
        self:addTooltip(self.cheatTooltipsRight, "LootZed", Capability.UseLootZed:name())
    end
    if self.player:getRole():hasCapability(Capability.UseLootLog) then
        self:addOptionRight("LootLog", ISLootLog.cheat, function(self, selected)
            ISLootLog.cheat = selected;
            self.player:setCanUseLootLog(selected);
        end);
        self:addTooltip(self.cheatTooltipsRight, "LootLog", Capability.UseLootLog:name())
    end
    if self.player:getRole():hasCapability(Capability.AnimalCheats) then
        self:addOptionRight("AnimalCheat", AnimalContextMenu.cheat, function(self, selected)
            AnimalContextMenu.cheat = selected;
            self.player:setAnimalCheat(selected);
        end);
        self:addTooltip(self.cheatTooltipsRight, "AnimalCheat", Capability.AnimalCheats:name())
    end
    if self.player:getRole():hasCapability(Capability.AnimalCheats) then
        self:addOptionRight("AnimalExtraValues", self.player:isAnimalExtraValuesCheat(), function(self, selected)
            self.player:setAnimalExtraValuesCheat(selected);
        end);
        self:addTooltip(self.cheatTooltipsRight, "AnimalExtraValues", Capability.AnimalCheats:name())
    end
    self.tickBoxRight:setWidthToFit()
end

function ISAdminPowerUI:onTicked(index, selected)
end

function ISAdminPowerUI:renderTickBox(tickBox, tooltips)
    if tickBox:isMouseOver() and tooltips[tickBox.optionsIndex[tickBox.mouseOverOption]] ~= nil then
        local text = tooltips[tickBox.optionsIndex[tickBox.mouseOverOption]]
        if not tickBox.tooltipUI then
            tickBox.tooltipUI = ISToolTip:new()
            tickBox.tooltipUI:setOwner(tickBox)
            tickBox.tooltipUI:setVisible(false)
            tickBox.tooltipUI:setAlwaysOnTop(true)
        end
        if not tickBox.tooltipUI:getIsVisible() then
            if string.contains(text, "\n") then
                tickBox.tooltipUI.maxLineWidth = 1000 -- don't wrap the lines
            else
                tickBox.tooltipUI.maxLineWidth = 300
            end
            tickBox.tooltipUI:addToUIManager()
            tickBox.tooltipUI:setVisible(true)
        end
        tickBox.tooltipUI.description = text
        tickBox.tooltipUI:setX(tickBox:getMouseX() + 23)
        tickBox.tooltipUI:setY(tickBox:getMouseY() + 23)
    else
        if tickBox.tooltipUI and tickBox.tooltipUI:getIsVisible() then
            tickBox.tooltipUI:setVisible(false)
            tickBox.tooltipUI:removeFromUIManager()
        end
    end
end

function ISAdminPowerUI:render()
    self:renderTickBox(self.tickBoxLeft, self.cheatTooltipsLeft)
    self:renderTickBox(self.tickBoxRight, self.cheatTooltipsRight)
    if not self.player and getPlayer() then
        self.player = getPlayer()
    end
    if self.player:isDead() and not getPlayer():isDead() then
        self.player = getPlayer()
    end
end

function ISAdminPowerUI:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    if isClient() then
        self:drawText(getText("IGUI_AdminPanel_AdminPower"), self.width / 2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AdminPanel_AdminPower")) / 2), UI_BORDER_SPACING, 1, 1, 1, 1, UIFont.Medium);
        self.richText:render(UI_BORDER_SPACING, math.max(self.tickBoxLeft:getBottom(), self.tickBoxRight:getBottom()) + UI_BORDER_SPACING, self)
    else
        self:drawText("Cheats", self.width / 2 - (getTextManager():MeasureStringX(UIFont.Medium, "Cheats") / 2), UI_BORDER_SPACING, 1, 1, 1, 1, UIFont.Medium);
    end
end

function ISAdminPowerUI:onClick(button)
    if button.internal == "SAVE" then
        if not self.player:isDead() then
            for i=1,#self.tickBoxLeft.options do
                self.setFunctionLeft[i](self, self.tickBoxLeft:isSelected(i))
            end
            for i=1,#self.tickBoxRight.options do
                self.setFunctionRight[i](self, self.tickBoxRight:isSelected(i))
            end
            sendPlayerExtraInfo(self.player)
        end
    
        self:setVisible(false)
        self:removeFromUIManager()
    end

    if button.internal == "CLOSE" then
        self:setVisible(false)
        self:removeFromUIManager()
    end
end

function ISAdminPowerUI.OnOpenPanel()
    if ISAdminPowerUI.instance==nil then
        ISAdminPowerUI.instance = ISAdminPowerUI:new(50, 200, 480, 350, getPlayer())
        ISAdminPowerUI.instance:initialise();
    end
    ISAdminPowerUI.instance:addToUIManager();
    ISAdminPowerUI.instance:setVisible(true);
    return ISAdminPowerUI.instance;
end

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

ISAdminPowerUI.onGameStart = function()
    ISBuildMenu.cheat = getPlayer():isBuildCheat();
    ISFarmingMenu.cheat = getPlayer():isFarmingCheat();
    ISHealthPanel.cheat = getPlayer():isHealthCheat();
    ISMoveableDefinitions.cheat = getPlayer():isMovablesCheat();
    BrushToolManager.cheat = getPlayer():isCanUseBrushTool();
    ISFastTeleportMove.cheat = getPlayer():isFastMoveCheat();
    AnimalContextMenu.cheat = getPlayer():isAnimalCheat();
    ISLootZed.cheat = getPlayer():canUseLootZed();
    ISLootLog.cheat = getPlayer():canUseLootLog();
    ISVehicleMechanics.cheat = getPlayer():isMechanicsCheat();
end

Events.OnGameStart.Add(ISAdminPowerUI.onGameStart)
Events.RefreshCheats.Add(ISAdminPowerUI.onGameStart)
