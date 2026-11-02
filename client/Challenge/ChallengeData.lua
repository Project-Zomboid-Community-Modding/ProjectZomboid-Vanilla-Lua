ChallengeData = {}
ChallengeData.chosenChallenge = nil

local function findCurrentChallenge()
    if not getCore():isChallenge() then return nil end
    for _,challenge in ipairs(ChallengeList) do
        if challenge.id == getCore():getChallengeID() then
            return challenge
        end
    end
    return nil
end

function preChallengeInit()
    if getCore():isChallenge() then
        ChallengeData.chosenChallenge = findCurrentChallenge()
        globalChallenge = ChallengeData.chosenChallenge
        setMinMaxZombiesPerChunk(globalChallenge.zombiesMinPerChunk or 0.0, globalChallenge.zombiesMaxPerChunk or 255.0)
        globalChallenge.OnInitWorld()

        Events.OnPostUIDraw.Add(doChallengeDraw)
        Events.OnCreatePlayer.Add(doChallengeCreatePlayer)
        Events.OnPlayerDeath.Add(doChallengePlayerDeath)
    end
end

function doChallengeDraw()
    if globalChallenge ~= nil then
        globalChallenge.Render()
    end

end

function doChallengeCreatePlayer(playerNum, playerObj)
    globalChallenge.AddPlayer(playerNum, playerObj)
end

function doChallengePlayerDeath(playerObj)
    if globalChallenge then
        globalChallenge.RemovePlayer(playerObj)
    end
end

function ChallengeData.getSpawnRegion()
    local c = findCurrentChallenge()
    if not c then return nil end
    if c.getSpawnRegion then
        return c.getSpawnRegion()
    end
    if c.xcell ~= nil then
        -- This is the old format with 300x300 cell coordinates.
        return { {
            name = c.name, points = {
                unemployed = {
                    { worldX = c.xcell, worldY = c.ycell, posX = c.x, posY = c.y, posZ = c.z },
                }
            }
        } }
    end
    return { {
        name = c.name, points = {
            unemployed = {
                { posX = c.x, posY = c.y, posZ = c.z },
            }
        }
    } }
end

Events.OnInitWorld.Add(preChallengeInit)
