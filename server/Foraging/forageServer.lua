if not isServer() then return; end;

require "Foraging/forageSystem";

forageServer = {};
forageClient = forageServer;
forageServer.pools    = {};
forageServer.byId     = {};
forageServer.lastFind = {};
forageServer.focus    = {};
forageServer.lastReqMs = {};
forageServer.minReqMs  = 250;

forageServer.maxPickupDistance = 30;
forageServer.maxXPDistance     = 20;
forageServer.nearMargin        = 25;
forageServer.poolGraceMs       = 60000;
forageServer.relevanceMs       = 2000;
forageServer._nextRelevanceMs  = 0;

forageServer.affinityRadius   = 8;
forageServer.affinityRolled   = {};
forageServer.affinityChunks   = {};
local AFFINITY_CHUNK = 8;

forageData = ModData.getOrCreate("forageData");

function forageServer.updateData()
    forageData = ModData.getOrCreate("forageData");
end

function forageServer.clearData()
    ModData.remove("forageData");
end

function forageServer.addZone(_zoneData)
    forageData[_zoneData.id] = _zoneData;
end

function forageServer.removeZone(_zoneData)
    forageData[_zoneData.id] = nil;
end

function forageServer.updateZone(_zoneData)
    forageServer.addZone(_zoneData);
end

function forageServer.syncForageData()
    ModData.transmit("forageData");
end

function forageServer.updateIcon(_zoneData, _iconID, _icon)
    forageData[_zoneData.id].forageIcons[_iconID] = _icon;
end

forageServer.OnClientCommand = function(_module, _command, _plObj, _packet, _clientID)
    if _module ~= "forageData" then return; end;
    if (not forageServer[_command]) or (not _packet) then
        print("aborted function call in forageServer "
                .. (_command or "missing _command.")
                .. (_packet or "missing _packet."));
    else
        sendServerCommand(_module, _command, _packet, _clientID);
        forageServer[_command](_packet, _clientID);
    end;
end

Events.OnClientCommand.Add(forageServer.OnClientCommand);

local function pname(_player)
    return _player and (_player:getUsername() or _player:getDisplayName());
end

local function rollCount(_itemDef)
    if not _itemDef then
        return 1;
    end;
    if _itemDef.minCount == _itemDef.maxCount then
        return _itemDef.minCount or 1;
    end;
    return ZombRand(_itemDef.minCount, _itemDef.maxCount) + 1;
end

local function applyFocus(_player, _zoneName, _itemType, _catName, _focus)
    if (not _focus) or _focus == "" or _focus == "None" or _catName == _focus then
        return _itemType, _catName;
    end;
    local focusCatDef = forageSystem.catDefs[_focus];
    if not focusCatDef then
        return _itemType, _catName;
    end;
    local perkLevel = _player:getPerkLevel(Perks.FromString(focusCatDef.identifyCategoryPerk));
    if perkLevel < (focusCatDef.identifyCategoryLevel or 0) then
        return _itemType, _catName;
    end;
    local chance = (focusCatDef.focusChanceMin or 0)
        + (math.abs((focusCatDef.focusChanceMax or 0) - (focusCatDef.focusChanceMin or 0)) / math.max(10 - perkLevel, 1));
    if ZombRandFloat(0.0, 100.0) < chance then
        local picked = forageSystem.pickRandomItemType(_zoneName, _focus);
        if picked and forageSystem.itemDefs[picked] then
            return picked, _focus;
        end;
    end;
    return _itemType, _catName;
end

local function buildIconsTable(_icons)
    local t = {};
    for id, rec in pairs(_icons) do
        t[id] = { x = rec.x, y = rec.y, z = rec.z, itemType = rec.itemType, catName = rec.catName, count = rec.count or 1 };
    end;
    return t;
end

local function getZoneSubTable(_byUser, _user, _zoneId)
    local byUser = _byUser[_user];
    if not byUser then
        byUser = {};
        _byUser[_user] = byUser;
    end;
    local byZone = byUser[_zoneId];
    if not byZone then
        byZone = {};
        byUser[_zoneId] = byZone;
    end;
    return byZone;
end

local function addBonusIcon(_entry, _byId, _zoneData, _x, _y, _z, _itemType, _catName, _itemDef)
    local id = getRandomUUID();
    local rec = {
        iconID = id, zoneId = _zoneData.id,
        x = _x, y = _y, z = _z,
        itemType = _itemType, catName = _catName,
        count = rollCount(_itemDef), isBonusIcon = true,
    };
    _entry.icons[id] = rec;
    _byId[id] = rec;
end

local function rollAffinityItem(_square, _zoneName, _focus)
    local objects = _square:getObjects();
    local n = (objects and objects:size()) or 0;
    for i = 0, n - 1 do
        local object = objects:get(i);
        if object and (not object:hasModData()) then
            for _, spriteName in ipairs(forageSystem.getAffinitySpriteNames(object)) do
                local catName, catDef = forageSystem.resolveSpriteAffinity(spriteName, _focus);
                if catDef and ZombRandFloat(0.0, 100.0) < (catDef.chanceToCreateIcon or 0) then
                    local itemType = forageSystem.pickRandomItemType(_zoneName, catName);
                    local itemDef = itemType and forageSystem.itemDefs[itemType];
                    if itemDef then
                        return itemType, catName, itemDef;
                    end;
                end;
            end;
        end;
    end;
end

function forageServer.generatePool(_player, _zoneData, _focus)
    local icons = {};
    local name = _zoneData.name;
    if (not name) or (not forageSystem.zoneDefs[name]) or (not forageSystem.lootTable[name]) or (not _zoneData.metaZone) then
        return icons;
    end;
    local itemsLeft = math.floor(_zoneData.itemsLeft or 0);
    if itemsLeft <= 0 then
        return icons;
    end;
    local target = math.min(itemsLeft, forageSystem.maxIconsPerZone);

    local location = Location.new();
    local made, guard = 0, 0;
    while made < target and guard < (target * 4 + 8) do
        guard = guard + 1;
        local itemType, catName = forageSystem.pickRandomItemType(name);
        if itemType and catName then
            itemType, catName = applyFocus(_player, name, itemType, catName, _focus);
        end;
        local itemDef = itemType and forageSystem.itemDefs[itemType];
        if itemType and catName and itemDef then
            location = _zoneData.metaZone:pickRandomLocation(location);
            if location then
                local id = getRandomUUID();
                icons[id] = {
                    iconID = id, zoneId = _zoneData.id,
                    x = location:getX(), y = location:getY(), z = 0,
                    itemType = itemType, catName = catName,
                    count = rollCount(itemDef),
                };
                made = made + 1;
            end;
        end;
    end;

    return icons;
end

function forageServer.ensurePool(_player, _zoneData, _focus)
    local user = pname(_player);
    if not user then
        return nil;
    end;
    local pools = forageServer.pools[user];
    if not pools then
        pools = {};
        forageServer.pools[user] = pools;
    end;
    local entry = pools[_zoneData.id];
    if not entry then
        local icons = forageServer.generatePool(_player, _zoneData, _focus);
        entry = { lastMs = getTimestampMs(), icons = icons };
        pools[_zoneData.id] = entry;
        local byId = forageServer.byId[user];
        if not byId then
            byId = {};
            forageServer.byId[user] = byId;
        end;
        for id, rec in pairs(icons) do
            byId[id] = rec;
        end;
        return entry, true;
    end;
    entry.lastMs = getTimestampMs();
    return entry, false;
end

function forageServer.scanAffinity(_player, _zoneData, _entry)
    if not (_player and _zoneData and _entry) then
        return;
    end;
    local user = pname(_player);
    if not user then
        return;
    end;
    local cell = getCell();
    if not cell then
        return;
    end;
    if not forageSystem.spriteAffinities then
        return;
    end;

    local rolledZ = getZoneSubTable(forageServer.affinityRolled, user, _zoneData.id);
    local gatedZ = getZoneSubTable(forageServer.affinityChunks, user, _zoneData.id);
    local byId = forageServer.byId[user];
    if not byId then
        byId = {};
        forageServer.byId[user] = byId;
    end;

    local occupied = {};
    for _, rec in pairs(_entry.icons) do
        occupied[math.floor(rec.x) .. "," .. math.floor(rec.y)] = true;
    end;

    local focus = forageServer.focus[user];
    local plX, plY, plZ = math.floor(_player:getX()), math.floor(_player:getY()), math.floor(_player:getZ());

    local function scanSquare(_dx, _dy)
        local sqX, sqY = plX + _dx, plY + _dy;
        local sqKey = sqX .. "," .. sqY;
        if rolledZ[sqKey] then
            return;
        end;
        if not forageSystem.zoneContains(_zoneData, sqX, sqY, 0) then
            return;
        end;
        local square = cell:getGridSquare(sqX, sqY, plZ);
        if not square then
            return;
        end;
        rolledZ[sqKey] = true;
        local chunkKey = math.floor(sqX / AFFINITY_CHUNK) .. "," .. math.floor(sqY / AFFINITY_CHUNK);
        if gatedZ[chunkKey] or occupied[sqKey] or square:HasTree() then
            return;
        end;
        local itemType, catName, itemDef = rollAffinityItem(square, _zoneData.name, focus);
        if not itemDef then
            return;
        end;
        addBonusIcon(_entry, byId, _zoneData, sqX, sqY, plZ, itemType, catName, itemDef);
        gatedZ[chunkKey] = true;
    end;

    local R = forageServer.affinityRadius;
    for dx = -R, R do
        for dy = -R, R do
            scanSquare(dx, dy);
        end;
    end;
end

function forageServer.onRequestZone(_player, _focus)
    if not _player then
        return;
    end;
    local user = pname(_player);
    if not user then
        return;
    end;
    local now = getTimestampMs();
    local last = forageServer.lastReqMs[user];
    if last and (now - last) < forageServer.minReqMs then
        return;
    end;
    forageServer.lastReqMs[user] = now;
    forageServer.focus[user] = _focus or "None";
    local zoneData = forageSystem.getForageZoneAt(_player:getX(), _player:getY());
    if not zoneData then
        return;
    end;
    forageSystem.checkRefillZone(zoneData);
    local entry = forageServer.ensurePool(_player, zoneData, _focus);
    if not entry then
        return;
    end;
    forageServer.scanAffinity(_player, zoneData, entry);
    sendForagePool(_player, zoneData.id, buildIconsTable(entry.icons));
end

function forageServer.onSpot(_player, _iconID)
    if not (_player and _iconID) then
        return;
    end;
    local user = pname(_player);
    if not user then
        return;
    end;
    local byId = forageServer.byId[user];
    if not byId then
        return;
    end;
    local rec = byId[_iconID];
    if not rec then
        return;
    end;
    if rec.xpGiven then
        return;
    end;
    rec.xpGiven = true;
    local itemDef = forageSystem.itemDefs[rec.itemType];
    if not itemDef then
        return;
    end;

    local px, py = _player:getX(), _player:getY();
    local ref = forageServer.lastFind[user];
    local dist = 1;
    if ref then
        local dx, dy = px - ref.x, py - ref.y;
        dist = math.sqrt((dx * dx) + (dy * dy));
    end;
    if dist > forageServer.maxXPDistance then
        dist = forageServer.maxXPDistance;
    end;
    if dist < 1 then
        dist = 1;
    end;
    forageServer.lastFind[user] = { x = px, y = py };

    forageSystem.giveXP(_player, itemDef, dist);
end

function forageServer.buildItems(_player, _rec, _itemDef)
    local items = ArrayList.new();
    for _ = 1, (_rec.count or 1) do
        items:add(instanceItem(_rec.itemType));
    end;
    if _itemDef and _itemDef.spawnFuncs then
        for _, spawnFunc in ipairs(_itemDef.spawnFuncs) do
            items = spawnFunc(_player, _player:getInventory(), _itemDef, items) or items;
        end;
    end;
    return items;
end

function forageServer.onPickup(_player, _iconID, _container)
    if not (_player and _iconID) then
        return false;
    end;
    local user = pname(_player);
    if not user then
        return false;
    end;
    local byId = forageServer.byId[user];
    if not byId then
        return false;
    end;
    local rec = byId[_iconID];
    if not rec then
        return false;
    end;
    local dx, dy = _player:getX() - rec.x, _player:getY() - rec.y;
    if math.sqrt((dx * dx) + (dy * dy)) > forageServer.maxPickupDistance then
        return false;
    end;
    byId[_iconID] = nil;
    local pools = forageServer.pools[user];
    if pools and pools[rec.zoneId] then
        pools[rec.zoneId].icons[_iconID] = nil;
    end;

    local itemDef = forageSystem.itemDefs[rec.itemType];
    local items = forageServer.buildItems(_player, rec, itemDef);
    forageSystem.addOrDropItems(_player, _container or _player:getInventory(), items);
    forageSystem.doFatiguePenalty(_player);
    forageSystem.doEndurancePenalty(_player);
    local zoneData = forageSystem.getForageZoneAt(rec.x, rec.y);
    if zoneData then
        forageSystem.takeItem(zoneData);
    end;
    return true;
end

function forageServer.dropZonePool(_user, _zoneId)
    local pools = forageServer.pools[_user];
    local byId = forageServer.byId[_user];
    if pools and pools[_zoneId] then
        if byId then
            for id in pairs(pools[_zoneId].icons) do
                byId[id] = nil;
            end;
        end;
        pools[_zoneId] = nil;
    end;
    if forageServer.affinityRolled[_user] then
        forageServer.affinityRolled[_user][_zoneId] = nil;
    end;
    if forageServer.affinityChunks[_user] then
        forageServer.affinityChunks[_user][_zoneId] = nil;
    end;
end

function forageServer.dropPlayer(_user)
    forageServer.pools[_user] = nil;
    forageServer.byId[_user] = nil;
    forageServer.lastFind[_user] = nil;
    forageServer.focus[_user] = nil;
    forageServer.lastReqMs[_user] = nil;
    forageServer.affinityRolled[_user] = nil;
    forageServer.affinityChunks[_user] = nil;
end

function forageServer.playerNearZone(_px, _py, _zoneId)
    local zoneData = forageData[_zoneId];
    if not zoneData then
        return false;
    end;
    local m = forageServer.nearMargin;
    return forageSystem.zoneIntersects(zoneData, _px - m, _py - m, 0, m * 2, m * 2);
end

function forageServer.relevanceTick()
    local now = getTimestampMs();
    if now < forageServer._nextRelevanceMs then
        return;
    end;
    forageServer._nextRelevanceMs = now + forageServer.relevanceMs;

    local online = {};
    local players = getOnlinePlayers();
    if players then
        for i = 0, players:size() - 1 do
            local p = players:get(i);
            local u = pname(p);
            if u then
                online[u] = p;
            end;
        end;
    end;

    for user in pairs(forageServer.focus) do
        if not online[user] then
            forageServer.dropPlayer(user);
        end;
    end;

    for user, pools in pairs(forageServer.pools) do
        local player = online[user];
        if not player then
            forageServer.dropPlayer(user);
        else
            local px, py = player:getX(), player:getY();
            for zoneId, entry in pairs(pools) do
                if forageServer.playerNearZone(px, py, zoneId) then
                    entry.lastMs = now;
                elseif now - entry.lastMs > forageServer.poolGraceMs then
                    forageServer.dropZonePool(user, zoneId);
                end;
            end;
        end;
    end;
end

LuaEventManager.AddEvent("OnForageRequestZone");
LuaEventManager.AddEvent("OnForageSpot");

Events.OnForageRequestZone.Add(function(_player, _focus) forageServer.onRequestZone(_player, _focus); end);
Events.OnForageSpot.Add(function(_player, _iconID) forageServer.onSpot(_player, _iconID); end);
Events.OnTick.Add(forageServer.relevanceTick);
