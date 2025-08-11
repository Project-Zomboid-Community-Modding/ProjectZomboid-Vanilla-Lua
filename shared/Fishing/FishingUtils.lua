Fishing = Fishing or {}
Fishing.Utils = {}

function Fishing.Utils.isWaterCoords(x, y)
    local sq = getCell():getGridSquare(x, y, 0)
    if sq and sq:getProperties() and sq:getProperties():Is(IsoFlagType.water) then
        return true
    end
    return false
end

function Fishing.Utils.getAimCoords(player)
    if player:getJoypadBind() == -1 then
        return ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled() + 100, player:getZ())
    else
        local x = player:getX()
        local y = player:getY()
        local dir = player:getDir()

        if     dir == IsoDirections.N  then   x,y = x, y - 6
        elseif dir == IsoDirections.NE then   x,y = x + 4, y - 4
        elseif dir == IsoDirections.E  then   x,y = x + 6, y
        elseif dir == IsoDirections.SE then   x,y = x + 4, y + 4
        elseif dir == IsoDirections.S  then   x,y = x, y + 6
        elseif dir == IsoDirections.SW then   x,y = x - 4, y + 4
        elseif dir == IsoDirections.W  then   x,y = x - 6, y
        elseif dir == IsoDirections.NW then   x,y = x - 4, y - 4
        end

        return x, y
    end
end

Fishing.Utils.stopFishingKeysKeyboard = { "Forward", "Left", "Backward", "Right", "Melee", "CancelAction"}

function Fishing.Utils.isStopFishingButtonPressed(joypad)
    if joypad == -1 then
        for _, key in ipairs(Fishing.Utils.stopFishingKeysKeyboard) do
            if isKeyPressed(key) then
                if getCore():getKey(key) then
                    GameKeyboard.eatKeyPress(getCore():getKey(key))
                elseif getCore():getAltKey(key) then
                    GameKeyboard.eatKeyPress(getCore():getAltKey(key))
                end
                return true
            end
        end
    else
        return isJoypadPressed(joypad, Joypad.BButton)
    end
    return false
end

-- Fix for SPIF-3279. Eats hotbar inputs when rod is out and fishing.
Fishing.Utils.hotbarKeys = {"Hotbar 1", "Hotbar 2", "Hotbar 3", "Hotbar 4", "Hotbar 5", "Hotbar 6", "Hotbar 7", "Hotbar 8"}
function Fishing.Utils.hotbarStopper()
    for _, key in ipairs(Fishing.Utils.hotbarKeys) do
        if isKeyPressed(key) then
            if getCore():getKey(key) then
                GameKeyboard.eatKeyPress(getCore():getKey(key))
            elseif getCore():getAltKey(key) then
                GameKeyboard.eatKeyPress(getCore():getAltKey(key))
            end
        end
    end
end

function Fishing.Utils.isPlayerAimOnWater(player, autoAim)
    if (not player:isAiming() and not autoAim) then return false end

    local x, y = Fishing.Utils.getAimCoords(player)

    if Fishing.isNoFishZone(x,y) then
        return false
    end

    local sq = getSquare(x, y, 0)
    if sq and sq:getProperties() and sq:getProperties():Is(IsoFlagType.water) then
        return true
    end
    return false
end

function Fishing.Utils.isAccessibleAimDist(player)
    local x, y = Fishing.Utils.getAimCoords(player)
    return IsoUtils.DistanceTo(player:getX(), player:getY(), x, y) < 16
end

Fishing.Utils.tempVec2 = Vector2.new()
function Fishing.Utils.facePlayerToAim(player)
    local vec = player:getAimVector(Fishing.Utils.tempVec2)
    player:faceLocationF(player:getX() + vec:getX(), player:getY() + vec:getY())
end

function Fishing.Utils.FacePlayerToBobber(player, x, y)
    player:faceLocationF(x, y)
end

function Fishing.Utils.isCastButtonPressed(joypad)
    if joypad == -1 then
        return isMouseButtonDown(0)
    else
        return isJoypadRTPressed(joypad)
    end
end

function Fishing.Utils.isGamepadReelMove(joypad, prevValue)
    local x = getJoypadAimingAxisX(joypad)
    local y = getJoypadAimingAxisY(joypad)
    local val = math.abs(x) + math.abs(y)
    if val < 0.85 then
        return 0, 0, false, false
    end
    local angle = math.atan(math.abs(x)/math.abs(y))
    if x < 0 then
        angle = angle * -1
    end
    if y < 0 then
        angle = math.pi - angle
    end

    if prevValue == 0 then
        return angle - math.pi/2, 0, false, false
    end

    local delta = (angle - math.pi/2) - prevValue
    if math.abs(delta) > math.pi then
        if delta < 0 then
            delta = delta + 2 * math.pi
        else
            delta = delta - 2 * math.pi
        end
    end

    local isReel = delta > 0
    local isRelease = delta < 0

    if delta == 0 then
        return angle - math.pi/2, delta, nil, nil
    end

    return angle - math.pi/2, delta, isReel, isRelease
end

function Fishing.Utils.isNearShore(x, y)
    local cell = getCell()
    for i = -7, 7 do
        for j = -7, 7 do
            local sq = cell:getGridSquare(math.floor(x+i), math.floor(y+j), 0)
            if sq ~= nil and sq:getWater() ~= nil and sq:getWater():isActualShore()  then
                return true
            end
        end
    end
    return false
end

Fishing.Utils.skillSizeLimit = {}
Fishing.Utils.skillSizeLimit[0] = 1.4
Fishing.Utils.skillSizeLimit[1] = 1.5
Fishing.Utils.skillSizeLimit[2] = 1.9
Fishing.Utils.skillSizeLimit[3] = 2.2
Fishing.Utils.skillSizeLimit[4] = 2.3
Fishing.Utils.skillSizeLimit[5] = 2.8
Fishing.Utils.skillSizeLimit[6] = 4.5
Fishing.Utils.skillSizeLimit[7] = 9
Fishing.Utils.skillSizeLimit[8] = 27
Fishing.Utils.skillSizeLimit[9] = 32
Fishing.Utils.skillSizeLimit[10] = 45

-- Small, Medium, Big
Fishing.Utils.fishSizeChancesBySkillLevel = {}
Fishing.Utils.fishSizeChancesBySkillLevel[0] = { 95, 5, 0 }
Fishing.Utils.fishSizeChancesBySkillLevel[1] = { 85, 15, 0 }
Fishing.Utils.fishSizeChancesBySkillLevel[2] = { 75, 24, 1 }
Fishing.Utils.fishSizeChancesBySkillLevel[3] = { 70, 25, 5 }
Fishing.Utils.fishSizeChancesBySkillLevel[4] = { 60, 30, 10 }
Fishing.Utils.fishSizeChancesBySkillLevel[5] = { 48, 40, 12 }
Fishing.Utils.fishSizeChancesBySkillLevel[6] = { 35, 45, 20 }
Fishing.Utils.fishSizeChancesBySkillLevel[7] = { 25, 45, 30 }
Fishing.Utils.fishSizeChancesBySkillLevel[8] = { 20, 40, 40 }
Fishing.Utils.fishSizeChancesBySkillLevel[9] = { 15, 40, 45 }
Fishing.Utils.fishSizeChancesBySkillLevel[10] = { 10, 40, 50 }

function Fishing.Utils.getFishSizeChancesBySkillLevel(lvl, isNearShore, fishNum)
    if fishNum == 0 then
        return 100, 0, 0
    end
    local fishSmall = Fishing.Utils.fishSizeChancesBySkillLevel[lvl][1]
    local fishMedium = Fishing.Utils.fishSizeChancesBySkillLevel[lvl][2]
    local fishBig = Fishing.Utils.fishSizeChancesBySkillLevel[lvl][3]

    if isNearShore then
        fishSmall = fishSmall + fishMedium/2 + fishBig/2
        fishMedium = fishMedium / 2
        fishBig = fishBig / 2
    end

    return fishSmall, fishMedium, fishBig
end


----- Fishing params and coeffs -----

function Fishing.Utils.getTemperatureParams(player)
    local temperature = getClimateManager():getAirTemperatureForCharacter(player, false)
    local temperatureCoeff = 1
    if temperature >= 30 and temperature < 40 or temperature >= 0 and temperature < 15 then
        temperatureCoeff = 0.75
    elseif temperature >= 40 or temperature > -10 and temperature < 0 then
        temperatureCoeff = 0.5
    elseif temperature <= -10 then
        temperatureCoeff = 0.25
    end

    return { temperature = temperature, coeff = temperatureCoeff }
end

function Fishing.Utils.getWeatherParams()
    local weatherCoeff = 1
    local isFog = getClimateManager():getFogIntensity() >= 0.4
    local isWind = getClimateManager():getWindPower() >= 0.5
    local isRain = RainManager.isRaining()

    if isFog or isWind then
        weatherCoeff = 0.8
    elseif isRain then
        weatherCoeff = 1.2
    end

    return { isFog = isFog, isWind = isWind, isRain = isRain, coeff = weatherCoeff }
end

function Fishing.Utils.getTimeParams()
    local currentHour = math.floor(math.floor(GameTime.getInstance():getTimeOfDay() * 3600) / 3600);
    local timeCoeff = 1
    if (currentHour >= 4 and currentHour <= 6) or (currentHour >= 18 and currentHour <= 20) then
        timeCoeff = 1.2
    end

    return { time = currentHour, coeff = timeCoeff }
end

function Fishing.Utils.getHookParams(hookType)
    local hookCoeff = 1
    if hookType == nil or Fishing.hook[hookType] == nil then
        hookCoeff = 0
    else
        hookCoeff = Fishing.hook[hookType]
    end

    return { hook = hookType, coeff = hookCoeff }
end

function Fishing.Utils.getFishNumParams(x, y)
    local numberOfFish = FishSchoolManager.getInstance():getFishAbundance(x, y)
    local numberOfFishCoeff = 1
    if numberOfFish == 0 then
        numberOfFishCoeff = 0.1
    elseif numberOfFish < 10 then
        numberOfFishCoeff = 0.5
    elseif numberOfFish <= 25 then
        numberOfFishCoeff = 1.0
    else
        numberOfFishCoeff = 1.5
    end

    return { value = numberOfFish, coeff = numberOfFishCoeff }
end

---

local function fishGroupsUpdate()
    FishSchoolManager.getInstance():updateSeed()
end
Events.EveryDays.Add(fishGroupsUpdate)
