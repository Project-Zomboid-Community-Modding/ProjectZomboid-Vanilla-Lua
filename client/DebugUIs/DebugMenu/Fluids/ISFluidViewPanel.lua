--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISFluidViewPanel = ISPanel:derive("ISFluidViewPanel");

function ISFluidViewPanel:initialise()
    ISPanel.initialise(self);
end

function ISFluidViewPanel:createChildren()
    ISPanel.createChildren(self);

    local x,y = UI_BORDER_SPACING+1, UI_BORDER_SPACING+1;

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

    local width = self.width - x - UI_BORDER_SPACING-1;

    self.objectRuntimeButton = ISButton:new(x, y, width,BUTTON_HGT, getText("IGUI_Fluids_ViewPanel_ObjectRuntimeDump"),self, ISFluidViewPanel.onButtonClick);
    self.objectRuntimeButton.viewMode = 1;
    self.objectRuntimeButton:initialise();
    self.objectRuntimeButton:instantiate();
    self.objectRuntimeButton.enable = true;
    self:addChild(self.objectRuntimeButton);
    table.insert(self.viewButtons, self.objectRuntimeButton);

    y = self:incY(y, self.objectRuntimeButton, UI_BORDER_SPACING);

    self.scriptButton = ISButton:new(x, y, width,BUTTON_HGT, getText("IGUI_Fluids_ViewPanel_ViewScript"),self, ISFluidViewPanel.onButtonClick);
    self.scriptButton.viewMode = 2;
    self.scriptButton:initialise();
    self.scriptButton:instantiate();
    self.scriptButton.enable = true;
    self:addChild(self.scriptButton);
    table.insert(self.viewButtons, self.scriptButton);

    y = self:incY(y, self.scriptButton, UI_BORDER_SPACING);

    self.scriptRuntimeButton = ISButton:new(x, y, width,BUTTON_HGT, getText("IGUI_Fluids_ViewPanel_ScriptRuntimeDump"),self, ISFluidViewPanel.onButtonClick);
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

function ISFluidViewPanel:onResize()
    self.scriptButton:setWidth(self.width-(UI_BORDER_SPACING+1)*2)
    self.scriptRuntimeButton:setWidth(self.width-(UI_BORDER_SPACING+1)*2)
    self.objectRuntimeButton:setWidth(self.width-(UI_BORDER_SPACING+1)*2)
    self.listView:setWidth(self.width - self.listView:getX() - UI_BORDER_SPACING-1);
    self.listView:setHeight(self.height - self.listView:getY() - UI_BORDER_SPACING-1);
end

function ISFluidViewPanel:incY(_y, _obj, _margin)
    return _obj:getY() + _obj:getHeight() + (_margin or 0);
end

function ISFluidViewPanel:onButtonClick(_button)
    if _button.viewMode then
        self.viewMode = _button.viewMode;
        self:populateListView();
    end
end

function ISFluidViewPanel:populateListView()
    if self.fluid then
        if self.viewMode==1 then
            local lines = ObjectDebuggerLua.AllocList();

            ObjectDebuggerLua.GetLines(self.fluid, lines);

            self.listView:populate(lines);

            ObjectDebuggerLua.ReleaseList(lines);

            self.listView:setExpandedAll();
        elseif self.viewMode==2 then
            if self.fluid:getScript() then
                local lines = self.fluid:getScript():getScriptLines();
                self.listView:populate(lines);

                self.listView:setExpandedAll();
            end
        elseif self.viewMode==3 then
            if self.fluid:getScript() then
                local lines = ObjectDebuggerLua.AllocList();

                ObjectDebuggerLua.GetLines(self.fluid:getScript(), lines);

                self.listView:populate(lines);

                ObjectDebuggerLua.ReleaseList(lines);

                self.listView:setExpandedAll();
            end
        end
    else
        self.listView:populate(nil);
    end
end

--requires a GameEntity object
function ISFluidViewPanel:setFluid(_fluid)
    if self.fluid~=_fluid then
        self.fluid = _fluid;
        
        if self.fluid then
            self.scriptLabel:setName(self.fluid:getDisplayName());
            self.subLabel:setName("<"..self.fluid:getFluidTypeString()..">");
        else
            self.scriptLabel:setName("Void");
            self.subLabel:setName("Base.Void");
        end
        self:populateListView();
    end
end

function ISFluidViewPanel:update()
    ISPanel.update(self);
end

function ISFluidViewPanel:prerender()
    ISPanel.prerender(self);
end


function ISFluidViewPanel:render()
    ISPanel.render(self);
end

function ISFluidViewPanel:new (x, y, width, height, fluid)
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
    o.fluid = fluid;
    o.searchText = "";
    o.viewMode = 1;
    o.viewButtons = {};
    return o
end