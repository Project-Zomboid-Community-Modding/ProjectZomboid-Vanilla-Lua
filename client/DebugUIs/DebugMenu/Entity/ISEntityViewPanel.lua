--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"



local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISEntityViewPanel = ISPanel:derive("ISEntityViewPanel");

function ISEntityViewPanel:initialise()
    ISPanel.initialise(self);
end

function ISEntityViewPanel:createChildren()
    ISPanel.createChildren(self);

    local x,y = UI_BORDER_SPACING+1, UI_BORDER_SPACING+1;

    self.reloadButton = ISButton:new(x, y, self.width-x*2, BUTTON_HGT,getText("IGUI_Entities_ViewPanel_TestSaveLoad"), self, ISEntityViewPanel.onButtonClick);
    self.reloadButton:initialise();
    self.reloadButton:instantiate();
    self.reloadButton.enable = true;
    self:addChild(self.reloadButton);

    y = self:incY(y, self.reloadButton, UI_BORDER_SPACING);

    self.reloadScriptButton = ISButton:new(x, y, self.width-x*2, BUTTON_HGT,getText("IGUI_Entities_ViewPanel_ReloadFromScript"), self, ISEntityViewPanel.onButtonClick);
    self.reloadScriptButton:initialise();
    self.reloadScriptButton:instantiate();
    self.reloadScriptButton.enable = true;
    self:addChild(self.reloadScriptButton);

    y = self:incY(y, self.reloadScriptButton, UI_BORDER_SPACING);

    local LEFT_BAR_WIDTH = 100+(getCore():getOptionFontSizeReal()*50);

    self.list = ISScrollingListBox:new(x, y, LEFT_BAR_WIDTH, self.height - y - UI_BORDER_SPACING - 1);
    self.list.backgroundColor = {r=0.0, g=0.0, b=0.0, a=1.0};
    self.list:initialise();
    self.list:instantiate();
    self.list.itemheight = BUTTON_HGT*2;
    self.list.selected = 0;
    --self.infoList.joypadParent = self;
    self.list.font = UIFont.Small;
    self.list.target = self;
    self.list.doDrawItem = ISEntityViewPanel.drawEntityListItem;
    self.list.onmousedown = ISEntityViewPanel.onEntityListSelected;
    self.list.drawBorder = true;
    self:addChild(self.list);

    local x = x + LEFT_BAR_WIDTH + UI_BORDER_SPACING;

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

    local width = self.width - x - UI_BORDER_SPACING-1;

    self.objectRuntimeButton = ISButton:new(x, y, width,BUTTON_HGT, getText("IGUI_Entities_ViewPanel_ObjectRuntimeDump"),self, ISEntityViewPanel.onButtonClick);
    self.objectRuntimeButton.defText = getText("IGUI_Entities_ViewPanel_ObjectRuntimeDumpDef");
    self.objectRuntimeButton.altText = getText("IGUI_Entities_ViewPanel_ObjectRuntimeDumpAlt");
    self.objectRuntimeButton.viewMode = 1;
    self.objectRuntimeButton:initialise();
    self.objectRuntimeButton:instantiate();
    self.objectRuntimeButton.enable = true;
    self:addChild(self.objectRuntimeButton);
    table.insert(self.viewButtons, self.objectRuntimeButton);

    y = self:incY(y, self.objectRuntimeButton, UI_BORDER_SPACING);

    self.entityScriptButton = ISButton:new(x, y, width,BUTTON_HGT,getText("IGUI_Entities_ViewPanel_ViewScript"),self, ISEntityViewPanel.onButtonClick);
    self.entityScriptButton.defText = getText("IGUI_Entities_ViewPanel_ViewScriptDef");
    self.entityScriptButton.altText = getText("IGUI_Entities_ViewPanel_ViewScriptAlt");
    self.entityScriptButton.viewMode = 2;
    self.entityScriptButton:initialise();
    self.entityScriptButton:instantiate();
    self.entityScriptButton.enable = true;
    self:addChild(self.entityScriptButton);
    table.insert(self.viewButtons, self.entityScriptButton);

    y = self:incY(y, self.entityScriptButton, UI_BORDER_SPACING);

    self.scriptRuntimeButton = ISButton:new(x, y, width,BUTTON_HGT,getText("IGUI_Entities_ViewPanel_ScriptRuntimeDump"),self, ISEntityViewPanel.onButtonClick);
    self.scriptRuntimeButton.defText = getText("IGUI_Entities_ViewPanel_ScriptRuntimeDumpDef");
    self.scriptRuntimeButton.altText = getText("IGUI_Entities_ViewPanel_ScriptRuntimeDumpAlt");
    self.scriptRuntimeButton.viewMode = 3;
    self.scriptRuntimeButton:initialise();
    self.scriptRuntimeButton:instantiate();
    self.scriptRuntimeButton.enable = true;
    self:addChild(self.scriptRuntimeButton);
    table.insert(self.viewButtons, self.scriptRuntimeButton);

    y = self:incY(y, self.scriptRuntimeButton, UI_BORDER_SPACING);

    local height = self.height - y - UI_BORDER_SPACING - 1;

    self.listView = ISStringListView:new (x, y, width, self.height - y - UI_BORDER_SPACING - 1);
    self.listView:initialise();
    self.listView:instantiate();
    self:addChild(self.listView);
end

function ISEntityViewPanel:onResize()
    self.reloadButton:setWidth(self.width-(UI_BORDER_SPACING+1)*2);
    self.reloadScriptButton:setWidth(self.width-(UI_BORDER_SPACING+1)*2);
    self.list:setHeight(self.height - self.list:getY() - UI_BORDER_SPACING - 1)
    self.entityScriptButton:setWidth(self.width-self.entityScriptButton:getX() -UI_BORDER_SPACING-1)
    self.scriptRuntimeButton:setWidth(self.width-self.scriptRuntimeButton:getX() -UI_BORDER_SPACING-1)
    self.objectRuntimeButton:setWidth(self.width-self.objectRuntimeButton:getX() -UI_BORDER_SPACING-1)
    self.listView:setWidth(self.width - self.listView:getX() - UI_BORDER_SPACING-1);
    self.listView:setHeight(self.height - self.listView:getY() - UI_BORDER_SPACING-1);
end

function ISEntityViewPanel:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISEntityViewPanel:onButtonClick(_button)
    if _button==self.reloadScriptButton then
        local reloadTable = ISEntityUI.GetReloadTable();
        ISEntityUI.CloseWindows();
        if ISEntitiesDebugWindow.instance then
            --ISEntitiesDebugWindow.instance:onReloadEntities();
        end

        reloadEntityFromScriptDebug(self.entity);
        --self.entity = false;

        self:populate();
        self:populateListView();

        for k,v in ipairs(reloadTable) do
            if ISEntityUI.CanOpenWindowFor(v.player, v.entity) then
                ISEntityUI.OpenWindow(v.player, v.entity)
            end
        end
    elseif _button==self.reloadButton then
        local reloadTable = ISEntityUI.GetReloadTable();
        ISEntityUI.CloseWindows();
        if ISEntitiesDebugWindow.instance then
            --ISEntitiesDebugWindow.instance:onReloadEntities();
        end

        reloadEntityDebug(self.entity);
        --self.entity = false;

        self:populate();
        self:populateListView();

        for k,v in ipairs(reloadTable) do
            if ISEntityUI.CanOpenWindowFor(v.player, v.entity) then
                ISEntityUI.OpenWindow(v.player, v.entity)
            end
        end
    else
        self.viewMode = _button.viewMode;
        self:populateListView();
    end
end

function ISEntityViewPanel:populateListView()
    if self.selectedEntityItem then
        local item = self.selectedEntityItem;
        for k,v in ipairs(self.viewButtons) do
            if v.viewMode==self.viewMode then
                v.backgroundColor.r = 0.5;
                v.backgroundColor.g = 0.5;
                v.backgroundColor.b = 0.5;
            else
                v.backgroundColor.r = 0;
                v.backgroundColor.g = 0;
                v.backgroundColor.b = 0;
            end

            v:setTitle(item.isComponent and v.altText or v.defText);
        end

        if self.viewMode==1 then
            if item.object then
                local lines = ObjectDebuggerLua.AllocList();

                ObjectDebuggerLua.GetLines(item.object, lines);

                self.listView:populate(lines);

                ObjectDebuggerLua.ReleaseList(lines);
            end
        elseif self.viewMode==2 then
            if item.entityScript then
                local lines = item.entityScript:getScriptLines();
                self.listView:populate(lines);
            end
        elseif self.viewMode==3 then
            if item.script then
                local lines = ObjectDebuggerLua.AllocList();

                ObjectDebuggerLua.GetLines(item.script, lines);

                self.listView:populate(lines);

                ObjectDebuggerLua.ReleaseList(lines);
            end
        end
    else
        self.listView:populate(nil);
    end
end

--requires a GameEntity object
function ISEntityViewPanel:setEntity(_entity)
    if self.entity~=_entity then
        self.entity = _entity;
        self:populate();
    end
end

local sortScripts = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
end

function ISEntityViewPanel:populate()
    self.list:clear();

    if self.entity then
        local temp = {};

        local entityScript = nil;-- self.entity:getEntityScript();
        local scriptComp = self.entity:getComponent(ComponentType.Script);
        if scriptComp then
            entityScript = scriptComp:getScript();
        end

        for i=0,self.entity:componentSize()-1 do
            local component = self.entity:getComponentForIndex(i);
            local componentType = component:getComponentType();
            local script = false;
            if entityScript then
                script = entityScript:getComponentScriptFor(componentType);
            end

            local t = {
                isComponent = true,
                object = component,
                componentType = componentType,
                script = script,
                entityScript = entityScript,
                fulltype = "Component",
                name = componentType:toString(),
            }

            table.insert(temp, t);
        end

        table.sort(temp, sortScripts)

        local t = {
            isComponent = false,
            object = self.entity,
            componentType = false,
            script = entityScript,
            entityScript = entityScript,
            fulltype = "Entity", --self.entity:getEntityFullType(),
            name = self.entity:getEntityDisplayName() or self.entity:getEntityFullType(), --"GameEntity",
        }

        table.insert(temp, 1, t);

        for _,item in ipairs(temp) do
            self.list:addItem(item.name, item);
        end

        if self.list.items and #self.list.items>0 then
            --print("SELECTING ELEMENT")
            self.list.selected = 1;
            self:onEntityListSelected(self.list.items[self.list.selected].item);
        end
    end
end

function ISEntityViewPanel:drawEntityListItem(y, item, alt)
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

function ISEntityViewPanel:onEntityListSelected(_item)
    self.selectedEntityItem = _item;

    if self.selectedEntityItem then
        self.scriptLabel:setName(_item.name);
        self.subLabel:setName(_item.fulltype);
    else
        self.scriptLabel:setName("Void");
        self.subLabel:setName("Base.Void");
    end
    self:populateListView();
end

function ISEntityViewPanel:update()
    ISPanel.update(self);
end

function ISEntityViewPanel:prerender()
    ISPanel.prerender(self);
end


function ISEntityViewPanel:render()
    ISPanel.render(self);
end

function ISEntityViewPanel:new (x, y, width, height, entity)
    local o = {}
    --o.data = {}
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=1.0};
    o.greyCol = { r=0.4,g=0.4,b=0.4,a=1};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.entity = entity;
    o.searchText = "";
    o.viewMode = 1;
    o.viewButtons = {};
    return o
end