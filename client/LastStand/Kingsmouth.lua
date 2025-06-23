

Kingsmouth = {}

Kingsmouth.Add = function()
    addChallenge(Kingsmouth);
end

Kingsmouth.AddPlayer = function(playerNum, playerObj)
end

function Kingsmouth.RemovePlayer(playerObj)
end

Kingsmouth.Init = function()
end

Kingsmouth.OnGameStart = function()
end


Kingsmouth.OnInitWorld = function()
    SandboxVars.Zombies = 2;
--    SandboxVars.Distribution = 1;
--    SandboxVars.DayLength = 3;
--    SandboxVars.StartMonth = 7;
--    SandboxVars.StartTime = 2;
--    SandboxVars.WaterShutModifier = 7;
--    SandboxVars.ElecShutModifier = 7;
--    SandboxVars.FoodLoot = 4;
    SandboxVars.WeaponLoot = 3;
--    SandboxVars.CannedFoodLoot = 1;
    SandboxVars.RangedWeaponLoot = 7;
    SandboxVars.AmmoLoot = 7;
--    SandboxVars.SurvivalGearsLoot = 1;
--    SandboxVars.MechanicsLoot = 1;
--    SandboxVars.LiteratureLoot = 1;
--    SandboxVars.MedicalLoot = 1;
--    SandboxVars.OtherLoot = 4;
--    SandboxVars.Temperature = 3;
--    SandboxVars.Rain = 3;
--    SandboxVars.ErosionSpeed = 5
--    SandboxVars.Farming = 3;
--    SandboxVars.NatureAbundance = 5;
--    SandboxVars.PlantResilience = 3;
--    SandboxVars.PlantAbundance = 3;
--    SandboxVars.Alarm = 3;
--    SandboxVars.LockedHouses = 3;
--    SandboxVars.FoodRotSpeed = 3;
--    SandboxVars.FridgeFactor = 3;
--    SandboxVars.LootRespawn = 1;
--    SandboxVars.StatsDecrease = 3;
--    SandboxVars.StarterKit = false;
--    SandboxVars.TimeSinceApo = 1;
--    SandboxVars.DecayingCorpseHealthImpact = 1
    SandboxVars.MultiHitZombies = false;
--
--    SandboxVars.ZombieConfig.PopulationMultiplier = ZombiePopulationMultiplier.Insane

----    Events.OnZombieUpdate.Add(Kingsmouth.OnZombieUpdate);
--    Events.OnGameStart.Add(Kingsmouth.OnGameStart);
--
--    Events.EveryHours.Add(Kingsmouth.EveryHours);
--    Events.EveryDays.Add(Kingsmouth.EveryDays);
        --    Events.OnPlayerUpdate.Add(Kingsmouth.OnPlayerUpdate);
end

Kingsmouth.Render = function()

end

--[[
-- Example
function Kingsmouth.getSpawnRegion()
    local c = Kingsmouth
    return {
        {
            name = "Kingsmouth Region 1/2", points = {
                unemployed = {
                    { posX = c.x, posY = c.y, posZ = c.z },
                },
            }
        },
        {
            name = "Kingsmouth Region 2/2", points = {
                unemployed = {
                    { posX = (101 * 300 + 202), posY = (102 * 300 + 280), posZ = 1 },
                },
            }
        }
    }
end
--]]

--[[
-- Example
function Kingsmouth.getSpawnRegion()
    local c = Kingsmouth
    return {
        {
            name = "Kingsmouth Region 1/1", points = {
                unemployed = {
                    { posX = c.x, posY = c.y, posZ = c.z },
                    { posX = (101 * 300 + 202), posY = (102 * 300 + 280), posZ = 1 },
                }
            }
        }
    }
end
--]]

Kingsmouth.id = "Kingsmouth";
Kingsmouth.image = "media/lua/client/LastStand/Kingsmouth.png";
Kingsmouth.world = "challengemaps/Kingsmouth";
Kingsmouth.gameMode = "Kingsmouth";
Kingsmouth.x = 100 * 300 + 265;
Kingsmouth.y = 101 * 300 + 248;
Kingsmouth.z = 0;
Kingsmouth.zombiesMinPerChunk = 0.06 * 0.64 * 0.66
Kingsmouth.zombiesMaxPerChunk = 12 * 0.64 * 0.66

--Events.OnChallengeQuery.Add(Kingsmouth.Add)
