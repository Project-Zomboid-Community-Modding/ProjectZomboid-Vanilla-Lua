require "TimedActions/ISBaseTimedAction"

ISSmashWindow = ISBaseTimedAction:derive("ISSmashWindow");

function ISSmashWindow:isValid()
    return true;
end

function ISSmashWindow:waitToStart()
    if self.vehiclePart ~= nil then
        self.character:faceThisObject(self.vehiclePart:getVehicle());
    else
        self.character:faceThisObject(self.window)
    end

    return self.character:isPlayerMoving() or self.character:isTurning() or self.character:shouldBeTurning()
end

function ISSmashWindow:update()
    self.character:setMetabolicTarget(Metabolics.UsingTools);
end

function ISSmashWindow:start()
    if self.vehiclePart ~= nil then
        self.character:smashCarWindow(self.vehiclePart);
    else
        self.character:smashWindow(self.window);
    end
end

function ISSmashWindow:serverStart()
end

function ISSmashWindow:stop()
    ISBaseTimedAction.stop(self);
end

function ISSmashWindow:perform()
    if isClient() then
        self.character:playerVoiceSound("PainFromGlassCut")
    end
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISSmashWindow:complete()
    if isServer() and not self.window:isDestroyed() then
        if self.vehiclePart ~= nil then
            self.window:hit(self.character);
        else
            self.window:WeaponHit(self.character, nil);
        end

        if not instanceof(self.character:getPrimaryHandItem(),"HandWeapon") and not instanceof(self.character:getSecondaryHandItem(),"HandWeapon") then
            self.character:getBodyDamage():setScratchedWindow();
            sendDamage(self.character);
        end
    end

    return true;
end

function ISSmashWindow:getDuration()
    return 35;
end

function ISSmashWindow:new(character, window, vehiclePart)
    local o = ISBaseTimedAction.new(self, character)
    o.vehiclePart = vehiclePart;
    o.window = window;
    o.maxTime = o:getDuration()
    o.useProgressBar = false;
    return o;
end