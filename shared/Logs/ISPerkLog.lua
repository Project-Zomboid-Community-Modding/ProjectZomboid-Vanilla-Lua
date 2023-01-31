--[[---------------------------------------------
-------------------------------------------------
--
-- ISPerkLog
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

require "Logs/ISLogSystem";

--[[--========  ========--]]--

local function inBrackets(_string) return "["..tostring(_string).."]"; end;

local function getPerkLevels(_character)
    if not _character then return; end;
    --
    local perkLevels = {};
    local perk, perkLevel;
    for i=0, Perks.getMaxIndex() - 1 do
        perk = PerkFactory.getPerk(Perks.fromIndex(i));
        perkLevel = _character:getPerkLevel(Perks.fromIndex(i));
        if perk and perkLevel and perk:getParent() ~= Perks.None then
            table.insert(perkLevels, tostring(perk:getType()) .. "=" .. perkLevel);
        end;
    end;
    --
    return perkLevels;
end

--[[--========  ========--]]--

ISPerkLog = {};

--[[--======== logPerkLevelChange ========--
    @param _character   - local IsoPlayer
    @param _perk        - PerkFactory.Perk
    @param _perkLevel   - new perk level
]]--

function ISPerkLog.logPerkLevelChange(_character, _perk, _perkLevel)
    if getServerOptions():getBoolean("PerkLogs") then
        if isClient() and _character and _character:isLocalPlayer() then
            if _perk and _perkLevel then
                local logText = ISLogSystem.getGenericLogText(_character);
                ISLogSystem.sendLog(
                    _character,
                    "PerkLog",
                    logText ..
                    inBrackets("Level Changed") ..
                    inBrackets(tostring(_perk)) ..
                    inBrackets(tostring(_perkLevel)) ..
                    inBrackets("Hours Survived: " .. math.floor(_character:getHoursSurvived()))
                );
            end;
        end;
    end;
end

--[[--======== logAllPerks ========--
    @param _character - local IsoPlayer
]]--

function ISPerkLog.logAllPerks(_character)
    if getServerOptions():getBoolean("PerkLogs") then
        if isClient() and _character and _character:isLocalPlayer() then
            local logText = ISLogSystem.getGenericLogText(_character);
            ISLogSystem.sendLog(
                _character,
                "PerkLog",
                logText ..
                inBrackets(table.concat(getPerkLevels(_character), ", ")) ..
                inBrackets("Hours Survived: " .. math.floor(_character:getHoursSurvived()))
            );
        end;
    end;
end

--[[--======== logCreatePlayer ========--
    @param _character - local IsoPlayer
]]--

function ISPerkLog.logCreatePlayer(_player)
    if getServerOptions():getBoolean("PerkLogs") then
        local character = getSpecificPlayer(_player);
        if isClient() and character and character:isLocalPlayer() then
            local logText = ISLogSystem.getGenericLogText(character);
            ISLogSystem.sendLog(
                character,
                "PerkLog",
                logText ..
                inBrackets("Created Player " .. (_player + 1)) ..
                inBrackets("Hours Survived: " .. math.floor(character:getHoursSurvived()))
            );
            --
            ISPerkLog.logAllPerks(character);
        end;
    end;
end


--[[--======== logLogin ========--
    @param _character - local IsoPlayer
]]--

function ISPerkLog.logLogin(_character)
    if getServerOptions():getBoolean("PerkLogs") then
        if isClient() and _character and _character:isLocalPlayer() then
            local logText = ISLogSystem.getGenericLogText(_character);
            ISLogSystem.sendLog(
                _character,
                "PerkLog",
                logText ..
                inBrackets("Login") ..
                inBrackets("Hours Survived: " .. math.floor(_character:getHoursSurvived()))
            );
        end;
    end;
end

--[[--======== logDeath ========--
    @param _character - local IsoPlayer
]]--

function ISPerkLog.logDeath(_character)
    if getServerOptions():getBoolean("PerkLogs") then
        if isClient() and _character and _character:isLocalPlayer() then
            local logText = ISLogSystem.getGenericLogText(_character);
            ISLogSystem.sendLog(
                _character,
                "PerkLog",
                logText ..
                inBrackets("Died") ..
                inBrackets("Hours Survived: " .. math.floor(_character:getHoursSurvived()))
            );
        end;
    end;
end

--[[--======== init ========--]]--

function ISPerkLog.init()
    Events.EveryOneMinute.Remove(ISPerkLog.init)
    --
    local character = getSpecificPlayer(0);
    ISPerkLog.logLogin(character);
    ISPerkLog.logAllPerks(character);
    --
    Events.OnCreatePlayer.Add(ISPerkLog.logCreatePlayer);
    Events.LevelPerk.Add(ISPerkLog.logPerkLevelChange);
    Events.OnPlayerDeath.Add(ISPerkLog.logDeath);
end

if isClient() then Events.EveryOneMinute.Add(ISPerkLog.init); end;