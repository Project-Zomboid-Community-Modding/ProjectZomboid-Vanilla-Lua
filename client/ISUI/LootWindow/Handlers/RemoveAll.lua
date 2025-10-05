--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_RemoveAll = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_RemoveAll")
local Handler = ISLootWindowObjectControlHandler_RemoveAll

function Handler:shouldBeVisible()
	if self.lootWindow.onCharacter then return false end
	if self.lootWindow.inventory:isEmpty() then return false end
	if isClient() and not getServerOptions():getBoolean("TrashDeleteAll") then return false end
	if not instanceof(self.object, "IsoObject") then return false end
	local sprite = self.object:getSprite()
	return sprite and sprite:getProperties() and sprite:getProperties():Is("IsTrashCan")
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("IGUI_invpage_RemoveAll"))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local option = self:addJoypadContextMenuOption(context, getText("IGUI_invpage_RemoveAll"))
    option.iconTexture = ContainerButtonIcons.bin
end

function Handler:perform()
    if isGamePaused() then return end
    self.lootWindow.inventoryPane:removeAll(self.playerNum)
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
