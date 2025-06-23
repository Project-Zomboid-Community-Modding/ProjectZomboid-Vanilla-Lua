--***********************************************************
--**                    THE INDIE STONE                    **
--**                    ROBERT JOHNSON                     **
--**				  Refactor: turbotutone				   **
--***********************************************************

--[[
    NOTE: this lua class has been refactor to be more automated
    so that it can autogenerate options for the new Attribute system.
    see ISItemEditPanel header for more info
--]]

require "ISUI/ISPanel"

ISItemEditorUI = ISPanel:derive("ISItemEditorUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISItemEditorUI.OpenPanel(_player, _item)
    local x = getMouseX() + 10;
    local y = getMouseY() + 10;
    local ui = ISItemEditorUI:new(x,y,400,600, _player, _item);
    ui:initialise();
    ui:addToUIManager();
end

-- INIT --
function ISItemEditorUI:initialise()
    ISPanel.initialise(self);
end

function ISItemEditorUI:createChildren()
    ISPanel.createChildren(self);

    local btnWid = 100;

    local y = UI_BORDER_SPACING+1;
    --ISLabel:new (0, y, height, name, r, g, b, a, font, bLeft)
    self.titleText = getText("IGUI_ItemEditor_Title");
    self.title = ISLabel:new (0, y, FONT_HGT_MEDIUM, self.titleText, 1, 1, 1, 1.0, UIFont.Medium, true);
    self.title:initialise();
    self.title:instantiate();
    self:addChild(self.title);

    y = y + FONT_HGT_MEDIUM + UI_BORDER_SPACING;

--     self.pathText = self.item:getFileAbsPath();
--     self.path = ISLabel:new (0, y, FONT_HGT_MEDIUM, self.pathText, 1, 1, 1, 1.0, UIFont.Medium, true);
--     self.path:initialise();
--     self.path:instantiate();
--     self:addChild(self.path);
--
--     y = y + FONT_HGT_MEDIUM + UI_BORDER_SPACING;

    local panelY = 200;
    self.optionsPanel = ISItemEditPanel:new(UI_BORDER_SPACING+1, y,400, panelY, self.admin, self.item);
    self.optionsPanel:initialise();
    self.optionsPanel:instantiate();
    self.optionsPanel.doStencilRender = true;
    self.optionsPanel:addScrollBars();
    self.optionsPanel.vscroll:setVisible(true);
    self.optionsPanel.vscroll:setAnchorRight(false); -- <- fix for issue of scroll not aligning properly.
    self.optionsPanel:setScrollChildren(true);
    self.optionsPanel.onMouseWheel = ISItemEditorUI.onMouseWheel;
    self:addChild(self.optionsPanel);

    y = y + panelY + UI_BORDER_SPACING+1;

    self.save = ISButton:new(UI_BORDER_SPACING+1, y, btnWid, BUTTON_HGT, getText("IGUI_RadioSave"), self, ISItemEditorUI.onOptionMouseDown);
    self.save.internal = "SAVE";
    self.save:initialise();
    self.save:instantiate();
    self.save:enableAcceptColor()
    self:addChild(self.save);

    self.cancel = ISButton:new(0, y, btnWid, BUTTON_HGT, getText("IGUI_Exit"), self, ISItemEditorUI.onOptionMouseDown);
    self.cancel.internal = "CANCEL";
    self.cancel:initialise();
    self.cancel:instantiate();
    self.cancel:enableCancelColor()
    self:addChild(self.cancel);

    y = y + BUTTON_HGT + UI_BORDER_SPACING+1;

    local w = self.optionsPanel:getWidth() + (UI_BORDER_SPACING+1)*2;
    self:setWidth(w);
    self.cancel:setX(w-btnWid-UI_BORDER_SPACING-1);
    self:setHeight(y);

    local textW = getTextManager():MeasureStringX(UIFont.Medium, self.titleText);
    local textX = (w/2) - (textW/2);
    self.title:setX(textX);
end

function ISItemEditorUI.onMouseWheel(self, del)
    if self:getScrollHeight() > 0 then
        self:setYScroll(self:getYScroll() - (del * 40))
        return true
    end
    return false
end

function ISItemEditorUI:onOptionMouseDown(button, x, y)
    if button.internal == "SAVE" then
        self.optionsPanel:saveAll();
        self:setVisible(false);
        self:removeFromUIManager();
    elseif button.internal == "CANCEL" then
        self:setVisible(false);
        self:removeFromUIManager();
    end
end

function ISItemEditorUI:setVisible(visible)
    --    self.parent:setVisible(visible);
    self.javaObject:setVisible(visible);
end

function ISItemEditorUI:render()
end

function ISItemEditorUI:prerender()
    ISPanel.prerender(self);

end

function ISItemEditorUI:new(x, y, width, height, admin, item)
    local o = {};
    o = ISPanel:new(x, y, 800, height);
--     o = ISPanel:new(x, y, 400, height);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = true;
    o.admin = admin;
    o.item = item;

    return o;
end
