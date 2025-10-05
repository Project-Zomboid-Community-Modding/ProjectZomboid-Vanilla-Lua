--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_CombinationWasherDryerToggle = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_CombinationWasherDryerToggle")
local Handler = ISLootWindowObjectControlHandler_CombinationWasherDryerToggle

function Handler:shouldBeVisible()
    if getCore():getGameMode() == "Tutorial" then return false end
    if not instanceof(self.object, "IsoCombinationWasherDryer") then return false end
    if self.object:isModeWasher() and self.object:getFluidAmount() <= 0 then return false end
    return (self.container ~= nil) and self.container:isPowered()
end

function Handler:getControl()
    local xln = nil
	if self.object:isActivated() then
        xln = "ContextMenu_Turn_Off"
    else
       xln = "ContextMenu_Turn_On"
    end
    self.control = self:getButtonControl(getText(xln))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local xln = nil
	if self.object:isActivated() then
        xln = "ContextMenu_Turn_Off"
    else
        xln = "ContextMenu_Turn_On"
    end
    local option = self:addJoypadContextMenuOption(context, getText(xln))
    option.iconTexture = self.object:isModeWasher() and ContainerButtonIcons.clothingwasher or  ContainerButtonIcons.clothingdryer
end

function Handler:perform()
    if self.object:getSquare() and luautils.walkAdj(self.playerObj, self.object:getSquare()) then
        ISTimedActionQueue.add(ISToggleComboWasherDryer:new(self.playerObj, self.object))
    end
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
