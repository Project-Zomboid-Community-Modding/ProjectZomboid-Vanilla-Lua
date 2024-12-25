--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

ItemBindingHandler = {};

local function predicateLightSource(item)
	return item:canEmitLight() and (item:getLightStrength() > 0)
end

local function compareLightStrength(a, b)
	return a:getLightStrength() - b:getLightStrength()
end

ItemBindingHandler.onKeyPressed = function(key)
	local playerObj = getSpecificPlayer(0)
	if not playerObj then
		return
	end
	if getCore():isKey("Equip/Turn On/Off Light Source", key) then
		ItemBindingHandler.toggleLight(key)
	end
end

function ItemBindingHandler.toggleLight(key)
	local playerObj = getSpecificPlayer(0)
	if getCore():isKey("ToggleVehicleHeadlights", key) then
		local vehicle = playerObj:getVehicle()
		if vehicle and vehicle:isDriver(playerObj) and not playerObj:isAiming() then
			if vehicle:hasHeadlights() then
				ISVehicleMenu.onToggleHeadlights(playerObj)
			end
			return
		end
	end
	local secondary = playerObj:getSecondaryHandItem()
	if secondary ~= nil and secondary:canEmitLight() and secondary:getType() ~= "CandleLit" and secondary:getType() ~= "Lantern_HurricaneLit" then
		if secondary:canBeActivated() then
			secondary:setActivated(not secondary:isActivated())
			secondary:playActivateDeactivateSound()
		end
		return
	end
	local primary = playerObj:getPrimaryHandItem()
	if primary ~= nil and primary:canEmitLight() and primary:getType() ~= "CandleLit" and primary:getType() ~= "Lantern_HurricaneLit" then
		if primary:canBeActivated() then
			primary:setActivated(not primary:isActivated())
			primary:playActivateDeactivateSound()
		end
		return
	end
	local attachedItems = playerObj:getAttachedItems()
	for i=1,attachedItems:size() do
		local item = attachedItems:getItemByIndex(i-1)
		if item:canEmitLight() and item:getType() ~= "CandleLit" and item:getType() ~= "Lantern_HurricaneLit" and not instanceof(item, "HandWeapon") then
			if item:canBeActivated() then
				item:setActivated(not item:isActivated())
			end
			return
		end
	end
	if playerObj:isAiming() then return end
	local lightSource = playerObj:getInventory():getBestEvalRecurse(predicateLightSource, compareLightStrength);
	if lightSource ~= nil then
		ISInventoryPaneContextMenu.transferIfNeeded(playerObj, lightSource);
		ISTimedActionQueue.add(ISEquipWeaponAction:new(playerObj, lightSource, 50, instanceof(lightSource, "HandWeapon"), false));	
		if not lightSource:isActivated() then lightSource:setActivated(true) end;
	end
end

-- Events.OnKeyPressed.Add(ItemBindingHandler.onKeyPressed);
