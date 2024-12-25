---
--- Created by Iurii.
--- DateTime: 3/6/2024 3:46 AM
---

ISModalEditRole = ISPanel:derive("ISModalEditRole");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 20
local COLUMN_WIDTH = 200
local BUTTON_HGT = FONT_HGT_SMALL + 6


--************************************************************************--
--** ISRolesList:initialise
--**
--************************************************************************--

function ISModalEditRole:initialise()
    ISPanel.initialise(self);
    local btnWid = 100
    local elementHeight = FONT_HGT_MEDIUM
    local elementWidth = 100
    local y = UI_BORDER_SPACING+1

    local title = getText("IGUI_AdminPanel_SeeRole").." \""..self.role:getName().."\""
    self.labelTitle = ISLabel:new(self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, title) / 2), y, 10, title ,1,1,1,1,UIFont.Medium, true);
    self:addChild(self.labelTitle);
    y = y + elementHeight + UI_BORDER_SPACING

    self.valueDescriptionLabel = ISLabel:new(UI_BORDER_SPACING, y, elementHeight, getText("IGUI_AdminPanel_Description"), 1, 1, 1, 1, UIFont.Medium, true);
    self.valueDescriptionLabel:initialise();
    self.valueDescriptionLabel:instantiate();
    self.valueDescriptionLabel:setAnchorLeft(false);
    self.valueDescriptionLabel:setAnchorRight(true);
    self.valueDescriptionLabel:setAnchorTop(true);
    self.valueDescriptionLabel:setAnchorBottom(false);
    self:addChild(self.valueDescriptionLabel);

    self.valueDescription = ISTextEntryBox:new("", UI_BORDER_SPACING + elementWidth, y, self.width - UI_BORDER_SPACING * 2 - elementWidth, elementHeight);
    self.valueDescription.font = UIFont.Medium;
    self.valueDescription:initialise();
    self.valueDescription:instantiate();
    self.valueDescription.background = false;
    self:addChild(self.valueDescription)
    y = y + elementHeight + UI_BORDER_SPACING;

    self.buttonColorLabel = ISLabel:new(UI_BORDER_SPACING, y, elementHeight, getText("IGUI_AdminPanel_Color"), 1, 1, 1, 1, UIFont.Medium, true);
    self.buttonColorLabel:initialise();
    self.buttonColorLabel:instantiate();
    self.buttonColorLabel:setAnchorLeft(false);
    self.buttonColorLabel:setAnchorRight(true);
    self.buttonColorLabel:setAnchorTop(true);
    self.buttonColorLabel:setAnchorBottom(false);
    self:addChild(self.buttonColorLabel);

    self.buttonColor = ISButton:new(UI_BORDER_SPACING + elementWidth, y, self.width - UI_BORDER_SPACING * 2 - elementWidth, elementHeight, "", self, ISModalEditRole.onColor);
    self.buttonColor:initialise();
    self.buttonColor.backgroundColor = {r = 1, g = 1, b = 1, a = 1};
    self:addChild(self.buttonColor);
    y = y + elementHeight + UI_BORDER_SPACING;

    self.colorPicker = ISColorPicker:new(UI_BORDER_SPACING+COLUMN_WIDTH, y)
    self.colorPicker:initialise()
    self.colorPicker.pickedTarget = self
    self.colorPicker.resetFocusTo = self

    self.tickBoxCapabilityLabel = ISLabel:new(UI_BORDER_SPACING, y, elementHeight, getText("IGUI_AdminPanel_Capabilities"), 1, 1, 1, 1, UIFont.Medium, true);
    self.tickBoxCapabilityLabel:initialise();
    self.tickBoxCapabilityLabel:instantiate();
    self.tickBoxCapabilityLabel:setAnchorLeft(false);
    self.tickBoxCapabilityLabel:setAnchorRight(true);
    self.tickBoxCapabilityLabel:setAnchorTop(true);
    self.tickBoxCapabilityLabel:setAnchorBottom(false);
    self:addChild(self.tickBoxCapabilityLabel);

    self.filter = ISTextEntryBox:new("", UI_BORDER_SPACING + elementWidth, y, self.width - UI_BORDER_SPACING * 2 - elementWidth, elementHeight);
    self.filter.font = UIFont.Medium;
    self.filter:initialise();
    self.filter:instantiate();
    self.filter.background = false;
    self:addChild(self.filter)
    y = y + elementHeight + UI_BORDER_SPACING;

    self.scrollPanel = ISPanelJoypad:new(UI_BORDER_SPACING, y, self:getWidth() - 2*UI_BORDER_SPACING, self:getHeight() - y - 2*UI_BORDER_SPACING - elementHeight)
    self.scrollPanel:initialise()
    self.scrollPanel:instantiate()
    self.scrollPanel:setAnchorLeft(true);
    self.scrollPanel:setAnchorRight(true);
    self.scrollPanel:setAnchorTop(true);
    self.scrollPanel:setAnchorBottom(true);
    self.scrollPanel:setScrollChildren(true)
    self.scrollPanel:noBackground()
    self.scrollPanel:addScrollBars()
    self.scrollPanel.vscroll.doRepaintStencil = true
    self:addChild(self.scrollPanel);
    self.scrollPanel.prerender = function(self)
        self:setStencilRect(0, 0, self:getWidth(), self:getHeight())
        ISPanelJoypad.prerender(self)
    end
    self.scrollPanel.render = function(self)
        ISPanelJoypad.render(self)
        self:clearStencilRect()
        if self.joyfocus then
            self:drawRectBorder(0, -self:getYScroll(), self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
            self:drawRectBorder(1, 1-self:getYScroll(), self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);
        end
    end
    self.scrollPanel.onMouseWheel = function(self, del)
        if self:getScrollHeight() > 0 then
            self:setYScroll(self:getYScroll() - (del * 40))
            return true
        end
        return false
    end

    --local y2 = 0
    self.tickBoxCapability = ISTickBox:new(UI_BORDER_SPACING, 0, self.width - 2*UI_BORDER_SPACING, BUTTON_HGT, "", self, self.onTickBox, self.role)
    self.tickBoxCapability:initialise()
    self.tickBoxCapability:instantiate();
    self.tickBoxCapability.doStencilRender = true;
    self.tickBoxCapability:addScrollBars();
    self.tickBoxCapability.vscroll:setVisible(true);
    self.tickBoxCapability.vscroll:setAnchorRight(false); -- <- fix for issue of scroll not aligning properly.
    self.tickBoxCapability:setScrollChildren(true);
    self.tickBoxCapability:setEnabled(not self.role:isReadOnly());
    self.scrollPanel:addChild(self.tickBoxCapability);

    --y2 = y2 + self.tickBoxCapability:getHeight() + UI_BORDER_SPACING;
    --self.scrollPanel:setScrollHeight(1000)

    self.close = ISButton:new(self.width - btnWid - (UI_BORDER_SPACING+1)*2, self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_RolesList_Close"), self, ISModalEditRole.onClick);
    self.close.internal = "CLOSE";
    self.close.anchorTop = false
    self.close.anchorBottom = true
    self.close:initialise();
    self.close:instantiate();
    self.close.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.close);

    self.save = ISButton:new(self.close.x - btnWid - UI_BORDER_SPACING+1 , self:getHeight() - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWid, BUTTON_HGT, getText("IGUI_RolesList_Save"), self, ISModalEditRole.onClick);
    self.save.internal = "SAVE";
    self.save.anchorTop = false
    self.save.anchorBottom = true
    self.save:initialise();
    self.save:instantiate();
    self.save.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.save);

    local allCapabilities = getCapabilities()
    for i=1,allCapabilities:size() do
        local capability = allCapabilities:get(i-1)
        self.capabilities[capability] = self.role:haveCapability(capability)
    end
end

function ISModalEditRole:onTickBox(index, selected)
    local option = self.tickBoxCapability:getOptionData(index)
    self.capabilities[option] = selected
end

function ISModalEditRole:onColor(button)
    self.colorPicker:setX(button:getAbsoluteX());
    self.colorPicker:setY(button:getAbsoluteY() + button:getHeight());
    self.colorPicker.pickedFunc = ISModalEditRole.onPickedTagColor
    self.colorPicker:setInitialColor(ColorInfo.new(button.backgroundColor.r, button.backgroundColor.g, button.backgroundColor.b, 1.0));
    self.colorPicker:addToUIManager()
end

function ISModalEditRole:onPickedTagColor(color, mouseUp)
    ISModalEditRole.instance.buttonColor.backgroundColor = { r=color.r, g=color.g, b=color.b, a = 1 }
end

function ISModalEditRole:populateList()

    self.valueDescription:setText(self.role:getDescription());
    --self.valueDescription:paginate();
    self.valueDescription:setEditable(not self.role:isReadOnly());

    self.buttonColor.backgroundColor = {r = self.role:getColor():getR(), g = self.role:getColor():getG(), b = self.role:getColor():getB(), a = 1};
    self.buttonColor:setEnable(not self.role:isReadOnly());
    self.colorPicker:setInitialColor(self.role:getColor());

    local scrollHeight = 0
    local filterText = string.lower(self.filter:getInternalText())
    self.tickBoxCapability:clearOptions()
    for k,v in pairs(self.capabilities) do
        if filterText == nil or filterText == '' or string.contains(string.lower(k:name()), filterText) then
            local index = self.tickBoxCapability:addOption(k:name(), k)
            self.tickBoxCapability:setSelected(index, v)
            scrollHeight = scrollHeight + 1
        end
    end
    self.tickBoxCapability:setWidthToFit()

    self.scrollPanel:setScrollHeight(scrollHeight * (FONT_HGT_MEDIUM + 9))

    self.save:setVisible(not self.role:isReadOnly())
end

function ISModalEditRole:drawDatas(y, item, alt)
    local a = 0.9;

    --    self.parent.selectedFaction = nil;
    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    local readOnlyTxt = "";
    if item.item:isReadOnly() then
        readOnlyTxt = "[Read Only]";
    end
    local defaultsTxt = "";
    local defaults = item.item:getDefaults()
    for i=0,defaults:size()-1 do
        defaultsTxt = defaultsTxt .. defaults:get(i) .. " "
    end
    local color = item.item:getColor()
    self:drawText(item.item:getName(), 10, y + 2, color:getR(), color:getG(), color:getB(), a, UIFont.Medium);
    self:drawText(item.item:getDescription(), 10, y + 2 + (FONT_HGT_SMALL + 3), 1, 1, 1, a, self.font);
    self:drawText(readOnlyTxt .. " " .. defaultsTxt, 10, y + 2 + (FONT_HGT_SMALL + 3) * 2, 1, 1, 1, a, self.font);

    return y + self.itemheight;
end

function ISModalEditRole:onSelectRole(_item)
    ISModalEditRole.instance.delete.enable = true;
    ISModalEditRole.instance.edit.enable = true;
end

function ISModalEditRole:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:populateList();
end

function ISModalEditRole:onClick(button)
    if button.internal == "CLOSE" then
        ISModalEditRole.instance:closeModal()
        return;
    end
    if button.internal == "SAVE" then
        setupRole(self.role, self.valueDescription:getText(), Color.new(self.buttonColor.backgroundColor.r, self.buttonColor.backgroundColor.g, self.buttonColor.backgroundColor.b, 1.0), self.capabilities)
        ISModalEditRole.instance:closeModal()
        return;
    end
end

function ISModalEditRole:closeModal()
    self:setVisible(false);
    self:removeFromUIManager();
    ISModalEditRole.instance = nil
end

--************************************************************************--
--** ISFactionsList:new
--**
--************************************************************************--
function ISModalEditRole:new(x, y, width, height, role)
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
    o.role = role;
    o.moveWithMouse = true;
    o.capabilities = {}
    ISModalEditRole.instance = o;
    return o;
end