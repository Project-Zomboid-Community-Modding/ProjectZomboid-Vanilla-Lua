--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDryMyself = ISBaseTimedAction:derive("ISDryMyself");

function ISDryMyself:isValid()
	if isClient() then
		if self.started then
			return self.character:getBodyDamage():getWetness() > 0;
		elseif self.item then
			return self.character:getInventory():containsID(self.item:getID()) and self.character:getBodyDamage():getWetness() > 0 and self.item:getCurrentUsesFloat() > 0
		end
    else
        return self.character:getInventory():contains(self.item) and self.character:getBodyDamage():getWetness() > 0 and self.item:getCurrentUsesFloat() > 0;
    end
end

function ISDryMyself:update()
	self.tick = self.tick + 1;
	if self.tick >= self.timer then
		self.tick = 0;
		--self.character:getBodyDamage():setWetness(self.character:getBodyDamage():getWetness() - (self.character:getBodyDamage():getWetness() / 20));
		self.character:getBodyDamage():decreaseBodyWetness( self.character:getBodyDamage():getWetness() / 20 );

		if isClient() then
			if self.item then
				local dt = self.item:getCurrentUsesFloat() - self.item:getUseDelta();
				if dt > 0 then
					self.item:setUsedDelta(dt);
				else
					self:forceStop();
				end
			end
		else
			self.item:Use();
		end

	end
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISDryMyself:start()
	if isClient() and self.item then
		self.item = self.character:getInventory():getItemById(self.item:getID())
	end

	self.started = true
end

function ISDryMyself:stop()
    ISBaseTimedAction.stop(self);
end

function ISDryMyself:perform()
	self.started = false;
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISDryMyself:complete()
	self:syncItemUses();

	if self.item then
		self.item:UseAndSync();
	end

	self.character:getBodyDamage():decreaseBodyWetness( self.character:getBodyDamage():getWetness() );
	sendDamage(self.character)
	return true
end

function ISDryMyself:serverStart()
	self.serverStartTime = getTimeInMillis();
end

function ISDryMyself:serverStop()
	self:syncItemUses();
	self.character:getBodyDamage():decreaseBodyWetness( self.character:getBodyDamage():getWetness() * self.netAction:getProgress() );
	sendDamage(self.character)
end


function ISDryMyself:syncItemUses()
	if not self.item or not isServer() then
		return
	end

	local duration = getTimeInMillis() - self.serverStartTime;
	local timer = self.timer * 20;
	local maxTime = self.maxTime * 20;

	if duration > maxTime then
		duration = maxTime;
	end

	local numberOfUses = math.ceil(duration / timer) + 1;
	for i = 1, numberOfUses do
		if i == numberOfUses then
			self.item:UseAndSync();
		else
			self.item:Use();
		end
	end
end

function ISDryMyself:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	local useLeft = math.ceil(self.item:getCurrentUsesFloat() * 10);
	return (useLeft * 20) + 20
end

function ISDryMyself:new(character, item)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item;
	o.maxTime = o:getDuration();
	o.timer = o.maxTime / 20;
	o.tick = 0;
    o.caloriesModifier = 4;
	return o;
end
