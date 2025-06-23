--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISPutOutFire = ISBaseTimedAction:derive("ISPutOutFire");

function ISPutOutFire:isValid()
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID()) and
            FireFighting.isExtinguisher(self.item)
    else
        return self.character:getInventory():contains(self.item) and
            FireFighting.isExtinguisher(self.item)
    end
end

function ISPutOutFire:update()
	-- assumes 2x2 area
	if self.character:getJoypadBind() == -1 then
		self.character:faceLocation(self.squares[1]:getX() + 1, self.squares[1]:getY() + 1)
	end
end

function ISPutOutFire:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
end

function ISPutOutFire:stop()
    ISBaseTimedAction.stop(self);
end

function ISPutOutFire:perform()
    -- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self);
end

function ISPutOutFire:useItem()
	for i=1,self.usesPerSquare do
		if instanceof(self.item, "DrainableComboItem") then
			self.item:UseAndSync()
		elseif self.item:getFluidContainer() then
			local amount = self.item:getFluidContainer():getAmount() - ZomboidGlobals.fireFightingFluidContainerMillilitresPerUse / 1000
			if amount < 0 then amount = 0 end
			self.item:getFluidContainer():adjustAmount(amount)
		end
		if FireFighting.getWaterUsesInteger(self.item) < 1 then
			break
		end
	end
	return FireFighting.getWaterUsesInteger(self.item) < self.usesPerSquare
end

function ISPutOutFire:complete()
	for _,square in pairs(self.squares) do
		local used = false
		for i=1,square:getMovingObjects():size() do
			local chr = square:getMovingObjects():get(i-1)
			if instanceof(chr, "IsoGameCharacter") and chr:isOnFire() then
				if not isServer() then
					chr:StopBurning()
				else
					stopFire(chr)
				end
				used = true
			end
		end
		if square:Is(IsoFlagType.burning) then
		    if not isServer() then
		        square:stopFire()
		    else
			    stopFire(square)
			end
			used = true
		end
		if used and self:useItem() then
			break
		end
	end
	return true
end

function ISPutOutFire:getDuration()
	if self.character:isTimedActionInstant() then
		return 1
	end
	return 50
end

function ISPutOutFire:new(character, squares, item, usesPerSquare)
	local o = ISBaseTimedAction.new(self, character)
	o.item = item
	o.squares = convertToPZNetTable(squares);
	o.maxTime = o:getDuration();
	o.usesPerSquare = usesPerSquare
	return o;
end
