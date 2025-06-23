--***********************************************************
--**                    THE INDIE STONE                    **
--**                  Author: turbotutone                  **
--***********************************************************

local instance  = nil;
ISMoveableDefinitions = {};
ISMoveableDefinitions.cheat = false;

local ItemTypeToTag = {
    ["Base.Hammer"] = "Hammer",
    ["Base.Saw"] = "Saw",
    ["Base.Screwdriver"] = "Screwdriver",
    ["Base.Shovel"] = "DigPlow",
    ["Tag.Crowbar"] = "Crowbar",
    ["Tag.SharpKnife"] = "SharpKnife",
    ["Tag.Scissors"] = "Scissors",
    ["Tag.WeldingMask"] = "WeldingMask",
    ["Tag.SewingNeedle"] = "SewingNeedle",
    ["Tag.Rope"] = "Rope",
}

function ISMoveableDefinitions:getInstance()
    if instance~=nil then
        return instance;
    end

    local self = {};
    self.floorReplaceSprites = {}; --{"carpentry_02_56","carpentry_02_57","carpentry_02_58"};
    self.toolDefinitions = {};  -- tools
    self.matsDefinitions = {};  -- materials
    self.scrapDefinitions = {};  -- materials Scrap
    self.healthDefinitions = {}; --material object health modifiers.
    self.repairDefinitions = {}; --material repair

    function self.parseItemTypes( _types )
        local types = {}
        for _,type in ipairs(_types) do
            if ItemTypeToTag[type] then
                local tag = ItemTypeToTag[type]
                local scriptItems = getScriptManager():getItemsTag(tag)
                for i=1,scriptItems:size() do
                    table.insert(types, scriptItems:get(i-1):getFullName())
                end
            else
                table.insert(types, type)
            end
        end
        return types
    end

    function self.addToolDefinition( _name, _items, _perk, _baseActionTime, _sound, _isWav )
        if not self.toolDefinitions[_name] then
            local perkName = nil;
            if _perk then
                perkName = PerkFactory.getPerkName(_perk);
            end
            _items = self.parseItemTypes(_items);
            self.toolDefinitions[_name] = { items = _items, perk = _perk, perkName = perkName, baseActionTime = _baseActionTime, sound = _sound, isWav = _isWav };
            if _items then
                self.toolDefinitions[_name].itemNames = {};
                for _,v in pairs(_items) do
                    local itemType = v:contains(".") and v or (v)
                    local scriptItem = ScriptManager.instance:FindItem(itemType)
                    if scriptItem then
                        self.toolDefinitions[_name].itemNames[v] = scriptItem:getDisplayName();
                    else
                        self.toolDefinitions[_name].itemNames[v] = getDebug() and (v .. "?") or v;
                    end
                end
            end
        end
    end

    function self.getToolDefinition( _name )
        if self.toolDefinitions[_name] then
            return self.toolDefinitions[_name];
        end
    end

    function self.removeToolDefinition( _name )
        if self.toolDefinitions[_name] then
            self.toolDefinitions[_name] = nil;
        end
    end

    function self.addMaterialDefinition( _material, _returnItem, _maxAmount, _chancePerRoll )
        local matsTable = self.matsDefinitions[ _material ] or {};
        table.insert( matsTable, { returnItem = _returnItem, maxAmount = _maxAmount, chancePerRoll = _chancePerRoll } );
        self.matsDefinitions[ _material ] = matsTable;
    end

    function self.getMaterialDefinition( _material )
        if self.matsDefinitions[ _material ] then
            return self.matsDefinitions[ _material ];
        end
    end

    function self.removeMaterialDefinition( _material )
        if self.matsDefinitions[ _material ] then
            self.matsDefinitions[ _material ] = nil;
        end
    end

    function self.addFloorReplaceSprite( _spriteName )
        table.insert( self.floorReplaceSprites, _spriteName );
    end

    function self.isFloorReplaceSprite( _spriteName )
        for k,v in ipairs( self.floorReplaceSprites ) do
            if v == _spriteName then return true; end
        end
        return false;
    end

    function self.addHealthDefinition( _material, _modifier)
        self.healthDefinitions[ _material ] = _modifier;
    end
    function self.getHealthDefinition( _material )
        if self.healthDefinitions[ _material ] then
            return self.healthDefinitions[ _material ];
        end
        return 1;
    end
    function self.removeHealthDefinition( _material)
        if self.healthDefinitions[ _material ] then
            self.healthDefinitions[ _material ] = nil;
        end
    end


    --name,   tools,  perk,   _basActionTime, sound,  isWav;
    function self.addScrapDefinition( _material, _tools, _tools2, _perk, _baseActionTime, _sound, _isWav, _baseChance, _unusableItem )
        if not self.scrapDefinitions[_material] then
            _tools = self.parseItemTypes(_tools);
            _tools2 = self.parseItemTypes(_tools2);
            self.scrapDefinitions[_material] = { name = _material, tools = _tools, tools2 = (_tools2 ~=nil and _tools2 or {}), perk = _perk, perkName = PerkFactory.getPerkName(_perk), baseActionTime = _baseActionTime, sound = _sound, isWav = _isWav, returnItems = {}, returnItemsStatic = {}, baseChance = _baseChance, unusableItem = _unusableItem, fromModData = false };
            if _tools then
                self.scrapDefinitions[_material].toolNames = {};
                for _,v in pairs(_tools) do
                    local itemType = v:contains(".") and v or (v)
                    local scriptItem = ScriptManager.instance:FindItem(itemType)
                    if scriptItem then
                        self.scrapDefinitions[_material].toolNames[v] = scriptItem:getDisplayName();
                    else
                        self.scrapDefinitions[_material].toolNames[v] = getDebug() and (v .. "?") or v;
                    end
                end
            end
            if _tools2 then
                self.scrapDefinitions[_material].toolNames = self.scrapDefinitions[_material].toolNames or {};
                for _,v in pairs(_tools2) do
                    local itemType = v:contains(".") and v or (v)
                    local scriptItem = ScriptManager.instance:FindItem(itemType)
                    if scriptItem then
                        self.scrapDefinitions[_material].toolNames[v] = scriptItem:getDisplayName();
                    else
                        self.scrapDefinitions[_material].toolNames[v] = getDebug() and (v .. "?") or v;
                    end
                end
            end
        end
    end

    function self.getScrapDefinition( _material )
        if self.scrapDefinitions[ _material ] then
            return self.scrapDefinitions[ _material ];
        end
    end

    function self.removeScrapDefinition( _material )
        if self.scrapDefinitions[ _material ] then
            self.scrapDefinitions[ _material ] = nil;
        end
    end

    function self.isScrapDefinitionValid( _material )
        local valid = false;
        if self.scrapDefinitions[ _material ] and self.scrapDefinitions[_material].returnItems then
            valid = (#self.scrapDefinitions[_material].returnItems>0);
        end
        if not valid and self.scrapDefinitions[ _material ] and self.scrapDefinitions[_material].returnItemsStatic then
            valid = (#self.scrapDefinitions[_material].returnItemsStatic>0);
        end
        return valid;
    end

    function self.addScrapItem( _material, _returnItem, _maxAmount, _chancePerRoll, _isStaticSize )
        if _material and self.scrapDefinitions[_material] then
            if not _isStaticSize then
                self.scrapDefinitions[_material].returnItems = self.scrapDefinitions[_material].returnItems or {};
                table.insert( self.scrapDefinitions[_material].returnItems, { returnItem = _returnItem, maxAmount = _maxAmount, chancePerRoll = _chancePerRoll } );
            else
                self.scrapDefinitions[_material].returnItemsStatic = self.scrapDefinitions[_material].returnItemsStatic or {};
                table.insert( self.scrapDefinitions[_material].returnItemsStatic, { returnItem = _returnItem, maxAmount = _maxAmount, chancePerRoll = _chancePerRoll } );
            end
        end
    end

    function self.getScrapItems( _material )
        if self.scrapDefinitions[ _material ] and self.scrapDefinitions[_material].returnItems then
            return self.scrapDefinitions[_material].returnItems;
        end
    end

    --name,  tools,  parts,  perk,  _basActionTime,  sound,  isWav;
    function self.addRepairDefinition( _material, _tools, _tools2, _perk, _baseActionTime, _sound, _isWav, _baseChance )
        if not self.repairDefinitions[_material] then
            _tools = self.parseItemTypes(_tools);
            _tools2 = self.parseItemTypes(_tools2);
            self.repairDefinitions[_material] = { name = _material, tools = _tools, tools2 = (_tools2 ~=nil and _tools2 or {}), parts = {}, perk = _perk, perkName = PerkFactory.getPerkName(_perk), baseActionTime = _baseActionTime, sound = _sound, isWav = _isWav, baseChance = _baseChance };
            if _tools then
                self.repairDefinitions[_material].toolNames = {};
                for _,v in pairs(_tools) do
                    local itemType = v:contains(".") and v or (v)
                    local scriptItem = ScriptManager.instance:FindItem(itemType)
                    if scriptItem then
                        self.repairDefinitions[_material].toolNames[v] = scriptItem:getDisplayName();
                    else
                        self.repairDefinitions[_material].toolNames[v] = getDebug() and (v .. "?") or v;
                    end
                end
            end
            if _tools2 then
                self.repairDefinitions[_material].toolNames = self.repairDefinitions[_material].toolNames or {};
                for _,v in pairs(_tools2) do
                    local itemType = v:contains(".") and v or (v)
                    local scriptItem = ScriptManager.instance:FindItem(itemType)
                    if scriptItem then
                        self.repairDefinitions[_material].toolNames[v] = scriptItem:getDisplayName();
                    else
                        self.repairDefinitions[_material].toolNames[v] = getDebug() and (v .. "?") or v;
                    end
                end
            end
        end
    end

    --items used to repair objects
    --if using _required then the item must be a part of the repair
    -- otherwise it will require any single match of non required items in enough quantity.
    --it must have all of the _required items in enough quantity
    -- _amountNeeded for items with useDelta will use this many uses of the item.
    -- see Door Example in addRepairDefinition below
    function self.addRepairItem( _material, _partItem, _amountNeeded, _required, _damageAmount )
        if _material and self.repairDefinitions[_material] then
            local itemTypes = self.parseItemTypes({_partItem});
            for _, type in ipairs(itemTypes) do
                local scriptItem = ScriptManager.instance:FindItem(type);
                if scriptItem then
                    self.repairDefinitions[_material].parts = self.repairDefinitions[_material].parts or {};
                    table.insert(self.repairDefinitions[_material].parts, { displayName = scriptItem:getDisplayName(), itemType = _partItem, amount = _amountNeeded, required = _required, damageAmount = _damageAmount });
                end
            end
        end
    end

    function self.getRepairDefinition( _material )
        if self.repairDefinitions[ _material ] then
            return self.repairDefinitions[ _material ];
        end
        return nil
    end

    function self.removeRepairDefinition( _material )
        if self.repairDefinitions[ _material ] then
            self.repairDefinitions[ _material ] = nil;
        end
    end

    function self.isRepairDefinitionValid( _material )
        return self.repairDefinitions[ _material ] ~= nil;
    end

    function self.reset()
        self.resetTools();
        self.resetMaterials();
        self.resetScrap();
        self.resetHealth();
        self.resetRepair();
        self.resetFloorReplaceSprites();
    end

    function self.resetTools()
        self.toolDefinitions = {};
    end
    function self.resetMaterials()
        self.matsDefinitions = {};
    end
    function self.resetScrap()
        self.scrapDefinitions = {};
    end
    function self.resetHealth()
        self.healthDefinitions = {};
    end
    function self.resetRepair()
        self.repairDefinitions = {};
    end
    function self.resetFloorReplaceSprites()
        self.floorReplaceSprites = {};
    end

    instance = self;
    return self;
end

function ISMoveableDefinitions.load()
    local moveableDefinitions = ISMoveableDefinitions:getInstance()
    moveableDefinitions.reset();
    --floor sprites
    moveableDefinitions.addFloorReplaceSprite("carpentry_02_56");   -- picked up floors get replaced by these, they are also the sprites that floors can be placed uppon.
    moveableDefinitions.addFloorReplaceSprite("carpentry_02_57");
    moveableDefinitions.addFloorReplaceSprite("carpentry_02_58");
    -- TOOLS:
    --                                      _name,          _items,                                                     _perk,                  _baseActionTime, _sound, _isWav
    moveableDefinitions.addToolDefinition( "Hammer",        {"Base.Hammer"},                                   Perks.Woodwork,         75,     "Hammering",    true  );
    moveableDefinitions.addToolDefinition( "Crowbar",       {"Tag.Crowbar", "Crowbar"},                                                Perks.Woodwork,         150,    "Hammering",    true  );
    moveableDefinitions.addToolDefinition( "Electrician",   {"Base.Screwdriver"},                                            Perks.Electricity,      100,    "Dismantle",    true  );
    moveableDefinitions.addToolDefinition( "Cutter",        {"Tag.SharpKnife","Tag.Scissors","KitchenKnife","Scissors","HuntingKnife","SharpedStone"},  Perks.Woodwork,         50,     "Hammering",    true  );
    moveableDefinitions.addToolDefinition( "Shovel",        {"Base.Shovel"},                    Perks.Farming,          100,    "bushes",       false );
    moveableDefinitions.addToolDefinition( "Wrench",        {"Base.Wrench", "Base.PipeWrench"},                                           nil,                    100,    "RepairWithWrench",    true  );
    moveableDefinitions.addToolDefinition( "Metal",   {"Base.Screwdriver"},                                            Perks.MetalWelding,      100,    "Hammering",    true  );
    moveableDefinitions.addToolDefinition( "Screwdriver",   {"Base.Screwdriver"},                                            Perks.Woodwork,      100,    "Dismantle",    true  );
    -- MATERIALS (BREAKAGE):
    --                                          _material, _returnItem, _maxAmount, _chancePerRoll
    -- Wood
    moveableDefinitions.addMaterialDefinition( "Wood",  "Base.Plank",   3,  20 );
    moveableDefinitions.addMaterialDefinition( "Wood",  "Base.Nails",   1,  10 );
    moveableDefinitions.addMaterialDefinition( "Log",  "Base.Log",   3,  15 );
    -- Steel
    moveableDefinitions.addMaterialDefinition( "Steel",  "Base.Screws",  3,  10 );
    -- Plumbing
    moveableDefinitions.addMaterialDefinition( "Plumbing",  "Base.Screws",  3,  10 );
    -- Electric
    moveableDefinitions.addMaterialDefinition( "Electric",  "Base.Screws",  3,  10 );
    -- Fabric
    moveableDefinitions.addMaterialDefinition( "Fabric",  "Base.Thread",  1,  20 );
    moveableDefinitions.addMaterialDefinition( "Fabric",  "Base.RippedSheets",  3,  10 );
    moveableDefinitions.addMaterialDefinition( "Fabric",  "Base.Sheet",  1,  1 );
    -- Leather
    moveableDefinitions.addMaterialDefinition( "Leather",  "Base.Thread",  1,  20 );
    moveableDefinitions.addMaterialDefinition( "Leather",  "Base.LeatherStrips",  3,  10 );
    -- Natural
    moveableDefinitions.addMaterialDefinition( "Natural",  "Base.Twigs",  3,  10 );
    --FIXME currently missing materials to be added later: 'Brick' and 'Plastic'

    -- MATERIALS (SCRAP)
    --[[
    -- Wood
    --                                      name,   tools,  perk,   _basActionTime, sound,  isWav;
    moveableDefinitions.addScrapDefinition( "Wood",  {"Hammer","HammerStone"}, {},   Perks.Woodwork,  75,     "PZ_Hammer",    true );
    -- Return Items on scrapmaterial, item, amountoftries, baseChance
    moveableDefinitions.addScrapItem( "Wood",  "Base.Plank",   6,  40 );
    moveableDefinitions.addScrapItem( "Wood",  "Base.Nails",   4,  50 );
    moveableDefinitions.addScrapItem( "Wood",  "Base.Screws",  4,  50 );
    -- Wood Door
    moveableDefinitions.addScrapDefinition( "WoodenDoor",  {"Hammer","HammerStone"}, {"Screwdriver"}, Perks.Woodwork,  1000,     "PZ_Hammer",    true );
    moveableDefinitions.addScrapItem( "WoodenDoor",  "Base.Plank",   2,  40 );
    moveableDefinitions.addScrapItem( "WoodenDoor",  "Base.Nails",   4,  50 );
    moveableDefinitions.addScrapItem( "WoodenDoor",  "Base.Plank",   2, 100, true );
    moveableDefinitions.addScrapItem( "WoodenDoor",  "Base.Doorknob",   1, 100, true );
    moveableDefinitions.addScrapItem( "WoodenDoor",  "Base.Hinge",   2, 100, true );
    -- Steel
    moveableDefinitions.addScrapDefinition( "Steel",  {"Hammer","HammerStone"}, {}, Perks.Woodwork,  75,     "PZ_Hammer",    true );
    moveableDefinitions.addScrapItem( "Steel",  "Base.Nails",   4,  50 );
    -- Plumbing
    moveableDefinitions.addScrapDefinition( "Plumbing",  {"Hammer","HammerStone"}, {}, Perks.Woodwork,  75,     "PZ_Hammer",    true );
    moveableDefinitions.addScrapItem( "Plumbing",  "Base.Nails",   4,  50 );
    -- Electric
    moveableDefinitions.addScrapDefinition( "Electric",  {"Screwdriver"}, {}, Perks.Woodwork,  75,     "PZ_Hammer",    true );
    moveableDefinitions.addScrapItem( "Electric",  "Base.Nails",   4,  50 );
    -- Fabric
    moveableDefinitions.addScrapDefinition( "Fabric",  {"KitchenKnife","Scissors","HuntingKnife","SharpedStone"}, {}, Perks.Woodwork,  75,     "PZ_Hammer",    true );
    moveableDefinitions.addScrapItem( "Fabric",  "Base.Nails",   4,  50 );
    -- Leather
    moveableDefinitions.addScrapDefinition( "Leather",  {"KitchenKnife","Scissors","HuntingKnife","SharpedStone"}, {}, Perks.Woodwork,  75,     "PZ_Hammer",    true );
    moveableDefinitions.addScrapItem( "Leather",  "Base.Nails",   4,  50 );
    -- Natural
    moveableDefinitions.addScrapDefinition( "Natural",  {"Base.Shovel","Base.HandShovel"}, {}, Perks.Woodwork,  75,     "PZ_Hammer",    true );
    moveableDefinitions.addScrapItem( "Natural",  "Base.Nails",   4,  50 );
    -- Brick
    moveableDefinitions.addScrapDefinition( "Brick",  {"Hammer","HammerStone"}, {}, Perks.Woodwork,  75,     "PZ_Hammer",    true );
    moveableDefinitions.addScrapItem( "Brick",  "Base.Nails",   4,  50 );
    -- Plastic
    moveableDefinitions.addScrapDefinition( "Plastic",  {"Hammer","HammerStone"}, {}, Perks.Woodwork,  75,     "PZ_Hammer",    true );
    moveableDefinitions.addScrapItem( "Plastic",  "Base.Nails",   4,  50 );
    --]]

    -- ###################################### Revision
    --                                      name,   tools,  perk,   _basActionTime, sound,  isWav, _baseChance;
    moveableDefinitions.addScrapDefinition( "AluminumScrap",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- not yet applied to anything

    moveableDefinitions.addScrapDefinition( "Brick",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- applied to some brick objects

    moveableDefinitions.addScrapDefinition( "Door",  {"Base.Hammer"}, {"Base.Screwdriver"},   Perks.Woodwork,  1000,     "Hammering",    true , 10);
    -- applied to all doors, return items should be ok as is
    -- door objects have their first material assigned as "door" in tilezed so theyll all need a hammer+screwdriver
    -- Return Items                   material, item, amountoftries, baseChance, isStaticSize
    moveableDefinitions.addScrapItem( "Door",  "Base.Doorknob",   1, 80, true );
    moveableDefinitions.addScrapItem( "Door",  "Base.Hinge",   2, 80, true );

    moveableDefinitions.addScrapDefinition( "Electric",  {"Base.Screwdriver"}, {},   Perks.Electricity,  1000,     "Dismantle",    true, 10 );
    -- mostly all electric objects have their first material set as Electric
    moveableDefinitions.addScrapItem( "Electric",  "Base.ElectronicsScrap",   1, 80, true );
    moveableDefinitions.addScrapItem( "Electric",  "Base.ElectricWire",   1, 80, true );
--     moveableDefinitions.addScrapItem( "Electric",  "Base.CopperScrap",   1, 80, true );

    moveableDefinitions.addScrapDefinition( "Fabric",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- applied to objects with a good amount of cloth, as couches and such

    moveableDefinitions.addScrapDefinition( "Foam",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- applied to many seatings that have foam

    moveableDefinitions.addScrapDefinition( "Glass",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- applied to many objects having glass (usually as second/third material

    moveableDefinitions.addScrapDefinition( "Leather",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- applied to objects with fair amount of leather

    moveableDefinitions.addScrapDefinition( "Mechanical",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- applied to mechanical objects not nescessaraly electric, think of bolts, cogs etc

    moveableDefinitions.addScrapDefinition( "MetalBars",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 0 );
    moveableDefinitions.addScrapItem( "MetalBars",  "Base.MetalBar",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalBars",  "Base.SteelBar",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalBars",  "Base.SteelBarHalf",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalBars",  "Base.SteelBarQuarter",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalBars",  "Base.SteelChunk",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalBars",  "Base.SteelPiece",   1, 70, true );
    -- applied to objects with metal bars

    moveableDefinitions.addScrapDefinition( "MetalPipe", {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 4 );
    moveableDefinitions.addScrapItem( "MetalPipe",  "Base.MetalPipe",  2,  80 );

    moveableDefinitions.addScrapDefinition( "Fridge",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 0, "Base.UnusableMetal" );
    moveableDefinitions.addScrapItem( "Fridge",  "Base.SheetMetal",   2, 70, true );
    moveableDefinitions.addScrapItem( "Fridge",  "Base.SmallSheetMetal",   2, 80, true );
    moveableDefinitions.addScrapItem( "Fridge",  "Base.SteelChunk",   2, 80, true );
    moveableDefinitions.addScrapItem( "Fridge",  "Base.SteelPiece",   2, 80, true );
    moveableDefinitions.addScrapItem( "Fridge",  "Base.NutsBolts",   2, 80, true );
    moveableDefinitions.addScrapItem( "Fridge",  "Base.Screws",   2, 80, true );
    moveableDefinitions.addScrapItem( "Fridge",  "Base.ElectricWire",   2, 80, true );
    moveableDefinitions.addScrapItem( "Fridge",  "Base.CopperScrap",   2, 80, true );

    moveableDefinitions.addScrapDefinition( "MetalPlates",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 0, "Base.UnusableMetal" );
    -- this is applied to limited number of objects big enough to supply useable plates
    moveableDefinitions.addScrapItem( "MetalPlates",  "Base.SheetMetal",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalPlates",  "Base.SteelChunk",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalPlates",  "Base.SteelPiece",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalPlates",  "Base.NutsBolts",   1, 70, true );
    
    moveableDefinitions.addScrapDefinition( "MetalPlatesAndBars",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 0, "Base.UnusableMetal" );
    -- this is applied to limited number of objects big enough to supply useable plates
    moveableDefinitions.addScrapItem( "MetalPlatesAndBars",  "Base.SheetMetal",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalPlatesAndBars",  "Base.MetalBar",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalPlatesAndBars",  "Base.SteelBar",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalPlatesAndBars",  "Base.SteelBarHalf",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalPlatesAndBars",  "Base.SteelBarQuarter",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalPlatesAndBars",  "Base.SteelChunk",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalPlatesAndBars",  "Base.SteelPiece",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalPlatesAndBars",  "Base.NutsBolts",   1, 70, true );

    moveableDefinitions.addScrapDefinition( "SmallMetalPlates",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 2, "Base.UnusableMetal" );
    -- this is applied to limited number of objects big enough to supply useable small plates
    moveableDefinitions.addScrapItem( "SmallMetalPlates",  "Base.SmallSheetMetal",   2, 80, true );
    moveableDefinitions.addScrapItem( "SmallMetalPlates",  "Base.SteelChunk",   1, 70, true );
    moveableDefinitions.addScrapItem( "SmallMetalPlates",  "Base.SteelPiece",   1, 70, true );
    moveableDefinitions.addScrapItem( "SmallMetalPlates",  "Base.NutsBolts",   1, 70, true );

    moveableDefinitions.addScrapDefinition( "MetalScrap",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 5);
    moveableDefinitions.addScrapItem( "MetalScrap",  "Base.ScrapMetal",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalScrap",  "Base.SteelChunk",   1, 70, true );
    moveableDefinitions.addScrapItem( "MetalScrap",  "Base.SteelPiece",   1, 70, true );
    -- applied to many objects that have metal in them

    moveableDefinitions.addScrapDefinition( "MetalWire",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 0);
--     moveableDefinitions.addScrapDefinition( "MetalWire",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 5);
    moveableDefinitions.addScrapItem( "MetalWire",  "Base.Wire",   1, 70, true );

    moveableDefinitions.addScrapDefinition( "Mirror",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- objects with a mirror (usually second/third material

    moveableDefinitions.addScrapDefinition( "Nails",  {"Base.Hammer"}, {},   Perks.Woodwork,  700,     "Hammering",    true, 5 );
    moveableDefinitions.addScrapItem( "Nails",  "Base.Nails",   2, 80, true );
    -- added to objects having nails

    moveableDefinitions.addScrapDefinition( "Natural",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- not yet applied on anything

    moveableDefinitions.addScrapDefinition( "Paper",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- applied to some cardboard objects

    moveableDefinitions.addScrapDefinition( "Pipes",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- anything that has piping in it

    moveableDefinitions.addScrapDefinition( "Plastic",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- plastic rubble

    moveableDefinitions.addScrapDefinition( "PlasticBag",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- applied to most recycle bins

    moveableDefinitions.addScrapDefinition( "PlasticHard",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- objects having pieces of hard plastic


    moveableDefinitions.addScrapDefinition( "Plumbing", {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 1 );
    moveableDefinitions.addScrapItem( "Plumbing",  "Base.MetalPipe",  2,  80, true );
    moveableDefinitions.addScrapItem( "Plumbing",  "Base.CopperScrap",   2, 80, true );
    -- generic plumbing stuff (maybe some pipes, bolts etc)

    moveableDefinitions.addScrapDefinition( "Rubber",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- objects having rubber

    moveableDefinitions.addScrapDefinition( "Sandbag",  {}, {},   Perks.Woodwork,  0,     "Hammering",    true );
    moveableDefinitions.addScrapItem( "Sandbag",  "Base.Sandbag",  3,  100 , true);

    moveableDefinitions.addScrapDefinition( "Screws",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    moveableDefinitions.addScrapItem( "Screws",  "Base.Screws",  2,  50 );
    -- objects having screws

    moveableDefinitions.addScrapDefinition( "Sink",  {"Base.Hammer"}, {},   Perks.MetalWelding,  1000,     "Hammering",    true, 1 );
    moveableDefinitions.addScrapItem( "Sink",  "Base.MetalPipe",  2,  80 );
    -- applied to all sink objects

    moveableDefinitions.addScrapDefinition( "Steel",  {"Base.Screwdriver"}, {},   Perks.Woodwork,  500,     "Hammering",    true, 5 );
    -- bit of dummy object, can be left as is (use the metal materials instead)
    moveableDefinitions.addScrapItem( "Steel",  "Base.Screws",  2,  50 );

    moveableDefinitions.addScrapDefinition( "Stone",  {"Base.Hammer"}, {},   Perks.Strength,  1000,     "Hammering",    true, 30 );
    -- applied to objects that can be smashed with sledge hammer to get stones/stoneshards (graves etc)
    moveableDefinitions.addScrapItem( "Stone",  "Base.Stone",  4,  90 );

    moveableDefinitions.addScrapDefinition( "Transmission",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- not yet applied

    moveableDefinitions.addScrapDefinition( "WaterContainer",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    -- special material, added to the waterbin

    moveableDefinitions.addScrapDefinition( "Wood",  {"Base.Hammer"}, {"Base.Saw"},   Perks.Woodwork,  1000,     "Hammering",    true, 7, "Base.UnusableWood" );
    moveableDefinitions.addScrapDefinition( "Log",  {"Base.Hammer"}, {"Base.Saw"},   Perks.Woodwork,  1000,     "Hammering",    true, 7, "Base.UnusableWood" );
    -- applied on all objects having wood
    moveableDefinitions.addScrapItem( "Wood",  "Base.Plank",   1,  90 );
    moveableDefinitions.addScrapItem( "Log",  "Base.Log",   2,  90 );





    --=========================================================== REPAIR DEFINITIONS
    --                                      name,   tools,  perk,   _basActionTime, sound,  isWav, _baseChance;
    moveableDefinitions.addRepairDefinition( "Door",  {"Base.Hammer"}, {"Base.Screwdriver"},   Perks.Woodwork,  1000,     "Hammering",    true , 10);
    -- applied to all doors, return items should be ok as is
    -- door objects have their first material assigned as "door" in tilezed so theyll all need a hammer+screwdriver
    -- Return Items                   _material, partItem, _amountNeeded, _required

    --Door example: needs planks to fix. at 50% damage, it also needs a knob and hinges. Nails or screws are also needed but can provide either type.
    moveableDefinitions.addRepairItem( "Door",  "Base.Plank",   3, true );
    moveableDefinitions.addRepairItem( "Door",  "Base.Doorknob",   1, true, 0.5 );
    moveableDefinitions.addRepairItem( "Door",  "Base.Hinge",   2, true, 0.5 );
    moveableDefinitions.addRepairItem( "Door",  "Base.Nails",   4, false );
    moveableDefinitions.addRepairItem( "Door",  "Base.Screws",   4, false );

    moveableDefinitions.addRepairDefinition( "Fabric",  {"Tag.SewingNeedle"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    moveableDefinitions.addRepairItem( "Fabric",  "Base.Thread",   4, true );
    moveableDefinitions.addRepairItem( "Fabric",  "Base.Sheet",   1, false );
    moveableDefinitions.addRepairItem( "Fabric",  "Base.RippedSheets",   4, false );
    -- applied to objects with a good amount of cloth, as couches and such

    moveableDefinitions.addRepairDefinition( "Leather",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    moveableDefinitions.addRepairItem( "Leather",  "Tag.SewingNeedle",   1, true );
    moveableDefinitions.addRepairItem( "Leather",  "Base.Thread",   4, true );
    moveableDefinitions.addRepairItem( "Leather",  "Base.LeatherStrips",   4, false );
    -- applied to objects with fair amount of leather

    moveableDefinitions.addRepairDefinition( "MetalBars",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 0 );
    moveableDefinitions.addRepairItem( "MetalBars",  "Base.MetalBar",   1, false );
    moveableDefinitions.addRepairItem( "MetalBars",  "Base.SteelBar",   1, false );
    moveableDefinitions.addRepairItem( "MetalBars",  "Base.SteelBarHalf",   2, false );
    moveableDefinitions.addRepairItem( "MetalBars",  "Base.SteelBarQuarter",   4, false );
    moveableDefinitions.addRepairItem( "MetalBars",  "Base.SteelChunk",   4, false );
    moveableDefinitions.addRepairItem( "MetalBars",  "Base.SteelPiece",   8, false );
    -- applied to objects with metal bars

    moveableDefinitions.addRepairDefinition( "MetalPipe", {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 4 );
    moveableDefinitions.addRepairItem( "MetalPipe",  "Base.MetalPipe",  2,  false );

    moveableDefinitions.addRepairDefinition( "MetalPlates",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 0 );
    -- this is applied to limited number of objects big enough to supply useable plates
    moveableDefinitions.addRepairItem( "MetalPlates",  "Base.NutsBolts",   1, true );
    moveableDefinitions.addRepairItem( "MetalPlates",  "Base.SheetMetal",   2, false );
    moveableDefinitions.addRepairItem( "MetalPlates",  "Base.SteelChunk",   4, false );
    moveableDefinitions.addRepairItem( "MetalPlates",  "Base.SteelPiece",   8, false );

    moveableDefinitions.addRepairDefinition( "MetalPlatesAndBars",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 0 );
    -- this is applied to limited number of objects big enough to supply useable plates
    moveableDefinitions.addRepairItem( "MetalPlatesAndBars",  "Base.NutsBolts",   1, true );
    moveableDefinitions.addRepairItem( "MetalPlatesAndBars",  "Base.SheetMetal",   1, false );
    moveableDefinitions.addRepairItem( "MetalPlatesAndBars",  "Base.MetalBar",   1, false );
    moveableDefinitions.addRepairItem( "MetalPlatesAndBars",  "Base.SteelBar",   1, false );
    moveableDefinitions.addRepairItem( "MetalPlatesAndBars",  "Base.SteelBarHalf",   2, false );
    moveableDefinitions.addRepairItem( "MetalPlatesAndBars",  "Base.SteelBarQuarter",   4, false );
    moveableDefinitions.addRepairItem( "MetalPlatesAndBars",  "Base.SteelChunk",   4, false );
    moveableDefinitions.addRepairItem( "MetalPlatesAndBars",  "Base.SteelPiece",   8, false );

    moveableDefinitions.addRepairDefinition( "SmallMetalPlates",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 2 );
    -- this is applied to limited number of objects big enough to supply useable small plates
    moveableDefinitions.addRepairItem( "SmallMetalPlates",  "Base.NutsBolts",   1, true );
    moveableDefinitions.addRepairItem( "SmallMetalPlates",  "Base.SheetMetal",   1, false );
    moveableDefinitions.addRepairItem( "SmallMetalPlates",  "Base.SmallSheetMetal",   2, false );
    moveableDefinitions.addRepairItem( "SmallMetalPlates",  "Base.SteelChunk",   4, false );
    moveableDefinitions.addRepairItem( "SmallMetalPlates",  "Base.SteelPiece",   8, false );

    moveableDefinitions.addRepairDefinition( "MetalScrap",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 5);
    moveableDefinitions.addRepairItem( "MetalScrap",  "Base.ScrapMetal",   1, false );
    moveableDefinitions.addRepairItem( "MetalScrap",  "Base.SteelChunk",   4, false );
    moveableDefinitions.addRepairItem( "MetalScrap",  "Base.SteelPiece",   8, false );
    -- applied to many objects that have metal in them

    moveableDefinitions.addRepairDefinition( "MetalWire",  {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 0);
    moveableDefinitions.addRepairItem( "MetalWire",  "Base.Wire",   1, true );

    moveableDefinitions.addRepairDefinition( "Nails",  {"Base.Hammer"}, {},   Perks.Woodwork,  700,     "Hammering",    true, 5 );
    moveableDefinitions.addRepairItem( "Nails",  "Base.Nails",   2, false );
    moveableDefinitions.addRepairItem( "Nails",  "Base.Screws",   2, false );
    -- added to objects having nails

    moveableDefinitions.addRepairDefinition( "Pipes",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    moveableDefinitions.addRepairItem( "Pipes",  "Base.MetalPipe",  2,  true );
    moveableDefinitions.addRepairItem( "Pipes",  "Base.CopperScrap",   2, false );
    -- anything that has piping in it

    moveableDefinitions.addRepairDefinition( "Plumbing", {"Base.BlowTorch"}, {"Tag.WeldingMask", "Base.WeldingMask"},   Perks.MetalWelding,  1000,     "BlowTorch",    true, 1 );
    moveableDefinitions.addRepairItem( "Plumbing",  "Base.MetalPipe",  2,  true );
    moveableDefinitions.addRepairItem( "Plumbing",  "Base.CopperScrap",   2, true );
    -- generic plumbing stuff (maybe some pipes, bolts etc)

    moveableDefinitions.addRepairDefinition( "Sandbag",  {}, {},   Perks.Woodwork,  0,     "Hammering",    true );
    moveableDefinitions.addRepairItem( "Sandbag",  "Base.Sandbag",  3,  true);

    moveableDefinitions.addRepairDefinition( "Screws",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    moveableDefinitions.addRepairItem( "Screws",  "Base.NutsBolts",  2,  false);
    moveableDefinitions.addRepairItem( "Screws",  "Base.Screws",  2,  false);
    -- objects having screws

    moveableDefinitions.addRepairDefinition( "Sink",  {"Base.Hammer"}, {},   Perks.MetalWelding,  1000,     "Hammering",    true, 1 );
    moveableDefinitions.addRepairItem( "Sink",  "Base.MetalPipe",  2, false );
    -- applied to all sink objects

    moveableDefinitions.addRepairDefinition( "WaterContainer",  {"Base.Hammer"}, {},   Perks.Woodwork,  75,     "Hammering",    true );
    moveableDefinitions.addRepairItem( "WaterContainer",  "Base.Plank",   2,  true );
    moveableDefinitions.addRepairItem( "WaterContainer",  "Base.Nails",   4,  false );
    moveableDefinitions.addRepairItem( "WaterContainer",  "Base.Screws",   4,  false );
    -- special material, added to the waterbin

    moveableDefinitions.addRepairDefinition( "Wood",  {"Base.Hammer"}, {"Base.Saw"},   Perks.Woodwork,  1000,     "Hammering",    true, 7 );
    moveableDefinitions.addRepairItem( "Wood",  "Base.Plank",   2,  true );
    moveableDefinitions.addRepairItem( "Wood",  "Base.Nails",   4,  false );
    moveableDefinitions.addRepairItem( "Wood",  "Base.Screws",   4,  false );
    -- applied on all objects having wood

    moveableDefinitions.addRepairDefinition( "Log",  {"Base.Hammer"}, {"Base.Saw"},   Perks.Woodwork,  1000,     "Hammering",    true, 7 );
    moveableDefinitions.addRepairItem( "Log",  "Base.Log",   2,  true );
    moveableDefinitions.addRepairItem( "Log",  "Base.Nails",   4,  false );
    moveableDefinitions.addRepairItem( "Log",  "Base.Screws",   2, false );
    moveableDefinitions.addRepairItem( "Log",  "Base.RippedSheets",   4, false );
    moveableDefinitions.addRepairItem( "Log",  "Base.Sheet",   2, false );
    moveableDefinitions.addRepairItem( "Log",  "Tag.Rope",   2, false );
    -- applied on all objects having logs




--[[
    local removeCurtainSound = nil
    moveableDefinitions.addScrapDefinition( "Curtain", {}, {}, Perks.MAX, 100, removeCurtainSound, true, 10000 );
    moveableDefinitions.addScrapItem( "Curtain", "Base.Sheet", 1, 10000, true );
    -- Hack so RippedSheets go into inventory instead of on the floor.
    moveableDefinitions.scrapDefinitions["Curtain"].addToInventory = true
    -- Hack to override the animation when scrapping both objects and inventory items.
    moveableDefinitions.scrapDefinitions["Curtain"].recipeAnimNode = "RemoveCurtain"
    moveableDefinitions.scrapDefinitions["Curtain"].recipeSound = removeCurtainSound
    -- Hack so screwdriver isn't displayed while scrapping.
    moveableDefinitions.scrapDefinitions["Curtain"].recipeProp1 = ""
    moveableDefinitions.scrapDefinitions["Curtain"].recipeProp2 = ""
--]]
    --object health modifiers
    moveableDefinitions.addHealthDefinition("Wood", 1.5);
    moveableDefinitions.addHealthDefinition("Brick", 2.25);
    moveableDefinitions.addHealthDefinition("Steel", 3);
end

Events.OnGameBoot.Add(ISMoveableDefinitions.load);

