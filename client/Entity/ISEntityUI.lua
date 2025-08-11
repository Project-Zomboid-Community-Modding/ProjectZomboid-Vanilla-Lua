--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    UI System for GameEntity->Components
--]]

--local _print = print;
--local function log(DebugType.CraftLogic, _s)
--    _log(DebugType.CraftLogic, "ISEntityUI -> "..tostring(_s));
--end

ISEntityUI = {};
ISEntityUI.drawDebugLines = false;
ISEntityUI.players = {};

ISEntityUI.isoPanelWalkToDist = 3;

function ISEntityUI.WalkToEntity( _player, _entity, _dist )
    if _player and _entity and instanceof(_entity, "IsoObject") then
        local square = _entity:getSquare();
        if not square then
            return false;
        end
        local dist = _dist or ISEntityUI.isoPanelWalkToDist;
        if _player:getX() < square:getX()-dist or _player:getX() > square:getX()+dist or _player:getY() < square:getY()-dist or _player:getY() > square:getY()+dist then
            return luautils.walkAdj( _player, square, false );
        else
            return true;
        end
    end
    return false;
end

function ISEntityUI.ItemSlotRemoveSingleItem( _player, _entity, _itemSlot, _item )
    if ISEntityUI.WalkToEntity( _player, _entity) then
        local action = ISItemSlotRemoveAction:new(_player, _entity, _itemSlot.resource, _item)
        action.itemSlot = _itemSlot
        ISTimedActionQueue.add(action);
    end
end

function ISEntityUI.ItemSlotRemoveItems( _player, _entity, _itemSlot )
    if ISEntityUI.WalkToEntity( _player, _entity) then
        for i=0,_itemSlot.resource:getItemAmount()-1 do
            local action = ISItemSlotRemoveAction:new(_player, _entity, _itemSlot.resource)
            action.itemSlot = _itemSlot
            ISTimedActionQueue.add(action);
        end
    end
end

function ISEntityUI.ItemSlotAddItems( _player, _entity, _itemSlot, _itemList )
    if #_itemList>0 and ISEntityUI.WalkToEntity( _player, _entity) then
        for index,item in ipairs(_itemList) do --todo remove For loop and handle list of items in Action
            if index<=_itemSlot.resource:getFreeItemCapacity() then
                local action = ISItemSlotAddAction:new(_player, _entity, item, _itemSlot.resource)
                action.itemSlot = _itemSlot
                ISTimedActionQueue.add(action);
            end
        end
    end
end

--todo deprecated:
--[[
function ISEntityUI.CraftProcessorStart( _player, _entity, _component, _craftProcessor )
    --if ISTimedActionQueue.hasActionType(_player, ISCraftAnimAction.Type) then
    --    return;
    --end
    if (not _player) or (not _entity) or (not _component) or (not _craftProcessor) then
        log(DebugType.CraftLogic, "Invalid parameters for ISEntityUI.CraftProcessorStart");
        log(DebugType.CraftLogic, "params-><"..tostring(_player).."><"..tostring(_entity).."><"..tostring(_component).."><"..tostring(_craftProcessor))
        return;
    end

    if not _craftProcessor:canStart(_player) then
        return;
    end

    if ISEntityUI.WalkToEntity( _player, _entity) then
        local action = ISStartCraftProcessorAction:new(_player, _entity, _component, _craftProcessor)
        ISTimedActionQueue.add(action);
        return true;
    end
end
--]]

function ISEntityUI.GenericCraftStart( _player, _entity, _component, _funcCanStart, _funcStart )
    --if ISTimedActionQueue.hasActionType(_player, ISCraftAnimAction.Type) then
    --    return;
    --end
    if (not _player) or (not _entity) or (not _component) or (not _funcCanStart) or (not _funcStart) then
        log(DebugType.CraftLogic, "Invalid parameters for ISEntityUI.CraftProcessorStart");
        log(DebugType.CraftLogic, "params-><"..tostring(_player).."><"..tostring(_entity).."><"..tostring(_component).."><"..tostring(_funcCanStart).."><"..tostring(_funcStart))
        return;
    end

    if not _funcCanStart(_player, _entity, _component) then
        return;
    end

    if ISEntityUI.WalkToEntity( _player, _entity) then
        local action = ISGenericCraftStart:new(_player, _entity, _component, _funcCanStart, _funcStart)
        ISTimedActionQueue.add(action);
        return true;
    end
end

function ISEntityUI.HandcraftStart( _player, _handcraftLogic, force, addToQueue ) --_recipeData, _craftBench, _isoObject)
    if (not _player) or (not _handcraftLogic) then --or (not _craftBench) then
        log(DebugType.CraftLogic, "Invalid parameters for ISEntityUI.HandcraftStart");
        log(DebugType.CraftLogic, "params-><required:"..tostring(_player).."><required:"..tostring(_handcraftLogic)..">"); --.."><optional:"..tostring(_craftBench).."><optional:"..tostring(_isoObject))
        return;
    end

    --local resources = _craftBench and _craftBench:getResources();
    if _player~=_handcraftLogic:getPlayer() then
        log(DebugType.CraftLogic, "HandcraftStart -> player mismatch with logic.player")
    end

    if not _handcraftLogic:canPerformCurrentRecipe() and not force then
        log(DebugType.CraftLogic, "Aborting ISEntityUI.HandcraftStart, cannot perform.")
        return;
    end

    if (not _handcraftLogic:getRecipe():isAnySurfaceCraft()) or (_handcraftLogic:getIsoObject() and ISEntityUI.WalkToEntity( _player, _handcraftLogic:getIsoObject())) then
        local action = ISHandcraftAction.FromLogic(_handcraftLogic); --:new(_player, _recipeData, _craftBench, _isoObject)
        action.force = force
        if addToQueue then
            ISTimedActionQueue.add(action);
        end
        return action;
    else
        log(DebugType.CraftLogic, "Aborting ISEntityUI.HandcraftStart, cannot walk to craftbench.")
    end
end

function ISEntityUI.HandcraftStartMultiple( _player, _handcraftLogic, force, qty, addToQueue)
    if (not _player) or (not _handcraftLogic) then --or (not _craftBench) then
        log(DebugType.CraftLogic, "Invalid parameters for ISEntityUI.HandcraftStartMultiple");
        log(DebugType.CraftLogic, "params-><required:"..tostring(_player).."><required:"..tostring(_handcraftLogic)..">"); --.."><optional:"..tostring(_craftBench).."><optional:"..tostring(_isoObject))
        return;
    end

    --local resources = _craftBench and _craftBench:getResources();
    if _player~=_handcraftLogic:getPlayer() then
        log(DebugType.CraftLogic, "HandcraftStartMultiple -> player mismatch with logic.player")
    end

    -- refresh craft count and inputs
    if _handcraftLogic:getPossibleCraftCount(true) < qty and not force then
        log(DebugType.CraftLogic, "Aborting ISEntityUI.HandcraftStartMultiple, cannot perform.")
        return;
    end

    local actions = {};
    if (not _handcraftLogic:getRecipe():isAnySurfaceCraft()) or (_handcraftLogic:getIsoObject() and ISEntityUI.WalkToEntity( _player, _handcraftLogic:getIsoObject())) then
        for i = 0, qty-1 do
            -- create action
            local action = ISHandcraftAction.FromLogicMultiple(_handcraftLogic);
            action.force = force
            if addToQueue then
                ISTimedActionQueue.add(action);
            end

            table.insert(actions, action);
        end
    else
        log(DebugType.CraftLogic, "Aborting ISEntityUI.HandcraftStartMultiple, cannot walk to craftbench.")
    end

    return actions;
end

function ISEntityUI.GetEntityUiConfig(_entity)
    if _entity and _entity:hasComponent(ComponentType.UiConfig) then
        return _entity:getComponent(ComponentType.UiConfig);
    end
end

function ISEntityUI.GetEntityUiStyle(_entity)
    local config = ISEntityUI.GetEntityUiConfig(_entity);
    if config then
        return config:getEntityUiStyle();
    end
end

function ISEntityUI.GetEntityUiSkin(_entity)
    local config = ISEntityUI.GetEntityUiConfig(_entity);
    if config then
        return config:getSkinOrDefault();
    end
end

function ISEntityUI.GetComponentPanelClass(_player, _entity, _componentType)
    if _player and _entity and _componentType and _entity:hasComponent(_componentType) then
        local component = _entity:getComponent(_componentType);

        if not component then
            return nil, nil, nil;
        end

        if not component:isValid() then
            log(DebugType.CraftLogic, "Skipping component '"..tostring(_componentType).."', component is isValid() returned false!")
            return nil, nil, nil;
        end

        local entityStyle = ISEntityUI.GetEntityUiStyle(_entity);

        local componentUiStyle = entityStyle and entityStyle:getComponentUiStyle(_componentType);
        if (not componentUiStyle) or (not componentUiStyle:isEnabled()) then
            return nil, nil, nil;
        end

        if componentUiStyle:getLuaPanelClass() and _G[componentUiStyle:getLuaPanelClass()] then
            local panelClass = _G[componentUiStyle:getLuaPanelClass()];

            if panelClass.CanCreatePanelFor then
                if panelClass.CanCreatePanelFor(_player, _entity, component, componentUiStyle) then
                    return panelClass, component, componentUiStyle;
                end
            else
                log(DebugType.CraftLogic, "Panel class '"..tostring(componentUiStyle:getLuaPanelClass()).."' has no 'CanCreatePanelFor' method")
            end
        else
            log(DebugType.CraftLogic, "Component '"..tostring(_componentType).."' has no (existing?) 'LuaPanelClass' set")
        end
    end
    return nil, nil, nil;
end

local sortPanels = function (a, b)
    return a.uiStyle:getListOrderZ() > b.uiStyle:getListOrderZ();
end

local function getComponentPanelsInternal(_player, _entity, _test, _dontInstantiate)
    local panels = (not _test) and {} or false;
    if _player and _entity then
        local entityStyle = ISEntityUI.GetEntityUiStyle(_entity);
        local skin = ISEntityUI.GetEntityUiSkin(_entity);

        if entityStyle and skin then
            local cnt = _entity:componentSize();
            for i=0,cnt-1 do
                local component = _entity:getComponentForIndex(i);
                local componentType = component:getComponentType();

                local panelClass, _nil, uiStyle = ISEntityUI.GetComponentPanelClass(_player, _entity, componentType);

                if panelClass and component and uiStyle then
                    if _test then
                        return true;
                    end

                    local v = {
                        panelClass = panelClass,
                        component = component,
                        uiStyle = uiStyle,
                    };

                    table.insert(panels, v);

                    if not _dontInstantiate then
                        local styleName = v.uiStyle:getXuiStyle();
                        --local panel = v.panelClass:new(skin, styleName, 0, 0, 100, 100, _player, _entity, v.component, v.uiScript);
                        local panel = ISXuiSkin.build(skin, styleName, v.panelClass, 0, 0, 100, 100, _player, _entity, v.component, v.uiStyle);
                        panel:initialise();
                        panel:instantiate();
                        v.panel = panel;
                    end
                end
            end
        end

        if not _test then
            table.sort(panels, sortPanels);
        end
    end

    return panels;
end

function ISEntityUI.GetComponentPanels(_player, _entity, _dontInstantiate)
    return getComponentPanelsInternal(_player, _entity, false, _dontInstantiate);
end

function ISEntityUI.HasComponentPanels(_player, _entity)
    return getComponentPanelsInternal(_player, _entity, true, true);
end

function ISEntityUI.GetWindowClass(_entity)
    if _entity then
        local uiStyle = ISEntityUI.GetEntityUiStyle(_entity);

        if uiStyle and uiStyle:getLuaWindowClass() then
            local windowClass = uiStyle:getLuaWindowClass();
            if _G[windowClass] then
                return _G[windowClass];
            end
        end
    end
    return nil;
end

function ISEntityUI.GetWindowStyleName(_entity)
    if _entity then
        local uiStyle = ISEntityUI.GetEntityUiStyle(_entity);

        if uiStyle then
            return uiStyle:getXuiStyle();
        end
    end
    return nil;
end

function ISEntityUI.GetCustomCanOpenWindowFunc(_entity)
    if _entity then
        local uiStyle = ISEntityUI.GetEntityUiStyle(_entity);

        if uiStyle then
            return uiStyle:getLuaCanOpenWindow();
        end
    end
    return nil;
end

function ISEntityUI.GetCustomOpenWindowFunc(_entity)
    if _entity then
        local uiStyle = ISEntityUI.GetEntityUiStyle(_entity);

        if uiStyle then
            return uiStyle:getLuaOpenWindow();
        end
    end
    return nil;
end

function ISEntityUI.CanOpenWindowFor(_player, _entity)
    --[[
    local skin = ISEntityUI.GetEntityUiSkin(_entity);
    if skin then
        skin:debuglog(DebugType.CraftLogic, );
    end
    --]]

    local customFunction = ISEntityUI.GetCustomCanOpenWindowFunc(_entity);

    if customFunction and customFunction~=ISEntityUI.CanOpenWindowFor then
        return customFunction(_player, _entity);
    end

    local config = ISEntityUI.GetEntityUiConfig(_entity);
    if (not config) or (not config:isUiEnabled()) then
        return false;
    end

    local windowClass = ISEntityUI.GetWindowClass(_entity);
    if windowClass then
        if windowClass.CanOpenWindowFor then
            return windowClass.CanOpenWindowFor(_player, _entity);
        else
            return true;
        end
    end
    return false;
end

--shared logic for OpenWindow and OpenHandcraftWindow
local function createWindow(_player, _windowInstance, _isoObject)
    local playerNum = _player:getPlayerNum();

    local x = getMouseX() + 10;
    local y = getMouseY() + 10;
    local adjustPos = true;

    local width = 0;
    local height = 0;
    
    local windowKey = _windowInstance.xuiStyleName or (_windowInstance.entity and _windowInstance.entity:getName()) or "Default";
    
    -- close all other entity windows - we only allow one open at the moment. - spurcival
    ISEntityUI.CloseWindows();

    if ISEntityUI.players[playerNum] and ISEntityUI.players[playerNum].windows[windowKey] then
        if ISEntityUI.players[playerNum].windows[windowKey].instance then
            ISEntityUI.players[playerNum].windows[windowKey].instance:close();
        end
        if ISEntityUI.players[playerNum].windows[windowKey].x and ISEntityUI.players[playerNum].windows[windowKey].y then
            x = ISEntityUI.players[playerNum].windows[windowKey].x;
            y = ISEntityUI.players[playerNum].windows[windowKey].y;
            adjustPos = false;
        end
        if ISEntityUI.players[playerNum].windows[windowKey].width and ISEntityUI.players[playerNum].windows[windowKey].height then
            width = ISEntityUI.players[playerNum].windows[windowKey].width;
            height = ISEntityUI.players[playerNum].windows[windowKey].height;
        end
    else
        ISEntityUI.players[playerNum] = ISEntityUI.players[playerNum] or {};
        ISEntityUI.players[playerNum].windows = ISEntityUI.players[playerNum].windows or {};
        ISEntityUI.players[playerNum].windows[windowKey] = {};
    end

    _windowInstance:initialise();
    _windowInstance:instantiate();
    _windowInstance:setX(x);
    _windowInstance:setY(y);
    _windowInstance:setVisible(true);
    if _windowInstance.calculateLayout then
        _windowInstance:calculateLayout(width,height);
    end
    _windowInstance:addToUIManager();

    ISEntityUI.players[playerNum].windows[windowKey].instance = _windowInstance;
    ISEntityUI.players[playerNum].windows[windowKey].playerObj = _player;
    ISEntityUI.players[playerNum].windows[windowKey].entityObj = _isoObject;

    --first time open panel and isoobject then middle of screen.
    if adjustPos and instanceof(_isoObject, "IsoObject") then
        local x = (getCore():getScreenWidth()/2) - (_windowInstance:getWidth()/2);
        local y = (getCore():getScreenHeight()/2) - (_windowInstance:getHeight()/2);
        _windowInstance:setX(x);
        _windowInstance:setY(y);
        ISEntityUI.players[playerNum].windows[windowKey].x = x;
        ISEntityUI.players[playerNum].windows[windowKey].y = y;
    end

    if JoypadState.players[playerNum+1] then
        if getFocusForPlayer(playerNum) then getFocusForPlayer(playerNum):setVisible(false); end
        if getPlayerInventory(playerNum) then getPlayerInventory(playerNum):close(); end
        if getPlayerLoot(playerNum) then getPlayerLoot(playerNum):close(); end
        --setJoypadFocus(playerNum, nil);
        setJoypadFocus(playerNum, _windowInstance);
    end
end

--****************************************************
-- Main entry for opening entity UI windows
--****************************************************
function ISEntityUI.OpenWindow(_player, _entity)

    if not ISEntityUI.CanOpenWindowFor(_player, _entity) then
        return;
    end

    if not ISEntityUI.CanPlayerUseEntity(_player, _entity) then
        log(DebugType.CraftLogic, "Object already in use by other player.")
        return;
    end

    local customFunction = ISEntityUI.GetCustomOpenWindowFunc(_entity);

    if customFunction and customFunction~=ISEntityUI.OpenWindow then
        customFunction(_player, _entity);
        return;
    end

    local windowClass = ISEntityUI.GetWindowClass(_entity);

    if windowClass then
        local skin = ISEntityUI.GetEntityUiSkin(_entity);
        local windowStyle = ISEntityUI.GetWindowStyleName(_entity);
        --local ui = windowClass:new(skin, windowStyle, x, y, 60, 30, _player, _entity, ISEntityUI.GetEntityUiStyle(_entity));
        local windowInstance = ISXuiSkin.build(skin, windowStyle, windowClass, 0, 0, 60, 30, _player, _entity, ISEntityUI.GetEntityUiStyle(_entity));
        createWindow(_player, windowInstance, _entity);
    else
        log(DebugType.CraftLogic, "Cannot find window: "..tostring(_entity));
    end
end

function ISEntityUI.OnCloseWindow(_window)
    local windowKey = _window.xuiStyleName or (_window.entity and _window.entity:getName()) or "Default";
    if _window and _window.playerNum and ISEntityUI.players[_window.playerNum] and ISEntityUI.players[_window.playerNum].windows[windowKey] then
        if not ISEntityUI.players[_window.playerNum].windows[windowKey].instance then
            log(DebugType.CraftLogic, "No window instance found!");
            return;
        end

        if ISEntityUI.players[_window.playerNum].windows[windowKey].instance==_window then
            ISEntityUI.players[_window.playerNum].windows[windowKey].x = _window:getX();
            ISEntityUI.players[_window.playerNum].windows[windowKey].y = _window:getY();
            ISEntityUI.players[_window.playerNum].windows[windowKey].width = _window:getWidth();
            ISEntityUI.players[_window.playerNum].windows[windowKey].height = _window:getHeight();
            ISEntityUI.players[_window.playerNum].windows[windowKey].playerObj = nil;
            ISEntityUI.players[_window.playerNum].windows[windowKey].entityObj = nil;
            ISEntityUI.players[_window.playerNum].windows[windowKey].instance = nil;
        else
            log(DebugType.CraftLogic, "Closing window not current instance!");
        end
    else
        log(DebugType.CraftLogic, "Window nil or playerNum missing!");
    end
end

function ISEntityUI.CanPlayerUseEntity(_player, _entity)
    if instanceof(_entity, "InventoryItem") then
        return true;
    end
    if _entity:getUsingPlayer()~=nil and _entity:getUsingPlayer()~=_player then
        return false;
    end
    return true;
end

function ISEntityUI.GetReloadTable()
    local t = {};
    for k,v in pairs(ISEntityUI.players) do
        if v.windows then
            for kk,vv in pairs(v.windows) do
                if vv.instance then
            table.insert(t, {
                player = vv.playerObj,
                entity = vv.entityObj,
            });
        end
    end
        end
    end
    return t;
end

function ISEntityUI.CloseWindows()
    for k,v in pairs(ISEntityUI.players) do
        if v.windows then
            for kk,vv in pairs(v.windows) do
                if vv.instance and vv.instance.close then
                    vv.instance:close();
                end
            end
        end
    end
end

function ISEntityUI.OpenBuildWindow(_player, _isoObject, _queryOverride, _ignoreFindSurface, recipe)
    local windowInstance = ISXuiSkin.build(skin, "BuildWindow", ISBuildWindow, 0, 0, 60, 30, _player, _isoObject, _queryOverride);
    createWindow(_player, windowInstance, _isoObject);

    if recipe then windowInstance.BuildPanel.logic:setRecipe(recipe) end;
end

--****************************************************
-- Main entry for opening non-entity Craft windows
--****************************************************
function ISEntityUI.OpenHandcraftWindow(_player, _isoObject, _queryOverride, _ignoreFindSurface, recipe, itemString)
    if (not _isoObject) and (not _ignoreFindSurface) then
    -- reduced the radius because only adjacent squares will pass as valid for ISOGridSquare canReachTo tests.
    -- we probably need to restrict crafting to adjacent square anyways because of all the edge case permutations that would emerge otherwise
        _isoObject = ISEntityUI.FindCraftSurface(_player, 1);
--         _isoObject = ISEntityUI.FindCraftSurface(_player, 4);
    end

    local skin = XuiManager.GetDefaultSkin(); --ISEntityUI.GetEntityUiSkin(_entity);
    local windowStyle = "HandcraftWindow"; --ISEntityUI.GetWindowStyleName(_entity);
    local windowInstance = ISXuiSkin.build(skin, windowStyle, ISHandcraftWindow, 0, 0, 60, 30, _player, _isoObject, _queryOverride);
    createWindow(_player, windowInstance, _isoObject);
    windowInstance:bringToTop()

    if recipe then windowInstance.handCraftPanel.logic:setRecipe(recipe) end;

    if itemString then
        windowInstance.handCraftPanel._filterString = itemString;
        windowInstance.handCraftPanel._filterMode = "InputName";
        windowInstance.handCraftPanel:filterRecipeList();
        windowInstance.handCraftPanel.recipesPanel.recipeFilterPanel.filterTypeCombo:setSelected(2)
        windowInstance.handCraftPanel.recipesPanel.recipeFilterPanel.entryBox:setText(itemString)
    end

--     if _isoObject  and getCore():getOptionDoContainerOutline() then
--         _isoObject:setOutlineHighlight(true);
--         _isoObject:setOutlineHlAttached(true);
--         _isoObject:setOutlineHighlightCol(1, 1, 1, 1);
--         _isoObject:setOutlineHighlightCol(getCore():getWorkstationHighlitedColor():getR(), getCore():getWorkstationHighlitedColor():getG(), getCore():getWorkstationHighlitedColor():getB(), 1);
--     end
end

function ISEntityUI.FindCraftSurface(_player, _radius)
    if not _player then return; end

    local sx = _player:getX();
    local sy = _player:getY();
    local sz = _player:getZ();

    local done = {};

    for r=0,_radius do
        for x=sx-r,sx+r do
            for y=sy-r,sy+r do
                local square = getCell():getGridSquare(x, y, sz);

                -- added check to ensure that the player can properly access the sqaure in question (ie not in another room; behind a fence; etc)
                if square and _player:getSquare():canReachTo(square) and not done[square] then
                    local objects = square:getObjects();
                    if objects:size()>1 then
                        for i=1,objects:size()-1 do
                            local obj = objects:get(i);
                            -- note that using this specific function is technically redundant, in that it also checks square canReachTo square, but for the sake of consistency still using it
                            if _player:canUseAsGenericCraftingSurface(obj) then return obj end
                        end
                    end
                    done[square] = true;
                end
            end
        end
    end

    return nil;
end