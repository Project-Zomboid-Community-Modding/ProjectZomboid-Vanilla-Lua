--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 20/01/2022
-- Time: 09:27
-- To change this template use File | Settings | File Templates.
--

require "BuildingObjects/ISAnimalPickMateCursor"

AnimalContextMenu = {};
AnimalContextMenu.cheat = getDebug();
--AnimalContextMenu.cheat = false;

local function predicateNotBroken(item)
    return not item:isBroken()
end

-----

-----

AnimalContextMenu.doInventoryMenu = function(player, context, animalInv, test)
    local animal = animalInv:getAnimal();
    local playerObj = getSpecificPlayer(player);
    context:addOption(getText("ContextMenu_AnimalInfo"), animal, AnimalContextMenu.onAnimalInfo, playerObj);

    context:addOption(getText("ContextMenu_Drop"), { animalInv }, ISInventoryPaneContextMenu.onDropItems, player);

    AnimalContextMenu.doFeedFromHandMenu(playerObj, animal, context);
    AnimalContextMenu.doWaterAnimalMenu(context, animal, playerObj)

    if AnimalContextMenu.cheat then
        context:addDebugOption(getText("ContextMenu_SetAnimalHungry"), animal, AnimalContextMenu.onSetHungry, playerObj);
    end
end

AnimalContextMenu.doFeedFromHandMenu = function(playerObj, animal, context)
    if animal:getStats():getHunger() <= 0 then
        return;
    end
    local foods = playerObj:getInventory():getAllEvalRecurse(function(item)
        if item:getFluidContainer() and item:getFluidContainer():isPureFluid(Fluid.Get(animal:getBreed():getMilkType())) then
            return true
        end
        if item:isAnimalFeed() or (instanceof(item, "Food") and (item:getFoodType() == "Fruits" or item:getFoodType() == "Vegetables" or item:getMilkType()) and item:getHungerChange() < 0 and not item:isRotten() and not item:isSpice()) then
            return true
        end

        return false
    end)

    local foodList = animal:getEatTypePossibleFromHand();
    local alreadyAdded = {};

    local feedOption = context:addOption("Feed");
    local subMenuFeed = ISContextMenu:getNew(context);
    context:addSubMenu(feedOption, subMenuFeed);

    local added = false;

    for i=0, foods:size() - 1 do
        local foodInv = foods:get(i);
        local testType = foodInv:getFullType();
        local testType2 = nil;
        if foodInv:getFluidContainer() and foodInv:getFluidContainer():isPureFluid(Fluid.Get(animal:getBreed():getMilkType())) then
            testType = animal:getBreed():getMilkType();
        end
        if instanceof(foodInv, "Food") then
            testType2 = foodInv:getFoodType();
        end
        if foodInv:isAnimalFeed() then
            testType = foodInv:getAnimalFeedType();
        end
        if foodList:contains(testType) or foodList:contains(testType2) then
            local text = foodInv:getDisplayName();
            if foodInv:getFluidContainer() then
                text = foodInv:getFluidContainer():getUiName();
            end
            if not alreadyAdded[text] then
                subMenuFeed:addOption(text, playerObj, AnimalContextMenu.onFeedAnimalFood, animal, foodInv)
                alreadyAdded[text] = true;
                added = true;
            end
        end
    end

    if not added then
        context:removeLastOption()
    end
end

AnimalContextMenu.onFeedAnimalFood = function(player, animal, food)
    if animal:isExistInTheWorld() then -- animal in world
        animal:getBehavior():setBlockMovement(true);
        if luautils.walkAdj(player, animal:getSquare()) then
            local vec = animal:getAttachmentWorldPos("head");
            ISTimedActionQueue.add(ISWalkToTimedActionF:new(player, vec));
            ISWorldObjectContextMenu.equip(player, player:getPrimaryHandItem(), food, true, false)
            ISTimedActionQueue.add(ISFeedAnimalFromHand:new(player, animal, food))
        end
    elseif animal:getVehicle() then -- animal in car
        local vec = animal:getVehicle():getAreaCenter("AnimalEntry");
        local sq = getSquare(vec:getX(), vec:getY(), animal:getVehicle():getZ());
        if luautils.walkAdj(player, sq) then
            ISWorldObjectContextMenu.equip(player, player:getPrimaryHandItem(), food, true, false)
            ISTimedActionQueue.add(ISFeedAnimalFromHand:new(player, animal, food))
        end
        return;
    else -- animal in your hands (InventoryAnimalItem)
        ISTimedActionQueue.add(ISFeedAnimalFromHand:new(player, animal, food))
    end
end

AnimalContextMenu.doMenu = function(player, context, animal, test)
    if animal:isOnHook() then return; end
    local playerObj = getSpecificPlayer(player);
    local playerInv = playerObj:getInventory();


    -- init the core debug stuff, as i'm using it in java too, but easier to maintain it only in lua so i can quickly reload this file and test stuff
    getCore():setAnimalCheat(AnimalContextMenu.cheat);

    local text = animal:getFullName()
    local animalOption = context:addOption(text, nil, nil);
    local animalSubMenu = ISContextMenu:getNew(context);
    context:addSubMenu(animalOption, animalSubMenu);

    local option = animalSubMenu:addOption(getText("ContextMenu_AnimalInfo"), animal, AnimalContextMenu.onAnimalInfo, playerObj);
    if not AnimalContextMenu.cheat and animal:getCurrentSquare():DistToProper(playerObj) > ISAnimalUI.maxDist then
        option.notAvailable = true;
        local tooltip = ISWorldObjectContextMenu.addToolTip();
        tooltip:setName(getText("Tooltip_Animal_TooFarAway"));
        option.toolTip = tooltip;
    end

    if not AnimalContextMenu.cheat and animal:isWild() then
        option.notAvailable = true;
        local tooltip = ISWorldObjectContextMenu.addToolTip();
        tooltip:setName(getText("Tooltip_Animal_AnimalIsWild"));
        option.toolTip = tooltip;
    end

    if (animal:getBehavior():canBeAttached() or AnimalContextMenu.cheat) and not animal:getData():getAttachedPlayer() then
        local nbOfRopes = playerObj:getInventory():getNumberOfItem("Base.Rope");
        local option = animalSubMenu:addOption(getText("ContextMenu_AttachAnimal"), animal, AnimalContextMenu.onAttachAnimal, playerObj);
        if(nbOfRopes <= playerObj:getAttachedAnimals():size() and not AnimalContextMenu.cheat) then
            option.notAvailable = true;
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName(getText("Tooltip_Animal_NeedMoreRope"));
            option.toolTip = tooltip;
        end
        if not animal:getBehavior():canBeAttached() then
            option.iconTexture = getTexture("media/ui/BugIcon.png");
        end
    end

    if (animal:getBehavior():canBeAttached() or AnimalContextMenu.cheat) and animal:getData():getAttachedPlayer() then
        animalSubMenu:addOption(getText("ContextMenu_DetachAnimal"), animal, AnimalContextMenu.onDetachAnimal, playerObj);
    end

    if animal:getData():getAttachedTree() then
        local text = getText("ContextMenu_DetachAnimalFromObject", animal:getData():getAttachedTree():getName())
        if instanceof(animal:getData():getAttachedTree(), "IsoTree") then
            text = getText("ContextMenu_DetachAnimalFromTree");
        end
        animalSubMenu:addOption(text, animal, AnimalContextMenu.onDetachAnimalTree, playerObj);
    end

    if animal:getData():getMilkQuantity() > 0.1 and animal:canBeMilked() then
        --local bucketList = playerInv:getAllTagEval("Bucket", predicateNotBroken)
        local bucketList = playerInv:getAvailableFluidContainer(animal:getData():getBreed():getMilkType())
        local choosenBuckets = {};
        local existingBucket = {};
        if bucketList then
            for i=0, bucketList:size()-1 do
                local bucket = bucketList:get(i);
                if not existingBucket[bucket:getType() .. bucket:getFluidContainer():getAmount()] then
                    existingBucket[bucket:getType() .. bucket:getFluidContainer():getAmount()] = true;
                    table.insert(choosenBuckets, bucket);
                end
                --if not existingBucket[bucket:getType()] and bucket:getMilkReplaceItem() then
                --    table.insert(choosenBuckets, bucket)
                --    existingBucket[bucket:getType()] = true;
                --end
                --if instanceof(bucket, "Food") and bucket:getMaxMilk() > 0 and bucket:getMilkQty() < bucket:getMaxMilk() and bucket:getMilkType() and animal:getData():getBreed():getMilkType() == bucket:getMilkType() and not existingBucket[bucket:getType() .. bucket:getMilkQty()] then
                --    existingBucket[bucket:getType() .. bucket:getMilkQty()] = true;
                --    table.insert(choosenBuckets, bucket)
                --end
            end
        end
        if #choosenBuckets > 0 then
            local milkOption = animalSubMenu:addOption(getText("ContextMenu_Milk"), nil, nil);
            local milkSubMenu = ISContextMenu:getNew(animalSubMenu);
            animalSubMenu:addSubMenu(milkOption, milkSubMenu);

            for i,bucket in ipairs(choosenBuckets) do
                text = bucket:getDisplayName();
                if bucket:getFluidContainer():getPrimaryFluid() then
                    text = bucket:getFluidContainer():getUiName();
                end
                if not bucket:getFluidContainer():isEmpty() then
                    text = text .. " (" .. round(bucket:getFluidContainer():getAmount(), 2) .. "/" .. bucket:getFluidContainer():getCapacity() .. "L)";
                end
                milkSubMenu:addOption(text, animal, AnimalContextMenu.onMilkAnimal, playerObj, bucket, false);
            end

            if #choosenBuckets > 1 then
                milkSubMenu:addOption(getText("ContextMenu_Eat_All"), animal, AnimalContextMenu.onMilkAnimal, playerObj, nil, true);
            end
        end
    end

    if animal:canBeSheared() and animal:getData():getWoolQuantity() > 1 then
        local shears = playerInv:getAllTagRecurse("Shear", ArrayList.new());
        if shears:isEmpty() then
            return;
        end

        local shearOption = animalSubMenu:addOption(getText("ContextMenu_Shear"), nil, nil);
        local shearSubMenu = ISContextMenu:getNew(animalSubMenu);
        animalSubMenu:addSubMenu(shearOption, shearSubMenu);

        for i=0,shears:size()-1 do
            local shear = shears:get(i);
            local shearOptionSub = shearSubMenu:addOption(shear:getDisplayName(), animal, AnimalContextMenu.onShearAnimal, playerObj, shear);
            if instanceof(shear, "DrainableComboItem") and shear:getCurrentUsesFloat() <= 0 then
                shearOptionSub.notAvailable = true;
                local tooltip = ISWorldObjectContextMenu.addToolTip();
                tooltip:setName(getText("Tooltip_Animal_ShearNoBattery"));
                shearOptionSub.toolTip = tooltip;
            end
        end

        --local shear = playerInv:getItemFromType("SheepElectricShears", true, true) or playerInv:getItemFromType("SheepShears", true, true);

        --local shear = playerInv:getFirstTagRecurse("Shear");
        --local shearOption = animalSubMenu:addOption(getText("ContextMenu_Shear"), animal, AnimalContextMenu.onShearAnimal, playerObj, shear);
        --local shearOk = true;
        --if not shear then
        --    shearOption.notAvailable = true;
        --    local tooltip = ISWorldObjectContextMenu.addToolTip();
        --    tooltip:setName(getText("Tooltip_Animal_NoShear"));
        --    shearOption.toolTip = tooltip;
        --elseif instanceof(shear, "DrainableComboItem") and shear:getCurrentUsesFloat() <= 0 then
        --    shearOption.notAvailable = true;
        --    local tooltip = ISWorldObjectContextMenu.addToolTip();
        --    tooltip:setName(getText("Tooltip_Animal_ShearNoBattery"));
        --    shearOption.toolTip = tooltip;
        --end
    end

    if animal:canBePicked(playerObj) then
        local pickOption = animalSubMenu:addOption(getText("ContextMenu_PickUpAnimal", animal:getFullName()), animal, AnimalContextMenu.onPickupAnimal, playerObj);
        --if not animal:canBePicked(playerObj) then
        --    if AnimalContextMenu.cheat or playerObj:isUnlimitedCarry() or playerObj:isGhostMode() then
        --        animalSubMenu:removeLastOption();
        --        animalSubMenu:addDebugOption(getText("ContextMenu_PickUpAnimal", animal:getFullName()), animal, AnimalContextMenu.onPickupAnimal, playerObj);
        --    else
        --        pickOption.notAvailable = true;
        --        local tooltip = ISWorldObjectContextMenu.addToolTip();
        --        tooltip:setName(getText("Tooltip_Animal_TooHeavy"));
        --        pickOption.toolTip = tooltip;
        --    end
        --end
    end

    local possibleLure = animal:getPossibleLuringItems(playerObj);
    if possibleLure and not possibleLure:isEmpty() then
        local lureOption = animalSubMenu:addOption(getText("ContextMenu_Lure"), nil, nil);
        local lureSubMenu = ISContextMenu:getNew(animalSubMenu);
        animalSubMenu:addSubMenu(lureOption, lureSubMenu);
        local alreadyAdded = {};

        for i=0, possibleLure:size()-1 do
            local item = possibleLure:get(i);
            if not alreadyAdded[getItemDisplayName(item:getType())] then
                local option = lureSubMenu:addOption(getItemDisplayName(item:getType()), animal, AnimalContextMenu.onLure, playerObj, item);
            end
            alreadyAdded[getItemDisplayName(item:getType())] = true;
            --if not playerInv:contains(item) then
            --    option.notAvailable = true;
            --end
        end
    end

    if animal:canBePet() then
        local option = animalSubMenu:addOption(getText("ContextMenu_PetAnimal"), animal, AnimalContextMenu.onPetAnimal, playerObj);
        if not animal:petTimerDone() and AnimalContextMenu.cheat then
            --option.notAvailable = true;
            local txt = "";
            if AnimalContextMenu.cheat then
                txt = " (" .. animal:getPetTimer() .. ")";
            end
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName(txt);
            option.toolTip = tooltip;
        end
    end

    if animal:getStats():getThirst() >= 0.1 then
        AnimalContextMenu.doWaterAnimalMenu(animalSubMenu, animal, playerObj);
    end
    if animal:getStats():getHunger() >= 0.1 then
        AnimalContextMenu.doFeedFromHandMenu(playerObj, animal, animalSubMenu);
    end

    if not animal:isWild() then
        local weapon = playerInv:getAllTagEval("KillAnimal", predicateNotBroken);
        if weapon and not weapon:isEmpty() then
            animalSubMenu:addOption(getText("ContextMenu_KillAnimal"), animal, AnimalContextMenu.onKillAnimal, playerObj);
        else
            local option = animalSubMenu:addOption(getText("ContextMenu_KillAnimal"), animal, AnimalContextMenu.onKillAnimal, playerObj);
            option.notAvailable = true;
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName(getText("Tooltip_Animal_NoWeapon"));
            option.toolTip = tooltip;
        end
    end

    if AnimalContextMenu.cheat then
        local debugOption = animalSubMenu:addDebugOption("Debug", nil, nil)
        local debugSubMenu = ISContextMenu:getNew(animalSubMenu);
        context:addSubMenu(debugOption, debugSubMenu);

        debugSubMenu:addDebugOption(getText("ContextMenu_RemoveAnimal"), animal, AnimalContextMenu.onRemoveAnimal, playerObj);
        debugSubMenu:addDebugOption(getText("ContextMenu_AnimalBehaviorDebug"), animal, AnimalContextMenu.onAnimalBehavior, playerObj);
        debugSubMenu:addDebugOption(getText("ContextMenu_SetAnimalAge"), animal, AnimalContextMenu.onSetAnimalAge, player);
        if animal:getMilkType() then
            debugSubMenu:addDebugOption(getText("ContextMenu_AddBucketMilk"), animal, AnimalContextMenu.onAddBucketMilk, playerObj);
        end
        if animal:getBabyType() then
            if animal:getEggsPerDay() > 0 then
                debugSubMenu:addDebugOption(getText("ContextMenu_AddEgg"), animal, AnimalContextMenu.onAddEgg, playerObj);
                if animal:getData():isFertilized() then
                    debugSubMenu:addDebugOption(getText("ContextMenu_RemoveFertilized"), animal, AnimalContextMenu.SetFertilized, playerObj, false);
                    debugSubMenu:addDebugOption(getText("ContextMenu_SetFertilizedTime"), animal, AnimalContextMenu.SetFertilizedTime, player);
                else
                    debugSubMenu:addDebugOption(getText("ContextMenu_SetFertilized"), animal, AnimalContextMenu.SetFertilized, playerObj, true);
                    debugSubMenu:addDebugOption("Pick male to mate with", animal, AnimalContextMenu.PickMate, playerObj)
                end
            else
                if animal:getData():isFertilized() then
                    debugSubMenu:addDebugOption(getText("ContextMenu_RemoveFertilized"), animal, AnimalContextMenu.SetFertilized, playerObj, false);
                else
                    debugSubMenu:addDebugOption("Pick male to mate with", animal, AnimalContextMenu.PickMate, playerObj)
                end
                if animal:getData():isPregnant() then
                    debugSubMenu:addDebugOption(getText("ContextMenu_StopPregnancy"), animal, AnimalContextMenu.Impregnate, playerObj, false);
                    debugSubMenu:addDebugOption(getText("ContextMenu_SetPregnancyPeriod"), animal, AnimalContextMenu.SetPregnancyPeriod, player);
                else
                    debugSubMenu:addDebugOption(getText("ContextMenu_Impregnate"), animal, AnimalContextMenu.Impregnate, playerObj, true);
                end
                debugSubMenu:addDebugOption(getText("ContextMenu_AddAnimalBaby"), animal, AnimalContextMenu.onAddAnimalBaby, playerObj);
            end
        end
        if animal:getData():canHaveMilk() then
            debugSubMenu:addDebugOption(getText("ContextMenu_SetMilkQty"), animal, AnimalContextMenu.onSetMilkQty, player);
        end
        if animal:canBeSheared() then
            debugSubMenu:addDebugOption(getText("ContextMenu_SetWoolQty"), animal, AnimalContextMenu.onSetWoolQty, player);
        end

        debugSubMenu:addDebugOption(getText("ContextMenu_SetAnimalHungry"), animal, AnimalContextMenu.onSetHungry, playerObj);

        debugSubMenu:addDebugOption(getText("ContextMenu_ModifyGenome"), animal, AnimalContextMenu.onAnimalGenome, playerObj);

        debugSubMenu:addDebugOption("Simulate 24 hours meta grow", animal, AnimalContextMenu.onForceAnimalGrowAway, playerObj);

        debugSubMenu:addDebugOption("Set Stress", animal, AnimalContextMenu.onDebugSetStress, player);

        debugSubMenu:addDebugOption("Full Acceptance", animal, AnimalContextMenu.onDebugSetAcceptance, playerObj, 100);

        debugSubMenu:addDebugOption("Kill", animal, AnimalContextMenu.onKill, playerObj);

        if not animal:isAnimalSitting() then
            debugSubMenu:addDebugOption("Force sit", animal, AnimalContextMenu.onForceSit);
        else
            debugSubMenu:addDebugOption("Force stand up", animal, AnimalContextMenu.onForceSit);
        end

        debugSubMenu:addDebugOption("Random Idle Anim", animal, AnimalContextMenu.onRandomIdleAnim);
        if animal:haveHappyAnim() then
            debugSubMenu:addDebugOption("Random Happy Anim", animal, AnimalContextMenu.onRandomHappyAnim);
        end

        local text = "Make Invincible";
        if animal:isInvincible() then
            text = "Remove Invicibility";
        end
        debugSubMenu:addDebugOption(text, animal, AnimalContextMenu.onToggleInvincible, playerObj, 100);
        if animal:canHaveEggs() then
            debugSubMenu:addDebugOption("Force egg now", animal, AnimalContextMenu.onDebugForceEgg, playerObj);
        end
        if animal:needHutch() then
            debugSubMenu:addDebugOption("Force enter hutch for 2h", animal, AnimalContextMenu.onDebugForceHutch, playerObj);
        end
        if animal:canPoop() then
            debugSubMenu:addDebugOption("Force poop", animal, AnimalContextMenu.onDebugForcePoop, playerObj);
        end
        debugSubMenu:addDebugOption("Force wander now", animal, AnimalContextMenu.onForceWanderNow, playerObj);
        debugSubMenu:addDebugOption("Force eat from mom", animal, AnimalContextMenu.onForceEatMom, playerObj);

        debugSubMenu:addDebugOption("Set on fire", animal, AnimalContextMenu.onSetFire, playerObj);

        debugSubMenu:addDebugOption("Generate world sound", animal, AnimalContextMenu.onGenerateWorldSound, playerObj);

        --debugSubMenu:addDebugOption("SANTA!", animal, AnimalContextMenu.onSanta, playerObj);
        --debugSubMenu:addDebugOption("Bowtie Gold", animal, AnimalContextMenu.onBowtieGold, playerObj);
        --debugSubMenu:addDebugOption("Bowtie Green", animal, AnimalContextMenu.onBowtieGreen, playerObj);
        --debugSubMenu:addDebugOption("Bowtie Red", animal, AnimalContextMenu.onBowtieRed, playerObj);
    end
end

AnimalContextMenu.onGenerateWorldSound = function(animal, playerObj)
    animal:playSoundDebug();
end

AnimalContextMenu.onSetFire = function(animal, playerObj)
    animal:setOnFire(true);
end

AnimalContextMenu.onForceEatMom = function(animal, playerObj)
    animal:getBehavior():forceEatFromMom();
end

AnimalContextMenu.onForceWanderNow = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "forceWander",
                "id", animal:getOnlineID())
    else
        animal:forceWanderNow();
    end
end

AnimalContextMenu.onDebugForcePoop = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "dung",
                "id", animal:getOnlineID())
    else
        animal:getData():checkPoop(false);
    end
end

AnimalContextMenu.onDebugForceHutch = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "forceHutch",
                "id", animal:getOnlineID())
    else
        animal:getBehavior():callToHutch(nil, true);
    end
end

AnimalContextMenu.onAddBucketMilk = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "addBucketMilk",
                "id", animal:getOnlineID())
    else
        playerObj:getInventory():AddItem(animal:addDebugBucketOfMilk(playerObj));
    end
end

AnimalContextMenu.doWaterAnimalMenu = function(animalSubMenu, animal, playerObj)
    local waterItems = playerObj:getInventory():getAllWaterFluidSources(true);

    local waterOption = animalSubMenu:addOption(getText("ContextMenu_WaterAnimal"), nil, nil);

    local alreadyAdded = {};
    if waterItems:isEmpty() then
        waterOption.notAvailable = true;
        local tooltip = ISWorldObjectContextMenu.addToolTip();
        tooltip:setName(getText("ContextMenu_NoWaterItemFound"));
        waterOption.toolTip = tooltip;
        return;
    end

    local subMenuWater = ISContextMenu:getNew(animalSubMenu);
    animalSubMenu:addSubMenu(waterOption, subMenuWater);

    for i=0, waterItems:size() - 1 do
        local item = waterItems:get(i);
        local text = item:getName() .. " (" .. round(item:getFluidContainer():getAmount() * 1000, 2) .. " mL)";
        if not alreadyAdded[text] then
            subMenuWater:addOption(text, playerObj, AnimalContextMenu.onGiveWater, animal, item)
            alreadyAdded[text] = true;
        end
    end
end

AnimalContextMenu.onGiveWater = function(player, animal,item)
    if animal:isExistInTheWorld() then -- animal in world
        animal:getBehavior():setBlockMovement(true);
        if luautils.walkAdj(player, animal:getSquare()) then
            local vec = animal:getAttachmentWorldPos("head");
            ISTimedActionQueue.add(ISWalkToTimedActionF:new(player, vec));
            ISWorldObjectContextMenu.equip(player, player:getPrimaryHandItem(), item, true, false)
            ISTimedActionQueue.add(ISGiveWaterToAnimal:new(player, animal, item))
        end
    elseif animal:getVehicle() then -- animal in car
        local vec = animal:getVehicle():getAreaCenter("AnimalEntry");
        local sq = getSquare(vec:getX(), vec:getY(), animal:getVehicle():getZ());
        if luautils.walkAdj(player, sq) then
            ISWorldObjectContextMenu.equip(player, player:getPrimaryHandItem(), item, true, false)
            ISTimedActionQueue.add(ISGiveWaterToAnimal:new(player, animal, item))
        end
        return;
    else -- animal in your hands (InventoryAnimalItem)
        ISTimedActionQueue.add(ISGiveWaterToAnimal:new(player, animal, item))
    end
end

AnimalContextMenu.onAnimalBehavior = function(animal, player)
    local ui = ISAnimalBehaviorDebugUI:new(50, 50, 350, 300, animal, player);
    ui:initialise();
    ui:addToUIManager();
end

AnimalContextMenu.onRandomIdleAnim = function(animal)
    animal:debugRandomIdleAnim();
end

AnimalContextMenu.onRandomHappyAnim = function(animal)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "happy",
                "id", animal:getOnlineID())
    else
        animal:debugRandomHappyAnim()
    end
end

AnimalContextMenu.onKill = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "kill",
                "id", animal:getOnlineID())
    else
        animal:setAttackedBy(getFakeAttacker())
        animal:setHealth(0);
    end
end

AnimalContextMenu.onForceSit = function(animal)
    animal:debugForceSit();
end

AnimalContextMenu.onToggleInvincible = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "invincible",
                "id", animal:getOnlineID())
    else
        animal:setIsInvincible(not animal:isInvincible())
    end
end

AnimalContextMenu.onDebugForceEgg = function(animal)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "forceEgg",
                "id", animal:getOnlineID())
    else
        animal:debugForceEgg();
    end
end

AnimalContextMenu.onLure = function(animal, playerObj, item)
    --local lureItem = playerObj:getInventory():getItemFromType(item);
    ISWorldObjectContextMenu.transferIfNeeded(playerObj, item)
    ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), item, true, false)
    ISTimedActionQueue.add(ISLureAnimal:new(playerObj, animal, item))
end

AnimalContextMenu.onDebugSetStress = function(animal, chr)
    local modal = ISTextBox:new(0, 0, 280, 180, "Set Stress", animal:getStress() .. "", nil, AnimalContextMenu.onSetStressClick, chr, animal, getSpecificPlayer(chr));
    modal:initialise();
    modal:addToUIManager();
    modal:setOnlyNumbers(true);
    if JoypadState.players[chr+1] then
        setJoypadFocus(player, modal)
    end
end

function AnimalContextMenu:onSetStressClick(button, animal, playerObj)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            if isClient() then
                sendClientCommandV(playerObj, "animal", "setStress",
                        "id", animal:getOnlineID(),
                        "value", tonumber(button.parent.entry:getText()))
            else
                animal:setDebugStress(tonumber(button.parent.entry:getText()));
            end
        end
    end
end

AnimalContextMenu.onDebugSetAcceptance = function(animal, playerObj, acceptance)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "acceptance",
                "id", animal:getOnlineID(),
                "player", playerObj:getOnlineID(),
                "acceptance", acceptance)
    else
        animal:setDebugAcceptance(playerObj, acceptance)
    end
end

AnimalContextMenu.onForceAnimalGrowAway = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "updateStatsAway", "id", animal:getOnlineID(), "value", 24)
    else
        animal:updateLastTimeSinceUpdate();
        animal:updateStatsAway(24);
    end
end

AnimalContextMenu.doAnimalBodyMenuFromInv = function(context, playerObj, animalbody)
    if animalbody:hasAnimalParts() then
        local knife = playerObj:getInventory():getFirstTagEvalRecurse("ButcherAnimal", predicateNotBroken)
        local butcherOption = context:addOption(getText("ContextMenu_ButcherAnimal", animalbody:getDisplayName()), animalbody, AnimalContextMenu.onButcherAnimalFromInv, playerObj, knife);
        if not knife then
            butcherOption.notAvailable = true;
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName(getText("Tooltip_Animal_NoKnifeButcher"));
            butcherOption.toolTip = tooltip;
        elseif ISButcherHookUI:isCorpseValid(animalbody) then -- notice the player you won't get as much as using a butchering hook
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName(getText("Tooltip_Animal_BetterOnHook"));
            butcherOption.toolTip = tooltip;
        end

    end
    if animalbody:isAnimalSkeleton() then
        context:addOption(getText("ContextMenu_GetBones", animalbody:getDisplayName()), animalbody, AnimalContextMenu.onGetAnimalBonesFromInv, playerObj);
    end
end

AnimalContextMenu.doAnimalBodyMenu = function(context, player, animalbody)
    local playerObj = getSpecificPlayer(player);
    local txt = getText("ContextMenu_PickUpAnimalBody", animalbody:getCustomName());
    if animalbody:isAnimalSkeleton() then
        txt = getText("ContextMenu_PickUpSkeleton");
    end
    local grabOption = context:addOption(txt, nil, ISWorldObjectContextMenu.onGrabCorpseItem, animalbody, player);

    if animalbody:hasAnimalParts() then
        local knife = playerObj:getInventory():getFirstTagEvalRecurse("ButcherAnimal", predicateNotBroken)
        local butcherOption = context:addOption(getText("ContextMenu_ButcherAnimal", animalbody:getCustomName()), animalbody, AnimalContextMenu.onButcherAnimal, playerObj, knife);
        if not knife then
            butcherOption.notAvailable = true;
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName(getText("Tooltip_Animal_NoKnifeButcher"));
            butcherOption.toolTip = tooltip;
        elseif ISButcherHookUI:isCorpseValid(animalbody) then -- notice the player you won't get as much as using a butchering hook
            local tooltip = ISWorldObjectContextMenu.addToolTip();
            tooltip:setName(getText("Tooltip_Animal_BetterOnHook"));
            butcherOption.toolTip = tooltip;
        end

        if AnimalContextMenu.cheat then
            context:addDebugOption("Butcher Debug UI " .. animalbody:getCustomName(), animalbody, AnimalContextMenu.onButcherAnimalDebug, playerObj);
        end
    end
    if animalbody:isAnimalSkeleton() then
        context:addOption(getText("ContextMenu_GetBones", animalbody:getCustomName()), animalbody, AnimalContextMenu.onGetAnimalBones, playerObj);
    end
end

AnimalContextMenu.onButcherAnimalDebug = function(body, chr)
    local ui = ISButcheringDebugUI:new(50, 50, 300, 600, body, chr)
    ui:initialise();
    ui:addToUIManager();
end

AnimalContextMenu.onGetAnimalBones = function(body, chr, knife)
    if luautils.walkAdj(chr, body:getSquare()) then
        ISTimedActionQueue.add(ISGetAnimalBones:new(chr, body))
    end
end

AnimalContextMenu.onButcherAnimal = function(body, chr, knife)
    if luautils.walkAdj(chr, body:getSquare()) then
        ISWorldObjectContextMenu.equip(chr, chr:getPrimaryHandItem(), knife, true)
        ISTimedActionQueue.add(ISButcherAnimal:new(chr, body))
    end
end

AnimalContextMenu.onGetAnimalBonesFromInv = function(body, chr, knife)
    local corpse = chr:getCurrentSquare():createAnimalCorpseFromItem(body);
    corpse:setX(chr:getCurrentSquare():getX());
    corpse:setY(chr:getCurrentSquare():getY());
    corpse:setZ(chr:getCurrentSquare():getZ());

    corpse:setSquare(chr:getCurrentSquare());

    corpse:getSquare():addCorpse(corpse, false);

    --if (GameServer.bServer) then
    --    GameServer.sendCorpse(corpse);
    --end
    chr:getInventory():Remove(body);
    ISTimedActionQueue.add(ISGetAnimalBones:new(chr, corpse))
end

AnimalContextMenu.onButcherAnimalFromInv = function(body, chr, knife)
    local corpse = chr:getCurrentSquare():createAnimalCorpseFromItem(body);
    corpse:setX(chr:getCurrentSquare():getX());
    corpse:setY(chr:getCurrentSquare():getY());
    corpse:setZ(chr:getCurrentSquare():getZ());

    corpse:setSquare(chr:getCurrentSquare());

    corpse:getSquare():addCorpse(corpse, false);

    --if (GameServer.bServer) then
    --    GameServer.sendCorpse(corpse);
    --end
    chr:getInventory():Remove(body);
    ISTimedActionQueue.add(ISButcherAnimal:new(chr, corpse));
end

AnimalContextMenu.onSetHungry = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "setHunger",
                "id", animal:getOnlineID(),
                "value", 1)
        sendClientCommandV(playerObj, "animal", "setThirst",
                "id", animal:getOnlineID(),
                "value", 1)
    else
        animal:getStats():setHunger(1);
        animal:getStats():setThirst(1);
    end
end

AnimalContextMenu.onAnimalGenome = function(animal, chr)
    local ui = ISAnimalGenomeUI:new(100, 100, 600, 500, animal, chr)
    ui:initialise();
    ui:addToUIManager();
end

AnimalContextMenu.onPetAnimal = function(animal, chr)
    animal:getBehavior():setBlockMovement(true);
    local vec = animal:getAttachmentWorldPos("head");
    ISTimedActionQueue.add(ISWalkToTimedActionF:new(chr, vec));
    ISTimedActionQueue.add(ISPetAnimal:new(chr, animal))
end

AnimalContextMenu.onPickupAnimal = function(animal, chr)
    animal:stopAllMovementNow();
    if luautils.walkAdj(chr, animal:getSquare()) then
        ISTimedActionQueue.add(ISPickupAnimal:new(chr, animal))
    end
end

AnimalContextMenu.onAddEgg = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "addEgg",
                "id", animal:getOnlineID())
    else
        animal:addEgg(false);
    end
end

AnimalContextMenu.onShearAnimal = function(animal, chr, shear)
    animal:getBehavior():setBlockMovement(true);
    local vecRight = animal:getAttachmentWorldPos("rightshear");
    local vecLeft = animal:getAttachmentWorldPos("leftshear");
    local vec = vecRight;
    -- pick the closest vector, left or right of the animal
    if chr:DistToSquared(vecLeft:x(), vecLeft:y()) < chr:DistToSquared(vecRight:x(), vecRight:y()) then
        vec = vecLeft;
    end
    ISTimedActionQueue.add(ISWalkToTimedActionF:new(chr, vec));
    ISWorldObjectContextMenu.transferIfNeeded(chr, shear)
    ISWorldObjectContextMenu.equip(chr, chr:getPrimaryHandItem(), shear, true, false)
    ISTimedActionQueue.add(ISShearAnimal:new(chr, animal, shear))
end

AnimalContextMenu.onSetWoolQty = function(animal, chr)
    local modal = ISTextBox:new(0, 0, 280, 180, getText("ContextMenu_SetWoolQty"), animal:getData():getWoolQuantity() .. "", nil, AnimalContextMenu.onSetWoolQtyClick, chr, animal, getSpecificPlayer(chr));
    modal:initialise();
    modal:addToUIManager();
    modal:setOnlyNumbers(true);
    if JoypadState.players[chr+1] then
        setJoypadFocus(player, modal)
    end
end

function AnimalContextMenu:onSetWoolQtyClick(button, animal, playerObj)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            if isClient() then
                sendClientCommandV(playerObj, "animal", "setWool",
                        "id", animal:getOnlineID(),
                        "value", button.parent.entry:getText())
            else
                animal:getData():setWoolQuantity(tonumber(button.parent.entry:getText()), true);
            end
        end
    end
end

AnimalContextMenu.onSetMilkQty = function(animal, chr)
    local modal = ISTextBox:new(0, 0, 280, 180, getText("ContextMenu_SetMilkQty"), animal:getData():getMilkQuantity() .. "", nil, AnimalContextMenu.onSetMilkQtyClick, chr, animal, getSpecificPlayer(chr));
    modal:initialise();
    modal:addToUIManager();
    modal:setOnlyNumbers(true);
    if JoypadState.players[chr+1] then
        setJoypadFocus(player, modal)
    end
end

function AnimalContextMenu:onSetMilkQtyClick(button, animal, playerObj)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            if isClient() then
                sendClientCommandV(playerObj, "animal", "setMilk",
                        "id", animal:getOnlineID(),
                        "value", tonumber(button.parent.entry:getText()))
            else
                animal:getData():setMaxMilkActual(tonumber(button.parent.entry:getText()));
                animal:getData():setMilkQuantity(tonumber(button.parent.entry:getText()));
            end
        end
    end
end


AnimalContextMenu.onMilkAnimal = function(animal, chr, bucket, all)
    animal:getBehavior():setBlockMovement(true);
    local right = true;
    local vecRight = animal:getAttachmentWorldPos("rightmilk");
    local vecLeft = animal:getAttachmentWorldPos("leftmilk");
    local vec = vecRight;
    -- pick the closest vector, left or right of the animal
    if chr:DistToSquared(vecLeft:x(), vecLeft:y()) < chr:DistToSquared(vecRight:x(), vecRight:y()) then
        vec = vecLeft;
        right = false;
    end
    ISTimedActionQueue.add(ISWalkToTimedActionF:new(chr, vec));
    --        ISWorldObjectContextMenu.transferIfNeeded(chr, shear)
    --        ISWorldObjectContextMenu.equip(chr, chr:getPrimaryHandItem(), shear, true, false)
    ISTimedActionQueue.add(ISMilkAnimal:new(chr, animal, bucket, right, all))
end

AnimalContextMenu.Impregnate = function(animal, playerObj, doIt)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "pregnant", "id", animal:getOnlineID(), "value", doIt)
    else
        animal:getData():setPregnant(doIt);
    end
end

AnimalContextMenu.SetFertilized = function(animal, playerObj, doIt, male)
    if isClient() then
        local maleID = -1
        if male then
            maleID = male:getOnlineID()
        end
        sendClientCommandV(playerObj, "animal", "fertilized",
                "id", animal:getOnlineID(),
                "value", doIt,
                "male", maleID)
    else
        animal:getData():setFertilized(doIt);
        if male and doIt then
            animal:getData():setMaleGenome(male:getFullGenome());
        end
    end
end

AnimalContextMenu.PickMate = function(animal, playerObj)
    local cursor = ISAnimalPickMateCursor:new(playerObj, animal)
    getCell():setDrag(cursor, cursor.player)
end

AnimalContextMenu.SetFertilizedTime = function(animal, player)
    local modal = ISTextBox:new(0, 0, 280, 180, getText("ContextMenu_SetFertilizedTime"), animal:getData():getFertilizedTime() .. "", nil, AnimalContextMenu.onSetFertilizedTimeClick, player, animal, getSpecificPlayer(player));
    modal:initialise();
    modal:addToUIManager();
    modal:setOnlyNumbers(true);
    if JoypadState.players[player+1] then
        setJoypadFocus(player, modal)
    end
end

function AnimalContextMenu:onSetFertilizedTimeClick(button, animal, playerObj)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            if isClient() then
                sendClientCommandV(playerObj, "animal", "fertilizedTime",
                        "id", animal:getOnlineID(),
                        "value", tonumber(button.parent.entry:getText()))
            else
                animal:getData():setFertilizedTime(tonumber(button.parent.entry:getText()));
            end
        end
    end
end

AnimalContextMenu.onAddAnimalBaby = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "addBaby",
                "id", animal:getOnlineID())
    else
        animal:addBaby();
    end
end

AnimalContextMenu.SetPregnancyPeriod = function(animal, player)
    local modal = ISTextBox:new(0, 0, 280, 180, getText("ContextMenu_SetPregnancyPeriod"), animal:getData():getPregnancyTime() .. "", nil, AnimalContextMenu.onSetPregnancyPeriodClick, player, animal, getSpecificPlayer(player));
    modal:initialise();
    modal:addToUIManager();
    modal:setOnlyNumbers(true);
    if JoypadState.players[player+1] then
        setJoypadFocus(player, modal)
    end
end

function AnimalContextMenu:onSetPregnancyPeriodClick(button, animal, playerObj)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            if isClient() then
                sendClientCommandV(playerObj, "animal", "pregnancyTime",
                        "id", animal:getOnlineID(),
                        "value", tonumber(button.parent.entry:getText()))
            else
                animal:getData():setPregnancyTime(tonumber(button.parent.entry:getText()));
            end
        end
    end
end

AnimalContextMenu.onSetAnimalAge = function(animal, player)
    local modal = ISTextBox:new(0, 0, 280, 180, getText("ContextMenu_SetAnimalAge"), animal:getData():getAge() .. "", nil, AnimalContextMenu.onSetAnimalAgeClick, player, animal, getSpecificPlayer(player));
    modal:initialise();
    modal:addToUIManager();
    modal:setOnlyNumbers(true);
    if JoypadState.players[player+1] then
        setJoypadFocus(player, modal)
    end
end

function AnimalContextMenu:onSetAnimalAgeClick(button, animal, playerObj)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            if isClient() then
                sendClientCommandV(playerObj, "animal", "setAge",
                        "id", animal:getOnlineID(),
                        "value", button.parent.entry:getText())
            else
                animal:setAgeDebug(tonumber(button.parent.entry:getText()));
            end
        end
    end
end

AnimalContextMenu.onRemoveAnimal = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "remove",
                "id", animal:getOnlineID())
    else
        animal:remove()
    end
end

AnimalContextMenu.onAnimalInfo = function(animal, chr)
    local ui = ISAnimalUI:new(100, 100, 680, 500, animal, chr)
    ui:initialise();
    ui:addToUIManager();
end

AnimalContextMenu.onDetachAnimalTree = function(animal, chr)
    if luautils.walkAdj(chr, animal:getData():getAttachedTree():getSquare()) then
        ISTimedActionQueue.add(ISAttachAnimalToTree:new(chr, animal, animal:getData():getAttachedTree(), true))
    end
end

AnimalContextMenu.onAttachAnimal = function(animal, chr)
    animal:stopAllMovementNow();
    if luautils.walkAdj(chr, animal:getSquare()) then
        ISTimedActionQueue.add(ISAttachAnimalToPlayer:new(chr, animal, false))
    end
end

AnimalContextMenu.onDetachAnimal = function(animal, chr)
    animal:stopAllMovementNow();
    if luautils.walkAdj(chr, animal:getSquare()) then
        ISTimedActionQueue.add(ISAttachAnimalToPlayer:new(chr, animal, true))
    end
end

AnimalContextMenu.clickedAnimals = function(player, context, animals, test)
    for i,v in ipairs(animals) do
        AnimalContextMenu.doMenu(player, context, v, test);
    end
end

AnimalContextMenu.onSanta = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "attach",
                "id", animal:getOnlineID(),
                "location", "head_hat",
                "item", "Base.Hat_SantaHatDebug")
    else
        animal:setAttachedItem("head_hat", instanceItem("Base.Hat_SantaHatDebug"))
    end
end

AnimalContextMenu.onBowtieGold = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "attach",
                "id", animal:getOnlineID(),
                "location", "bowtie",
                "item", "Base.Animal_BowtieGold")
    else
        animal:setAttachedItem("bowtie", instanceItem("Base.Animal_BowtieGold"))
    end
end
AnimalContextMenu.onBowtieGreen = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "attach",
                "id", animal:getOnlineID(),
                "location", "bowtie",
                "item", "Base.Animal_BowtieGreen")
    else
        animal:setAttachedItem("bowtie", instanceItem("Base.Animal_BowtieGreen"))
    end
end
AnimalContextMenu.onBowtieRed = function(animal, playerObj)
    if isClient() then
        sendClientCommandV(playerObj, "animal", "attach",
                "id", animal:getOnlineID(),
                "location", "bowtie",
                "item", "Base.Animal_BowtieRed")
    else
        animal:setAttachedItem("bowtie", instanceItem("Base.Animal_BowtieRed"))
    end
end

AnimalContextMenu.doDesignationZoneMenu = function(context, zone, playerObj)
    context:addOption(getText("ContextMenu_Animal_CheckZone", zone:getName()), zone, AnimalContextMenu.onCheckZone, playerObj);
end

AnimalContextMenu.onCheckZone = function(zone, playerObj)
    local ui = ISDesignationZoneAnimalZoneUI:new(50,50, 600, 600, playerObj, zone);
    ui:initialise()
    ui:addToUIManager()
    ISAnimalZoneFirstInfo.showUI();
end

AnimalContextMenu.onKillAnimal = function(animal, playerObj)
    local modal = ISModalDialog:new(0,0, 350, 150, getText("IGUI_KillAnimal_Confirm", animal:getFullName()), true, self, AnimalContextMenu.onKillAnimalConfirm);
    modal:initialise()
    modal:addToUIManager()
    modal.animal = animal;
    modal.playerObj = playerObj;
end

function AnimalContextMenu:onKillAnimalConfirm(button)
    if button.internal == "YES" then
        local player = button.parent.playerObj;
        local weapon = player:getInventory():getAllTagEval("KillAnimal", predicateNotBroken):get(0);
        ISWorldObjectContextMenu.equip(player, player:getPrimaryHandItem(), weapon, true, weapon:isTwoHandWeapon())
        if luautils.walkAdj(player, button.parent.animal:getSquare()) then
            ISTimedActionQueue.add(ISKillAnimal:new(player, button.parent.animal))
        end
    end
end

function AnimalContextMenu.attachAnimalToObject(attachAnimalTo, playerObj, worldobjects, context)
    if attachAnimalTo then
        if not playerObj:getAttachedAnimals():isEmpty() then
            local objectName = attachAnimalTo:getName();
            if not objectName then
                objectName = getText("IGUI_Name_Object");
            end
            local text = getText("ContextMenu_AttachAnimalToObject", objectName);
            if instanceof(attachAnimalTo, "IsoTree") then
                text = getText("ContextMenu_AttachAnimalToTree");
            end
            local attachOption = context:addOption(text, worldobjects, nil);
            local subMenu = ISContextMenu:getNew(context);
            context:addSubMenu(attachOption, subMenu)

            for i=0, playerObj:getAttachedAnimals():size() - 1 do
                local animal = playerObj:getAttachedAnimals():get(i);
                local text = getText("IGUI_AnimalType_" .. animal:getAnimalType());
                if animal:getData():getBreed() then
                    text = getText("IGUI_Breed_" .. animal:getData():getBreed():getName()) .. " " .. text;
                end
                text = animal:getCustomName() or text;
                subMenu:addOption(text , animal, ISWorldObjectContextMenu.onAttachAnimalToTree, playerObj, attachAnimalTo);
            end
        end
    end
end

function AnimalContextMenu.getAnimalToInteractWith(playerObj)
    return playerObj:getUseableAnimal();
end

function AnimalContextMenu.showRadialMenu(playerObj)
    local playerIndex = playerObj:getPlayerNum()
    local menu = getPlayerRadialMenu(playerIndex)

    -- For keyboard, toggle visibility
    if menu:isReallyVisible() then
        if menu.joyfocus then
            setJoypadFocus(playerIndex, nil)
        end
        menu:undisplay()
        return
    end

    menu:clear()

    local animal = AnimalContextMenu.getAnimalToInteractWith(playerObj);
    if not animal or animal:isWild() then return; end

    local weapon = playerObj:getInventory():getAllTagEval("KillAnimal", predicateNotBroken);
    if weapon and not weapon:isEmpty() then
        menu:addSlice(getText("ContextMenu_KillAnimal"), getTexture("media/ui/AnimalActions_Kill.png"), AnimalContextMenu.onKillAnimal, animal, playerObj);
    end

    if animal:canBePicked(playerObj) then
        menu:addSlice(getText("ContextMenu_PickUpAnimal", animal:getFullName()), getTexture("media/ui/AnimalActions_Grab.png"), AnimalContextMenu.onPickupAnimal, animal, playerObj);
    end

    if animal:getData():getMilkQuantity() > 0.1 and animal:canBeMilked() then
        local bucketList = playerObj:getInventory():getAvailableFluidContainer(animal:getData():getBreed():getMilkType())
        local bucket = nil;
        if bucketList then
            bucket = bucketList:get(0);
        end

        if bucket then
            menu:addSlice(getText("ContextMenu_Milk"), getTexture("media/ui/AnimalActions_Milk.png"), AnimalContextMenu.onMilkAnimal, animal, playerObj, bucket, true);
        end
    end

    if animal:canBePet() then
        menu:addSlice(getText("ContextMenu_PetAnimal"), getTexture("media/ui/AnimalActions_Pet.png"), AnimalContextMenu.onPetAnimal, animal, playerObj);
    end

    if (animal:getBehavior():canBeAttached() or AnimalContextMenu.cheat) and not animal:getData():getAttachedPlayer() then
        local nbOfRopes = playerObj:getInventory():getNumberOfItem("Base.Rope");
        if(nbOfRopes > playerObj:getAttachedAnimals():size() and not AnimalContextMenu.cheat) then
            menu:addSlice(getText("ContextMenu_AttachAnimal"), getTexture("media/ui/AnimalActions_Rope.png"), AnimalContextMenu.onAttachAnimal, animal, playerObj);
        end
    end

    if animal:canBeSheared() and animal:getData():getWoolQuantity() > 1 then
        local shears = playerObj:getInventory():getAllTagRecurse("Shear", ArrayList.new());
        if not shears:isEmpty() then
            menu:addSlice(getText("ContextMenu_Shear"), getTexture("media/ui/AnimalActions_Shear.png"), AnimalContextMenu.onShearAnimal, animal, playerObj, shears:get(0));
        end
    end

    menu:addSlice(getText("ContextMenu_AnimalInfo"), getTexture("media/ui/AnimalActions_Stats.png"), AnimalContextMenu.onAnimalInfo, animal, playerObj);

    menu:setX(getPlayerScreenLeft(playerIndex) + getPlayerScreenWidth(playerIndex) / 2 - menu:getWidth() / 2)
    menu:setY(getPlayerScreenTop(playerIndex) + getPlayerScreenHeight(playerIndex) / 2 - menu:getHeight() / 2)
    menu:addToUIManager()
end

Events.OnClickedAnimalForContext.Add(AnimalContextMenu.clickedAnimals);
