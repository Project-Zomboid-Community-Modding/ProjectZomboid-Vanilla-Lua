ProfessionVehicles = {}

ProfessionVehicles.OnCreateRegion = {}

ProfessionVehicles.OnCreateRegion  = function(region, square, direction)
    if region == "General" then return end
    local vList = ProfessionVehicles[region]
    if not vList then return end
    local pick = vList[ZombRand(#vList)+1]
--     print("Pick " .. tostring (pick))
    local unique = false

    for k, v in ipairs(ProfessionVehicles.UniqueVehicles) do
        if v == pick then unique = true end
    end

    if unique then
        mData = ModData.getOrCreate("UniqueVehiclesSpawned")
        if mData[pick] then
            print("Unique vehicle " .. tostring(pick) .. " has been spawned already; not spawning a profession vehicle in this case.")
            return
        end
        mData[pick] = true
    end

    addVehicleDebug(pick, direction, nil, square)
--     return vehicle
end



ProfessionVehicles.Louisville = {
    "Base.StepVan_LouisvilleMotorShop",
    "Base.StepVan_Jorgensen",
    "Base.VanKerrHomes",
    "Base.VanLouisvilleLandscaping",
    "Base.VanMetalheads",
    "Base.VanSeatsAirportShuttle",
--     "Base.VanSeats_Creature",
}
ProfessionVehicles.MarchRidge = {
    "Base.VanTreyBaines",
    "Base.VanJonesFabrication",
    "Base.PickUpVanHeltonMetalWorking",
    "Base.PickUpVanMarchRidgeConstruction",
    "Base.PickUpVanYingsWood",
    "Base.VanSeats_Creature",
}
ProfessionVehicles.Muldraugh = {
    "Base.PickUpVanBrickingIt",
    "Base.PickUpVanWeldingbyCamille",
    "Base.VanJohnMcCoy",
    "Base.VanKorshunovs",
    "Base.VanMicheles",
    "Base.VanSeats_LadyDelighter",
}
ProfessionVehicles.Riverside = {
    "Base.PickUpTruckJPLandscaping",
    "Base.VanGardenGods",
    "Base.PickUpTruckJPLandscaping",
    "Base.VanRiversideFabrication",
    "Base.PickUpVanKimbleKonstruction",
    "Base.VanBrewsterHarbin",
    "Base.VanSeats_Space",
}
ProfessionVehicles.Rosewood = {
    "Base.VanRosewoodworking",
    "Base.VanSchwabSheetMetal",
    "Base.VanPlattAuto",
    "Base.StepVan_CompleteRepairShop",
    "Base.PickUpVanCallowayLandscaping",
    "Base.VanSeats_Prison",
    "Base.VanSeats_Trippy",
}
ProfessionVehicles.WestPoint = {
    "Base.PickUpVanYingsWood",
    "Base.StepVan_RandisPlants",
    "Base.VanBeckmans",
    "Base.VanPennSHam",
    "Base.VanMooreMechanics",
    "Base.VanSeats_Valkyrie",
}
-- the LV airport
ProfessionVehicles.LAA = {
    "Base.PickUpTruckLightsAirport",
    "Base.PickUpTruckLightsAirportSecurity",
    "Base.StepVanAirportCatering",
    "Base.StepVanMail",
    "Base.VanMobileMechanics",
    "Base.VanMeltingPointMetal",
    "Base.VanSeatsAirportShuttle",
}

-- law enforcement vehicles
ProfessionVehicles.CarLightsPolice = {
    Jefferson = { "Base.CarLightsKST", "Base.CarLightsLouisvilleCounty", },
    Louisville = { "Base.CarLightsKST", "Base.CarLightsLouisvilleCounty", "Base.ModernCarLightsCityLouisvillePD", },
    Muldraugh = { "Base.CarLightsKST", "Base.ModernCarLightsMeadeSheriff", "Base.CarLightsMuldraughPolice", },
    Rosewood = { "Base.CarLightsKST", "Base.ModernCarLightsMeadeSheriff", },
    WestPoint= { "Base.CarLightsKST", "Base.ModernCarLightsWestPoint", },
    ValleyStation = { "Base.CarLightsBulletinSheriff", "Base.CarLightsKST", },
    General = { "Base.CarLightsKST", "Base.ModernCarLightsMeadeSheriff", },
    Alternate = { "Base.CarLightsKST", "Base.ModernCarLightsMeadeSheriff", },
    LAA = { "Base.PickUpTruckLightsAirportSecurity","Base.CarLightsKST", "Base.CarLightsLouisvilleCounty", },
}

-- ProfessionVehicles.PickUpTruckLightsAirport = {
--     LAA = { "Base.PickUpTruckLightsAirport", },
-- }
-- ProfessionVehicles.PickUpTruckLightsAirportSecurity = {
--     LAA = { "Base.PickUpTruckLightsAirportSecurity", },
-- }
-- ProfessionVehicles.PickUpTruckLightsFire = {
--     LAA = { "Base.PickUpTruckLightsFire", },
-- }
-- ProfessionVehicles.PickUpVanLightsFire = {
--     LAA = { "Base.PickUpVanLightsFire", },
-- }

ProfessionVehicles.PickUpVanLightsPolice = {
    Jefferson = { "Base.PickUpVanLightsLouisvilleCounty", "Base.PickUpVanLightsStatePolice",   },
    Louisville = { "Base.PickUpVanLightsLouisvilleCounty", "Base.PickUpVanLightsStatePolice", "Base.StepVan_LouisvilleSWAT",  },
    Rosewood = { "Base.PickUpVanLightsStatePolice", "Base.VanSeats_Prison", },
    General = { "Base.PickUpVanLightsStatePolice", },
    Alternate = { "Base.PickUpVanLightsStatePolice", },
    LAA = { "Base.PickUpTruckLightsAirportSecurity","Base.PickUpVanLightsLouisvilleCounty", "Base.PickUpVanLightsStatePolice",   },
}

-- ProfessionVehicles.StepVanAirportCatering = {
--     LAA = { "Base.StepVanAirportCatering", },
-- }

ProfessionVehicles.StepVan_Heralds = {
    Louisville = { "Base.StepVan_Heralds",  },
    Alternate = { "Base.StepVan", },
}

ProfessionVehicles.StepVan_MobileLibrary = {
    Louisville = { "Base.StepVan", },
    LAA = { "Base.StepVan", },
}

-- ProfessionVehicles.StepVanMail = {
--     LAA = { "Base.StepVanMail", },
-- }
ProfessionVehicles.StepVan_SouthEasternHosp = {
    LAA = { "Base.StepVanAirportCatering", },
}
--
-- ProfessionVehicles.VanAmbulance = {
--     LAA = { "Base.VanAmbulance", },
-- }

ProfessionVehicles.VanBuilder = {
    Louisville = { "Base.VanKerrHomes", "Base.VanCoastToCoast", },
    MarchRidge = { "Base.PickUpVanMarchRidgeConstruction", "Base.VanCoastToCoast", },
    Muldraugh = { "Base.PickUpVanBrickingIt", "Base.VanCoastToCoast", },
    Riverside = { "Base.PickUpVanKimbleKonstruction", "Base.VanCoastToCoast", },
    WestPoint = { "Base.VanBeckmans", "Base.VanPennSHam", "Base.VanCoastToCoast", },
    General = { "Base.VanCoastToCoast", "Base.VanCoastToCoast", "Base.VanCoastToCoast", "Base.VanCoastToCoast",
    "Base.PickUpVanKimbleKonstruction", "Base.PickUpVanMarchRidgeConstruction", "Base.VanBeckmans", "Base.VanKerrHomes",},
    Alternate = { "Base.VanCoastToCoast", "Base.VanCoastToCoast", "Base.VanCoastToCoast", "Base.VanCoastToCoast",
    "Base.PickUpVanKimbleKonstruction", "Base.PickUpVanMarchRidgeConstruction", "Base.VanBeckmans", "Base.VanKerrHomes",},
    LAA = { "Base.VanCoastToCoast", },
}

ProfessionVehicles.VanCarpenter = {
    Louisville = { "Base.StepVan_Jorgensen", "Base.PickUpVanLightsKentuckyLumber", },
    MarchRidge = {  "Base.PickUpVanYingsWood","Base.PickUpVanLightsKentuckyLumber", },
    Muldraugh = { "Base.VanJohnMcCoy", "Base.VanMicheles", "Base.PickUpVanLightsKentuckyLumber", },
    Rosewood = { "Base.VanRosewoodworking", "Base.PickUpVanLightsKentuckyLumber", },
    WestPoint = { "Base.VanWPCarpentry", "Base.PickUpVanLightsKentuckyLumber", },
    General = { "Base.PickUpVanLightsKentuckyLumber", "Base.VanRosewoodworking", },
    Alternate = { "Base.PickUpVanLightsKentuckyLumber", "Base.VanRosewoodworking", },
    LAA = { "Base.StepVan_Jorgensen", "Base.PickUpVanLightsKentuckyLumber", },
}
ProfessionVehicles.VanGardener = {
    Louisville = { "Base.VanLouisvilleLandscaping", },
    MarchRidge = { "Base.VanTreyBaines", },
    Riverside = { "Base.PickUpTruckJPLandscaping", "Base.VanGardenGods", },
    Rosewood = { "Base.PickUpVanCallowayLandscaping",},
    WestPoint = { "Base.StepVan_RandisPlants", },
    General = { "Base.VanLouisvilleLandscaping", "Base.VanTreyBaines", },
    Alternate = { "Base.VanLouisvilleLandscaping", "Base.VanTreyBaines", },
    LAA = { "Base.PickUpTruckLightsAirport", },
}
ProfessionVehicles.VanMechanic = {
    Louisville = { "Base.StepVan_LouisvilleMotorShop", "Base.VanMobileMechanics", },
    Muldraugh = { "Base.VanKorshunovs", "Base.VanMobileMechanics",},
    Riverside = { "Base.VanBrewsterHarbin", "Base.VanMobileMechanics",},
    Rosewood = { "Base.StepVan_CompleteRepairShop", "Base.VanPlattAuto", "Base.VanMobileMechanics",},
    WestPoint = { "Base.VanMooreMechanics", "Base.VanMobileMechanics",},
    General = { "Base.VanMobileMechanics", "Base.VanMobileMechanics", "Base.VanMobileMechanics", "Base.VanMobileMechanics", "Base.VanMobileMechanics",
    "Base.StepVan_CompleteRepairShop",  "Base.StepVan_LouisvilleMotorShop", "Base.VanBrewsterHarbin", "Base.VanMooreMechanics", "Base.VanPlattAuto", },
    Alternate = { "Base.VanMobileMechanics", "Base.VanMobileMechanics", "Base.VanMobileMechanics", "Base.VanMobileMechanics", "Base.VanMobileMechanics",
    "Base.StepVan_CompleteRepairShop",  "Base.StepVan_LouisvilleMotorShop", "Base.VanBrewsterHarbin", "Base.VanMooreMechanics", "Base.VanPlattAuto", },
    LAA = { "Base.VanMobileMechanics", },
}
ProfessionVehicles.VanMeltingPointMetal = {
    LAA = { "Base.VanMeltingPointMetal", },
}
ProfessionVehicles.VanMetalworker = {
    Louisville = { "Base.VanMetalheads", "Base.VanMeltingPointMetal", },
    MarchRidge = { "Base.PickUpVanHeltonMetalWorking", "Base.VanJonesFabrication", "Base.VanMeltingPointMetal", },
    Muldraugh = { "Base.PickUpVanWeldingbyCamille", "Base.VanMeltingPointMetal", },
    Riverside = {  "Base.VanRiversideFabrication", "Base.VanMeltingPointMetal", },
    Rosewood = { "Base.VanSchwabSheetMetal", "Base.VanMeltingPointMetal", },
    General = { "Base.VanMeltingPointMetal", "Base.VanMeltingPointMetal", "Base.VanMeltingPointMetal", "Base.VanMeltingPointMetal",
    "Base.PickUpVanHeltonMetalWorking", "Base.VanJonesFabrication", "Base.VanRiversideFabrication", "Base.VanSchwabSheetMetal", },
    Alternate = { "Base.VanMeltingPointMetal", "Base.VanMeltingPointMetal", "Base.VanMeltingPointMetal", "Base.VanMeltingPointMetal",
    "Base.PickUpVanHeltonMetalWorking", "Base.VanJonesFabrication", "Base.VanRiversideFabrication", "Base.VanSchwabSheetMetal", },
    LAA = { "Base.VanMeltingPointMetal", },
}
ProfessionVehicles.PickUpTruck_Camo = {
     Louisville = { "Base.PickUpTruck", },
}
ProfessionVehicles.PickUpVan_Camo = {
     Louisville = { "Base.PickUpVan", },
}
-- ProfessionVehicles.VanSeatsAirportShuttle = {
--     LAA = { "Base.VanSeatsAirportShuttle", },
-- }

-- ProfessionVehicles.All = {
--     LAA = { "Base.PickUpTruckLightsAirport", "Base.PickUpTruckLightsAirportSecurity", "Base.StepVanAirportCatering", "Base.StepVanMail", "Base.VanSeatsAirportShuttle", "Base.VanMobileMechanics", "Base.VanMeltingPointMetal", },
-- }

ProfessionVehicles.VanSeats_Mural = {
--     Louisville = { "Base.VanSeats_Creature", },
    MarchRidge = { "Base.VanSeats_Creature", },
    Muldraugh = { "Base.VanSeats_LadyDelighter", },
    Riverside = {  "Base.VanSeats_Space", },
    Rosewood = { "Base.VanSeats_Trippy", },
    WestPoint = { "Base.VanSeats_Valkyrie", },
    General = { "Base.VanSeats_Creature", "Base.VanSeats_LadyDelighter",  "Base.VanSeats_Space", "Base.VanSeats_Trippy", "Base.VanSeats_Valkyrie", },
    Alternate = { "Base.VanSeats", },
}
ProfessionVehicles.VanMechanic = {
    Louisville = { "Base.StepVan_LouisvilleMotorShop", "Base.VanMobileMechanics", },
    Muldraugh = { "Base.VanKorshunovs", "Base.VanMobileMechanics",},
    Riverside = { "Base.VanBrewsterHarbin", "Base.VanMobileMechanics",},
    Rosewood = { "Base.StepVan_CompleteRepairShop", "Base.VanPlattAuto", "Base.VanMobileMechanics",},
    WestPoint = { "Base.VanMooreMechanics", "Base.VanMobileMechanics",},
    General = { "Base.VanMobileMechanics", "Base.VanMobileMechanics", "Base.VanMobileMechanics", "Base.VanMobileMechanics", "Base.VanMobileMechanics",
    "Base.StepVan_CompleteRepairShop",  "Base.StepVan_LouisvilleMotorShop", "Base.VanBrewsterHarbin", "Base.VanMooreMechanics", "Base.VanPlattAuto", },
    Alternate = { "Base.VanMobileMechanics", "Base.VanMobileMechanics", "Base.VanMobileMechanics", "Base.VanMobileMechanics", "Base.VanMobileMechanics",
    "Base.StepVan_CompleteRepairShop",  "Base.StepVan_LouisvilleMotorShop", "Base.VanBrewsterHarbin", "Base.VanMooreMechanics", "Base.VanPlattAuto", },
    LAA = { "Base.VanMobileMechanics", },
}
ProfessionVehicles.RaceCarBurnt = {
    General = { "Base.RaceCarBurnt", "Base.RaceCar12", "Base.RaceCar34", "Base.RaceCar58", },
    Alternate = { "Base.RaceCarBurnt", },
}


ProfessionVehicles.PickUpVanBuilder = ProfessionVehicles.VanBuilder
ProfessionVehicles.PickUpVanLightsCarpenter = ProfessionVehicles.VanCarpenter
ProfessionVehicles.PickUpVanMetalworker = ProfessionVehicles.VanMetalworker
ProfessionVehicles.StepVan_Mechanic = ProfessionVehicles.VanMechanic

ProfessionVehicles.CheckSwap = function(vehicle)
    if not vehicle then return end
    if vehicle:isCreated() then return end
    local square = vehicle:getSquare()
    if not square then return end
    local region = square:getSquareRegion()
    if not region then region = "General" end
    local scriptName = vehicle:getScript():getName()
    local fullScriptName = vehicle:getScript():getFullName()
    if not scriptName then return end
    local list
    if ProfessionVehicles[scriptName] then
        list = ProfessionVehicles[scriptName][region] or ProfessionVehicles[scriptName].General
--     elseif ProfessionVehicles.All and ProfessionVehicles.All[region] then
--         list = ProfessionVehicles.All[region]
    end
    if not list then return end

    local pick = list[ZombRand(#list)+1]

    if scriptName == pick or fullScriptName == pick then return end

    local unique = false

    for k, v in ipairs(ProfessionVehicles.UniqueVehicles) do
        if v == pick then unique = true end
    end

    if unique then
        mData = ModData.getOrCreate("UniqueVehiclesSpawned")
        if mData[pick] then
            print("Unique vehicle " .. tostring(pick) .. " has been spawned already; not swapping a profession vehicle in this case.")
            if ProfessionVehicles[scriptName].Alternate then
                local list = ProfessionVehicles[scriptName].Alternate
                local pick = list[ZombRand(#list)+1]
                if scriptName == pick or fullScriptName == pick then return end
                vehicle:setScriptName(pick)
                vehicle:scriptReloaded(true)
            end
            return
        end
        mData[pick] = true
    end
--     if pick:contains("VanSeats_") and not pick:contains("Prison") then
--         local player = getPlayer()
--         player:Say(pick .. " spawned!!!")
--         print(pick .. " spawned at " .. tostring(vehicle:getX()) .. ", " .. tostring(vehicle:getY()))
--         player:setX(vehicle:getX())
--         player:setY(vehicle:getY())
--         player:setZ(vehicle:getZ())
--     end

    vehicle:setScriptName(pick)
    vehicle:scriptReloaded(true)
end

ProfessionVehicles.UniqueVehicles = {
    "Base.VanJohnMcCoy",
    "Base.VanMicheles",
    "Base.VanRosewoodworking",
    "Base.PickUpTruckJPLandscaping",
    "Base.VanGardenGods",
    "Base.VanTreyBaines",
    "Base.PickUpVanWeldingbyCamille",
    "Base.VanMetalheads",
    "Base.PickUpVanBrickingIt",
    "Base.VanPennSHam",
    "Base.VanKorshunovs",

    "Base.VanSeats_Creature",
    "Base.VanSeats_LadyDelighter",
    "Base.VanSeats_Space",
    "Base.VanSeats_Trippy",
    "Base.VanSeats_Valkyrie",

    "Base.RaceCar12",
    "Base.RaceCar34",
    "Base.RaceCar58",
}

Events.OnSpawnVehicleStart.Add(ProfessionVehicles.CheckSwap)

local function OnInitGlobalModData(isNewGame)
	if isNewGame then ModData.getOrCreate("UniqueVehiclesSpawned") end
end

Events.OnInitGlobalModData.Add(OnInitGlobalModData)