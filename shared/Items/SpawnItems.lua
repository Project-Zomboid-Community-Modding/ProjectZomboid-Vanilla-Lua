-------------------------------------------------
-------------------------------------------------
--
-- SpawnItems
--
-- eris
--
-------------------------------------------------
-------------------------------------------------
local SpawnItems = {};

-- this is an explicit % chance, ie 1% at default, no funny business or complexity beyond that
SpawnItems.SpecialKeyRingChance = 1

local function addTestSpawnPistol(playerObj)
    -- attaching the pistol to the holster doesn't work properly when the player spawns so it's commented out
-- 	local holster = playerObj:getInventory():AddItem("Base.HolsterSimple")
-- 	playerObj:setWornItem(holster:getBodyLocation(), holster)
    local pistol = playerObj:getInventory():AddItem("Base.Pistol")
    pistol:setRoundChambered(true)
    pistol:setContainsClip(true)
    pistol:setCurrentAmmoCount(pistol:getMaxAmmo())

-- the pistol isn't attached to the holster because it doesn't work properly when the player spawns
--     playerObj:setAttachedItem("Holster Right", pistol);
--     pistol:setAttachedSlot(4);
--     pistol:setAttachedSlotType("Holster Right");
--     pistol:setAttachedToModel("Holster Right");

    for i = 0, 4 do
        local clip = playerObj:getInventory():AddItem("Base.9mmClip")
        clip:setCurrentAmmoCount(clip:getMaxAmmo())
    end

    playerObj:getInventory():AddItem("Base.Bullets9mmBox")

end

local function addTestFishingStuff(playerObj)
    if "Darkwallow Lake, KY" == getCore():getSelectedMap() then
        local inv = playerObj:getInventory()
        inv:AddItem("Base.FishingLine")
        inv:AddItem("Base.JigLure")
        inv:AddItem("Base.MinnowLure")
        inv:AddItem("Base.Bobber")
        inv:AddItem("Base.PremiumFishingLine")
        inv:AddItem("Base.FishingHookBox")
        inv:AddItem("Base.CraftedFishingRod")
        inv:AddItem("Base.FishingRod")
        inv:AddItem("Base.FishingHook_Bone")
        inv:AddItem("Base.FishingHook_Forged")

        inv:AddItem("Base.Cricket")
        inv:AddItem("Base.Grasshopper")
        inv:AddItem("Base.AmericanLadyCaterpillar")
        inv:AddItem("Base.BandedWoolyBearCaterpillar")
        inv:AddItem("Base.Centipede")
        inv:AddItem("Base.Centipede2")
        inv:AddItem("Base.Millipede")
        inv:AddItem("Base.Millipede2")
        inv:AddItem("Base.MonarchCaterpillar")
        inv:AddItem("Base.Pillbug")
        inv:AddItem("Base.SawflyLarva")
        inv:AddItem("Base.SilkMothCaterpillar")
        inv:AddItem("Base.Cockroach")
        inv:AddItem("Base.SwallowtailCaterpillar")
        inv:AddItem("Base.Termites")
        inv:AddItem("Base.BaitFish")
        inv:AddItem("Base.Tadpole")
        inv:AddItem("Base.Leech")
        inv:AddItem("Base.Snail")
        inv:AddItem("Base.Slug")
        inv:AddItem("Base.Slug2")
        inv:AddItem("Base.Worm")
        inv:AddItem("Base.Maggots")
    end
end

local function addBunkerStuff(playerObj)
    if "Bunker, KY" == getCore():getSelectedMap() then
        local torch = instanceItem("Base.Torch");
        local machete = instanceItem("Base.Machete");

        playerObj:getInventory():AddItem(torch);
        playerObj:getInventory():AddItem(machete);
        playerObj:setPrimaryHandItem(machete);
        playerObj:setSecondaryHandItem(torch);

        for i=0,7 do
            playerObj:LevelPerk(Perks.Aiming);
            playerObj:LevelPerk(Perks.Reloading);
        end

        local guns = {};
        local clips = {};

        local sq = getSquare(9930, 12628, 0);
        if sq then
            local crate = sq:addTileObject("carpentry_01_16");
            crate:getContainer():clear();
            crate:getContainer():setExplored(true);
            table.insert(guns, crate:getContainer():AddItem("Base.AssaultRifle"));
            table.insert(guns, crate:getContainer():AddItem("Base.AssaultRifle2"));
            table.insert(guns, crate:getContainer():AddItem("Base.DoubleBarrelShotgun"));
            table.insert(guns, crate:getContainer():AddItem("Base.HuntingRifle"));
            table.insert(guns, crate:getContainer():AddItem("Base.Pistol2"));
            table.insert(guns, crate:getContainer():AddItem("Base.Pistol3"));
            table.insert(guns, crate:getContainer():AddItem("Base.Revolver"));
            table.insert(guns, crate:getContainer():AddItem("Base.Revolver_Long"));
            table.insert(guns, crate:getContainer():AddItem("Base.Revolver_Short"));
            table.insert(guns, crate:getContainer():AddItem("Base.VarmintRifle"));
            table.insert(guns, crate:getContainer():AddItem("Base.Shotgun"));

            for i = 0, 4 do
                table.insert(clips, crate:getContainer():AddItem("Base.556Clip"));
                table.insert(clips, crate:getContainer():AddItem("Base.M14Clip"));
                table.insert(clips, crate:getContainer():AddItem("Base.45Clip"));
                table.insert(clips, crate:getContainer():AddItem("Base.44Clip"));
                crate:getContainer():AddItem("Base.556Box");
                crate:getContainer():AddItem("Base.308Box");
                crate:getContainer():AddItem("Base.ShotgunShellsBox");
                crate:getContainer():AddItem("Base.Bullets45Box");
                crate:getContainer():AddItem("Base.Bullets44Box");
                crate:getContainer():AddItem("Base.223Box");
            end
        end

        for i,gun in ipairs(guns) do
            gun:setRoundChambered(true)
            gun:setContainsClip(true)
            gun:setCurrentAmmoCount(gun:getMaxAmmo())
        end

        for i,clip in ipairs(clips) do
            clip:setCurrentAmmoCount(clip:getMaxAmmo())
        end
    end
end

local function addRanchStuff(playerObj)
    if "Ranch" == getCore():getSelectedMap() then
        playerObj:getInventory():AddItem("Bucket");
        playerObj:getInventory():AddItem("MeatCleaver");
        playerObj:getInventory():AddItem("Scythe");
        playerObj:getInventory():AddItem("SheepElectricShears");
        playerObj:getInventory():AddItem("BrainTan");
        playerObj:getInventory():AddItem("Bag_NormalHikingBag");

        playerObj:getCurrentSquare():AddWorldInventoryItem("AnimalFeedBag", ZombRand(-0.5, 0.5), ZombRand(-0.5, 0.5), 0);
        playerObj:getCurrentSquare():AddWorldInventoryItem("AnimalFeedBag", ZombRand(-0.5, 0.5), ZombRand(-0.5, 0.5), 0);
        playerObj:getCurrentSquare():AddWorldInventoryItem("AnimalFeedBag", ZombRand(-0.5, 0.5), ZombRand(-0.5, 0.5), 0);
        playerObj:getCurrentSquare():AddWorldInventoryItem("AnimalFeedBag", ZombRand(-0.5, 0.5), ZombRand(-0.5, 0.5), 0);
        playerObj:getCurrentSquare():AddWorldInventoryItem("AnimalFeedBag", ZombRand(-0.5, 0.5), ZombRand(-0.5, 0.5), 0);
        playerObj:getCurrentSquare():AddWorldInventoryItem("AnimalFeedBag", ZombRand(-0.5, 0.5), ZombRand(-0.5, 0.5), 0);

        -- vehicles
        local vehicle = addVehicle("Base.Trailer_Livestock", 10821, 9087, 0);
        vehicle:repair();
        vehicle = addVehicle("Base.OffRoad", 10821, 9092, 0);
        vehicle:repair();
        local item = vehicle:createVehicleKey();
        if item then
            playerObj:getInventory():AddItem(item);
        end
--        sendClientCommand(getPlayer(), "vehicle", "getKey", { vehicle = vehicle:getId() })

        -- adding a butcher hook in the barn next to the player
        local sq = getSquare(10804, 9075, 0);
        if sq then
            sq:AddTileObject(IsoButcherHook.new(sq));
        end
    end
end

function SpawnItems.OnNewGame(playerObj, square)

	if isClient() then
		return
	end

	-- spawn with a belt
	local belt = playerObj:getInventory():AddItem("Base.Belt2");
	playerObj:setWornItem(belt:getBodyLocation(), belt);

	-- add StarterKit if configured
	if SandboxVars.StarterKit then
		local bag = playerObj:getInventory():AddItem("Base.Bag_Schoolbag");
		local bat = bag:getItemContainer():AddItem("Base.BaseballBat");
		bat:setCondition(7);
		local hammer = bag:getItemContainer():AddItem("Base.Hammer");
		hammer:setCondition(5);
		playerObj:getInventory():AddItem("Base.WaterBottle");
		playerObj:getInventory():AddItem("Base.Crisps");
		playerObj:setClothingItem_Back(bag);
	end;

	-- add starting items (depends on difficulty)
	if getWorld():getDifficulty() == "Easy" then
		local bag =  playerObj:getInventory():FindAndReturn("Base.Bag_Schoolbag");
		if not bag then
			bag = playerObj:getInventory():AddItem("Base.Bag_Schoolbag");
			playerObj:getInventory():AddItem("Base.WaterBottle");
			bag:getItemContainer():AddItem("Base.BaseballBat");
			bag:getItemContainer():AddItem("Base.Hammer");
			playerObj:getInventory():AddItem("Base.Crisps");
			playerObj:setClothingItem_Back(bag);
		end;
		bag:getItemContainer():AddItem("Base.Saw");
		playerObj:getInventory():AddItem("Base.Crisps2");
		playerObj:getInventory():AddItem("Base.Crisps3");
	elseif getWorld():getDifficulty() == "Normal" then
		local bag =  playerObj:getInventory():FindAndReturn("Base.Bag_Schoolbag");
		if not bag then
			bag = playerObj:getInventory():AddItem("Base.Bag_Schoolbag");
			local bat = bag:getItemContainer():AddItem("Base.BaseballBat");
			bat:setCondition(7);
			local hammer = bag:getItemContainer():AddItem("Base.Hammer");
			hammer:setCondition(5);
			playerObj:setClothingItem_Back(bag);
		end;
		playerObj:getInventory():AddItem("Base.WaterBottle");
		playerObj:getInventory():AddItem("Base.Crisps");
	elseif getWorld():getDifficulty() == "Hard" then
		playerObj:getInventory():AddItem("Base.WaterBottle");
		playerObj:getInventory():AddItem("Base.Crisps");
	end;
	
	-- give the new players the SpawnItem if configured (MP Only)
	if isServer() then
		if getServerOptions():getOption("SpawnItems") and getServerOptions():getOption("SpawnItems")~= "" then
			local items = luautils.split(getServerOptions():getOption("SpawnItems"), ",");
			for i,v in pairs(items) do
				playerObj:getInventory():AddItem(v);
			end;
		end;
	end;

	-- apply the character name if they have a DogTag
	local dogTag = playerObj:getInventory():getFirstTagRecurse("DogTag") or playerObj:getInventory():getFirstTypeRecurse("Necklace_DogTag");
	if dogTag then
	    dogTag:nameAfterDescriptor(playerObj:getDescriptor())
	end
	-- add an ID card
	local idType = "Base.IDcard"
    if ZombRand(100) < SpawnItems.SpecialKeyRingChance then
        idType = "Base.Passport"
    end
	local card = playerObj:getInventory():AddItem(idType)
	if card then
	    card:nameAfterDescriptor(playerObj:getDescriptor())
	end
    if playerObj:HasTrait("SpeedDemon") and ZombRand(100) < SpawnItems.SpecialKeyRingChance then
	   local ticket = playerObj:getInventory():AddItem("Base.SpeedingTicket")
	    ticket:nameAfterDescriptor(playerObj:getDescriptor())
    end
    if playerObj:getDescriptor():getProfession() then
        local prof = playerObj:getDescriptor():getProfession()
	    -- add a badge if a character has a suitable profession
        if prof == "parkranger" or prof == "policeofficer" or prof == "fireofficer" then
	        local badge = playerObj:getInventory():AddItem("Base.Badge")
	        badge:nameAfterDescriptor(playerObj:getDescriptor())
        end
	    -- add a pager if a character is a doctor
        if prof == "doctor" then
	        playerObj:getInventory():AddItem("Base.Pager");
        end
    end
    local keyRings = {  }
    -- 1% chance of having a special keyRing
    if ZombRand(100) < SpawnItems.SpecialKeyRingChance then
        SpawnItems.GenerateSpecialKeyRing(playerObj, keyRings)
    end
    if #keyRings < 1 then table.insert(keyRings, "Base.KeyRing") end
    local keyRing = keyRings[ZombRand(#keyRings)+1]
	-- key ring handling is now here and not in java
	playerObj:createKeyRing(keyRing)

 	addTestSpawnPistol(playerObj)
	addTestFishingStuff(playerObj)
    addRanchStuff(playerObj)
    addBunkerStuff(playerObj)
end

SpawnItems.TraitKeyRings = {
    AdrenalineJunkie = { "Base.KeyRing_EightBall", "Base.KeyRing_Panther", },
    Axeman = { "KeyRing_PineTree", },
    Brave = { "Base.KeyRing_Panther", },
    Brawler = { "Base.KeyRing_EightBall", "Base.KeyRing_Panther", },
    Burglar = { "Base.KeyRing_EightBall", "Base.KeyRing_Panther", },
    Cook = { "Base.KeyRing_HotDog", },
    Cook2 = { "Base.KeyRing_HotDog", },
    Desensitized = { "Base.KeyRing_Panther", },
    Dextrous = { "Base.KeyRing_Kitty", },
    Fishing = { "Base.KeyRing_Bass", },
    FormerScout = { "KeyRing_PineTree", },
    Gardener = { "Base.KeyRing_Bug", },
    Graceful = { "Base.KeyRing_Kitty", },
    HeartyAppetite = { "Base.KeyRing_HotDog", },
    FormerScout = { "KeyRing_PineTree", },
    Herbalist = { "KeyRing_PineTree", },
    Hiker = { "KeyRing_PineTree", },
    Hunter = { "KeyRing_PineTree", },
    IronGut = { "Base.KeyRing_HotDog", },
    Lucky = { "Base.KeyRing_Clover", "Base.KeyRing_RabbitFoot", },
    Mechanics = { "Base.KeyRing_EagleFlag", "Base.KeyRing_EightBall", "Base.KeyRing_Panther", "Base.KeyRing_Sexy", },
    Nightvision = { "Base.KeyRing_Kitty", },
    Outdoorsman = { "KeyRing_PineTree", },
    Smoker = { "Base.KeyRing_EightBall", "Base.KeyRing_Panther","Base.KeyRing_Sexy", },
    SpeedDemon = { "Base.KeyRing_EagleFlag", "Base.KeyRing_EightBall", "Base.KeyRing_Panther", "Base.KeyRing_Sexy", },
    ThickSkinned = { "Base.KeyRing_Panther", },
    Unlucky = { "Base.KeyRing_EightBall", },
    WeakStomach = { "Base.KeyRing_StinkyFace", },
    WildernessKnowledge = { "KeyRing_PineTree", },
}

-- note that a lot of professions would already have their key rings applied above via the traits that the profession gives
SpawnItems.ProfessionKeyRings = {
    burgerflipper = { "Base.KeyRing_Spiffoes", },
    carpenter = { "Base.KeyRing_EagleFlag", "Base.KeyRing_PineTree", },
    constructionworker = { "Base.KeyRing_EagleFlag",  },
    electrician = { "Base.KeyRing_EagleFlag",  },
    engineer = { "Base.KeyRing_EagleFlag",  },
    farmer = { "Base.KeyRing_EagleFlag",  },
    fireofficer = { "Base.KeyRing_EagleFlag",  },
    fisherman = { "Base.KeyRing_Bass", },
    mechanics = { "Base.KeyRing_EagleFlag", "Base.KeyRing_Panther",  },
    metalworker = { "Base.KeyRing_EagleFlag", "Base.KeyRing_Panther",  },
    nurse = { "Base.KeyRing_Kitty", "Base.KeyRing_RainbowStar",  },
    parkranger = { "Base.KeyRing_PineTree", },
    policeofficer = { "Base.KeyRing_EagleFlag",  },
    repairman = { "Base.KeyRing_EagleFlag", "Base.KeyRing_EightBall", "Base.KeyRing_Panther", "Base.KeyRing_Sexy",  },
    veteran = { "Base.KeyRing_EagleFlag",  },
}

-- TODO: move all the trait/profession definition stuff to some table because modding etc; will probably do in MainCreationMethod however.
function SpawnItems.GenerateSpecialKeyRing(playerObj, keyRings)

    for i=0, playerObj:getTraits():size() - 1 do
        local trait = TraitFactory.getTrait(playerObj:getTraits():get(i));
        if trait and trait:getType() then
            local traitType = trait:getType()
            if SpawnItems.TraitKeyRings[traitType] then
                local entry = SpawnItems.TraitKeyRings[traitType]
                for j=0, #entry - 1 do
                    if entry[j] then
                        table.insert(keyRings, entry[j])
                    end
                end
            end
        end
    end

    if not playerObj:getDescriptor():getProfession() then return end

    -- note that a lot of professions would already have their key rings applied above via the traits that the profession gives
    local profession = playerObj:getDescriptor():getProfession()
    if SpawnItems.ProfessionKeyRings[profession] then
        local entry = SpawnItems.ProfessionKeyRings[profession]
        for j=0, #entry - 1 do
            if entry[j] then
                table.insert(keyRings, entry[j])
            end
        end
    end

    return keyRings
end

function SpawnItems.OnGameStart()
	-- temp, need to remove this & option when everyone got it basically...
	if not getCore():gotNewBelt() then
		local playerObj = getSpecificPlayer(0);
		local belt = playerObj:getInventory():AddItem("Base.Belt2");
		playerObj:setWornItem(belt:getBodyLocation(), belt);
		getCore():setGotNewBelt(true);
		getCore():saveOptions();
		local hotbar = getPlayerHotbar(0);
		if hotbar then
			hotbar:refresh();
		end;
	end;
end

-------------------------------------------------
-------------------------------------------------
Events.OnNewGame.Add(SpawnItems.OnNewGame);
Events.OnGameStart.Add(SpawnItems.onNewGame);
-------------------------------------------------
-------------------------------------------------