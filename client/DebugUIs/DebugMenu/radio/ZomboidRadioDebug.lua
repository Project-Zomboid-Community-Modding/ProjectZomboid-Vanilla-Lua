--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ZomboidRadioDebug = ISPanel:derive("ZomboidRadioDebug");
ZomboidRadioDebug.instance = nil;
local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

local function roundstring(_val)
    return tostring(ISDebugUtils.roundNum(_val,2));
end

function ZomboidRadioDebug.OnOpenPanel()
    if isClient() then
        return;
    end
    if ZomboidRadioDebug.instance==nil then
        ZomboidRadioDebug.instance = ZomboidRadioDebug:new (100, 100, 1000+(getCore():getOptionFontSizeReal()*150), 600, getText("IGUI_ZomboidRadio_Title"));
        ZomboidRadioDebug.instance:initialise();
        ZomboidRadioDebug.instance:instantiate();
    end

    ZomboidRadioDebug.instance:addToUIManager();
    ZomboidRadioDebug.instance:setVisible(true);

    return ZomboidRadioDebug.instance;
end

function ZomboidRadioDebug:initialise()
    ISPanel.initialise(self);

    self.radio = getZomboidRadio();
    self.scriptManager = self.radio:getScriptManager();
end

function ZomboidRadioDebug:createChildren()
    ISPanel.createChildren(self);

    ISDebugUtils.addLabel(self, {}, UI_BORDER_SPACING+1, UI_BORDER_SPACING+1, getText("IGUI_ZomboidRadio_Title"), UIFont.Medium, true)
    local top = FONT_HGT_MEDIUM+UI_BORDER_SPACING*2+1

    self.channelsList = ISScrollingListBox:new(UI_BORDER_SPACING+1, top, 150+(getCore():getOptionFontSizeReal()*50), self.height-top-UI_BORDER_SPACING*2-BUTTON_HGT-1);
    self.channelsList:initialise();
    self.channelsList:instantiate();
    self.channelsList.itemheight = BUTTON_HGT;
    self.channelsList.selected = 0;
    self.channelsList.joypadParent = self;
    self.channelsList.font = UIFont.NewSmall;
    self.channelsList.doDrawItem = self.drawChannelList;
    self.channelsList.drawBorder = true;
    self.channelsList.onmousedown = ZomboidRadioDebug.OnDaysListMouseDown;
    self.channelsList.target = self;
    self:addChild(self.channelsList);

    self.infoList = ISScrollingListBox:new(self.channelsList:getRight()+UI_BORDER_SPACING, self.channelsList.y, 300+(getCore():getOptionFontSizeReal()*10), self.channelsList.height);
    self.infoList:initialise();
    self.infoList:instantiate();
    self.infoList.itemheight = BUTTON_HGT;
    self.infoList.selected = 0;
    self.infoList.joypadParent = self;
    self.infoList.font = UIFont.NewSmall;
    self.infoList.doDrawItem = self.drawInfoList;
    self.infoList.drawBorder = true;
    self:addChild(self.infoList);

    self.broadcastList = ISScrollingListBox:new(self.infoList:getRight()+UI_BORDER_SPACING, self.channelsList.y, self.width - self.infoList:getRight()-UI_BORDER_SPACING*2-1, self.channelsList.height);
    self.broadcastList:initialise();
    self.broadcastList:instantiate();
    self.broadcastList.itemheight = BUTTON_HGT;
    self.broadcastList.selected = 0;
    self.broadcastList.joypadParent = self;
    self.broadcastList.font = UIFont.NewSmall;
    self.broadcastList.doDrawItem = self.drawBroadcastList;
    self.broadcastList.drawBorder = true;
    self:addChild(self.broadcastList);

    --[[
    self.infoList = ISScrollingListBox:new(220, 50, 400, self.height - 100);
    self.infoList:initialise();
    self.infoList:instantiate();
    self.infoList.itemheight = 22;
    self.infoList.selected = 0;
    self.infoList.joypadParent = self;
    self.infoList.font = UIFont.NewSmall;
    self.infoList.doDrawItem = self.drawInfoList;
    self.infoList.drawBorder = true;
    self:addChild(self.infoList);
    --]]

    local btnY, btnWidth = self.broadcastList:getBottom() + UI_BORDER_SPACING, 180
    local _, obj = ISDebugUtils.addButton(self,"script",self.infoList.x,btnY,self.infoList.width,BUTTON_HGT,getText("IGUI_ZomboidRadio_ViewChannelScript"),ZomboidRadioDebug.onViewScript);
    _, obj = ISDebugUtils.addButton(self,"close",self.width-btnWidth-UI_BORDER_SPACING-1,btnY,btnWidth,BUTTON_HGT,getText("IGUI_DebugMenu_Close"),ZomboidRadioDebug.onClickClose);
    obj:enableCancelColor()
    _, obj = ISDebugUtils.addButton(self,"refresh",obj.x-btnWidth-UI_BORDER_SPACING,btnY,btnWidth,BUTTON_HGT,getText("IGUI_DebugMenu_Refresh"),ZomboidRadioDebug.onClickRefresh);

    self:populateList();
end

function ZomboidRadioDebug:onClickClose()
    self:close();
end

function ZomboidRadioDebug:onClickRefresh()
    self:populateList(true);
end

function ZomboidRadioDebug:onViewScript()
    if self.currentChannel then
        RadioScriptDebugger.OnOpenPanel(self.currentChannel);
    end
end

function ZomboidRadioDebug:OnDaysListMouseDown(item)
    self:populateInfoList(item);
    self:populateBroadcastList(item);
end

function ZomboidRadioDebug:populateList(_force)
    local channels = self.scriptManager:getChannelsList();

    if (not _force) and self.channelsSize and self.channelsSize==channels:size() then
        return
    end

    self.channelsList:clear();

    for i=0, channels:size()-1 do
        local channel = channels:get(i);

        local prefix = channel:GetFrequency();
        local name = channel:GetName(); -- prefix .. " : " .. channel:GetName();

        self.channelsList:addItem(name, channel);
    end

    self.channelsSize = channels:size();

    self:populateInfoList(channels:get(0));
    self:populateBroadcastList(channels:get(0));
end

function ZomboidRadioDebug:drawChannelList(y, item, alt)
    local a = 0.9;

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    --[[if item.item:getIndexOffset()<0 then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 0.80, 0.80, 0.80);
    end--]]

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    self:drawText( item.text, 10, y + 2, 1, 1, 1, a, self.font);

    return y + self.itemheight;
end

function ZomboidRadioDebug:populateInfoList(_radioChannel)
    self.infoList:clear();

    self.currentChannel = _radioChannel;
    self.infoList:addItem(_radioChannel:GetName(), nil);
    self.infoList:addItem(getText("IGUI_ZomboidRadio_GUID")..": "..tostring(_radioChannel:getGUID()), nil);
    self.infoList:addItem(getText("IGUI_ZomboidRadio_Frequency")..": "..tostring(_radioChannel:GetFrequency()), nil);
    self.infoList:addItem(getText("IGUI_ZomboidRadio_IsTV")..": "..tostring(_radioChannel:IsTv()), nil);
    self.infoList:addItem(getText("IGUI_ZomboidRadio_Category")..": "..tostring(_radioChannel:GetCategory()), nil);
    self.infoList:addItem(getText("IGUI_ZomboidRadio_PlayerListening")..": "..tostring(_radioChannel:GetPlayerIsListening()), nil);
    self.infoList:addItem(getText("IGUI_ZomboidRadio_HasActiveScript")..": "..tostring(_radioChannel:getCurrentScript()~=nil), nil);
    self.infoList:addItem(getText("IGUI_ZomboidRadio_HasActiveBroadcast")..": "..tostring(_radioChannel:getAiringBroadcast()~=nil), nil);
    self.infoList:addItem(getText("IGUI_ZomboidRadio_CurrentScriptLoop")..": "..tostring(_radioChannel:getCurrentScriptLoop()), nil);
    self.infoList:addItem(getText("IGUI_ZomboidRadio_MaxLoops")..": "..tostring(_radioChannel:getCurrentScriptMaxLoops()), nil);
end

function ZomboidRadioDebug:drawInfoList(y, item, alt)
    local a = 0.9;

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    self:drawText( item.text, 10, y + 2, 1, 1, 1, a, self.font);

    return y + self.itemheight;
end

function ZomboidRadioDebug:populateBroadcastList(_radioChannel)
    self.broadcastList:clear();

    local bc = _radioChannel:getAiringBroadcast();

    if not bc then
        local script = _radioChannel:getCurrentScript();
        if script then
            bc = script:getValidAirBroadcastDebug();
        end
    end

    if bc then
        local lines = bc:getLines();
        for i=0, lines:size()-1 do
            self.broadcastList:addItem(lines:get(i):getText(), lines:get(i));
        end
    end
end

function ZomboidRadioDebug:drawBroadcastList(y, item, alt)
    local a = 0.9;

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    self:drawText( item.text, 10, y + 2, item.item:getR(), item.item:getG(), item.item:getB(), a, self.font);

    return y + self.itemheight;
end


function ZomboidRadioDebug:prerender()
    ISPanel.prerender(self);
    self:populateList();
end

function ZomboidRadioDebug:update()
    ISPanel.update(self);
end

function ZomboidRadioDebug:close()
    self:setVisible(false);
    self:removeFromUIManager();
    ZomboidRadioDebug.instance = nil
end

function ZomboidRadioDebug:new(x, y, width, height, title)
    local o = {};
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = true;
    o.panelTitle = title;
    ISDebugMenu.RegisterClass(self);
    return o;
end




