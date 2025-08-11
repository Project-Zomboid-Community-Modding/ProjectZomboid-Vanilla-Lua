require "ISBaseObject"

ISTimedActionQueue = ISBaseObject:derive("ISTimedActionQueue");

ISTimedActionQueue.IDMax = 1;

ISTimedActionQueue.queues = {}

function ISTimedActionQueue:addToQueue (action)
    local count = #self.queue;
    table.insert(self.queue, action );

    -- none in queue, so go!
    if count == 0 then
        self.current = action;
        action:begin();
    end

end

function ISTimedActionQueue:indexOf(action)
    for i,v in ipairs(self.queue) do
        if v == action then
            return i
        end
    end
    return -1
end

function ISTimedActionQueue:indexOfType(type)
    for i,v in ipairs(self.queue) do
        if v.Type == type then
            return i
        end
    end
    return -1
end

function ISTimedActionQueue:removeFromQueue(action)
    local i = self:indexOf(action)
    if i ~= -1 then
        table.remove(self.queue, i)
    end
end

function ISTimedActionQueue:clearQueue()
    if self:isCurrentActionAddingOtherActions() then
        local current = self.queue[1]
        for i=1,current._numAddedActions do
            self.queue[2]:forceCancel()
            table.remove(self.queue, 2)
        end
        current._numAddedActions = 0
        return
    end
    self:cancelQueue();
    table.wipe(self.queue)
end

function ISTimedActionQueue:onCompleted(action)
    -- RJ: this is here to relaunch any timed action after another one was canceled (currently only used for ISOpenCloseDoor.lua)
    local addedBack = false;
    if self.current and self.character and self.current.retriggerLastAction and self.character:getTimedActionToRetrigger() then
        self.character:getTimedActionToRetrigger():getTable().relaunchWithDelta = true; -- when we canceled the previous action, we want to restart it from were we left off (so if out eating action was 50% done, it'll be restarted at 50%)
        self.character:getTimedActionToRetrigger():getTable().fromRelaunch = true; -- this is added to not consume again some items, like in ISEatFoodAction to not use the lighter again.
        self:addToQueue(self.character:getTimedActionToRetrigger():getTable())
        addedBack = true;
    end
    -- Some isValidStart are a bit weird, like the eating will only check for "eat moodle level", meaning smoking will be canceled when we retrigger it, so i want to avoid checking this if we're retriggering
    local checkIsValid = true;
    if self.current and self.character and self.current.retriggerLastAction then
        self.character:setTimedActionToRetrigger(nil);
        if addedBack then
            checkIsValid = false;
        end
    end
	self:removeFromQueue(action)

	self.current = self.queue[1]

	if self.current then
        if not checkIsValid or self.current:isValidStart() then
            local newDelta = 0;
            if self.current.action then
                newDelta = self.current:getJobDelta();
            end
            self.current:begin()
            if self.current and self.current.relaunchWithDelta and self.current.action then

                self.current:setJobDelta(newDelta)
            end
        else
            print('ISTimedActionQueue:onCompleted: bugged action, cleared queue ', self.current.Type or "???")
            self:resetQueue()
            return
        end
	end
end


function ISTimedActionQueue:resetQueue()
    self:cancelQueue();
	table.wipe(self.queue)
	self.current = nil;
end

function ISTimedActionQueue:cancelQueue()
    for i = 1, #self.queue do
        if not self.queue[i]:isStarted() then
            self.queue[i]:forceCancel();
        end
    end
end

function ISTimedActionQueue:tick()
	local action = self.queue[1]
	if action == nil then
		self:clearQueue()
		return
	end
	if not action.character:getCharacterActions():contains(action.action) then
		print('ISTimedActionQueue:tick: bugged action, cleared queue ', action.Type or "???")
		self:resetQueue()
		action.character:setIsFarming(false)
        return
	end
	if action.action:hasStalled() then
		self:onCompleted(action)
		return
	end
end

function ISTimedActionQueue:isCurrentActionAddingOtherActions()
    local current = self.queue[1]
    return (current ~= nil) and current._isAddingActions and (tonumber(current._numAddedActions) ~= nil)
end

--************************************************************************--
--** ISTimedActionQueue:new
--**
--************************************************************************--
function ISTimedActionQueue:new (character)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.queue = {}
	ISTimedActionQueue.queues[character] = o;
	return o
end

ISTimedActionQueue.getTimedActionQueue = function(character)
	local queue = ISTimedActionQueue.queues[character];
	if queue == nil then
		queue = ISTimedActionQueue:new(character);
	end

	return queue;
end

ISTimedActionQueue.add = function(action)
	if action.ignoreAction then
		return;
	end
	if instanceof(action.character, "IsoGameCharacter") and action.character:isAsleep() then
		return;
	end
	local queue = ISTimedActionQueue.getTimedActionQueue(action.character);

    if instanceof(action.character, "IsoGameCharacter") and action.character:isFarming() then
        action.stopOnAim = false;
    end

    ---- to cancel eating actions when performing other actions
    --local eatingNonConflictAction = action.isEating or action.clothingAction;
    --local oldEating = false;
    --local actualQueue = queue.queue
    --if not eatingNonConflictAction then
    --    for i,v in ipairs(actualQueue) do
    --        if v.isEating then
    --            oldEating = true
    --            CancelAction(queue.character:getPlayerNum())
    --            break
    --        end
    --    end
    --end

--     getPlayer():Say("oldEating " .. tostring(oldEating))

	-- This is to handle an action queueing other actions inside it's perform() method.
	if queue:isCurrentActionAddingOtherActions() then
		local current = queue.queue[1];
		table.insert(queue.queue, 2 + current._numAddedActions, action);
		current._numAddedActions = current._numAddedActions + 1;
		return queue;
	end

	queue:addToQueue(action);
	return queue;
end

ISTimedActionQueue.addAfter = function(previousAction, action)
	if action.ignoreAction then
		return nil;
	end
    if instanceof(action.character, "IsoGameCharacter") and action.character:isAsleep() then
        return nil;
    end
    local queue = ISTimedActionQueue.getTimedActionQueue(action.character);
    local i = queue:indexOf(previousAction)
    if i ~= -1 then
        table.insert(queue.queue, i + 1, action);
        return queue,action;
    end
    return nil
end

ISTimedActionQueue.queueActions = function(character, addActionsFunction, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    local action = ISQueueActionsAction:new(character, addActionsFunction, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    return ISTimedActionQueue.add(action)
end

ISTimedActionQueue.addGetUpAndThen = function(character, action)
	local action1 = ISWaitWhileGettingUp:new(character)
	action1.retriggerLastAction = action.retriggerLastAction
	action1:setOnComplete(ISTimedActionQueue.add, action)
	ISTimedActionQueue.add(action1)
end

ISTimedActionQueue.clear = function(character)
    local queue = ISTimedActionQueue.getTimedActionQueue(character);
    if not queue:isCurrentActionAddingOtherActions() then
        character:StopAllActionQueue();
    end
    queue:clearQueue();
    return queue;
end

ISTimedActionQueue.hasAction = function(action)
    if action == nil then return false end
    local queue = ISTimedActionQueue.queues[action.character]
    if queue == nil then return false end
    return queue:indexOf(action) ~= -1
end

ISTimedActionQueue.hasActionType = function(character, type)
    if character == nil or type == nil then return false end
    local queue = ISTimedActionQueue.queues[character]
    if queue == nil then return false end
    return queue:indexOfType(type) ~= -1
end

local STATES = {}
STATES[ClimbThroughWindowState.instance()] = true
STATES[ClimbOverFenceState.instance()] = true
STATES[ClimbOverWallState.instance()] = true
STATES[ClimbSheetRopeState.instance()] = true
STATES[ClimbDownSheetRopeState.instance()] = true
STATES[CloseWindowState.instance()] = true
STATES[OpenWindowState.instance()] = true

ISTimedActionQueue.isPlayerDoingAction = function(playerObj)
    if not playerObj then return false end
    if playerObj:isDead() then return false end
    if not playerObj:getCharacterActions():isEmpty() then return true end
    local state = playerObj:getCurrentState()
    if STATES[state] then return true end
    return false
end

-- master function for stalled queues
ISTimedActionQueue.onTick = function()

    for _,queue in pairs(ISTimedActionQueue.queues) do
        queue:tick()
    end

    if not getCore():getOptionTimedActionGameSpeedReset() then
        return
    end
    
    local isDoingAction = false
    for playerNum = 1,getNumActivePlayers() do
        local playerObj = getSpecificPlayer(playerNum-1)
        if ISTimedActionQueue.isPlayerDoingAction(playerObj) then
            isDoingAction = true
            break
        end
    end

    if isDoingAction then
        ISTimedActionQueue.shouldResetGameSpeed = true
    elseif ISTimedActionQueue.shouldResetGameSpeed then
        ISTimedActionQueue.shouldResetGameSpeed = false
        if UIManager.getSpeedControls() and (UIManager.getSpeedControls():getCurrentGameSpeed() > 1) then
            UIManager.getSpeedControls():SetCurrentGameSpeed(1)
        end
    end
end

Events.OnTick.Add(ISTimedActionQueue.onTick);

