require "TimedActions/ISBaseTimedAction"

ISReadABook = ISBaseTimedAction:derive("ISReadABook");

function ISReadABook:isValid()
	if self.character:tooDarkToRead() then
		HaloTextHelper.addBadText(self.character, getText("ContextMenu_TooDark"));
		return false
	end
    local vehicle = self.character:getVehicle()
    if vehicle and vehicle:isDriver(self.character) then
        return not vehicle:isEngineRunning() or vehicle:getSpeed2D() == 0
    end
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID()) and ((self.item:getNumberOfPages() > 0 and self.item:getAlreadyReadPages() <= self.item:getNumberOfPages()) or self.item:getNumberOfPages() < 0);
    else
        return self.character:getInventory():contains(self.item) and ((self.item:getNumberOfPages() > 0 and self.item:getAlreadyReadPages() <= self.item:getNumberOfPages()) or self.item:getNumberOfPages() < 0);
    end
end

function ISReadABook:isUsingTimeout()
    return false;
end

function ISReadABook:update()
    self.pageTimer = self.pageTimer + getGameTime():getMultiplier();
    self.item:setJobDelta(self:getJobDelta());
    if not isClient() then
        if self.item:getNumberOfPages() > 0 then
            local pagesRead = math.floor(self.item:getNumberOfPages() * self:getJobDelta())
            self.item:setAlreadyReadPages(pagesRead);
            if self.item:getAlreadyReadPages() > self.item:getNumberOfPages() then
                self.item:setAlreadyReadPages(self.item:getNumberOfPages());
            end
            self.character:setAlreadyReadPages(self.item:getFullType(), self.item:getAlreadyReadPages())
        end
    end
    if SkillBook[self.item:getSkillTrained()] then
        if self.item:getLvlSkillTrained() > self.character:getPerkLevel(SkillBook[self.item:getSkillTrained()].perk) + 1 or self.character:hasTrait(CharacterTrait.ILLITERATE) then
            if self.pageTimer >= 200 then
                self.pageTimer = 0;
                if not isClient() then
                    self:doHaloText()
                end
                if self.item:getNumberOfPages() > 0 then
                    self.character:setAlreadyReadPages(self.item:getFullType(), 0)
                    self:forceStop()
                end
            end
        elseif self.item:getMaxLevelTrained() < self.character:getPerkLevel(SkillBook[self.item:getSkillTrained()].perk) + 1 then
            if self.pageTimer >= 200 then
                self.pageTimer = 0;
                if not isClient() then
                    self:doHaloText()
                end
            end
        else
            if not isClient() then
                ISReadABook.checkMultiplier(self);
            end
        end
    end

    -- Playing with longer day length reduces the effectiveness of morale-boosting
    -- literature, like Comic Book.
    local bodyDamage = self.character:getBodyDamage()
    local stats = self.character:getStats()
    if self.stats and (self.item:getUnhappyChange() < 0.0) then
        if stats:get(CharacterStat.UNHAPPINESS) > self.stats.unhappiness then
            stats:set(CharacterStat.UNHAPPINESS, self.stats.unhappiness)
        end
    end
end

function ISReadABook:doHaloText()
    if SkillBook[self.item:getSkillTrained()] == nil then
        return
    end
    if self.item:getLvlSkillTrained() > self.character:getPerkLevel(SkillBook[self.item:getSkillTrained()].perk) + 1 or self.character:hasTrait(CharacterTrait.ILLITERATE) then
        local txtRandom = ZombRand(3);
        if txtRandom == 0 then
            HaloTextHelper.addBadText(self.character, getText("IGUI_PlayerText_DontGet"));
        elseif txtRandom == 1 then
            HaloTextHelper.addBadText(self.character, getText("IGUI_PlayerText_TooComplicated"));
        else
            HaloTextHelper.addBadText(self.character, getText("IGUI_PlayerText_DontUnderstand"));
        end
    elseif self.item:getMaxLevelTrained() < self.character:getPerkLevel(SkillBook[self.item:getSkillTrained()].perk) + 1 then
        local txtRandom = ZombRand(2);
        if txtRandom == 0 then
            HaloTextHelper.addGoodText(self.character, getText("IGUI_PlayerText_KnowSkill"));
        else
            HaloTextHelper.addGoodText(self.character, getText("IGUI_PlayerText_BookObsolete"));
        end
    end
end

-- get how much % of the book we already read, then we apply a multiplier depending on the book read progress
ISReadABook.checkMultiplier = function(self)
-- get all our info in the map
    local trainedStuff = SkillBook[self.item:getSkillTrained()];
    if trainedStuff then
        -- every 10% we add 10% of the max multiplier
        local readPercent = (self.item:getAlreadyReadPages() / self.item:getNumberOfPages()) * 100;
        if readPercent > 100 then
            readPercent = 100;
        end
        -- apply the multiplier to the skill
        local multiplier = (math.floor(readPercent/10) * (self.maxMultiplier/10));
        if multiplier > self.character:getXp():getMultiplier(trainedStuff.perk) then
            addXpMultiplier(self.character, trainedStuff.perk, multiplier, self.item:getLvlSkillTrained(), self.item:getMaxLevelTrained());
        end
    end
end

function ISReadABook.checkLevel(character, item)
    if item:getNumberOfPages() <= 0 then
        return
    end
    local skillBook = SkillBook[item:getSkillTrained()]
    if not skillBook then
        return
    end
    local level = character:getPerkLevel(skillBook.perk)
    if (item:getLvlSkillTrained() > level + 1) or character:hasTrait(CharacterTrait.ILLITERATE) then
        item:setAlreadyReadPages(0)
        character:setAlreadyReadPages(item:getFullType(), 0)
    end
end

function ISReadABook:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end

    if self.startPage then
        self:setCurrentTime(self.maxTime * (self.startPage / self.item:getNumberOfPages()))
    end
    self.item:setJobType(getText("ContextMenu_Read") ..' '.. self.item:getName());
    self.item:setJobDelta(0.0);
    --self.character:SetPerformingAction(GameCharacterActions.Reading, nil, self.item)
    if self.item:getReadType() then
        self:setAnimVariable("ReadType", self.item:getReadType())
    elseif (self.item:getType() == "Newspaper" or self.item:hasTag(ItemTag.NEWSPAPER_READ)) then
        self:setAnimVariable("ReadType", "newspaper")
    elseif (self.item:hasTag(ItemTag.PICTURE)) then
        self:setAnimVariable("ReadType", "photo")
    else
        self:setAnimVariable("ReadType", "book")
    end
    self:setActionAnim(CharacterActionAnims.Read);
    self:setOverrideHandModels(nil, self.item);
    self.character:setReading(true)
    
    self.character:reportEvent("EventRead");

    if not SkillBook[self.item:getSkillTrained()] then
        self.stats = {}
        self.stats.boredom = self.character:getStats():get(CharacterStat.BOREDOM);
        self.stats.unhappiness = self.character:getStats():get(CharacterStat.UNHAPPINESS);
        self.stats.stress = self.character:getStats():get(CharacterStat.STRESS);
    end

    if self:isBook(self.item) then
        self.character:playSound("OpenBook")
    else
        self.character:playSound("OpenMagazine")
    end

    if self.item:hasModData() and self.item:getModData().printMedia then
        self:startLoadingPrintMediaTextures()
    end
end

function ISReadABook:stop()
    if self.item:getNumberOfPages() > 0 and self.item:getAlreadyReadPages() >= self.item:getNumberOfPages() then
        self.item:setAlreadyReadPages(self.item:getNumberOfPages());
    end
    self.character:setReading(false);
    self.item:setJobDelta(0.0);
    if self:isBook(self.item) then
        self.character:playSound("CloseBook")
    else
        self.character:playSound("CloseMagazine")
    end
    syncItemFields(self.character, self.item);
    ISBaseTimedAction.stop(self);
end

function ISReadABook:perform()
    self.character:setReading(false);
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);
    if self:isBook(self.item) then
        self.character:playSound("CloseBook")
    else
        self.character:playSound("CloseMagazine")
    end

    self.isLiteratureRead = nil
    if self.item:hasModData() and self.item:getModData().literatureTitle then
        self.isLiteratureRead = self.character:isLiteratureRead(self.item:getModData().literatureTitle)
        self.character:addReadLiterature(self.item:getModData().literatureTitle)
    end

    if self.item:hasModData() and self.item:getModData().printMedia then
        self:displayPrintMedia()
    end

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

-- See init() in PrintMedia.lua
function ISReadABook:startLoadingPrintMediaTextures()
    local mediaID = self.item:getModData().printMedia
    local text = getTextOrNull(mediaID.info)
    if not text then return end
    local elements = string.split(text, "<")
    for i, val in ipairs(elements) do
        if val ~= "" then
            local data = string.split(val, ">")
            local params = {}
            local paramsData = string.split(data[1], ",")
            local incorrectElement = nil
            for _,v in ipairs(paramsData) do
                local temp = string.split(v, ":")
                if temp[1] == nil or temp[2] == nil then
                    incorrectElement = v
                else
                    params[string.trim(temp[1])] = string.trim(temp[2])
                end
            end
            if incorrectElement then
                print("RICH TEXT ERROR: Incorrect string: " .. incorrectElement)
                break
            end
            if params["type"] == "texture" then
                for key,value in pairs(params) do
                    if key == "texture" then
                        loadstring("return " .. value)()
                    end
                end
            end
        end
    end
end

function ISReadABook:displayPrintMedia()
    local val = self.item:getModData().printMedia
    local win = PZAPI.UI.PrintMedia{
        x = 730, y = 100,
    }
    win.media_id = val.id
    win.data = getText(val.info)
    win.children.bar.children.name.text = getText(val.title)
    win.textTitle = getText(val.title)
    win.textData = string.gsub(getText(val.text), "\\n", "\n")
    win:instantiate()
    win.javaObj:setAlwaysOnTop(false)
    win:centerOnScreen(self.playerNum)

    if getCore():getOptionAutoRevealPrintMediaMapLocations() then
        self:revealPrintMediaLocationsOnMap(win.media_id)
    end

    if getJoypadData(self.playerNum) then
        ISAtomUIJoypad.Apply(win)
        win.close = function(self)
            UIManager.RemoveElement(self.javaObj)
            if getJoypadData(self.playerNum) then
                setJoypadFocus(self.playerNum, self.prevFocus)
            end
        end
        win.children.bar.children.closeButton.onLeftClick = function(_self)
            getSoundManager():playUISound(_self.sounds.activate)
            _self.parent.parent:close()
        end
        win.playerNum = self.playerNum
        win.prevFocus = getJoypadData(self.playerNum).focus
        win.onJoypadDown = function(self, button, joypadData)
            if button == Joypad.BButton then
                self.children.bar.children.closeButton:onLeftClick()
            end
            if button == Joypad.XButton then
                self:onClickNewspaperButton()
            end
            if button == Joypad.YButton then
                self:onClickMapButton()
            end
        end
        setJoypadFocus(self.playerNum, win)
    end
end

function ISReadABook:revealPrintMediaLocationsOnMap(mediaID)
    if not PrintMediaDefinitions then
        return
    end
    local miscDetails = PrintMediaDefinitions.MiscDetails[mediaID]
    if not miscDetails then
      return
    end
    for i = 1, 5 do
        local locationData = miscDetails["location" .. i]
        if locationData == nil then
            break
        end
        for _, sqData in ipairs(locationData) do
            WorldMapVisited.getInstance():setKnownInSquares(sqData.x1, sqData.y1, sqData.x2, sqData.y2)
        end
    end
end

function ISReadABook:complete()
    self.item:setJobDelta(0.0);

    if isServer() and self.forceStopped then
        return true
    end

    if self.item:getLearnedRecipes() and not self.item:getLearnedRecipes():isEmpty() then
        self.character:getAlreadyReadBook():add(self.item:getFullType());
         if self.item:getLearnedRecipes():contains("Herbalist") and not self.character:hasTrait(CharacterTrait.HERBALIST) then
             self.character:hasTrait(CharacterTrait.HERBALIST);
         end
    end

    if not SkillBook[self.item:getSkillTrained()] and not self.isLiteratureRead then
        self.character:ReadLiterature(self.item);

        local args = { itemId=self.item:getID() }
        sendServerCommand(self.character, 'literature', 'readLiterature', args)

    elseif self.item:getAlreadyReadPages() >= self.item:getNumberOfPages() then
        self.item:setAlreadyReadPages(0);
    end

    if self.item:hasModData() and self.item:getModData().learnedRecipe ~= nil then
        self.character:learnRecipe(self.item:getModData().learnedRecipe)
    end

    if self.item:hasModData() and self.item:getModData().literatureTitle then
        self.character:addReadLiterature(self.item:getModData().literatureTitle)
    end

    if self.item:hasModData() and self.item:getModData().printMedia then
        self.character:addReadPrintMedia(self.item:getModData().printMedia.id)
    end

    ISReadABook.checkMultiplier(self);
    self.item:setAlreadyReadPages(self.item:getNumberOfPages());

    --PF_Recipes + PF_Traits + PF_AlreadyReadBook
    sendSyncPlayerFields(self.character, 0x00000007);
    syncItemFields(self.character, self.item)

    return true;
end

function ISReadABook:animEvent(event, parameter)
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
    if event == "ReadAPage" then
        if isServer() then
            if SkillBook[self.item:getSkillTrained()] then
                if self.item:getLvlSkillTrained() > self.character:getPerkLevel(SkillBook[self.item:getSkillTrained()].perk) + 1 or self.character:hasTrait(CharacterTrait.ILLITERATE) then
                    if self.item:getNumberOfPages() > 0 then
                        self.character:setAlreadyReadPages(self.item:getFullType(), 0)
                        self.item:setAlreadyReadPages(0);
                        syncItemFields(self.character, self.item)
                        self.forceStopped = true
                        self.netAction:forceComplete()
                        self:doHaloText()
                        return
                    end
                elseif self.item:getMaxLevelTrained() < self.character:getPerkLevel(SkillBook[self.item:getSkillTrained()].perk) + 1 then
                    self:doHaloText()
                else
                    ISReadABook.checkMultiplier(self);
                end
            end
            if self.item:getNumberOfPages() > 0 and self.startPage then
                local pagesRead = math.floor(self.item:getNumberOfPages() * self.netAction:getProgress()) + self.startPage;
                self.item:setAlreadyReadPages(pagesRead);
                if self.item:getAlreadyReadPages() > self.item:getNumberOfPages() then
                    self.item:setAlreadyReadPages(self.item:getNumberOfPages());
                    self.netAction:forceComplete()
                end
                self.character:setAlreadyReadPages(self.item:getFullType(), self.item:getAlreadyReadPages())
                syncItemFields(self.character, self.item)
            end
        end
    end
end

function ISReadABook:isBook(item)
	if not item then return false end
	return string.match(item:getType(), "Book")
end

function ISReadABook:serverStart()
    local numPages = 5
    if self.item:getNumberOfPages() > 0 then
        numPages = self.item:getNumberOfPages()
    end
    emulateAnimEvent(self.netAction, self.maxTime * 8.0 / numPages, "ReadAPage", nil)
end

function ISReadABook:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end

    local numPages
    if self.item:getNumberOfPages() > 0 then
        ISReadABook.checkLevel(self.character, self.item)
        self.item:setAlreadyReadPages(self.character:getAlreadyReadPages(self.item:getFullType()))
        self.startPage = self.item:getAlreadyReadPages()
        numPages = self.item:getNumberOfPages()
    else
        numPages = 5
    end

    local f = 1 / getGameTime():getMinutesPerDay() / 2
    local time = numPages * self.minutesPerPage / f
    if self.item:hasTag(ItemTag.FAST_READ) then
        time = 50
    end
    if(self.character:hasTrait(CharacterTrait.FAST_READER)) then
        time = time * 0.7;
    end
    if(self.character:hasTrait(CharacterTrait.SLOW_READER)) then
        time = time * 1.3;
    end

    --reading glasses are a little faster
    local eyeItem = self.character:getWornItems():getItem(ItemBodyLocation.EYES);
    if(eyeItem and eyeItem:getType() == "Glasses_Reading") then
        time = time * 0.9;
    end

    if self.character:isSitOnGround() or self.character:isSittingOnFurniture() then
        time = time * 0.9;
    end

    return math.max(time, 1);
end

function ISReadABook:new(character, item)
    local o = ISBaseTimedAction.new(self, character);
    o.character = character;
    o.playerNum = character:getPlayerNum()
    o.item = item;

    o.minutesPerPage = getSandboxOptions():getOptionByName("MinutesPerPage"):getValue() or 2.0
    if o.minutesPerPage < 0.0 then o.minutesPerPage = 2.0 end

    if SkillBook[item:getSkillTrained()] then
        if item:getLvlSkillTrained() == 1 then
            o.maxMultiplier = SkillBook[item:getSkillTrained()].maxMultiplier1;
        elseif item:getLvlSkillTrained() == 3 then
            o.maxMultiplier = SkillBook[item:getSkillTrained()].maxMultiplier2;
        elseif item:getLvlSkillTrained() == 5 then
            o.maxMultiplier = SkillBook[item:getSkillTrained()].maxMultiplier3;
        elseif item:getLvlSkillTrained() == 7 then
            o.maxMultiplier = SkillBook[item:getSkillTrained()].maxMultiplier4;
        elseif item:getLvlSkillTrained() == 9 then
            o.maxMultiplier = SkillBook[item:getSkillTrained()].maxMultiplier5;
        else
            o.maxMultiplier = 1
            print('ERROR: book has unhandled skill level ' .. item:getLvlSkillTrained())
        end
    end
    o.ignoreHandsWounds = true;
    o.maxTime = o:getDuration();
    o.caloriesModifier = 0.5;
    o.pageTimer = 0;
    o.forceProgressBar = true;

    return o;
end
