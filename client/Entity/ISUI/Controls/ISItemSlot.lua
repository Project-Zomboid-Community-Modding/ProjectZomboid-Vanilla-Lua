--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

ISItemSlot = ISPanel:derive("ISItemSlot");

local MOUSE_NONE = 0;
local MOUSE_OVER = 1;
local MOUSE_ITEM_VALID = 2;
local MOUSE_ITEM_INVALID = 3;

function ISItemSlot:initialise()
    ISPanel.initialise(self)
end

function ISItemSlot:createChildren()

end

function ISItemSlot:prerender()
    ISPanel.prerender(self);

    if self.toolTip and not self:isMouseOver() then
        self:deactivateToolTip();
    end
end

function ISItemSlot:render()
    local c = self.boxOccupied and self.backgroundColor or self.backgroundEmpty;
    local c2 = self.borderColor;

    if self.mouseOverState > MOUSE_NONE then
        c = self.backgroundHover;
        if self.mouseOverState == MOUSE_OVER then
            --c2 = ;
        elseif self.mouseOverState == MOUSE_ITEM_VALID then
            c2 = self.borderValid;
        elseif self.mouseOverState == MOUSE_ITEM_INVALID then
            c2 = self.borderInvalid;
        end
    end
    if self:isLocked() and self.drawBorderLocked then
        c2 = self.borderLockedColor;
    end

    local BLINK_BORDER = false;
    if self.bBlinkBorder then
        c2 = self.borderInvalid;
        BLINK_BORDER = true;
    else
        BLINK_BORDER = false;
    end

    if self.background then
        self:drawRect(0, 0, self:getWidth(), self:getHeight(), c.a, c.r, c.g, c.b);
    end

    if self.actionAdd then
        local delta = self.actionAdd:getJobDelta();
        if delta > 0 and delta<=1 then
            local h = self:getHeight() * delta;
            c = self.actionAddColor;
            self:drawRect(0, 0, self:getWidth(), h, c.a, c.r, c.g, c.b);
        end
    elseif self.actionRemove then
        local delta = self.actionRemove:getJobDelta();
        if delta > 0 and delta<=1 then
            local h = self:getHeight() * delta;
            c = self.actionRemoveColor;
            self:drawRect(0, self:getHeight()-h, self:getWidth(), h, c.a, c.r, c.g, c.b);
        end
    end

    local x,y,w,h=4,4,self:getWidth()-8,self:getHeight()-8;
    if self.background and self.drawInnerBorder then
        x,y,w,h=6,6,self:getWidth()-12,self:getHeight()-12;
    end
    if self.background and self.doBackDropTex and self.backDropTex and not self.storedItemTex then
        self:drawTextureScaled(self.backDropTex, x, y, w, h, self.backDropTexCol.a, self.backDropTexCol.r, self.backDropTexCol.g, self.backDropTexCol.b);
    end

    if not self.hideItem then
        if self.storedItem then
            ISInventoryItem.renderItemIcon(self, self.storedItem, x, y, 1.0, w, h);
        elseif self.storedItemTex then
            self:drawTextureScaled(self.storedItemTex, x, y, w, h, 1.0, 1.0, 1.0, 1.0);
        end
    end

    local a = (self.storedItem or self.storedItemTex) and 1.0 or 0.4;
    if self.actionAdd or self.actionRemove then
        a = 1.0;
    end
    if self.mouseOverState > MOUSE_NONE then
        a = 1.0;
    end
    local origA = a;
    if BLINK_BORDER and self.character then
        local playerIndex = self.character:getPlayerNum();
        a = UIManager.getBlinkAlpha(playerIndex);
    end
    if self.background then
        self:drawRectBorder(0, 0, self:getWidth(), self:getHeight(), a, c2.r, c2.g, c2.b);
        self:drawRectBorder(1, 1, self:getWidth()-2, self:getHeight()-2, a, c2.r, c2.g, c2.b);
        if self.drawInnerBorder then
            --inner
            c = 0.50*a;
            self:drawRectBorder(2, 2, self:getWidth()-4, self:getHeight()-4, 1, c2.r*c, c2.g*c, c2.b*c);
            self:drawRectBorder(3, 3, self:getWidth()-6, self:getHeight()-6, 1, c2.r*c, c2.g*c, c2.b*c);
            c = 0.75*a;
            self:drawRectBorder(self:getWidth()-3, 2, 1, self:getHeight()-4, 1, c2.r*c, c2.g*c, c2.b*c);
            self:drawRectBorder(self:getWidth()-4, 3, 1, self:getHeight()-6, 1, c2.r*c, c2.g*c, c2.b*c);

            self:drawRectBorder(2, self:getHeight()-3, self:getWidth()-4, 1, 1, c2.r*c, c2.g*c, c2.b*c);
            self:drawRectBorder(3, self:getHeight()-4, self:getWidth()-6, 1, 1, c2.r*c, c2.g*c, c2.b*c);
        end
    end

    if self.resource and self.drawProgress and self.resource:getProgress()>0 then
        local delta = self.resource:getProgress();
        if delta > 0 and delta<=1 then
            local h = (self:getHeight()-8) * delta;
            c = self.progressColor;
            self:drawRect(4, self:getHeight()-4-h, 4, h, c.a, c.r, c.g, c.b);
        end
        self:drawRectBorder(4, 4, 4, self:getHeight()-8, a, c2.r, c2.g, c2.b);
    end

    a = origA;
    if self.resource and self.renderItemCount then
        x = self:getWidth()/2;
        y = self:getHeight() - 16;
        local s = tostring(self.resource:storedSize());
        c2 = self.countColor;

        self:drawTextCentre(s, x-1, y+1, 0.0, 0.0, 0.0, 1.0, UIFont.Small);
        self:drawTextCentre(s, x-1, y-1, 0.0, 0.0, 0.0, 1.0, UIFont.Small);
        self:drawTextCentre(s, x+1, y-1, 0.0, 0.0, 0.0, 1.0, UIFont.Small);
        self:drawTextCentre(s, x+1, y+1, 0.0, 0.0, 0.0, 1.0, UIFont.Small);

        self:drawTextCentre(s, x, y, c2.r, c2.g, c2.b, a, UIFont.Small);
    end
end

--[[
function ISItemSlot:renderFilterItems(_x, _y, _alpha, _width, _height)
    if true then
        return; --TODO CURRENTLY DISABLED
    end
    if self.resource and self.filterItems and #self.filterItems>0 then
        if self.filterItemIndex>#self.filterItems then
            --self.filterItemIndex = #self.filterItems>1 and 1 or 0;
            self.filterItemIndex = 1;
        end

        local item = self.filterItems[self.filterItemIndex];
        if item then
            ISInventoryItem.renderScriptItemIcon(self, item, _x, _y, _alpha, _width, _height);
        end

        --todo use UIManager.getBlinkAlpha(playerIndex)
        self.filterCycleCounter = self.filterCycleCounter + 1;
        if self.filterCycleCounter > 40 then
            self.filterCycleCounter = 0;
            self.filterItemIndex = self.filterItemIndex + 1;
        end
    end
end
--]]

function ISItemSlot:update()
    --get storeditem from slot
    if self.resource then
        self:setStoredItem( self.resource:peekItem() );
    end
end

function ISItemSlot:defaultVerifyItem( _itemSlot, _item )
    if _itemSlot.resource then
        return _itemSlot.resource:acceptsItem(_item, false);
    end
    return false;
end

function ISItemSlot:hasValidItemInDrag()
    if not self.mouseEnabled then return false end

    local verifyFunc = self.onVerifyItem or self.defaultVerifyItem;
    if ISMouseDrag.dragging ~= nil and ISMouseDrag.draggingFocus ~= self then
        for k,v in ipairs(ISMouseDrag.dragging) do
            if instanceof(v, "InventoryItem") then
                if verifyFunc( self.functionTarget, self, v ) then return true; end
            elseif v.items and type(v.items)=="table" and #v.items > 1 then
                for k2,v2 in ipairs(v.items) do
                    if k2 ~= 1 and instanceof(v2, "InventoryItem") then
                        if verifyFunc( self.functionTarget, self, v2 ) then return true; end
                    end
                end
            end
        end
    end
end

function ISItemSlot:onMouseMove(dx, dy)
    if not self.mouseEnabled then return; end

    if self:isMouseOver() then
        self:activateToolTip();
    else
        self:deactivateToolTip();
    end

    if self:isLocked() then
        return;
    end

    self.mouseOverState = MOUSE_OVER;
    --(self.allowDropAlways or self.boxOccupied == false) and
    if ISMouseDrag.dragging ~= nil and ISMouseDrag.draggingFocus ~= self then
        if self:hasValidItemInDrag() then
            self.mouseOverState = MOUSE_ITEM_VALID;
        else
            self.mouseOverState = MOUSE_ITEM_INVALID;
        end
    end
end

function ISItemSlot:onMouseMoveOutside(dx, dy)
    if not self.mouseEnabled then return; end

    self:deactivateToolTip();

    self.mouseOverState = MOUSE_NONE;
end

function ISItemSlot:onMouseDown(x, y)
end

local function collectMouseDragItems(_self, _verifyFunc)
    local items = {};

    for k,v in ipairs(ISInventoryPane.getActualItems(ISMouseDrag.dragging)) do
        if _verifyFunc( _self.functionTarget, _self, v ) then
            table.insert(items, v);
        end
    end

    return items;
end

function ISItemSlot:onMouseUp(x, y)
    if not self:getIsVisible() or not self.mouseEnabled then
        return;
    end
    if self:isLocked() then
        return;
    end

    if ISMouseDrag.dragging ~= nil and ISMouseDrag.draggingFocus ~= self then
        --if ((not self.allowDropAlways) and self.boxOccupied == true) then
        --    return;
        --end
        if self.resource and self.resource:isFull() then
            return;
        end

        local items = collectMouseDragItems(self, self.onVerifyItem or self.defaultVerifyItem);

        if #items == 0 then
            return;
        end

        if self.onItemDropped then
            self.onItemDropped( self.functionTarget, self, items )
        else
            self:itemDropped( items );
        end
    else
        -- regular click
        if self.boxOccupied == true then
            if self.onBoxClicked then
                self.onBoxClicked( self.functionTarget, self, false, isKeyDown(Keyboard.KEY_LSHIFT) )
            else
                self:boxClicked( false, isKeyDown(Keyboard.KEY_LSHIFT) )
            end
        end
    end
end

function ISItemSlot:onRightMouseUp(x, y)
    if not self.mouseEnabled then return; end
    if self:isLocked() then
        return;
    end

    if ISMouseDrag.dragging ~= nil and ISMouseDrag.draggingFocus ~= self then
        --if ((not self.allowDropAlways) and self.boxOccupied == true) then
            --return;
        --end
        if self.resource and self.resource:isFull() then
            return;
        end

        local items = collectMouseDragItems(self, self.onVerifyItem or self.defaultVerifyItem);

        if #items == 0 then
            return;
        end

        if self.onItemDropped then
            self.onItemDropped( self.functionTarget, self, { items[1] } )
        else
            self:itemDropped( { items[1] } );
        end
    else
        if self.boxOccupied == true then
            if self.onBoxClicked then
                self.onBoxClicked( self.functionTarget, self, true, isKeyDown(Keyboard.KEY_LSHIFT) )
            else
                self:boxClicked( true, isKeyDown(Keyboard.KEY_LSHIFT) )
            end
        end
    end
end

function ISItemSlot:itemDropped( _items )
    if self.resource then
        local list = ArrayList.new();
        for index,item in ipairs(_items) do
            list:add(item);
        end
        local added = self.resource:offerItems(list);
    end
end

function ISItemSlot:boxClicked( _isRightClick, _isShift )
    if self.resource and self.resource:bp() and self.boxOccupied == true then
        local list = ArrayList.new();
        if not _isRightClick then --TODO THESE ARE CURRENTLY BROKEN
            if not _isShift then
                list = self.resource:removeAllItems(list);
            else
                -- remove items from all slots with ResourceType.Item and same ResourceIO as this slot
                local fabricator = self.resource:getFabricator();
                if fabricator then
                    fabricator:removeAllItems(list, self.resource:bp():getIO());
                end
            end
        else
            if not _isShift then
                local item = self.resource:pollItem();
                if item then
                    list:add(item);
                end
            else
                -- remove items from all slots with ResourceType.Item, both input and output
                local fabricator = self.resource:getFabricator();
                if fabricator then
                    fabricator:removeAllItems(list, ResourceIO.Any);
                end
            end
        end

        for i=0,list:size()-1 do
            local item = list:get(i);
            if item and self.onItemRemove then
                self.onItemRemove( self.functionTarget, self, item );
            end
        end
    end
end

function ISItemSlot:setStoredItem( _item )
    -- set stored item
    if self.storeItem == true then
        if self.storedItem~=_item then
            self.storedItem = _item;
            if self.toolTip then
                self:deactivateToolTip();
                self:activateToolTip();
            end
        end
    end
    if _item then
        self.boxOccupied = true;
        self.storedItemTex = _item:getTex();
    else
        self.boxOccupied = false;
        self.storedItemTex = nil;
    end
end

--[[
function ISItemSlot:setStoredItemFake( _itemTex )
    if _itemTex then
        self.boxOccupied = true;
        self.storedItemTex = _itemTex;
    else
        self.boxOccupied = false;
        self.storedItemTex = nil;
    end
end
--]]

function ISItemSlot:setBackDropTex( _tex, _a, _r, _g, _b )
    self.backDropTex = _tex;
    if _a and _r and _g and _b then
        self.backDropTexCol = { r = _r, g=_g, b=_b, a=_a };
    end
end
function ISItemSlot:setDoBackDropTex( _b )
    self.doBackDropTex = _b;
end

function ISItemSlot:setToolTip( _b, _text )
    self.doToolTip = _b;
    if _b == true and _text then
        self.toolTipText = _text;
    end
end

function ISItemSlot:activateToolTip()
    if self.doToolTip then
        --if self:isLocked() and not self.toolTipTextLocked then
        --    return;
        --end
        if self.toolTip ~= nil then
            self.toolTip:setVisible(true);
            self.toolTip:addToUIManager();
            self.toolTip:bringToTop()
        else
            if self.resource or self.storedItem then
                self.toolTip = ISToolTipInv:new(self.resource or self.storedItem);
                self.toolTip:initialise();
                self.toolTip:addToUIManager();
                self.toolTip:setOwner(self);
                self.toolTip:setCharacter(self.character);
            elseif self.toolTipText or (self.boxOccupied and self.toolTipTextItem) or (self:isLocked() and self.toolTipTextLocked) then
                self.toolTip = ISToolTip:new();
                self.toolTip:initialise();
                self.toolTip:addToUIManager();
                self.toolTip:setOwner(self);
                self.toolTip.description = self.toolTipText;
                if self.boxOccupied and self.toolTipTextItem then
                    self.toolTip.description = self.toolTipTextItem;
                end
                if self:isLocked() and self.toolTipTextLocked then
                    self.toolTip.description = self.toolTipTextLocked;
                end
                self.toolTip:doLayout();
            end
        end
    end
end

function ISItemSlot:deactivateToolTip()
    if self.toolTip then
        self.toolTip:removeFromUIManager();
        self.toolTip:setVisible(false);
        self.toolTip = nil;
    end
end

function ISItemSlot:setCharacter( _character )
    self.character = _character;
end

function ISItemSlot:setResource(_resource)
    if self.resource~= _resource then
        self.resource = _resource;
        if self.resource:getChannel()~=ResourceChannel.NO_CHANNEL then
            self.borderColor = colorToTable(self.resource:getChannel():getColor());
        else
            self.borderColor = self.borderColorOrig;
        end
    end
end

function ISItemSlot:isLocked()
    return self.locked or (self.resource and self.resource:isLocked());
end

function ISItemSlot:setLocked(_b)
    self.locked = _b;
end

--todo remove slot from params or trigger setSlot
function ISItemSlot:new (x, y, width, height, resource, target, onItemDropped, onItemRemove, onVerifyItem, onBoxClicked)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.background = true;
    o.backgroundColor = {r=0.1, g=0.1, b=0.1, a=1.0};
    o.backgroundEmpty = {r=0.1, g=0.1, b=0.1, a=1.0};
    o.backgroundHover = {r=0.3, g=0.3, b=0.3, a=1.0};

    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    --o.borderInput = {r=0.4, g=0.4, b=0.4, a=1};
    --o.borderOutput = {r=0.4, g=0.4, b=0.4, a=1};
    --o.borderNeutral = {r=0.4, g=0.4, b=0.4, a=1};
    o.borderValid = {r=0.0, g=1.0, b=0.0, a=1};
    o.borderInvalid = {r=1.0, g=0.0, b=0.0, a=1};

    o.actionAddColor = {r=0.2, g=0.8, b=0.2, a=1};
    o.actionRemoveColor = {r=0.8, g=0.2, b=0.2, a=1};

    o.progressColor = {r=0.8, g=0.8, b=0.2, a=1 };

    o.renderItemCount = true;
    o.countColor = {r=1.0, g=1.0, b=1.0, a=1.0};
    --o.countInvalidColor = {r=255/255, g=70/255, b=70/255, a=1.0};

    o.drawBorderLocked = false;
    o.borderLockedColor = {r=1.0, g=1.0, b=0.8, a=1};

    o.drawInnerBorder = true;

    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.mouseOverState = MOUSE_NONE;
    o.boxOccupied = false;

    -- functions that can be overriden/customized
    o.functionTarget = target;
    o.onItemDropped = onItemDropped; --when items dragged under mouse are dropped in box
    o.onBoxClicked = onBoxClicked;
    o.onVerifyItem = onVerifyItem; --when items are checked to see if box can accept
    o.onItemRemove = onItemRemove; --when item gets removed in default 'boxClicked'
    --end
    o.character = nil;
    o.resource = resource; --slotcontroller slot
    --o.resourceIO = ResourceIO.Any; --todo remove instead do borders with style
    o.storeItem = true; --store java item interally y,n?
    o.storedItem = nil; --javaobj
    o.storedItemTex = nil; --itemtex for display
    o.hideItem = false;
    --optional stuff:
    o.doBackDropTex = false;
    o.backDropTex = nil;
    o.backDropTexCol = { r = 1, g=1, b=1, a=1 };
    --tooptil
    o.doToolTip = true;
    o.toolTipText = false;
    --toggle mouse functionallity
    o.mouseEnabled = true;
    -- if true locks the box from user input
    o.locked = false;
    --tooltip for when there is an item stored
    o.toolTipTextItem = false;
    --tooltip when box isLocked
    o.toolTipTextLocked = false;
    o.bBlinkBorder = false;

    o.borderColorOrig = o.borderColor;
    if o.resource and o.resource:getChannel()~=ResourceChannel.NO_CHANNEL then
        o.borderColor = colorToTable(o.resource:getChannel():getColor());
    end

    o.drawProgress = false;

    return o
end
