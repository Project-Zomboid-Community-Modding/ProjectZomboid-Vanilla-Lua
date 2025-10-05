--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_AddFuelOption = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_AddFuelOption")
local Handler = ISLootWindowObjectControlHandler_AddFuelOption

function Handler:shouldBeVisible()
    if CCampfireSystem.instance:isValidIsoObject(self.object) then
        campfire = CCampfireSystem.instance:getLuaObjectOnSquare(self.object:getSquare())
        if campfire then
            return true
        end
        return false
    end
    if self.object:isFireInteractionObject() and (not self.object:isPropaneBBQ()) then
        return true
    end
    return false
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("ContextMenu_DestroyForFuel"))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
	local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(self.object:getSquare())
	local fuelInfo = ISCampingMenu.getNearbyFuelInfo(self.playerObj)
	local fuelAmount = 0
	if campfire then
        fuelAmount = campfire.fuelAmt or 0
    else
        fuelAmount = self.object:getFuelAmount()
    end
	if campfire then
	    ISCampingMenu.doAddFuelOption(context, nil, fuelAmount, fuelInfo, campfire, ISAddFuelAction, self.playerObj)
    else
	    ISCampingMenu.doAddFuelOption(context, nil, fuelAmount, fuelInfo, self.object, ISBBQAddFuel, self.playerObj)
    end
end

function Handler:perform()
    if isGamePaused() then return end
	local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(self.object:getSquare())
	local fuelInfo = ISCampingMenu.getNearbyFuelInfo(self.playerObj)
	local fuelAmount = 0
	if campfire then
        fuelAmount = campfire.fuelAmt or 0
    else
        fuelAmount = self.object:getFuelAmount()
    end

    local x = self:getControl():getX() + self.lootWindow:getX()
    local y = self:getControl():getY() + self.lootWindow:getY() + self.lootWindow:getHeight()

    local context = ISContextMenu.get(self.playerObj:getPlayerNum(), x, y)
    if (y < 0) then y = 0 end

	if campfire then
	    ISCampingMenu.doAddFuelOption(context, nil, fuelAmount, fuelInfo, campfire, ISAddFuelAction, self.playerObj)
    else
	    ISCampingMenu.doAddFuelOption(context, nil, fuelAmount, fuelInfo, self.object, ISBBQAddFuel, self.playerObj)
    end
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
