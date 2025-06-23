--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISWaitWhileGettingUp = ISBaseTimedAction:derive("ISWaitWhileGettingUp")

function ISWaitWhileGettingUp:isValid()
	return true
end

function ISWaitWhileGettingUp:waitToStart()
	return false
end

function ISWaitWhileGettingUp:start()
	if not self.character:isSitOnGround() and not self.character:isSittingOnFurniture() then
		self:forceComplete()
		return
	end
	self.character:setVariable("forceGetUp", true)
end

function ISWaitWhileGettingUp:update()
	if not self.character:isSitOnGround() and not self.character:isSittingOnFurniture() then
		self:forceComplete()
	end
end

function ISWaitWhileGettingUp:stop()
	ISBaseTimedAction.stop(self)
end

function ISWaitWhileGettingUp:perform()
	local actionToRetrigger = self.character:getTimedActionToRetrigger()
	self.retriggerLastAction = false

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)

	self.character:setTimedActionToRetrigger(actionToRetrigger)

	self:beginAddingActions()
	if self.onCompleteFunc then
		local a = self.onCompleteArgs
		self.onCompleteFunc(a.p1, a.p2, a.p3, a.p4, a.p5, a.p6, a.p7, a.p8, a.p9, a.p10)
	end
	self:endAddingActions()
end

function ISWaitWhileGettingUp:complete()
	return true
end

function ISWaitWhileGettingUp:setOnComplete(func, p1, p2, p3, p4, p5, p6, p7, p8, p9, p10, ...)
	local nArgs = select("#", ...)
	if nArgs > 0 then
		error("only 10 additional arguments are supported,")
	end
	self.onCompleteFunc = func
	-- Any of these may be nil, so we can't take advantage of "..." syntax :-(
	self.onCompleteArgs = { p1=p1, p2=p2, p3=p3, p4=p4, p5=p5, p6=p6, p7=p7, p8=p8, p9=p9, p10=p10 }
end

function ISWaitWhileGettingUp:getDuration()
	return -1
end

function ISWaitWhileGettingUp:new(character)
	local o = ISBaseTimedAction.new(self, character)
	o.stopOnAim = false
	o.stopOnWalk = false
	o.stopOnRun = false
	o.maxTime = o:getDuration()
	o.useProgressBar = false
	return o
end	
