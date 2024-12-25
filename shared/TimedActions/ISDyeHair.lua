--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDyeHair = ISBaseTimedAction:derive("ISDyeHair");

function ISDyeHair:isValid()
    if isClient() and self.hairDye then
	    return self.character:getInventory():containsID(self.hairDye:getID())
	else
	    return self.character:getInventory():contains(self.hairDye);
	end
end

function ISDyeHair:update()
end

function ISDyeHair:start()
    if isClient() and self.hairDye then
        self.hairDye = self.character:getInventory():getItemById(self.hairDye:getID())
    end
	self:setActionAnim("WearClothing");
	self:setAnimVariable("WearClothingLocation", "Face");
	if self.beard then
		self:setAnimVariable("WearClothingLocation", "Face");	
	end
end

function ISDyeHair:stop()
    ISBaseTimedAction.stop(self);
end

function ISDyeHair:perform()
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISDyeHair:complete()
	local color = self.hairDye:getFluidContainer():getColor();
	local r, g, b = color:getR(), color:getG(), color:getB();
	if self.beard then
		self.character:getHumanVisual():setBeardColor(ImmutableColor.new(r, g, b, 1));
	else
		self.character:getHumanVisual():setHairColor(ImmutableColor.new(r, g, b, 1));
	end
	local amount = self.hairDye:getFluidContainer():getAmount() - 0.5;
	if amount < 0 then amount = 0 end;
	self.hairDye:getFluidContainer():adjustAmount(amount);
	sendItemStats(self.hairDye);
	self.character:resetModel();
	sendHumanVisual(self.character);
	triggerEvent("OnClothingUpdated", self.character)

	return true;
end

function ISDyeHair:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 120
end

function ISDyeHair:new(character, hairDye, beard)
	local o = ISBaseTimedAction.new(self, character)
	o.hairDye = hairDye;
	o.beard = beard;
	o.maxTime = o:getDuration()
	return o;
end