--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    Extension to ISBuildMenu containing all entity related functions.
--]]

local SHOW_ALL_MENU = true;

ISEntityBuildMenu = {};
ISEntityBuildMenu.buildables = false;
ISEntityBuildMenu.items = {};

function ISEntityBuildMenu.init(_player)
    local infos, items = ISBuildIsoEntity.GetBuildableEntities(_player);
    ISEntityBuildMenu.buildables = infos;
    ISEntityBuildMenu.items = items;
    return #ISEntityBuildMenu.buildables > 0;
end

function ISEntityBuildMenu.hasSomethingToBuild()
    if true then
        return; --TODO REMOVE
    end
    return ISEntityBuildMenu.buildables and #ISEntityBuildMenu.buildables > 0;
end

function ISEntityBuildMenu.createMenu(_player, _context, _subMenu, _worldObjects)
    if (not ISEntityBuildMenu.hasSomethingToBuild()) and (not SHOW_ALL_MENU) then
        return;
    end

    local buildables = SHOW_ALL_MENU and ISBuildIsoEntity.GetAllBuildableEntities() or ISEntityBuildMenu.buildables;

    --print("buildables = "..tostring(#buildables));
    local cats = {}; -- Meow.
    for _,info in ipairs(buildables) do
        local category = info:getRecipe():getBuildCategory() or "none";
        if not cats[category] then
            cats[category] = {};
        end
        table.insert(cats[category], info);
    end

    table.sort(cats);

    for category, list in pairs(cats) do
        if category~="none" then
            --todo getText("ContextMenu_EntityBuildCat_"..tostring(category))
            local catOption = _subMenu:addOption(getText(category), _worldObjects, nil);
            local subMenuCat = _subMenu:getNew(_subMenu);

            _context:addSubMenu(catOption, subMenuCat);
			ISEntityBuildMenu.buildCategoryMenu(subMenuCat, _player, list);
        end
    end
    if cats.none then
        ISEntityBuildMenu.buildCategoryMenu(_subMenu, _player, cats.none);
    end

    ISEntityBuildMenu.buildables = false;
    ISEntityBuildMenu.items = {};
end

function ISEntityBuildMenu.buildCategoryMenu(_subMenu, _player, _list)
    for _,info in ipairs(_list) do
        local gameEntityScript = info:getScript():getParent();
        local uiConfig = gameEntityScript:getComponentScriptFor(ComponentType.UiConfig);

        local displayName = getText("EC_Entity_DisplayName_Default");
        local buildDescription = getText("EC_Entity_BuildDescription_Default");

        if uiConfig then
            local skinName = uiConfig:getXuiSkinName();
            local entityStyle = uiConfig:getEntityStyle();

            local skin = XuiManager.GetSkin(skinName);
            if not skin then
                skin = XuiManager.GetDefaultSkin();
            end

            if skin then
                local style = skin:getEntityUiStyle(entityStyle);
                if style then
                    if style:getDisplayName() then
                        displayName = style:getDisplayName();
                    end
                    if style:getBuildDescription() then
                        buildDescription = style:getBuildDescription();
                    end
                end
            end
        end

        local entityOption = _subMenu:addOption(displayName, _player, ISEntityBuildMenu.onBuildEntity, info);
        local tooltip = ISEntityBuildMenu.createToolTip(entityOption, _player, info);
        tooltip:setName(displayName);
        tooltip.description = buildDescription .. tooltip.description;
        tooltip:setTexture(info:getMainSpriteNameUI());
    end
end

local function getTool(_info, _inventory)   -- takes: InputScript, ItemContainer -- returns InventoryItem
    if _info then
        local inputScript = _info;
        local entryItems = inputScript:getPossibleInputItems(); -- List<Item>

        local item = false;
        for m=0, entryItems:size()-1 do
            local itemType = entryItems:get(m):getFullName(); -- Item
            local result = _inventory:getAllTypeEvalRecurse(itemType, ISBuildIsoEntity.predicateMaterial);  -- ArrayList<InventoryItem>
            if result:size()>0 then
                item = result:get(0):getFullType();
                break;
            end
        end
        if item then
            return item;
        else
            print("ISEntityBuildMenu.onBuildEntity -> tool item missing!")
            return;
        end
    end
end

function ISEntityBuildMenu.onBuildEntity(_player, _info)
    local containers = ISInventoryPaneContextMenu.getContainers(_player)
    local buildEntity = ISBuildIsoEntity:new(_player, _info, 1, containers);

    local inventory = _player:getInventory();
    local items = ISEntityBuildMenu.items;

    local _recipe = _info:getRecipe():getCraftRecipe();
    buildEntity.equipBothHandItem = getTool(_recipe:getToolBoth(), inventory);
    buildEntity.firstItem = getTool(_recipe:getToolRight(), inventory);
    buildEntity.secondItem = getTool(_recipe:getToolLeft(), inventory);

    getCell():setDrag(buildEntity, _player:getPlayerNum());
end

function ISEntityBuildMenu.createToolTip(_option, _player, info)
    local items = ISEntityBuildMenu.items;

    local tooltip = ISEntityBuildMenu.addToolTip();
	_option.toolTip = tooltip;
	local result = true;
    tooltip.description = "<LINE> <LINE>" .. getText("Tooltip_craft_Needs") .. ": <LINE>";

    local constructItems = info:getRecipe():getCraftRecipe():getInputs();    --ArrayList<InputScript>
    for k=0,constructItems:size()-1 do
        local constructItem = constructItems:get(k);
        local entryItems = constructItem:getPossibleInputItems();    -- List<Item>
        local testUses = not constructItem:isItemCount();
        local required = 1;
        local available = 0;
        if testUses then
            required = constructItem:getAmount();
        else
            required = constructItem:getIntAmount();
        end

        for m=0, entryItems:size()-1 do
            local itemType = entryItems:get(m):getFullName();
            if items[itemType] then
                if testUses then
                    available = available + items[itemType].uses;
                else
                    available = available + items[itemType].count;
                end
            end
        end

        if available>required then
            available = required;
        end

        if available~=required then
            result = false;
        end

        local prefix = (available==required) and " <RGB:1,1,1>" or " <RGB:1,0,0>";

        if entryItems:size()==1 then
            local itemType = entryItems:get(0):getFullName();
            tooltip.description = tooltip.description .. prefix .. getItemNameFromFullType(itemType) .. " " .. tostring(available) .. "/" .. tostring(required) .. " <LINE>";
        else
            tooltip.description = tooltip.description .. " <RGB:1,1,1> " .. tostring(available) .. "/" .. tostring(required) .. " of: <LINE>";
            for m=0, entryItems:size()-1 do
                local itemType = entryItems:get(m):getFullName();
                local itemAvailable = 0;
                if items[itemType] then
                    if testUses then
                        itemAvailable = items[itemType].uses;
                    else
                        itemAvailable = items[itemType].count;
                    end
                end
                tooltip.description = tooltip.description .. prefix .. "* " .. getItemNameFromFullType(itemType) .. ": " .. tostring(available) .. " <LINE>";
            end
        end

    end

	if ISBuildMenu.cheat then
		return tooltip;
	end
	if not result then
		_option.onSelect = nil;
		_option.notAvailable = true;
	end
	tooltip.description = " " .. tooltip.description .. " "
	return tooltip;
end

function ISEntityBuildMenu.addToolTip()
	local toolTip = ISWorldObjectContextMenu.addToolTip();
	toolTip.footNote = getText("Tooltip_craft_pressToRotate", Keyboard.getKeyName(getCore():getKey("Rotate building")))
	return toolTip;
end