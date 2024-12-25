--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISEntityScriptsPanel = ISPanel:derive("ISEntityScriptsPanel");

function ISEntityScriptsPanel:initialise()
	ISPanel.initialise(self);
end


function ISEntityScriptsPanel:createChildren()
    ISPanel.createChildren(self);

    local x,y = UI_BORDER_SPACING+1, UI_BORDER_SPACING+1;

    local LEFT_BAR_WIDTH = 100+(getCore():getOptionFontSizeReal()*50);

    self.listLabel = ISLabel:new(x, y, BUTTON_HGT, getText("IGUI_DebugMenu_Search"), 1, 1, 1, 1.0, UIFont.Small, true);
    self.listLabel:initialise();
    self.listLabel:instantiate();
    self:addChild(self.listLabel);

    self.entryBox = ISTextEntryBox:new("", x+self.listLabel.width+UI_BORDER_SPACING, y, LEFT_BAR_WIDTH-self.listLabel.width-UI_BORDER_SPACING, BUTTON_HGT);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onTextChange = ISEntityScriptsPanel.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self:addChild(self.entryBox);

    y = self.entryBox:getBottom()+UI_BORDER_SPACING;

    self.list = ISScrollingListBox:new(UI_BORDER_SPACING+1, y, LEFT_BAR_WIDTH, self.height - y - UI_BORDER_SPACING*2-2);
    self.list.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.list:initialise();
    self.list:instantiate();
    self.list.itemheight = BUTTON_HGT*2;
    self.list.selected = 0;
    self.list.font = UIFont.Small;
    self.list.doDrawItem = ISEntityScriptsPanel.drawEntityListItem;
    self.list.target = self;
    self.list.onmousedown = ISEntityScriptsPanel.onEntityListSelected;
    self.list.drawBorder = true;
    self:addChild(self.list);

    y = self.listLabel:getY();
    x = self.list:getX() + self.list:getWidth() + UI_BORDER_SPACING;

    local midWidth = self.width - x - UI_BORDER_SPACING;

    self.scriptLabel = ISLabel:new(x, y, FONT_HGT_MEDIUM, getText("IGUI_Entities_ViewPanel_ScriptTitle"), 1, 1, 1, 1.0, UIFont.Medium, true);
    self.scriptLabel:initialise();
    self.scriptLabel:instantiate();
    self:addChild(self.scriptLabel);

    y = self:incY(y, self.scriptLabel, 2);

    self.subLabel = ISLabel:new(x, y, FONT_HGT_SMALL, getText("IGUI_Entities_ViewPanel_Subtitle"), 1, 1, 1, 1.0, UIFont.Small, true);
    self.subLabel:initialise();
    self.subLabel:instantiate();
    self:addChild(self.subLabel);

    y = self:incY(y, self.subLabel, UI_BORDER_SPACING);

    self.buildButton = ISButton:new(x, y, midWidth,BUTTON_HGT,getText("IGUI_Entities_ScriptPanel_BuildEntity"), self, ISEntityScriptsPanel.onButtonClick);
    self.buildButton:initialise();
    self.buildButton:instantiate();
    self.buildButton.enable = false;
    self:addChild(self.buildButton);

    y = self:incY(y, self.buildButton, UI_BORDER_SPACING);

    self.scriptPanel = ISScriptViewPanel:new(x, y, self:getWidth()-(x*2-1), self.height - y - UI_BORDER_SPACING)
    self.scriptPanel:initialise();
    self.scriptPanel:instantiate();
    self:addChild(self.scriptPanel);

    self:populate();
end

function ISEntityScriptsPanel:onResize(_width, _height)
    ISPanel.onResize(self, _width, _height);

    self.list:setHeight(self.height - self.list:getY() - UI_BORDER_SPACING - 1);

    local x = self.list:getX() + self.list:getWidth() + UI_BORDER_SPACING;
    local midWidth = self.width - x - UI_BORDER_SPACING - 1;

    --self.reloadButton:setWidth(midWidth);
    self.buildButton:setWidth(midWidth);

    self.scriptPanel:setWidth(midWidth);
    self.scriptPanel:setHeight(self.height - self.scriptPanel:getY() - UI_BORDER_SPACING - 1);
end

function ISEntityScriptsPanel:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISEntityScriptsPanel.onTextChange(box)
    if not box then
        return;
    end
    if box:getInternalText()~=box.target.searchText then
        box.target.searchText = box:getInternalText();
        box.target:populate();
    end
end

function ISEntityScriptsPanel:onButtonClick(_button)
    if _button==self.buildButton then
        if not self.selectedEntityItem then
            return;
        end

        local script = self.selectedEntityItem.script:getComponentScriptFor(ComponentType.SpriteConfig);
        if not script then
            return;
        end

        local infos = SpriteConfigManager.GetObjectInfoList();
        local info = false;
        for i=0,infos:size()-1 do
            info = infos:get(i);
            if info:getScript() and info:getScript()==script then
                break;
            end
            info = false;
        end

        if not info then
            return;
        end

        local buildEntity = ISBuildIsoEntity:new(self.player, info);
        buildEntity.buildCheat = true;
        buildEntity.maxTime = 1;

        getCell():setDrag(buildEntity, buildEntity.character:getPlayerNum());
    end
end

local sortScripts = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
end

function ISEntityScriptsPanel:populate()
    self.list:clear()

    local needle = self.searchText;
    if (not self.searchText) or self.searchText=="" then
        needle = false;
    end

    local scripts = ScriptManager.instance:getAllGameEntities();
    local temp = {};
    for i=0,scripts:size()-1 do
        local script = scripts:get(i);

        local found = true;
        if needle then
            found = string.find( string.lower(script:getScriptObjectFullType()), string.lower(self.searchText) ) and true or false;
            if not found then
                found = string.find( string.lower(script:getDisplayNameDebug()), string.lower(self.searchText) ) and true or false;
            end
        end
        if found then
            local t = {
                script = script,
                fulltype = script:getScriptObjectFullType(),
                name = script:getDisplayNameDebug(),
            }
            table.insert(temp, t);
        end
    end

    table.sort(temp, sortScripts)

    for _,item in ipairs(temp) do
        self.list:addItem(item.name, item);
    end

    if self.list.items and #self.list.items>0 then
        --print("SELECTING ELEMENT")
        self.list.selected = 1;
        self:onEntityListSelected(self.list.items[self.list.selected].item);
    end
end

function ISEntityScriptsPanel:drawEntityListItem(y, item, alt)
    local a = 1.0;

    self:drawRectBorder( 1, y+1, self:getWidth()-2, self.itemheight - 2, 0.2, 1.0, 1.0, 1.0)
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.2, 1.0, 1.0, 1.0);
    end


    if item.item.name then
        local drawY = y + (self.itemheight/4) - (FONT_HGT_SMALL /2) + 2;
        --local c = item.item.color;
        self:drawText( item.item.name, 5, drawY, 1, 1, 1, 1.0, self.font);
    end
    if item.item.fulltype then
        local drawY = y + ((self.itemheight/4)*3) - (FONT_HGT_SMALL /2) - 1;
        self:drawText( item.item.fulltype, 5, drawY, 0.4, 0.4, 0.4, 1.0, self.font);
    end

    return y + self.itemheight;
end

function ISEntityScriptsPanel:onEntityListSelected(_item)
    self.selectedEntityItem = _item;

    if self.selectedEntityItem then
        self.scriptLabel:setName(_item.name);
        self.subLabel:setName(_item.fulltype);
        self.selectedCanBuild = self.selectedEntityItem.script:getComponentScriptFor(ComponentType.SpriteConfig)~=nil;
        self.scriptPanel:setScript(self.selectedEntityItem.script);
    else
        self.scriptLabel:setName("Void");
        self.subLabel:setName("Base.Void");
        self.selectedCanBuild = false;
        self.scriptPanel:setScript(nil);
    end
end

function ISEntityScriptsPanel:prerender()
    ISPanel.prerender(self);

    self.buildButton.enable = self.selectedEntityItem and self.selectedCanBuild;
end


function ISEntityScriptsPanel:render()
    ISPanel.render(self)
end

function ISEntityScriptsPanel:new (x, y, width, height, player)
	local o = ISPanel:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
    o.player = player;
    o.playerNum = player:getPlayerNum();
    o.searchText = "";
	return o
end