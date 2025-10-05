--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"

ISLootWindowObjectControlHandler_LightFireOption = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_LightFireOption")
local Handler = ISLootWindowObjectControlHandler_LightFireOption

function Handler:shouldBeVisible()
    if CCampfireSystem.instance:isValidIsoObject(self.object) then
        local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(self.object:getSquare())
        if campfire and not campfire.isLit then
            return true
        end
        return false
    end
    if self.object:isFireInteractionObject() and (not self.object:isPropaneBBQ()) and (not self.object:isLit()) then
        return true
    end
    return false
end

function Handler:getControl()
    self.control = self:getButtonControl(getText("ContextMenu_Light_fire"))
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
        ISCampingMenu.doLightFireOption(self.playerObj, context, nil, fuelAmount > 0, fuelInfo, campfire, ISLightFromPetrol, ISLightFromLiterature, ISLightFromKindle)
    else
        ISCampingMenu.doLightFireOption(self.playerObj, context, nil, self.object:hasFuel(), fuelInfo, self.object, ISBBQLightFromPetrol, ISBBQLightFromLiterature, ISBBQLightFromKindle)
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
        ISCampingMenu.doLightFireOption(self.playerObj, context, nil, fuelAmount > 0, fuelInfo, campfire, ISLightFromPetrol, ISLightFromLiterature, ISLightFromKindle)
    else
        ISCampingMenu.doLightFireOption(self.playerObj, context, nil, self.object:hasFuel(), fuelInfo, self.object, ISBBQLightFromPetrol, ISBBQLightFromLiterature, ISBBQLightFromKindle)
	end
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
