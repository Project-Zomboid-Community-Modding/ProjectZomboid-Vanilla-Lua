--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "BuildingRooms/ISBuildingRoomsEditor_ToolAddRect"

ISBuildingRoomsEditor_ToolAddRoom = ISBuildingRoomsEditor_ToolAddRect:derive("ISBuildingRoomsEditor_ToolAddRoom")

function ISBuildingRoomsEditor_ToolAddRoom:getAPrompt()
    if self.choosingEndLocation then
        return getText("IGUI_BuildingRoomsEditor_ButtonAddRoom")
    end
    return getText("IGUI_BuildingRoomsEditor_SetStartLocation")
end

function ISBuildingRoomsEditor_ToolAddRoom:getLBPrompt()
    return nil
end

function ISBuildingRoomsEditor_ToolAddRoom:getRBPrompt()
    return nil
end

function ISBuildingRoomsEditor_ToolAddRoom:new(editor)
    local o = ISBuildingRoomsEditor_ToolAddRect.new(self, editor)
    o.mode = "AddRoom"
    return o
end