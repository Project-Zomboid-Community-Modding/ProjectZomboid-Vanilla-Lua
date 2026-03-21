require "TimedActions/ISBaseTimedAction"

ISLoadBulletsInMagazine = ISBaseTimedAction:derive("ISLoadBulletsInMagazine")

function ISLoadBulletsInMagazine:isValid()
	if isClient() and self.magazine then
		return self.character:getInventory():containsID(self.magazine:getID())
	else
		return self.character:getInventory():contains(self.magazine)
	end
end

function ISLoadBulletsInMagazine:start()
    local itemKey = self.magazine:getAmmoType():getItemKey();
	if not self.character:getInventory():containsWithModule(itemKey) then
		self:forceStop();
		return;
	end
	self.ammoCountStart = self.magazine:getCurrentAmmoCount()
	self.magazine:setJobDelta(0.0)
	self:setOverrideHandModels(nil, "GunMagazine");
	self:setActionAnim(CharacterActionAnims.InsertBullets);
	self:initVars()
	self.loadedThisLoop = false;
	self.updateLoadBulletsTime = 0.0
	self.character:setVariable("UpdateLoadBulletsTime", 0.0);
end

function ISLoadBulletsInMagazine:update()
	local remaining = self.ammoCount - (self.magazine:getCurrentAmmoCount() - self.ammoCountStart)
	self.magazine:setJobType(getText("ContextMenu_InsertBulletsInMagazine", remaining))
	self.magazine:setJobDelta((self.magazine:getCurrentAmmoCount() - self.ammoCountStart) / self.ammoCount)
	if self.loadFinished then
		self:setOverrideHandModels(nil, nil);
		self:forceComplete();
		return;
	end
	self.character:setMetabolicTarget(Metabolics.LightDomestic);

    self:updateLoadingTime()
end

function ISLoadBulletsInMagazine:updateLoadingTime()
    local animTimeDelta = self.character:getAnimationTimeDelta();
    local oldUpdateLoadBulletsTime = self.updateLoadBulletsTime;
    self.updateLoadBulletsTime = (self.updateLoadBulletsTime + animTimeDelta) % 1.0;
    if oldUpdateLoadBulletsTime > self.updateLoadBulletsTime then
        self.loadedThisLoop = false
    end
	self.character:setVariable("UpdateLoadBulletsTime", self.updateLoadBulletsTime);
end

function ISLoadBulletsInMagazine:initVars()
	ISReloadWeaponAction.setReloadSpeed(self.character, false)
end

function ISLoadBulletsInMagazine:isLoadFinished()
    local itemKey = self.magazine:getAmmoType():getItemKey();
	return self.magazine:getCurrentAmmoCount() >= self.magazine:getMaxAmmo() or not self.character:getInventory():containsWithModule(itemKey)
end

function ISLoadBulletsInMagazine:isLocal()
    if not isMultiplayer() or isClient() then
        return true
    end
    return false
end

function ISLoadBulletsInMagazine:serverStart()
	self:initVars()
	emulateAnimEvent(self.netAction, ISReloadWeaponAction.getReloadTime(self.character, 500), "InsertBullet", nil)
	emulateAnimEvent(self.netAction, ISReloadWeaponAction.getReloadTime(self.character, 550), "loadFinished", nil)
	emulateAnimEvent(self.netAction, ISReloadWeaponAction.getReloadTime(self.character, 500), "updateLoadingTime", nil)
end

function ISLoadBulletsInMagazine:getDuration()
	return -1
end

function ISLoadBulletsInMagazine:complete()
	return true
end

function ISLoadBulletsInMagazine:animEvent(event, parameter)
    if isServer() then
        if event == "updateLoadingTime" then
            self:updateLoadingTime();
        end
    end
	if event == 'InsertBulletSound' then
		if self:isLoadFinished() then
			-- Fix for looping animation events arriving after loading finished.
			-- That's why 'PlaySound' isn't used instead.
			return
		end
        if self:isLocal() then
            if self.loadedThisLoop then
                return
            end
        end
		self.character:playSound(parameter);
	elseif event == 'InsertBullet' then
		if self:isLoadFinished() then
			-- Fix for looping animation events arriving after loading finished.
			return
		end
        if self:isLocal() then
            if self.loadedThisLoop then
                return
            end
        end
        self.loadedThisLoop = true
		if not isClient() then
			local chance = 5;
			local xp = 1;
			if self.character:getPerkLevel(Perks.Reloading) < 5 then
				chance = 2;
				xp = 4;
			end
			if ZombRand(chance) == 0 then
				addXp(self.character, Perks.Reloading, xp)
			end
            local itemKey = self.magazine:getAmmoType():getItemKey();
			local removedBullet = self.character:getInventory():RemoveOneOf(itemKey, true)
			self.magazine:setCurrentAmmoCount(self.magazine:getCurrentAmmoCount() + 1)
			sendRemoveItemFromContainer(self.character:getInventory(), removedBullet);
			syncItemFields(self.character, self.magazine)
		end
	elseif event == 'loadFinished' then
		if self:isLoadFinished() then
			self.loadFinished = true
	        self.loadedThisLoop = false
			if isServer() then
				self.netAction:forceComplete()
			end
		end
	elseif event == 'playReloadSound' then
		if parameter == 'insertAmmoStart' then
			if not self.playedInsertAmmoStartSound and self.magazine:getInsertAmmoStartSound() then
				self.playedInsertAmmoStartSound = true;
				self.character:playSound(self.gun:getInsertAmmoStartSound());
			end
		end
	end
end

function ISLoadBulletsInMagazine:stop()
	self.magazine:setJobDelta(0.0)
	ISBaseTimedAction.stop(self)
end

function ISLoadBulletsInMagazine:perform()
	self.magazine:setJobDelta(0.0)
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISLoadBulletsInMagazine:new(character, magazine, ammoCount)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnAim = false
	o.stopOnWalk = false
	o.stopOnRun = true
	o.maxTime = o:getDuration()
	o.magazine = magazine;
	o.useProgressBar = false;
	o.ammoCount = ammoCount
	o.updateLoadBulletsTime = 0.0
	o.loadedThisLoop = false
	return o
end
