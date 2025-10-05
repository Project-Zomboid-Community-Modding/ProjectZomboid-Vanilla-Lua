--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_CombinationWasherDryerSetMode = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_CombinationWasherDryerSetMode")
local Handler = ISLootWindowObjectControlHandler_CombinationWasherDryerSetMode

function Handler:shouldBeVisible()
    if getCore():getGameMode() == "Tutorial" then return false end
    if not instanceof(self.object, "IsoCombinationWasherDryer") then return false end
    if self.object:isModeWasher() and self.object:getFluidAmount() <= 0 then return false end
    return (self.container ~= nil) and self.container:isPowered()
end

function Handler:getControl()
    local xln = nil
	if self.object:isModeWasher() then
        xln = "ContextMenu_ComboWasherDryer_SetModeDryer"
    else
        xln = "ContextMenu_ComboWasherDryer_SetModeWasher"
    end
    self.control = self:getButtonControl(getText(xln))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local xln = nil
	if self.object:isModeWasher() then
        xln = "ContextMenu_ComboWasherDryer_SetModeDryer"
    else
        xln = "ContextMenu_ComboWasherDryer_SetModeWasher"
    end
    local option = self:addJoypadContextMenuOption(context, getText(xln))
    option.iconTexture = self.object:isModeWasher() and ContainerButtonIcons.clothingwasher or  ContainerButtonIcons.clothingdryer
end

function Handler:perform()
    ISWorldObjectContextMenu.onSetComboWasherDryerMode(self.playerObj, self.object, self.object:isModeWasher() and "dryer" or "washer")
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
