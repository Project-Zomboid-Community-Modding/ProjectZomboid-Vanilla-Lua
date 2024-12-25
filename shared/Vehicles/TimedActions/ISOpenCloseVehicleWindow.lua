--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISOpenCloseVehicleWindow = ISBaseTimedAction:derive("ISOpenCloseVehicleWindow")

function ISOpenCloseVehicleWindow:isValid()
	-- TODO: if zombie reaching in the window, can't close it
	local installed = not self.part:getItemType() or (self.part:getInventoryItem() ~= nil)
	return installed and self.window and
		(self.window:isOpen() ~= self.open) and
		not self.window:isDestroyed()
end

function ISOpenCloseVehicleWindow:update()
	-- TODO: animate window + character
	self.window:setOpenDelta(self.open and self:getJobDelta() or (1 - self:getJobDelta()))
end

function ISOpenCloseVehicleWindow:start()
	self.vehicle:playPartSound(self.part, self.character, self.open and "Open" or "Close")
end

function ISOpenCloseVehicleWindow:stop()
	self.window:setOpenDelta(self.window:isOpen() and 1.0 or 0.0)
	ISBaseTimedAction.stop(self)
end

function ISOpenCloseVehicleWindow:perform()

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISOpenCloseVehicleWindow:complete()
   	if self.vehicle then
   		if not self.part then
   			print('no such part '..tostring(self.part))
   			return
   		end
   		if not self.part:getWindow() then
   			print('part ' .. self.part .. ' has no window')
   			return
   		end
   		self.part:getWindow():setOpen(self.open)
   		self.vehicle:transmitPartWindow(self.part)
   	else
   		print('no such vehicle id='..tostring(self.vehicle))
   	end
   	return true
end

function ISOpenCloseVehicleWindow:getDuration()
	if self.character:isTimedActionInstant() then
		return 1;
	end
	return 50
end

function ISOpenCloseVehicleWindow:new(character, part, open)
	local o = ISBaseTimedAction.new(self, character)
	o.vehicle = part:getVehicle()
	o.part = part
	o.window = part:getWindow()
	o.open = open
	o.stopOnWalk = false
	o.ignoreHandsWounds = true;
	o.stopOnRun = false
	o.maxTime = o:getDuration()
	return o
end

