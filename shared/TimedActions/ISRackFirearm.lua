--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISRackFirearm = ISBaseTimedAction:derive("ISRackFirearm")

function ISRackFirearm:isValid()
	return true
end

function ISRackFirearm:start()
	if not ISReloadWeaponAction.canRack(self.gun) then
		self:forceComplete()
		return
	end

	-- Setup IsPerformingAction & the current anim we want (check in AnimSets LoadHandgun.xml for example)
	self:setAnimVariable("WeaponReloadType", self.gun:getWeaponReloadType())

	-- we asked to rack, we gonna remove bullets if one is chambered or load one is no one is chambered
	-- chamber gun will need to be racked to remove bullet, otherwise we play the unload anim
	if self.gun:haveChamber() then
		self:setAnimVariable("isRacking", true)
	else
		self:setAnimVariable("isUnloading", true)
	end

	self:setAnimVariable("RackAiming", self.character:isAiming())
	if self.character:isAiming() then
		self.character:setAimingDelay(self.character:getAimingDelay() + self.gun:getAimingTime() * (0.15 - self.character:getPerkLevel(Perks.Reloading)*0.01))
	end
	self:setOverrideHandModels(self.gun, nil)
	self:setActionAnim(CharacterActionAnims.Reload)
	self.character:reportEvent("EventReloading");

	self:ejectSpentRounds()

	self:initVars()
end

function ISRackFirearm:update()
end

-- Rack to get a bullet (from the chamber) or unjam the gun
function ISRackFirearm:rackBullet()
	if self.gun:haveChamber() then
		if self.gun:isJammed() and self.gun:checkUnJam(self.character) then
			-- failed to unjam the weapon!
			syncHandWeaponFields(self.character, self.gun)
			return
		end

		-- rack give one bullet & put another one back in the chamber
		-- don't give back bullet if jammed
		if not self.gun:isJammed() and self.gun:isRoundChambered() then
			self:removeBullet()
		end
		self.gun:setRoundChambered(false)
		self.gun:setJammed(false)
		if self.gun:getCurrentAmmoCount() >= self.gun:getAmmoPerShoot() then
			self.gun:setRoundChambered(true)
			self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() - self.gun:getAmmoPerShoot())
			if (self.gun:getJamGunChance() > 0) then
				self.gun:checkJam(self.character, true) -- check if we jam closing the bolt/slide
			end
		end
	else
		-- rack non chamber gun give a bullet back
		-- don't give back bullet if jammed
		if not self.gun:isJammed() and self.gun:getCurrentAmmoCount() > 0 then
			self:removeBullet()
			self.gun:setCurrentAmmoCount(self.gun:getCurrentAmmoCount() - self.gun:getAmmoPerShoot())
		end
		self.gun:setJammed(false)
	end

	syncHandWeaponFields(self.character, self.gun)
end

function ISRackFirearm:removeBullet()
	local newBullet = instanceItem(self.gun:getAmmoType())
	self.character:getInventory():AddItem(newBullet)
	sendAddItemToContainer(self.character:getInventory(), newBullet)
end

function ISRackFirearm:ejectSpentRounds()
	if self.gun:getSpentRoundCount() > 0 then
		self.gun:setSpentRoundCount(0)
		syncHandWeaponFields(self.character, self.gun)
	elseif self.gun:isSpentRoundChambered() then
		self.gun:setSpentRoundChambered(false)
		syncHandWeaponFields(self.character, self.gun)
	else
		return
	end
	if self.gun:getShellFallSound() then
		self.character:getEmitter():playSound(self.gun:getShellFallSound())
	end
end

function ISRackFirearm:initVars()
	ISReloadWeaponAction.setReloadSpeed(self.character, true)
end

function ISRackFirearm:stop()
	if self.playedEjectAmmoStartSound and self.gun:getEjectAmmoStopSound() then
		self.character:playSound(self.gun:getEjectAmmoStopSound());
	end
	self.character:clearVariable("isLoading")
	self.character:clearVariable("isRacking")
	self.character:clearVariable("isUnloading")
	self.character:clearVariable("WeaponReloadType")
	self.character:clearVariable("RackAiming")
	ISBaseTimedAction.stop(self)
end

function ISRackFirearm:perform()
	if self.playedEjectAmmoStartSound and self.gun:getEjectAmmoStopSound() then
		self.character:playSound(self.gun:getEjectAmmoStopSound());
	end
	self.character:clearVariable("isLoading")
	self.character:clearVariable("isRacking")
	self.character:clearVariable("isUnloading")
	self.character:clearVariable("WeaponReloadType")
	self.character:clearVariable("RackAiming")
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISRackFirearm:serverStart()
	self:ejectSpentRounds()
	self:initVars()
	emulateAnimEventOnce(self.netAction, 100, "rackBullet", nil)
	emulateAnimEventOnce(self.netAction, 1200, "rackingFinished", nil)
end

function ISRackFirearm:getDuration()
	return -1
end

function ISRackFirearm:complete()
	return true
end

function ISRackFirearm:animEvent(event, parameter)
	if event == 'unloadFinished' then
		if not isClient() then
			self:rackBullet()
		end
		if isServer() then
			self.netAction:forceComplete()
		else
			self:forceComplete()
		end
	end
	if event == 'rackBullet' then
		if not isClient() then
			self:rackBullet()
		end
	end
	if event == 'rackingFinished' then
		-- Racking is done, we can exit out timedaction
		if isServer() then
			self.netAction:forceComplete()
		else
			self:forceComplete()
		end
	end
	if event == 'playReloadSound' then
		if parameter == 'rack' then
			if self.gun:getRackSound() then
				self.character:playSound(self.gun:getRackSound())
			end
		end
		if parameter == 'ejectAmmoStart' then
			if not self.playedEjectAmmoStartSound and self.gun:getEjectAmmoStartSound() then
				self.playedEjectAmmoStartSound = true;
				self.character:playSound(self.gun:getEjectAmmoStartSound());
			end
			return
		end
		if parameter == 'unload' then
			if self.gun:getEjectAmmoSound() then
				self.character:playSound(self.gun:getEjectAmmoSound())
			end
		end
	end
	if event == 'changeWeaponSprite' then
		if parameter and parameter ~= '' then
			if parameter ~= 'original' then
				self:setOverrideHandModels(parameter, nil)
			else
				self:setOverrideHandModels(self.gun:getWeaponSprite(), nil)
			end
		end
	end
end

function ISRackFirearm:new(character, gun)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnAim = false
	o.stopOnWalk = false
	o.stopOnRun = true
	o.maxTime = o:getDuration()
	o.useProgressBar = false
	o.gun = gun
	return o
end	
