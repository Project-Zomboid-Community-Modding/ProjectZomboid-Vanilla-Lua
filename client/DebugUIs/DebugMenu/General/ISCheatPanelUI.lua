ISCheatPanelUI = ISPanel:derive("ISCheatPanelUI");
ISCheatPanelUI.instance = nil

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISCheatPanelUI.cheatTooltips = {}

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
    self.setFunction = {}
    self:addOption("IGUI_CheatPanel_Invisible", self.player:isInvisible(), function(self, selected)
        self.player:setInvisible(selected);
    end);
    self:addOption("IGUI_CheatPanel_GodMod", self.player:isGodMod(), function(self, selected)
        self.player:setGodMod(selected);
    end);
    self:addOption("IGUI_CheatPanel_NoClip", self.player:isNoClip(), function(self, selected)
        self.player:setNoClip(selected);
    end);
    self:addOption("IGUI_CheatPanel_FastMove", ISFastTeleportMove.cheat, function(self, selected)
        ISFastTeleportMove.cheat = selected
    end);
    self:addOption("IGUI_CheatPanel_TimedActionInstant", self.player:isTimedActionInstantCheat(), function(self, selected)
        self.player:setTimedActionInstantCheat(selected);
    end);
    self:addOption("IGUI_CheatPanel_UnlimitedCarry", self.player:isUnlimitedCarry(), function(self, selected)
        self.player:setUnlimitedCarry(selected);
    end);
    self:addOption("IGUI_CheatPanel_UnlimitedEndurance", self.player:isUnlimitedEndurance(), function(self, selected)
        self.player:setUnlimitedEndurance(selected);
    end);
    self:addOption("IGUI_CheatPanel_UnlimitedAmmo", self.player:isUnlimitedAmmo(), function(self, selected)
        self.player:setUnlimitedAmmo(selected);
    end)
    self:addOption("IGUI_CheatPanel_KnowAllRecipes", self.player:isKnowAllRecipes(), function(self, selected)
        self.player:setKnowAllRecipes(selected);
    end)
    self:addOption("IGUI_CheatPanel_SeeAllRecipes", getDebugOptions():getBoolean("Cheat.Recipe.SeeAll"), function(self, selected)
        getDebugOptions():setBoolean("Cheat.Recipe.SeeAll", selected)
    end)
    self:addOption("IGUI_CheatPanel_BuildCheat", ISBuildMenu.cheat, function(self, selected)
        ISBuildMenu.cheat = selected;
        self.player:setBuildCheat(selected);
    end);
    self:addOption("IGUI_CheatPanel_FarmingCheat", ISFarmingMenu.cheat, function(self, selected)
        ISFarmingMenu.cheat = selected;
        self.player:setFarmingCheat(selected);
    end);
    self:addOption("IGUI_CheatPanel_HealthCheat", ISHealthPanel.cheat, function(self, selected)
        ISHealthPanel.cheat = selected;
        self.player:setHealthCheat(selected);
    end);
    -- disable mechanics cheat for non-debug
    if getDebug() then
        self:addOption("IGUI_CheatPanel_MechanicsCheat", ISVehicleMechanics.cheat, function(self, selected)
            ISVehicleMechanics.cheat = selected;
            self.player:setMechanicsCheat(selected);
        end);
    end
    self:addOption("IGUI_CheatPanel_MoveableCheat", ISMoveableDefinitions.cheat, function(self, selected)
        ISMoveableDefinitions.cheat = selected;
        self.player:setMovablesCheat(selected);
    end);
    self:addOption("IGUI_CheatPanel_LootZed", ISLootZed.cheat, function(self, selected)
        ISLootZed.cheat = selected;
    end);
    self:addOption("IGUI_CheatPanel_LootLog", ISLootLog.cheat, function(self, selected)
        ISLootLog.cheat = selected;
    end);
    self:addOption("IGUI_CheatPanel_BrushTool", BrushToolManager.cheat, function(self, selected)
        BrushToolManager.cheat = selected;
    end);

    self:addOption("IGUI_CheatPanel_AnimalCheat", AnimalContextMenu.cheat, function(self, selected)
        AnimalContextMenu.cheat = selected;
    end);

    self:addOption("IGUI_CheatPanel_AnimalExtraValues", IsoAnimal.isExtraValues(), function(self, selected)
        IsoAnimal.toggleExtraValues();
    end);

    self.tickBox:setWidthToFit()

    self:setHeight(self.tickBox:getBottom() + self.ok:getHeight() + UI_BORDER_SPACING*2+1)
end

function ISCheatPanelUI:addOption(text, selected, setFunction)
    local n = self.tickBox:addOption(getText(text))
    self.tickBox:setSelected(n, selected)
    ISCheatPanelUI.cheatTooltips[getText(text)] = getText(text.."_tooltip")
    self.setFunction[n] = setFunction
end

function ISCheatPanelUI:onTicked(index, selected)
end

function ISCheatPanelUI:render()
    if self.tickBox:isMouseOver() and ISCheatPanelUI.cheatTooltips[self.tickBox.optionsIndex[self.tickBox.mouseOverOption]] ~= nil then
        local text = ISCheatPanelUI.cheatTooltips[self.tickBox.optionsIndex[self.tickBox.mouseOverOption]]
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
            for i=1,#self.tickBox.options do
                self.setFunction[i](self, self.tickBox:isSelected(i))
            end
            if isClient() then sendPlayerExtraInfo(self.player) end
        end
        self:setVisible(false);
        self:removeFromUIManager();
    end
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
    local chr = getPlayer();
    chr:setBuildCheat(ISBuildMenu.cheat);
    chr:setFarmingCheat(ISFarmingMenu.cheat);
    chr:setHealthCheat(ISHealthPanel.cheat);
end

Events.OnGameStart.Add(ISCheatPanelUI.EnableCheats)