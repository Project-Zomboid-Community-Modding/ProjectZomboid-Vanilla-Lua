--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 21/09/16
-- Time: 10:19
-- To change this template use File | Settings | File Templates.
--

--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "ISUI/ISPanel"

ISServerOptions = ISPanel:derive("ISServerOptions");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISPanel:initialise
--**
--************************************************************************--

function ISServerOptions:initialise()
    ISPanel.initialise(self);
    self:create();
end


function ISServerOptions:setVisible(visible)
    --    self.parent:setVisible(visible);
    self.javaObject:setVisible(visible);
end

function ISServerOptions:render()
    self:drawText(getText("IGUI_PlayerStats_ServerOptionTitle"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_PlayerStats_ServerOptionTitle")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);
    self:drawText(getText("IGUI_DbViewer_Filters"), self.datas.x, self.datas.y + self.datas.height + UI_BORDER_SPACING, 1,1,1,1, UIFont.Small);
end

function ISServerOptions:onMouseMove(dx, dy)
    ISPanel.onMouseMove(self, dx, dy)

    local x = self:getMouseX();
    local y = self:getMouseY();
    self.changeBtn:setVisible(false)

    if self.player:getRole():hasCapability(Capability.ChangeAndReloadServerOptions) and not self.modifying and x >= self.datas:getX() and x <= self.datas:getX() + (self.datas:getWidth() - 40) and y >= self.datas:getY() and y <= self.datas:getY() + self.datas:getHeight() then
        y = self.datas:rowAt(self.datas:getMouseX(), self.datas:getMouseY())
        if self.datas.items[y] then
            self.changeBtn:setVisible(true);
            self.changeBtn:setY(self.datas.y + self.datas:topOfItem(y) + self.datas:getYScroll());
            local option = self.datas.items[y].item
            local tooltipText = option:getTooltip()
            if not tooltipText then self:hideTooltip(); return; end
            tooltipText = tooltipText:gsub("\\n", "\n")
            tooltipText = tooltipText:gsub("\\\"", "\"")
            if not self.tooltip then
                local tooltip = ISToolTip:new();
                tooltip:initialise();
                tooltip.description = tooltipText;
                self.tooltip = tooltip;
                self.tooltip.maxLineWidth = 300;
                self.tooltip:setVisible(true);
                self.tooltip:addToUIManager();
                self.tooltip.followMouse = true;
            else
                self.tooltip.description = tooltipText;
            end
        else
            self:hideTooltip();
        end
    else
        self:hideTooltip();
    end
end

function ISServerOptions:hideTooltip()
    if self.tooltip then
        self.tooltip:setVisible(false);
        self.tooltip:removeFromUIManager();
        self.tooltip = nil;
    end
end

function ISServerOptions:create()
    local btnWid = 100
    local padBottom = UI_BORDER_SPACING + 1
    local y = FONT_HGT_MEDIUM + UI_BORDER_SPACING*2 + 1;
    self.datas = ISScrollingListBox:new(UI_BORDER_SPACING + 1, y, self.width - (UI_BORDER_SPACING+1)*2, self.height - y - UI_BORDER_SPACING*3 - BUTTON_HGT*2 - 1);
    self.datas:initialise();
    self.datas:instantiate();
    self.datas.itemheight = BUTTON_HGT;
    self.datas.selected = 0;
    self.datas.joypadParent = self;
    self.datas.font = UIFont.NewSmall;
    self.datas.doDrawItem = self.drawDatas;
    self.datas.drawBorder = true;
    self.datas.parent = self;
    self:addChild(self.datas);

    local textWid = getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DbViewer_Filters"))
    self.filterEntry = ISTextEntryBox:new("", self.datas.x + textWid + UI_BORDER_SPACING, self.datas.y + self.datas.height + UI_BORDER_SPACING, 200, BUTTON_HGT);
    self.filterEntry:initialise();
    self.filterEntry:instantiate();
    self.filterEntry:setText("");
    self:addChild(self.filterEntry);
    self.filterEntry:setClearButton(true)
    self.filterEntry.onTextChange = ISServerOptions.populateList;

    self.changeBtn = ISButton:new(self.width - btnWid - padBottom - 13, 0, btnWid, BUTTON_HGT, getText("IGUI_PlayerStats_Change"), self, ISServerOptions.onOptionMouseDown);
    self.changeBtn.internal = "CHANGE";
    self.changeBtn:initialise();
    self.changeBtn:instantiate();
    self.changeBtn.borderColor = self.buttonBorderColor;
    self.changeBtn:setVisible(false);
    self:addChild(self.changeBtn);

    self.saveBtn = ISButton:new(self.datas.x, self:getHeight() - padBottom - BUTTON_HGT, btnWid, BUTTON_HGT, getText("IGUI_PlayerStats_ReloadOptions"), self, ISServerOptions.onOptionMouseDown);
    self.saveBtn.internal = "RELOAD";
    self.saveBtn.tooltip = getText("IGUI_PlayerStats_ReloadOptionsTooltip");
    self.saveBtn:initialise();
    self.saveBtn:instantiate();
    self.saveBtn.enable = false;
    self.saveBtn.borderColor = self.buttonBorderColor;
    self:addChild(self.saveBtn);

    self.cancel = ISButton:new(self:getWidth() - btnWid - UI_BORDER_SPACING - 1, self:getHeight() - padBottom - BUTTON_HGT, btnWid, BUTTON_HGT, getText("IGUI_CraftUI_Close"), self, ISServerOptions.onOptionMouseDown);
    self.cancel.internal = "CANCEL";
    self.cancel:initialise();
    self.cancel:instantiate();
    self.cancel.borderColor = self.buttonBorderColor;
    self:addChild(self.cancel);

    if not self.player:getRole():hasCapability(Capability.ChangeAndReloadServerOptions) then
        self.changeBtn:setVisible(false);
        self.saveBtn:setVisible(false);
    end

    self:populateList();
end

function ISServerOptions:populateList()
    ISServerOptions.instance.datas:clear();
    local options = ServerOptions.getInstance():getPublicOptions()
    local sorted = {}
    for i=1,options:size() do
        local option = options:get(i-1)
        table.insert(sorted, option)
    end
    table.sort(sorted, function(a,b) return not string.sort(a, b) end)
    local filterText = ISServerOptions.instance.filterEntry:getInternalText():trim():lower()
    if filterText ~= "" then
        for _,option in ipairs(sorted) do
            if string.contains(string.lower(option), filterText) then
                ISServerOptions.instance.datas:addItem(option, ServerOptions.getInstance():getOptionByName(option))
            end
        end
    else
        for _,option in ipairs(sorted) do
            ISServerOptions.instance.datas:addItem(option, ServerOptions.getInstance():getOptionByName(option))
        end
    end
end

function ISServerOptions:drawDatas(y, item, alt)
    local a = 0.9;

    if alt then
        self:drawRect(0, (y), self:getWidth(), self.itemheight, 0.3, 0.6, 0.5, 0.5);
    end

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    self:drawText(item.item:getName(), UI_BORDER_SPACING, y + 3, 1, 1, 1, a, self.font);

    local labelWidth = getTextManager():MeasureStringX(self.font, item.item:getName())

    local dataString = item.item:getValueAsString()
    if instanceof(item.item, "EnumConfigOption") then
        dataString = item.item:getValueTranslationByIndex(item.item:getValue())
    end

    local dataWidth = getTextManager():MeasureStringX(self.font, dataString)

    if labelWidth + dataWidth > self.width - UI_BORDER_SPACING*3 then
        self:drawText(dataString, labelWidth + UI_BORDER_SPACING*3, y+3, 1, 1, 1, a, self.font);
    else
        self:drawTextRight(dataString, self.width - 13 - UI_BORDER_SPACING, y+3, 1, 1, 1, a, self.font);
    end


    return y + self.itemheight;
end

function ISServerOptions:onServerOptionChange(option, newValue)
    newValue = string.gsub(newValue, "\"", "\\\"");
    if newValue ~= option:getValueAsString() then
        self.saveBtn.enable = true;
        SendCommandToServer("/changeoption " .. option:getName() .. " \"" .. newValue .. "\"");
        for i=1,#self.datas.items do
            local item = self.datas.items[i].item;
            if item:getName() == option:getName() then
                item:asConfigOption():setValueFromObject(newValue);
            end
        end
    end
end

function ISServerOptions:onOptionMouseDown(button, x, y)
    if button.internal == "CHANGE" then
        local y = self:getMouseY() + (-self.datas:getYScroll());
        y = y - (FONT_HGT_MEDIUM + UI_BORDER_SPACING*2 + 1);
        y = y / self.datas.itemheight;
        y = math.floor(y + 1);
        local modal = ISServerOptionsChange:new(self:getMouseX() - 30, self:getMouseY() - 30, self.width, 100, self, ISServerOptions.onServerOptionChange, self.datas.items[y].item)
        modal:initialise();
        modal:addToUIManager();
        self.modifying = true;
    end

    if button.internal == "CANCEL" then
        if self.saveBtn.enable then
            local modal = ISModalDialog:new(0,0, 350, 150, getText("IGUI_PlayerStats_ConfirmNonSaveServerOptions"), true, nil, ISServerOptions.onConfirmLeave);
            modal:initialise()
            modal:addToUIManager()
            modal.ui = self;
            modal.moveWithMouse = true;
        else
            self:setVisible(false);
            self:removeFromUIManager();
        end
    end

    if button.internal == "RELOAD" then
        SendCommandToServer("/reloadoptions");
        self.saveBtn.enable = false;
    end
end

function ISServerOptions:onConfirmLeave(button)
    if button.internal == "YES" then
        SendCommandToServer("/reloadoptions");
    end
    button.parent.ui:setVisible(false);
    button.parent.ui:removeFromUIManager();
end

function ISServerOptions:new(x, y, width, height, player)
    local o = {};
    x = getCore():getScreenWidth() / 2 - (width / 2);
    y = getCore():getScreenHeight() / 2 - (height / 2);
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.player = player;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = true;
    o.modifying = false;
    ISServerOptions.instance = o;

    return o;
end
