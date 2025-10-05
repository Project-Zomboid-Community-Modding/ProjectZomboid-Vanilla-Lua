--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_AddCorpseToCampfire = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_AddCorpseToCampfire")
local Handler = ISLootWindowObjectControlHandler_AddCorpseToCampfire

function Handler:shouldBeVisible()
    if not CCampfireSystem.instance:isValidIsoObject(self.object) then return end
    campfire = CCampfireSystem.instance:getLuaObjectOnSquare(self.object:getSquare())
    if self.playerObj:isGrappling() and campfire and not campfire.isLit then
        return true
    end
    return false
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("ContextMenu_CampfireCorpse"))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local option = self:addJoypadContextMenuOption(context, getText("ContextMenu_CampfireCorpse"))
    option.iconTexture = ContainerButtonIcons[self.container:getType()]
end

function Handler:perform()
    if isGamePaused() then return end
	local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(self.object:getSquare())
    if campfire and not campfire.isLit then
        if ISCampingMenu.walkToCampfire(self.playerObj, campfire:getSquare()) then
            ISCampingMenu.onDropCorpse(nil, self.playerObj, self.object, campfire)
        end
    end
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
