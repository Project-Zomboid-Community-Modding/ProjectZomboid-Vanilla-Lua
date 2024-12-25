--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISAddCompost = ISBaseTimedAction:derive("ISAddCompost")

local COMPOST_PER_BAG = 10
local SCRIPT_ITEM = ScriptManager.instance:FindItem("Base.CompostBag")
local USES_PER_BAG = 1.0 / SCRIPT_ITEM:getUseDelta()
local COMPOST_PER_USE = COMPOST_PER_BAG / USES_PER_BAG

function ISAddCompost:isValid()
    if isClient() and self.item then
        return self.compost:getCompost() + COMPOST_PER_USE <= 100 and
            self.character:getInventory():containsID(self.item:getID()) and
            self.item:getCurrentUses() > 0
    else
        return self.compost:getCompost() + COMPOST_PER_USE <= 100 and
            self.character:getInventory():contains(self.item) and
            self.item:getCurrentUses() > 0
    end
end

function ISAddCompost:update()
	self.character:faceThisObject(self.compost)
	self.character:setMetabolicTarget(Metabolics.HeavyWork)
end

function ISAddCompost:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
	self:setActionAnim(CharacterActionAnims.Pour)
	self:setOverrideHandModels(self.item, nil)
end

function ISAddCompost:stop()
	ISBaseTimedAction.stop(self)
end

function ISAddCompost:perform()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISAddCompost:complete()
	local amount = math.min(100 - self.compost:getCompost())
	local uses = math.floor(amount / COMPOST_PER_USE)
	uses = math.min(uses, self.item:getCurrentUses())
	for i=1,uses do
		self.item:Use()
		self.compost:setCompost(self.compost:getCompost() + COMPOST_PER_USE)
	end
	if isClient() then
		self.compost:updateSprite()
	end
	self.compost:sync()

	return true;
end

function ISAddCompost:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 150
end

function ISAddCompost:new(character, compost, item)
	local o = ISBaseTimedAction.new(self, character)
	o.compost = compost
	o.item = item
	o.maxTime = o:getDuration()
	return o
end	
