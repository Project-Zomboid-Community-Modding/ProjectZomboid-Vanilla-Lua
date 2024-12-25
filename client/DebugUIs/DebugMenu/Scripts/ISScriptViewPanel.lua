--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISCollapsableWindow"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISScriptViewPanel = ISPanel:derive("ISScriptViewPanel");

function ISScriptViewPanel:initialise()
    ISPanel.initialise(self);
end

function ISScriptViewPanel:createChildren()
    ISPanel.createChildren(self);

    local x,y = UI_BORDER_SPACING+1, UI_BORDER_SPACING+1;

    self.viewModes = {};
    self.currentViewMode = 1;
    table.insert(self.viewModes, {
        --value = 1,
        text = getText("IGUI_ScriptView_ToggleRuntime"),
    });
    table.insert(self.viewModes, {
        --value = 2,
        text = getText("IGUI_ScriptView_ToggleViewScript"),
    });

    local width = self.width - x*2;

    self.toggleViewButton = ISButton:new(x, y, width, BUTTON_HGT,self.viewModes[self.currentViewMode].text,self, ISScriptViewPanel.onButtonClick);
    self.toggleViewButton:initialise();
    self.toggleViewButton:instantiate();
    self.toggleViewButton.enable = true;
    self:addChild(self.toggleViewButton);

    y = self.toggleViewButton:getY() + self.toggleViewButton:getHeight() + UI_BORDER_SPACING;

    self.listView = ISStringListView:new (x, y, width, self.height - y - UI_BORDER_SPACING);
    self.listView:initialise();
    self.listView:instantiate();
    self:addChild(self.listView);

    self:populate();
end

function ISScriptViewPanel:onResize()
    --ISUIElement.onResize(self);
    self.toggleViewButton:setWidth(self.width - (UI_BORDER_SPACING+1)*2);
    self.listView:setWidth(self.width - (UI_BORDER_SPACING+1)*2);
    self.listView:setHeight(self.height-self.listView:getY()-UI_BORDER_SPACING-1);
end

function ISScriptViewPanel:onButtonClick(_button)
    if _button == self.toggleViewButton then
        local mode = self.currentViewMode;
        self.currentViewMode = self.currentViewMode + 1;
        if self.currentViewMode > #self.viewModes then
            self.currentViewMode = 1;
        end
        if self.currentViewMode~=mode then
            self.toggleViewButton:setTitle(self.viewModes[self.currentViewMode].text);
            self:populate();
        end
    end
end

--requires a BaseScriptObject derived class
function ISScriptViewPanel:setScript(_script)
    if self.script~=_script then
        self.script = _script;
        self:populate();
    end
end

function ISScriptViewPanel:populate()
    self.listView:clear();
    if self.script then
        if self.currentViewMode==1 then
            local lines = self.script:getScriptLines();
            self.listView:populate(lines);

            if self.autoExpandAll then
                self.listView:setExpandedAll();
            end
        elseif self.currentViewMode==2 then
            local lines = ObjectDebuggerLua.AllocList();

            ObjectDebuggerLua.GetLines(self.script, lines); --, 1000, true, false, 1000);

            self.listView:populate(lines);

            ObjectDebuggerLua.ReleaseList(lines);

            if self.autoExpandAll then
                self.listView:setExpandedAll();
            end
        end
    end
end

function ISScriptViewPanel:update()
    ISPanel.update(self);
end

function ISScriptViewPanel:prerender()
    ISPanel.prerender(self);
end


function ISScriptViewPanel:render()
    ISPanel.render(self);
end

function ISScriptViewPanel:new (x, y, width, height, script)
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
    o.script = script;
    o.searchText = "";
    o.autoExpandAll = false;
    return o
end