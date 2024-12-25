--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISItemSlotRemoveAction = ISBaseTimedAction:derive("ISItemSlotRemoveAction");

function ISItemSlotRemoveAction:isValid()
	return true;
end

function ISItemSlotRemoveAction:update()
	--self.item:setJobDelta(self:getJobDelta());
	self.character:setMetabolicTarget(Metabolics.LightWork);

	self.character:faceThisObject(self.entity)
end

function ISItemSlotRemoveAction:start()
	if self.resource:isEmpty() then
		self:stop();
		return;
	end
    if self.itemSlot then
        self.itemSlot.actionRemove = self;
    end
    self.item = self.resource:peekItem();
    self.maxTime = 30+(self.item:getWeight()*3);
	self:setActionAnim("Loot");
	self:setAnimVariable("LootPosition", "");
	--self:setActionAnim(CharacterActionAnims.Craft);
	self:setOverrideHandModels(nil, nil);
	if self.item:getStaticModel() then
		self:setOverrideHandModels(nil, self.item:getStaticModel())
	end
end

function ISItemSlotRemoveAction:stop()
    ISBaseTimedAction.stop(self);
    if self.item ~= nil then
        self.item:setJobDelta(0.0);
	end
    if self.itemSlot then
        self.itemSlot.actionRemove = nil;
    end
end

function ISItemSlotRemoveAction:perform()
    if self.item then
		ISInventoryPage.dirtyUI()
    end
    if self.itemSlot then
        self.itemSlot.actionRemove = nil;
    end
	ISBaseTimedAction.perform(self);
end

function ISItemSlotRemoveAction:complete()
	self.item = self.resource:pollItem();

	self.character:getInventory():AddItem(self.item);
	sendAddItemToContainer(self.character:getInventory(), self.item);

	return true
end

function ISItemSlotRemoveAction:getDuration()
	return 30; --todo base on weight?
end

function ISItemSlotRemoveAction:new(character, entity, resource)
	local o = ISBaseTimedAction.new(self, character)
	o.entity = entity
	o.resource = resource;
    o.itemSlot = nil;
	o.maxTime = o:getDuration()
	return o
end