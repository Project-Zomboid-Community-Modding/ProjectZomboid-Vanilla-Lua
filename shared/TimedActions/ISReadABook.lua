--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISReadABook = ISBaseTimedAction:derive("ISReadABook");

function ISReadABook:isValid()
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
        if self.item:getLvlSkillTrained() > self.character:getPerkLevel(SkillBook[self.item:getSkillTrained()].perk) + 1 or self.character:HasTrait("Illiterate") then
            if self.pageTimer >= 200 then
                self.pageTimer = 0;
                local txtRandom = ZombRand(3);
                if txtRandom == 0 then
--                     self.character:Say(getText("IGUI_PlayerText_DontGet"));
					HaloTextHelper.addBadText(self.character, getText("IGUI_PlayerText_DontGet"));
-- 					HaloTextHelper.addText(self.character, getText("IGUI_PlayerText_DontGet"), getCore():getGoodHighlitedColor());
                elseif txtRandom == 1 then
--                     self.character:Say(getText("IGUI_PlayerText_TooComplicated"));
					HaloTextHelper.addBadText(self.character, getText("IGUI_PlayerText_TooComplicated"));
-- 					HaloTextHelper.addText(self.character, getText("IGUI_PlayerText_TooComplicated"), getCore():getGoodHighlitedColor());
                else
--                     self.character:Say(getText("IGUI_PlayerText_DontUnderstand"));
					HaloTextHelper.addBadText(self.character, getText("IGUI_PlayerText_DontUnderstand"));
-- 					HaloTextHelper.addText(self.character, getText("IGUI_PlayerText_DontUnderstand"), getCore():getGoodHighlitedColor());
                end
                if self.item:getNumberOfPages() > 0 then
                    self.character:setAlreadyReadPages(self.item:getFullType(), 0)
                    self:forceStop()
                end
            end
        elseif self.item:getMaxLevelTrained() < self.character:getPerkLevel(SkillBook[self.item:getSkillTrained()].perk) + 1 then
            if self.pageTimer >= 200 then
                self.pageTimer = 0;
                local txtRandom = ZombRand(2);
                if txtRandom == 0 then
--                     self.character:Say(getText("IGUI_PlayerText_KnowSkill"));
					HaloTextHelper.addGoodText(self.character, getText("IGUI_PlayerText_KnowSkill"));
-- 					HaloTextHelper.addText(self.character, getText("IGUI_PlayerText_KnowSkill"), getCore():getGoodHighlitedColor());
                else
--                     self.character:Say(getText("IGUI_PlayerText_BookObsolete"));
					HaloTextHelper.addGoodText(self.character, getText("IGUI_PlayerText_BookObsolete"));
-- 					HaloTextHelper.addText(self.character, getText("IGUI_PlayerText_BookObsolete"), getCore():getGoodHighlitedColor());
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
    if self.stats and (self.item:getBoredomChange() < 0.0) then
        if bodyDamage:getBoredomLevel() > self.stats.boredom then
            bodyDamage:setBoredomLevel(self.stats.boredom)
        end
    end
    if self.stats and (self.item:getUnhappyChange() < 0.0) then
        if bodyDamage:getUnhappynessLevel() > self.stats.unhappyness then
            bodyDamage:setUnhappynessLevel(self.stats.unhappyness)
        end
    end
    if self.stats and (self.item:getStressChange() < 0.0) then
        if stats:getBasicStress() > self.stats.stress then
            stats:setStress(self.stats.stress)
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
    if (item:getLvlSkillTrained() > level + 1) or character:HasTrait("Illiterate") then
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
    elseif (self.item:getType() == "Newspaper" or self.item:hasTag("NewspaperRead")) then
        self:setAnimVariable("ReadType", "newspaper")
    elseif (self.item:hasTag("Picture")) then
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
        self.stats.boredom = self.character:getBodyDamage():getBoredomLevel()
        self.stats.unhappyness = self.character:getBodyDamage():getUnhappynessLevel()
        self.stats.stress = self.character:getStats():getBasicStress()
    end

    if self:isBook(self.item) then
        self.character:playSound("OpenBook")
    else
        self.character:playSound("OpenMagazine")
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
--    if self.item:getTeachedRecipes() and not self.item:getTeachedRecipes():isEmpty() then
--        for i=0, self.item:getTeachedRecipes():size() - 1 do
--           if not self.character:getKnownRecipes():contains(self.item:getTeachedRecipes():get(i)) then
--               self.character:getKnownRecipes():add(self.item:getTeachedRecipes():get(i));
--           else
--               self.character:Say(getText("IGUI_PlayerText_KnowSkill"));
--           end
--        end
--    end
    if self:isBook(self.item) then
        self.character:playSound("CloseBook")
    else
        self.character:playSound("CloseMagazine")
    end

    self.isLiteratureRead = nil
    if self.item:getModData().literatureTitle then
        --         self.character:Say(self.item:getModData().literatureTitle)
        self.isLiteratureRead = self.character:isLiteratureRead(self.item:getModData().literatureTitle)
        self.character:addReadLiterature(self.item:getModData().literatureTitle)
    end

    if self.item:getModData().printMedia then
        --local val = "TheKentuckyHerald_July9"
        local val = self.item:getModData().printMedia
        local win = PZAPI.UI.PrintMedia{
            x = 730, y = 100,
        }
        win.media_id = val
        win.data = getText("Print_Media_" .. val .. "_info")
        win.children.bar.children.name.text = getText("Print_Media_" .. val .. "_title")
        win.textTitle = getText("Print_Text_" .. val .. "_title")
        win.textData = string.gsub(getText("Print_Text_" .. val .. "_info"), "\\n", "\n")


        win:instantiate()
        win.javaObj:setAlwaysOnTop(false)

        --[[
        local index = self.item:getModData().printMedia
        local panel = ISPrintMediaPage:new(0, 0, index, self.character, self.item);
        panel:initialise();
        panel:addToUIManager();

        panel:setX((getCore():getScreenWidth() / 2) - (panel.width / 2));
        panel:setY((getCore():getScreenHeight() / 2) - (panel.height / 2));

        ISLayoutManager.RegisterWindow('PrintMedia', PrintMediaManager, self)
        if PrintMediaDefinitions.MiscDetails[index] and PrintMediaDefinitions.MiscDetails[index].locations then
            local locations = PrintMediaDefinitions.MiscDetails[index].locations

            for i = 1, #locations do
                local location = locations[i]
                if location.x1 and location.x2 and location.y1 and location.y2 then
                    local x1 = math.floor(locations[i].x1)
                    local y1 = math.floor(locations[i].y1)
                    local x2 = math.floor(locations[i].x2)
                    local y2 = math.floor(locations[i].y2)
                    WorldMapVisited.getInstance():setKnownInSquares(x1, y1, x2, y2)

                elseif location.x and location.y then
                    local x = math.floor(locations[i].x/300)
                    local y = math.floor(locations[i].y/300)
                    WorldMapVisited.getInstance():setKnownInCells(x, y, x, y)
                end
            end
        end
        ]]
    end
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end

function ISReadABook:complete()
    self.item:setJobDelta(0.0);

    if self.item:getTeachedRecipes() and not self.item:getTeachedRecipes():isEmpty() then
        self.character:getAlreadyReadBook():add(self.item:getFullType());
        --wacky hacky for herbalist trait
        if self.item:getTeachedRecipes():contains("Herbalist") then
            self.character:getTraits():add("Herbalist");
        end
    end

    if not SkillBook[self.item:getSkillTrained()] and not self.isLiteratureRead then
        self.character:ReadLiterature(self.item);

        local args = { itemId=self.item:getID() }
        sendServerCommand(self.character, 'literature', 'readLiterature', args)

    elseif self.item:getAlreadyReadPages() >= self.item:getNumberOfPages() then
        self.item:setAlreadyReadPages(0);
    end

    if self.item:getModData().teachedRecipe ~= nil then
        self.character:learnRecipe(self.item:getModData().teachedRecipe)
--         self.character:getKnownRecipes():add(self.item:getModData().teachedRecipe)
    end

    if self.item:getModData().literatureTitle then
        --         self.character:Say(self.item:getModData().literatureTitle)
        self.character:addReadLiterature(self.item:getModData().literatureTitle)
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
            if self.item:getLvlSkillTrained() > self.character:getPerkLevel(SkillBook[self.item:getSkillTrained()].perk) + 1 or self.character:HasTrait("Illiterate") then
                if self.item:getNumberOfPages() > 0 then
                    self.character:setAlreadyReadPages(self.item:getFullType(), 0)
                    self.item:setAlreadyReadPages(0);
                    syncItemFields(self.character, self.item)
                    self.netAction:forceComplete()
                end
            elseif self.item:getMaxLevelTrained() >= self.character:getPerkLevel(SkillBook[self.item:getSkillTrained()].perk) + 1 then
                ISReadABook.checkMultiplier(self);
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
        numPages = self.item:getNumberOfPages() -- item:getAlreadyReadPages()
    else
        numPages = 5
    end

    local f = 1 / getGameTime():getMinutesPerDay() / 2
    local time = numPages * self.minutesPerPage / f
    if self.item:hasTag("FastRead") then
        time = 50
    end
    if(self.character:HasTrait("FastReader")) then
        time = time * 0.7;
    end
    if(self.character:HasTrait("SlowReader")) then
        time = time * 1.3;
    end

    --reading glasses are a little faster
    local eyeItem = self.character:getWornItems():getItem("Eyes");
    if(eyeItem and eyeItem:getType() == "Glasses_Reading") then
        time = time * 0.9;
    end

    return time;
end

function ISReadABook:new(character, item)
    local o = ISBaseTimedAction.new(self, character);
    o.character = character;
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
