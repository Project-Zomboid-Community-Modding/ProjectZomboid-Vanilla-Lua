---
--- Created by RJ.
--- DateTime: 2/2/2024 8:36 AM
---

CraftRecipeCode = CraftRecipeCode or {};

CraftRecipeCode.removeFlesh = {};
CraftRecipeCode.removeFur = {};
CraftRecipeCode.tanLeatherCrude = {};
CraftRecipeCode.tanLeatherFur = {};
CraftRecipeCode.dryLeatherCrude = {};
CraftRecipeCode.dryLeatherFur = {};

--[ Leather Preparation ]--
function CraftRecipeCode.removeFlesh.OnCreate(_craftProcessor)
    CraftRecipeCode.replaceOutputLeather2(_craftProcessor);
    --CraftRecipeCode.replaceOutputLeather(_craftProcessor, "_Fur", "LeatherFull");
end

function CraftRecipeCode.removeFur.OnCreate(_craftProcessor)
    CraftRecipeCode.replaceOutputLeather2(_craftProcessor);
    --CraftRecipeCode.replaceOutputLeather(_craftProcessor, "_Crude", "LeatherFur");
end

function CraftRecipeCode.tanLeatherCrude.OnCreate(_craftProcessor)
    CraftRecipeCode.replaceOutputLeather(_craftProcessor, "_Crude_Tan_Wet", "LeatherCrude");
end

function CraftRecipeCode.tanLeatherFur.OnCreate(_craftProcessor)
    CraftRecipeCode.replaceOutputLeather(_craftProcessor, "_Fur_Tan_Wet", "LeatherFur");
end

function CraftRecipeCode.dryLeatherCrude.OnCreate(_craftProcessor)
    CraftRecipeCode.replaceOutputLeather(_craftProcessor, "_Crude_Tan", "LeatherCrudeWet");
end

function CraftRecipeCode.dryLeatherFur.OnCreate(_craftProcessor)
    CraftRecipeCode.replaceOutputLeather(_craftProcessor, "_Fur_Tan", "LeatherFurWet");
end

-- Because we have several possible leather type (one per animal), i'm doing sometihng to replace the output items according to the input
-- SO like if we have a cow's leather as input (Base.Leather_Cow_Fur), we can replace it by a Base.Leather_Cow_Crude or a _Crude_Tan etc...
-- This avoid the needs for multiple recipes per leather type and make modding tad easier
function CraftRecipeCode.replaceOutputLeather(_craftProcessor, name, tag)
    local leatherName = CraftRecipeCode.getLeatherName(_craftProcessor, tag);

    if not leatherName then
        print("No leather name found")
        -- todo: log?
        return;
    end

    leatherName = leatherName .. name;

    _craftProcessor:getResources():getOutputResources():get(0):getStoredItems():clear();
    _craftProcessor:getResources():getOutputResources():get(0):createItem(1, leatherName, 100, false);
end

function CraftRecipeCode.replaceOutputLeather2(_craftProcessor)
    local leather = CraftRecipeCode.getInputLeather(_craftProcessor);

    if not leather then
        print("No leather found")
        -- todo: log?
        return;
    end

    -- if we have a CrudeLeatherVersion we get this one, otherwise we get the ReplacOnUse
    -- the first ReplaceOnUse is basically to remove the flesh, the CrudeLeatherVersion is for if you decide to remove the fur also
    --_craftProcessor:getResources():getOutputResources():get(0):getStoredItems():clear();
    --if leather:getCrudeLeatherVersion() then
    --    _craftProcessor:getResources():getOutputResources():get(0):createItem(1, leather:getCrudeLeatherVersion(), 100, false);
    --elseif leather:getReplaceOnUse() then
    --    _craftProcessor:getResources():getOutputResources():get(0):createItem(1, leather:getReplaceOnUse(), 100, false);
    --end
end

function CraftRecipeCode.getInputLeather(_craftProcessor)
    local caches = ArrayList.new();
    caches = _craftProcessor:getAllConsumedItems(caches)
    --print("yo?")
    --local data = _craftProcessor:getCraftCacheData();
    --data:getAllConsumedCaches(caches);
    for i=0,caches:size()-1 do
        local testItem = caches:get(i);
        if testItem then
            print("check item: ", testItem:getFullType())
            for k=0,testItem:getTags():size()-1 do
                local tag = testItem:getTags():get(k);
                print("testing tag: ", tag)
                if string.contains(tag, "Leather") then
                    return testItem;
                end
            end
        end
    end
end

-- get the leather name by a tag, like a Base.Leather_Cow_Crude have a LeatherCrude tag on it (see items_leather.txt), this'll return "Base.Leather_Cow" if we find it, then we can add the type of leather we want behind this name (like Base.Leather_Cow_Crude_Tan etc.)
function CraftRecipeCode.getLeatherName(_craftProcessor, tag)
    local data = _craftProcessor:getCraftCacheData();
    local caches = ArrayList.new();
    data:getAllConsumedCaches(caches);
    local leather = nil;
    for i=0,caches:size()-1 do
        local consumedCache = caches:get(i);

        if consumedCache:hasItems() then
            for j=0,consumedCache:getItems():size()-1 do
                local testItem = consumedCache:getItems():get(j);
                if testItem and (testItem:hasTag(tag)) then
                    leather = testItem
                    break;
                end
            end
            if leather then
                break;
            end
        end
    end

    if not leather then return; end
    local type = leather:getFullType();
    local split = luautils.split(type, "_");
    return split[1] .. "_" .. split[2];
end