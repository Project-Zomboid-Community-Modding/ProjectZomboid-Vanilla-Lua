if debugScenarios == nil then
    debugScenarios = {}
end

local PLAYMODE = false -- false is testing mode (no save, no initial zombies)

local addTableItem = function(square, table, item, x, y)
    return square:AddWorldInventoryItem(instanceItem(item), x, y, table:getSurfaceOffsetNoTable() / 96)
end

local getTable = function(square)
    for i=0, square:getObjects():size() -1 do
        local o = square:getObjects():get(i)
        if o:getProperties():isTable() then
            return o
        end
    end
end

local lastSpawn = 0
local Booths = {
    { -- 1 
        y = 5440,
        speed = 3,
        range = 12,
        count = 1,
        doTable1 = function()
            local sq = getCell():getGridSquare(13278, 5439, 0)
            local tbl = getTable(sq)
            --addTableItem(sq, tbl, "Base.ShotgunShellsBox", ZombRand(0.2, 0.3), ZombRand(0.2, 0.3))
            --addTableItem(sq, tbl, "Base.ShotgunShellsBox", ZombRand(0.2, 0.3), ZombRand(0.4, 0.5))
            --addTableItem(sq, tbl, "Base.ShotgunShellsBox", ZombRand(0.2, 0.3), ZombRand(0.6, 0.7))

            --addTableItem(sq, tbl, "Base.ShotgunShellsBox", ZombRand(0.4, 0.5), ZombRand(0.2, 0.3))
            --addTableItem(sq, tbl, "Base.ShotgunShellsBox", ZombRand(0.4, 0.5), ZombRand(0.4, 0.5))
            --addTableItem(sq, tbl, "Base.ShotgunShellsBox", ZombRand(0.4, 0.5), ZombRand(0.6, 0.7))
            local wpn = addTableItem(sq, tbl, "Base.ShotgunSawnoff", 0.5, 0.6)
            wpn:setCurrentAmmoCount(0)
            wpn:setWorldZRotation(0)

            wpn = addTableItem(sq, tbl, "Base.DoubleBarrelShotgunSawnoff", 0.4, 0.3)
            wpn:setCurrentAmmoCount(0)
            wpn:setWorldZRotation(0)
            
        end,
        doTable2 = function()
            local sq = getCell():getGridSquare(13279, 5439, 0)
            local tbl = getTable(sq)
            local wpn = addTableItem(sq, tbl, "Base.Shotgun", 0.2, 0.7)
            wpn:setCurrentAmmoCount(0)
            wpn:setWorldZRotation(0)

            wpn = addTableItem(sq, tbl, "Base.DoubleBarrelShotgun", 0.2, 0.3)
            wpn:setCurrentAmmoCount(0)
            wpn:setWorldZRotation(0)

        end
    },
    { -- 2 
        y = 5443,
        speed = 2,
        range = 12,
        count = 1,
        doTable1 = function()
            local sq = getCell():getGridSquare(13278, 5440, 0)
            local tbl = getTable(sq)

            local bag = addTableItem(sq, tbl, "Base.Bag_DuffelBagTINT", 0.5, 0.5)
            bag:getVisual():setTint(ImmutableColor.new(0.25, 0.36, 0.36, 1));
            bag:getInventory():AddItem("Base.9mmClip"):setCurrentAmmoCount(15)
            bag:getInventory():AddItem("Base.9mmClip"):setCurrentAmmoCount(15)
            bag:getInventory():AddItem("Base.9mmClip"):setCurrentAmmoCount(15)
            bag:getInventory():AddItem("Base.9mmClip"):setCurrentAmmoCount(15)
            bag:getInventory():AddItem("Base.45Clip"):setCurrentAmmoCount(7)
            bag:getInventory():AddItem("Base.45Clip"):setCurrentAmmoCount(7)
            bag:getInventory():AddItem("Base.45Clip"):setCurrentAmmoCount(7)
            bag:getInventory():AddItem("Base.45Clip"):setCurrentAmmoCount(7)
            bag:getInventory():AddItem("Base.44Clip"):setCurrentAmmoCount(8)
            bag:getInventory():AddItem("Base.44Clip"):setCurrentAmmoCount(8)
            bag:getInventory():AddItem("Base.44Clip"):setCurrentAmmoCount(8)
            bag:getInventory():AddItem("Base.44Clip"):setCurrentAmmoCount(8)

            bag:getInventory():AddItem("Base.Bullets9mmBox")
            bag:getInventory():AddItem("Base.Bullets9mmBox")
            bag:getInventory():AddItem("Base.Bullets38Box")
            bag:getInventory():AddItem("Base.Bullets38Box")
            bag:getInventory():AddItem("Base.Bullets44Box")
            bag:getInventory():AddItem("Base.Bullets44Box")
            bag:getInventory():AddItem("Base.Bullets45Box")
            bag:getInventory():AddItem("Base.Bullets45Box")

        end,
        doTable2 = function()
            local sq = getCell():getGridSquare(13279, 5440, 0)
            local tbl = getTable(sq)
            local wpn = addTableItem(sq, tbl, "Base.Pistol", 0.7, 0.8)
            wpn:setContainsClip(true);
            wpn:setCurrentAmmoCount(15)
            wpn:setWorldZRotation(0)
            wpn = addTableItem(sq, tbl, "Base.Pistol2", 0.7, 0.5)
            wpn:setContainsClip(true);
            wpn:setCurrentAmmoCount(7)
            wpn:setWorldZRotation(0)
            wpn = addTableItem(sq, tbl, "Base.Pistol3", 0.7, 0.3)
            wpn:setContainsClip(true);
            wpn:setCurrentAmmoCount(8)
            wpn:setWorldZRotation(0)

            wpn = addTableItem(sq, tbl, "Base.Revolver", 0.3, 0.8)
            wpn:setCurrentAmmoCount(6)
            wpn:setWorldZRotation(0)
            wpn = addTableItem(sq, tbl, "Base.Revolver_Long", 0.3, 0.5)
            wpn:setCurrentAmmoCount(6)
            wpn:setWorldZRotation(0)
            wpn = addTableItem(sq, tbl, "Base.Revolver_Short", 0.3, 0.3)
            wpn:setCurrentAmmoCount(6)
            wpn:setWorldZRotation(0)
            
        end
    },
    { -- 3 
        y = 5446,
        speed = 1,
        range = 15,
        count = 1,
        doTable1 = function()
            local sq = getCell():getGridSquare(13278, 5445, 0)
            local tbl = getTable(sq)
        end,
        doTable2 = function()
            local sq = getCell():getGridSquare(13279, 5445, 0)
            local tbl = getTable(sq)
        end
    },
    { -- 4 
        y = 5449,
        speed = 2,
        range = 20,
        count = 3,
        doTable1 = function()
            local sq = getCell():getGridSquare(13278, 5446, 0)
            local tbl = getTable(sq)
        end,
        doTable2 = function()
            local sq = getCell():getGridSquare(13279, 5446, 0)
            local tbl = getTable(sq)
            
        end
    },
    { -- 5 
        y = 5452,
        speed = 2,
        range = 25,
        count = 2,
        doTable1 = function()
            local sq = getCell():getGridSquare(13278, 5451, 0)
            local tbl = getTable(sq)
            addTableItem(sq, tbl, "Base.M14Clip", 0.3, 0.3):setCurrentAmmoCount(20)
            addTableItem(sq, tbl, "Base.M14Clip", 0.5, 0.3):setCurrentAmmoCount(20)
            addTableItem(sq, tbl, "Base.M14Clip", 0.7, 0.3):setCurrentAmmoCount(20)

            addTableItem(sq, tbl, "Base.556Clip", 0.3, 0.8):setCurrentAmmoCount(30)
            addTableItem(sq, tbl, "Base.556Clip", 0.5, 0.8):setCurrentAmmoCount(30)
            addTableItem(sq, tbl, "Base.556Clip", 0.7, 0.8):setCurrentAmmoCount(30)
        end,
        doTable2 = function()
            local sq = getCell():getGridSquare(13279, 5451, 0)
            local tbl = getTable(sq)
            local wpn = addTableItem(sq, tbl, "Base.AssaultRifle2", 0.5, 0.3)
            wpn:setContainsClip(true);
            wpn:setCurrentAmmoCount(20)
            wpn:setWorldZRotation(0)

            wpn = addTableItem(sq, tbl, "Base.AssaultRifle", 0.5, 0.8)
            wpn:setContainsClip(true);
            wpn:setCurrentAmmoCount(30)
            wpn:setWorldZRotation(0)

        end
    },
    { -- 6
        y = 5455,
        speed = 4,
        range = 30,
        count = 1,
        doTable1 = function()
            local sq = getCell():getGridSquare(13278, 5454, 0)
            local tbl = getTable(sq)

        end,
        doTable2 = function()
            local sq = getCell():getGridSquare(13279, 5454, 0)
            local tbl = getTable(sq)
            local wpn = addTableItem(sq, tbl, "Base.HuntingRifle", 0.2, 0.3)
            wpn:setCurrentAmmoCount(0)
            wpn:setWorldZRotation(0)
            wpn = addTableItem(sq, tbl, "Base.VarmintRifle", 0.2, 0.7)
            wpn:setCurrentAmmoCount(0)
            wpn:setWorldZRotation(0)
        end
    }
}

debugScenarios.FenrisScenario = {
    name = "Fen's Range Day",
    startLoc = {x=13270, y=5443, z=0 },
    setSandbox = function()
        --getCore():setNoSave(not PLAYMODE);
        SandboxVars.Speed = 3;
        SandboxVars.Zombies = 1; -- 6 = no zombies, 1 = insane (then 2 = low, 3 normal, 4 high..)
        SandboxVars.Distribution = 1;
        SandboxVars.Survivors = 1;
        SandboxVars.DayLength = 3;
        SandboxVars.StartYear = 1;
        SandboxVars.StartMonth = 7;
        SandboxVars.StartDay = 9;
        SandboxVars.StartTime = 2;
        SandboxVars.VehicleEasyUse = true;
        SandboxVars.WaterShutModifier = 14;
        SandboxVars.ElecShutModifier = 14;
        SandboxVars.WaterShut = 2;
        SandboxVars.ElecShut = 2;
--         SandboxVars.FoodLoot = 2;
--         SandboxVars.WeaponLoot = 2;
--         SandboxVars.OtherLoot = 2;
        SandboxVars.LootItemRemovalList = "";
        SandboxVars.Temperature = 3;
        SandboxVars.Rain = 3;
        SandboxVars.ErosionSpeed = 3;
        SandboxVars.StatsDecrease = 3;
        SandboxVars.NatureAbundance = 3;
        SandboxVars.Alarm = 4;
        SandboxVars.LockedHouses = 6;
        SandboxVars.FoodRotSpeed = 3;
        SandboxVars.FridgeFactor = 3;
        SandboxVars.Farming = 3;
        SandboxVars.LootRespawn = 1;
        SandboxVars.StarterKit = false;
        SandboxVars.Nutrition = true;
        SandboxVars.TimeSinceApo = 1;
        SandboxVars.PlantResilience = 3;
        SandboxVars.PlantAbundance = 3;
        SandboxVars.EndRegen = 3;
        SandboxVars.CarSpawnRate = 3;
        SandboxVars.LockedCar = 3;
        SandboxVars.CarAlarm = 2;
        SandboxVars.ChanceHasGas = 1;
        SandboxVars.InitialGas = 2;
        SandboxVars.CarGeneralCondition = 1;
        SandboxVars.RecentlySurvivorVehicles = 2;
        SandboxVars.VehicleStoryChance = 1;

        SandboxVars.MultiplierConfig = {
            XPMultiplierGlobal = 1,
            XPMultiplierGlobalToggle = true,
        }

        SandboxVars.ZombieLore = {
            Speed = 2,
            Strength = 2,
            Toughness = 2,
            Transmission = 1,
            Mortality = 5,
            Reanimate = 3,
            Cognition = 3,
            Memory = 2,
            Sight = 3,
            Hearing = 3,
            ThumpNoChasing = 0,
        }
    end,
    onStart = function()
        local player = getPlayer();

        -- set climate if in testing mode, otherwise let nature take its course
        if not PLAYMODE then
            local clim = getClimateManager();
            local w = clim:getWeatherPeriod();
            if w:isRunning() then
                clim:stopWeatherAndThunder();
            end

            -- remove fog
            w = clim:getClimateFloat(5);
            w:setEnableOverride(true);
            w:setOverride(0, 1);
        end

        -- setup fenris
        do
            local desc = player:getDescriptor();
            local visual = player:getHumanVisual();
            local inv = player:getInventory();
            player:getTraits():add("Organized")
            desc:setVoicePrefix("VoiceMale");
            desc:setVoiceType(0);
            desc:setVoicePitch(0);

            player:setFemale(false);
            desc:setFemale(false);
            desc:setForename("Fenris");
            desc:setSurname("Wolf");
            -- reset
            player:clearWornItems();
            inv:clear();

            visual:setBeardModel("Goatee");
            visual:setHairModel("Metal");

            local immutableColor = ImmutableColor.new(0.40, 0.32, 0.0, 1)
            visual:setHairColor(immutableColor)
            visual:setBeardColor(immutableColor)
            visual:setSkinTextureIndex(2);
            player:resetModel();

            local items = {
                "Glasses_Aviators",
                "JacketLong_Black",
                "Gloves_FingerlessLeatherGloves",
                "Tshirt_IndieStoneDECAL",
                "Trousers_CamoUrban",
                "WristWatch_Right_ClassicMilitary",
                "Shoes_ArmyBoots",
                "Socks_Ankle_White",
                "Belt2"
            }

            for _, value in pairs(items) do
                local item = inv:AddItem("Base." .. value)
                player:setWornItem(item:getBodyLocation(), item);
            end

            local wpn = inv:AddItem("Base.AssaultRifle")
            wpn:attachWeaponPart(instanceItem("Base.RedDot") , true)
            wpn:attachWeaponPart(instanceItem("Base.Sling") , true)
            wpn:setContainsClip(true)
            wpn:setCurrentAmmoCount(30)
            wpn:setAttachedSlot(1);
            player:setAttachedItem("Rifle On Back", wpn);
            wpn:setAttachedToModel("Rifle On Back");
            wpn:setAttachedSlotType("Back");

            local holster = inv:AddItem("Base.HolsterShoulder")
            player:setWornItem(holster:getBodyLocation(), holster);

            wpn = inv:AddItem("Base.Pistol2")
            player:setAttachedItem("Holster Shoulder", wpn);
            wpn:setAttachedSlot(4);
            wpn:setAttachedSlotType("HolsterShoulder");
            wpn:setAttachedToModel("Holster Shoulder");
            wpn:setContainsClip(true);
            wpn:setCurrentAmmoCount(7);

            holster:getInventory():AddItem("Base.45Clip"):setCurrentAmmoCount(7)
            holster:getInventory():AddItem("Base.45Clip"):setCurrentAmmoCount(7)
            inv:AddItem("Base.45Clip"):setCurrentAmmoCount(7)
            inv:AddItem("Base.45Clip"):setCurrentAmmoCount(7)
            inv:AddItem("Base.45Clip"):setCurrentAmmoCount(7)
            inv:AddItem("Base.HuntingKnife")
        end

        -- setup the car
        do
            local car = addVehicleDebug("Base.SUV", IsoDirections.N, nil, getCell():getGridSquare(13270, 5439, 0));

            car:setColorHSV(0.41, 0.50, 0.30);
            --car:setColorHSV(0.6, 0.9, 0.2);
            player:getInventory():AddItem(car:createVehicleKey());
            car:getPartById("GasTank"):setInventoryItem(instanceItem("Base.BigGasTank2"))
            car:getPartById("Muffler"):setInventoryItem(instanceItem("Base.ModernCarMuffler2"))
            car:getPartById("BrakeFrontLeft"):setInventoryItem(instanceItem("Base.ModernBrake2"))
            car:getPartById("BrakeFrontRight"):setInventoryItem(instanceItem("Base.ModernBrake2"))
            car:getPartById("BrakeRearLeft"):setInventoryItem(instanceItem("Base.ModernBrake2"))
            car:getPartById("BrakeRearRight"):setInventoryItem(instanceItem("Base.ModernBrake2"))
            car:getPartById("SuspensionFrontLeft"):setInventoryItem(instanceItem("Base.ModernSuspension2"))
            car:getPartById("SuspensionFrontRight"):setInventoryItem(instanceItem("Base.ModernSuspension2"))
            car:getPartById("SuspensionRearLeft"):setInventoryItem(instanceItem("Base.ModernSuspension2"))
            car:getPartById("SuspensionRearRight"):setInventoryItem(instanceItem("Base.ModernSuspension2"))
            car:repair();
            
            local part = car:getPartById("GloveBox"):getItemContainer()
            part:clear()
            part:AddItem("Base.HandTorch")
            part:AddItem("Base.CanteenMilitary")
            part:AddItem("Base.Holster")
            part:AddItem("Base.9mmClip"):setCurrentAmmoCount(15)
            part:AddItem("Base.9mmClip"):setCurrentAmmoCount(15)
            local wpn = part:AddItem("Base.Pistol")
            wpn:attachWeaponPart(instanceItem("Base.GunLight"), true)
            wpn:setContainsClip(true)
            wpn:setCurrentAmmoCount(15)

            part = car:getPartById("SeatFrontLeft"):getItemContainer()
            part:clear()
            
            part = car:getPartById("SeatFrontRight"):getItemContainer()
            part:clear()
            local wpn = part:AddItem("Base.Shotgun")
            wpn:attachWeaponPart(instanceItem("Base.Sling") , true)
            wpn:attachWeaponPart(instanceItem("Base.RecoilPad") , true)
            wpn:setCurrentAmmoCount(6)
            part:AddItems("Base.ShotgunShellsBox", 3)

            part = car:getPartById("SeatRearLeft"):getItemContainer()
            part:clear()
            part = car:getPartById("SeatRearRight"):getItemContainer()
            part:clear()

            local bag = part:AddItem("Base.Bag_Military"):getItemContainer()
            for _=0, 6 do
                bag:AddItem("Base.9mmClip"):setCurrentAmmoCount(15)
                bag:AddItem("Base.45Clip"):setCurrentAmmoCount(7)
                bag:AddItem("Base.556Clip"):setCurrentAmmoCount(30)
            end
            bag:AddItems("Base.Bullets44Box", 3)
            wpn = bag:AddItem("Base.Revolver_Long")
            wpn:attachWeaponPart(instanceItem("Base.x2Scope") , true)
            wpn:setCurrentAmmoCount(6)
            bag:AddItem("Base.Screwdriver")
            bag:AddItem("Base.GunLight")

            local trunk = car:getPartById("TruckBed"):getItemContainer()
            trunk:clear()

            bag = trunk:AddItem("Base.Bag_ALICEpack_Army"):getItemContainer()
            bag:AddItem("Base.SleepingBag_Camo_Packed")
            bag:AddItem("Base.TentGreen_Packed")
            bag:AddItem("Base.CanteenMilitary")
            bag:AddItem("Base.EntrenchingTool")
            bag:AddItem("Base.HuntingKnife")
            bag:AddItem("Base.HandAxe")
            bag:AddItem("Base.Machete")
            bag:AddItem("Base.Tshirt_CamoUrban")
            bag:AddItem("Base.Trousers_CamoUrban")

            bag = trunk:AddItem("Base.Bag_ProtectiveCaseBulkyAmmo"):getItemContainer()
            bag:AddItems("Base.Bullets9mmBox", 4)
            bag:AddItems("Base.Bullets45Box", 4)
            bag:AddItems("Base.556Box", 4)
            bag:AddItems("Base.ShotgunShellsBox", 4)
            bag:AddItems("Base.223Box", 1)
            bag:AddItems("Base.308Box", 2)

            bag = trunk:AddItem("Base.Bag_Satchel_Military"):getItemContainer()
            bag:AddItems("AlcoholWipes", 3)
            bag:AddItems("Bandage", 3)
            bag:AddItems("Pills", 3)
            bag:AddItems("PillsBeta", 3)
            bag:AddItems("SutureNeedle", 3)
            bag:AddItem("PenLight")
            bag:AddItem("Scalpel")
            bag:AddItem("Tweezers")
            bag:AddItem("SutureNeedleHolder")

            bag = trunk:AddItem("Base.Bag_RifleCase"):getItemContainer()
            bag:AddItem("Base.556Clip"):setCurrentAmmoCount(30)
            bag:AddItem("Base.556Clip"):setCurrentAmmoCount(30)
            bag:AddItem("Base.556Clip"):setCurrentAmmoCount(30)
            wpn = bag:AddItem("Base.AssaultRifle")
            wpn:attachWeaponPart(instanceItem("Base.RedDot"), true)
            wpn:attachWeaponPart(instanceItem("Base.Sling"), true)
            wpn:setContainsClip(true)
            wpn:setCurrentAmmoCount(30)

            bag = trunk:AddItem("Base.Bag_RifleCase"):getItemContainer()
            wpn = bag:AddItem("Base.HuntingRifle")
            wpn:attachWeaponPart(instanceItem("Base.Sling"), true)
            wpn:attachWeaponPart(instanceItem("Base.RecoilPad"), true)
            wpn:attachWeaponPart(instanceItem("Base.x8Scope"), true)
            wpn:attachWeaponPart(instanceItem("Base.FiberglassStock"), true)

            wpn = bag:AddItem("Base.VarmintRifle")
            wpn:attachWeaponPart(instanceItem("Base.Sling"), true)
            wpn:attachWeaponPart(instanceItem("Base.RecoilPad"), true)
            wpn:attachWeaponPart(instanceItem("Base.x4Scope"), true)
            wpn:attachWeaponPart(instanceItem("Base.FiberglassStock"), true)

            bag = trunk:AddItem("Base.Bag_Military"):getItemContainer()
            bag:AddItems("Base.P38", 2)
            bag:AddItems("Base.Cereal", 2)
            bag:AddItems("Base.CannedBolognese", 12)
            bag:AddItems("Base.CannedChili", 12)
            bag:AddItem("Base.CanteenMilitary")
        end

        -- add all items to booth tables
        for _, b in pairs(Booths) do
            b.doTable1()
            b.doTable2()
        end

        player:getInventory():setDrawDirty(true)
        player:setGodMod(false)
        player:setGhostMode(false)
        player:setInvisible(false)

        if PLAYMODE then
            Events.OnTick.Add(debugScenarios.FenrisScenario.removeInitialZ)
        else
            Events.OnPlayerUpdate.Add(debugScenarios.FenrisScenario.playerUpdate)
        end
    end,
    removeInitialZ = function() 
        local player = getPlayer()
        local zombies = getCell():getObjectList()
        for i=zombies:size(),1,-1 do
            local zombie = zombies:get(i-1)
            if instanceof(zombie, "IsoZombie") and player:DistTo(zombie) < 100 then
                zombie:removeFromWorld()
                zombie:removeFromSquare()
            end
        end
        Events.OnTick.Remove(debugScenarios.FenrisScenario.removeInitialZ)
    end,
    playerUpdate = function(player)
        local x = math.floor(player:getX())
        local y = math.floor(player:getY())
        if x < 13276 or x > 13280  then return end
        if y < 5437 or y > 5454 then return end

        -- booth area
        local booth = Booths[1]
        for _, b in pairs(Booths) do
            if y < b.y then
                booth = b
                break
            end
        end
        local color = x == 13280 and getCore():getGoodHighlitedColor() or getCore():getBadHighlitedColor()

        getCell():getGridSquare(13280, booth.y -1, 0):getFloor():setHighlightColor(color)
        getCell():getGridSquare(13280, booth.y -1, 0):getFloor():setHighlighted(true)
        getCell():getGridSquare(13280, booth.y -2, 0):getFloor():setHighlightColor(color)
        getCell():getGridSquare(13280, booth.y -2, 0):getFloor():setHighlighted(true)
        getCell():getGridSquare(13280, booth.y -3, 0):getFloor():setHighlightColor(color)
        getCell():getGridSquare(13280, booth.y -3, 0):getFloor():setHighlighted(true)

        if x ~= 13280 then return end
        -- on the firing line
        local time = GameTime.getInstance():getTimeOfDay()
        if time > lastSpawn + (booth.speed or 1)*(1/60) then
            lastSpawn = time
            --GameTime.getInstance().getWorldAgeHours()
            addZombiesInOutfit(x + (booth.range or 10), y, 0, (booth.count or 1), nil, 50);
        end
    end
}
if PLAYMODE then
    debugScenarios.FenrisScenario.setSandbox = nil
end 