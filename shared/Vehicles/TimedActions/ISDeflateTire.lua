--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDeflateTire = ISBaseTimedAction:derive("ISDeflateTire")

function ISDeflateTire:isValid()
--	return self.vehicle:isInArea(self.part:getArea(), self.character)
	return true;
end

function ISDeflateTire:update()
	self.character:faceThisObject(self.vehicle)
	local psi = self.psiStart + (self.psiTarget - self.psiStart) * self:getJobDelta()
	if math.floor(psi) ~= self.psiSent then
		if self.vehicle then
            if not self.part then
                print('no such part ',self.part)
                return
            end
            self.part:setContainerContentAmount(psi, true, true)
            local wheelIndex = self.part:getWheelIndex()
            -- TODO: sync inflation
            self.vehicle:setTireInflation(wheelIndex, self.part:getContainerContentAmount() / self.part:getContainerCapacity())
            self.vehicle:transmitPartModData(self.part)
        else
            print('no such vehicle id=',self.vehicle)
        end
		self.psiSent = math.floor(psi)
	end
end

function ISDeflateTire:start()
	if isClient() then
		self.psiSent = math.floor(self.psiStart)
	end
end

function ISDeflateTire:stop()
	ISBaseTimedAction.stop(self)
end

function ISDeflateTire:serverStop()
    local psi = self.psiStart + (self.psiTarget - self.psiStart) * self.netAction:getProgress()
    self.part:setContainerContentAmount(math.floor(psi), true, true)
    self.vehicle:transmitPartModData(self.part)
end

function ISDeflateTire:perform()
    local wheelIndex = self.part:getWheelIndex()
    self.vehicle:setTireInflation(wheelIndex, self.part:getContainerContentAmount() / self.part:getContainerCapacity())
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISDeflateTire:complete()
    if self.vehicle then
        if not self.part then
            print('no such part ',self.part)
            return false
        end
        self.part:setContainerContentAmount(self.psiTarget, true, true)
        -- TODO: sync inflation
        self.vehicle:transmitPartModData(self.part)
    else
        print('no such vehicle id=',self.vehicle)
    end
    return true
end

function ISDeflateTire:getDuration()
    if self.character:isTimedActionInstant() then
       return 1
    end
	return (self.part:getContainerContentAmount()-self.psiTarget) * 50
end

function ISDeflateTire:new(character, part, psiTarget)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = part:getVehicle()
	o.part = part
	o.psiStart = part:getContainerContentAmount()
	o.psiTarget = psiTarget
    o.stopOnWalk = true
    o.stopOnRun = true
	o.maxTime = o:getDuration()
	o.jobType = getText("IGUI_JobType_DeflateTire")
	return o
end

