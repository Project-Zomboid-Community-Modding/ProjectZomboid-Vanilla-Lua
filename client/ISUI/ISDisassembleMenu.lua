ISDisassembleMenu = ISDisassembleMenu or {};

function ISDisassembleMenu.createMenu(worldObjects, context, playerObj)
    local done = {}; -- TODO this is lame, but somehow worldobjects have 2 times the same item sometimes, need to debug it out
    local validObjList = {};
    for _,object in ipairs(worldObjects) do
        if not done[object] then
            local square = object:getSquare();
            if square then
                local moveProps = ISMoveableSpriteProps.fromObject(object);
                -- Check for partially-destroyed multi-tile objects.
                if moveProps.isMultiSprite then
                    local grid = moveProps:getSpriteGridInfo(object:getSquare(), true)
                    if not grid then moveProps = nil end
                end
                if moveProps then
                    local resultScrap, chance, perkName = moveProps:canScrapObject(playerObj);
                    if resultScrap.craftValid then
                        table.insert(validObjList, { object = object, moveProps = moveProps, square = square, chance = chance, perkName = perkName, resultScrap = resultScrap });
                    end
                end
            end
            done[object] = true;
        end
    end

    if #validObjList == 0 then
        return;
    end

    local disassembleMenu = context:addOption(getText("ContextMenu_Disassemble"), playerObj, nil);
    disassembleMenu.iconTexture = getTexture("Item_Hammer");
    local subMenu = ISContextMenu:getNew(context);
    context:addSubMenu(disassembleMenu, subMenu);

    local tooltipFont = ISToolTip.GetFont()
    local hc = getCore():getBadHighlitedColor();

    for k,v in ipairs(validObjList) do
        local infoTable = v.moveProps:getInfoPanelDescription(v.square, v.object, playerObj, "scrap");

        local option = subMenu:addOption(Translator.getMoveableDisplayName(v.moveProps.name), playerObj, ISDisassembleMenu.disassemble, v);
        option.notAvailable = not v.resultScrap.canScrap;

        local toolTip = ISToolTip:new();
        toolTip:initialise();
        toolTip:setVisible(false);
        toolTip.description = "";

        local column2 = 0;
        for _,t1 in ipairs(infoTable) do
            if #t1 == 2 then
                local textWid = getTextManager():MeasureStringX(tooltipFont, t1[1].txt);
                column2 = math.max(column2, textWid + 10)
            end
        end

        for _,t1 in ipairs(infoTable) do
            toolTip.description = string.format("%s <RGB:%.2f,%.2f,%.2f> %s", toolTip.description, t1[1].r / 255, t1[1].g / 255, t1[1].b / 255, t1[1].txt);
            if #t1 == 2 then
                toolTip.description = string.format("%s <SETX:%d> <INDENT:%d> <RGB:%.2f,%.2f,%.2f> %s", toolTip.description, column2, column2, t1[2].r / 255, t1[2].g / 255, t1[2].b / 255, t1[2].txt);
            end
            toolTip.description = toolTip.description .. " <LINE> <INDENT:0> ";
        end
        toolTip:setTexture(v.moveProps.spriteName);
        option.toolTip = toolTip;

        option.onHighlightParams = { v.moveProps.object, hc };
        option.onHighlight = function(_option, _menu, _isHighlighted, _object, _color)
            if _object == nil then return end
            if _isHighlighted then
                _object:setHighlightColor(_menu.player, _color);
                _object:setOutlineHighlightCol(_menu.player, _color);
            end
            _object:setHighlighted(_menu.player, _isHighlighted, false);
            _object:setOutlineHighlight(_menu.player, _isHighlighted);
            _object:setOutlineHlAttached(_menu.player, _isHighlighted);
            ISInventoryPage.OnObjectHighlighted(_menu.player, _object, _isHighlighted)
        end
    end
end

function ISDisassembleMenu.disassemble(playerObj, _v)
    if _v and _v.moveProps and _v.square and _v.object then
        if _v.moveProps:canScrapObject(playerObj) and _v.square:getObjects():contains(_v.object) then
            if _v.moveProps:walkToAndEquip(playerObj, _v.square, "scrap" ) or ISMoveableDefinitions.cheat then
                if instanceof(_v.object,"IsoLightSwitch") and _v.object:hasLightBulb() then
                    ISTimedActionQueue.add(ISLightActions:new("RemoveLightBulb",playerObj, _v.object));
                end
                if _v.object:getProperties():has(IsoFlagType.solidfloor) then
                    local adjacent = AdjacentFreeTileFinder.Find(_v.square, playerObj)
                    if adjacent ~= nil then
                        ISTimedActionQueue.add(ISWalkToTimedAction:new(playerObj, adjacent))
                    end
                end
                local direction = _v.moveProps:getFaceDirectionFromSpriteName(_v.moveProps.sprite:getName())
                local object, sprInstance = _v.moveProps:findOnSquare(_v.square, _v.moveProps.spriteName);
                ISTimedActionQueue.add(ISMoveablesAction:new(playerObj, _v.square, "scrap", nil, object, direction, nil, nil ));
            end
        end
    end
end
