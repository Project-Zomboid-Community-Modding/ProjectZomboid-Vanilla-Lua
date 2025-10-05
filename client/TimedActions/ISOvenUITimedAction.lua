--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISOvenUITimedAction = ISBaseTimedAction:derive("ISOvenUITimedAction");

function ISOvenUITimedAction:isValid()
    return true;
end

function ISOvenUITimedAction:update()
	self.character:faceThisObject(self.mcwave or self.stove)
end

function ISOvenUITimedAction:start()
end

function ISOvenUITimedAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISOvenUITimedAction:perform()
    ISBaseTimedAction.perform(self);

	local player = self.character:getPlayerNum()
	local ui
    if self.mcwave then
        if ISMicrowaveUI.instance and ISMicrowaveUI.instance[player+1] then
            ISMicrowaveUI.instance[player+1].close:forceClick()
        end
        ui = ISMicrowaveUI:new(0,0,430,280, self.mcwave, self.character);
        ui:initialise();
        ui:addToUIManager();
    else
        if ISOvenUI.instance and ISOvenUI.instance[player+1] then
            ISOvenUI.instance[player+1].close:forceClick()
        end
        ui = ISOvenUI:new(0,0,430,310, self.stove, self.character);
        ui:initialise();
        ui:addToUIManager();
    end

    if JoypadState.players[player+1] then
        ui.prevFocus = JoypadState.players[player+1].focus
        setJoypadFocus(player, ui)
    end
end

function ISOvenUITimedAction:new(character, stove, mcwave)
    local o = ISBaseTimedAction.new(self, character)
    o.stove = stove;
    o.mcwave = mcwave;
    o.maxTime = 0;
    return o;
end
