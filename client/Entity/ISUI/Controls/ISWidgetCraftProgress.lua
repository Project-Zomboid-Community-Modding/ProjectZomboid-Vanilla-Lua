--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);

ISWidgetCraftProgress = ISPanel:derive("ISWidgetCraftProgress");

function ISWidgetCraftProgress:initialise()
	ISPanel.initialise(self);
end

function ISWidgetCraftProgress:createChildren()
    ISPanel.createChildren(self);

    local style = self.styleBar or "S_ProgressBar_Craft";
    self.progressBar = ISXuiSkin.build(self.xuiSkin, style, ISProgressBar, 0, 0, 150, 20, false, UIFont.Small);
    --self.progressBar.progressColor = namedColorToTable("ProgressYellow"); --{r=1.0, g=0.95, b=0.4, a=1};
    --self.progressBar.progressTexture = self.horzTexture;
    self.progressBar:initialise();
    self.progressBar:instantiate();
    self:addChild(self.progressBar);

    self.originalBarWidth = self.progressBar:getWidth();
    self.originalBarHeight = self.progressBar:getHeight();
end

function ISWidgetCraftProgress:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local margin2x = self.margin*2;

    if self.autoFillContents or self.progressBar.isAutoFill or self.progressBar.isAutoFillX then
        self.progressBar:setWidth(math.max(self.originalBarWidth, width - margin2x));
    else
        self.progressBar:setWidth(self.originalBarWidth);
    end

    if self.autoFillContents or self.progressBar.isAutoFill or self.progressBar.isAutoFillY then
        self.progressBar:setHeight(math.max(self.originalBarHeight, height - margin2x));
    else
        self.progressBar:setHeight(self.originalBarHeight);
    end

    width = math.max(width, self.progressBar:getWidth() + margin2x);
    height = math.max(height, self.progressBar:getHeight() + margin2x);

    local x = (width/2) - (self.progressBar:getWidth()/2);
    local y = (height/2) - (self.progressBar:getHeight()/2);

    self.progressBar:setX(x);
    self.progressBar:setY(y);

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetCraftProgress:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISWidgetCraftProgress:prerender()
    ISPanel.prerender(self);

    if self.callbackTarget and self.onGetProgress then
        self.progressBar:setProgress(self.onGetProgress(self.callbackTarget));
    end
end

function ISWidgetCraftProgress:render()
    ISPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0.5, 0, 1);
    end
end

function ISWidgetCraftProgress:update()
    ISPanel.update(self);
end

function ISWidgetCraftProgress:onGetProgress()
    return 0;
end

--************************************************************************--
--** ISWidgetCraftProgress:new
--**
--************************************************************************--
function ISWidgetCraftProgress:new (x, y, width, height, player, entity, callbackTarget, _styleBar)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.entity = entity;
    o.callbackTarget = callbackTarget;
    o.background = false;

    o.margin = 5;

    o.styleBar = _styleBar;

    o.minimumWidth = 0;
    o.minimumHeight = 0;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end