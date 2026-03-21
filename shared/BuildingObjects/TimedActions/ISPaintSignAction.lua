require "TimedActions/ISBaseTimedAction"

ISPaintSignAction = ISBaseTimedAction:derive("ISPaintSignAction");

function ISPaintSignAction:isValid()
	return true;
end

function ISPaintSignAction:update()
    self.character:setMetabolicTarget(Metabolics.HeavyDomestic)
end

function ISPaintSignAction:start()
    self:setActionAnim(CharacterActionAnims.Paint)
    self:setOverrideHandModels("PaintBrush", nil)
    self.character:faceThisObject(self.wall)
    self.sound = self.character:playSound("Painting")
end

function ISPaintSignAction:stop()
    if self.sound then self.character:stopOrTriggerSound(self.sound) end
    ISBaseTimedAction.stop(self)
end

function ISPaintSignAction:perform()
    if self.sound then self.character:stopOrTriggerSound(self.sound) end
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISPaintSignAction:complete()
    if self.wall:getProperties():has("WallW") then
        self.sign = self.sign + 8
    end
    self.wall:setOverlaySprite("constructedobjects_signs_01_" .. self.sign, self.r or 1.0, self.g or 1.0, self.b or 1.0, 1)
    if not self.isBuildCheat then
        self.paintPot:UseAndSync()
    end

    return true
end

function ISPaintSignAction:getDuration()
    if self.character:isTimedActionInstant() or self.isBuildCheat then
        return 1
    end
    return 100
end

function ISPaintSignAction:new(character, wall, paintPot, sign, r, g, b)
    local o = ISBaseTimedAction.new(self, character)
	o.wall = wall
	o.paintPot = paintPot
	o.sign = sign
    o.r = r
    o.g = g
    o.b = b
	o.maxTime = o:getDuration()
    o.caloriesModifier = 4
    if isMultiplayer() then
        o.isBuildCheat = character:isBuildCheat()
    else
        o.isBuildCheat = ISBuildMenu.cheat
    end
	return o
end
