--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 13/08/2021
-- Time: 10:25
-- To change this template use File | Settings | File Templates.
--

--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isServer() then return end

require "BuildingObjects/ISBuildingObject"

ISPlace3DItemCursor = ISBuildingObject:derive("ISPlace3DItemCursor");

local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

function ISPlace3DItemCursor:create(x, y, z, north, sprite)
    showDebugInfoInChat("Cursor Create \'ISPlace3DItemCursor\' "..tostring(x)..", "..tostring(y)..", "..tostring(z)..", "..tostring(north)..", "..tostring(sprite))
    local drop = self.itemSq == nil; -- nil when the item is in a vehicle
    if self.itemSq and luautils.walkAdj(self.chr, self.itemSq, true) then
        drop = true;
    end
    if not drop then return; end
    for i,v in ipairs(self.items) do
--        if not v:getWorldItem() or not AdjacentFreeTileFinder.isTileOrAdjacent(self.selectedSqDrop, v:getWorldItem():getSquare()) then
            ISWorldObjectContextMenu.transferIfNeeded(self.chr, v)
--        end
    end
    if self.chr:getJoypadBind() == -1 then
        self.placeAll = isShiftKeyDown()
    end
    if self.placeAll then
        if luautils.walkAdjAltTest(self.chr, self.selectedSqDrop, self.itemSq, true) then
            for i,v in ipairs(self.items) do
                if self.chr:isEquipped(v) then
                    ISTimedActionQueue.add(ISUnequipAction:new(self.chr, v, 1));
                end
                ISTimedActionQueue.add(ISDropWorldItemAction:new(self.chr, v, self.selectedSqDrop, self.render3DItemXOffset, self.render3DItemYOffset, self.render3DItemZOffset, self.render3DItemRot, #self.items > 1));
            end
        end
    else
        local item = table.remove(self.items, 1)
        if luautils.walkAdjAltTest(self.chr, self.selectedSqDrop, self.itemSq, true) then
            if self.chr:isEquipped(item) then
                ISTimedActionQueue.add(ISUnequipAction:new(self.chr, item, 1));
            end
            ISTimedActionQueue.add(ISDropWorldItemAction:new(self.chr, item, self.selectedSqDrop, self.render3DItemXOffset, self.render3DItemYOffset, self.render3DItemZOffset, self.render3DItemRot, false));
        end
        if #self.items > 0 then
            getCell():setDrag(self, self.chr:getPlayerNum())
        end
    end
    self.keepOnSquare = false
end

function ISPlace3DItemCursor:walkTo(x, y, z)
    return true
end

function ISPlace3DItemCursor:isValid(square)
    if not self.previousSq then
        self.previousSq = square;
    end
    if self.previousSq ~= square then -- reset the selected high when changing sq
        self.previousSq = square;
        self.surfaceSelected = 1;
    end
    if self.chr:getCharacterActions():isEmpty() and not self.chr:isSittingOnFurniture() then
        self.chr:faceLocation(square:getX(), square:getY())
    end
--    print("render X/Y", self.render3DItemXOffset, self.render3DItemYOffset, self.render3DItemRot)
    if not luautils.walkAdjTest(self.chr, square) then
        return false
    end
    local totalWeight = 0
    if self.placeAll then
        for _,item in ipairs(self.items) do
            totalWeight = totalWeight + item:getUnequippedWeight()
        end
    else
        local item = self.items[1]
        totalWeight = totalWeight + item:getUnequippedWeight()
    end
	if square:getTotalWeightOfItemsOnFloor() + totalWeight >= 50 then
		return false
	end
    if not square:isCouldSee(self.chr:getPlayerNum()) then
        return false
    end
    if square:isWallTo(self.chr:getCurrentSquare()) or square:isWindowTo(self.chr:getCurrentSquare()) then
        return false
    end
    local surface = self:getSurface(square)
    if (surface == 0) and (square:isSolid() or square:isSolidTrans() or not square:TreatAsSolidFloor()) then
        return false
    end
    return true;
end

function ISPlace3DItemCursor:render(x, y, z, square)
    if not square or not self:isValid(square) then
        self:getFloorCursorSprite():RenderGhostTileColor(x, y, z, 1.0, 0.0, 0.0, 0.2)
        self.chr:setIgnoreMovement(false) -- for joypad Y button
        return
    end
    self:getFloorCursorSprite():RenderGhostTileColor(x, y, z, 1.0, 1.0, 1.0, 0.2)


--    ISPlace3DItemCursor.panel:drawText("Press R/Shift-R to rotate", 0, 0, 1, 1, 1, 1, UIFont.Medium);

--    ISEquippedItem.instance:drawText(getText("IGUI_Place3DItem_Rotate", getKeyName(getCore():getKey("Rotate building")), getKeyName(42)), 0, 200, 1, 1, 1, 1, UIFont.Small);
--    if self.surfacesPossible and #self.surfacesPossible > 1 then
--        ISEquippedItem.instance:drawText(getText("IGUI_Place3DItem_Surface", getKeyName(getCore():getKey("Toggle mode"))), 0, 220, 1, 1, 1, 1, UIFont.Small);
--    end
end

function ISPlace3DItemCursor:renderOpaqueObjectsInWorld(x, y, z, square)
    self:checkRotateKey()
    self:checkSelectSurfaceKey()
    self:checkRotateJoypad()
    self:checkPositionJoypad()

    local worldX = x + 0.5
    local worldY = y + 0.5
    if self.chr:getPlayerNum() == 0 and (self.chr:getJoypadBind() == -1 or wasMouseActiveMoreRecentlyThanJoypad()) then
        worldX = screenToIsoX(self.player, getMouseX(), getMouseY(), math.floor(self.chr:getZ()))
        worldY = screenToIsoY(self.player, getMouseX(), getMouseY(), math.floor(self.chr:getZ()))
        if self.isLeftDown then
            if not self.keepOnSquare then
                self.keepOnSquare = true
                self.keepOnSquareX = math.floor(worldX)
                self.keepOnSquareY = math.floor(worldY)
            end
        else
            self.keepOnSquare = false;
        end
        if self.keepOnSquare then
            worldX = PZMath.clampFloat(worldX, self.keepOnSquareX + 0.05, self.keepOnSquareX + 0.95)
            worldY = PZMath.clampFloat(worldY, self.keepOnSquareY + 0.05, self.keepOnSquareY + 0.95)
        end
    end
    if self.chr:getJoypadBind() ~= -1 and not (self.chr:getPlayerNum() == 0 and wasMouseActiveMoreRecentlyThanJoypad()) then
        worldX = x + self.joypadPositionX
        worldY = y + self.joypadPositionY
    end
    local sq = getSquare(worldX, worldY, self.chr:getZ());
    if not sq then
        return;
    end
    self.render3DItemXOffset = worldX - sq:getX();
    self.render3DItemYOffset = worldY - sq:getY();
    self.render3DItemZOffset = self:getSurface(sq);
    if square and (square:HasStairs() or square:hasSlopedSurface()) then
        self.render3DItemZOffset = square:getApparentZ(self.render3DItemXOffset, self.render3DItemYOffset)
    end
    self.selectedSqDrop = sq;
    if self.placeAll then
        for i,v in ipairs(self.items) do
            -- ensure you're not too far
            local sq = nil;
            if v:getWorldItem() then
                sq = v:getWorldItem():getSquare();
            end
            local container = v:getOutermostContainer()
            if container then
                if container:getParent() then
                    sq = container:getParent():getSquare();
                end
                if container:getContainingItem() and container:getContainingItem():getWorldItem() then
                    sq = container:getContainingItem():getWorldItem():getSquare()
                end
            end
            self.itemSq = sq;
            if container and container:getVehiclePart() then
                self.itemSq = nil
            end
            Render3DItem(v, self.selectedSqDrop, worldX, worldY, self.selectedSqDrop:getZ() + self.render3DItemZOffset, self:clamp(self.render3DItemRot));
        end
    else
        local item = self.items[1]
        local sq = nil;
        if item:getWorldItem() then
            sq = item:getWorldItem():getSquare();
        end
        local container = item:getOutermostContainer()
        if container then
            if container:getParent() then
                sq = container:getParent():getSquare();
            end
            if container:getContainingItem() and container:getContainingItem():getWorldItem() then
                sq = container:getContainingItem():getWorldItem():getSquare()
            end
        end
        self.itemSq = sq;
        if container and container:getVehiclePart() then
            self.itemSq = nil
        end
        Render3DItem(item, self.selectedSqDrop, worldX, worldY, self.selectedSqDrop:getZ() + self.render3DItemZOffset, self:clamp(self.render3DItemRot));
    end
end

function ISPlace3DItemCursor:deactivate()
    self.chr:setIgnoreMovement(false) -- for joypad Y button
    ISBuildingObject.deactivate(self)
end

-- For keyboard & mouse user.
function ISPlace3DItemCursor:drawPrompt(playerNum, ui)
    if playerNum ~= 0 then return end
    if JoypadState.players[playerNum+1] then return end
    local screenX = getPlayerScreenLeft(playerNum)
    local screenY = getPlayerScreenTop(playerNum)
    local screenW = getPlayerScreenWidth(playerNum)
    local screenH = getPlayerScreenHeight(playerNum)
    local y = screenH - (FONT_HGT_MEDIUM * 4)
    local textW = getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_Place3DItem_Rotate"))
    local hotBar = getPlayerHotbar(playerNum)
    if hotBar and hotBar:isReallyVisible() and (screenX + screenW - 30 - textW < hotBar:getRight()) then
        y = hotBar:getY() - FONT_HGT_MEDIUM * 3
    end
    ui:drawTextRight(getText("IGUI_Place3DItem_Rotate", getKeyName(getCore():getKey("Rotate building")), getKeyName(42)), screenX + screenW - 30, y, 1, 1, 1, 1, UIFont.NewMedium);
    y = y + FONT_HGT_MEDIUM;
    if self.surfacesPossible and #self.surfacesPossible > 1 then
        ui:drawTextRight(getText("IGUI_Place3DItem_Surface", getKeyName(getCore():getKey("Toggle mode"))), screenX + screenW - 30, y, 1, 1, 1, 1, UIFont.NewMedium);
    end
end

function ISPlace3DItemCursor:getSurface(square)
    -- check if we have a surface, so we can do a z offset to make items goes on this surface
    -- we list all our possible surface height, allow Shift to switch thru them
--    local surface = 0
    self.surfacesPossible = {};
    for i=1,square:getObjects():size() do
        local object = square:getObjects():get(i-1);
        if object:getSurfaceOffsetNoTable() > 0 then
            -- the surface is in pixel, set for the 1X texture, so we *2 (192 pixels is 1X texture height)
            local newSurf = (object:getSurfaceOffsetNoTable() / 96);
            local add = true;
            for x,j in ipairs(self.surfacesPossible) do
                if j == newSurf then
                    add = false;
                    break;
                end
            end
            if add then
                table.insert(self.surfacesPossible, newSurf)
            end
--            if newSurf > surface then
--                surface = newSurf;
--            end
        end
    end
--    print(self.surfacesPossible[2])
--    print("total possible surface: ")
--    for x,j in ipairs(self.surfacesPossible) do
--        print(x, j)
--    end
    return self.surfacesPossible[self.surfaceSelected] or 0;
end

function ISPlace3DItemCursor:rotateDelta()
    return 0.75 * getGameTime():getMultiplier() / 1.6
end

function ISPlace3DItemCursor:clamp(rot)
    -- Clamp to 10-degree intervals
    return round(rot / 5, 0) * 5
end

function ISPlace3DItemCursor:checkSelectSurfaceKey() -- switch between our possible surface height when pressing Shift
    if self.chr:getPlayerNum() ~= 0 then return end
    if self.chr:getJoypadBind() ~= -1 then return end
    local pressed = isKeyPressed("Toggle mode")
    if pressed then
        self.surfaceSelected = self.surfaceSelected + 1;
        if self.surfaceSelected > #self.surfacesPossible then
            self.surfaceSelected = 1;
        end
    end
end

function ISPlace3DItemCursor:checkRotateKey()
    if self.chr:getPlayerNum() ~= 0 then return end
    if self.chr:getJoypadBind() ~= -1 then return end
    local pressed = isKeyDown("Rotate building")
    local reverse = isShiftKeyDown()
    self:handleRotate(pressed, reverse)
end

function ISPlace3DItemCursor:checkRotateJoypad()
    if self.chr:getJoypadBind() == -1 then return end
    if self.joypadPositionActive then
        return
    end
    -- FIXME: the way the model rotates depends on the up-axis
    local reverse = isJoypadLBPressed(self.chr:getJoypadBind())
    local pressed = isJoypadRBPressed(self.chr:getJoypadBind()) or reverse
    self:handleRotate(pressed, reverse)
end

function ISPlace3DItemCursor:handleRotate(pressed, reverse)
    if pressed then
        self.rotateReverse = reverse
        if not self.rotatePressed then
            self.rotatePressed = true
            self.rotateStart = getTimestampMs()
            return
        elseif getTimestampMs() - self.rotateStart > 250 then
            self.rotating = true
        else
            return
        end
        local rot = self.render3DItemRot;
        if reverse then
            rot = rot - 5 * self:rotateDelta();
        else
            rot = rot + 5 * self:rotateDelta();
        end
        if rot < 0 then
            rot = 360;
        end
        if rot > 360 then
            rot = 0;
        end
        self.render3DItemRot = rot;
    else
        if self.rotatePressed then
            self.rotatePressed = false
            local rot = self.render3DItemRot;
            if not self.rotating then
                 -- Quick tap/release rotates 10 degrees
                if self.rotateReverse then
                    rot = rot - 5;
                else
                    rot = rot + 5;
                end
                if rot < 0 then
                    rot = 360;
                end
                if rot > 360 then
                    rot = 0;
                end
            end
            self.render3DItemRot = self:clamp(rot)
        end
        self.rotating = false
    end
end

function ISPlace3DItemCursor:checkPositionJoypad()
    local joypadID = self.chr:getJoypadBind()
    if joypadID == -1 then return end
    self.joypadPositionActive = isJoypadPressed(joypadID, getJoypadYButton(joypadID))
    if self.joypadPositionActive then
        self.chr:setIgnoreMovement(true)
        local axisX = getJoypadMovementAxisX(joypadID)
        local axisY = getJoypadMovementAxisY(joypadID)
        local delta = UIManager.getMillisSinceLastRender() / 33.3 * 0.025
        self.joypadPositionX = PZMath.clampFloat(self.joypadPositionX + axisX * delta, 0.05, 0.95)
        self.joypadPositionY = PZMath.clampFloat(self.joypadPositionY + axisY * delta, 0.05, 0.95)
    else
        self.chr:setIgnoreMovement(false)
    end
end

function ISPlace3DItemCursor:onJoypadPressButton(joypadIndex, joypadData, button)
    if self.joypadPositionActive then
        if button == Joypad.RBumper then
            self.surfaceSelected = self.surfaceSelected + 1
            if self.surfaceSelected > #self.surfacesPossible then
                self.surfaceSelected = 1
            end
        end
        return
    end
    if button == Joypad.XButton then
        self.placeAll = not self.placeAll
    else
        ISBuildingObject.onJoypadPressButton(self, joypadIndex, joypadData, button)
    end
end

function ISPlace3DItemCursor:onJoypadDirDown(joypadData)
    if self.joypadPositionActive then
        self.joypadPositionY = PZMath.clampFloat(self.joypadPositionY + 0.05, 0.05, 0.95)
        return
    end
    return ISBuildingObject.onJoypadDirDown(self, joypadData)
end

function ISPlace3DItemCursor:onJoypadDirUp(joypadData)
    if self.joypadPositionActive then
        self.joypadPositionY = PZMath.clampFloat(self.joypadPositionY - 0.05, 0.05, 0.95)
        return
    end
    return ISBuildingObject.onJoypadDirUp(self, joypadData)
end

function ISPlace3DItemCursor:onJoypadDirRight(joypadData)
    if self.joypadPositionActive then
        self.joypadPositionX = PZMath.clampFloat(self.joypadPositionX + 0.05, 0.05, 0.95)
        return
    end
    return ISBuildingObject.onJoypadDirRight(self, joypadData)
end

function ISPlace3DItemCursor:onJoypadDirLeft(joypadData)
    if self.joypadPositionActive then
        self.joypadPositionX = PZMath.clampFloat(self.joypadPositionX - 0.05, 0.05, 0.95)
        return
    end
    return ISBuildingObject.onJoypadDirLeft(self, joypadData)
end

function ISPlace3DItemCursor:getAPrompt()
    if self.joypadPositionActive then
        return nil
    end
    return getText("ContextMenu_PlaceItemOnGround")
end

function ISPlace3DItemCursor:getBPrompt()
    if self.joypadPositionActive then
        return nil
    end
    return ISBuildingObject.getBPrompt(self)
end

function ISPlace3DItemCursor:getXPrompt()
    if self.joypadPositionActive then
        return nil
    end
    return getText(self.placeAll and "ContextMenu_PlaceAll" or "ContextMenu_PlaceOne")
end

function ISPlace3DItemCursor:getYPrompt()
    return getText("IGUI_Place3DItem_JoypadPosition")
end

function ISPlace3DItemCursor:getLBPrompt()
    if self.joypadPositionActive then
        return nil
    end
    return ISBuildingObject.getLBPrompt(self)
end

function ISPlace3DItemCursor:getRBPrompt()
    if self.joypadPositionActive then
        if #self.surfacesPossible <= 1 then return nil end
        return getText("IGUI_Place3DItem_JoypadSurface")
    end
    return ISBuildingObject.getRBPrompt(self)
end

function ISPlace3DItemCursor:onObjectLeftMouseButtonDown(object, x, y)
    -- Disable clicks on objects, to prevent the loot window being displayed
    return true
end

function ISPlace3DItemCursor:new(character, items)
    local o = {}
    setmetatable(o, self)
    self.__index = self
    o:init()
    o.chr = character
    o.character = character
    o.items = items;
    o.player = character:getPlayerNum()
    o.skipBuildAction = true
    o.noNeedHammer = false
    o.dragNilAfterPlace = true
    o.isYButtonResetCursor = false
    o.render3DItemRot = 0;
    o.surfaceSelected = 1;
    o.placeAll = false
    o.previousSq = nil;
    o.isPlace3DCursor = true;
    o.joypadPositionActive = false;
    o.joypadPositionX = 0.5;
    o.joypadPositionY = 0.5;
    o.dontLockItemToSquare = true;
    showDebugInfoInChat("Cursor New \'ISPlace3DItemCursor\'")
    return o
end

