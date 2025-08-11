--***********************************************************
--**                     SOUL FILCHER                      **
--**                         2025                          **
--***********************************************************

ContextMenuCode = {}
ContextMenuCode.Items = {}
ContextMenuCode.Tiles = {}

-- Items

function ContextMenuCode.Items.PlaceCarBatteryCharger(carBatteryCharger, playerObj, param)
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, carBatteryCharger)
	ISTimedActionQueue.add(ISPlaceCarBatteryChargerAction:new(playerObj, carBatteryCharger))
end

-- Tiles

function ContextMenuCode.AddDispenserBottle(context, param)
    local option = param.option;
    local waterdispenser = param.entity;
    local playerObj = param.playerObj;
    local extraParam = param.extraParam;

    local subMenu = ISContextMenu:getNew(context)
    context:addSubMenu(option, subMenu)
    
    if not playerObj:getInventory():contains("WaterDispenserBottle") then
        option.notAvailable = true;
    else
	    local bottlesList = playerObj:getInventory():getAllTypeRecurse("WaterDispenserBottle");
	    for n = 0,bottlesList:size()-1 do
		    local bottle = bottlesList:get(n)
		    bottleOption = subMenu:addGetUpOption(bottle:getName(), playerObj, ISWorldObjectContextMenu.onWaterDispenserBottle, waterdispenser, bottle);
		    bottleOption.itemForTexture = bottle;
	    end
    end
end

function ContextMenuCode.BatteryLightSourceInteraction(context, option, lightSource, playerObj, param)
    local player = playerObj:getPlayerNum();
    local playerInv = playerObj:getInventory();
                if (lightSource:getLightSourceFuel() and lightSource:haveFuel()) or not lightSource:getLightSourceFuel() then
                    if lightSource:isLightSourceOn() then
                        context:addGetUpOption(getText("ContextMenu_Turn_Off"), lightSource, ISWorldObjectContextMenu.onToggleThumpableLight, player);
                    elseif lightSource:getLifeLeft() > 0 then
                        context:addGetUpOption(getText("ContextMenu_Turn_On"), lightSource, ISWorldObjectContextMenu.onToggleThumpableLight, player);
                    end
                end
                if lightSource:getLightSourceFuel() and playerInv:containsWithModule(lightSource:getLightSourceFuel(), true) then
                    local fuelOption = context:addOption(getText("ContextMenu_Insert_Fuel"), worldobjects, nil)
                    local subMenuFuel = ISContextMenu:getNew(context)
                    context:addSubMenu(fuelOption, subMenuFuel)
                    local fuelList = playerInv:FindAll(lightSource:getLightSourceFuel())
                    for n = 0,fuelList:size()-1 do
                        local fuel = fuelList:get(n)
                        if instanceof(fuel, 'DrainableComboItem') and fuel:getCurrentUsesFloat() > 0 then
                            local fuelOption2 = subMenuFuel:addGetUpOption(fuel:getName(), lightSource, ISWorldObjectContextMenu.onInsertFuel, fuel, playerObj)
                            local tooltip = ISWorldObjectContextMenu.addToolTip()
                            tooltip:setName(fuel:getName())
                            tooltip.description = getText("IGUI_RemainingPercent", luautils.round(math.ceil(fuel:getCurrentUsesFloat()*100),0))
                            fuelOption2.toolTip = tooltip
                        end
                    end
                end
                if lightSource:getLightSourceFuel() and lightSource:haveFuel() then
                    local removeOption = context:addGetUpOption(getText("ContextMenu_Remove_Battery"), lightSource, ISWorldObjectContextMenu.onRemoveFuel, player);
                    if playerObj:DistToSquared(lightSource:getX() + 0.5, lightSource:getY() + 0.5) < 2 * 2 then
                        local item = ScriptManager.instance:getItem(lightSource:getLightSourceFuel())
                        local tooltip = ISWorldObjectContextMenu.addToolTip()
                        tooltip:setName(item and item:getDisplayName() or "???")
                        tooltip.description = getText("IGUI_RemainingPercent", luautils.round(math.ceil(lightSource:getLifeLeft()*100),0))
                        removeOption.toolTip = tooltip
                    end
                end
end

function ContextMenuCode.CompostInteraction(context, option, compost, playerObj, param)
    local playerInv = playerObj:GetInventory();
	--local option = context:addOption(getText("ContextMenu_GetCompost") .. " (" .. round(compost:getCompost(),1) .. getText("ContextMenu_FullPercent") .. ")")
	option.toolTip = ISWorldObjectContextMenu.addToolTip()
	option.toolTip:setVisible(false)
	option.toolTip:setName(getText("ContextMenu_Compost"))
	local percent = round(compost:getCompost(), 1)
	option.toolTip.description = percent .. getText("ContextMenu_FullPercent")
	local COMPOST_PER_BAG = 10
	local compostBagScriptItem = ScriptManager.instance:FindItem("Base.CompostBag")
	local USES_PER_BAG = 1.0 / compostBagScriptItem:getUseDelta()
	local COMPOST_PER_USE = COMPOST_PER_BAG / USES_PER_BAG
	if percent < COMPOST_PER_USE then
		option.toolTip.description = "<RGB:1,0,0> " .. getText("ContextMenu_CompostPercentRequired", percent, COMPOST_PER_USE)
		option.notAvailable = true
	end
	local compostBags = playerInv:getAllTypeEvalRecurse("CompostBag", predicateNotFull)
	local sandBags = playerInv:getAllEvalRecurse(predicateEmptySandbag)
	if compostBags:isEmpty() and sandBags:isEmpty() then
		option.toolTip.description = option.toolTip.description .. " <LINE> <RGB:1,0,0> " .. getText("ContextMenu_EmptySandbagRequired")
		option.notAvailable = true
	elseif not option.notAvailable then
		for i=1,compostBags:size() do
			local compostBag = compostBags:get(i-1)
			local availableUses = USES_PER_BAG - compostBag:getCurrentUses()
			context:addGetUpOption(getText("ContextMenu_GetCompostItem", compostBag:getDisplayName(), math.min(percent, availableUses * COMPOST_PER_USE)), compost, ISWorldObjectContextMenu.onGetCompost, compostBag, playerObj)
		end
		for i=1,sandBags:size() do
			local sandBag = sandBags:get(i-1)
			context:addGetUpOption(getText("ContextMenu_GetCompostItem", sandBag:getDisplayName(), math.min(percent, COMPOST_PER_BAG)), compost, ISWorldObjectContextMenu.onGetCompost, sandBag, playerObj)
			break -- only 1 empty sandbag listed
		end
		option.subOption = context.subOptionNums
	end
	if compost:getCompost() + COMPOST_PER_USE <= 100 then
		local compostBags = playerInv:getAllTypeRecurse("CompostBag")
		if not compostBags:isEmpty() then
			for i=1,compostBags:size() do
				local compostBag = compostBags:get(i-1)
				context:addGetUpOption(getText("ContextMenu_AddCompostItem", compostBag:getDisplayName(), math.min(100 - percent, compostBag:getCurrentUses() * COMPOST_PER_USE)), compost, ISWorldObjectContextMenu.onAddCompost, compostBag, playerObj)
			end
			local subMenuOption = context:addOption(getText("ContextMenu_AddCompost"))
			context:addSubMenu(subMenuOption, subMenu)
		end
	end
end

function ContextMenuCode.OnButcherHook(context, hook, playerObj, param)
	if luautils.walkAdj(playerObj, hook:getSquare(), false) then
		ISTimedActionQueue.add(ISOpenButcherHookUI:new(playerObj, hook));
	end
end

function ContextMenuCode.OpenCloseAmphoraLid(context, entity, character, param)
    local sprite = entity:getSprite():getName();
    local newSprite = "crafted_04_32";
    if not sprite then return; end
    if sprite == "crafted_04_35" then
        newSprite = "crafted_04_34";
    elseif sprite == "crafted_04_34" then
        newSprite = "crafted_04_35";
    elseif sprite == "crafted_04_32" then
        newSprite = "crafted_04_33";
    end

	if luautils.walkAdj(character, entity:getSquare(), false) then
		ISTimedActionQueue.add(ISOpenCloseLid:new(character, entity, entity:getSquare(), newSprite));
	end
end

function ContextMenuCode.OpenCloseLid(context, entity, character, sprite)
	if luautils.walkAdj(character, entity:getSquare(), false) then
		ISTimedActionQueue.add(ISOpenCloseLid:new(character, entity, entity:getSquare(), sprite));
	end
end

function ContextMenuCode.TakeDispenserBottle(context, entity, character, param)
	if luautils.walkAdj(character, entity:getSquare(), false) then
		ISTimedActionQueue.add(ISAddTakeDispenserBottle:new(character, entity, bottle));
	end	
end

function ContextMenuCode.TakeBricks(context, entity, character, param)
	if luautils.walkAdj(character, entity:getSquare(), false) then
		ISTimedActionQueue.add(ISTakeBricks:new(character, entity, entity:getSquare(), "construction_01_5", "Base.ClayBrick", 20));
	end	
end

function ContextMenuCode.TakeGoldBars(context, entity, character, param)
	if luautils.walkAdj(character, entity:getSquare(), false) then
		ISTimedActionQueue.add(ISTakeBricks:new(character, entity, entity:getSquare(), "location_military_knox_01_0", "Base.GoldBar", 30));
	end
end