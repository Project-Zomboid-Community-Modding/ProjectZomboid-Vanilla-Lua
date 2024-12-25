--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);

ISWidgetCraftControl = ISPanel:derive("ISWidgetCraftControl");

function ISWidgetCraftControl:initialise()
	ISPanel.initialise(self);
end

function ISWidgetCraftControl:createChildren()
    ISPanel.createChildren(self);

    local style = self.styleButton or "S_Button_Craft";
    self.buttonStart = ISXuiSkin.build(self.xuiSkin, style, ISButton, 0, 0, 150, FONT_HGT_SMALL+8, nil) --craft
    --self.buttonRepair.image = (not self.showInfo) and self.iconInfo or self.iconPanel;
    self.buttonStart.target = self;
    self.buttonStart.onclick = ISWidgetCraftControl.onButtonClick;
    self.buttonStart.enable = false;
    self.buttonStart:initialise();
    self.buttonStart:instantiate();
    self:addChild(self.buttonStart);

    self.buttonStart:setWidthToTitle(self.buttonStart.width);

    self.originalButtonWidth = self.buttonStart:getWidth();
    self.originalButtonHeight = self.buttonStart:getHeight();
end

function ISWidgetCraftControl:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local margin2x = self.margin*2;

    if self.autoFillContents or self.buttonStart.isAutoFill or self.buttonStart.isAutoFillX then
        self.buttonStart:setWidthToTitle(math.max(self.originalButtonWidth, width - margin2x));
    else
        self.buttonStart:setWidthToTitle(self.originalButtonWidth);
    end

    local font_height = getTextManager():getFontHeight(self.buttonStart.font);

    if self.autoFillContents or self.buttonStart.isAutoFill or self.buttonStart.isAutoFillY then
        local h = math.max(font_height+8, height - margin2x);
        self.buttonStart:setHeight(math.max(self.originalButtonHeight, h));
    else
        self.buttonStart:setHeight(self.originalButtonHeight);
    end

    width = math.max(width, self.buttonStart:getWidth() + margin2x);
    height = math.max(height, self.buttonStart:getHeight() + margin2x);

    local x = (width/2) - (self.buttonStart:getWidth()/2);
    local y = (height/2) - (self.buttonStart:getHeight()/2);

    self.buttonStart:setX(x);
    self.buttonStart:setY(y);

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetCraftControl:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISWidgetCraftControl:prerender()
    ISPanel.prerender(self);

end

function ISWidgetCraftControl:render()
    ISPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0.5, 1.0, 0.5);
    end
end

function ISWidgetCraftControl:update()
    ISPanel.update(self);

    if self.callbackTarget and self.onGetIsStartEnabled then
        self.buttonStart.enable = self.onGetIsStartEnabled(self.callbackTarget);
    else
        self.buttonStart.enable = false;
    end
end

function ISWidgetCraftControl:onButtonClick(_button)
    if self.buttonStart and _button==self.buttonStart then
        if self.callbackTarget and self.onStart then
            self.onStart(self.callbackTarget);
        end
    end
end

function ISWidgetCraftControl:onGetIsStartEnabled()
    return false;
end

function ISWidgetCraftControl:onStart()
    print("OnStart callback not set...")
    return false;
end

--************************************************************************--
--** ISWidgetCraftControl:new
--**
--************************************************************************--
function ISWidgetCraftControl:new (x, y, width, height, player, entity, component, callbackTarget, _styleButton)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.entity = entity;
    o.component = component;
    o.callbackTarget = callbackTarget;

    o.background = false;

    o.styleButton = _styleButton;

    o.margin = 5;
    o.minimumWidth = 0;
    o.minimumHeight = 0;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end