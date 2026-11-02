ContextMenuCode = {}
ContextMenuCode.Items = {}
ContextMenuCode.Tiles = {}

function ContextMenuCode.Items.PlaceCarBatteryCharger(carBatteryCharger, playerObj, param)
	ISInventoryPaneContextMenu.transferIfNeeded(playerObj, carBatteryCharger)
	ISTimedActionQueue.add(ISPlaceCarBatteryChargerAction:new(playerObj, carBatteryCharger))
end

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

function ContextMenuCode.BatteryLightSourceInteraction(context, param)
    local option = param.option;
    local playerObj = param.playerObj;
    local player = param.playerObj:getPlayerNum();
    local playerInv = param.playerObj:getInventory();
    local lightSource = param.entity;

    local subMenu = ISContextMenu:getNew(context)
    context:addSubMenu(option, subMenu)

                if (lightSource:getLightSourceFuel() and lightSource:haveFuel()) or not lightSource:getLightSourceFuel() then
                    if lightSource:isLightSourceOn() then
                        subMenu:addGetUpOption(getText("ContextMenu_Turn_Off"), lightSource, ISWorldObjectContextMenu.onToggleThumpableLight, player);
                    elseif lightSource:getLifeLeft() > 0 then
                        subMenu:addGetUpOption(getText("ContextMenu_Turn_On"), lightSource, ISWorldObjectContextMenu.onToggleThumpableLight, player);
                    end
                end
                if lightSource:getLightSourceFuel() and playerInv:containsWithModule(lightSource:getLightSourceFuel(), true) then
                    local fuelOption = subMenu:addOption(getText("ContextMenu_Insert_Fuel"), worldobjects, nil)
                    local subMenuFuel = ISContextMenu:getNew(subMenu)
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
                    local removeOption = subMenu:addGetUpOption(getText("ContextMenu_Remove_Battery"), lightSource, ISWorldObjectContextMenu.onRemoveFuel, player);
                    if playerObj:DistToSquared(lightSource:getX() + 0.5, lightSource:getY() + 0.5) < 2 * 2 then
                        local item = ScriptManager.instance:getItem(lightSource:getLightSourceFuel())
                        local tooltip = ISWorldObjectContextMenu.addToolTip()
                        tooltip:setName(item and item:getDisplayName() or "???")
                        tooltip.description = getText("IGUI_RemainingPercent", luautils.round(math.ceil(lightSource:getLifeLeft()*100),0))
                        removeOption.toolTip = tooltip
                    end
                end
end

function ContextMenuCode.OnButcherHook(context, hook, playerObj, param)
	if not playerObj:getVehicle() and luautils.walkAdj(playerObj, hook:getSquare(), false) then
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
		ISTimedActionQueue.add(ISTakeBricks:new(character, entity, entity:getSquare()));
	end	
end

function ContextMenuCode.TakeHay(context, entity, character, param)
	if luautils.walkAdj(character, entity:getSquare(), false) then
		ISTimedActionQueue.add(ISTakeBricks:new(character, entity, entity:getSquare()));
	end
end

function ContextMenuCode.TakeHayDouble(context, entity, character, param)
	if luautils.walkAdj(character, entity:getSquare(), false) then
		ISTimedActionQueue.add(ISTakeBricks:new(character, entity, entity:getSquare()));
	end
end

function ContextMenuCode.TakeGoldBars(context, entity, character, param)
	if luautils.walkAdj(character, entity:getSquare(), false) then
		ISTimedActionQueue.add(ISTakeBricks:new(character, entity, entity:getSquare()));
	end
end
