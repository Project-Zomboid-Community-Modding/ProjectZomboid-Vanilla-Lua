--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_StoveSettings = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_StoveSettings")
local Handler = ISLootWindowObjectControlHandler_StoveSettings

function Handler:shouldBeVisible()
    if getCore():getGameMode() == "Tutorial" then return false end
    return instanceof(self.object, "IsoStove") and (self.container ~= nil) and self.container:isPowered()
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("ContextMenu_StoveSetting"))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local option = self:addJoypadContextMenuOption(context, getText("ContextMenu_StoveSetting"))
    option.iconTexture = ContainerButtonIcons[self.container:getType()]
end

function Handler:perform()
    if self.object:isMicrowave() then
        ISWorldObjectContextMenu.onMicrowaveSetting(nil, self.object, self.playerNum)
    else
        ISWorldObjectContextMenu.onStoveSetting(nil, self.object, self.playerNum)
    end
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
