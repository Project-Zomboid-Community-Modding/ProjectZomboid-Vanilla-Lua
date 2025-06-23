--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISInflateTire = ISBaseTimedAction:derive("ISInflateTire")

function ISInflateTire:isValid()
--	return self.vehicle:isInArea(self.part:getArea(), self.character)
	-- The tire might explode while inflating.
	return self.part:getInventoryItem() ~= nil
end

function ISInflateTire:update()
	self.character:faceThisObject(self.vehicle)
	self.item:setJobDelta(self:getJobDelta())
	self.item:setJobType(getText("IGUI_JobType_InflateTire"))
	local psi = self.psiStart + (self.psiTarget - self.psiStart) * self:getJobDelta();
	self.totalPsi = psi;
	if math.floor(psi) ~= self.psiSent then
		if self.vehicle then
            if not self.part then
                print('no such part ',self.part)
                return false
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

function ISInflateTire:start()
	self.psiSent = math.floor(self.psiStart)
end

function ISInflateTire:stop()
	if self.item then self.item:setJobDelta(0) end
	ISBaseTimedAction.stop(self)
end

function ISInflateTire:serverStop()
    local psi = self.psiStart + (self.psiTarget - self.psiStart) * self.netAction:getProgress()
    self.part:setContainerContentAmount(math.floor(psi),true,true)
    self.vehicle:transmitPartModData(self.part)
end

function ISInflateTire:perform()
	self.item:setJobDelta(0)
	local wheelIndex = self.part:getWheelIndex()
	self.vehicle:setTireInflation(wheelIndex, self.part:getContainerContentAmount() / self.part:getContainerCapacity())

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISInflateTire:complete()
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

function ISInflateTire:getDuration()
    if self.character:isTimedActionInstant() then
       return 1
    end
	return math.ceil(self.psiTarget - self.part:getContainerContentAmount()) * 100
end

function ISInflateTire:new(character, part, item, psiTarget)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = part:getVehicle()
	o.part = part
	o.item = item
	o.psiStart = part:getContainerContentAmount()
	o.psiTarget = psiTarget
	o.stopOnWalk = true
	o.stopOnRun = true
	o.maxTime = o:getDuration()
	o.jobType = getText("IGUI_JobType_InflateTire")
	return o
end

