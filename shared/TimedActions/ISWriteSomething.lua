--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"
ISWriteSomething = ISBaseTimedAction:derive("ISWriteSomething");


function ISWriteSomething:isValid()
	if self.character:tooDarkToRead() then
-- 	if self.character:getSquare():getLightLevel(self.character:getPlayerNum()) < 0.43 then
		-- self.character:Say(getText("ContextMenu_TooDark"))
		HaloTextHelper.addBadText(self.character, getText("ContextMenu_TooDark"));
-- 		HaloTextHelper.addText(self.character, getText("ContextMenu_TooDark"), getCore():getGoodHighlitedColor());
		return false
	end
    local vehicle = self.character:getVehicle()
    if vehicle and vehicle:isDriver(self.character) then
        return not vehicle:isEngineRunning() or vehicle:getSpeed2D() == 0
    end
    if isClient() and self.item then
        return self.container:containsID(self.item:getID()) and ((self.item:getNumberOfPages() > 0 and self.item:getAlreadyReadPages() <= self.item:getNumberOfPages()) or self.item:getNumberOfPages() < 0);
    else
        return self.container:containsID(self.item:getID()) and ((self.item:getNumberOfPages() > 0 and self.item:getAlreadyReadPages() <= self.item:getNumberOfPages()) or self.item:getNumberOfPages() < 0);
    end
end

function ISWriteSomething:update()

end


function ISWriteSomething:start()
    if isClient() and self.item then
        self.item = self.container:getItemById(self.item:getID())
    end

    if self.item:getReadType() then
        self:setAnimVariable("ReadType", self.item:getReadType())
    elseif (self.item:getType() == "Newspaper" or self.item:hasTag("NewspaperRead")) then
        self:setAnimVariable("ReadType", "newspaper")
    elseif (self.item:hasTag("Picture")) then
        self:setAnimVariable("ReadType", "photo")
    else
        self:setAnimVariable("ReadType", "book")
    end
    self:setActionAnim(CharacterActionAnims.Read);
    self:setOverrideHandModels(nil, self.item);

    self.character:reportEvent("EventRead");

    if self:isBook(self.item) then
        self.character:playSound("OpenBook")
    else
        self.character:playSound("OpenMagazine")
    end
end

function ISWriteSomething:stop()
    if self.item:getNumberOfPages() > 0 and self.item:getAlreadyReadPages() >= self.item:getNumberOfPages() then
        self.item:setAlreadyReadPages(self.item:getNumberOfPages());
    end

    syncItemFields(self.character, self.item);

    if self:isBook(self.item) then
        self.character:playSound("CloseBook")
    else
        self.character:playSound("CloseMagazine")
    end

    self.modal:destroy()

    ISBaseTimedAction.stop(self);
end

function ISWriteSomething:serverStart()
    self.character:setReading(true);
    -- PF_Reading
    sendSyncPlayerFields(self.character, 0x00000010);
end

function ISWriteSomething:serverStop()
    self.character:setReading(false);

    -- PF_Reading
    sendSyncPlayerFields(self.character, 0x00000010);
end

function ISWriteSomething:perform()
    if self:isBook(self.item) then
        self.character:playSound("CloseBook")
    else
        self.character:playSound("CloseMagazine")
    end

    self.modal:destroy()

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISWriteSomething:complete()
    self.character:setReading(false);

    -- PF_Reading
    sendSyncPlayerFields(self.character, 0x00000010);

    return true;
end

function ISWriteSomething:animEvent(event, parameter)
    if event == "PageFlip" then
        if getGameSpeed() ~= 1 then
            return
        end
        if self:isBook(self.item) then
            self.character:playSound("PageFlipBook")
        else
            self.character:playSound("PageFlipMagazine")
        end
    end
end

function ISWriteSomething:isBook(item)
	if not item then return false end
	return string.match(item:getType(), "Book")
end

function ISWriteSomething:getDuration()
    return -1;
end

function ISWriteSomething:new(character, item)
    local o = ISBaseTimedAction.new(self, character);
    o.character = character;
    o.item = item;
    o.container = item:getOutermostContainer();
    o.ignoreHandsWounds = true;
    o.maxTime = o:getDuration();
    return o;
end
