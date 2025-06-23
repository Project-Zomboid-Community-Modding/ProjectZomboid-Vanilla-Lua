ISCharacterDebugUI = ISPanel:derive("ISCharacterDebugUI");
ISCharacterDebugUI.instance = nil

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISCharacterDebugUI.OnOpenPanel()
    if ISCharacterDebugUI.instance == nil then
        ISCharacterDebugUI.instance = ISCharacterDebugUI:new(50, 200, 10, 10);
        ISCharacterDebugUI.instance:initialise();
        ISCharacterDebugUI.instance:setVisible(false);
    end
    if ISCharacterDebugUI.instance:isVisible() then
        ISCharacterDebugUI.instance:setVisible(false);
        ISCharacterDebugUI.instance:removeFromUIManager();
    else
        ISCharacterDebugUI.instance:addToUIManager();
        ISCharacterDebugUI.instance:setVisible(true);
    end
    return ISCharacterDebugUI.instance;
end

function ISCharacterDebugUI:initialise()
    ISPanel.initialise(self);

    local tckWidth = UI_BORDER_SPACING*2 + BUTTON_HGT + math.max(
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CharacterDebug_LocalPlayer")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CharacterDebug_RemotePlayer")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CharacterDebug_Zombie")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CharacterDebug_Animal")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CharacterDebug_DeadBody")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CharacterDebug_Position")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CharacterDebug_Prediction")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CharacterDebug_State")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CharacterDebug_StateVariables")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CharacterDebug_Animation")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CharacterDebug_Variables"))
    )

    local tckTop = UI_BORDER_SPACING+1
    local tckLeft = UI_BORDER_SPACING+1
    self:setWidth(UI_BORDER_SPACING * 6 + 5 * tckWidth)
    self:setHeight(tckTop + (BUTTON_HGT+UI_BORDER_SPACING)*(self.tcks+1)+1)

    self.tickBoxLocalPlayer= ISTickBox:new(tckLeft, tckTop, tckWidth, BUTTON_HGT, getText("IGUI_CharacterDebug_LocalPlayer"), self, self.onTicked)
    self.tickBoxLocalPlayer.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxLocalPlayer:setFont(UIFont.Small)
    self:addChild(self.tickBoxLocalPlayer)
    tckLeft = tckLeft + tckWidth + UI_BORDER_SPACING

    self.tickBoxRemotePlayer = ISTickBox:new(tckLeft, tckTop, tckWidth, BUTTON_HGT, getText("IGUI_CharacterDebug_RemotePlayer"), self, self.onTicked)
    self.tickBoxRemotePlayer.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxRemotePlayer:setFont(UIFont.Small)
    self:addChild(self.tickBoxRemotePlayer)
    tckLeft = tckLeft + tckWidth + UI_BORDER_SPACING

    self.tickBoxZombie = ISTickBox:new(tckLeft, tckTop, tckWidth, BUTTON_HGT, getText("IGUI_CharacterDebug_Zombie"), self, self.onTicked)
    self.tickBoxZombie.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxZombie:setFont(UIFont.Small)
    self:addChild(self.tickBoxZombie)
    tckLeft = tckLeft + tckWidth + UI_BORDER_SPACING

    self.tickBoxAnimal = ISTickBox:new(tckLeft, tckTop, tckWidth, BUTTON_HGT, getText("IGUI_CharacterDebug_Animal"), self, self.onTicked)
    self.tickBoxAnimal.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxAnimal:setFont(UIFont.Small)
    self:addChild(self.tickBoxAnimal)
    tckLeft = tckLeft + tckWidth + UI_BORDER_SPACING

    self.tickBoxDeadBody = ISTickBox:new(tckLeft, tckTop, tckWidth, BUTTON_HGT, getText("IGUI_CharacterDebug_DeadBody"), self, self.onTicked)
    self.tickBoxDeadBody.choicesColor = {r=1, g=1, b=1, a=1}
    self.tickBoxDeadBody:setFont(UIFont.Small)
    self:addChild(self.tickBoxDeadBody)
    tckLeft = tckLeft + tckWidth + UI_BORDER_SPACING

    self.btnSave = ISButton:new((self:getWidth()-UI_BORDER_SPACING) / 2 - tckWidth, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, tckWidth, BUTTON_HGT, getText("IGUI_DebugMenu_Save"), self, ISCharacterDebugUI.onClick);
    self.btnSave.internal = "SAVE"
    self.btnSave.anchorTop = false
    self.btnSave.anchorBottom = true
    self.btnSave:initialise()
    self.btnSave:instantiate()
    self.btnSave:enableAcceptColor()
    self:addChild(self.btnSave)

    self.btnClose = ISButton:new(self.btnSave:getRight() + UI_BORDER_SPACING, self.btnSave.y, tckWidth, BUTTON_HGT, getText("IGUI_DebugMenu_Close"), self, ISCharacterDebugUI.onClick);
    self.btnClose.internal = "CLOSE"
    self.btnClose.anchorTop = false
    self.btnClose.anchorBottom = true
    self.btnClose:initialise()
    self.btnClose:instantiate()
    self.btnClose:enableCancelColor()
    self:addChild(self.btnClose)

    self.setFunctionLocalPlayer = {}
    self:addTickOptions(self.tickBoxLocalPlayer, self.setFunctionLocalPlayer, "LocalPlayer")
    self.setFunctionRemotePlayer = {}
    self:addTickOptions(self.tickBoxRemotePlayer, self.setFunctionRemotePlayer, "RemotePlayer")
    self.setFunctionZombie = {}
    self:addTickOptions(self.tickBoxZombie, self.setFunctionZombie, "Zombie")
    self.setFunctionAnimal = {}
    self:addTickOptions(self.tickBoxAnimal, self.setFunctionAnimal, "Animal")
    self.setFunctionDeadBody = {}
    self:addTickOptions(self.tickBoxDeadBody, self.setFunctionDeadBody, "DeadBody")
end

function ISCharacterDebugUI:onClick(button)
    if button.internal == "SAVE" then
        getDebugOptions():save()
    end
    if button.internal == "CLOSE" then
        getDebugOptions():save()
        self:setVisible(false)
        self:removeFromUIManager()
    end
end

function ISCharacterDebugUI:addOption(tickBox, text, selected, setFunction, tickSetFunction)
    local n = tickBox:addOption(text)
    tickBox:setSelected(n, selected)
    tickSetFunction[n] = setFunction
end

function ISCharacterDebugUI:addTickOptions(tickBox, tickSetFunction, name)
    local prefix = "Multiplayer.DebugFlags."
    self:addOption(tickBox, tickBox.name,
            getDebugOptions():getBoolean("Multiplayer.DebugFlags."..name..".Enable"),
            function(self, selected) getDebugOptions():setBoolean("Multiplayer.DebugFlags."..name..".Enable", selected); end,
            tickSetFunction);
    self:addOption(tickBox, getText("IGUI_CharacterDebug_Position"),
            getDebugOptions():getBoolean("Multiplayer.DebugFlags."..name..".Position"),
            function(self, selected) getDebugOptions():setBoolean("Multiplayer.DebugFlags."..name..".Position", selected); end,
            tickSetFunction);
    self:addOption(tickBox, getText("IGUI_CharacterDebug_Prediction"),
            getDebugOptions():getBoolean("Multiplayer.DebugFlags."..name..".Prediction"),
            function(self, selected) getDebugOptions():setBoolean("Multiplayer.DebugFlags."..name..".Prediction", selected); end,
            tickSetFunction);
    self:addOption(tickBox, getText("IGUI_CharacterDebug_State"),
            getDebugOptions():getBoolean("Multiplayer.DebugFlags."..name..".State"),
            function(self, selected) getDebugOptions():setBoolean("Multiplayer.DebugFlags."..name..".State", selected); end,
            tickSetFunction);
    self:addOption(tickBox, getText("IGUI_CharacterDebug_StateVariables"),
            getDebugOptions():getBoolean("Multiplayer.DebugFlags."..name..".StateVariables"),
            function(self, selected) getDebugOptions():setBoolean("Multiplayer.DebugFlags."..name..".StateVariables", selected); end,
            tickSetFunction);
    self:addOption(tickBox, getText("IGUI_CharacterDebug_Animation"),
            getDebugOptions():getBoolean("Multiplayer.DebugFlags."..name..".Animation"),
            function(self, selected) getDebugOptions():setBoolean("Multiplayer.DebugFlags."..name..".Animation", selected); end,
            tickSetFunction);
    self:addOption(tickBox, getText("IGUI_CharacterDebug_Variables"),
            getDebugOptions():getBoolean("Multiplayer.DebugFlags."..".Variables"),
            function(self, selected) getDebugOptions():setBoolean("Multiplayer.DebugFlags."..name..".Variables", selected); end,
            tickSetFunction);
end

function ISCharacterDebugUI:onTicked(index, selected)
    self:apply()
end

function ISCharacterDebugUI:render()
end

function ISCharacterDebugUI:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
end

function ISCharacterDebugUI:apply()
    for i=1,#self.tickBoxLocalPlayer.options do
        self.setFunctionLocalPlayer[i](self, self.tickBoxLocalPlayer:isSelected(i))
    end
    for i=1,#self.tickBoxRemotePlayer.options do
        self.setFunctionRemotePlayer[i](self, self.tickBoxRemotePlayer:isSelected(i))
    end
    for i=1,#self.tickBoxZombie.options do
        self.setFunctionZombie[i](self, self.tickBoxZombie:isSelected(i))
    end
    for i=1,#self.tickBoxAnimal.options do
        self.setFunctionAnimal[i](self, self.tickBoxAnimal:isSelected(i))
    end
    for i=1,#self.tickBoxDeadBody.options do
        self.setFunctionDeadBody[i](self, self.tickBoxDeadBody:isSelected(i))
    end
end

function ISCharacterDebugUI:new(x, y, width, height)
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
    o.player = getPlayer();
    o.moveWithMouse = true;
    ISCharacterDebugUI.instance = o;
    o.tcks = 7
    return o;
end
