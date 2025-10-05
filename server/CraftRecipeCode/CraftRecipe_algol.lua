--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "recipecode"

CraftRecipeCode = CraftRecipeCode or {};

-- CraftRecipeCode.generic = {};
--
-- function CraftRecipeCode.generic.OnTest(_craftProcessor)
--
-- end
--
-- function CraftRecipeCode.generic.OnStart(_craftProcessor)
--
-- end
--
-- function CraftRecipeCode.generic.OnUpdate(_craftProcessor)
--
-- end
--
-- function CraftRecipeCode.generic.OnCreate(_craftProcessor)
--
-- end
--
-- function CraftRecipeCode.generic.OnFailed(_craftProcessor)
--
-- end


CraftRecipeCode.SharpenBladeGrindstone = {}

function CraftRecipeCode.SharpenBladeGrindstone.OnTest(_craftProcessor)
    local entity = _craftProcessor
    local player = entity:getPlayer()
--     print("TEST!")
    local blade
    for i = 0,entity:getResources():getInputResources():size()-1 do
        local result = entity:getResources():getInputResources():get(i):peekItem()
        if result and (result:hasTag("Sharpenable") or result:hasTag("SharpenableHead")) then blade = result end
    end
    local skill = player:getPerkLevel(Perks.Smithing) + player:getPerkLevel(Perks.Maintenance)
    if not blade then return end
    if (skill == 0 or blade:getCondition() < blade:getConditionMax()/3) and ZombRand(math.min(blade:getCondition(), blade:getConditionLowerChance()) + skill) == 0 then
        blade:setCondition(0)
        return
    end
--     skill = math.max(skill,1)
    if blade:hasTag("SharpenableHead") and blade:hasHeadCondition() then
        local repairMax = math.min(ZombRand(blade:getHeadCondition() + skill, blade:getHeadCondition() + skill + 2), blade:getHeadConditionMax())
        if blade:getHeadCondition() < blade:getHeadConditionMax() and repairMax > blade:getHeadCondition() then
            addXp(player, Perks.Maintenance, 10)
        end
        blade:setHeadCondition(repairMax)
    elseif not blade:hasTag("SharpenableHead") then
        local repairMax = math.min(ZombRand(blade:getCondition() + skill, blade:getCondition() + skill + 2), blade:getConditionMax())
        if blade:getCondition() < blade:getConditionMax() and repairMax > blade:getCondition() then
            addXp(player, Perks.Maintenance, 10)
        end
        blade:setCondition(repairMax)
    end
    if blade:hasSharpness() then blade:applyMaxSharpness() end
end

function CraftRecipeCode.SharpenBladeGrindstone.OnCreate(_craftProcessor)
    local entity = _craftProcessor
    local player = entity:getPlayer()
--     print("TEST!")
    local blade
    for i = 0,entity:getResources():getInputResources():size()-1 do
        local result = entity:getResources():getInputResources():get(i):peekItem()
        if result and result:hasTag("SharpenableHead") then blade = result end
    end
    local skill = player:getPerkLevel(Perks.Smithing) + player:getPerkLevel(Perks.Maintenance)
    if not blade then return end
    if (skill == 0 or blade:getCondition() < blade:getConditionMax()/3) and ZombRand(math.min(blade:getCondition(), blade:getConditionLowerChance()) + skill) == 0 then
        blade:setCondition(0)
        return
    end
--     skill = math.max(skill,1)
--     local repairMax = math.min(ZombRand(blade:getCondition() + skill, blade:getCondition() + skill + 2), blade:getConditionMax())
--     if blade:getCondition() < blade:getConditionMax() then player:getXp():AddXP(Perks.Maintenance, 10) end
--     blade:setCondition(repairMax)
    if blade:hasSharpness() then blade:applyMaxSharpness() end
end

-- function Recipe.OnCreate.SharpenBladeGrindstone(entity)
--     local player = entity:getPlayer()
-- --     print("TEST!")
--     local blade
--     for i = 0,entity:getResources():getInputResources():size()-1 do
--         local result = entity:getResources():getInputResources():get(i):peekItem()
--         if result and (result:hasTag("Sharpenable") or result:hasTag("SharpenableHead")) then blade = result end
--     end
--     local skill = player:getPerkLevel(Perks.Smithing) + player:getPerkLevel(Perks.Maintenance)
--     if not blade then return end
--     if (skill == 0 or blade:getCondition() < blade:getConditionMax()/3) and ZombRand(math.min(blade:getCondition(), blade:getConditionLowerChance()) + skill) == 0 then
--         blade:setCondition(0)
--         return
--     end
-- --     skill = math.max(skill,1)
--     if blade:hasTag("SharpenableHead") and blade:hasHeadCondition() then
--         local repairMax = math.min(ZombRand(blade:getHeadCondition() + skill, blade:getHeadCondition() + skill + 2), blade:getHeadConditionMax())
--         if blade:getHeadCondition() < blade:getHeadConditionMax() and repairMax > blade:getHeadCondition() then player:getXp():AddXP(Perks.Maintenance, 10) end
--         blade:setHeadCondition(repairMax)
--     elseif not blade:hasTag("SharpenableHead") then
--         local repairMax = math.min(ZombRand(blade:getCondition() + skill, blade:getCondition() + skill + 2), blade:getConditionMax())
--         if blade:getCondition() < blade:getConditionMax() and repairMax > blade:getCondition() then player:getXp():AddXP(Perks.Maintenance, 10) end
--         blade:setCondition(repairMax)
--     end
--     if blade:hasSharpness() then blade:applyMaxSharpness() end
-- end

CraftRecipeCode.SharpenHeadGrindstone = {}

function CraftRecipeCode.SharpenHeadGrindstone.OnCreate(_craftProcessor)
    local entity = _craftProcessor
    local player = entity:getPlayer()
--     print("TEST!")
    local blade
    for i = 0,entity:getResources():getInputResources():size()-1 do
        local result = entity:getResources():getInputResources():get(i):peekItem()
        if result and result:hasTag("SharpenableHead") then blade = result end
    end
    local skill = player:getPerkLevel(Perks.Smithing) + player:getPerkLevel(Perks.Maintenance)
    if not blade then return end
    if (skill == 0 or blade:getCondition() < blade:getConditionMax()/3) and ZombRand(math.min(blade:getCondition(), blade:getConditionLowerChance()) + skill) == 0 then
        blade:setCondition(0)
        return
    end
--     skill = math.max(skill,1)
--     local repairMax = math.min(ZombRand(blade:getCondition() + skill, blade:getCondition() + skill + 2), blade:getConditionMax())
--     if blade:getCondition() < blade:getConditionMax() then player:getXp():AddXP(Perks.Maintenance, 10) end
--     blade:setCondition(repairMax)
    if blade:hasSharpness() then blade:applyMaxSharpness() end
end

CraftRecipeCode.EntityRepairFull = {}

-- function Recipe.OnTest.EntityRepairFull(entity)
function CraftRecipeCode.EntityRepairFull.OnCreate(_craftProcessor)
    local entity = _craftProcessor
    print("TEST!")
    local item
    for i = 0,entity:getResources():getInputResources():size()-1 do
        item = entity:getResources():getInputResources():get(i):peekItem()
        if item and item:hasTag("Sharpenable") then
            print("Result " .. tostring(item))
        end
    end
    if not item then return end
    print("item:hasSharpness() " .. tostring(item:hasSharpness()))
    print("item:getSharpness() " .. tostring(item:getSharpness()))
    print("item:getMaxSharpness() " .. tostring(item:getMaxSharpness()))
    if item:hasSharpness() and item:getSharpness() < item:getMaxSharpness() then return true end
--     return false
    if item:hasHeadCondition() then
        print("item:getHeadCondition() < item:getHeadConditionMax() " .. tostring(item:getHeadCondition() < item:getHeadConditionMax()))
        print("item:getHeadCondition() >= item:getHeadConditionMax()/3 " .. tostring(item:getHeadCondition() >= item:getHeadConditionMax()/3))
        return item:getHeadCondition() < item:getHeadConditionMax() and item:getHeadCondition() >= item:getHeadConditionMax()/3
    else
        print("item:getCondition() < item:getConditionMax() " .. tostring( item:getCondition() < item:getConditionMax()))
        print("item:getCondition() >= item:getConditionMax()/3 " .. tostring(item:getCondition() >= item:getConditionMax()/3))
        return item:getCondition() < item:getConditionMax() and item:getCondition() >= item:getConditionMax()/3
    end
end

function CraftRecipeCode.EntityRepairFull.OnTest(_craftProcessor)
    local entity = _craftProcessor
    print("TEST!")
    local item
    for i = 0,entity:getResources():getInputResources():size()-1 do
        item = entity:getResources():getInputResources():get(i):peekItem()
        if item and item:hasTag("Sharpenable") then
            print("Result " .. tostring(item))
        end
    end
    if not item then return end
    print("item:hasSharpness() " .. tostring(item:hasSharpness()))
    print("item:getSharpness() " .. tostring(item:getSharpness()))
    print("item:getMaxSharpness() " .. tostring(item:getMaxSharpness()))
    if item:hasSharpness() and item:getSharpness() < item:getMaxSharpness() then return true end
--     return false
    if item:hasHeadCondition() then
        print("item:getHeadCondition() < item:getHeadConditionMax() " .. tostring(item:getHeadCondition() < item:getHeadConditionMax()))
        print("item:getHeadCondition() >= item:getHeadConditionMax()/3 " .. tostring(item:getHeadCondition() >= item:getHeadConditionMax()/3))
        return item:getHeadCondition() < item:getHeadConditionMax() and item:getHeadCondition() >= item:getHeadConditionMax()/3
    else
        print("item:getCondition() < item:getConditionMax() " .. tostring( item:getCondition() < item:getConditionMax()))
        print("item:getCondition() >= item:getConditionMax()/3 " .. tostring(item:getCondition() >= item:getConditionMax()/3))
        return item:getCondition() < item:getConditionMax() and item:getCondition() >= item:getConditionMax()/3
    end
end

CraftRecipeCode.DismantleBlade = {}

function CraftRecipeCode.DismantleBlade.OnCreate(_craftProcessor)
    local entity = _craftProcessor
    local player = entity:getPlayer()
    local skill = player:getPerkLevel(Perks.Smithing)
--     print("TEST!")
    local blade
    for i = 0,entity:getResources():getInputResources():size()-1 do
        local item = entity:getResources():getInputResources():get(i):peekItem()
        if item and item:hasTag("Sharpenable") then blade = item end
    end
    if not blade then return end
    local result = entity:getResources():getOutputResources():get(0):peekItem()
    result:setConditionFrom(blade);
--     if blade:getConditionMax() == result:getConditionMax() then
--         result:setCondition(result:getCondition())
--         return
--     end
--     local perc = blade:getCondition()/blade:getConditionMax()
--     result:setCondition(result:getConditionMax() * perc)
--     if ZombRand(blade:getCondition() + skill) then result:setCondition(result:getCondition()-1) end

    result:damageCheck(skill, 2)
end

CraftRecipeCode.AssembleBlade = {}

function CraftRecipeCode.AssembleBlade.OnCreate(_craftProcessor)
    local entity = _craftProcessor
    local player = entity:getPlayer()
    local skill = player:getPerkLevel(Perks.Smithing)
--     print("TEST!")
    local blade
    for i = 0,entity:getResources():getInputResources():size()-1 do
        local item = entity:getResources():getInputResources():get(i):peekItem()
        if item and item:hasTag("Sharpenable") then blade = item end
    end
    if not blade then return end
    local result = entity:getResources():getOutputResources():get(0):peekItem()
    result:setConditionFrom(blade);
--     if blade:getConditionMax() == result:getConditionMax() then
--         result:setCondition(result:getCondition())
--         return
--     end
--     local perc = blade:getCondition()/blade:getConditionMax()
--     result:setCondition(result:getConditionMax() * perc)
--     if ZombRand(blade:getCondition() + skill) then result:setCondition(result:getCondition()-1) end
    result:damageCheck(skill, 2)
end

CraftRecipeCode.DismantleHead = {}

function CraftRecipeCode.DismantleHead.OnCreate(_craftProcessor)
    local entity = _craftProcessor
    local player = entity:getPlayer()
    local skill = player:getPerkLevel(Perks.Smithing)
--     print("TEST!")
    local head
    local result
    local handle
    for i = 0,entity:getResources():getInputResources():size()-1 do
        local item = entity:getResources():getInputResources():get(i):peekItem()
        if item and (item:hasTag("SharpenableHead") or item:hasTag("HasToolHead")) then head = item end
    end
    for i = 0,entity:getResources():getOutputResources():size()-1 do
        local item = entity:getResources():getOutputResources():get(i):peekItem()
        if item and (item:hasTag("Sharpenable") or item:hasTag("ToolHead")) then result = item end
        if item and item:hasTag("WoodHandle") and not item:hasTag("AlreadyBroken")then handle = item end
    end
    if handle then handle:setCondition(0) end
--     local result = entity:getResources():getOutputResources():get(0):peekItem()
    if not result then return end
    if head then result:setConditionFromHeadCondition(head) end
    result:damageCheck(skill, 2)
end

CraftRecipeCode.AssembleHead = {}

function CraftRecipeCode.AssembleHead.OnCreate(_craftProcessor)
    local entity = _craftProcessor
    local player = entity:getPlayer()
    local skill = player:getPerkLevel(Perks.Smithing)
--     print("TEST!")
    local head
    local handle
    for i = 0,entity:getResources():getInputResources():size()-1 do
        local item = entity:getResources():getInputResources():get(i):peekItem()
        if item and (item:hasTag("Sharpenable") or item:hasTag("ToolHead"))then head = item end
        if item and item:hasTag("WoodHandle") then handle = item end
    end
    local result = entity:getResources():getOutputResources():get(0):peekItem()
    if handle then result:setConditionFrom(handle) end
    if head then result:setHeadConditionFromCondition(head) end
    result:damageCheck(skill, 2)
end

CraftRecipeCode.ONCREATE_TEST = function(_craftProcessor, thing2, thing3)
    print("ONCREATE_TEST")
    print("_craftProcessor - " .. tostring(_craftProcessor))
    print("thing2 - " .. tostring(thing2))
    print("thing3 - " .. tostring(thing3))
end

CraftRecipeCode.ONTEST_TEST = function(_craftProcessor, thing2, thing3)
    print("ONTEST_TEST")
    print("_craftProcessor - " .. tostring(_craftProcessor))
--     print("thing2 - " .. tostring(thing2))
--     print("thing3 - " .. tostring(thing3))
--     local entity = _craftProcessor
--     local recipe = entity:getRecipe()
--     print("recipe - " .. tostring(recipe))
--     print("recipe name - " .. tostring(recipe:getName()))
--     local item = entity:getFirstInputItem()
--     print("item - " .. tostring(item))
--     local player = entity:getPlayer()
--     print("player - " .. tostring(player))
--     local resources = entity:getResources()
--     print("resources - " .. tostring(resources))
--     local inputResources = resources:getInputResources()
--     print("inputResources - " .. tostring(inputResources))
--
--     if inputResources then
--         print("inputResources:size() - " .. tostring(inputResources:size()))
--
--         for i = 0,inputResources:size()-1 do
--             print("inputResources:get("..i..") - " .. tostring(inputResources:get(i)))
--             local item = inputResources:get(i):peekItem()
--             if item then
--
--                 print("item #" .. tostring(i) .. " - " .. item:getType())
--             end
--         end
--     end
    return true
end


CraftRecipeCode.FLAG_TEST = function(_craftProcessor, thing2, thing3)
    print("FLAG_TEST")
    print("_craftProcessor - " .. tostring(_craftProcessor))
--     print("thing2 - " .. tostring(thing2))
--     print("thing3 - " .. tostring(thing3))

    local list = _craftProcessor:getAllKeepInputItems()
    print("list - " .. tostring(list))
    local list2 = _craftProcessor:getAllInputItemsWithFlag("IsWorn")
    print("IsWorn - " .. tostring(list2))
    local list3 = _craftProcessor:getAllInputItemsWithFlag("AllowDestroyedItem")
    print("AllowDestroyedItem - " .. tostring(list3))

--     local resources = _craftProcessor:getResources()
--     print("resources - " .. tostring(resources))

end

CraftRecipeCode.CopyKey = {}
function CraftRecipeCode.CopyKey.OnTest(item)
--     print("ONTEST FOR COPY KEY")
--     print("ITEM " .. tostring(item))

    if not item:hasTag("BuildingKey") then return true end
--     print("getKeyId() " .. tostring(item:getKeyId()))
    return item:getKeyId() ~= -1
end

function CraftRecipeCode.CopyKey.OnCreate(craftRecipeData)
--     print("craftRecipeData - " .. tostring(craftRecipeData))

    local items = craftRecipeData:getAllInputItems()
    print("items - " .. tostring(items))


    local sourceKey
    for i = 0,items:size()-1 do
        local item = items:get(i)
        if item and item:hasTag("BuildingKey") then sourceKey = item end
    end
    local newKey = craftRecipeData:getFirstCreatedItem()
--     print("newKey - " .. tostring(newKey))
    newKey:setKeyId(sourceKey:getKeyId());
end

CraftRecipeCode.GenericFixing = {}

function CraftRecipeCode.GenericFixing.OnCreate(craftRecipeData, player)
    CraftRecipeCode.GenericFixer(craftRecipeData, player, 1, craftRecipeData:getFirstInputItemWithFlag("IsDamaged"), skill, false)
end

CraftRecipeCode.GenericBetterFixing = {}

function CraftRecipeCode.GenericBetterFixing.OnCreate(craftRecipeData, player)
    CraftRecipeCode.GenericFixer(craftRecipeData, player, 2, craftRecipeData:getFirstInputItemWithFlag("IsDamaged"), skill, false)
end

CraftRecipeCode.GenericEvenBetterFixing = {}

function CraftRecipeCode.GenericEvenBetterFixing.OnCreate(craftRecipeData, player)
    CraftRecipeCode.GenericFixer(craftRecipeData, player, 3, craftRecipeData:getFirstInputItemWithFlag("IsDamaged"), skill, false)
end

function CraftRecipeCode.GenericFixer(craftRecipeData, player, factor, item, skill, head)
    if not item then item = craftRecipeData:getFirstInputItemWithFlag("IsDamaged") end
    if not factor then factor = 1 end
    if not player then player = craftRecipeData:getPlayer() end
    if not skill then skill  = math.max(craftRecipeData:getRecipe():getHighestRelevantSkillLevel(player), item:getMaintenanceMod(false, player)/2) end
    local timesRepaired = item:getHaveBeenRepaired()
    if head then
        timesRepaired = item:getTimesHeadRepaired()
        item:setTimesHeadRepaired(timesRepaired + 1)
    else
        item:setHaveBeenRepaired(timesRepaired + 1)
    end

    local failChance = 25 - (factor * 5)
--     local failChance = 3
    if skill > 0 then
        failChance = failChance - (skill * 5)
    else
        failChance = failChance + 10
--         failChance = failChance + 30
    end
    failChance = failChance + (timesRepaired * 2)
    -- failChance = failChance + (item:getHaveBeenRepaired() * 2)
    if player:getTraits():contains("Lucky") then failChance = failChance - 5
    elseif player:getTraits():contains("Lucky") then failChance = failChance + 5 end

    failChance = math.min(failChance, 95)
    failChance = math.max(failChance, 0)

    if ZombRand(100) <= failChance then
        if head then
            item:setHeadCondition(item:getHeadCondition() - 1);
        else
            item:setCondition(item:getCondition() - 1);
        end
        item:syncItemFields()
        return
    end
    if timesRepaired < 1 then timesRepaired = 1 end
    local percentFixed = (factor * 10 * (1/timesRepaired) + math.min(skill * 5, 25))/100
    local amountFixed
    if head then
        amountFixed = ( item:HeadgetConditionMax() - item:getHeadCondition() ) * percentFixed
    else
        amountFixed = ( item:getConditionMax() - item:getCondition() ) * percentFixed
    end
    amountFixed = math.max(1, amountFixed)
    if head then
        item:setHeadCondition(item:getHeadCondition() +amountFixed)
    else
        item:setConditionNoSound(item:getCondition() +amountFixed)
    end

--     item:setCondition(item:getCondition() + ZombRand(factor) +1)
--     if ZombRand(11) < skill then
--         item:setConditionNoSound(item:getCondition() + ZombRand(factor) + 1)
--     end
	item:syncItemFields()
end
