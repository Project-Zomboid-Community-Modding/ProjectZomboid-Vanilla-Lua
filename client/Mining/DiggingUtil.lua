DiggingUtil = {

    excavatingStairs = false,

    tick = function()
        local x = screenToIsoX(getPlayer():getIndex(), getMouseX(), getMouseY(), getPlayer():getZ());
        local y = screenToIsoY(getPlayer():getIndex(), getMouseX(), getMouseY(), getPlayer():getZ());

        local xx = x - math.floor(x);
        local yy = y - math.floor(y);

        if DiggingUtil.excavatingStairs then
            local dir = IsoDirections.E;

            if xx < yy and xx < 0.5 then
                dir = IsoDirections.W;
            elseif xx > yy and yy > 0.5 then
                dir = IsoDirections.E;
            elseif yy < xx and yy < 0.5 then
                dir = IsoDirections.N;
            else
                dir = IsoDirections.S;
            end

            DiggingUtil.mining_drawStairsGuide(x, y, getPlayer():getZ(), dir);


            if(isMouseButtonPressed(0)) then
                DiggingUtil.excavatingStairs = false;

                local function predicateDigGrave(item)
                    return not item:isBroken() and item:hasTag("DigGrave")
                end

                local playerObj = getPlayer()
                local playerInv = playerObj:getInventory()
                local shovel = playerInv:getFirstEvalRecurse(predicateDigGrave);

                if dir == IsoDirections.N then y = y + 1; end
                if dir == IsoDirections.S then y = y - 1; end

                if dir == IsoDirections.W then x = x + 1; end
                if dir == IsoDirections.E then x = x - 1; end

                local sq = getCell():getGridSquare(math.floor(x), math.floor(y), math.floor(getPlayer():getZ()));

                if luautils.walk(playerObj, sq) then

                    ISTimedActionQueue.add(ISDigStairsAction:new(playerObj, shovel, sq, dir, 1));
                end

            end



        end
    end,

    mining_drawStairsGuide = function(x, y, z, dir)
        local xt = math.floor(x);
        local yt = math.floor(y);
        local zt = math.floor(z);

        local r = 1;
        local g = 1;
        local b = 1;
        local a = 1;

        local w = 1;
        local h = 1;

        if dir == IsoDirections.S or dir == IsoDirections.N then
            h = 3;
            if dir == IsoDirections.N then
                yt = yt - 2;
            end
            for yy=0, h do
                renderLine(xt, yt, zt, xt, yt+yy, zt, r, g, b, a);
                renderLine(xt+1, yt, zt, xt+1, yt+yy, zt, r, g, b, a);
            end
                renderLine(xt, yt, zt, xt, yt, zt, r, g, b, a);
                renderLine(xt, yt, zt, xt+1, yt, zt, r, g, b, a);

                renderLine(xt, yt+h, zt, xt, yt+h, zt, r, g, b, a);
                renderLine(xt, yt+h, zt, xt+1, yt+h, zt, r, g, b, a);
        else
            w = 3;

            if dir == IsoDirections.W then
                xt = xt - 2;
            end
            for xx=0, w do
                renderLine(xt, yt, zt, xt+xx, yt, zt, r, g, b, a);
                renderLine(xt, yt+1, zt, xt+xx, yt+1, zt, r, g, b, a);
            end
                renderLine(xt, yt, zt, xt, yt, zt, r, g, b, a);
                renderLine(xt, yt, zt, xt, yt+1, zt, r, g, b, a);

                renderLine(xt+w, yt, zt, xt+w, yt, zt, r, g, b, a);
                renderLine(xt+w, yt, zt, xt+w, yt+1, zt, r, g, b, a);
        end

        -- draw arrow
        xt = math.floor(x);
        yt = math.floor(y);
        zt = math.floor(z);

        if dir == IsoDirections.N then
             yt = yt + 0.5;
             renderLine(xt+0.5, yt, zt, xt+0.5, yt-1.5, zt, r, g, b, a);
             renderLine(xt+0.5, yt-1.5, zt, xt+0.5-0.25, yt-1, zt, r, g, b, a);
             renderLine(xt+0.5, yt-1.5, zt, xt+0.5+0.25, yt-1, zt, r, g, b, a);

        elseif dir == IsoDirections.S then
             yt = yt + 0.5;
             renderLine(xt+0.5, yt, zt, xt+0.5, yt+1.5, zt, r, g, b, a);
             renderLine(xt+0.5, yt+1.5, zt, xt+0.5+0.25, yt+1, zt, r, g, b, a);
             renderLine(xt+0.5, yt+1.5, zt, xt+0.5-0.25, yt+1, zt, r, g, b, a);
        elseif dir == IsoDirections.W then
             xt = xt + 0.5;
             renderLine(xt, yt+0.5, zt, xt-1.5, yt+0.5, zt, r, g, b, a);
             renderLine(xt-1.5, yt+0.5, zt, xt-1, yt+0.5-0.25, zt, r, g, b, a);
             renderLine(xt-1.5, yt+0.5, zt, xt-1, yt+0.5+0.25, zt, r, g, b, a);
        elseif dir == IsoDirections.E then
             xt = xt + 0.5;
             renderLine(xt, yt+0.5, zt, xt+1.5, yt+0.5, zt, r, g, b, a);
             renderLine(xt+1.5, yt+0.5, zt, xt+1, yt+0.5+0.25, zt, r, g, b, a);
             renderLine(xt+1.5, yt+0.5, zt, xt+1, yt+0.5-0.25, zt, r, g, b, a);
        end

    end,

    mining_floorCanDig = function(square)
        if (not square) or (not square:getFloor()) then
            return false;
        end
        local floor = square:getFloor();
        local sprite = floor:getSprite():getName();
        if luautils.stringStarts(sprite, "floors_exterior_natural") or luautils.stringStarts(sprite, "blends_natural_01") then
            return true;
        end

        return false;
    end,
}

Events.OnTick.Add(DiggingUtil.tick);

