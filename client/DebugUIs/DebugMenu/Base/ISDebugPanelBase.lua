--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

ISDebugPanelBase = ISPanel:derive("ISDebugPanelBase");
--ISDebugPanelBase.instance = nil;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6


function ISDebugPanelBase.OnOpenPanel(_class,_x, _y, _w, _h, _title)
    if _class.instance==nil then
        _class.instance = _class:new(_x, _y, _w, _h, _title);
        _class.instance:initialise();
        _class.instance:instantiate();
        ISDebugMenu.RegisterClass(_class);
    end

    _class.instance:addToUIManager();
    _class.instance:setVisible(true);

    return _class.instance;
end

function ISDebugPanelBase:initialise()
    ISPanel.initialise(self);
end

function ISDebugPanelBase:registerPanel(_buttonTitle, _panelClass, _ignoreSorting)
    self.panelInfo = self.panelInfo or {};

    table.insert(self.panelInfo, {
        buttonTitle = _buttonTitle,
        panelClass = _panelClass,
        ignoreSorting = _ignoreSorting;
    });
    --table.sort(self.panelInfo, function(a, b) return string.sort(b.buttonTitle, a.buttonTitle) end)
end

function ISDebugPanelBase:createChildren()
    ISPanel.createChildren(self);

    local panelInfo = self.panelInfo;
    self.panelInfo = {};
    for k,v in ipairs(panelInfo) do
        if v.ignoreSorting then
            table.insert(self.panelInfo, v);
        end
    end
    table.sort(panelInfo, function(a, b) return string.sort(b.buttonTitle, a.buttonTitle) end)
    for k,v in ipairs(panelInfo) do
        if not v.ignoreSorting then
            table.insert(self.panelInfo, v);
        end
    end

    local y, obj = ISDebugUtils.addLabel(self, self.panelTitle, self.width/2, UI_BORDER_SPACING+1, self.panelTitle, UIFont.Medium, true);
    obj.center = true;
    local headerY = y + UI_BORDER_SPACING;

    local buttonX,buttonY = UI_BORDER_SPACING+1, headerY;
    local buttonW = UI_BORDER_SPACING*2 + getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_CraftUI_Close"));

    for k,v in ipairs(self.panelInfo) do
        buttonW = math.max(UI_BORDER_SPACING * 2 + getTextManager():MeasureStringX(UIFont.Small, v.buttonTitle), buttonW)
    end

    local obj;

    for k,v in ipairs(self.panelInfo) do
        buttonY, obj = ISDebugUtils.addButton(self,v.buttonTitle,buttonX,buttonY,buttonW,BUTTON_HGT,v.buttonTitle,ISDebugPanelBase.onClick);
        v.button = obj;
        buttonY = buttonY+UI_BORDER_SPACING;
    end

    local buttonY, obj = ISDebugUtils.addButton(self,"close", buttonX, self.height - BUTTON_HGT - UI_BORDER_SPACING-1, buttonW, BUTTON_HGT,getText("IGUI_DebugMenu_Close"),ISDebugPanelBase.onClick);
    obj:enableCancelColor()
    local x,y = buttonX+buttonW + UI_BORDER_SPACING, headerY;
    local w,h = self.width-buttonX-buttonW - UI_BORDER_SPACING*2 - 1, self.height-headerY-UI_BORDER_SPACING-1;

    self.panels = {};

    local options;
    for k,v in ipairs(self.panelInfo) do
        options = v.panelClass:new(x, y, w, h);
        options:initialise();
        options:instantiate();
        options:setAnchorRight(true);
        options:setAnchorLeft(true);
        options:setAnchorTop(true);
        options:setAnchorBottom(true);
        options.moveWithMouse = true;
        options.doStencilRender = true;
        options:addScrollBars();
        options.vscroll:setVisible(true);
        self:addChild(options);
        options:setScrollChildren(true);
        options.onMouseWheel = ISDebugUtils.onMouseWheel;

        v.panel = options;
        --self.climateOptions = options;
        table.insert(self.panels, self.climateOptions);

        if k>1 then
            options:setEnabled(false);
            options:setVisible(false);
        end
    end

end

function ISDebugPanelBase:onClick(_button)
    if _button.customData == "close" then
        self:close();
        return;
    end
    for k,v in ipairs(self.panelInfo) do
        if v.button==_button then
            v.panel:setEnabled(true);
            v.panel:setVisible(true);
            if v.panel.onMadeActive then
                v.panel:onMadeActive();
            end
        else
            v.panel:setEnabled(false);
            v.panel:setVisible(false);
        end
    end
end

function ISDebugPanelBase:onMadeActive()
    for k,v in ipairs(self.panelInfo) do
        if v.panel and v.panel:getIsVisible() and v.panel:isEnabled() and v.panel.onMadeActive then
            v.panel:onMadeActive();
        end
    end
end

function ISDebugPanelBase:update()
    ISPanel.update(self);
end

function ISDebugPanelBase:close()
    self:setVisible(false);
    self:removeFromUIManager();
    ISDebugPanelBase.instance = nil
end

function ISDebugPanelBase:new(x, y, width, height, title)
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
    --ISDebugPanelBase.instance = o
    return o;
end



