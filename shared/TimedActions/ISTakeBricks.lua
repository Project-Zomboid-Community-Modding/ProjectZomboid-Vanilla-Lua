--***********************************************************
--**                     SOUL FILCHER                      **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTakeBricks = ISBaseTimedAction:derive("ISTakeBricks");

function ISTakeBricks:isValid()
	return true;
end

function ISTakeBricks:waitToStart()
	self.character:faceThisObject(self.pallet)
	return self.character:shouldBeTurning()
end

function ISTakeBricks:update()
	self.character:faceThisObject(self.pallet)
	self.character:setMetabolicTarget(Metabolics.HeavyDomestic);
end

function ISTakeBricks:start()
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")
end

function ISTakeBricks:stop()
    ISBaseTimedAction.stop(self);
end

function ISTakeBricks:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISTakeBricks:complete()

	self.square:transmitRemoveItemFromSquare(self.pallet)
	self.square:RemoveTileObject(self.pallet)

	local bricks = self.character:getInventory():AddItems(self.item, self.amount);
	sendAddItemsToContainer(self.character:getInventory(), bricks);

	local newPallet = IsoObject.new(getCell(), self.square, self.sprite);
	self.square:AddTileObject(newPallet);
	newPallet:transmitCompleteItemToClients()
	self.square:RecalcProperties();

    return true;
end

function ISTakeBricks:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end
    return 10 * self.amount;
end

function ISTakeBricks:new(character, pallet, square, sprite, item, amount)
    local o = ISBaseTimedAction.new(self, character)
    o.amount = amount;
    o.maxTime = o:getDuration();
	o.character = character;
	o.pallet = pallet;
	o.square = square;
	o.sprite = sprite;
	o.item = item;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	return o;
end