--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "BuildingObjects/ISBuildingObject"

ISBuildingRoomsEditor_ToolAddRect = ISBuildingObject:derive("ISBuildingRoomsEditor_ToolAddRect")

function ISBuildingRoomsEditor_ToolAddRect:create(x, y, z, north, sprite)
    if getJoypadData(self.playerNum) and not self.choosingEndLocation then
        self.startX = x
        self.startY = y
        self.choosingEndLocation = true
        return
    end
    local x1,y1,x2,y2 = self:getRectangle(x, y)
    self.choosingEndLocation = false
    local room = self.editor:getSelectedRoom()
    if self.mode == "AddBuilding" or self.mode == "AddRoom" then room = nil end
    if not self.javaEditor:canAddRoomRectangle(room, x1, y1, x2 - x1 + 1, y2 - y1 + 1, z) then
        self.editor:setCurrentTool(nil)
        return
    end
    if self.mode == "AddBuilding" then
        local building = self.javaEditor:createBuilding()
        local room = building:createRoom(z)
        room:addRectangle(x1, y1, x2 - x1 + 1, y2 - y1 + 1)
        self.editor:setCurrentTool(nil)
        self.editor.hasChanges = true
    end
    if self.mode == "AddRoom" then
        local room = self.editor:getSelectedBuilding():createRoom(z)
        room:addRectangle(x1, y1, x2 - x1 + 1, y2 - y1 + 1)
        self.editor.hasChanges = true
    end
    if self.mode == "AddRect" then
        room:addRectangle(x1, y1, x2 - x1 + 1, y2 - y1 + 1)
        self.editor.hasChanges = true
    end
end

function ISBuildingRoomsEditor_ToolAddRect:isValid(square)
    return true
end

function ISBuildingRoomsEditor_ToolAddRect:render(x, y, z, square)
    local room = self.editor:getSelectedRoom()
    if self.mode == "AddBuilding" or self.mode == "AddRoom" then room = nil end
    local r,g,b,a = self.zoneColor.r, self.zoneColor.g, self.zoneColor.b, self.zoneColor.a
    if self.isLeftDown or self.choosingEndLocation then
        local x1,y1,x2,y2 = self:getRectangle(x, y)
        local width = (x2 - x1) + 1
        local height = (y2 - y1) + 1
        if not self.javaEditor:canAddRoomRectangle(room, x1, y1, width, height, z) then
            r,g,b = 1,0,0
        end
        addAreaHighlightForPlayer(self.playerNum, x1, y1, x2 + 1, y2 + 1, z, r, g, b, a)
        return
    end
    if not self.javaEditor:canAddRoomRectangle(room, x, y, 1, 1, z) then
        r,g,b = 1,0,0
    end
    addAreaHighlightForPlayer(self.playerNum, x, y, x + 1, y + 1, z, r, g, b, a)
end

function ISBuildingRoomsEditor_ToolAddRect:activate()
    self:reset()
end

function ISBuildingRoomsEditor_ToolAddRect:deactivate()
    self.editor.currentTool = nil
    self:reset()
    if self.editor:isVisible() and getJoypadData(self.playerNum) then
        self.editor.previousFocusTool = self
        setJoypadFocus(self.playerNum, self.editor)
    end
end

function ISBuildingRoomsEditor_ToolAddRect:getRectangle(x, y)
    local x1,y1 = x, y
    local square,x2,y2,z2 = self:pickSquare(getMouseX(), getMouseY())
    if self.choosingEndLocation then -- joypad
        local z = self.character:getCurrentSquare():getZ()
        x = self.startX
        y = self.startY
        square,x2,y2,z2 = getCell():getGridSquare(x, y, z), x, y, z
    end
    if x1 > x2 then
        local tmp = x1
        x1 = x2
        x2 = tmp
    end
    if y1 > y2 then
        local tmp = y1
        y1 = y2
        y2 = tmp
    end
    return x1,y1,x2,y2
end

function ISBuildingRoomsEditor_ToolAddRect:pickSquare(screenX, screenY)
    local playerIndex = self.playerNum
    local z = self.character:getCurrentSquare():getZ()
    local worldX = screenToIsoX(playerIndex, screenX, screenY, z)
    local worldY = screenToIsoY(playerIndex, screenX, screenY, z)
    worldX = math.floor(worldX)
    worldY = math.floor(worldY)
    return getCell():getGridSquare(worldX, worldY, z), worldX, worldY, z
end

function ISBuildingRoomsEditor_ToolAddRect:reset()
    ISBuildingObject.reset(self)
    self.choosingEndLocation = false
    ISWorldObjectContextMenu.disableWorldMenu = false
end

function ISBuildingRoomsEditor_ToolAddRect:getAPrompt()
    if self.choosingEndLocation then
        return getText("IGUI_BuildingRoomsEditor_ButtonAddRectangle")
    end
    return getText("IGUI_BuildingRoomsEditor_SetStartLocation")
end

function ISBuildingRoomsEditor_ToolAddRect:getLBPrompt()
    return nil
end

function ISBuildingRoomsEditor_ToolAddRect:getRBPrompt()
    return nil
end

function ISBuildingRoomsEditor_ToolAddRect:new(editor)
    local o = ISBuildingObject.new(self)
    -- ISBuildingObject fields
    o.player = 0
    o.character = getSpecificPlayer(o.player)
	o.skipBuildAction = true
	o.noNeedHammer = true
	o.skipWalk = true
    -- Our fields
    o.editor = editor
    o.javaEditor = editor.javaEditor
    o.playerNum = o.player
    o.mode = "AddRect"
    o.zoneColor = {r=DesignationZoneAnimal.ZONECOLORR, g=DesignationZoneAnimal.ZONECOLORG, b=DesignationZoneAnimal.ZONECOLORB, a=0.5}
    return o
end