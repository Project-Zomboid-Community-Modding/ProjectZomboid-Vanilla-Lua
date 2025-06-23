ISPaintMenu = {};

local PaintMenuItems = {
    { paint = "PaintBlue",          text = "ContextMenu_Blue",          color = { 0.35,0.35,0.80 } },
    { paint = "PaintGreen",         text = "ContextMenu_Green",         color = { 0.41,0.80,0.41 } },
    { paint = "PaintLightBrown",    text = "ContextMenu_Light_Brown",   color = { 0.59,0.44,0.21 } },
    { paint = "PaintLightBlue",     text = "ContextMenu_Light_Blue",    color = { 0.55,0.55,0.87 } },
    { paint = "PaintBrown",         text = "ContextMenu_Brown",         color = { 0.45,0.23,0.11 } },
    { paint = "PaintOrange",        text = "ContextMenu_Orange",        color = { 0.79,0.44,0.19 } },
    { paint = "PaintCyan",          text = "ContextMenu_Cyan",          color = { 0.50,0.80,0.80 } },
    { paint = "PaintPink",          text = "ContextMenu_Pink",          color = { 0.81,0.60,0.60 } },
    { paint = "PaintGrey",          text = "ContextMenu_Grey",          color = { 0.50,0.50,0.50 } },
    { paint = "PaintTurquoise",     text = "ContextMenu_Turquoise",     color = { 0.49,0.70,0.80 } },
    { paint = "PaintPurple",        text = "ContextMenu_Purple",        color = { 0.61,0.40,0.63 } },
    { paint = "PaintYellow",        text = "ContextMenu_Yellow",        color = { 0.84,0.78,0.30 } },
    { paint = "PaintWhite",         text = "ContextMenu_White",         color = { 0.92,0.92,0.92 } },
    { paint = "PaintRed",           text = "ContextMenu_Red",           color = { 0.63,0.10,0.10 } },
    { paint = "PaintBlack",         text = "ContextMenu_Black",         color = { 0.20,0.20,0.20 } }
}

local WallpaperMenuItems = {
    { paper = "Wallpaper_BeigeStripe",          text = "ContextMenu_BeigeStripe",},
    { paper = "Wallpaper_BlackFloral",         text = "ContextMenu_BlackFloral", },
    { paper = "Wallpaper_BlueStripe",    text = "ContextMenu_Light_BlueStripe", },
    { paper = "Wallpaper_GreenDiamond",     text = "ContextMenu_Light_GreenDiamond",  },
    { paper = "Wallpaper_GreenFloral",         text = "ContextMenu_GreenFloral",  },
    { paper = "Wallpaper_PinkChevron",        text = "ContextMenu_PinkChevron", },
    { paper = "Wallpaper_PinkFloral",          text = "ContextMenu_PinkFloral",  },
}

local function predicateEnoughPaste(item)
 return item:getCurrentUsesFloat() >= 0.1
end

local function predicateNotBroken(item)
 return not item:isBroken()
end

ISPaintMenu.doPaintMenu = function(player, context, worldobjects, test)

	if test and ISWorldObjectContextMenu.Test then return true end

	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()

	if playerObj:getVehicle() then return false end

    local square = nil;
    local thump = nil;
    local paintableWall = nil;
    local paintableItem = nil;

	-- we get the thumpable item (like wall/door/furniture etc.) if exist on the tile we right clicked
	for i,v in ipairs(worldobjects) do
		square = v:getSquare();
        local props = v:getProperties()
        if props and props:Is("IsPaintable") then
            paintableItem = v;
        end
		if instanceof(v, "IsoThumpable") then
			thump = v;
        end
        if props and (props:Is("WallNW") or props:Is("WallN") or props:Is("WallW") or
                props:Is("DoorWallN") or props:Is("DoorWallW")) or
                props:Is("WindowN") or props:Is("WindowW") then
            paintableWall = v;
        end
    end

    local joypad = JoypadState.players[player+1] or false

	local paintBrush = playerInv:getFirstTagRecurse("Paintbrush")
	local wallpaper = playerInv:getFirstTagRecurse("Wallpaper")
	local wallpaperPaste = playerInv:getFirstTagEvalRecurse("WallpaperPaste", predicateEnoughPaste)
	local scissors = playerInv:getFirstTagEvalRecurse("Scissors", predicateNotBroken)
	local plaster = playerInv:containsTypeRecurse("BucketPlasterFull")
	local plasterTrowel = playerInv:containsTagRecurse("PlasterTrowel")

    -- Plaster
    if (joypad or (thump and thump:canBePlastered())) and ((playerObj:getPerkLevel(Perks.Woodwork) >= 4 and plaster and plasterTrowel) or ISBuildMenu.cheat) then
		if test then return ISWorldObjectContextMenu.setTest() end
		context:addOption(getText("ContextMenu_Plaster"), worldobjects, ISPaintMenu.onPlaster, player, thump, square);
	elseif  (joypad or (thump and thump:canBePlastered())) and ((playerObj:getPerkLevel(Perks.Woodwork) >= 4 and (plaster or plasterTrowel))) then
		if test then return ISWorldObjectContextMenu.setTest() end
		local opt = context:addOption(getText("ContextMenu_CantPlaster"), worldobjects, ISPaintMenu.onPlaster, player, thump, square);
		opt.notAvailable = true;
	end

    -- Wallpaper
    if (((thump and thump:isPaintable()) or paintableWall) or joypad) and (paintBrush and wallpaper and wallpaperPaste and scissors) then
		if test then return ISWorldObjectContextMenu.setTest() end

        local wallType
        if paintableWall then
            wallType = paintableWall:getSprite():getProperties():Val("PaintingType")
        else
            wallType = thump:getSprite():getProperties():Val("PaintingType")
        end

        local wallpaperOption = context:addOption(getText("ContextMenu_ApplyWallpaper"), worldobjects, nil)
        local subMenuWallpaper = ISContextMenu:getNew(context)
        context:addSubMenu(wallpaperOption, subMenuWallpaper)

        ISPaintMenu.player = player
        for _,wme in ipairs(WallpaperMenuItems) do
            if (playerInv:containsTypeRecurse(wme.paper))
                    and WallPaper[wallType]
                    and WallPaper[wallType][wme.paper] then
                subMenuWallpaper:addOption(getText(wme.text), worldobjects, ISPaintMenu.onPaper, player, thump, wme.paper, wallType)
            end
        end

        if subMenuWallpaper:isEmpty() then
            context:removeLastOption()
        end
    end

    -- Paint various sign
    if (paintableWall or joypad) and (ISBuildMenu.cheat or paintBrush) then
		if test then return ISWorldObjectContextMenu.setTest() end

        local paintOption = context:addOption(getText("ContextMenu_PaintSign"), worldobjects, nil);
        local subMenuPaint = ISContextMenu:getNew(context);
        context:addSubMenu(paintOption, subMenuPaint);

        ISPaintMenu.player = player
        for _, pme in ipairs(PaintMenuItems) do
            if ISBuildMenu.cheat or playerInv:containsTypeRecurse(pme.paint) then
                ISPaintMenu.addSignOption(subMenuPaint, getText(pme.text), paintableWall, pme.paint, pme.color[1], pme.color[2], pme.color[3])
            end
        end
        if subMenuPaint:isEmpty() then
            context:removeLastOption()
        end
    end

	-- Item paint
	if joypad and (ISBuildMenu.cheat or paintBrush) then
		local paintOption = context:addOption(getText("ContextMenu_Paint"), worldobjects, nil)
		local subMenuPaint = ISContextMenu:getNew(context)
		context:addSubMenu(paintOption, subMenuPaint)

		for _, pme in ipairs(PaintMenuItems) do
			if ISBuildMenu.cheat or playerInv:containsTypeRecurse(pme.paint) then
				subMenuPaint:addOption(getText(pme.text), worldobjects, ISPaintMenu.onPaint, player, thump, pme.paint)
			end
		end

		if subMenuPaint:isEmpty() then
			context:removeLastOption()
		end
	elseif ((thump and thump:isPaintable()) or paintableItem) and (ISBuildMenu.cheat or paintBrush) then
        if test then return ISWorldObjectContextMenu.setTest() end

        local item = thump
        if paintableItem then
            item = paintableItem
        end

		local paintOption = context:addOption(getText("ContextMenu_Paint"), worldobjects, nil);
		local subMenuPaint = ISContextMenu:getNew(context);
		context:addSubMenu(paintOption, subMenuPaint);

        local addedMenu = false
        local wallType
        if paintableItem then
            wallType = paintableItem:getSprite():getProperties():Val("PaintingType")
        end
        if wallType == nil then
            wallType = ISPaintMenu.getWallType(item)
        end
        for _,pme in ipairs(PaintMenuItems) do
            if ((Painting[wallType] and Painting[wallType][pme.paint])) and (ISBuildMenu.cheat or playerInv:containsTypeRecurse(pme.paint)) then
                subMenuPaint:addOption(getText(pme.text), worldobjects, ISPaintMenu.onPaint, player, item, pme.paint);
                addedMenu = true;
            end
        end
        for _,pme in ipairs(PaintMenuItems) do
            if OtherPainting[wallType] and OtherPainting[wallType][pme.paint] and (ISBuildMenu.cheat or playerInv:containsTypeRecurse(pme.paint)) then
                subMenuPaint:addOption(getText(pme.text), worldobjects, ISPaintMenu.onPaint, player, item, pme.paint);
                addedMenu = true;
            end
        end
        if not addedMenu then
            context:removeLastOption();
        end
	end
end

ISPaintMenu.getWallType = function(obj)
    local props = obj:getProperties()
    if props:Is("WallN") or props:Is("WallW") then
        return "wall"
    end
    if props:Is("WindowN") or props:Is("WindowW") then
        return "windowsframe"
    end
    if props:Is("DoorWallN") or props:Is("DoorWallW") then
        return "doorframe"
    end
    if props:Is(IsoFlagType.WallSE) then
        return "pillar";
    end;
end

ISPaintMenu.addSignOption = function(subMenuPaint, name, wall, painting, r,g,b)
    local blueOption = subMenuPaint:addOption(name, nil, nil);
    local subMenuBlue = ISContextMenu:getNew(subMenuPaint);
    subMenuPaint:addSubMenu(blueOption, subMenuBlue);

    subMenuBlue:addOption(getText("ContextMenu_SignSkull"), wall, ISPaintMenu.onPaintSign, ISPaintMenu.player, painting, 36, r,g,b);
    subMenuBlue:addOption(getText("ContextMenu_SignRightArrow"), wall, ISPaintMenu.onPaintSign, ISPaintMenu.player, painting, 32, r,g,b);
    subMenuBlue:addOption(getText("ContextMenu_SignLeftArrow"), wall, ISPaintMenu.onPaintSign, ISPaintMenu.player, painting, 33, r,g,b);
    subMenuBlue:addOption(getText("ContextMenu_SignDownArrow"), wall, ISPaintMenu.onPaintSign, ISPaintMenu.player, painting, 34, r,g,b);
    subMenuBlue:addOption(getText("ContextMenu_SignUpArrow"), wall, ISPaintMenu.onPaintSign, ISPaintMenu.player, painting, 35, r,g,b);
end

ISPaintMenu.onPaintSign = function(wall, player, painting, sign, r,g,b)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    if true or JoypadState.players[player+1] then
        local bo = ISPaintCursor:new(playerObj, "paintSign", { paintType=painting, sign=sign, r=r, g=g, b=b })
        getCell():setDrag(bo, bo.player)
        return
    end
    if luautils.walkAdjWall(playerObj, wall:getSquare(), wall:getProperties():Is("WallN")) then
        local paintCan = nil
        if not ISBuildMenu.cheat then
            local paintBrush = playerInv:getFirstTypeRecurse("Paintbrush")
            ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintBrush)
            paintCan = playerInv:getFirstTypeRecurse(painting)
            ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintCan)
        end
        ISTimedActionQueue.add(ISPaintSignAction:new(playerObj, wall, paintCan, sign, r,g,b,100));
    end
end

ISPaintMenu.onPaint = function(worldobjects, player, thumpable, painting)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    if true or JoypadState.players[player+1] then
        local bo = ISPaintCursor:new(playerObj, "paintThump", { paintType=painting })
        getCell():setDrag(bo, bo.player)
        return
    end
    local props = thumpable:getProperties()
    local isWall = props:Is("WallN") or props:Is("WallW") or
        props:Is("DoorWallN") or props:Is("DoorWallW")
    if isWall then
        local north = props:Is("WallN") or props:Is("DoorWallN")
        if not luautils.walkAdjWall(playerObj, thumpable:getSquare(), north) then
            return
        end
    else
        if not luautils.walkAdj(playerObj, thumpable:getSquare()) then
            return
        end
    end
    local paintCan = nil
    if not ISBuildMenu.cheat then
        local paintBrush = playerInv:getFirstTypeRecurse("Paintbrush")
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintBrush)
        paintCan = playerInv:getFirstTypeRecurse(painting)
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintCan)
    end
    ISTimedActionQueue.add(ISPaintAction:new(playerObj, thumpable, paintCan, painting, 100));
end

ISPaintMenu.onPaper = function( worldobjects, player, thumpable, papering, wallType)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    if true or JoypadState.players[player+1] then
--         getPlayer():Say("Papering " .. tostring(papering))
        local bo = ISPaperCursor:new(playerObj, papering, WallPaper[wallType][papering])
        getCell():setDrag(bo, bo.player)
        return
    end
    local props = thumpable:getProperties()
    local isWall = props:Is("WallN") or props:Is("WallW") or props:Is("DoorWallN") or props:Is("DoorWallW") or props:Is("WindowW") or props:Is("WindowN")
    if isWall then
        local north = props:Is("WallN") or props:Is("DoorWallN") or props:Is("WindowN")
        if not luautils.walkAdjWall(playerObj, thumpable:getSquare(), north) then
            return
        end
    else
        if not luautils.walkAdj(playerObj, thumpable:getSquare()) then
            return
        end
    end
    local paintCan = nil
    if not ISBuildMenu.cheat then
        local paintBrush = playerInv:getFirstTagRecurse("Paintbrush")
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintBrush)
        wallPaper = playerInv:getFirstTypeRecurse(papering)
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, paintCan)
        paste = playerInv:getFirstTagRecurse("WallpaperPaste")
        ISWorldObjectContextMenu.transferIfNeeded(playerObj, paste)
    end
    ISTimedActionQueue.add(ISWallpaperAction:new(playerObj, thumpable, wallPaper, papering));
end

ISPaintMenu.onPlaster = function(worldobjects, player, thumpable, square)
    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()
    if true or JoypadState.players[player+1] then
        local bo = ISPaintCursor:new(playerObj, "plaster")
        getCell():setDrag(bo, bo.player)
        return
    end
	if luautils.walkAdjWall(playerObj, thumpable:getSquare(), thumpable:getNorth()) then
		local plaster = nil
		if not ISBuildMenu.cheat then
			plaster = playerInv:getFirstTypeRecurse("BucketPlasterFull")
			ISWorldObjectContextMenu.transferIfNeeded(playerObj, plaster)
		end
		ISTimedActionQueue.add(ISPlasterAction:new(playerObj, thumpable, plaster));
 	end
end


Events.OnFillWorldObjectContextMenu.Add(ISPaintMenu.doPaintMenu);
