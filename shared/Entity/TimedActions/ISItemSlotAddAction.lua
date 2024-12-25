--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISItemSlotAddAction = ISBaseTimedAction:derive("ISItemSlotAddAction");

function ISItemSlotAddAction:isValid()
	return true;
end

function ISItemSlotAddAction:update()
	self.item:setJobDelta(self:getJobDelta());
	self.character:setMetabolicTarget(Metabolics.LightWork);

	self.character:faceThisObject(self.entity)
end

function ISItemSlotAddAction:start()
	if self.resource:isFull() then
		self:stop();
		return;
	end
    if self.itemSlot then
        self.itemSlot.actionAdd = self;
    end
	self.item:setJobType("Transferring");
	self.item:setJobDelta(0.0);
	self:setActionAnim("Loot");
	self:setAnimVariable("LootPosition", "");
	--self:setActionAnim(CharacterActionAnims.Craft);
	self:setOverrideHandModels(nil, nil);
	if self.item:getStaticModel() then
		self:setOverrideHandModels(nil, self.item:getStaticModel())
	end
end

function ISItemSlotAddAction:stop()
    ISBaseTimedAction.stop(self);
    if self.item ~= nil then
        self.item:setJobDelta(0.0);
	end
    if self.itemSlot then
        self.itemSlot.actionAdd = nil;
    end
end

function ISItemSlotAddAction:perform()
    if self.item then
		self.item:setJobDelta(0.0);
		if self.item:getContainer() and self.item:getContainer().setDrawDirty then
			self.item:getContainer():setDrawDirty(true);
		end
		--ISInventoryPage.dirtyUI()
    end
    if self.itemSlot then
        self.itemSlot.actionAdd = nil;
    end
	ISBaseTimedAction.perform(self);
end

function ISItemSlotAddAction:complete()
	self.resource:offerItem(self.item);
	return true
end

function ISItemSlotAddAction:getDuration()
	return 30+(self.item:getWeight()*3); --todo temp value, needs proper value consistent with other actions
end

function ISItemSlotAddAction:new(character, entity, item, resource)
	local o = ISBaseTimedAction.new(self, character)
	o.entity = entity
	o.item = item;
	o.resource = resource;
    o.itemSlot = nil;
	o.maxTime = o:getDuration();
	return o
end