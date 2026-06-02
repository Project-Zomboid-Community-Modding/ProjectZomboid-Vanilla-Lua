xpUpdate = {};
xpUpdate.characterInfo = nil;
-- timer to see how much time since last strength xp gain, if it's too long we start losing xp

xpUpdate.lastX = 0;
xpUpdate.lastY = 0;

-- used everytime the player move
xpUpdate.onPlayerMove = function(player)
	local x = player:getX();-- these values are used to prevent AFKing to grind nimble
	local y = player:getY();
	-- pacing/sprinting xp
	-- if you're running and your endurance has changed
	if (player:IsRunning() or player:isSprinting()) and player:getStats():get(CharacterStat.ENDURANCE) > player:getStats():getEnduranceWarning() then
		-- you may gain 1 xp in sprinting or fitness
		if xpUpdate.randXp() then
		    addXp(player, Perks.Fitness, 1)
		end
		if xpUpdate.randXp() then
		    addXp(player, Perks.Sprinting, 1)
		end
	end
	--local manager = ISSearchManager.getManager(player); -- this is to nerf foraging and grinding nimble
	--local searching = false;
	if manager and manager.isSearchMode then searching = true end
	-- aiming while moving, gain nimble xp (move faster in aiming mode)
	if player:isAiming() and xpUpdate.randXp() and (xpUpdate.lastX ~= x or xpUpdate.lastY ~= y) and not player:getVehicle() then --the extra check is to prevent afking to grind nimble, the character must have moved to get the skill
		addXp(player, Perks.Nimble, 1)
	end
	-- if you're walking with a lot of stuff, you may gain in Strength
	if player:getInventoryWeight() > player:getMaxWeight() * 0.5 then
		if xpUpdate.randXp() then
		    addXp(player, Perks.Strength, 2)
		end
	end	
	xpUpdate.lastX = x;-- these values are used to prevent AFKing to grind nimble
	xpUpdate.lastY = y;
end

-- when you or a npc try to hit a tree
xpUpdate.OnWeaponHitTree = function(owner, weapon)
	if weapon and weapon:getType() ~= "BareHands" then
	    addXp(owner, Perks.Strength, 2)
	end
end

-- when you or a npc try to hit something
xpUpdate.onWeaponHitXp = function(owner, weapon, hitObject, damage, hitCount)
    if not weapon then
        return;
    end
    local isShove = false
    if hitObject:isOnFloor() == false and weapon:getType() == "BareHands" then
        isShove = true
    end
	local exp = 1 * damage * 0.9;
	if exp > 3 then
		exp = 3;
	end
	-- add info of favourite weapon
	local modData = owner:getModData();
    if isShove == false then
        if modData["Fav:"..weapon:getScriptItem():getDisplayName()] == nil then
            modData["Fav:"..weapon:getScriptItem():getDisplayName()] = 1;
        else
            modData["Fav:"..weapon:getScriptItem():getDisplayName()] = modData["Fav:"..weapon:getScriptItem():getDisplayName()] + 1;
        end
    end
	-- if you sucessful swing your non ranged weapon
	if owner:getStats():get(CharacterStat.ENDURANCE) > owner:getStats():getEnduranceWarning() and not weapon:isRanged() then
	    addXp(owner, Perks.Fitness, 1)
	end
	-- we add xp depending on how many target you hit
	if not weapon:isRanged() and owner:getLastHitCount() > 0 then
	    addXp(owner, Perks.Strength, owner:getLastHitCount())
	end
	-- add xp for ranged weapon
	if weapon:isRanged() then
		local xp = hitCount;
		if owner:getPerkLevel(Perks.Aiming) < 5 then
			xp = xp * 2.7;
		end
		addXp(owner, Perks.Aiming, xp)
	end
	-- add either blunt or blade xp (blade xp's perk name is Axe)
	if hitCount > 0 and not weapon:isRanged() then
		if weapon:getScriptItem():containsWeaponCategory(WeaponCategory.AXE) then
		    addXp(owner, Perks.Axe, exp)
		end
		if weapon:getScriptItem():containsWeaponCategory(WeaponCategory.BLUNT) then
		    addXp(owner, Perks.Blunt, exp)
		end
		if weapon:getScriptItem():containsWeaponCategory(WeaponCategory.SPEAR) then
		    addXp(owner, Perks.Spear, exp)
		end
		if weapon:getScriptItem():containsWeaponCategory(WeaponCategory.LONG_BLADE) then
		    addXp(owner, Perks.LongBlade, exp)
		end
		if weapon:getScriptItem():containsWeaponCategory(WeaponCategory.SMALL_BLADE) then
		    addXp(owner, Perks.SmallBlade, exp)
		end
		if weapon:getScriptItem():containsWeaponCategory(WeaponCategory.SMALL_BLUNT) then
		    addXp(owner, Perks.SmallBlunt, exp)
		end
	end
end

-- get xp when you craft something
xpUpdate.onMakeItem = function(item, resultItem, recipe)
	if instanceof(resultItem, "Food") then
		addXp(getPlayer(), Perks.Cooking, 3)
	end
--~ 	if resultItem:getType():contains("Plank") then
--~ 		getPlayer():getXp():AddXP(Perks.Woodwork, 3);
--~ 	end
--~ 	if item:getType():contains("Plank") then
--~ 		getPlayer():getXp():AddXP(Perks.Woodwork, 3);
--~ 	end

end

-- if we press the toggle skill panel key we gonna display the character info screen
xpUpdate.displayCharacterInfo = function(key)
	local playerObj = getSpecificPlayer(0)
	if getGameSpeed() == 0 or not playerObj or playerObj:isDead() then
		return;
	end
	if not getPlayerData(0) then return end
	if getCore():isKey("Crafting UI", key) then
		local windowInstance = ISEntityUI.GetWindowInstance(0, "HandcraftWindow");
		if windowInstance then
			windowInstance:close();
			windowInstance:removeFromUIManager();
		else
			ISEntityUI.OpenHandcraftWindow(getSpecificPlayer(0), nil);
		end
	end
    if getCore():isKey("Building UI", key) then
        local windowInstance = ISEntityUI.GetWindowInstance(0, "BuildWindow");
        if windowInstance then
            windowInstance:close();
            windowInstance:removeFromUIManager();
        else
            ISEntityUI.OpenBuildWindow(getSpecificPlayer(0));
        end
    end
	if getCore():isKey("Toggle Skill Panel", key) then
		xpUpdate.characterInfo = getPlayerInfoPanel(playerObj:getPlayerNum());
		xpUpdate.characterInfo:toggleView(xpSystemText.skills);
	end
	if getCore():isKey("Toggle Health Panel", key) then
		xpUpdate.characterInfo = getPlayerInfoPanel(playerObj:getPlayerNum());
		xpUpdate.characterInfo:toggleView(xpSystemText.health);
        xpUpdate.characterInfo.healthView.doctorLevel = playerObj:getPerkLevel(Perks.Doctor);
	end
	if getCore():isKey("Toggle Info Panel", key) then
		xpUpdate.characterInfo = getPlayerInfoPanel(playerObj:getPlayerNum());
		xpUpdate.characterInfo:toggleView(xpSystemText.info);
	end
	if getCore():isKey("Toggle Clothing Protection Panel", key) then
		xpUpdate.characterInfo = getPlayerInfoPanel(playerObj:getPlayerNum());
		xpUpdate.characterInfo:toggleView(xpSystemText.protection);
	end
end

-- do we get xp ?
xpUpdate.randXp = function()
	if isServer() then
		return ZombRand(100 * GameTime.getInstance():getInvMultiplier()) == 0;
	else
		return ZombRand(700 * GameTime.getInstance():getInvMultiplier()) == 0;
	end
end

-- handle when you gain xp, we gonna apply the xp multiplier
xpUpdate.addXp = function(owner, type, amount)
	-- reset our strength/fitness timer

	local modData = xpUpdate.getModData(owner)

	if type == Perks.Strength and amount > 0 then
		modData.strengthUpTimer = modData.strengthUpTimer - 3000; -- allow us to not lose strength xp for a time if we still train
		if modData.strengthUpTimer < -50000 then
			modData.strengthUpTimer = -50000;
		end
	end

	if type == Perks.Fitness and amount > 0 then
		modData.fitnessUpTimer = modData.fitnessUpTimer - 3000; -- allow us to not lose fitness xp for a time if we still train
		if modData.fitnessUpTimer < -50000 then
			modData.fitnessUpTimer = -50000;
		end
	end

	if type == Perks.PlantScavenging and amount > 0 then
        local amount2 = round(amount, 2)
		HaloTextHelper.addTextWithArrow(owner, type:getName().." "..getText("Challenge_Challenge2_CurrentXp", amount2), "[br/]", true, HaloTextHelper.getGoodColor());
    end
end

-- when you gain a level you could win or lose perks
xpUpdate.levelPerk = function(owner, perk, level, addBuffer)
    -- check AutoLearn craftRecipes
    getScriptManager():checkAutoLearn(owner)

	-- first Strength skill, grant you some traits that gonna help you to carry more stuff, hitting harder, etc.
	if perk == Perks.Strength then
		-- we start to remove all previous Strength related traits
		owner:getCharacterTraits():remove(CharacterTrait.WEAK);
		owner:getCharacterTraits():remove(CharacterTrait.FEEBLE);
		owner:getCharacterTraits():remove(CharacterTrait.STOUT);
		owner:getCharacterTraits():remove(CharacterTrait.STRONG);

        -- now we add trait depending on your current lvl
        if level >= 0 and level <= 1 then
            owner:getCharacterTraits():add(CharacterTrait.WEAK);
        elseif level >= 2 and level <= 4 then
            owner:getCharacterTraits():add(CharacterTrait.FEEBLE);
        elseif level >= 6 and level <= 8 then
            owner:getCharacterTraits():add(CharacterTrait.STOUT);
        elseif level >= 9 then
            owner:getCharacterTraits():add(CharacterTrait.STRONG);
        end
	end

	-- then Fitness skill, grant you some traits that gonna help you to run faster, recovery faster, etc..
	if perk == Perks.Fitness then
		-- we start to remove all previous Fitness related traits
        owner:getCharacterTraits():remove(CharacterTrait.UNFIT);
        owner:getCharacterTraits():remove(CharacterTrait.OUT_OF_SHAPE);
		owner:getCharacterTraits():remove(CharacterTrait.FIT);
		owner:getCharacterTraits():remove(CharacterTrait.ATHLETIC);

		-- now we add trait depending on your current lvl
		if level >= 0 and level <= 1 then
			owner:getCharacterTraits():add(CharacterTrait.UNFIT);
		elseif level >= 2 and level <= 4 then
			owner:getCharacterTraits():add(CharacterTrait.OUT_OF_SHAPE);
		elseif level >= 6 and level <= 8 then
			owner:getCharacterTraits():add(CharacterTrait.FIT);
		elseif level >= 9 then
			owner:getCharacterTraits():add(CharacterTrait.ATHLETIC);
		end
	end

	local modifier = 0
	if owner:isInventive() then modifier = 1 end
    -- learn all the growing seasons at Farming 10
	if perk == Perks.Farming and level + modifier > 9 then
        for typeOfSeed,props in pairs(farming_vegetableconf.props) do
            if props.seasonRecipe then
                xpUpdate.checkForLearningRecipe(owner, props.seasonRecipe)
            end
        end
    end
    -- learn Mechanics recipes at high levels of Mechanics
	if perk == Perks.Mechanics then
	    if level + modifier > 9 then
            xpUpdate.checkForLearningRecipe(owner, "Advanced Mechanics")
        end
	    if level + modifier > 8 then
            xpUpdate.checkForLearningRecipe(owner, "Intermediate Mechanics")
        end
	    if level + modifier > 7 then
            xpUpdate.checkForLearningRecipe(owner, "Basic Mechanics")
        end
    end
    -- learn Generator at Electrical 3
    if perk == Perks.Electricity and level + modifier > 2 then
        xpUpdate.checkForLearningRecipe(owner, "Generator")
    end

	-- we reset the xp multiplier for this perk
--	owner:getXp():getMultiplierMap():remove(perk);

	-- we add a "buffer" xp, so if you just get your lvl but you're still losing xp (if you've been lazy for a moment), you won't lose your lvl at the next tick
	if addBuffer then
--		owner:getXp():AddXP(perk, 5, false);
	end
end

xpUpdate.checkForLearningRecipe = function(playerObj, recipe)
    if playerObj:isRecipeActuallyKnown(recipe) then return end

    playerObj:learnRecipe(recipe)
    HaloTextHelper.addGoodText(playerObj, Translator.getText("IGUI_HaloNote_LearnedRecipe", getRecipeDisplayName(recipe)), "[br/]")
end

xpUpdate.checkForLosingLevel = function(playerObj, perk)
	local info = playerObj:getPerkInfo(perk);
	if info then
		local level = info:getLevel()
		if level >= 1 and level <= 10 and playerObj:getXp():getXP(perk) < PerkFactory.getPerk(perk):getTotalXpForLevel(level) then
			playerObj:LoseLevel(perk);
        end
	end
end

xpUpdate.everyTenMinutes = function()
	local players = getOnlinePlayers()
	local playersNumber = isServer() and players:size()-1 or getNumActivePlayers()-1
	for playerIndex=0,playersNumber do
		local playerObj = isServer() and players:get(playerIndex) or getSpecificPlayer(playerIndex)
		if playerObj and not playerObj:isDead() then
			local modData = xpUpdate.getModData(playerObj)
			-- strength stuff
			modData.strengthUpTimer = modData.strengthUpTimer + getLoosingXpTick(modData.strengthUpTimer);
			-- if we've been lazy for too long, we start losing xp, every 1200 tick we lose 1 xp
			if modData.strengthUpTimer > 20000 and modData.strengthMod ~= math.floor(modData.strengthUpTimer / 1200) then
				modData.strengthMod = math.floor(modData.strengthUpTimer / 1200);
				if playerObj:getXp():getXP(Perks.Strength) > 0 then
					addXp(playerObj, Perks.Strength, getLoosingXpValue())
				end
				xpUpdate.checkForLosingLevel(playerObj, Perks.Strength);
			end
			if modData.strengthUpTimer > 31000 then -- it's caped to a 30000 timer, so if you've been lazy for a lot of days, it's not so long to get in shape again
				modData.strengthUpTimer = 0;
			end
			-- fitness stuff
			modData.fitnessUpTimer = modData.fitnessUpTimer + getLoosingXpTick(modData.fitnessUpTimer);
			-- if we've been lazy for too long, we start losing xp, every 1200 tick we lose 1 xp
			if modData.fitnessUpTimer > 20000 and modData.fitnessMod ~= math.floor(modData.fitnessUpTimer / 1200) then
				modData.fitnessMod = math.floor(modData.fitnessUpTimer / 1200);
				if playerObj:getXp():getXP(Perks.Fitness) > 0 then
					addXp(playerObj, Perks.Fitness, getLoosingXpValue())
				end
				xpUpdate.checkForLosingLevel(playerObj, Perks.Fitness);
			end
			if modData.fitnessUpTimer > 31000 then -- it's caped to a 30000 timer, so if you've been lazy for a lot of days, it's not so long to get in shape again
				modData.fitnessUpTimer = 0;
			end
		end
	end
end

-- load our losing xp timer
xpUpdate.getModData = function(playerObj)
    if playerObj then
		local modData = playerObj:getModData()
		modData.strengthUpTimer = tonumber(modData.strengthUpTimer) or -50000
		modData.strengthMod = modData.strengthMod or 0
		modData.fitnessUpTimer = tonumber(modData.fitnessUpTimer) or -50000
		modData.fitnessMod = modData.fitnessMod or 0
		return modData
	end
	return nil
end

xpUpdate.onNewGame = function(playerObj, square)
	playerObj:getFitness():init();
end

xpUpdate.onLoad = function()
	local playerObj = getSpecificPlayer(0)
	local modifier = 0
	if playerObj:isInventive() then modifier = 1 end
    -- learn all the growing seasons at Farming 10
	if playerObj:getPerkLevel(Perks.Farming) + modifier > 9 then
        for typeOfSeed,props in pairs(farming_vegetableconf.props) do
            if props.seasonRecipe then
                playerObj:learnRecipe(props.seasonRecipe)
            end
        end
    end
    -- learn Mechanics recipes at high levels of Mechanics
    if playerObj:getPerkLevel(Perks.Mechanics) + modifier > 9 then
       playerObj:learnRecipe("Advanced Mechanics")
    end
    if playerObj:getPerkLevel(Perks.Mechanics) + modifier > 8 then
        playerObj:learnRecipe("Intermediate Mechanics")
    end
    if playerObj:getPerkLevel(Perks.Mechanics) + modifier > 7 then
       playerObj:learnRecipe("Basic Mechanics")
    end
    -- learn Generator at Electrical 3
    if playerObj:getPerkLevel(Perks.Electricity) + modifier > 2 then
        playerObj:learnRecipe("Generator")
    end
end

Events.EveryTenMinutes.Add(xpUpdate.everyTenMinutes);

Events.OnPlayerMove.Add(xpUpdate.onPlayerMove);

Events.OnWeaponHitXp.Add(xpUpdate.onWeaponHitXp);

Events.OnWeaponHitTree.Add(xpUpdate.OnWeaponHitTree);

--Events.OnMakeItem.Add(xpUpdate.onMakeItem);

Events.OnKeyPressed.Add(xpUpdate.displayCharacterInfo);

Events.AddXP.Add(xpUpdate.addXp);

Events.LevelPerk.Add(xpUpdate.levelPerk);

Events.OnNewGame.Add(xpUpdate.onNewGame);

Events.OnLoad.Add(xpUpdate.onLoad);
