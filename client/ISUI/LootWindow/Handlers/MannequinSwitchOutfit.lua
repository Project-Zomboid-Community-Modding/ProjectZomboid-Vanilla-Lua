--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/LootWindow/ISLootWindowObjectControlHandler"
require "TimedActions/ISInventoryTransferUtil"

ISLootWindowObjectControlHandler_MannequinSwitchOutfit = ISLootWindowObjectControlHandler:derive("ISLootWindowObjectControlHandler_MannequinSwitchOutfit")
local Handler = ISLootWindowObjectControlHandler_MannequinSwitchOutfit

function Handler:shouldBeVisible()
    if not instanceof(self.object, "IsoMannequin") then return false end
    if self.object:getWornItems():size()>0 and self.playerObj:getWornItems():size()>0 then
        return true
    end
    if self.object:getWornItems():size()<1 and self.playerObj:getWornItems():size()>0 then
        return true
    end
    if self.object:getWornItems():size()>0 and self.playerObj:getWornItems():size()<1 then
        return true
    end
    return false
end

function Handler:getControl()
    local xln = nil
    if self.object:getWornItems():size()>0 and self.playerObj:getWornItems():size()>0 then
        xln = "ContextMenu_SwitchOutfit"
    elseif self.object:getWornItems():size()<1 and self.playerObj:getWornItems():size()>0 then
        xln = "ContextMenu_StoreOutfit"
    elseif self.object:getWornItems():size()>0 and self.playerObj:getWornItems():size()<1 then
        xln = "ContextMenu_WearOutfit"
    end
    self.control = self:getButtonControl(getText(xln))
    return self.control
end

function Handler:handleJoypadContextMenu(context)
    local xln = nil
    if self.object:getWornItems():size()>0 and self.playerObj:getWornItems():size()>0 then
        xln = "ContextMenu_SwitchOutfit"
    elseif self.object:getWornItems():size()<1 and self.playerObj:getWornItems():size()>0 then
        xln = "ContextMenu_StoreOutfit"
    elseif self.object:getWornItems():size()>0 and self.playerObj:getWornItems():size()<1 then
        xln = "ContextMenu_WearOutfit"
    end
    local option = self:addJoypadContextMenuOption(context, getText(xln))
    option.iconTexture = ContainerButtonIcons[self.container:getType()]
end

function Handler:perform()
	if isGamePaused() then return end
	local mannequin = self.object
	if not mannequin then return end
	local playerObj = self.playerObj
	if playerObj:getVehicle() then return end
	if luautils.walkAdj(playerObj, mannequin:getSquare()) then
	    local wornItemsPlayer = playerObj:getWornItems()
        for i=0,wornItemsPlayer:size()-1 do
            local item = wornItemsPlayer:get(i):getItem();
            if item and item:getDisplayName() ~= null then
                if (item:IsClothing() and item:isWorn()) or (instanceof(item, "InventoryContainer") and item:isEquipped()) then
                    ISTimedActionQueue.add(ISUnequipAction:new(playerObj, item, 50))
                end
            end
        end
        for i=0,mannequin:getWornItems():size()-1 do
            local item = mannequin:getWornItems():get(i):getItem();
            if item and item:getDisplayName() ~= null then
                ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
                ISTimedActionQueue.add(ISWearClothing:new(playerObj, item, 50))
            end
        end
        for i=0,wornItemsPlayer:size()-1 do
            local item = wornItemsPlayer:get(i):getItem();
            if item and item:getDisplayName() ~= null then
                ISTimedActionQueue.add(ISInventoryTransferUtil.newInventoryTransferAction(playerObj, item, item:getContainer(), mannequin:getContainer()))
            end
        end
	end
end

function Handler:new()
    local o = ISLootWindowObjectControlHandler.new(self)
    o.altColor = true
    return o
end
