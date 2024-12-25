--***********************************************************
--**                    THE INDIE STONE                    **
--**				    Author: Aiteron				       **
--***********************************************************

ISRemoveItemTool = ISPanelJoypad:derive("ISRemoveItemTool");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.NewLarge)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISRemoveItemTool:initialise()
    ISPanelJoypad.initialise(self)

    local th = self:titleBarHeight()
    local y = th + UI_BORDER_SPACING*2+FONT_HGT_LARGE+1

    local buttonWid = UI_BORDER_SPACING*2 + math.max(
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_RemoveItemTool_SelectArea")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Remove")),
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Close"))
    )
    self:setWidth(buttonWid * 3 + UI_BORDER_SPACING * 4)

    self.itemType = ISRadioButtons:new(self:getWidth()/2 - 50, y, 150, 20, self, self.onItemType)
    self.itemType.choicesColor = {r=1, g=1, b=1, a=1}
    self.itemType:initialise()
    self.itemType.autoWidth = true;
    self:addChild(self.itemType)
    self.itemType:addOption(getText("IGUI_RemoveItemTool_Items"));
    self.itemType:addOption(getText("IGUI_RemoveItemTool_Corpses"))
    self.itemType:setSelected(1)

    self:setHeight(self.itemType:getBottom() + UI_BORDER_SPACING*2 + BUTTON_HGT + 1)

    self.select = ISButton:new(UI_BORDER_SPACING, self:getHeight() - UI_BORDER_SPACING - 1 - BUTTON_HGT, buttonWid, BUTTON_HGT, getText("IGUI_RemoveItemTool_SelectArea"), self, ISRemoveItemTool.onClick);
    self.select.internal = "SELECT";
    self.select:initialise();
    self.select:instantiate();
    self.select.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.select);

    self.remove = ISButton:new(self.select:getRight() + UI_BORDER_SPACING, self.select.y, buttonWid, BUTTON_HGT, getText("IGUI_DebugMenu_Remove"), self, ISRemoveItemTool.onClick);
    self.remove.internal = "REMOVE";
    self.remove:initialise();
    self.remove:instantiate();
    self.remove.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.remove);

    self.close = ISButton:new(self.remove:getRight() + UI_BORDER_SPACING, self.select.y, buttonWid, BUTTON_HGT, getText("IGUI_DebugMenu_Close"), self, ISRemoveItemTool.onClick);
    self.close.internal = "CLOSE";
    self.close:initialise();
    self.close:instantiate();
    self.close:enableCancelColor()
    self:addChild(self.close);
end

function ISRemoveItemTool:onItemType(buttons, index)
    if index == 1 then
        if self.marker then
            self.marker:setActive(false)
        end
    else
        if self.marker then
            self.marker:setActive(true)
        end
    end
end

function ISRemoveItemTool:destroy()
    self:setVisible(false);
    self:removeFromUIManager();
end

function ISRemoveItemTool:onClick(button)
    if button.internal == "SELECT" then
        self.selectStart = true
        self.selectEnd = false
        self.startPos = nil
        self.endPos = nil
        self.zPos = self.player:getZ()
        self.highlightSquares = {}
        if self.marker then
            self.marker:remove()
            self.marker = nil
        end

        if self.OnRenderTick == nil then
            self.OnRenderTick = function()
                if self.marker == nil or not self.marker:isActive() then
                    for _, sqFloor in ipairs(self.highlightSquares) do
                        sqFloor:setHighlighted(true)
                    end
                end
            end
            Events.OnRenderTick.Add(self.OnRenderTick)
        end
    end
    if button.internal == "REMOVE" then
        if self.startPos ~= nil and self.endPos ~= nil then
            local itemBuffer = {}
            for x = self.startPos.x, self.endPos.x do
                for y = self.startPos.y, self.endPos.y do
                    local sq = getSquare(x, y, self.zPos)

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
                elseif self.itemType:isSelected(2) and not isClient() then
                    sq:removeCorpse(item, false);
                end
            end
            if self.itemType:isSelected(2) and isClient() then
                SendCommandToServer(string.format("/removezombies -x %d -y %d -z %d -radius %d -clear true", math.floor(self.marker:getX()), math.floor(self.marker:getY()), math.floor(self.marker:getZ()), math.floor(self.marker:getSize())))
            end
            if self.OnRenderTick ~= nil then
                Events.OnRenderTick.Remove(self.OnRenderTick)
                self.OnRenderTick = nil
                self.highlightSquares = {}
            end
            if self.marker then
                self.marker:remove()
                self.marker = nil
            end
        end
    end
    if button.internal == "CLOSE" then
        if self.OnRenderTick ~= nil then
            Events.OnRenderTick.Remove(self.OnRenderTick)
            self.OnRenderTick = nil
            self.highlightSquares = {}
        end
        if self.marker then
            self.marker:remove()
            self.marker = nil
        end
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

    self:drawTextCentre(getText("IGUI_DebugContext_RemoveItemTool"), self:getWidth() / 2, UI_BORDER_SPACING+th+1, 1, 1, 1, 1, UIFont.NewLarge);
end

function ISRemoveItemTool:render()
    if self.selectStart then
        local xx, yy = ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled(), self.zPos)
        local sq = getSquare(math.floor(xx), math.floor(yy), self.zPos)
        if sq and sq:getFloor() then self.highlightSquares = { sq:getFloor() } end
    elseif self.selectEnd then
        local xx, yy = ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled(), self.zPos)
        xx = math.floor(xx)
        yy = math.floor(yy)
        local x1 = math.min(xx, self.startPos.x)
        local x2 = math.max(xx, self.startPos.x)
        local y1 = math.min(yy, self.startPos.y)
        local y2 = math.max(yy, self.startPos.y)

        self.highlightSquares = {}
        for x = x1, x2 do
            for y = y1, y2 do
                local sq = getSquare(x, y, self.zPos)
                if sq and sq:getFloor() then table.insert(self.highlightSquares, sq:getFloor()) end
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
        self.highlightSquares = {}
        local x1 = math.min(self.startPos.x, self.endPos.x)
        local x2 = math.max(self.startPos.x, self.endPos.x)
        local y1 = math.min(self.startPos.y, self.endPos.y)
        local y2 = math.max(self.startPos.y, self.endPos.y)
        self.startPos.x = x1
        self.startPos.y = y1
        self.endPos.x = x2
        self.endPos.y = y2
        for _x = x1, x2 do
            for _y = y1, y2 do
                local sq = getSquare(_x, _y, self.zPos)
                if sq and sq:getFloor() then
                    table.insert(self.highlightSquares, sq:getFloor())
                end
            end
        end

        if isClient() then
            local centerX = self.startPos.x + (self.endPos.x - self.startPos.x)/2.0
            local centerY = self.startPos.y + (self.endPos.y - self.startPos.y)/2.0
            local radius = math.floor(math.min((self.endPos.x - self.startPos.x)/2.0, (self.endPos.y - self.startPos.y)/2.0))
            local square = getSquare(centerX, centerY, self.zPos)
            if square then
                self.marker = getWorldMarkers():addGridSquareMarker(square, 0.8, 0.8, 0.0, true, radius)
                self.marker:setScaleCircleTexture(true);
                self.marker:setActive(self.itemType:isSelected(2))
            end
        end
    end
end

function ISRemoveItemTool:new(x, y, player)
    local o = ISPanelJoypad:new(x, y, 1000, 1000);
    setmetatable(o, self)
    self.__index = self
    o.width = 1000;
    o.height = 1000;

    if y == 0 then
        o.y = o:getMouseY() - (o.height / 2)
        o:setY(o.y)
    end
    if x == 0 then
        o.x = o:getMouseX() - (o.width / 2)
        o:setX(o.x)
    end
    o.name = nil;
    o.backgroundColor = {r=0, g=0, b=0, a=0.5};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
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
    local srcContainer = item:getContainer()
    local playerObj = getSpecificPlayer(player)

    srcContainer:DoRemoveItem(item);
    if isServer() then
        sendRemoveItemFromContainer(srcContainer, item)
    end
    if isClient() then
        SendCommandToServer("/removeitem " .. item:getFullType() .. " " .. 1)
    end

    if srcContainer:getType() == "floor" and item:getWorldItem() ~= nil then
        DesignationZoneAnimal.removeFoodFromGround(item:getWorldItem())
        if instanceof(item, "Radio") then
            local grabSquare = item:getWorldItem():getSquare()
            local _obj = nil
            for i=0, grabSquare:getObjects():size()-1 do
                local tObj = grabSquare:getObjects():get(i)
                if instanceof(tObj, "IsoRadio") then
                    if tObj:getModData().RadioItemID == item:getID() then
                        _obj = tObj
                        break
                    end
                end
            end
            if _obj ~= nil then
                local deviceData = _obj:getDeviceData()
                if deviceData then
                    item:setDeviceData(deviceData)
                end
                grabSquare:transmitRemoveItemFromSquare(_obj)
                grabSquare:RecalcProperties()
                grabSquare:RecalcAllWithNeighbours(true)
            end
        end

        item:getWorldItem():getSquare():transmitRemoveItemFromSquare(item:getWorldItem())
        item:getWorldItem():getSquare():removeWorldObject(item:getWorldItem())
        --item:getWorldItem():getSquare():getObjects():remove(item:getWorldItem())
        item:setWorldItem(nil)
    elseif playerObj:getInventory() == srcContainer then
        playerObj:removeAttachedItem(item)
        if not playerObj:isEquipped(item) then return end
        playerObj:removeFromHands(item)
        playerObj:removeWornItem(item, false)
        triggerEvent("OnClothingUpdated", playerObj)
    end
end

function ISRemoveItemTool.removeItems(items, player)
    for i, item in ipairs(items) do
        ISRemoveItemTool.removeItem(item, player)
    end
end

--************************************************************************--

local function RemoveItemContextOptions(player, context, items)

    if not isDebugEnabled() or (isClient() and not getPlayer():getRole():haveCapability(Capability.EditItem)) then
        return true
    end

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

