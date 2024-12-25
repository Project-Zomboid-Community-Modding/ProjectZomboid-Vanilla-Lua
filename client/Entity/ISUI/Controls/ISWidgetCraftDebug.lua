--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

--[[
    Add a canStart test debug button for craft grid components
--]]

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);

ISWidgetCraftDebug = ISPanel:derive("ISWidgetCraftDebug");

function ISWidgetCraftDebug:initialise()
	ISPanel.initialise(self);
end

function ISWidgetCraftDebug:createChildren()
    ISPanel.createChildren(self);

    if getDebug() then
        local style = self.styleButton or "S_Button_DebugCraft";
        self.buttonDebug = ISXuiSkin.build(self.xuiSkin, style, ISButton, 0, 0, 150, FONT_HGT_SMALL+8, "debug craft")
        --self.buttonRepair.image = (not self.showInfo) and self.iconInfo or self.iconPanel;
        self.buttonDebug.target = self;
        self.buttonDebug.onclick = ISWidgetCraftDebug.onButtonClick;
        self.buttonDebug.enable = true;
        self.buttonDebug:initialise();
        self.buttonDebug:instantiate();
        self:addChild(self.buttonDebug);

        self.buttonDebug:setWidthToTitle(self.buttonDebug.width);

        self.originalButtonWidth = self.buttonDebug:getWidth();
        self.originalButtonHeight = self.buttonDebug:getHeight();
    else
        print("Warning -> ISWidgetCraftDebug created in non-debug")
    end
end

function ISWidgetCraftDebug:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    if self.buttonDebug then
        local margin2x = self.margin*2;

        if self.autoFillContents or self.buttonDebug.isAutoFill or self.buttonDebug.isAutoFillX then
            self.buttonDebug:setWidthToTitle(math.max(self.originalButtonWidth, width - margin2x));
        else
            self.buttonDebug:setWidthToTitle(self.originalButtonWidth);
        end

        local font_height = getTextManager():getFontHeight(self.buttonDebug.font);

        if self.autoFillContents or self.buttonDebug.isAutoFill or self.buttonDebug.isAutoFillY then
            local h = math.max(font_height+8, height - margin2x);
            self.buttonDebug:setHeight(math.max(self.originalButtonHeight, h));
        else
            self.buttonDebug:setHeight(self.originalButtonHeight);
        end

        width = math.max(width, self.buttonDebug:getWidth() + margin2x);
        height = math.max(height, self.buttonDebug:getHeight() + margin2x);

        local x = (width/2) - (self.buttonDebug:getWidth()/2);
        local y = (height/2) - (self.buttonDebug:getHeight()/2);

        self.buttonDebug:setX(x);
        self.buttonDebug:setY(y);
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetCraftDebug:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISWidgetCraftDebug:prerender()
    ISPanel.prerender(self);

end

function ISWidgetCraftDebug:render()
    ISPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0.5, 1.0, 0.5);
    end
end

function ISWidgetCraftDebug:update()
    ISPanel.update(self);
end

function ISWidgetCraftDebug:onButtonClick(_button)
    if self.buttonDebug and _button==self.buttonDebug then
        if self.callbackTarget and self.onStartDebug then
            self.onStartDebug(self.callbackTarget);
        end
    end
end

function ISWidgetCraftDebug:onStartDebug()
    print("onStartDebug callback not set...")
    return false;
end

--************************************************************************--
--** ISWidgetCraftDebug:new
--**
--************************************************************************--
function ISWidgetCraftDebug:new (x, y, width, height, player, entity, component, callbackTarget, _styleButton)
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