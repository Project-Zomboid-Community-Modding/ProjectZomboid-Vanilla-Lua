--***********************************************************
--**                    THE INDIE STONE                    **
--**				    Author: Aiteron				       **
--***********************************************************

BrushToolTilePickerList = ISPanel:derive("BrushToolTilePickerList")

function BrushToolTilePickerList:render()
    ISPanel.render(self)

    local tileWidth = 64
    local tileHeight = 128
    local maxRow = 1
    for r = 1, 256 do
        for c = 1, 8 do
            local tileName = self.imageName .. "_" .. tostring((c-1) + (r-1)*8)

            if self.posToTileNameTable[r] == nil then self.posToTileNameTable[r] = {} end
            self.posToTileNameTable[r][c] = tileName

            local texture = getTexture(tileName)
            if texture then
                self:drawTextureScaledAspect(texture, (c - 1) * tileWidth, (r - 1) * tileHeight, tileWidth, tileHeight, 1.0, 1.0, 1.0, 1.0)
                maxRow = r
            end
        end
    end

    self:setScrollHeight(maxRow * tileHeight)

    local c = math.floor(self:getMouseX() / tileWidth)
    local r = math.floor(self:getMouseY() / tileHeight)
    if c >= 0 and c < 8 and r >= 0 and r < 128 and self.posToTileNameTable[r+1] ~= nil and self.posToTileNameTable[r+1][c+1] ~= nil then
        self:drawRectBorder(c * tileWidth, r * tileHeight, tileWidth, tileHeight, 0.6, 1, 1, 1)
    end
end

function BrushToolTilePickerList:onMouseWheel(del)
    self:setYScroll(self:getYScroll() - del * 128)
    return true
end

function BrushToolTilePickerList:onMouseDown(x, y)
    local c = math.floor(x / 64)
    local r = math.floor(y / 128)
    if c >= 0 and c < 8 and r >= 0 and r < 128 then
        if self.posToTileNameTable[r+1] ~= nil and self.posToTileNameTable[r+1][c+1] ~= nil then
            local cursor = ISBrushToolTileCursor:new(self.posToTileNameTable[r+1][c+1], self.posToTileNameTable[r+1][c+1], self.character)
            getCell():setDrag(cursor, self.character:getPlayerNum())
        end
    end
end

function BrushToolTilePickerList:new(x, y, w, h, character)
    local o = ISPanel.new(self, x, y, w, h)
    o.backgroundColor.a = 1.0
    o.imageName = nil
    o.character = character
    o.posToTileNameTable = {}
    return o
end

---------------------------------------
local TileCategories = {}
TileCategories["advertising_01"] = "[OTHER] "
TileCategories["advertising_02"] = "[OTHER] "
TileCategories["appliances_01"] = "[DECOR] "
TileCategories["appliances_com_01"] = "[FURNITURE] "
TileCategories["appliances_cooking_01"] = "[FURNITURE] "
TileCategories["appliances_cooking_ON_01"] = "[OTHER] "
TileCategories["appliances_laundry_01"] = "[FURNITURE] "
TileCategories["appliances_misc_01"] = "[FURNITURE] "
TileCategories["appliances_radio_01"] = "[FURNITURE] "
TileCategories["appliances_refrigeration_01"] = "[FURNITURE] "
TileCategories["appliances_television_01"] = "[FURNITURE] "
TileCategories["blends_grassoverlays_01"] = "[DECOR] "
TileCategories["blends_natural_01"] = "[FLOOR] "
TileCategories["blends_natural_02"] = "[FLOOR] "
TileCategories["blends_street_01"] = "[FLOOR] "
TileCategories["blends_streetoverlays_01"] = "[DECOR] "
TileCategories["books&misc_01"] = "[DECOR] "
TileCategories["books&misc_02"] = "[DECOR] "
TileCategories["brokenglass_1"] = "[DECOR] "
TileCategories["camping_01"] = "[FURNITURE] "
TileCategories["carpentry_01"] = "[FURNITURE] "
TileCategories["carpentry_02"] = "[FURNITURE] "
TileCategories["clothing_01"] = "[FURNITURE] "
TileCategories["clothing_02"] = "[FURNITURE] "
TileCategories["constructedobjects_01"] = "[FURNITURE] "
TileCategories["construction_01"] = "[FURNITURE] "
TileCategories["crafted_01"] = "[OTHER] "
TileCategories["d_floorleaves_1"] = "[DECOR] "
TileCategories["d_generic_1"] = "[DECOR] "
TileCategories["d_plants_1"] = "[DECOR] "
TileCategories["d_streetcracks_1"] = "[DECOR] "
TileCategories["d_trash_1"] = "[DECOR] "
TileCategories["d_wallcracks_1"] = "[DECOR] "
TileCategories["damaged_objects_01"] = "[DECOR] "
TileCategories["desks_01"] = "[DECOR] "
TileCategories["e_americanholly_1"] = "[PLANT] "
TileCategories["e_americanlinden_1"] = "[PLANT] "
TileCategories["e_canadianhemlock_1"] = "[PLANT] "
TileCategories["e_carolinasilverbell_1"] = "[PLANT] "
TileCategories["e_cockspurhawthorn_1"] = "[PLANT] "
TileCategories["e_dogwood_1"] = "[PLANT] "
TileCategories["e_easternredbud_1"] = "[PLANT] "
TileCategories["e_exterior_snow_1"] = "[FLOOR] "
TileCategories["e_newgrass_1"] = "[DECOR] "
TileCategories["e_newsnow_ground_1"] = "[FLOOR] "
TileCategories["e_redmaple_1"] = "[PLANT] "
TileCategories["e_riverbirch_1"] = "[PLANT] "
TileCategories["e_roof_snow_1"] = "[ROOF] "
TileCategories["e_virginiapine_1"] = "[PLANT] "
TileCategories["e_yellowwood_1"] = "[PLANT] "
TileCategories["electricity_pylon"] = "[OTHER] "
TileCategories["f_bushes_1"] = "[PLANT] "
TileCategories["f_bushes_2"] = "[PLANT] "
TileCategories["f_flowerbed_1"] = "[DECOR] "
TileCategories["f_wallvines_1"] = "[DECOR] "
TileCategories["fencing_01"] = "[WALL] "
TileCategories["fencing_burnt_01"] = "[WALL] "
TileCategories["fencing_damaged_01"] = "[WALL] "
TileCategories["fencing_damaged_02"] = "[WALL] "
TileCategories["fixtures_01"] = "[DECOR] "
TileCategories["fixtures_bathroom_01"] = "[FURNITURE] "
TileCategories["fixtures_bathroom_02"] = "[FURNITURE] "
TileCategories["fixtures_counters_01"] = "[FURNITURE] "
TileCategories["fixtures_doors_01"] = "[DOOR] "
TileCategories["fixtures_doors_02"] = "[DOOR] "
TileCategories["fixtures_doors_fences_01"] = "[DOOR] "
TileCategories["fixtures_doors_frames_01"] = "[DOOR] "
TileCategories["fixtures_escalators_01"] = "[OTHER] "
TileCategories["fixtures_fireplaces_01"] = "[OTHER] "
TileCategories["fixtures_overlay_counters_01"] = "[DECOR] "
TileCategories["fixtures_railings_01"] = "[DECOR] "
TileCategories["fixtures_sinks_01"] = "[FURNITURE] "
TileCategories["fixtures_stairs_01"] = "[OTHER] "
TileCategories["fixtures_windows_01"] = "[WINDOW] "
TileCategories["fixtures_windows_curtains_01"] = "[WINDOW] "
TileCategories["fixtures_windows_curtains_02"] = "[WINDOW] "
TileCategories["floors_burnt_01"] = "[FLOOR] "
TileCategories["floors_exterior_natural_01"] = "[FLOOR] "
TileCategories["floors_exterior_street_01"] = "[FLOOR] "
TileCategories["floors_exterior_tilesandstone_01"] = "[FLOOR] "
TileCategories["floors_interior_carpet_01"] = "[FLOOR] "
TileCategories["floors_interior_tilesandwood_01"] = "[FLOOR] "
TileCategories["floors_overlay_street_01"] = "[DECOR] "
TileCategories["floors_overlay_tiles_01"] = "[DECOR] "
TileCategories["floors_overlay_tiles_02"] = "[DECOR] "
TileCategories["floors_overlay_wood_01"] = "[DECOR] "
TileCategories["floors_rugs_01"] = "[FLOOR] "
TileCategories["food_01"] = "[DECOR] "
TileCategories["food_02"] = "[DECOR] "
TileCategories["furniture_bedding_01"] = "[FURNITURE] "
TileCategories["furniture_seating_indoor_01"] = "[FURNITURE] "
TileCategories["furniture_seating_indoor_02"] = "[FURNITURE] "
TileCategories["furniture_seating_indoor_03"] = "[FURNITURE] "
TileCategories["furniture_seating_outdoor_01"] = "[FURNITURE] "
TileCategories["furniture_shelving_01"] = "[FURNITURE] "
TileCategories["furniture_storage_01"] = "[FURNITURE] "
TileCategories["furniture_storage_02"] = "[FURNITURE] "
TileCategories["furniture_tables_high_01"] = "[FURNITURE] "
TileCategories["furniture_tables_low_01"] = "[FURNITURE] "
TileCategories["industry_01"] = "[OTHER] "
TileCategories["industry_02"] = "[OTHER] "
TileCategories["industry_bunker_01"] = "[OTHER] "
TileCategories["industry_railroad_01"] = "[DECOR] "
TileCategories["industry_railroad_02"] = "[DECOR] "
TileCategories["industry_railroad_03"] = "[DECOR] "
TileCategories["industry_railroad_04"] = "[DECOR] "
TileCategories["industry_railroad_05"] = "[OTHER] "
TileCategories["industry_trucks_01"] = "[OTHER] "
TileCategories["industry_trucks_02"] = "[OTHER] "
TileCategories["invisible_01"] = "[OTHER] "
TileCategories["lighting_indoor_01"] = "[DECOR] "
TileCategories["lighting_outdoor_01"] = "[DECOR] "
TileCategories["location_barn_01"] = "[WALL] "
TileCategories["location_business_bank_01"] = "[OTHER] "
TileCategories["location_business_distillery_01"] = "[DECOR] "
TileCategories["location_business_machinery_01"] = "[DECOR] "
TileCategories["location_business_office_generic_01"] = "[FURNITURE] "
TileCategories["location_community_cemetary_01"] = "[DECOR] "
TileCategories["location_community_church_small_01"] = "[WALL] "
TileCategories["location_community_medical_01"] = "[FURNITURE] "
TileCategories["location_community_park_01"] = "[DECOR] "
TileCategories["location_community_police_01"] = "[DECOR] "
TileCategories["location_community_school_01"] = "[DECOR] "
TileCategories["location_entertainment_gallery_01"] = "[DECOR] "
TileCategories["location_entertainment_gallery_02"] = "[DECOR] "
TileCategories["location_entertainment_theatre_01"] = "[FURNITURE] "
TileCategories["location_farm_accesories_01"] = "[DECOR] "
TileCategories["location_hospitality_sunstarmotel_01"] = "[WALL] "
TileCategories["location_hospitality_sunstarmotel_02"] = "[DECOR] "
TileCategories["location_military_generic_01"] = "[DECOR] "
TileCategories["location_military_knox_01"] = "[DECOR] "
TileCategories["location_military_tent_01"] = "[WALL] "
TileCategories["location_restaurant_bar_01"] = "[FURNITURE] "
TileCategories["location_restaurant_diner_01"] = "[DECOR] "
TileCategories["location_restaurant_generic_01"] = "[FURNITURE] "
TileCategories["location_restaurant_pie_01"] = "[OTHER] "
TileCategories["location_restaurant_pileocrepe_01"] = "[DECOR] "
TileCategories["location_restaurant_pizzawhirled_01"] = "[DECOR] "
TileCategories["location_restaurant_seahorse_01"] = "[WALL] "
TileCategories["location_restaurant_spiffos_01"] = "[WALL] "
TileCategories["location_restaurant_spiffos_02"] = "[DECOR] "
TileCategories["location_restaurant_spiffos_03"] = "[DECOR] "
TileCategories["location_services_beauty_01"] = "[FURNITURE] "
TileCategories["location_sewer_01"] = "[WALL] "
TileCategories["location_shop_accessories_01"] = "[FURNITURE] "
TileCategories["location_shop_accessories_genericsigns_01"] = "[DECOR] "
TileCategories["location_shop_bargNclothes_01"] = "[DECOR] "
TileCategories["location_shop_fossoil_01"] = "[OTHER] "
TileCategories["location_shop_gas2go_01"] = "[OTHER] "
TileCategories["location_shop_generic_01"] = "[FURNITURE] "
TileCategories["location_shop_greenes_01"] = "[WALL] "
TileCategories["location_shop_mall_01"] = "[OTHER] "
TileCategories["location_shop_zippee_01"] = "[FURNITURE] "
TileCategories["location_trailer_01"] = "[WALL] "
TileCategories["location_trailer_02"] = "[FURNITURE] "
TileCategories["office_01"] = "[DECOR] "
TileCategories["overlay_blood_fence_01"] = "[DECOR] "
TileCategories["overlay_blood_floor_01"] = "[DECOR] "
TileCategories["overlay_blood_wall_01"] = "[DECOR] "
TileCategories["overlay_graffiti_wall_01"] = "[DECOR] "
TileCategories["overlay_grime_floor_01"] = "[DECOR] "
TileCategories["overlay_grime_wall_01"] = "[DECOR] "
TileCategories["overlay_messages_wall_01"] = "[DECOR] "
TileCategories["papernotices_01"] = "[DECOR] "
TileCategories["preset_depthmaps_01"] = "[DECOR] "
TileCategories["radio_tower"] = "[DECOR] "
TileCategories["recreational_01"] = "[FURNITURE] "
TileCategories["recreational_sports_01"] = "[OTHER] "
TileCategories["roofs_01"] = "[ROOF] "
TileCategories["roofs_02"] = "[ROOF] "
TileCategories["roofs_03"] = "[ROOF] "
TileCategories["roofs_04"] = "[ROOF] "
TileCategories["roofs_05"] = "[ROOF] "
TileCategories["roofs_accents_01"] = "[ROOF] "
TileCategories["roofs_burnt_01"] = "[ROOF] "
TileCategories["seating_01"] = "[DECOR] "
TileCategories["security_01"] = "[DECOR] "
TileCategories["signs_miscbrands_01"] = "[DECOR] "
TileCategories["signs_one-off_01"] = "[DECOR] "
TileCategories["signs_one-off_02"] = "[DECOR] "
TileCategories["signs_one-off_03"] = "[DECOR] "
TileCategories["signs_one-off_04"] = "[DECOR] "
TileCategories["signs_one-off_05"] = "[DECOR] "
TileCategories["stashes_01"] = "[DECOR] "
TileCategories["storage_01"] = "[DECOR] "
TileCategories["street_curbs_01"] = "[FLOOR] "
TileCategories["street_curbs_01_blend_dark_grass"] = "[FLOOR] "
TileCategories["street_curbs_01_blend_dirt"] = "[FLOOR] "
TileCategories["street_curbs_01_blend_gravel"] = "[FLOOR] "
TileCategories["street_curbs_01_blend_light_grass"] = "[FLOOR] "
TileCategories["street_curbs_01_blend_medium_grass"] = "[FLOOR] "
TileCategories["street_curbs_01_blend_sand"] = "[FLOOR] "
TileCategories["street_curbs_01_blend_street"] = "[FLOOR] "
TileCategories["street_curbs_01_diag"] = "[FLOOR] "
TileCategories["street_curbs_01_diag_2"] = "[FLOOR] "
TileCategories["street_decoration_01"] = "[DECOR] "
TileCategories["street_roadsigns_01"] = "[DECOR] "
TileCategories["street_trafficlines_01"] = "[DECOR] "
TileCategories["street_trafficlines_curb_white_faded"] = "[DECOR] "
TileCategories["street_trafficlines_curb_white_full"] = "[DECOR] "
TileCategories["street_trafficlines_curb_yellow_faded"] = "[DECOR] "
TileCategories["street_trafficlines_curb_yellow_full"] = "[DECOR] "
TileCategories["trash&junk_01"] = "[DECOR] "
TileCategories["trash_01"] = "[DECOR] "
TileCategories["trash_walls_01"] = "[DECOR] "
TileCategories["trashcontainers_01"] = "[FURNITURE] "
TileCategories["underground_01"] = "[WALL] "
TileCategories["vegetation_farm_01"] = "[DECOR] "
TileCategories["vegetation_farming_01"] = "[DECOR] "
TileCategories["vegetation_indoor_01"] = "[DECOR] "
TileCategories["vegetation_ornamental_01"] = "[PLANT] "
TileCategories["walls_burnt_01"] = "[WALL] "
TileCategories["walls_burnt_roofs_01"] = "[WALL] "
TileCategories["walls_commercial_01"] = "[WALL] "
TileCategories["walls_commercial_02"] = "[WALL] "
TileCategories["walls_commercial_03"] = "[WALL] "
TileCategories["walls_decoration_01"] = "[WALL] "
TileCategories["walls_detailing_01"] = "[WALL] "
TileCategories["walls_exterior_house_01"] = "[WALL] "
TileCategories["walls_exterior_house_02"] = "[WALL] "
TileCategories["walls_exterior_roofs_01"] = "[WALL] "
TileCategories["walls_exterior_roofs_02"] = "[WALL] "
TileCategories["walls_exterior_roofs_03"] = "[WALL] "
TileCategories["walls_exterior_roofs_04"] = "[WALL] "
TileCategories["walls_exterior_roofs_05"] = "[WALL] "
TileCategories["walls_exterior_roofs_06"] = "[WALL] "
TileCategories["walls_exterior_roofs_07"] = "[WALL] "
TileCategories["walls_exterior_roofs_08"] = "[WALL] "
TileCategories["walls_exterior_roofs_09"] = "[WALL] "
TileCategories["walls_exterior_wooden_01"] = "[WALL] "
TileCategories["walls_exterior_wooden_02"] = "[WALL] "
TileCategories["walls_garage_01"] = "[WALL] "
TileCategories["walls_garage_02"] = "[WALL] "
TileCategories["walls_house_blocks_01"] = "[DECOR] "
TileCategories["walls_house_blocks_01_MIRRORED"] = "[DECOR] "
TileCategories["walls_house_blocks_LIGHT_01"] = "[DECOR] "
TileCategories["walls_house_blocks_LIGHT_01_MIRRORED"] = "[DECOR] "
TileCategories["walls_house_brick_01"] = "[DECOR] "
TileCategories["walls_house_brick_01_MIRRORED"] = "[DECOR] "
TileCategories["walls_house_brick_LIGHT_01"] = "[DECOR] "
TileCategories["walls_house_brick_LIGHT_01_MIRRORED"] = "[DECOR] "
TileCategories["walls_house_clapboard_01"] = "[DECOR] "
TileCategories["walls_house_clapboard_01_MIRRORED"] = "[DECOR] "
TileCategories["walls_house_clapboard_LIGHT_01"] = "[DECOR] "
TileCategories["walls_house_clapboard_LIGHT_01_MIRRORED"] = "[DECOR] "
TileCategories["walls_house_flatstone_01"] = "[DECOR] "
TileCategories["walls_house_flatstone_01_MIRRORED"] = "[DECOR] "
TileCategories["walls_house_smooth_01"] = "[DECOR] "
TileCategories["walls_house_smooth_01_MIRRORED"] = "[DECOR] "
TileCategories["walls_house_stone_01"] = "[DECOR] "
TileCategories["walls_house_stone_01_MIRRORED"] = "[DECOR] "
TileCategories["walls_house_trailer_01"] = "[DECOR] "
TileCategories["walls_house_trailer_01_MIRRORED"] = "[DECOR] "
TileCategories["walls_house_wood_01"] = "[DECOR] "
TileCategories["walls_house_wood_01_MIRRORED"] = "[DECOR] "
TileCategories["walls_interior_bathroom_01"] = "[WALL] "
TileCategories["walls_interior_cutaways_01"] = "[DECOR] "
TileCategories["walls_interior_detailing_01"] = "[DECOR] "
TileCategories["walls_interior_house_01"] = "[WALL] "
TileCategories["walls_interior_house_02"] = "[WALL] "
TileCategories["walls_interior_house_03"] = "[WALL] "
TileCategories["walls_interior_house_04"] = "[WALL] "
TileCategories["walls_special_01"] = "[DECOR] "
TileCategories["weapons_01"] = "[DECOR] "
TileCategories["z_templates_wallcutaways"] = "[WALL] "


---------------------------------------

BrushToolChooseTileUI = ISCollapsableWindow:derive("BrushToolChooseTileUI");
BrushToolChooseTileUI.instance = nil

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

function BrushToolChooseTileUI.openPanel(x, y, playerObj)
    if y < 0 then y = 0 end
    if BrushToolChooseTileUI.instance == nil then
        local window = BrushToolChooseTileUI:new(x, y, 822, 660, playerObj)
        window:initialise()
        window:addToUIManager()
        BrushToolChooseTileUI.instance = window
    end
end

function BrushToolChooseTileUI:createChildren()
    ISCollapsableWindow.createChildren(self)

    local th = self:titleBarHeight()

    self.searchEntryBox = ISTextEntryBox:new('', 0, th, 300, 20)
    self.searchEntryBox.font = UIFont.Small
    self.searchEntryBox.onTextChange = BrushToolChooseTileUI.onTextChange
    self:addChild(self.searchEntryBox)

    self.imageList = ISScrollingListBox:new(0, self.searchEntryBox:getBottom(), 300, self.height - th - 20);
    self.imageList.anchorBottom = true;
    self.imageList:initialise();
    self.imageList:instantiate();
    self.imageList.itemheight = FONT_HGT_SMALL + 2;
    self.imageList.selected = 0;
    self.imageList.font = UIFont.Small;
    self.imageList.doDrawItem = self.doDrawImageListItem;
    self.imageList.drawBorder = true;
    self.imageList.onmousedown = self.onSelectImage
    self:addChild(self.imageList);

    self.tilesList = BrushToolTilePickerList:new(self.imageList:getRight(), th, self:getWidth() - 300, self:getHeight() - th, self.character)
    self.tilesList.anchorRight = true;
    self.tilesList.anchorBottom = true;
    self.tilesList:initialise();
    self.tilesList:instantiate();
    self.tilesList:addScrollBars();
    self:addChild(self.tilesList);

    self:populateList();
end

function BrushToolChooseTileUI:onTextChange()
    BrushToolChooseTileUI.instance:populateList()
end

function BrushToolChooseTileUI:doDrawImageListItem(y, item, alt)
    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, 0.9, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end
    self:drawText(item.text, 10, y + (self.itemheight - FONT_HGT_SMALL) / 2, 1, 1, 1, 0.9, self.font);
    return y + self.itemheight;
end

function BrushToolChooseTileUI.onSelectImage(_, item)
    BrushToolChooseTileUI.instance.tilesList.imageName = item
end

function BrushToolChooseTileUI:populateList()
    local searchText = self.searchEntryBox:getInternalText()

    self.imageList:clear();
    local bufferImages = {}
    local resultImages = {}
    local images = getWorld():getTileImageNames()
    for i = 0, images:size()-1 do
        local name = luautils.split(images:get(i), ".")[1]
        local catName = TileCategories[name] and TileCategories[name] or "[NEW] "
        if getTexture(name .. "_0") ~= nil and (string.contains(string.lower(catName .. name), string.lower(searchText)) or searchText == "") then
            bufferImages[name] = true
        end
    end

    for v, _ in pairs(bufferImages) do
        local catName = TileCategories[v] and TileCategories[v] or "[NEW] "
        table.insert(resultImages, {(catName .. v), v})
    end
    table.sort(resultImages, function (a, b) return (a[1] < b[1]) end)

    for i = 1, #resultImages do
        self.imageList:addItem(resultImages[i][1], resultImages[i][2]);
    end

    if #self.imageList.items ~= 0 then
        self.tilesList.imageName = self.imageList.items[self.imageList.selected].item
    end
end

function BrushToolChooseTileUI:close()
    BrushToolChooseTileUI.instance = nil
    self:setVisible(false);
    self:removeFromUIManager();
end

function BrushToolChooseTileUI:new(x, y, width, height, character)
    local o = ISCollapsableWindow.new(self, x, y, width, height);
    o:setResizable(false)
    o.title = "Tiles"
    o.character = character
    return o;
end

local function getNameAndNumFromSpriteName(name)
    local len = string.len(name)
    local num = nil
    local strName = nil
    for i = len, 1, -1 do
        local sub = string.sub(name, i, i)
        if sub == "_" then
            strName = string.sub(name, 1, i-1)
            num = tonumber(string.sub(name, i+1, len))
            break
        end
    end
    return strName, num
end

function BrushToolChooseTileUI.OnKeyPressed(key)
    if key == 26 or key == 27 then
        local cell = getCell()
        if cell == nil then return end
        local drag = cell:getDrag(0)
        if drag ~= nil and drag.isTileCursor then
            local name, num = getNameAndNumFromSpriteName(drag.spriteName)
            if key == 26 then
                if num > 0 then
                    num = num - 1
                end
            else
                num = num + 1
            end
            local res = name .. "_" .. tostring(num)
            if getTexture(res) ~= nil then
                local cursor = ISBrushToolTileCursor:new(res, res, getPlayer())
                getCell():setDrag(cursor, 0)
            end
        end
    end
end
Events.OnKeyPressed.Add(BrushToolChooseTileUI.OnKeyPressed)
