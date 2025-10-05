--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "BuildingObjects/ISBuildingObject"

ISBuildingRoomsEditor_ToolRemoveRect = ISBuildingObject:derive("ISBuildingRoomsEditor_ToolRemoveRect")

function ISBuildingRoomsEditor_ToolRemoveRect:create(x, y, z, north, sprite)
    local room = self.editor:getSelectedRoom()
    if self.mouseOverRect ~= -1 then
        room:removeRectangle(self.mouseOverRect)
        self.mouseOverRect = -1
        self.editor.hasChanges = true
    end
end

function ISBuildingRoomsEditor_ToolRemoveRect:isValid(square)
    return true
end

function ISBuildingRoomsEditor_ToolRemoveRect:render(x, y, z, square)
    local room = self.editor:getSelectedRoom()
    self.mouseOverRect = room:hitTest(x, y)
    self.editor.javaEditor:setHighlightRectForDeletion(self.mouseOverRect)
    if (self.mouseOverRect == -1) or getJoypadData(self.playerNum) then
        local r,g,b,a = self.zoneColor.r, self.zoneColor.g, self.zoneColor.b, self.zoneColor.a
        a = 1
        addAreaHighlightForPlayer(self.playerNum, x, y, x+1, y+1, z, r, g, b, a)
        if self.mouseOverRect == -1 then
            return
        end
    end
--[[
    local rect = room:getRectangle(self.mouseOverRect)
    local r,g,b,a = self.zoneColor.r, self.zoneColor.g, self.zoneColor.b, self.zoneColor.a
    addAreaHighlightForPlayer(self.playerNum, rect:getX(), rect:getY(), rect:getX2(), rect:getY2(), z, r, g, b, a)
 ]]
end

function ISBuildingRoomsEditor_ToolRemoveRect:activate()
    self:reset()
end

function ISBuildingRoomsEditor_ToolRemoveRect:deactivate()
    self.editor.javaEditor:setHighlightRectForDeletion(-1)
    self.editor.currentTool = nil
    self:reset()
    if self.editor:isVisible() and getJoypadData(self.playerNum) then
        self.editor.previousFocusTool = self
        setJoypadFocus(self.playerNum, self.editor)
    end
end

function ISBuildingRoomsEditor_ToolRemoveRect:pickSquare(screenX, screenY)
    local playerIndex = self.playerNum
    local z = self.player:getCurrentSquare():getZ()
    local worldX = screenToIsoX(playerIndex, screenX, screenY, z)
    local worldY = screenToIsoY(playerIndex, screenX, screenY, z)
    return getCell():getGridSquare(worldX, worldY, z), worldX, worldY, z
end

function ISBuildingRoomsEditor_ToolRemoveRect:reset()
    ISBuildingObject.reset(self)
    ISWorldObjectContextMenu.disableWorldMenu = false
end

function ISBuildingRoomsEditor_ToolRemoveRect:getAPrompt()
    if self.mouseOverRect == -1 then return nil end
    return getText("IGUI_BuildingRoomsEditor_ButtonRemoveRectangle")
end

function ISBuildingRoomsEditor_ToolRemoveRect:getLBPrompt()
    return nil
end

function ISBuildingRoomsEditor_ToolRemoveRect:getRBPrompt()
    return nil
end

function ISBuildingRoomsEditor_ToolRemoveRect:new(editor)
    local o = ISBuildingObject.new(self)
    -- ISBuildingObject fields
    o.player = 0
    o.character = getSpecificPlayer(o.player)
	o.skipBuildAction = true
	o.noNeedHammer = true
	o.skipWalk = true
    -- Our fields
    o.editor = editor
    o.playerNum = o.player
    o.zoneColor = {r=1.0, g=0.0, b=0.0, a=0.5}
    return o
end