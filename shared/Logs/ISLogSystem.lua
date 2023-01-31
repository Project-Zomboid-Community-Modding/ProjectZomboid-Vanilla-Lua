--[[---------------------------------------------
-------------------------------------------------
--
-- ISLogSystem
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------

local function inBrackets(_string) return "["..tostring(_string).."]"; end;

local function findCharacter(_action)
    if _action.character then return _action.character; end;
    if _action.player and instanceof(_action.player, "IsoPlayer") then return _action.player; end;
    if _action.player and type(_action.player) == "number" then return getSpecificPlayer(_action.player); end;
    return getSpecificPlayer(0);
end;

--[[--========  ========--]]--

ISLogSystem = {};

--[[--======== getGenericLogText ========--]]--

function ISLogSystem.getGenericLogText(_character, _actionType)
    local logText = "";
    --
    if ISLogSystem.steamID then
        logText = logText .. inBrackets(ISLogSystem.steamID);
    end;
    --
    if _actionType then
        logText = logText .. inBrackets(_actionType);
    end;
    --
    if _character then
        logText = logText .. inBrackets(_character:getUsername());
        logText = logText .. inBrackets(ISLogSystem.getObjectPosition(_character));
    end;
    --
    return logText;
end

--[[--======== getObjectPosition ========--]]--

function ISLogSystem.getObjectPosition(_object)
    if instanceof(_object, "IsoObject") then
        return math.floor(_object:getX()) ..","..math.floor(_object:getY())..","..math.floor(_object:getZ());
    else
        return "invalid object";
    end;
end

--[[--======== logAction ========--
    @param _action - any table object

    Requires _action.Type string - this is the identifier for ClientActionLogs server option.

    All objects derived from ISBaseObject should have a Type identifier.

    This may only be called from a client.
]]--

function ISLogSystem.logAction(_action)
    if isClient() then
        local actionType = _action.Type;
        if (not actionType) then return; end;
        --
        local logActions = getServerOptions():getOption("ClientActionLogs");
        if string.match(logActions, actionType) then
            --
            local character = findCharacter(_action);
            if (not character) then return; end;
            --
            local actionLog = {};
            if ISLogSystem.steamID then table.insert(actionLog, ISLogSystem.steamID); end;
            table.insert(actionLog, actionType);
            table.insert(actionLog, character:getUsername());
            table.insert(actionLog, ISLogSystem.getObjectPosition(character));
            --
            if _action.getExtraLogData then
                local extraLogData = _action:getExtraLogData();
                if type(extraLogData) == "table" then
                    for _, value in ipairs(extraLogData) do
                        table.insert(actionLog, value);
                    end;
                end;
            end;
            --
            local logText = "";
            for _, text in ipairs(actionLog) do
                logText = logText .. inBrackets(text);
            end;
            --
            ISLogSystem.sendLog(character, "ClientActionLog", logText);
        end;
    end;
end

--[[--======== writeLog ========--
    @oaram _character   - unused
    @param _packet      - table containing loggerName and logText keys

    Handles writing the log data. Can be called from client or server.
]]--

function ISLogSystem.writeLog(_character, _packet)
    writeLog(_packet.loggerName, _packet.logText);
end

--[[--======== sendLog ========--
    @oaram _character   - IsoPlayer
    @oaram _loggerName  - log to write to - e.g. "ClientActionLog"
    @param _logText     - string to write in the log

    Wraps the log data in a table and sends it to the server to be logged.

    This may only be called from a client.
]]--

function ISLogSystem.sendLog(_character, _loggerName, _logText)
    if isClient() and _loggerName and _logText then
        sendClientCommand(_character, 'ISLogSystem', 'writeLog', {loggerName = _loggerName, logText = _logText});
    end;
end

--[[--======== receiveLog ========--]]--

function ISLogSystem.OnClientCommand(_module, _command, _plObj, _packet)
    if _module ~= "ISLogSystem" then return; end;
    if (not ISLogSystem[_command]) then
        print("aborted function call in ISLogSystem " .. (_command or "missing _command."));
    else
        ISLogSystem[_command](_plObj, _packet);
    end;
end

if isServer() then Events.OnClientCommand.Add(ISLogSystem.OnClientCommand); end;

--[[--======== init ========--]]--

function ISLogSystem.init()
    ISLogSystem.steamID = getCurrentUserSteamID();
end

if isClient() then ISLogSystem.init(); end;