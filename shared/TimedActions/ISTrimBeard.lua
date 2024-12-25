--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISTrimBeard = ISBaseTimedAction:derive("ISTrimBeard");

function ISTrimBeard:isValid()
    if isClient() then
	    return true
	else
	    return self.item and self.character:getInventory():contains(self.item) or getCore():getDebug();
	end
end

function ISTrimBeard:update()
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISTrimBeard:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
	self:setActionAnim(CharacterActionAnims.Shave)
	self:setOverrideHandModels(self.item and self.item:getStaticModel() or "DisposableRazor", nil)
end

function ISTrimBeard:stop()
	self:stopSound()
    ISBaseTimedAction.stop(self);
end

function ISTrimBeard:perform()
	self:stopSound()
	if isClient() then
		self.character:resetModel();
		self.character:resetBeardGrowingTime();
		triggerEvent("OnClothingUpdated", self.character)
	end
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISTrimBeard:stopSound()
	if self.sound and self.character:getEmitter():isPlaying(self.sound) then
		self.character:stopOrTriggerSound(self.sound);
	end
end

function ISTrimBeard:animEvent(event, parameter)
	if event == "PlayShaveSound" then
		self.sound = self.character:playSound(parameter)
	end
end

function ISTrimBeard:complete()
	self.character:getHumanVisual():setBeardModel(self.beardStyle);

	if self.beardStyle == "" then
		self.character:getHumanVisual():setBeardColor(self.character:getHumanVisual():getNaturalBeardColor())
	end
	sendHumanVisual(self.character)

	if not isServer() then
		self.character:resetModel();
		self.character:resetBeardGrowingTime();
		triggerEvent("OnClothingUpdated", self.character)
	end

	return true
end

function ISTrimBeard:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 300
end

function ISTrimBeard:new(character, beardStyle, item)
	local o = ISBaseTimedAction.new(self, character)
	o.beardStyle = beardStyle or "";
	o.item = item;
	o.maxTime = o:getDuration();
	return o;
end
