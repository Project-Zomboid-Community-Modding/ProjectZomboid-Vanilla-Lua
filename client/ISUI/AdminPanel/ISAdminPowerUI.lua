ISAdminPowerUI = ISPanel:derive("ISAdminPowerUI");
ISAdminPowerUI.messages = {};

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local BUTTON_WIDTH = 100

ISAdminPowerUI.OptionList = {}
ISAdminPowerUI.OptionById = {}

function ISAdminPowerUI.AddOption(id, side, capability, functionGet, functionSet)
    local option = {}
    option.id = id
    option.text = getText("IGUI_CheatPanel_"..id)
    option.side = side
    option.capability = capability
    if isClient() then
        option.tooltip = getText("IGUI_CheatPanel_"..id.."_tooltip") .. "\n" .. getText("IGUI_AdminPanel_Tooltip_Capability", capability:name())
    else
        option.tooltip = getText("IGUI_CheatPanel_"..id.."_tooltip")
    end
    option.getValue = functionGet
    option.setValue = functionSet
    table.insert(ISAdminPowerUI.OptionList, option)
    ISAdminPowerUI.OptionById[id] = option
    return option
end

ISAdminPowerUI.AddOption("Invisible", "left", Capability.ToggleInvisibleHimself,
    function(self)
        return self.player:isInvisible()
    end,
    function(self, selected)
        self.player:setInvisible(selected)
    end
)
ISAdminPowerUI.AddOption("GodMod", "left", Capability.ToggleGodModHimself,
    function(self)
        return self.player:isGodMod()
    end,
    function(self, selected)
        self.player:setGodMod(selected)
    end
)
ISAdminPowerUI.AddOption("NoClip", "left", Capability.ToggleNoclipHimself,
    function(self)
        return self.player:isNoClip()
    end,
    function(self, selected)
        self.player:setNoClip(selected)
    end
)
ISAdminPowerUI.AddOption("FastMove", "left", Capability.UseFastMoveCheat,
    function(self)
        return ISFastTeleportMove.cheat
    end,
    function(self, selected)
        ISFastTeleportMove.cheat = selected
    end
)
ISAdminPowerUI.AddOption("TimedActionInstant", "left", Capability.UseTimedActionInstantCheat,
    function(self)
        return self.player:isTimedActionInstantCheat()
    end,
    function(self, selected)
        self.player:setTimedActionInstantCheat(selected)
    end
)
ISAdminPowerUI.AddOption("UnlimitedCarry", "left", Capability.ToggleUnlimitedCarry,
    function(self)
        return self.player:isUnlimitedCarry()
    end,
    function(self, selected)
        self.player:setUnlimitedCarry(selected)
    end
)
ISAdminPowerUI.AddOption("UnlimitedEndurance", "left", Capability.ToggleUnlimitedEndurance,
    function(self)
        return self.player:isUnlimitedEndurance()
    end,
    function(self, selected)
        self.player:setUnlimitedEndurance(selected)
    end
)
ISAdminPowerUI.AddOption("UnlimitedAmmo", "left", Capability.ToggleUnlimitedAmmo,
    function(self)
        return self.player:isUnlimitedAmmo()
    end,
    function(self, selected)
        self.player:setUnlimitedAmmo(selected)
    end
)
ISAdminPowerUI.AddOption("KnowAllRecipes", "left", Capability.ToggleKnowAllRecipes,
    function(self)
        return self.player:isKnowAllRecipes()
    end,
    function(self, selected)
        self.player:setKnowAllRecipes(selected)
    end
)
ISAdminPowerUI.AddOption("BuildCheat", "left", Capability.UseBuildCheat,
    function(self)
        return ISBuildMenu.cheat
    end,
    function(self, selected)
        ISBuildMenu.cheat = selected
        self.player:setBuildCheat(selected)
    end
)
ISAdminPowerUI.AddOption("FarmingCheat", "left", Capability.UseFarmingCheat,
    function(self)
        return ISFarmingMenu.cheat
    end,
    function(self, selected)
        ISFarmingMenu.cheat = selected
        self.player:setFarmingCheat(selected)
    end
)
ISAdminPowerUI.AddOption("FishingCheat", "left", Capability.UseFishingCheat,
    function(self)
        return self.player:isFishingCheat()
    end,
    function(self, selected)
        self.player:setFishingCheat(selected)
    end
)
ISAdminPowerUI.AddOption("HealthCheat", "right", Capability.UseHealthCheat,
    function(self)
        return ISHealthPanel.cheat
    end,
    function(self, selected)
        ISHealthPanel.cheat = selected;
        self.player:setHealthCheat(selected)
    end
)
ISAdminPowerUI.AddOption("MechanicsCheat", "right", Capability.UseMechanicsCheat,
    function(self)
        return ISVehicleMechanics.cheat
    end,
    function(self, selected)
        ISVehicleMechanics.cheat = selected;
        self.player:setMechanicsCheat(selected);
    end
)
ISAdminPowerUI.AddOption("MoveableCheat", "right", Capability.UseMovablesCheat,
    function(self)
        return ISMoveableDefinitions.cheat
    end,
    function(self, selected)
        ISMoveableDefinitions.cheat = selected
        self.player:setMovablesCheat(selected)
    end
)
ISAdminPowerUI.AddOption("CanSeeAll", "right", Capability.CanSeeAll,
    function(self)
        return self.player:canSeeAll()
    end,
    function(self, selected)
        self.player:setCanSeeAll(selected)
    end
)
ISAdminPowerUI.AddOption("CanHearAll", "right", Capability.CanHearAll,
    function(self)
        return self.player:canHearAll()
    end,
    function(self, selected)
        self.player:setCanHearAll(selected)
    end
)
ISAdminPowerUI.AddOption("ZombiesDontAttack", "right", Capability.ManipulateZombie,
    function(self)
        return self.player:isZombiesDontAttack()
    end,
    function(self, selected)
        self.player:setZombiesDontAttack(selected)
    end
)
ISAdminPowerUI.AddOption("BrushTool", "right", Capability.UseBrushToolManager,
    function(self)
        return BrushToolManager.cheat
    end,
    function(self, selected)
        BrushToolManager.cheat = selected
        self.player:setCanUseBrushTool(selected)
    end
)
ISAdminPowerUI.AddOption("LootZed", "right", Capability.UseLootZed,
    function(self)
        return ISLootZed.cheat
    end, function(self, selected)
        ISLootZed.cheat = selected
        self.player:setCanUseLootZed(selected);
    end
)
ISAdminPowerUI.AddOption("LootLog", "right", Capability.UseLootLog,
    function(self)
        return ISLootLog.cheat
    end,
    function(self, selected)
        ISLootLog.cheat = selected
        self.player:setCanUseLootLog(selected);
    end
)
ISAdminPowerUI.AddOption("AnimalCheat", "right", Capability.AnimalCheats,
    function(self)
        return AnimalContextMenu.cheat
    end,
    function(self, selected)
        AnimalContextMenu.cheat = selected
        self.player:setAnimalCheat(selected)
    end
)
ISAdminPowerUI.AddOption("AnimalExtraValues", "right", Capability.AnimalCheats,
    function(self)
        return self.player:isAnimalExtraValuesCheat()
    end,
    function(self, selected)
        self.player:setAnimalExtraValuesCheat(selected)
    end
)

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

function ISAdminPowerUI:addOptionLeft(option)
    local n = self.tickBoxLeft:addOption(option.text, option.id)
    option.player = self.player
    self.tickBoxLeft:setSelected(n, option:getValue())
    self.optionsLeft[n] = option
    self.cheatTooltipsLeft[option.text] = option.tooltip
end

function ISAdminPowerUI:addOptionRight(option)
    local n = self.tickBoxRight:addOption(option.text, option.id)
    option.player = self.player
    self.tickBoxRight:setSelected(n, option:getValue())
    self.optionsRight[n] = option
    self.cheatTooltipsRight[option.text] = option.tooltip
end

function ISAdminPowerUI:updateAdminPower()
    self.tickBoxLeft:clearOptions()
    self:addAdminPowerOptionsLeft()
    self.tickBoxRight:clearOptions()
    self:addAdminPowerOptionsRight()
    self.tickBoxRight:setX(UI_BORDER_SPACING * 2 + self.tickBoxLeft:getWidth())
    local btnWidth = BUTTON_WIDTH * 2
    local tickBoxWidth = self.tickBoxLeft:getWidth() + self.tickBoxRight:getWidth()
    local textWidth = getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_AdminPanel_AdminPower"))
    self:setWidth(math.max(tickBoxWidth + UI_BORDER_SPACING * 3, btnWidth + UI_BORDER_SPACING * 2))
    self.richText:setWidth(self:getWidth() - UI_BORDER_SPACING * 2)
    self.richText.textDirty = true
    self:setHeight(FONT_HGT_MEDIUM + math.max(self.tickBoxLeft:getHeight(), self.tickBoxRight:getHeight()) + self.richText:getHeight() + BUTTON_HGT + UI_BORDER_SPACING * 5)
    self.ok:setX(self:getWidth() / 2 - UI_BORDER_SPACING / 2 - BUTTON_WIDTH)
    self.ok:setY(self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT)
    self.cancel:setX(self:getWidth() / 2 + UI_BORDER_SPACING / 2)
    self.cancel:setY(self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT)
end

function ISAdminPowerUI:addAdminPowerOptionsLeft()
    self.optionsLeft = {}
    self.cheatTooltipsLeft = {}
	for _,option in ipairs(ISAdminPowerUI.OptionList) do
	    if option.side == "left" and self.player:getRole():hasCapability(option.capability) then
            self:addOptionLeft(option)
        end
    end
    self.tickBoxLeft:setWidthToFit()
end

function ISAdminPowerUI:addAdminPowerOptionsRight()
    self.optionsRight = {}
    self.cheatTooltipsRight = {}
	for _,option in ipairs(ISAdminPowerUI.OptionList) do
	    if option.side == "right" and self.player:getRole():hasCapability(option.capability) then
            self:addOptionRight(option)
        end
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
        if not self.player:isDead() and self.player:getRole():hasAdminPower() then
            for i=1,#self.tickBoxLeft.options do
                self.optionsLeft[i]:setValue(self.tickBoxLeft:isSelected(i))
            end
            for i=1,#self.tickBoxRight.options do
                self.optionsRight[i]:setValue(self.tickBoxRight:isSelected(i))
            end
            sendPlayerExtraInfo(self.player)
        end
    
        self:setVisible(false)
        self:removeFromUIManager()
        self:saveOptions()
    end

    if button.internal == "CLOSE" then
        self:setVisible(false)
        self:removeFromUIManager()
    end
end

function ISAdminPowerUI:saveOptions()
    if isClient() then return end
    if not self.player or self.player:isDead() then return end
	local writer = getFileWriter("CheatPanel.ini", true, false)
	for _,option in ipairs(ISAdminPowerUI.OptionList) do
        option.player = self.player
        local value = option:getValue() and "true" or "false"
	    writer:write(option.id.."="..value..lineSeparator())
    end
	writer:close()
end

function ISAdminPowerUI.OnOpenPanel()
    if ISAdminPowerUI.instance == nil then
        ISAdminPowerUI.instance = ISAdminPowerUI:new(50, 200, 480, 350, getPlayer())
        ISAdminPowerUI.instance:initialise();
    end
    ISAdminPowerUI.instance:updateAdminPower();
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
    if isClient() then
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
    else
        local playerObj = getSpecificPlayer(0)
        if not playerObj or playerObj:isDead() then return end
        -- if single player and it's not debug mode, all cheats should be disabled
        if not getDebug() then return end
        local reader = getFileReader("CheatPanel.ini", false)
        if not reader then return end
        while true do
            local line = reader:readLine()
            if not line then
                reader:close()
                break
            end
            local ss = luautils.split(line, "=")
            local id = ss[1]
            local value = ss[2]
            local option = ISAdminPowerUI.OptionById[id]
            if option then
                option.player = playerObj
                option:setValue(value == "true")
            end
        end
        DebugLog.log("Cheats enabled/disabled on game start in lua from the file CheatPanel.ini.")
    end
end

Events.OnGameStart.Add(ISAdminPowerUI.onGameStart)
Events.RefreshCheats.Add(ISAdminPowerUI.onGameStart)
