--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************


require "ISUI/ISCollapsableWindow"

ISAnimDebugMonitor = ISCollapsableWindow:derive("ISAnimDebugMonitor");
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISAnimDebugMonitor.OnOpenPanel()
    if ISAnimDebugMonitor.instance==nil then
        ISAnimDebugMonitor.instance = ISAnimDebugMonitor:new (300, 100, 504+(getCore():getOptionFontSizeReal()*56), 750, getPlayer());
        ISAnimDebugMonitor.instance:initialise();
        ISAnimDebugMonitor.instance:instantiate();
    end

    ISAnimDebugMonitor.instance:addToUIManager();
    ISAnimDebugMonitor.instance:setVisible(true);


    return ISAnimDebugMonitor.instance;
end

function ISAnimDebugMonitor:initialise()
    ISCollapsableWindow.initialise(self);

    self.cGreen = { r=0,g=0.3,b=0,a=1};
    self.cRed = { r=0.3,g=0,b=0,a=1};
end


function ISAnimDebugMonitor:createChildren()
    ISCollapsableWindow.createChildren(self);

    local x, y = UI_BORDER_SPACING+1, self:titleBarHeight()+UI_BORDER_SPACING;
    local obj;

    ISDebugUtils.initHorzBars(self,x,self.width-x*2);

    --self.buttons = {"Show layers","Active nodes", "Anim tracks", "Show variables", "Show floats"};

    local widthFull = self.width-x*2
    local widthHalf = (widthFull - UI_BORDER_SPACING)/2
    local widthQuarter = (widthHalf - UI_BORDER_SPACING)/2

    local xmarg = 10;
    local bw = (self.width-(xmarg*3))/2;

    y, self.buttonToggleMonitor = ISDebugUtils.addButton(self,"toggle_monitor",x,y,widthFull,BUTTON_HGT,getText("IGUI_AnimDebugMonitor_ToggleMonitor"),ISAnimDebugMonitor.onClick);
    y = y+UI_BORDER_SPACING;

    local cacheY = y;
    y, self.buttonLayers = ISDebugUtils.addButton(self,"show_layers",x,y,widthHalf,BUTTON_HGT,getText("IGUI_AnimDebugMonitor_ShowLayers"),ISAnimDebugMonitor.onClick);
    y, self.buttonVariables = ISDebugUtils.addButton(self,"show_variables",self.buttonLayers:getRight()+UI_BORDER_SPACING,cacheY,widthHalf,BUTTON_HGT,getText("IGUI_AnimDebugMonitor_ShowVariables"),ISAnimDebugMonitor.onClick);
    y = y+UI_BORDER_SPACING;

    cacheY = y;
    y, self.buttonActiveNodes = ISDebugUtils.addButton(self,"active_nodes",x,y,widthQuarter,BUTTON_HGT,getText("IGUI_AnimDebugMonitor_ActiveNodes"),ISAnimDebugMonitor.onClick);
    y, self.buttonAnimTracks = ISDebugUtils.addButton(self,"anim_tracks",self.buttonActiveNodes:getRight()+UI_BORDER_SPACING,cacheY,widthQuarter,BUTTON_HGT,getText("IGUI_AnimDebugMonitor_AnimTracs"),ISAnimDebugMonitor.onClick);
    y, self.buttonStamps = ISDebugUtils.addButton(self,"show_ticks",self.buttonAnimTracks:getRight()+UI_BORDER_SPACING,cacheY,widthHalf,BUTTON_HGT,getText("IGUI_AnimDebugMonitor_TickStamps"),ISAnimDebugMonitor.onClick);
    y = y+UI_BORDER_SPACING;

    y = ISDebugUtils.addHorzBar(self,y)+UI_BORDER_SPACING+1;

    y, self.labelVars = ISDebugUtils.addLabel(self, "addvar_title", self.width/2, y, getText("IGUI_AnimDebugMonitor_AddVariableLabel"), UIFont.Small);
    self.labelVars.center = true;
    y = y+UI_BORDER_SPACING;

    cacheY = y;
    y, self.addVarComboType = ISDebugUtils.addComboBox(self,"addvar_type",x,y,widthHalf,UIFont.Small,nil);
    self.addVarComboType:clear();
    self.addVarComboType:addOption(getText("IGUI_DebugMenu_String"));
    self.addVarComboType:addOption(getText("IGUI_DebugMenu_Float"));
    self.addVarComboType:addOption(getText("IGUI_DebugMenu_Boolean"));
    self.addVarComboType:setHeight(BUTTON_HGT);

    y, self.addVarKeyLabel = ISDebugUtils.addLabel(self, "addvar_keylabel", self.addVarComboType:getRight()+UI_BORDER_SPACING, cacheY, getText("IGUI_AnimDebugMonitor_Key"), UIFont.Small);
    local keyLabelWid = self.addVarKeyLabel.width;
    y, self.addVarKey = ISDebugUtils.addTextEntryBox(self, "addvar_key", "", self.addVarKeyLabel:getRight()+UI_BORDER_SPACING, cacheY, widthHalf-keyLabelWid-UI_BORDER_SPACING, BUTTON_HGT);
    self.addVarKey.backgroundColor = {r=0, g=0, b=0, a=0.75};
    y = y+UI_BORDER_SPACING;

    cacheY = y;
    y, self.addVarValueLabel = ISDebugUtils.addLabel(self, "addvar_valuelabel", x, cacheY, getText("IGUI_AnimDebugMonitor_Value"), UIFont.Small);
    local valueLabelWidth = self.addVarValueLabel.width;
    y, self.addVarValue = ISDebugUtils.addTextEntryBox(self, "addvar_value", "", self.addVarValueLabel:getRight()+UI_BORDER_SPACING, cacheY, widthHalf-valueLabelWidth-UI_BORDER_SPACING, BUTTON_HGT);
    y, self.addVarAddButton = ISDebugUtils.addButton(self,"addvar_add",self.addVarValue:getRight()+UI_BORDER_SPACING,cacheY,widthHalf,BUTTON_HGT,getText("IGUI_AnimDebugMonitor_AddVariable"),ISAnimDebugMonitor.onClick);
    y = y+UI_BORDER_SPACING;

    y = ISDebugUtils.addHorzBar(self,y)+UI_BORDER_SPACING+1;

    y, self.labelVars = ISDebugUtils.addLabel(self, "varedit_title", self.width*0.5, y, getText("IGUI_AnimDebugMonitor_EditVariableLabel"), UIFont.Small);
    self.labelVars.center = true;
    y = y+UI_BORDER_SPACING;

    cacheY = y;
    y, self.comboVars = ISDebugUtils.addComboBox(self,"combo_vars",x,y,widthHalf,UIFont.Small,ISAnimDebugMonitor.onCombo);
    self.comboVars:setHeight(BUTTON_HGT)
    y, self.entryBoxValue = ISDebugUtils.addTextEntryBox(self, "entry_value", "", self.comboVars:getRight()+UI_BORDER_SPACING, cacheY, widthHalf, BUTTON_HGT); --this box is 4 pixels too big for some reason, and won't shrink further
    self.entryBoxValue.backgroundColor = {r=0, g=0, b=0, a=0.75};
    y = y+UI_BORDER_SPACING;

    cacheY = y;
    y, self.buttonClearVar = ISDebugUtils.addButton(self,"varedit_clear",x,y,widthHalf,BUTTON_HGT,getText("IGUI_AnimDebugMonitor_ClearVariable"),ISAnimDebugMonitor.onClick);
    y, self.buttonSetVar = ISDebugUtils.addButton(self,"varedit_set",self.buttonClearVar:getRight()+UI_BORDER_SPACING,cacheY,widthHalf,BUTTON_HGT,getText("IGUI_AnimDebugMonitor_SetVariable"),ISAnimDebugMonitor.onClick);
    y = y+UI_BORDER_SPACING;

    y = ISDebugUtils.addHorzBar(self,y)+UI_BORDER_SPACING+1;

    y, self.labelFloat = ISDebugUtils.addLabel(self, "float_title", self.width*0.5, y, getText("IGUI_AnimDebugMonitor_FloatVariableLabel"), UIFont.Small);
    self.labelFloat.center = true;
    y = y+UI_BORDER_SPACING;

    y, self.comboFloats = ISDebugUtils.addComboBox(self,"combo_floats",x,y,widthFull,UIFont.Small,ISAnimDebugMonitor.onCombo);
    self.comboFloats:addOption("- NONE -");
    self.comboFloats.selected = 1;
    self.comboFloats:setHeight(BUTTON_HGT)
    y = y+UI_BORDER_SPACING;

    y, self.labelFloatInfo = ISDebugUtils.addLabel(self, "float_info", self.width*0.5, y, getText("IGUI_AnimDebugMonitor_SelectedFloat", getText("IGUI_None"), -1.0, 1.0), UIFont.Small);
    self.labelFloatInfo.center = true;
    y = y+UI_BORDER_SPACING;

    self.floatPlotter = FloatArrayPlotter:new(x,y,widthFull,BUTTON_HGT*2+UI_BORDER_SPACING);
    self.floatPlotter:initialise();

    self.floatPlotter:setHorzLine(0.125,{r=0.05, g=0.05, b=0.05, a=1});
    self.floatPlotter:setHorzLine(0.25,{r=0.1, g=0.1, b=0.1, a=1});
    --self.charts[i]:setHorzLine(0.30,{r=0.1, g=0.1, b=0.1, a=1});
    self.floatPlotter:setHorzLine(0.375,{r=0.05, g=0.05, b=0.05, a=1});
    self.floatPlotter:setHorzLine(0.50,{r=0.2, g=0.2, b=0.2, a=1});
    --self.charts[i]:setHorzLine(0.60,{r=0.1, g=0.1, b=0.1, a=1});
    self.floatPlotter:setHorzLine(0.625,{r=0.05, g=0.05, b=0.05, a=1});
    self.floatPlotter:setHorzLine(0.75,{r=0.1, g=0.1, b=0.1, a=1});
    --self.charts[i]:setHorzLine(0.80,{r=0.1, g=0.1, b=0.1, a=1});
    self.floatPlotter:setHorzLine(0.875,{r=0.05, g=0.05, b=0.05, a=1});
    self:addChild(self.floatPlotter);

    y = self.floatPlotter:getY() + self.floatPlotter:getHeight();

    y = ISDebugUtils.addHorzBar(self,y+UI_BORDER_SPACING)+UI_BORDER_SPACING+1;

    local h = BUTTON_HGT*6;
    --[[
    self.subPanel = ISAnimLoggerOutput:new(10, y, self.width-20, h);
    self.subPanel:initialise();
    self.subPanel:instantiate();
    self.subPanel:setAnchorRight(true);
    self.subPanel:setAnchorLeft(true);
    self.subPanel:setAnchorTop(true);
    self.subPanel:setAnchorBottom(true);
    self.subPanel.moveWithMouse = true;
    self.subPanel.doStencilRender = true;
    self.subPanel:addScrollBars();
    self.subPanel.vscroll:setVisible(true);
    self:addChild(self.subPanel);
    self.subPanel:setScrollChildren(true);
    self.subPanel.onMouseWheel = ISDebugUtils.onMouseWheel;
    --]]

    self.richtext = ISRichTextPanel:new(x, y, widthFull, h);
    self.richtext:initialise();

    self:addChild(self.richtext);

    self.richtext.backgroundColor = {r=0, g=0, b=0, a=1};
    --self.richtext.background = false;
    self.richtext.autosetheight = false;
    self.richtext.clip = true
    self.richtext:addScrollBars();

    self.clearText = getText("IGUI_AnimDebugMonitor_NoMonitor");
    self.richtext.text = self.clearText;
    self.richtext:paginate();

    y = y+h+UI_BORDER_SPACING+1;
    self:setHeight(y)
    --self:setHeight(y);

    self:toggleEditEnabled(false);

    self.buttonToggleMonitor:enableCancelColor()

    self.init = false;
    self.selectedVar = false;
end

function ISAnimDebugMonitor:scrollToBottom()
    local yscroll = -(self.richtext:getScrollHeight() - (self.richtext:getScrollAreaHeight()));
    self.richtext:setYScroll( yscroll );
end

function ISAnimDebugMonitor:clearLog()
    self.richtext.text = self.clearText;
    self.richtext:paginate();
    self:scrollToBottom();
end

function ISAnimDebugMonitor:toggleEditEnabled(_b)
    self.editEnabled = _b;
    self.buttonLayers:setEnable(_b);
    self.buttonActiveNodes:setEnable(_b);
    self.buttonAnimTracks:setEnable(_b);
    self.buttonVariables:setEnable(_b);
    self.buttonStamps:setEnable(_b);

    self.entryBoxValue:setText("");
    self.entryBoxValue:setEditable(_b);
    self.buttonClearVar:setEnable(_b);
    self.buttonSetVar:setEnable(_b);
    --self.comboVars.selected = 1;
    --self.comboFloats.selected = 1;
    if _b then
        self:colorButtons()
    end
end

function ISAnimDebugMonitor:onClick(_button)
    if self.buttonToggleMonitor==_button then
        local char = getPlayer();
        local smallestDist = 100000;
    --  for x=-5,5 do
      --      for y=-5,5 do
        --        local sq = getCell():getGridSquare(char:getX() + x,char:getY() + y,char:getZ());
          --      for i=0,sq:getMovingObjects():size()-1 do
            --        local moving = sq:getMovingObjects():get(i);
              --      if instanceof(moving, "IsoZombie") then
--
  --                      local dist = char:DistTo(getPlayer());
--
  --                      if(dist < smallestDist) then
    --                        char = moving;
      --                      smallestDist = dist;
        --                end
--
  --                  end
    --            end
      --          if instanceof(char, "IsoZombie") then break; end
        --    end
          --  if instanceof(char, "IsoZombie") then break; end
        --end

        self.monitor = char:getDebugMonitor();
        if self.monitor then
            self.monitor = nil;
            self.buttonToggleMonitor:enableCancelColor();

            self:toggleEditEnabled(false);

            --self.subPanel:clear();
            self:clearLog();
            self.floatPlotter:setData(nil);
        else
            self.monitor = AnimatorDebugMonitor.new(char);
            self.buttonToggleMonitor:enableAcceptColor();

            self:toggleEditEnabled(true);
        end
        char:setDebugMonitor(self.monitor);
        --self.subPanel:setMonitor(self.monitor);
        return;
    elseif self.buttonClearVar==_button then
        local sel = self.comboVars.options[self.comboVars.selected];
        local char = getPlayer();
        if sel then
            char:ClearVariable(sel);
            self.entryBoxValue:setText("");
        end
    elseif self.buttonSetVar==_button then
        local sel = self.comboVars.options[self.comboVars.selected];
        local val = self.entryBoxValue:getText();
        local char = getPlayer();
        if sel and val then
            char:SetVariable(sel, val);
        end
    end

    local monitor = self.monitor;
    if monitor then
        if self.buttonLayers==_button then
            local index = 1;
            local val = not monitor:getFilter(index);
            monitor:setFilter(index,val);
            if not val then
                self.oldNodesVal = {monitor:getFilter(2)};
                monitor:setFilter(2,val);
                self.oldTracksVal = {monitor:getFilter(3)};
                monitor:setFilter(3,val);
                self.buttonActiveNodes:setEnable(false);
                self.buttonAnimTracks:setEnable(false);
            else
                self.buttonActiveNodes:setEnable(true);
                self.buttonAnimTracks:setEnable(true);
                if self.oldNodesVal then monitor:setFilter(2,self.oldNodesVal[1]); end
                if self.oldTracksVal then monitor:setFilter(3,self.oldTracksVal[1]); end
            end
        elseif self.buttonActiveNodes==_button then
            local index = 2;
            local val = not monitor:getFilter(index);
            monitor:setFilter(index,val);
        elseif self.buttonAnimTracks==_button then
            local index = 3;
            local val = not monitor:getFilter(index);
            monitor:setFilter(index,val);
        elseif self.buttonVariables==_button then
            local index = 4;
            local val = not monitor:getFilter(index);
            monitor:setFilter(index,val);
        elseif self.buttonStamps==_button then
            monitor:setDoTickStamps(not monitor:isDoTickStamps());
        elseif self.addVarAddButton==_button then
            addVariableToSyncList(self.addVarKey:getText());
            if self.addVarComboType.selected == 1 then -- String
                getPlayer():setVariable(self.addVarKey:getText(), self.addVarValue:getText());
            end
            if self.addVarComboType.selected == 2 then -- Float
                getPlayer():setVariable(self.addVarKey:getText(), tonumber(self.addVarValue:getText()));
            end
            if self.addVarComboType.selected == 3 then -- Boolean
                getPlayer():setVariable(self.addVarKey:getText(), (self.addVarValue:getText()=="true") or (self.addVarValue:getText()=="True") or (self.addVarValue:getText()=="TRUE") or (self.addVarValue:getText()=="1"));
            end
        end
    end
end

function ISAnimDebugMonitor:onCombo(_combo)
    if not self.editEnabled then return; end
    if self.comboFloats == _combo then
        local sel = _combo.options[_combo.selected];
        --print("combo selected "..tostring(sel))
        if sel and sel~="- NONE -" and self.monitor then
            self.monitor:setSelectedVariable(sel);
            self.selectedVar = sel;
        else
            self.selectedVar = false;
        end
    elseif self.comboVars == _combo then
        local sel = _combo.options[_combo.selected];
        if not sel then return; end
        local char = getPlayer();
        local val = char:getVariableString(sel);
        if val then
            self.entryBoxValue:setText(val);
        end
    end
end

function ISAnimDebugMonitor:onResize()
    ISUIElement.onResize(self);
    local th = self:titleBarHeight();
end

function ISAnimDebugMonitor:update()
    ISCollapsableWindow.update(self);

    if not self.editEnabled then
        self.comboVars.selected = 1;
        self.comboFloats.selected = 1;
    end

    if self.monitor then
        if self.monitor:IsDirty() then
            self.richtext.text = self.monitor:getLogString();
            self.richtext:paginate();
            self:scrollToBottom();
        end

        self:colorButtons()

        if self.monitor:IsDirtyFloatList() or (not self.init) then
            local sel = self.comboFloats.options[self.comboFloats.selected];

            self.comboFloats:clear();
            local list = self.monitor:getFloatNames();
            self.comboFloats:addOption("- NONE -");
            local newindex = 1;
            for i =0,list:size()-1 do
                local name = list:get(i);
                self.comboFloats:addOption(name);
                if sel and sel==name then
                    newindex = i+2;
                end
            end
            self.comboFloats.selected = newindex;
        end

        if AnimatorDebugMonitor:isKnownVarsDirty() or (not self.init) then
            local sel = self.comboVars.options[self.comboVars.selected];

            self.comboVars:clear();
            local list = AnimatorDebugMonitor:getKnownVariables();

            local newindex = 0;
            for i =0,list:size()-1 do
                local name = list:get(i);
                self.comboVars:addOption(name);
                if sel and sel==name then
                    newindex = i+1;
                end
            end
            self.comboVars.selected = newindex;
        end

        local floats = false;
        if self.selectedVar then
            local v = self.selectedVar;
            if self.monitor:getSelectedVariable() and self.monitor:getSelectedVariable()==v then
                local min = self.monitor:getSelectedVarMinFloat();
                local max = self.monitor:getSelectedVarMaxFloat();
                local cur = self.monitor:getSelectedVariableFloat();
                min = ISDebugUtils.roundNum(min,5);
                max = ISDebugUtils.roundNum(max,5);
                cur = ISDebugUtils.roundNum(cur,5);
                self.labelFloatInfo.name = getText("IGUI_AnimDebugMonitor_SelectedFloat", v.." = "..tostring(cur), min, max);
                floats = self.monitor:getSelectedVarFloatList();
            else
                self.selectedVar = false;
            end
        end

        if not self.selectedVar then
            self.labelFloatInfo.name = getText("IGUI_AnimDebugMonitor_SelectedFloat", getText("IGUI_None"), -1.0, 1.0);
        end

        self.floatPlotter:setData(floats);

        self.init = true;
    end
end

function ISAnimDebugMonitor:colorButtons()
    self.buttonLayers:toggleAcceptCancel(self.monitor:getFilter(1))
    self.buttonActiveNodes:toggleAcceptCancel(self.monitor:getFilter(2))
    self.buttonAnimTracks:toggleAcceptCancel(self.monitor:getFilter(3))
    self.buttonVariables:toggleAcceptCancel(self.monitor:getFilter(4))
    self.buttonStamps:toggleAcceptCancel(self.monitor:isDoTickStamps())
end

function ISAnimDebugMonitor:prerender()
    self:stayOnSplitScreen();
    ISCollapsableWindow.prerender(self);

    ISDebugUtils.renderHorzBars(self);
end

function ISAnimDebugMonitor:stayOnSplitScreen()
    ISUIElement.stayOnSplitScreen(self, self.playerNum)
end


function ISAnimDebugMonitor:render()
    ISCollapsableWindow.render(self);
end


function ISAnimDebugMonitor:close()
    ISCollapsableWindow.close(self)
    if JoypadState.players[self.playerNum+1] then
        setJoypadFocus(self.playerNum, nil)
    end
    self:removeFromUIManager();
    self:clear();
end

function ISAnimDebugMonitor:clear()
end



function ISAnimDebugMonitor:new (x, y, width, height, player)
    local o = {}
    --o.data = {}
    o = ISCollapsableWindow:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.6};
    o.greyCol = { r=0.4,g=0.4,b=0.4,a=1};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.pin = true;
    o.isCollapsed = false;
    o.collapseCounter = 0;
    o.title = getText("IGUI_AnimDebugMonitor_Title");
    o.resizable = false;
    o.drawFrame = true;

    o.currentTile = nil;
    o.richtext = nil;
    o.overrideBPrompt = true;
    o.subFocus = nil;
    o.hotKeyPanels = {};
    o.isJoypadWindow = false;
    ISDebugMenu.RegisterClass(self);
    return o
end

--[[
if enabled then
    Events.OnCustomUIKey.Add(ISAnimDebugMonitor.OnKeyDown);
    Events.OnKeyKeepPressed.Add(ISAnimDebugMonitor.OnKeepKeyDown);
    Events.OnClimateTickDebug.Add(ISAnimDebugMonitor.OnClimateTickDebug);
    Events.OnThunderEvent.Add(ISAnimDebugMonitor.OnThunderEvent);
    --Events.OnObjectLeftMouseButtonUp.Add(ISAnimDebugMonitor.onMouseButtonUp);
end--]]
