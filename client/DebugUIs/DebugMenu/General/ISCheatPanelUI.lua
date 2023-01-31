ISCheatPanelUI = ISPanel:derive("ISCheatPanelUI");
ISCheatPanelUI.instance = nil

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

ISCheatPanelUI.cheatTooltips = {}
ISCheatPanelUI.cheatTooltips["Fast Move"] = "Fast move:\nMove - arrow keys\nFloor Up/Down - PageUp/PageDown keys"
ISCheatPanelUI.cheatTooltips["LootZed"] = "Show distribution list\nClick on container icon in loot menu to show"

function ISCheatPanelUI.OnOpenPanel()
    if ISCheatPanelUI.instance==nil then
        ISCheatPanelUI.instance = ISCheatPanelUI:new (50, 200, 212, 350, getPlayer());
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
    local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
    local padBottom = 10

    self.ok = ISButton:new(10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("IGUI_RadioSave"), self, ISCheatPanelUI.onClick);
    self.ok.internal = "SAVE";
    self.ok.anchorTop = false
    self.ok.anchorBottom = true
    self.ok:initialise();
    self.ok:instantiate();
    self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.ok);

    self.tickBox = ISTickBox:new(30, 50, 100, FONT_HGT_SMALL + 5, "Admin Powers", self, self.onTicked)
    self.tickBox.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBox.leftMargin = 2
    self.tickBox:setFont(UIFont.Small)
    self:addChild(self.tickBox);

    self:addAdminPowerOptions()
end

function ISCheatPanelUI:addAdminPowerOptions()
    self.setFunction = {}
    self:addOption("Invisible", self.player:isInvisible(), function(self, selected)
        self.player:setInvisible(selected);
    end);
    self:addOption("God mode", self.player:isGodMod(), function(self, selected)
        self.player:setGodMod(selected);
    end);
    self:addOption("Ghost mode", self.player:isGhostMode(), function(self, selected)
        self.player:setGhostMode(selected);
    end);
    self:addOption("No Clip", self.player:isNoClip(), function(self, selected)
        self.player:setNoClip(selected);
    end);
    self:addOption("Fast Move", ISFastTeleportMove.cheat, function(self, selected)
        ISFastTeleportMove.cheat = selected
    end);
    self:addOption("Timed Action Instant", self.player:isTimedActionInstantCheat(), function(self, selected)
        self.player:setTimedActionInstantCheat(selected);
    end);
    self:addOption("Unlimited Carry", self.player:isUnlimitedCarry(), function(self, selected)
        self.player:setUnlimitedCarry(selected);
    end);
    self:addOption("Unlimited Endurance", self.player:isUnlimitedEndurance(), function(self, selected)
        self.player:setUnlimitedEndurance(selected);
    end);
    self:addOption("Unlimited Ammo", getDebugOptions():getBoolean("Cheat.Player.UnlimitedAmmo"), function(self, selected)
        getDebugOptions():setBoolean("Cheat.Player.UnlimitedAmmo", selected)
    end)
    self:addOption("Know All Recipes", getDebugOptions():getBoolean("Cheat.Recipe.KnowAll"), function(self, selected)
        getDebugOptions():setBoolean("Cheat.Recipe.KnowAll", selected)
    end)
    self:addOption(getText("IGUI_AdminPanel_BuildCheat"), ISBuildMenu.cheat, function(self, selected)
        ISBuildMenu.cheat = selected;
        self.player:setBuildCheat(selected);
    end);
    self:addOption(getText("IGUI_AdminPanel_FarmingCheat"), ISFarmingMenu.cheat, function(self, selected)
        ISFarmingMenu.cheat = selected;
        self.player:setFarmingCheat(selected);
    end);
    self:addOption(getText("IGUI_AdminPanel_HealthCheat"), ISHealthPanel.cheat, function(self, selected)
        ISHealthPanel.cheat = selected;
        self.player:setHealthCheat(selected);
    end);
    self:addOption(getText("IGUI_AdminPanel_MechanicsCheat"), ISVehicleMechanics.cheat, function(self, selected)
        ISVehicleMechanics.cheat = selected;
        self.player:setMechanicsCheat(selected);
    end);
    self:addOption(getText("IGUI_AdminPanel_MoveableCheat"), ISMoveableDefinitions.cheat, function(self, selected)
        ISMoveableDefinitions.cheat = selected;
        self.player:setMovablesCheat(selected);
    end);
    self:addOption("LootZed", ISLootZed.cheat, function(self, selected)
        ISLootZed.cheat = selected;
    end);
    self:addOption("Brush Tool", BrushToolManager.cheat, function(self, selected)
        BrushToolManager.cheat = selected;
    end);

    self.tickBox:setWidthToFit()

    self:setHeight(self.tickBox:getBottom() + 40 + 20 + self.ok:getHeight() + 10)
end

function ISCheatPanelUI:addOption(text, selected, setFunction)
    local n = self.tickBox:addOption(text)
    self.tickBox:setSelected(n, selected)
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
    local z = 20;
    local splitPoint = 100;
    local x = 10;
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText("Cheats", self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, "Cheats") / 2), z, 1,1,1,1, UIFont.Medium);
end

function ISCheatPanelUI:onClick(button)
    if button.internal == "SAVE" then
        if not self.player:isDead() then
            for i=1,#self.tickBox.options do
                self.setFunction[i](self, self.tickBox:isSelected(i))
            end
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
