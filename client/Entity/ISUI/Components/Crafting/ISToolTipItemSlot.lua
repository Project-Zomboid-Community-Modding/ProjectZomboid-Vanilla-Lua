--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "ISUI/ISPanel"

ISToolTipItemSlot = ISPanel:derive("ISToolTipItemSlot");

--************************************************************************--
--** ISToolTipItemSlot:initialise
--**
--************************************************************************--

function ISToolTipItemSlot:initialise()
    ISPanel.initialise(self);
end

function ISToolTipItemSlot:setItem(item)
    self.item = item;
end

function ISToolTipItemSlot:onMouseDown(x, y)
    return false
end

function ISToolTipItemSlot:onMouseUp(x, y)
    return false
end

function ISToolTipItemSlot:onMouseDownOutside(x, y)
    if self.followMouse then
        self:setVisible(false)
    end
end

function ISToolTipItemSlot:onRightMouseDown(x, y)
    return false
end

function ISToolTipItemSlot:onRightMouseUp(x, y)
    return false
end

--************************************************************************--
--** ISToolTipItemSlot:render
--**
--************************************************************************--

function ISToolTipItemSlot:prerender()
    if self.owner and not self.owner:isReallyVisible() then
        self:removeFromUIManager()
        self:setVisible(false)
        return
    end
end

function ISToolTipItemSlot:render()
    -- we render the tool tip for inventory item only if there's no context menu showed
    if not ISContextMenu.instance or not ISContextMenu.instance.visibleCheck then

        local mx = getMouseX() + 24;
        local my = getMouseY() + 24;
        if not self.followMouse then
            mx = self:getX()
            my = self:getY()
            if self.anchorBottomLeft then
                mx = self.anchorBottomLeft.x
                my = self.anchorBottomLeft.y
            end
        end

        local PADX = 0

        self.tooltip:setX(mx + PADX);
        self.tooltip:setY(my);

        self.tooltip:setWidth(50)
        self.tooltip:setMeasureOnly(true)
        if self.itemSlot then self.itemSlot:drawTooltip(self.tooltip) end;
        self.tooltip:setMeasureOnly(false)

        -- clampy x, y

        local myCore = getCore();
        local maxX = myCore:getScreenWidth();
        local maxY = myCore:getScreenHeight();

        local tw = self.tooltip:getWidth();
        local th = self.tooltip:getHeight();

        self.tooltip:setX(math.max(0, math.min(mx + PADX, maxX - tw - 1)));
        if not self.followMouse and self.anchorBottomLeft then
            self.tooltip:setY(math.max(0, math.min(my - th, maxY - th - 1)));
        else
            self.tooltip:setY(math.max(0, math.min(my, maxY - th - 1)));
        end

        self:setX(self.tooltip:getX() - PADX);
        self:setY(self.tooltip:getY());
        self:setWidth(tw + PADX);
        self:setHeight(th);

        if self.followMouse then
            self:adjustPositionToAvoidOverlap({ x = mx - 24 * 2, y = my - 24 * 2, width = 24 * 2, height = 24 * 2 })
        end

        self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
        self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
        if self.itemSlot then self.itemSlot:drawTooltip(self.tooltip) end;
    end
end


function ISToolTipItemSlot:adjustPositionToAvoidOverlap(avoidRect)
    local myRect = { x = self.x, y = self.y, width = self.width, height = self.height }
    if self:overlaps(myRect, avoidRect) then
        local r = self:placeRight(myRect, avoidRect)
        if self:overlaps(r, avoidRect) then
            r = self:placeAbove(myRect, avoidRect)
            if self:overlaps(r, avoidRect) then
                r = self:placeLeft(myRect, avoidRect)
            end
        end
        self.tooltip:setX(r.x)
        self.tooltip:setY(r.y)
        self:setX(r.x - 11)
        self:setY(r.y)
    end
end

function ISToolTipItemSlot:overlaps(r1, r2)
    return r1.x + r1.width > r2.x and r1.x < r2.x + r2.width and
            r1.y + r1.height > r2.y and r1.y < r2.y + r2.height
end

function ISToolTipItemSlot:placeLeft(r1, r2)
    local r = r1
    r.x = math.max(0, r2.x - r.width - 8)
    return r
end

function ISToolTipItemSlot:placeRight(r1, r2)
    local r = r1
    r.x = r2.x + r2.width + 8
    r.x = math.min(r.x, getCore():getScreenWidth() - r.width)
    return r
end

function ISToolTipItemSlot:placeAbove(r1, r2)
    local r = r1
    r.y = r2.y - r.height - 8
    r.y = math.max(0, r.y)
    return r
end

function ISToolTipItemSlot:setOwner(ui)
    self.owner = ui
end

function ISToolTipItemSlot:setCharacter(chr)
    self.tooltip:setCharacter(chr)
end

--************************************************************************--
--** ISToolTipItemSlot:new
--**
--************************************************************************--
function ISToolTipItemSlot:new(itemSlot)
    local o = {}
    o = ISPanel:new(0, 0, 0, 0);
    setmetatable(o, self)
    self.__index = self
    o.tooltip = ObjectTooltip.new();
    
    o.itemSlot = itemSlot;
    o.item = itemSlot.resource or itemSlot.storedItem;

    o.tooltip:setX(0);
    o.tooltip:setY(0);

    o.x = 0;
    o.y = 0;

    o.toolTipDone = false;

    o.backgroundColor = {r=0, g=0, b=0, a=0.5};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = 0;
    o.height = 0;
    o.anchorLeft = false;
    o.anchorRight = false;
    o.anchorTop = false;
    o.anchorBottom = false;

    o.owner = nil
    o.followMouse = true
    o.anchorBottomLeft = nil
    return o;
end
