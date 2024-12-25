--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

local events = {}
events.VERSION = 1

table.insert(events, { id = "ClimbThroughWindow", intensity = 30.0, duration = 30000 })
table.insert(events, { id = "ClimbWall", intensity = 30.0, duration = 30000 })
table.insert(events, { id = "DoorClose", intensity = -10.0, duration = 30000, multiple = false })
table.insert(events, { id = "DoorOpen", intensity = -10.0, duration = 30000, multiple = false })
--table.insert(events, { id = "EnterBuilding", intensity = -40.0, duration = 60000 })
--table.insert(events, { id = "ExitBuilding", intensity = 30.0, duration = 30000 })
table.insert(events, { id = "InsideBuilding", intensity = -40.0, duration = -1, multiple = false })
table.insert(events, { id = "HopFence", intensity = 10.0, duration = 30000 })
-- SearchNewContainer: Some containers are set to explored when first loaded (ones with overlays).
table.insert(events, { id = "SearchNewContainer", intensity = -10.0, duration = 30000 })
-- SeeUnexploredRoom: Currently the entire building is flagged "explored" when the first room is spotted.
table.insert(events, { id = "SeeUnexploredRoom", intensity = -30.0, duration = 60000 })
table.insert(events, { id = "VehicleCrash", intensity = 30.0, duration = 30000 })
table.insert(events, { id = "VehicleEnter", intensity = 50.0, duration = 120000 })
-- table.insert(events, { id = "VehicleExit", intensity = -10.0, duration = 30000 })
table.insert(events, { id = "VehicleHitCharacter", intensity = 30.0, duration = 30000 })
table.insert(events, { id = "VehicleHitObject", intensity = 30.0, duration = 30000 })
table.insert(events, { id = "VehicleHorn", intensity = 20.0, duration = 30000 })
table.insert(events, { id = "VehicleTireExplode", intensity = 30.0, duration = 30000 })

table.insert(events, { id = "WindowClose", intensity = 10.0, duration = 30000 })
table.insert(events, { id = "WindowOpen", intensity = 10.0, duration = 30000 })

table.insert(events, { id = "AlarmNearby", intensity = 20.0, duration = 30000, multiple = false })
table.insert(events, { id = "HealthPanel_SeeBite", intensity = 20.0, duration = 30000, multiple = false })
table.insert(events, { id = "HelicopterOverhead", intensity = 20.0, duration = 30000, multiple = false })
table.insert(events, { id = "RangedWeaponFailedToShoot", intensity = 20.0, duration = 30000, multiple = false })
table.insert(events, { id = "VehicleFailsToStartWithZombiesTargeting", intensity = 20.0, duration = 30000, multiple = false })
table.insert(events, { id = "VehicleStartsWithZombiesTargeting", intensity = -20.0, duration = 30000, multiple = false })
table.insert(events, { id = "WeaponBreaksDuringCombat", intensity = 20.0, duration = 30000, multiple = false })
table.insert(events, { id = "ZombieEntersPlayerBuilding", intensity = 20.0, duration = 30000, multiple = false })

MusicIntensityConfig.getInstance():initEvents(events)
