--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISResearchRecipe = ISBaseTimedAction:derive("ISResearchRecipe");

function ISResearchRecipe:isValid()
	if self.character:tooDarkToRead() then
-- 	if self.character:getSquare():getLightLevel(self.character:getPlayerNum()) < 0.43 then
		-- self.character:Say(getText("ContextMenu_TooDark"))		
		HaloTextHelper.addBadText(self.character, getText("ContextMenu_TooDarkToSee"));
-- 		HaloTextHelper.addText(self.character, getText("ContextMenu_TooDark"), getCore():getGoodHighlitedColor());
		return false
	end
    local vehicle = self.character:getVehicle()
    if vehicle and vehicle:isDriver(self.character) then
        return not vehicle:isEngineRunning() or vehicle:getSpeed2D() == 0
    end
    if isClient() and self.item then
        return self.character:getInventory():containsID(self.item:getID());
    else
        return self.character:getInventory():contains(self.item);
    end
end

function ISResearchRecipe:isUsingTimeout()
    return false;
end

function ISResearchRecipe:update()
    self.item:setJobDelta(self:getJobDelta());
end

function ISResearchRecipe:start()
    if isClient() and self.item then
        self.item = self.character:getInventory():getItemById(self.item:getID())
    end
    self.item:setJobType(getText("ContextMenu_Research") ..' '.. self.item:getName());
    self.item:setJobDelta(0.0);
    self:setOverrideHandModels(nil, self.item);
    self:setActionAnim("Loot");
end

function ISResearchRecipe:stop()
    self.item:setJobDelta(0.0);
    ISBaseTimedAction.stop(self);
end

function ISResearchRecipe:perform()
    self.item:getContainer():setDrawDirty(true);
    self.item:setJobDelta(0.0);

    ISBaseTimedAction.perform(self);
end

function ISResearchRecipe:sendShowText()
    local researchList = self.scriptItem:getResearchableRecipes(self.character, true)
    local recipesNames = { }

    if researchList:size() > 0 then
        for i=0,researchList:size()-1 do
            local recipe = researchList:get(i)
            self.character:learnRecipe(recipe);
            if ScriptManager.instance:getCraftRecipe(recipe) then
                local craftRecipe = ScriptManager.instance:getCraftRecipe(recipe)
                table.insert(recipesNames, tostring(craftRecipe:getName()));
            end
        end
    end


    if #recipesNames > 0 then
        sendServerCommand("recipe", "SayText", { onlineID = self.character:getOnlineID(), type = 5, names = recipesNames })
    end
end

function ISResearchRecipe:complete()
    self.item:setJobDelta(0.0);
-- learn all of the learnable recipes in the item
    if self.scriptItem then
        if isServer() then
            self:sendShowText()
        end

        self.scriptItem:researchRecipes(self.character);
        --PF_Recipes
        sendSyncPlayerFields(self.character, 0x00000001);
    end
    return true;
end

function ISResearchRecipe:animEvent(event, parameter)

end

function ISResearchRecipe:getDuration()
    if self.character:isTimedActionInstant() then
        return 1;
    end

    local time = 5
    local otherTime = 5
    local timeMultiplier = 1
    if self.scriptItem and self.scriptItem:getResearchableRecipes(self.character) then
        local researchList = self.scriptItem:getResearchableRecipes(self.character)
        if researchList:size() > 0 then
            for i=0,researchList:size()-1 do
                local recipe = researchList:get(i)
                if ScriptManager.instance:getCraftRecipe(recipe) then
                    local craftRecipe = ScriptManager.instance:getCraftRecipe(recipe)
                    if craftRecipe:getTime() > otherTime then
                        otherTime = craftRecipe:getTime()
                    end
                    if craftRecipe:getHighestSkillRequirement() > timeMultiplier then
                        timeMultiplier = craftRecipe:getHighestSkillRequirement()
                    end
                end
            end
        end
    end

    time = time * timeMultiplier

    local f = 1 / getGameTime():getMinutesPerDay() / 2
    time = time / f

    if otherTime > time then
        time = otherTime
    end

    if(self.character:HasTrait("FastLearner")) then
        time = time * 0.7;
    end
    if(self.character:HasTrait("SlowLearner")) then
        time = time * 1.3;
    end

    time = time / 2

    --reading glasses are a little faster
    local eyeItem = self.character:getWornItems():getItem("Eyes");
    if(eyeItem and eyeItem:getType() == "Glasses_Reading") then
        time = time * 0.9;
    end
    -- using a loupe or magnifying glass also makes it a little faster
    local magnifier = (self.character:getPrimaryHandItem() and self.character:getPrimaryHandItem():hasTag("Magnifier")) or (self.character:getSecondaryHandItem() and self.character:getSecondaryHandItem():hasTag("Magnifier"));
    if magnifier then
        time = time * 0.9;
    end
    return time;
end

function ISResearchRecipe:new(character, item)
    if not item:getScriptItem() then return end
    local o = ISBaseTimedAction.new(self, character);
    o.character = character;
    o.item = item;
    o.scriptItem = item:getScriptItem();
    o.ignoreHandsWounds = true;
    o.maxTime = o:getDuration();
    o.caloriesModifier = 0.5;
    o.pageTimer = 0;
    o.forceProgressBar = true;

    return o;
end
