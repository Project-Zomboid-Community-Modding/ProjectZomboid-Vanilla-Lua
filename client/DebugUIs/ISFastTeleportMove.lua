
ISFastTeleportMove = {}
ISFastTeleportMove.cheat = false
ISFastTeleportMove.currentZ = 0
ISFastTeleportMove.isAdded = false

ISFastTeleportMove.moveXY = function(player, dx, dy)
    player:getForwardDirection():set(dx, dy)

    local x = player:getX() + dx
    local y = player:getY() + dy

    player:setX(x)
    player:setY(y)
    player:setLx(x)
    player:setLy(y)
end

ISFastTeleportMove.moveZ = function(player, dz)
    player:setZ(player:getZ()+dz)
    player:setLz(player:getZ()+dz)
    ISFastTeleportMove.currentZ = player:getZ()
    if ISFastTeleportMove.currentZ ~= 0 and not ISFastTeleportMove.isAdded then
        Events.OnTick.Add(ISFastTeleportMove.OnTick)
        ISFastTeleportMove.isAdded = true
    end
    if ISFastTeleportMove.currentZ == 0 and ISFastTeleportMove.isAdded then
        Events.OnTick.Remove(ISFastTeleportMove.OnTick)
        ISFastTeleportMove.isAdded = false
    end
end

ISFastTeleportMove.OnKeyKeepPressed = function(key)
    if not ISFastTeleportMove.cheat then return end

    local player = getPlayer()
    if player ~= nil then
        if key == Keyboard.KEY_UP then
            ISFastTeleportMove.moveXY(player, -1, -1)
        elseif key == Keyboard.KEY_DOWN then
            ISFastTeleportMove.moveXY(player, 1, 1)
        elseif key == Keyboard.KEY_LEFT then
            ISFastTeleportMove.moveXY(player, -1, 1)
        elseif key == Keyboard.KEY_RIGHT then
            ISFastTeleportMove.moveXY(player, 1, -1)
        end
    end
end
Events.OnKeyKeepPressed.Add(ISFastTeleportMove.OnKeyKeepPressed)

ISFastTeleportMove.OnKeyStartPressed = function(key)
    if not ISFastTeleportMove.cheat then return end

    local player = getPlayer()
    if player ~= nil then
        if key == 201 and player:getZ() < 7 then        -- PageUp
            ISFastTeleportMove.moveZ(player, 1)
        elseif key == 209 and player:getZ() > 0 then    -- PageDown
            ISFastTeleportMove.moveZ(player, -1)
        end
    end
end
Events.OnKeyStartPressed.Add(ISFastTeleportMove.OnKeyStartPressed)

ISFastTeleportMove.OnTick = function()
    if not ISFastTeleportMove.cheat then return end

    local player = getPlayer()
    if player ~= nil and ISFastTeleportMove.currentZ ~= 0 then
        player:setZ(ISFastTeleportMove.currentZ)
        player:setLz(ISFastTeleportMove.currentZ)
    end
end