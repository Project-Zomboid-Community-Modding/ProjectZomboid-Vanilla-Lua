--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

CraftRecipeCode = CraftRecipeCode or {};

CraftRecipeCode.test = {};

function CraftRecipeCode.test.OnTest(_craftProcessor)
    --This print will spam when craft UI is open.
    --print("[CraftRecipeCode.test.OnTest]");
    return true;
end

function CraftRecipeCode.test.OnStart(_craftProcessor)
    print("[CraftRecipeCode.test.OnStart]");
    local data = _craftProcessor:getCraftCacheData();

    --Cache data has mod data that can optionally be used
    --Mod data, like all other craft cache data, is available during the time the craft is being performed, gets wiped after OnCreate or OnFailed events.
    local modData = data:getModData();
    modData.ticks = 0;
end

function CraftRecipeCode.test.OnUpdate(_craftProcessor)
    print("[CraftRecipeCode.test.OnUpdate]");
    local data = _craftProcessor:getCraftCacheData();

    local modData = data:getModData();
    modData.ticks = modData.ticks + 1;
end

function CraftRecipeCode.test.OnCreate(_craftProcessor)
    print("[CraftRecipeCode.test.OnCreate]");

    local data = _craftProcessor:getCraftCacheData();
    -- printing mod data recorded tick count
    local modData = data:getModData();
    print("Total entity ticks: "..tostring(modData.ticks));

    print("==== Testing Caches ====")
    print("<consumed>")
    local caches = ArrayList.new();
    data:getAllConsumedCaches(caches);
    for i=0,caches:size()-1 do
        local consumedCache = caches:get(i);

        local resource = consumedCache:getResource();
        local type = consumedCache:getType();
        print("Type="..tostring(type)..", resource="..tostring(resource:getId()));

        print("  hasItems = "..tostring(consumedCache:hasItems()));
        print("  isUsed = "..tostring(consumedCache:isItemUsed()));
        print("  isKeep = "..tostring(consumedCache:isItemKeep()));
        print("  isFluid = "..tostring(consumedCache:getFluidSample()~=nil));
        print("  isEnergy = "..tostring(consumedCache:getEnergy()~=nil));
        print("  amount = "..tostring(consumedCache:getAmount()));
        if consumedCache:hasItems() then
            print("  items");
            print("  [");
            for j=0,consumedCache:getItems():size()-1 do
                print("    item = "..tostring(consumedCache:getItems():get(j):getFullType()))
            end
            print("  ]");
        else
            print("  items = []");
        end
    end
    print("</consumed>")
    print("<created>")
    local caches = ArrayList.new();
    data:getAllCreatedCaches(caches);
    for i=0,caches:size()-1 do
        local createdCache = caches:get(i);

        local resource = createdCache:getResource();
        local type = createdCache:getType();
        print("Type="..tostring(type)..", resource="..tostring(resource:getId()));

        print("  hasItems = "..tostring(createdCache:hasItems()));
        print("  isUsesCreated = "..tostring(createdCache:isItemUsesAdded()));
        print("  isFluid = "..tostring(createdCache:getFluid()~=nil));
        print("  isEnergy = "..tostring(createdCache:getEnergy()~=nil));
        print("  amount = "..tostring(createdCache:getAmount()));
        if createdCache:hasItems() then
            print("  items");
            print("  [");
            for j=0,createdCache:getItems():size()-1 do
                print("    item = "..tostring(createdCache:getItems():get(j):getFullType()))
            end
            print("  ]");
        else
            print("  items = []");
        end
    end
    print("</created>")

    CraftRecipeCode.test.moreDebugPrints(_craftProcessor)
end

function CraftRecipeCode.test.OnFailed(_craftProcessor)
    print("[CraftRecipeCode.test.OnFailed]");
end

--[[
    Some more caching tests
--]]
function CraftRecipeCode.test.moreDebugPrints(_craftProcessor)
    -- to poll Cache data on Resources directly
    -- See ConsumedCache and CreatedCache subclasses of ResourceItem.java, ResourceFluid.java and ResourceEnergy.java.
    print("==== Testing Inputs (Resources) ====")
    local inputs = _craftProcessor:getResources():getInputResources();
    for i=0,inputs:size()-1 do
        local resource = inputs:get(i);
        local cache = resource:getConsumedCache();
        -- ConsumedCache items include both fully consumed and used items
        -- if wanting to exclude used ones test for 'isItemUsed'
        if cache:hasItems() and (not cache:isItemUsed()) then
            print(" -> Resource: "..tostring(resource:getId()));
            for j=0,cache:getItems():size()-1 do
                local item = cache:getItems():get(j);
                print("  consumed item = "..tostring(item:getFullType()))
            end
        end
    end

    -- Alternatively can use helper functions of CraftCacheData.
    -- See CraftCacheData.java

    local data = _craftProcessor:getCraftCacheData();

    print("==== Testing Inputs (CraftCacheData) ====")
    -- a list of items can be fetched directly
    -- the boolean parameter false excludes used items
    local consumedItems = ArrayList.new();
    data:getAllConsumedItems(consumedItems, false);
    for i=0,consumedItems:size()-1 do
        local item = consumedItems:get(i);
        print("  consumed item = "..tostring(item:getFullType()))
    end

    -- list of resources with only fully consumed items
    print("<resources>")
    local consumedItemResources = ArrayList.new();
    data:getAllConsumedItemResources(consumedItemResources, false);
    for i=0,consumedItemResources:size()-1 do
        local resource = consumedItemResources:get(i);
        local cache = resource:getConsumedCache();
        print(" -> Resource: "..tostring(resource:getId()));
        for j=0,cache:getItems():size()-1 do
            local item = cache:getItems():get(j);
            print("  consumed item = "..tostring(item:getFullType()))
        end
    end
    print("</resources>")
    -- instead of resources these function have a variant as well that returns a list of resource caches directly
    print("<caches>")
    local consumedItemCaches = ArrayList.new();
    data:getAllConsumedItemCaches(consumedItemCaches, false);
    for i=0,consumedItemCaches:size()-1 do
        local cache = consumedItemCaches:get(i);
        -- optionally can grab resource from cache object
        local resource = cache:getResource();
        print(" -> Resource: "..tostring(resource:getId()));
        for j=0,cache:getItems():size()-1 do
            local item = cache:getItems():get(j);
            print("  consumed item = "..tostring(item:getFullType()))
        end
    end
    print("</caches>")

    print("==== Testing Input Script ====")
    -- Recipe input/output scripts can also be used to find resource which it has been applied to
    -- note this may be inflexible if the recipe lines change (as referencing these lines would be index based)
    local recipe = _craftProcessor:getCurrentRecipe();
    local inputs = recipe:getInputs();
    local inputScript = inputs:get(1); -- <- getting input with index 1
    print("testing input line: "..tostring(inputScript:getOriginalLine()))

    local resource = data:getResourceForInputScript(inputScript);
    if resource then
        print(" -> consumed by resource: "..tostring(resource:getId()));
        local cache = resource:getConsumedCache();
        for j=0,cache:getItems():size()-1 do
            local item = cache:getItems():get(j);
            print("  consumed item = "..tostring(item:getFullType()))
        end
    end

    print("==== Testing CraftCacheData Other Helper Functions ====")
    -- these require a reference to a recipe input/output or a resource
    print("<recipeInput>")
    local inputs = recipe:getInputs();
    for i=0,inputs:size()-1 do
        local inputScript = inputs:get(i);
        print("input line: "..tostring(inputScript:getOriginalLine()))

        -- directly polls consumedItems for input
        local items = data:getConsumedItems(inputScript);
        print("  - items fully consumed = "..tostring(not data:getConsumedIsItemUsed(inputScript)))
        for j=0,items:size()-1 do
            local item = items:get(j);
            print("  consumed item = "..tostring(item:getFullType()))
        end
    end
    print("</recipeInput>")

    print("<resources>")
    local inputs = _craftProcessor:getResources():getInputResources();
    for i=0,inputs:size()-1 do
        local resource = inputs:get(i);
        print("resource: "..tostring(resource:getId()))

        -- directly polls consumedItems for resource
        local items = data:getConsumedItems(resource);
        print("  - items fully consumed = "..tostring(not data:getConsumedIsItemUsed(resource)))
        for j=0,items:size()-1 do
            local item = items:get(j);
            print("  consumed item = "..tostring(item:getFullType()))
        end
    end
    print("</resources>")
end