---
--- Created by RJ.
--- DateTime: 2/2/2024 8:36 AM
---

CraftRecipeCode = CraftRecipeCode or {};

CraftRecipeCode.butcherHook = {};
CraftRecipeCode.removeLeather = {};
CraftRecipeCode.removeBlood = {};
CraftRecipeCode.removeGrease = {};
CraftRecipeCode.removeParts = {};
CraftRecipeCode.removeFeather = {};

-- Columns index for easier reference
CraftRecipeCode.COLUMN_ANIMAL = 0;
CraftRecipeCode.COLUMN_TOOL = 1;
CraftRecipeCode.COLUMN_BLOOD = 5;
CraftRecipeCode.COLUMN_GREASE = 6;

-- Items name for easier reference
CraftRecipeCode.DUMMY_ITEM = "Base.Animal_Item_Dummy";

--[ Butchering ]--
--[ Feather ]--
function CraftRecipeCode.removeFeather.OnCreate(_craftProcessor)
    local def, modData = CraftRecipeCode.butcherHook.getAnimalPartDef(_craftProcessor)
    if not def then return; end

    CraftRecipeCode.butcherHook.createItem(_craftProcessor, def.feather, modData["MaxFeather"])

    modData["feather"] = nil;
    modData["MaxFeather"] = nil;
end

function CraftRecipeCode.removeFeather.OnTest(_craftProcessor)
    --if not CraftRecipeCode.butcherHook.OnTest(_craftProcessor) then return false; end
    return CraftRecipeCode.butcherHook.OnTestModData(_craftProcessor, "feather") ~= nil;

end

--[ Parts ]--
function CraftRecipeCode.removeParts.OnCreate(_craftProcessor)
    local def, modData = CraftRecipeCode.butcherHook.getAnimalPartDef(_craftProcessor)
    if not def then return; end

    for i,v in ipairs(def.parts) do
        print("adding part", v.item, v.nb)
        CraftRecipeCode.butcherHook.createItem(_craftProcessor, v.item, v.nb)
    end

    modData["skeleton"] = "true";
    modData["parts"] = nil;
end

function CraftRecipeCode.removeParts.OnTest(_craftProcessor)
    print("testing remove parts? ")
    --if not CraftRecipeCode.butcherHook.OnTest(_craftProcessor) then return false; end
    return CraftRecipeCode.butcherHook.OnTestModData(_craftProcessor, "parts")  ~= nil;
end

--[ Leather ]--
function CraftRecipeCode.removeLeather.OnCreate(_craftRecipeData)
    local def, modData, carcass = CraftRecipeCode.butcherHook.getAnimalPartDef(_craftRecipeData)
    if not def then return; end

    CraftRecipeCode.butcherHook.createItem(_craftRecipeData, def.leather, 1)

    modData["leather"] = nil;
    --carcass:setModData(modData);
end

function CraftRecipeCode.removeLeather.OnTest(_craftRecipeData)
    print("TESTING REMOVE LEATHER")
    --if not CraftRecipeCode.butcherHook.OnTest(_craftProcessor) then return false; end
    return CraftRecipeCode.butcherHook.OnTestModData(_craftRecipeData, "leather") ~= nil;
end

--[ Grease ]--
function CraftRecipeCode.removeGrease.OnTest(_craftProcessor)
    if not CraftRecipeCode.butcherHook.OnTest(_craftProcessor) then return false; end
    return true;
end

function CraftRecipeCode.removeGrease.OnCreate(_craftProcessor)

end

--[ Blood ]--
function CraftRecipeCode.removeBlood.OnCreate(_craftProcessor)
    local carcass = CraftRecipeCode.getAnimalBody(_craftProcessor);
    if not carcass then return; end
    local modData = carcass:getModData();
    _craftProcessor:getResources():getOutputResources():get(CraftRecipeCode.COLUMN_BLOOD):getFluidContainer():addFluid("AnimalBlood", modData["BloodQty"])
    modData["BloodQty"] = nil;
end

function CraftRecipeCode.removeBlood.OnTest(_craftProcessor)
    --if not CraftRecipeCode.butcherHook.OnTest(_craftProcessor) then return false; end
    return CraftRecipeCode.butcherHook.OnTestModData(_craftProcessor, "BloodQty") ~= nil;
end

-- return the InventoryItem and column index of a output resources
function CraftRecipeCode.getOutputResourceInProcessor(_craftProcessor, name)
    local resources = ArrayList.new();
    resources = _craftProcessor:getResources():getResources(resources, ResourceIO.Output, ResourceType.Item);
    for i=0, resources:size()-1 do
        for j=0,resources:get(i):getStoredItems():size()-1 do
            local item = resources:get(i):getStoredItems():get(j);
            if name == item:getFullType() then
                return item, i;
            end
        end
    end
end

--[ Generic ]--
function CraftRecipeCode.butcherHook.OnTest(_craftRecipeData)
    local gotCorpse = false;
    local gotCleaver = false;
    local inputs = _craftRecipeData:getAllKeepInputItems();
    for i = 0,inputs:size()-1 do
        local item = inputs:get(i);
        if item:hasTag("AnimalCorpse") then
            gotCorpse = true;
        end
        if item:hasTag("ButcherAnimal") then
            gotCleaver = true;
        end
    end
    return gotCorpse and gotCleaver;
    --local body = _craftProcessor:getResources():getInputResources():get(CraftRecipeCode.COLUMN_ANIMAL):getStoredItems():get(0);
    --if not body or not body:hasTag("AnimalCorpse") then
    --    return false;
    --end
    --local tool = _craftProcessor:getResources():getInputResources():get(CraftRecipeCode.COLUMN_TOOL):getStoredItems():get(0);
    --if not tool or not tool:hasTag("ButcherAnimal") then
    --    return false;
    --end
    --return true;
end

function CraftRecipeCode.butcherHook.OnTestModData(_craftProcessor, name)
    --if not CraftRecipeCode.butcherHook.OnTest(_craftProcessor) then return false; end
    local carcass = CraftRecipeCode.getAnimalBody(_craftProcessor);
    if not carcass then return; end
    local modData = carcass:getModData();
    if modData and modData[name] ~= nil then
        return modData[name];
    end
    return nil;
end

--function CraftRecipeCode.butcherHook.replaceItem(_craftProcessor, searchItem, modDataName, nbOfItem)
--    if not nbOfItem then nbOfItem = 1; end
--    local carcass = CraftRecipeCode.getAnimalBody(_craftProcessor);
--    if not carcass then return; end
--    local modData = carcass:getModData();
--    if not modData or not modData[modDataName] then return; end
--
--    local part, index = CraftRecipeCode.getOutputResourceInProcessor(_craftProcessor, searchItem);
--    if not part or not index then print("Output ", searchItem, "wasn't found") return; end
--    _craftProcessor:getResources():getOutputResources():get(index):getStoredItems():remove(part);
--    _craftProcessor:getResources():getOutputResources():get(index):createItem(nbOfItem, modData[modDataName], 100, false);
--    -- remove the moddata on the corpse so we can harvest again
--    carcass:getModData()[modDataName] = nil;
--    return;
--end

-- remove the Animal_Item_Dummy item used in the recipe so it can work
function CraftRecipeCode.butcherHook.removeDummyItem(_craftRecipeData)
    print("REMOVE DUMMY ITEM")
    local carcass = CraftRecipeCode.getAnimalBody(_craftRecipeData);
    if not carcass then return; end

    local ouputs = _craftRecipeData:getToOutputItems();
    print(outputs)
    --for i=0,outputs:size()-1 do
    --    local item = outputs:getInventoryItem(i);
    --    print(item);
    --end

    --local part, index = CraftRecipeCode.getOutputResourceInProcessor(_craftRecipeData, CraftRecipeCode.DUMMY_ITEM);
    --if not part or not index then print("Output ", searchItem, "wasn't found") return; end
    --_craftProcessor:getResources():getOutputResources():get(index):getStoredItems():remove(part);
    return;
end

-- get the AnimalPartsDefinitions for this animal
-- as it's the first step in many butchering stuff, we also remove the dummy item we've made so the recipe can proceed
function CraftRecipeCode.butcherHook.getAnimalPartDef(_craftRecipeData)
    -- remove the item created by default
    CraftRecipeCode.butcherHook.removeDummyItem(_craftRecipeData)
    if true then return; end

    -- get the definitions files for this animal
    local carcass = CraftRecipeCode.getAnimalBody(_craftRecipeData);
    if not carcass then return; end
    local modData = carcass:getModData();
    if not modData or not modData["AnimalType"] or not modData["AnimalBreed"] then return; end

    local def = AnimalPartsDefinitions.animals[modData["AnimalType"] .. modData["AnimalBreed"]];
    if not def then print("no animal parts definition in AnimalPartsDefinitions.lua was found for animal type ", modData["AnimalType"], "breed", modData["AnimalBreed"]) return; end

    return def, modData, carcass;
end

-- create an item in the first empty output resource
function CraftRecipeCode.butcherHook.createItem(_craftProcessor, item, nb)
    local emptyOutput = _craftProcessor:getResources():getFirstEmptyOutputResource();
    if not emptyOutput then
        print("No more free space in output resources")
        return;
    end

    emptyOutput:createItem(nb, item, 100, false);
end

function CraftRecipeCode.getAnimalBody(_craftRecipeData)
    local inputs = _craftRecipeData:getAllKeepInputItems();
    for i = 0,inputs:size()-1 do
        local item = inputs:get(i);
        if item:hasTag("AnimalCorpse") then
            return item;
        end
    end
    --for i = 0,_craftProcessor:getResources():getInputResources():size()-1 do
    --    local result = _craftProcessor:getResources():getInputResources():get(i):peekItem()
    --    if result and instanceof(result, "Food") then
    --        return result;
    --    end
    --end
end