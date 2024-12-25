--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISScriptsDebugWindow = ISCollapsableWindow:derive("ISScriptsDebugWindow");
ISScriptsDebugWindow.coords = false;

function ISScriptsDebugWindow.OnOpenPanel(_player)
    if ISScriptsDebugWindow.instance then
        return ISScriptsDebugWindow.instance;
    end
    local x, y, w, h = 200, 100, 640, 480;
    if ISScriptsDebugWindow.coords then
        x, y, w, h = unpack(ISScriptsDebugWindow.coords);
    end
    _player = _player or getPlayer(0);
    local ui = ISScriptsDebugWindow:new(x, y, w, h, _player);
    ui:initialise();
    ui:instantiate();
    ui:setVisible(true);
    ui:addToUIManager();
    ISScriptsDebugWindow.instance = ui;
end

function ISScriptsDebugWindow:initialise()
	ISCollapsableWindow.initialise(self);
end


function ISScriptsDebugWindow:createChildren()
    ISCollapsableWindow.createChildren(self);

    self.th = self:titleBarHeight();
    local rh = self.resizable and self:resizeWidgetHeight() or 0;
    self.rh = rh;

    self.minimumWidth = 640+(getCore():getOptionFontSizeReal()*100);
    self.minimumHeight = 480+(getCore():getOptionFontSizeReal()*100);
    self.width = math.max(self.width, self.minimumWidth); --self.minimumWidth;
    self.height = math.max(self.height, self.minimumHeight); -- self.minimumHeight;

    self.heightMod = self.th+rh;

    local LEFT_BAR_WIDTH = 100+(getCore():getOptionFontSizeReal()*50);

    local x,y = UI_BORDER_SPACING+1, self.th+UI_BORDER_SPACING+1;

    self.listLabel = ISLabel:new(x, y, FONT_HGT_SMALL, getText("IGUI_ScriptManager_ScriptTypes"), 1, 1, 1, 1.0, UIFont.Small, true);
    self.listLabel:initialise();
    self.listLabel:instantiate();
    self:addChild(self.listLabel);

    y = self:incY(y, self.listLabel, UI_BORDER_SPACING);

    self.comboBox = ISComboBox:new (x, y, LEFT_BAR_WIDTH, BUTTON_HGT, self, ISScriptsDebugWindow.comboChange)
    self.comboBox:initialise();
    self.comboBox:instantiate();
    --self:addChild(self.comboBox);

    local enums = ScriptType.GetEnumListLua();
    for i=0,enums:size()-1 do
        local title = enums:get(i):getScriptTag();
        if enums:get(i):isTemplate() then
            title = "[TEMPLATE] "..title;
        end
        self.comboBox:addOptionWithData(title, enums:get(i));
    end

    self.hackPane = ISPanel:new(self.comboBox:getX(), self.comboBox:getY(), self.comboBox:getWidth(), self.comboBox:getHeight());
	self.hackPane.background = true;
	self.hackPane.backgroundColor = {r=0, g=0, b=0, a=1.0};
    self.hackPane.borderColor = {r=0.0, g=0.0, b=0.0, a=1};
    self.hackPane:initialise();
    self.hackPane:instantiate();

    y = self:incY(y, self.comboBox, UI_BORDER_SPACING);

    self.listLabel = ISLabel:new(x, y, BUTTON_HGT, getText("IGUI_DebugMenu_Search"), 1, 1, 1, 1.0, UIFont.Small, true);
    self.listLabel:initialise();
    self.listLabel:instantiate();
    self:addChild(self.listLabel);

    self.labelWidth = getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Search")) + UI_BORDER_SPACING;

    self.entryBox = ISTextEntryBox:new("", x+self.labelWidth, y, LEFT_BAR_WIDTH-self.labelWidth, BUTTON_HGT);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onTextChange = ISScriptsDebugWindow.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self:addChild(self.entryBox);

    y = self:incY(y, self.entryBox, UI_BORDER_SPACING);

    self.list = ISScrollingListBox:new(x, y, LEFT_BAR_WIDTH, self.height - y - rh - UI_BORDER_SPACING*2-2);
    self.list.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.list:initialise();
    self.list:instantiate();
    self.list.itemheight = BUTTON_HGT*2;
    self.list.selected = 0;
    --self.infoList.joypadParent = self;
    self.list.font = UIFont.Small;
    self.list.doDrawItem = ISScriptsDebugWindow.drawScriptListItem;
    self.list.target = self;
    --self.list.onmousedblclick = ISStationRecipeList.onItemDoubleClick;
    self.list.onmousedown = ISScriptsDebugWindow.onScriptListSelected;
    --self.list.onMouseDown = ISStationRecipeList.onMouseDownRecipeItem;
    --self.list.onMouseDoubleClick = ISStationRecipeList.onMouseDoubleClickRecipeItem;
    self.list.drawBorder = true;
    self:addChild(self.list);

    -- RESET X Y
    y = self.comboBox:getY();
    x = self.list:getX() + self.list:getWidth() + UI_BORDER_SPACING;

    local midWidth = self.width - x - UI_BORDER_SPACING;

    self.reloadButton = ISButton:new(x, y, midWidth,BUTTON_HGT,"Reload All Scripts of ScriptType",self, ISScriptsDebugWindow.onButtonClick);
    self.reloadButton:initialise();
    self.reloadButton:instantiate();
    self.reloadButton.enable = true;
    self:addChild(self.reloadButton);

    y = self:incY(y, self.reloadButton, UI_BORDER_SPACING);

    self.scriptLabel = ISLabel:new(x, y, FONT_HGT_MEDIUM, "ScriptTitle", 1, 1, 1, 1.0, UIFont.Medium, true);
    self.scriptLabel:initialise();
    self.scriptLabel:instantiate();
    self:addChild(self.scriptLabel);

    y = self:incY(y, self.scriptLabel, 2);

    self.subLabel = ISLabel:new(x, y, FONT_HGT_SMALL, "SubTitle", 1, 1, 1, 1.0, UIFont.Small, true);
    self.subLabel:initialise();
    self.subLabel:instantiate();
    self:addChild(self.subLabel);

    y = self:incY(y, self.subLabel, UI_BORDER_SPACING);

    local height = self.height - y - UI_BORDER_SPACING - rh - 1;

    self.scriptPanel = ISScriptViewPanel:new(x, y, midWidth, height)
    self.scriptPanel:initialise();
    self.scriptPanel:instantiate();
    self:addChild(self.scriptPanel);

    self:addChild(self.hackPane);
    self:addChild(self.comboBox);

    self:setWidth(self.width);
    self:setHeight(self.height);

    self:populate();
end

function ISScriptsDebugWindow:onResize(_width, _height)
    ISCollapsableWindow.onResize(self, _width, _height);

    self.list:setHeight(self.height - self.list:getY() - UI_BORDER_SPACING - self.rh - 1);

    local x = self.list:getX() + self.list:getWidth() + UI_BORDER_SPACING;
    local midWidth = self.width - x - UI_BORDER_SPACING - 1;

    self.reloadButton:setWidth(midWidth);
    self.scriptPanel:setWidth(midWidth);
    self.scriptPanel:setHeight(self.height - self.scriptPanel:getY() - UI_BORDER_SPACING - self.rh - 1);
end

function ISScriptsDebugWindow:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISScriptsDebugWindow.onTextChange(box)
    if not box then
        return;
    end
    if box:getInternalText()~=box.target.searchText then
        box.target.searchText = box:getInternalText();
        box.target:populate();
    end
end

function ISScriptsDebugWindow:comboChange(_combo, _arg1, _arg2)
    self:populate();
end

function ISScriptsDebugWindow:onButtonClick(_button)
    if _button==self.reloadButton then
        local scriptType = self.comboBox:getOptionData(self.comboBox.selected)
        if not scriptType then
            return;
        end
        reloadScripts(scriptType);
        self.selectedScriptItem = false;

        self:populate();
    end
end

local sortScripts = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
end

function ISScriptsDebugWindow:populate()
    self.list:clear();

    local needle = self.searchText;
    if (not self.searchText) or self.searchText=="" then
        needle = false;
    end

    local scriptType = self.comboBox:getOptionData(self.comboBox.selected)
    local typeStr = scriptType and scriptType:getScriptTag() or "unknown";
    self.reloadButton:setTitle(getText("IGUI_ScriptManager_ReloadScripts", tostring(typeStr)));
    local scripts = ScriptManager.instance:getScriptsForType(scriptType);
    local temp = {};
    local scriptWarn = false;
    for i=0,scripts:size()-1 do
        local script = scripts:get(i);
        local found = true;
        if needle then
            found = string.find( string.lower(script:getScriptObjectFullType()), string.lower(self.searchText) ) and true or false;
            if not found then
                found = string.find( string.lower(script:getScriptObjectName()), string.lower(self.searchText) ) and true or false;
            end
        end
        if found and script then
            local t = {
                script = script,
                fulltype = script:getScriptObjectFullType(),
                name = script:getScriptObjectName(),
            }
            table.insert(temp, t);
        end
        if not script then
            scriptWarn = true;
        end
    end
    if scriptWarn then
        print("WARNING -> Some scripts were 'nil', are they exposed in LuaManager? scriptType = "..tostring(scriptType));
    end

    table.sort(temp, sortScripts)

    for _,item in ipairs(temp) do
        self.list:addItem(item.name, item);
    end

    if self.list.items and #self.list.items>0 then
        --print("SELECTING ELEMENT")
        self.list.selected = 1;
        self:onScriptListSelected(self.list.items[self.list.selected].item);
    end
end

function ISScriptsDebugWindow:drawScriptListItem(y, item, alt)
    local a = 1.0;

    self:drawRectBorder( 1, y+1, self:getWidth()-2, self.itemheight - 2, 0.2, 1.0, 1.0, 1.0)
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);
    end


    if item.item.name then
        local drawY = y + (self.itemheight/4) - (FONT_HGT_SMALL/2) + 2;
        --local c = item.item.color;
        self:drawText( item.item.name, 5, drawY, 1, 1, 1, 1.0, self.font);
    end
    if item.item.fulltype then
        local drawY = y + ((self.itemheight/4)*3) - (FONT_HGT_SMALL/2) - 1;
        self:drawText( item.item.fulltype, 5, drawY, 0.4, 0.4, 0.4, 1.0, self.font);
    end

    return y + self.itemheight;
end

function ISScriptsDebugWindow:onScriptListSelected(_item)
    self.selectedScriptItem = _item;

    if self.selectedScriptItem then
        self.scriptLabel:setName(_item.name);
        self.subLabel:setName(_item.fulltype);
    else
        self.scriptLabel:setName("Void");
        self.subLabel:setName("Base.Void");
    end
    self.scriptPanel:setScript(_item.script);
end

function ISScriptsDebugWindow:prerender()
    ISCollapsableWindow.prerender(self);

    if self.comboBox:getOptionData(self.comboBox.selected) then
        self.reloadButton.enable = true;
    end
end


function ISScriptsDebugWindow:render()
    ISCollapsableWindow.render(self)
end

function ISScriptsDebugWindow:close()
    ISCollapsableWindow.close(self);
    if JoypadState.players[self.playerNum+1] then
        if getFocusForPlayer(self.playerNum)==self then
            setJoypadFocus(self.playerNum, nil);
        end
    end
    ISScriptsDebugWindow.coords = { self:getX(), self:getY(), self:getWidth(), self:getHeight() }
    self:removeFromUIManager();
    ISScriptsDebugWindow.instance = nil;
end

function ISScriptsDebugWindow:new (x, y, width, height, player)
	local o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.title = getText("IGUI_DebugMenu_Main_Scripts");
    o.searchText = "";
    ISDebugMenu.RegisterClass(self);
	return o
end