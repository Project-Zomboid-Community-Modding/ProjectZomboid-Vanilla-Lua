local SpawnItems = {};

-- this is an explicit % chance, ie 1% at default, no funny business or complexity beyond that
SpawnItems.SpecialKeyRingChance = 1

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
	local dogTag = playerObj:getInventory():getFirstTagRecurse(ItemTag.DOG_TAG) or playerObj:getInventory():getFirstTypeRecurse("Necklace_DogTag");
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
    if playerObj:hasTrait(CharacterTrait.SPEED_DEMON) and ZombRand(100) < SpawnItems.SpecialKeyRingChance then
	   local ticket = playerObj:getInventory():AddItem("Base.SpeedingTicket")
	    ticket:nameAfterDescriptor(playerObj:getDescriptor())
    end
    if playerObj:getDescriptor():getCharacterProfession() then
        local survivorDescription = playerObj:getDescriptor()
	    -- add a badge if a character has a suitable profession
        if survivorDescription:isCharacterProfession(CharacterProfession.PARK_RANGER) or survivorDescription:isCharacterProfession(CharacterProfession.POLICE_OFFICER) or survivorDescription:isCharacterProfession(CharacterProfession.FIRE_OFFICER) then
	        local badge = playerObj:getInventory():AddItem("Base.Badge")
	        badge:nameAfterDescriptor(playerObj:getDescriptor())
        end
	    -- add a pager if a character is a doctor
        if survivorDescription:isCharacterProfession(CharacterProfession.DOCTOR) then
	        playerObj:getInventory():AddItem("Base.Pager");
        end
    end
    local keyRings = {  }
    if ZombRand(100) < SpawnItems.SpecialKeyRingChance then
        SpawnItems.GenerateSpecialKeyRing(playerObj, keyRings)
    end
    if #keyRings < 1 then table.insert(keyRings, ItemKey.Container.KEY_RING) end
    local keyRing = keyRings[ZombRand(#keyRings)+1]
	playerObj:createKeyRing(keyRing)

	addTestFishingStuff(playerObj)
    addRanchStuff(playerObj)
    addBunkerStuff(playerObj)
end

SpawnItems.TraitKeyRings = {
    [CharacterTrait.ADRENALINE_JUNKIE] = { ItemKey.Container.KEY_RING_EIGHT_BALL, ItemKey.Container.KEY_RING_PANTHER, },
    [CharacterTrait.AXEMAN] = { ItemKey.Container.KEY_RING_PINE_TREE, },
    [CharacterTrait.BRAVE] = { ItemKey.Container.KEY_RING_PANTHER, },
    [CharacterTrait.BRAWLER] = { ItemKey.Container.KEY_RING_EIGHT_BALL, ItemKey.Container.KEY_RING_PANTHER, },
    [CharacterTrait.BURGLAR] = { ItemKey.Container.KEY_RING_EIGHT_BALL, ItemKey.Container.KEY_RING_PANTHER, },
    [CharacterTrait.COOK] = { ItemKey.Container.KEY_RING_HOTDOG, },
    [CharacterTrait.COOK2] = { ItemKey.Container.KEY_RING_HOTDOG, },
    [CharacterTrait.DESENSITIZED] = { ItemKey.Container.KEY_RING_PANTHER, },
    [CharacterTrait.DEXTROUS] = { ItemKey.Container.KEY_RING_KITTY, },
    [CharacterTrait.FISHING] = { ItemKey.Container.KEY_RING_BASS, },
    [CharacterTrait.GARDENER] = { ItemKey.Container.KEY_RING_BUG, },
    [CharacterTrait.GRACEFUL] = { ItemKey.Container.KEY_RING_KITTY, },
    [CharacterTrait.HEARTY_APPETITE] = { ItemKey.Container.KEY_RING_HOTDOG, },
    [CharacterTrait.HERBALIST] = { ItemKey.Container.KEY_RING_PINE_TREE, },
    [CharacterTrait.HERBALIST_PROF] = { ItemKey.Container.KEY_RING_PINE_TREE, },
    [CharacterTrait.HIKER] = { ItemKey.Container.KEY_RING_PINE_TREE, },
    [CharacterTrait.HUNTER] = { ItemKey.Container.KEY_RING_PINE_TREE, },
    [CharacterTrait.IRON_GUT] = { ItemKey.Container.KEY_RING_HOTDOG, },
    [CharacterTrait.MECHANICS] = { ItemKey.Container.KEY_RING_EAGLE_FLAG, ItemKey.Container.KEY_RING_EIGHT_BALL, ItemKey.Container.KEY_RING_PANTHER, ItemKey.Container.KEY_RING_SEXY, },
    [CharacterTrait.NIGHT_VISION] = { ItemKey.Container.KEY_RING_KITTY, },
    [CharacterTrait.OUTDOORSMAN] = { ItemKey.Container.KEY_RING_PINE_TREE, },
    [CharacterTrait.SCOUT] = { ItemKey.Container.KEY_RING_PINE_TREE, },
    [CharacterTrait.SMOKER] = { ItemKey.Container.KEY_RING_EIGHT_BALL, ItemKey.Container.KEY_RING_PANTHER,ItemKey.Container.KEY_RING_SEXY, },
    [CharacterTrait.SPEED_DEMON] = { ItemKey.Container.KEY_RING_EAGLE_FLAG, ItemKey.Container.KEY_RING_EIGHT_BALL, ItemKey.Container.KEY_RING_PANTHER, ItemKey.Container.KEY_RING_SEXY, },
    [CharacterTrait.THICK_SKINNED] = { ItemKey.Container.KEY_RING_PANTHER, },
    [CharacterTrait.WEAK_STOMACH] = { ItemKey.Container.KEY_RING_STINKY_FACE, },
    [CharacterTrait.WILDERNESS_KNOWLEDGE] = { ItemKey.Container.KEY_RING_PINE_TREE, },
}

-- note that a lot of professions would already have their key rings applied above via the traits that the profession gives
SpawnItems.ProfessionKeyRings = {
    [CharacterProfession.BURGER_FLIPPER] = { ItemKey.Container.KEY_RING_SPIFFOS, },
    [CharacterProfession.CARPENTER] = { ItemKey.Container.KEY_RING_EAGLE_FLAG, ItemKey.Container.KEY_RING_PINE_TREE, },
    [CharacterProfession.CONSTRUCTION_WORKER] = { ItemKey.Container.KEY_RING_EAGLE_FLAG,  },
    [CharacterProfession.ELECTRICIAN] = { ItemKey.Container.KEY_RING_EAGLE_FLAG,  },
    [CharacterProfession.ENGINEER] = { ItemKey.Container.KEY_RING_EAGLE_FLAG,  },
    [CharacterProfession.FARMER] = { ItemKey.Container.KEY_RING_EAGLE_FLAG,  },
    [CharacterProfession.FIRE_OFFICER] = { ItemKey.Container.KEY_RING_EAGLE_FLAG,  },
    [CharacterProfession.FISHERMAN] = { ItemKey.Container.KEY_RING_BASS, },
    [CharacterProfession.MECHANICS] = { ItemKey.Container.KEY_RING_EAGLE_FLAG, ItemKey.Container.KEY_RING_PANTHER,  },
    [CharacterProfession.METALWORKER] = { ItemKey.Container.KEY_RING_EAGLE_FLAG, ItemKey.Container.KEY_RING_PANTHER,  },
    [CharacterProfession.NURSE] = { ItemKey.Container.KEY_RING_KITTY, ItemKey.Container.KEY_RING_RAINBOW_STAR,  },
    [CharacterProfession.PARK_RANGER] = { ItemKey.Container.KEY_RING_PINE_TREE, },
    [CharacterProfession.POLICE_OFFICER] = { ItemKey.Container.KEY_RING_EAGLE_FLAG,  },
    [CharacterProfession.REPAIRMAN] = { ItemKey.Container.KEY_RING_EAGLE_FLAG, ItemKey.Container.KEY_RING_EIGHT_BALL, ItemKey.Container.KEY_RING_PANTHER, ItemKey.Container.KEY_RING_SEXY,  },
    [CharacterProfession.VETERAN] = { ItemKey.Container.KEY_RING_EAGLE_FLAG,  },
}

function SpawnItems.GenerateSpecialKeyRing(playerObj, keyRings)
    for i=0, playerObj:getCharacterTraits():getKnownTraits():size() - 1 do
        local trait = CharacterTraitDefinition.getCharacterTraitDefinition(playerObj:getCharacterTraits():getKnownTraits():get(i));
        if trait and trait:getType() then
            if SpawnItems.TraitKeyRings[trait:getType()] then
                for i,entry in ipairs(SpawnItems.TraitKeyRings[trait:getType()]) do
                    table.insert(keyRings, entry)
                end
            end
        end
    end

    if not playerObj:getDescriptor():getCharacterProfession() then return end

    if SpawnItems.ProfessionKeyRings[playerObj:getDescriptor():getCharacterProfession()] then
        for i,entry in ipairs(SpawnItems.ProfessionKeyRings[playerObj:getDescriptor():getCharacterProfession()]) do
            table.insert(keyRings, entry)
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

Events.OnNewGame.Add(SpawnItems.OnNewGame);
Events.OnGameStart.Add(SpawnItems.onNewGame);
