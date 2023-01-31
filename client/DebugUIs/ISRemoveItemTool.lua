--***********************************************************
--**                    THE INDIE STONE                    **
--**				    Author: Aiteron				       **
--***********************************************************

ISRemoveItemTool = ISPanelJoypad:derive("ISRemoveItemTool");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

function ISRemoveItemTool:initialise()
    ISPanelJoypad.initialise(self);

    local fontHgt = FONT_HGT_SMALL
    local buttonWid1 = getTextManager():MeasureStringX(UIFont.Small, "Select area") + 12
    local buttonWid2 = getTextManager():MeasureStringX(UIFont.Small, "Remove") + 12
    local buttonWid3 = getTextManager():MeasureStringX(UIFont.Small, "Close") + 12
    local buttonWid = math.max(math.max(buttonWid1, buttonWid2, buttonWid3), 100)
    local buttonHgt = math.max(fontHgt + 6, 25)
    local padBottom = 10

    self.select = ISButton:new((self:getWidth() / 6) - buttonWid/2, self:getHeight() - padBottom - buttonHgt, buttonWid, buttonHgt, "Select area", self, ISRemoveItemTool.onClick);
    self.select.internal = "SELECT";
    self.select:initialise();
    self.select:instantiate();
    self.select.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.select);

    self.remove = ISButton:new((self:getWidth() / 2) - buttonWid/2, self:getHeight() - padBottom - buttonHgt, buttonWid, buttonHgt, "Remove", self, ISRemoveItemTool.onClick);
    self.remove.internal = "REMOVE";
    self.remove:initialise();
    self.remove:instantiate();
    self.remove.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.remove);

    self.close = ISButton:new((self:getWidth() / 6)*5 - buttonWid/2, self:getHeight() - padBottom - buttonHgt, buttonWid, buttonHgt, "Close", self, ISRemoveItemTool.onClick);
    self.close.internal = "CLOSE";
    self.close:initialise();
    self.close:instantiate();
    self.close.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.close);

    self.itemType = ISRadioButtons:new(self:getWidth()/2 - 50, 55, 150, 20, self)
    self.itemType.choicesColor = {r=1, g=1, b=1, a=1}
    self.itemType:initialise()
    self.itemType.autoWidth = true;
    self:addChild(self.itemType)
    self.itemType:addOption("Items");
    self.itemType:addOption("Corpses")
    self.itemType:setSelected(1)
end

function ISRemoveItemTool:destroy()
    self:setVisible(false);
    self:removeFromUIManager();
end

function ISRemoveItemTool:onClick(button)
    if button.internal == "SELECT" then
        self.selectEnd = false
        self.startPos = nil
        self.endPos = nil
        self.zPos = self.player:getZ()
        self.selectStart = true
    end
    if button.internal == "REMOVE" then
        if self.startPos ~= nil and self.endPos ~= nil then
            local cell = getCell()
            local x1 = math.min(self.startPos.x, self.endPos.x)
            local x2 = math.max(self.startPos.x, self.endPos.x)
            local y1 = math.min(self.startPos.y, self.endPos.y)
            local y2 = math.max(self.startPos.y, self.endPos.y)
            local itemBuffer = {}
            for x = x1, x2 do
                for y = y1, y2 do
                    local sq = cell:getGridSquare(x, y, self.zPos)

                    if self.itemType:isSelected(1) then
                        for i=0, sq:getObjects():size()-1 do
                            if instanceof(sq:getObjects():get(i), "IsoWorldInventoryObject") then
                                local item = sq:getObjects():get(i)
                                table.insert(itemBuffer, { it = item, square = sq })
                            end
                        end
                    elseif self.itemType:isSelected(2) then
                        for i=0, sq:getStaticMovingObjects():size()-1 do
                            if instanceof(sq:getStaticMovingObjects():get(i), "IsoDeadBody") then
                                local item = sq:getStaticMovingObjects():get(i)
                                table.insert(itemBuffer, { it = item, square = sq })
                            end
                        end
                    end
                end
            end
            for i, itemData in ipairs(itemBuffer) do
                local sq = itemData.square
                local item = itemData.it
                if self.itemType:isSelected(1) then
                    sq:transmitRemoveItemFromSquare(item);
                    item:removeFromWorld()
                    item:removeFromSquare()
                    item:setSquare(nil)
                elseif self.itemType:isSelected(2) then
                    sq:removeCorpse(item, false);
                end
            end
        end
    end
    if button.internal == "CLOSE" then
        self:destroy();
        return;
    end
end

function ISRemoveItemTool:titleBarHeight()
    return 16
end

function ISRemoveItemTool:prerender()
    self.backgroundColor.a = 0.8

    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);

    local th = self:titleBarHeight()
    self:drawTextureScaled(self.titlebarbkg, 2, 1, self:getWidth() - 4, th - 2, 1, 1, 1, 1);

    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    self:drawTextCentre("Remove item tool", self:getWidth() / 2, 20, 1, 1, 1, 1, UIFont.NewLarge);
end

function ISRemoveItemTool:render()
    if self.selectStart then
        local xx, yy = ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled(), self.zPos)
        local sq = getCell():getGridSquare(math.floor(xx), math.floor(yy), self.zPos)
        if sq and sq:getFloor() then sq:getFloor():setHighlighted(true) end
    elseif self.selectEnd then
        local xx, yy = ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled(), self.zPos)
        xx = math.floor(xx)
        yy = math.floor(yy)
        local cell = getCell()
        local x1 = math.min(xx, self.startPos.x)
        local x2 = math.max(xx, self.startPos.x)
        local y1 = math.min(yy, self.startPos.y)
        local y2 = math.max(yy, self.startPos.y)

        for x = x1, x2 do
            for y = y1, y2 do
                local sq = cell:getGridSquare(x, y, self.zPos)
                if sq and sq:getFloor() then sq:getFloor():setHighlighted(true) end
            end
        end
    elseif self.startPos ~= nil and self.endPos ~= nil then
        local cell = getCell()
        local x1 = math.min(self.startPos.x, self.endPos.x)
        local x2 = math.max(self.startPos.x, self.endPos.x)
        local y1 = math.min(self.startPos.y, self.endPos.y)
        local y2 = math.max(self.startPos.y, self.endPos.y)
        for x = x1, x2 do
            for y = y1, y2 do
                local sq = cell:getGridSquare(x, y, self.zPos)
                if sq and sq:getFloor() then sq:getFloor():setHighlighted(true) end
            end
        end
    end
end

function ISRemoveItemTool:onMouseMove(dx, dy)
    self.mouseOver = true
    if self.moving then
        self:setX(self.x + dx)
        self:setY(self.y + dy)
        self:bringToTop()
    end
end

function ISRemoveItemTool:onMouseMoveOutside(dx, dy)
    self.mouseOver = false
    if self.moving then
        self:setX(self.x + dx)
        self:setY(self.y + dy)
        self:bringToTop()
    end
end

function ISRemoveItemTool:onMouseDown(x, y)
    if not self:getIsVisible() then
        return
    end
    self.downX = x
    self.downY = y
    self.moving = true
    self:bringToTop()
end

function ISRemoveItemTool:onMouseUp(x, y)
    if not self:getIsVisible() then
        return;
    end
    self.moving = false
    if ISMouseDrag.tabPanel then
        ISMouseDrag.tabPanel:onMouseUp(x,y)
    end
    ISMouseDrag.dragView = nil
end

function ISRemoveItemTool:onMouseUpOutside(x, y)
    if not self:getIsVisible() then
        return
    end
    self.moving = false
    ISMouseDrag.dragView = nil
end

function ISRemoveItemTool:onMouseDownOutside(x, y)
    local xx, yy = ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled(), self.zPos)
    if self.selectStart then
        self.startPos = { x = math.floor(xx), y = math.floor(yy) }
        self.selectStart = false
        self.selectEnd = true
    elseif self.selectEnd then
        self.endPos = { x = math.floor(xx), y = math.floor(yy) }
        self.selectEnd = false
    end
end

function ISRemoveItemTool:new(x, y, width, height, player)
    local o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self

    if y == 0 then
        o.y = o:getMouseY() - (height / 2)
        o:setY(o.y)
    end
    if x == 0 then
        o.x = o:getMouseX() - (width / 2)
        o:setX(o.x)
    end
    o.name = nil;
    o.backgroundColor = {r=0, g=0, b=0, a=0.5};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = true;
    o.anchorTop = true;
    o.anchorBottom = true;
    o.player = player;
    o.titlebarbkg = getTexture("media/ui/Panel_TitleBar.png");
    o.numLines = 1
    o.maxLines = 1
    o.multipleLine = false

    o.selectStart = false
    o.selectEnd = false
    o.startPos = nil
    o.endPos = nil
    o.zPos = 0

    return o;
end

--************************************************************************--
--************************************************************************--

function ISRemoveItemTool.removeItem(item, player)
    if item:getWorldItem() ~= nil then
        item:getWorldItem():getSquare():transmitRemoveItemFromSquare(item:getWorldItem());
        item:getWorldItem():removeFromWorld()
        item:getWorldItem():removeFromSquare()
        item:getWorldItem():setSquare(nil)
        getPlayerLoot(player):refreshBackpacks()
        return
    end

    if item:isEquipped() then
        local playerObj = item:getContainer():getParent()

        item:getContainer():setDrawDirty(true);
        item:setJobDelta(0.0);
        playerObj:removeWornItem(item)

        local hotbar = getPlayerHotbar(playerObj:getPlayerNum())
        local fromHotbar = false;
        if hotbar then
            fromHotbar = hotbar:isItemAttached(item);
        end

        if fromHotbar then
            hotbar.chr:setAttachedItem(item:getAttachedToModel(), item);
            playerObj:resetEquippedHandsModels()
        end

        if item == playerObj:getPrimaryHandItem() then
            if (item:isTwoHandWeapon() or item:isRequiresEquippedBothHands()) and item == playerObj:getSecondaryHandItem() then
                playerObj:setSecondaryHandItem(nil);
            end
            playerObj:setPrimaryHandItem(nil);
        end
        if item == playerObj:getSecondaryHandItem() then
            if (item:isTwoHandWeapon() or item:isRequiresEquippedBothHands()) and item == playerObj:getPrimaryHandItem() then
                playerObj:setPrimaryHandItem(nil);
            end
            playerObj:setSecondaryHandItem(nil);
        end
    end

    if isClient() and not instanceof(item:getOutermostContainer():getParent(), "IsoPlayer") and item:getContainer():getType()~="floor" then
        item:getContainer():removeItemOnServer(item);
    end

    item:getContainer():DoRemoveItem(item);
end

function ISRemoveItemTool.removeItems(items, player)
    for i, item in ipairs(items) do
        ISRemoveItemTool.removeItem(item, player)
    end
end

--************************************************************************--

local function RemoveItemContextOptions(player, context, items)
    if not (isDebugEnabled() or (isClient() and (isAdmin() or getAccessLevel() ~= ""))) then return true; end

    local container = nil
    local resItems = {}
    for i,v in ipairs(items) do
        if not instanceof(v, "InventoryItem") then
            for _, it in ipairs(v.items) do
                resItems[it] = true
            end
            container = v.items[1]:getContainer()
        else
            resItems[v] = true
            container = v:getContainer()
        end
    end

    local listItems = {}
    for v, _ in pairs(resItems) do
        table.insert(listItems, v)
    end

    local removeOption = context:addDebugOption("Delete:")
    local subMenuRemove = ISContextMenu:getNew(context)
    context:addSubMenu(removeOption, subMenuRemove)

    subMenuRemove:addOption("1 item", listItems[1], ISRemoveItemTool.removeItem, player)
    subMenuRemove:addOption("selected", listItems, ISRemoveItemTool.removeItems, player)
end
Events.OnFillInventoryObjectContextMenu.Add(RemoveItemContextOptions)

