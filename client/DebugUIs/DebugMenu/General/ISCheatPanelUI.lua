ISCheatPanelUI = ISPanel:derive("ISCheatPanelUI");
ISCheatPanelUI.instance = nil

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISCheatPanelUI.cheatTooltips = {}

-----

ISCheatPanelUI.OptionList = {}
ISCheatPanelUI.OptionById = {}

function ISCheatPanelUI.AddOption(id, xln, functionGet, functionSet)
    local option = {}
    option.id = id
    option.text = getText(xln)
    option.tooltip = getTextOrNull(xln.."_tooltip")
    option.getValue = functionGet
    option.setValue = functionSet
    table.insert(ISCheatPanelUI.OptionList, option)
    ISCheatPanelUI.OptionById[id] = option
    return option
end

ISCheatPanelUI.AddOption("Invisible", "IGUI_CheatPanel_Invisible",
    function(self)
        return self.player:isInvisible()
    end,
    function(self, selected)
        self.player:setInvisible(selected)
    end
)
ISCheatPanelUI.AddOption("GodMod", "IGUI_CheatPanel_GodMod",
    function(self)
        return self.player:isGodMod()
    end,
    function(self, selected)
        self.player:setGodMod(selected)
    end
)
ISCheatPanelUI.AddOption("NoClip", "IGUI_CheatPanel_NoClip",
    function(self)
        return self.player:isNoClip()
    end,
    function(self, selected)
        self.player:setNoClip(selected)
    end
)
ISCheatPanelUI.AddOption("FastMove", "IGUI_CheatPanel_FastMove",
    function(self)
        return ISFastTeleportMove.cheat
    end,
    function(self, selected)
        ISFastTeleportMove.cheat = selected
    end
)
ISCheatPanelUI.AddOption("TimedActionInstant", "IGUI_CheatPanel_TimedActionInstant",
    function(self)
        return self.player:isTimedActionInstantCheat()
    end,
    function(self, selected)
        self.player:setTimedActionInstantCheat(selected)
    end
)
ISCheatPanelUI.AddOption("UnlimitedCarry", "IGUI_CheatPanel_UnlimitedCarry",
    function(self)
        return self.player:isUnlimitedCarry()
    end,
    function(self, selected)
        self.player:setUnlimitedCarry(selected)
    end
)
ISCheatPanelUI.AddOption("UnlimitedEndurance", "IGUI_CheatPanel_UnlimitedEndurance",
    function(self)
        return self.player:isUnlimitedEndurance()
    end,
    function(self, selected)
        self.player:setUnlimitedEndurance(selected)
    end
)
ISCheatPanelUI.AddOption("UnlimitedAmmo", "IGUI_CheatPanel_UnlimitedAmmo",
    function(self)
        return self.player:isUnlimitedAmmo()
    end,
    function(self, selected)
        self.player:setUnlimitedAmmo(selected)
    end
)
ISCheatPanelUI.AddOption("KnowAllRecipes", "IGUI_CheatPanel_KnowAllRecipes",
    function(self)
        return self.player:isKnowAllRecipes()
    end,
    function(self, selected)
        self.player:setKnowAllRecipes(selected)
    end
)
ISCheatPanelUI.AddOption("SeeAllRecipes", "IGUI_CheatPanel_SeeAllRecipes",
    function(self)
        return getDebugOptions():getBoolean("Cheat.Recipe.SeeAll")
    end,
    function(self, selected)
        getDebugOptions():setBoolean("Cheat.Recipe.SeeAll", selected)
    end
)
ISCheatPanelUI.AddOption("BuildCheat", "IGUI_CheatPanel_BuildCheat",
    function(self)
        return ISBuildMenu.cheat
    end,
    function(self, selected)
        ISBuildMenu.cheat = selected
        self.player:setBuildCheat(selected)
    end
)
ISCheatPanelUI.AddOption("FarmingCheat", "IGUI_CheatPanel_FarmingCheat",
    function(self)
        return ISFarmingMenu.cheat
    end,
    function(self, selected)
        ISFarmingMenu.cheat = selected
        self.player:setFarmingCheat(selected)
    end
)
ISCheatPanelUI.AddOption("HealthCheat", "IGUI_CheatPanel_HealthCheat",
    function(self)
        return ISHealthPanel.cheat
    end,
    function(self, selected)
        ISHealthPanel.cheat = selected;
        self.player:setHealthCheat(selected)
    end
)
-- disable mechanics cheat for non-debug
if getDebug() then
    ISCheatPanelUI.AddOption("MechanicsCheat", "IGUI_CheatPanel_MechanicsCheat",
        function(self)
            return ISVehicleMechanics.cheat
        end,
        function(self, selected)
            ISVehicleMechanics.cheat = selected;
            self.player:setMechanicsCheat(selected);
        end
    )
end
ISCheatPanelUI.AddOption("MoveableCheat", "IGUI_CheatPanel_MoveableCheat",
    function(self)
        return ISMoveableDefinitions.cheat
    end,
    function(self, selected)
        ISMoveableDefinitions.cheat = selected
        self.player:setMovablesCheat(selected)
    end
)
ISCheatPanelUI.AddOption("LootZed", "IGUI_CheatPanel_LootZed",
    function(self)
        return ISLootZed.cheat
    end, function(self, selected)
        ISLootZed.cheat = selected
    end
)
ISCheatPanelUI.AddOption("LootLog", "IGUI_CheatPanel_LootLog",
    function(self)
        return ISLootLog.cheat
    end,
    function(self, selected)
        ISLootLog.cheat = selected
    end
)
ISCheatPanelUI.AddOption("BrushTool", "IGUI_CheatPanel_BrushTool",
    function(self)
        return BrushToolManager.cheat
    end,
    function(self, selected)
        BrushToolManager.cheat = selected
    end
)
ISCheatPanelUI.AddOption("AnimalCheat", "IGUI_CheatPanel_AnimalCheat",
    function(self)
        return AnimalContextMenu.cheat
    end,
    function(self, selected)
        AnimalContextMenu.cheat = selected
    end
)
ISCheatPanelUI.AddOption("AnimalExtraValues", "IGUI_CheatPanel_AnimalExtraValues",
    function(self)
        return IsoAnimal.isExtraValues()
    end,
    function(self, selected)
        IsoAnimal.setExtraValues(selected)
    end
)

-----

function ISCheatPanelUI.OnOpenPanel()
    if ISCheatPanelUI.instance==nil then
        ISCheatPanelUI.instance = ISCheatPanelUI:new (50, 200, 212+(getCore():getOptionFontSizeReal()*35), 350, getPlayer());
        ISCheatPanelUI.instance:initialise();
    end

    ISCheatPanelUI.instance:addToUIManager();
    ISCheatPanelUI.instance:setVisible(true);

    return ISCheatPanelUI.instance;
end

--************************************************************************--
--** ISCheatPanelUI:initialise
--**
--************************************************************************--

function ISCheatPanelUI:initialise()
    ISPanel.initialise(self);
    local btnWid = 100

    self.ok = ISButton:new((self:getWidth()-btnWid)/2, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_RadioSave"), self, ISCheatPanelUI.onClick);
    self.ok.internal = "SAVE";
    self.ok.anchorTop = false
    self.ok.anchorBottom = true
    self.ok:initialise();
    self.ok:instantiate();
    self.ok:enableAcceptColor()
    self:addChild(self.ok);

    self.tickBox = ISTickBox:new(UI_BORDER_SPACING+1, UI_BORDER_SPACING+FONT_HGT_MEDIUM+1, self.width - (UI_BORDER_SPACING+1)*2, BUTTON_HGT, "Admin Powers", self, self.onTicked)
    self.tickBox.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBox:setFont(UIFont.Small)
    self:addChild(self.tickBox);

    self:addAdminPowerOptions()
end

function ISCheatPanelUI:addAdminPowerOptions()
    for index,option in ipairs(ISCheatPanelUI.OptionList) do
        option.player = self.player
        local n = self.tickBox:addOption(option.text)
        self.tickBox:setSelected(n, option:getValue())
        ISCheatPanelUI.cheatTooltips[option.text] = option.tooltip
    end
    self.tickBox:setWidthToFit()

    self:setHeight(self.tickBox:getBottom() + self.ok:getHeight() + UI_BORDER_SPACING*2+1)
end

function ISCheatPanelUI:onTicked(index, selected)
end

function ISCheatPanelUI:render()
    local option = ISCheatPanelUI.OptionList[self.tickBox.mouseOverOption]
    if self.tickBox:isMouseOver() and option ~= nil and option.tooltip ~= nil then
        local text = option.tooltip
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
    if self.player:isDead() and not getPlayer():isDead() then
        self.player = getPlayer()
    end
end

function ISCheatPanelUI:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText("Cheats", self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, "Cheats") / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
end

function ISCheatPanelUI:onClick(button)
    if button.internal == "SAVE" then
        if not self.player:isDead() then
            for i,option in ipairs(ISCheatPanelUI.OptionList) do
                option.player = self.player
                option:setValue(self.tickBox:isSelected(i))
            end
            if isClient() then sendPlayerExtraInfo(self.player) end
        end
        self:setVisible(false);
        self:removeFromUIManager();
        self:saveOptions()
    end
end

function ISCheatPanelUI:saveOptions()
    if not self.player or self.player:isDead() then return end
	local writer = getFileWriter("CheatPanel.ini", true, false)
	for _,option in ipairs(ISCheatPanelUI.OptionList) do
        option.player = self.player
        local value = option:getValue() and "true" or "false"
	    writer:write(option.id.."="..value..lineSeparator())
    end
	writer:close()
end

--************************************************************************--
--** ISCheatPanelUI:new
--**
--************************************************************************--
function ISCheatPanelUI:new(x, y, width, height, player)
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
    ISCheatPanelUI.instance = o;
    return o;
end

ISCheatPanelUI.EnableCheats = function()
    local playerObj = getSpecificPlayer(0)
    if not playerObj or playerObj:isDead() then return end
    -- if single player and it's not debug mode, all cheats should be disabled
    if not isServer() and not isClient() and not getDebug() then return end
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
        local option = ISCheatPanelUI.OptionById[id]
        if option then
            option.player = playerObj
            option:setValue(value == "true")
        end
    end
end

Events.OnGameStart.Add(ISCheatPanelUI.EnableCheats)