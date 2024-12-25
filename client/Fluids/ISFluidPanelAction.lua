--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISFluidPanelAction = ISBaseTimedAction:derive("ISFluidPanelAction")

function ISFluidPanelAction:isValid()
    if self.container then
        return ISFluidUtil.validateContainer(self.container)
    end
end

function ISFluidPanelAction:update()
end

function ISFluidPanelAction:start()
end

function ISFluidPanelAction:stop()
	ISBaseTimedAction.stop(self)
end

function ISFluidPanelAction:perform()
	if self.panelClass and self.panelClass["OpenPanel"] then
		self.panelClass.OpenPanel(self.character, self.container, self.source)
	end
	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISFluidPanelAction:new(character, _container, _panelClass, isSource)
	local o = ISBaseTimedAction.new(self, character)
    if not ISFluidUtil.validateContainer(_container) then
        print("ISFluidPanelAction not a valid (ISFluidContainer) container?")
    end
	o.container = _container;
	o.panelClass = _panelClass;
	o.source = isSource;
	o.maxTime = 10;
	if o.character:isTimedActionInstant() then o.maxTime = 1; end
	return o
end