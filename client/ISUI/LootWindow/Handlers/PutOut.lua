--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_PutOut = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_PutOut")
local Handler = ISLootWindowObjectControlHandler_PutOut

function Handler:shouldBeVisible()
    if CCampfireSystem.instance:isValidIsoObject(self.object) then
        local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(self.object:getSquare())
        if campfire and campfire.isLit then
            return true
        end
        return false
    end
    if self.object:isFireInteractionObject() and (not self.object:isPropaneBBQ()) and self.object:isLit() then
        return true
    end
    return false
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("ContextMenu_Put_out_fire"))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local option = self:addJoypadContextMenuOption(context, getText("ContextMenu_Put_out_fire"))
    option.iconTexture = ContainerButtonIcons[self.container:getType()]
end

function Handler:perform()
    if isGamePaused() then return end
	local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(self.object:getSquare())
    if campfire and campfire.isLit then
        if ISCampingMenu.walkToCampfire(self.playerObj, campfire:getSquare()) then
            ISTimedActionQueue.add(ISPutOutCampfireAction:new(self.playerObj, campfire));
        end
    else
	    ISBBQMenu.onExtinguish(nil, self.playerObj:getPlayerNum(), self.object)
    end
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
