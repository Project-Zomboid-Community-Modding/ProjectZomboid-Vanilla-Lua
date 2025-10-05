--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_RemoveCampfire = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_RemoveCampfire")
local Handler = ISLootWindowObjectControlHandler_RemoveCampfire

function Handler:shouldBeVisible()
    if not CCampfireSystem.instance:isValidIsoObject(self.object) then return end
    local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(self.object:getSquare())
    if campfire and not campfire.isLit then
        return true
    end
    return false
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("ContextMenu_Remove_fire"))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local option = self:addJoypadContextMenuOption(context, getText("ContextMenu_Remove_fire"))
    option.iconTexture = ContainerButtonIcons[self.container:getType()]
end

function Handler:perform()
    if isGamePaused() then return end
	local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(self.object:getSquare())
    if campfire and not campfire.isLit then
        if ISCampingMenu.walkToCampfire(self.playerObj, campfire:getSquare()) then
            ISTimedActionQueue.add(ISRemoveCampfireAction:new(self.playerObj, campfire, 60));
        end
    end
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
