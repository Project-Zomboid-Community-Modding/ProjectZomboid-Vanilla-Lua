--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "BuildingRooms/ISBuildingRoomsEditor_ToolAddRect"

ISBuildingRoomsEditor_ToolAddBuilding = ISBuildingRoomsEditor_ToolAddRect:derive("ISBuildingRoomsEditor_ToolAddBuilding")

function ISBuildingRoomsEditor_ToolAddBuilding:getAPrompt()
    if self.choosingEndLocation then
        return getText("IGUI_BuildingRoomsEditor_ButtonAddBuilding")
    end
    return getText("IGUI_BuildingRoomsEditor_SetStartLocation")
end

function ISBuildingRoomsEditor_ToolAddBuilding:getLBPrompt()
    return nil
end

function ISBuildingRoomsEditor_ToolAddBuilding:getRBPrompt()
    return nil
end

function ISBuildingRoomsEditor_ToolAddBuilding:new(editor)
    local o = ISBuildingRoomsEditor_ToolAddRect.new(self, editor)
    o.mode = "AddBuilding"
    return o
end