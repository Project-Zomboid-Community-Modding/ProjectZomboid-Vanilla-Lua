--***********************************************************
--**               LEMMY/ROBERT JOHNSON                    **
--***********************************************************

require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISInventoryPane"
require "ISUI/ISResizeWidget"
require "ISUI/ISMouseDrag"
require "ISUI/ISLayoutManager"

require "Definitions/ContainerButtonIcons"

require "defines"

ISInventoryPage = ISPanel:derive("ISInventoryPage");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISInventoryPage.bagSoundDelay = 0.5
ISInventoryPage.bagSoundTime = 0

--************************************************************************--
--** ISInventoryPage:initialise
--**
--************************************************************************--

function ISInventoryPage:initialise()
	ISPanel.initialise(self);
end

function ISInventoryPage:onChangeFilter(selected)

end

function ISInventoryPage:titleBarHeight(selected)
	return math.max(16, self.titleFontHgt + 1)
end

--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function ISInventoryPage:createChildren()
    self.minimumHeight = 100;
    -- This must be buttonSize pixels wider than InventoryPane's minimum width
    -- TODO: parent widgets respect min size of child widgets.
    self.minimumWidth = 256 + self.buttonSize;

    local titleBarHeight = self:titleBarHeight()
    local buttonHeight = titleBarHeight-2 --minus the 1 pixel border, and icon buttons are square
    local buttonOffset = 1 + (5-getCore():getOptionFontSizeReal())*2
    local textButtonOffset = buttonOffset * 3

    self.render3DItemRot = 0;

    local rh = BUTTON_HGT/2+1
    local panel2 = ISInventoryPane:new(0, titleBarHeight, self.width-self.buttonSize, self.height-titleBarHeight-rh-1, self.inventory, self.zoom);
    panel2.anchorBottom = true;
	panel2.anchorRight = true;
    panel2.player = self.player;
	panel2:initialise();

    panel2:setMode("details");

    panel2.inventoryPage = self;
	self:addChild(panel2);

	self.inventoryPane = panel2;

	-- FIXME: It is wrong to have both self.transferAll and ISInventoryPage.transferAll (button and function with the same name).

    local textWid = getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_invpage_Transfer_all"))
    local weightWid = getTextManager():MeasureStringX(UIFont.Small, "9999.99 / 9999")
    self.transferAll = ISButton:new(self.width - 1 - buttonHeight - buttonOffset - weightWid - textButtonOffset - textWid, 0, textWid, buttonHeight, getText("IGUI_invpage_Transfer_all"), self, ISInventoryPage.transferAll);
    self.transferAll:initialise();
    self.transferAll.borderColor.a = 0.0;
    self.transferAll.backgroundColor.a = 0.0;
    self.transferAll.backgroundColorMouseOver.a = 0.7;
    self:addChild(self.transferAll);
    self.transferAll:setVisible(false);

    if not self.onCharacter then
        self.lootAll = ISButton:new(1 + (buttonHeight+buttonOffset)*2, 1, 50, buttonHeight, getText("IGUI_invpage_Loot_all"), self, ISInventoryPage.lootAll);
        self.lootAll:initialise();
        self.lootAll.borderColor.a = 0.0;
        self.lootAll.backgroundColor.a = 0.0;
        self.lootAll.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.lootAll);
        self.lootAll:setVisible(false);
        
        self.removeAll = ISButton:new(self.lootAll:getRight() + textButtonOffset, 1, 50, buttonHeight, getText("IGUI_invpage_RemoveAll"), self, ISInventoryPage.removeAll);
        self.removeAll:initialise();
        self.removeAll.borderColor.a = 0.0;
        self.removeAll.backgroundColor.a = 0.0;
        self.removeAll.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.removeAll);
        self.removeAll:setVisible(false);

        self.toggleStove = ISButton:new(self.lootAll:getRight() + textButtonOffset, 1, 50, buttonHeight, getText("ContextMenu_Turn_On"), self, ISInventoryPage.toggleStove);
        self.toggleStove:initialise();
        self.toggleStove.borderColor.a = 0.0;
        self.toggleStove.backgroundColor.a = 0.0;
        self.toggleStove.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.toggleStove);
        self.toggleStove:setVisible(false);

        self.switchOutfit = ISButton:new(self.lootAll:getRight() + textButtonOffset, 1, 50, buttonHeight, getText("ContextMenu_SwitchOutfit"), self, ISInventoryPage.switchOutfit);
        self.switchOutfit:initialise();
        self.switchOutfit.borderColor.a = 0.0;
        self.switchOutfit.backgroundColor.a = 0.0;
        self.switchOutfit.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.switchOutfit);
        self.switchOutfit:setVisible(false);

        self.storeOutfit = ISButton:new(self.lootAll:getRight() + textButtonOffset, 1, 50, buttonHeight, getText("ContextMenu_StoreOutfit"), self, ISInventoryPage.switchOutfit);
        self.storeOutfit:initialise();
        self.storeOutfit.borderColor.a = 0.0;
        self.storeOutfit.backgroundColor.a = 0.0;
        self.storeOutfit.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.storeOutfit);
        self.storeOutfit:setVisible(false);

        self.wearOutfit = ISButton:new(self.lootAll:getRight() + textButtonOffset, 1, 50, buttonHeight, getText("ContextMenu_WearOutfit"), self, ISInventoryPage.switchOutfit);
        self.wearOutfit:initialise();
        self.wearOutfit.borderColor.a = 0.0;
        self.wearOutfit.backgroundColor.a = 0.0;
        self.wearOutfit.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.wearOutfit);
        self.wearOutfit:setVisible(false);

        self.wearAll = ISButton:new(self.switchOutfit:getRight() + textButtonOffset, 1, 50, buttonHeight, getText("ContextMenu_WearAll"), self, ISInventoryPage.wearAll);
        self.wearAll:initialise();
        self.wearAll.borderColor.a = 0.0;
        self.wearAll.backgroundColor.a = 0.0;
        self.wearAll.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.wearAll);
        self.wearAll:setVisible(false);

--         self.fireTileInfo = ISButton:new(self.lootAll:getRight() + textButtonOffset, 1, 200, buttonHeight, getText("IGUI_BBQ_FuelAmount"), self) -- , ISInventoryPage.displayFireTileInfo);
--         self.fireTileInfo:initialise();
--         self.fireTileInfo.borderColor.a = 0.0;
--         self.fireTileInfo.backgroundColor.a = 0.0;
--         self.fireTileInfo.backgroundColorMouseOver.a = 0.7;
--         self:addChild(self.fireTileInfo);
--         self.fireTileInfo:setVisible(false);

        self.propaneTileToggle = ISButton:new(self.lootAll:getRight() + textButtonOffset, 1, 50, buttonHeight, getText("ContextMenu_Turn_On"), self, ISInventoryPage.togglePropaneTile);
        self.propaneTileToggle:initialise();
        self.propaneTileToggle.borderColor.a = 0.0;
        self.propaneTileToggle.backgroundColor.a = 0.0;
        self.propaneTileToggle.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.propaneTileToggle);
        self.propaneTileToggle:setVisible(false);

        self.removePropaneTileTank = ISButton:new(self.propaneTileToggle:getRight() + textButtonOffset, 1, 50, buttonHeight, getText("ContextMenu_Remove_Propane_Tank"), self, ISInventoryPage.removePropaneTileTank);
        self.removePropaneTileTank:initialise();
        self.removePropaneTileTank.borderColor.a = 0.0;
        self.removePropaneTileTank.backgroundColor.a = 0.0;
        self.removePropaneTileTank.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.removePropaneTileTank);
        self.removePropaneTileTank:setVisible(false);

        self.addPropaneTileTank = ISButton:new(self.propaneTileToggle:getRight() + textButtonOffset, 1, 50, buttonHeight, getText("ContextMenu_Insert_Propane_Tank"), self, ISInventoryPage.addPropaneTileTank);
--         self.addPropaneTileTank = ISButton:new(self.removePropaneTileTank:getRight() + buttonOffset, 1, 50, buttonHeight, getText("ContextMenu_Insert_Propane_Tank"), self, ISInventoryPage.addPropaneTileTank);
        self.addPropaneTileTank:initialise();
        self.addPropaneTileTank.borderColor.a = 0.0;
        self.addPropaneTileTank.backgroundColor.a = 0.0;
        self.addPropaneTileTank.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.addPropaneTileTank);
        self.addPropaneTileTank:setVisible(false);

        self.addFuel = ISButton:new(self.lootAll:getRight() + textButtonOffset, 1, 50, buttonHeight, getText("ContextMenu_DestroyForFuel"), self, ISInventoryPage.addFuelOption);
        self.addFuel:initialise();
        self.addFuel.borderColor.a = 0.0;
        self.addFuel.backgroundColor.a = 0.0;
        self.addFuel.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.addFuel);
        self.addFuel:setVisible(false);

        self.putOut = ISButton:new(self.addFuel:getRight() + textButtonOffset, 1, 50, buttonHeight, getText("ContextMenu_Put_out_fire"), self, ISInventoryPage.putOut);
        self.putOut:initialise();
        self.putOut.borderColor.a = 0.0;
        self.putOut.backgroundColor.a = 0.0;
        self.putOut.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.putOut);
        self.putOut:setVisible(false);

        self.lightFire = ISButton:new(self.addFuel:getRight() + textButtonOffset, 1, 50, buttonHeight, getText("ContextMenu_Light_fire"), self, ISInventoryPage.lightFireOption);
        self.lightFire:initialise();
        self.lightFire.borderColor.a = 0.0;
        self.lightFire.backgroundColor.a = 0.0;
        self.lightFire.backgroundColorMouseOver.a = 0.7;
        self:addChild(self.lightFire);
        self.lightFire:setVisible(false);

    end

    --	local filter = ISRadioOption:new(0, 15, 150, 150, "Filter", self, ISInventoryPage.onChangeFilter);
--	filter:addOption("All");
--	filter:addOption("Weapons/Ammo");
--	filter:addOption("Food/Cooking");
--	filter:addOption("Clothing");
--	filter:addOption("Building");
--	self:addChild(filter);

    local rh = BUTTON_HGT/2+1

    -- Do corner x + y widget
	local resizeWidget = ISResizeWidget:new(self.width-rh, self.height-rh, rh, rh, self);
	resizeWidget:initialise();
	self:addChild(resizeWidget);

	self.resizeWidget = resizeWidget;

    -- Do bottom y widget
    resizeWidget = ISResizeWidget:new(0, self.height-rh, self.width-rh, rh, self, true);
    resizeWidget.anchorLeft = true;
    resizeWidget.anchorRight = true;
    resizeWidget:initialise();
    self:addChild(resizeWidget);

    self.resizeWidget2 = resizeWidget;


    self.closeButton = ISButton:new(1, 1, buttonHeight, buttonHeight, "", self, ISInventoryPage.close);
    self.closeButton:initialise();
    self.closeButton.borderColor.a = 0.0;
    self.closeButton.backgroundColor.a = 0;
    self.closeButton.backgroundColorMouseOver.a = 0;
    self.closeButton:setImage(self.closebutton);
    self.closeButton:setSound('activate', nil) -- see close()
    self:addChild(self.closeButton);
    if getCore():getGameMode() == "Tutorial" then
        self.closeButton:setVisible(false)
    end

    self.infoButton = ISButton:new(1 + buttonHeight + buttonOffset, 1, buttonHeight, buttonHeight, "", self, ISInventoryPage.onInfo);
    self.infoButton:initialise();
    self.infoButton.borderColor.a = 0.0;
    self.infoButton.backgroundColor.a = 0.0;
    self.infoButton.backgroundColorMouseOver.a = 0.7;
    self.infoButton:setImage(self.infoBtn);
    self:addChild(self.infoButton);
    self.infoButton:setVisible(false);

    --  --print("adding pin button");
    self.pinButton = ISButton:new(self.width - 1 - buttonHeight, 1, buttonHeight, buttonHeight, "", self, ISInventoryPage.setPinned);
    self.pinButton.anchorRight = true;
    self.pinButton.anchorLeft = false;
  --  --print("initialising pin button");
    self.pinButton:initialise();
    self.pinButton.borderColor.a = 0.0;
    self.pinButton.backgroundColor.a = 0;
    self.pinButton.backgroundColorMouseOver.a = 0;
   -- --print("setting pin button image");
    self.pinButton:setImage(self.pinbutton);
  --  --print("adding pin button to panel");
    self:addChild(self.pinButton);
  --  --print("set pin button invisible.");
    self.pinButton:setVisible(false);

   -- --print("adding collapse button");
    self.collapseButton = ISButton:new(self.pinButton:getX(), 1, buttonHeight, buttonHeight, "", self, ISInventoryPage.collapse);
    self.collapseButton.anchorRight = true;
    self.collapseButton.anchorLeft = false;
    self.collapseButton:initialise();
    self.collapseButton.borderColor.a = 0.0;
    self.collapseButton.backgroundColor.a = 0;
    self.collapseButton.backgroundColorMouseOver.a = 0;
    self.collapseButton:setImage(self.collapsebutton);
    self:addChild(self.collapseButton);
    if getCore():getGameMode() == "Tutorial" then
        self.collapseButton:setVisible(false);
    end
	-- load the current weight of the container
	self.totalWeight = ISInventoryPage.loadWeight(self.inventory);
	self.totalItems = 0;

    self:refreshBackpacks();

    self:collapse();
end

function ISInventoryPage:updateItemCount()
    self.totalItems = luautils.countItemsRecursive({luautils.findRootInventory(self.inventoryPane.inventory)});
end

function ISInventoryPage:refreshWeight()
	return;
--~ 	for i,v in ipairs(self.backpacks) do
--~ 		v:setOverlayText(ISInventoryPage.loadWeight(v.inventory) .. "/" .. v.capacity);
--~ 	end
end

function ISInventoryPage:lootAll()
    self.inventoryPane:lootAll();
end

function ISInventoryPage:transferAll()
    self.inventoryPane:transferAll();
end

local TurnOnOff = {
	ClothingDryer = {
		isPowered = function(object)
			return object:getContainer() and object:getContainer():isPowered() or false
		end,
		isActivated = function(object)
			return object:isActivated()
		end,
		toggle = function(object)
            if object:getSquare() and luautils.walkAdj(getPlayer(), object:getSquare()) then
                ISTimedActionQueue.add(ISToggleClothingDryer:new(getPlayer(), object))
            end
		end
	},
	ClothingWasher = {
		isPowered = function(object)
			if object:getFluidAmount() <= 0 then return false end
			return object:getContainer() and object:getContainer():isPowered() or false
		end,
		isActivated = function(object)
			return object:isActivated()
		end,
		toggle = function(object)
            if object:getSquare() and luautils.walkAdj(getPlayer(), object:getSquare()) then
                ISTimedActionQueue.add(ISToggleClothingWasher:new(getPlayer(), object))
            end
		end
	},
	CombinationWasherDryer = {
		isPowered = function(object)
			if object:isModeWasher() and (object:getFluidAmount() <= 0) then return false end
			return object:getContainer() and object:getContainer():isPowered() or false
		end,
		isActivated = function(object)
			return object:isActivated()
		end,
		toggle = function(object)
            if object:getSquare() and luautils.walkAdj(getPlayer(), object:getSquare()) then
                ISTimedActionQueue.add(ISToggleComboWasherDryer:new(getPlayer(), object))
            end
		end
	},
	Stove = {
		isPowered = function(object)
			return object:getContainer() and object:getContainer():isPowered() or false
		end,
		isActivated = function(object)
			return object:Activated()
		end,
		toggle = function(object)
            if object:getSquare() and luautils.walkAdj(getPlayer(), object:getSquare()) then
                ISTimedActionQueue.add(ISToggleStoveAction:new(getPlayer(), object))
            end
			--object:Toggle()
		end
	}
}

function ISInventoryPage:toggleStove()
	if UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
		return
	end

	local object = self.inventoryPane.inventory:getParent()
	if not object then return end
	local className = object:getObjectName()
	TurnOnOff[className].toggle(object)
end

function ISInventoryPage:switchOutfit()
	if UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
		return
	end

	local mannequin = self.inventoryPane.inventory:getParent()
	if not mannequin then return end

	local playerObj = getSpecificPlayer(self.player)
	if playerObj:getVehicle() then return end

	if luautils.walkAdj(playerObj, mannequin:getSquare()) then

	    local wornItemsPlayer = playerObj:getWornItems()

        for i=0,wornItemsPlayer:size()-1 do
            local item = wornItemsPlayer:get(i):getItem();
            if item and item:getDisplayName() ~= null then
                if (item:IsClothing() and item:isWorn()) or (instanceof(item, "InventoryContainer") and item:isEquipped()) then
                    ISTimedActionQueue.add(ISUnequipAction:new(playerObj, item, 50))
                end
--                 if item:IsClothing() and item:isWorn() then
--                     ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), mannequin:getContainer()))
--                 elseif instanceof(item, "InventoryContainer") and item:isEquipped() then
--                     ISTimedActionQueue.add(ISUnequipAction:new(playerObj, item, 50))
--                     ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), mannequin:getContainer()))
--                 end
            end
        end

        for i=0,mannequin:getWornItems():size()-1 do
            local item = mannequin:getWornItems():get(i):getItem();
            if item and item:getDisplayName() ~= null then
                ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
                ISTimedActionQueue.add(ISWearClothing:new(playerObj, item, 50))
            end
        end

        for i=0,wornItemsPlayer:size()-1 do
            local item = wornItemsPlayer:get(i):getItem();
            if item and item:getDisplayName() ~= null then
                ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), mannequin:getContainer()))
--                 if item:IsClothing() and item:isWorn() then
--                     ISTimedActionQueue.add(ISUnequipAction:new(playerObj, item, 50))
--                     ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), mannequin:getContainer()))
--                 elseif instanceof(item, "InventoryContainer") and item:isEquipped() then
--                     ISTimedActionQueue.add(ISUnequipAction:new(playerObj, item, 50))
--                     ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), mannequin:getContainer()))
--                 end
            end
        end
	end
end

-- function ISInventoryPage:displayFireTileInfo()
-- 	if UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
-- 		return
-- 	end
--
-- 	local object = self.inventoryPane.inventory:getParent()
-- 	if not object then return end
-- 	ISBBQMenu.onDisplayInfo(nil, self.player, object)
-- end

function ISInventoryPage:togglePropaneTile()
	if UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
		return
	end

	local object = self.inventoryPane.inventory:getParent()
	if not object then return end
	ISBBQMenu.onToggle(nil, self.player, object, nil)
end

function ISInventoryPage:addPropaneTileTank()
	if UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
		return
	end

	local object = self.inventoryPane.inventory:getParent()
	if not object then return end
	local playerObj = getSpecificPlayer(self.player)
    local tank = ISBBQMenu.FindPropaneTank(playerObj, object)
	if not tank then return end
	ISBBQMenu.onInsertPropaneTank(nil, self.player, object, tank)
end

function ISInventoryPage:removePropaneTileTank()
	if UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
		return
	end

	local object = self.inventoryPane.inventory:getParent()
	if not object then return end
	ISBBQMenu.onRemovePropaneTank(nil, self.player, object, nil)
end

function ISInventoryPage:addFuelOption()
	if UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
		return
	end

	local object = self.inventoryPane.inventory:getParent()
	if not object then return end
	local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(object:getSquare())
	local playerObj = getSpecificPlayer(self.player)
	local fuelInfo = ISCampingMenu.getNearbyFuelInfo(playerObj)
	local fuelAmount = 0
	if campfire then
        fuelAmount = campfire.fuelAmt or 0
    else
        fuelAmount = object:getFuelAmount()
    end
    if fuelAmount >= getCampingFuelMax() then
        self.addFuel:setTitle("ContextMenu_Fuel_Full2")
    elseif table.isempty(fuelInfo.fuelList) then
        self.addFuel:setTitle("ContextMenu_No_Fuel")
    end
    local x = self:getX() + self.lootAll:getRight() + ((1 + (5-getCore():getOptionFontSizeReal())*2) * 3)
    local y = self:getY() + self.lootAll:getY() -- - (self.addFuel:getHeight()/2)
    local context = ISContextMenu.get(self.player, x, y)
    if (y < 0) then y = 0 end

	if campfire then
	    ISCampingMenu.doAddFuelOption(context, worldobjects, fuelAmount, fuelInfo, campfire, ISAddFuelAction)
    else
	    ISCampingMenu.doAddFuelOption(context, worldobjects, fuelAmount, fuelInfo, object, ISBBQAddFuel)
    end
end

function ISInventoryPage:putOut()
	if UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
		return
	end

	local object = self.inventoryPane.inventory:getParent()
	if not object then return end
	local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(object:getSquare())
	local playerObj = getSpecificPlayer(self.player)
    if campfire and campfire.isLit then
        if ISCampingMenu.walkToCampfire(playerObj, campfire:getSquare()) then
            ISTimedActionQueue.add(ISPutOutCampfireAction:new(playerObj, campfire));
        end
    else
	    ISBBQMenu.onExtinguish(nil, self.player, object)
    end
end

function ISInventoryPage:lightFireOption()
	if UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
		return
	end

	local object = self.inventoryPane.inventory:getParent()
	if not object then return end
	local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(object:getSquare())
	local playerObj = getSpecificPlayer(self.player)
	local fuelInfo = ISCampingMenu.getNearbyFuelInfo(playerObj)
	local fuelAmount = 0
	if campfire then
        fuelAmount = campfire.fuelAmt or 0
    else
        fuelAmount = object:getFuelAmount()
    end
    local x = self:getX() + self.addFuel:getRight() + ((1 + (5-getCore():getOptionFontSizeReal())*2) * 3)
    local y = self:getY() + self.addFuel:getY() -- - (self.addFuel:getHeight()/2)
    if (y < 0) then y = 0 end
    local context = ISContextMenu.get(self.player, x, y)
    if campfire then
        ISCampingMenu.doLightFireOption(playerObj, context, worldobjects, fuelAmount > 0, fuelInfo, campfire, ISLightFromPetrol, ISLightFromLiterature, ISLightFromKindle)
    else
        ISCampingMenu.doLightFireOption(playerObj, context, nil, object:hasFuel(), fuelInfo, object, ISBBQLightFromPetrol, ISBBQLightFromLiterature, ISBBQLightFromKindle)
	end
end

-- function ISInventoryPage:storeOutfit()
-- 	if UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
-- 		return
-- 	end
--
-- 	local mannequin = self.inventoryPane.inventory:getParent()
-- 	if not mannequin then return end
--
-- 	local playerObj = getSpecificPlayer(self.player)
-- 	if playerObj:getVehicle() then return end
--
-- 	if luautils.walkAdj(playerObj, mannequin:getSquare()) then
--
-- 	    local wornItemsPlayer = playerObj:getWornItems()
--
--         for i=0,wornItemsPlayer:size()-1 do
--             local item = wornItemsPlayer:get(i):getItem();
--             if item and item:getDisplayName() ~= null then
--                 if (item:IsClothing() and item:isWorn()) or (instanceof(item, "InventoryContainer") and item:isEquipped()) then
--                     ISTimedActionQueue.add(ISUnequipAction:new(playerObj, item, 50))
--                     ISTimedActionQueue.add(ISInventoryTransferAction:new(playerObj, item, item:getContainer(), mannequin:getContainer()))
--                 end
--             end
--         end
-- 	end
-- end

function ISInventoryPage:wearAll()
	if UIManager.getSpeedControls() and UIManager.getSpeedControls():getCurrentGameSpeed() == 0 then
		return
	end

	local mannequin = self.inventoryPane.inventory:getParent()
	if not mannequin then return end

	local playerObj = getSpecificPlayer(self.player)
	if playerObj:getVehicle() then return end

	if luautils.walkAdj(playerObj, mannequin:getSquare()) then

        for i=0,mannequin:getWornItems():size()-1 do
            local item = mannequin:getWornItems():get(i):getItem();
            if item and item:getDisplayName() ~= null then
                ISInventoryPaneContextMenu.transferIfNeeded(playerObj, item)
                ISTimedActionQueue.add(ISWearClothing:new(playerObj, item, 50))
            end
        end
	end
end

function ISInventoryPage:syncToggleStove()
	if self.onCharacter then return end
	local isVisible = self.toggleStove:getIsVisible()
	local shouldBeVisible = false
	local stove = nil
	if self.inventoryPane.inventory then
		stove = self.inventoryPane.inventory:getParent()
		if stove then
			local className = stove:getObjectName()
			if TurnOnOff[className] and TurnOnOff[className].isPowered(stove) then
				shouldBeVisible = true
			end
		end
	end
	local containerButton
	for _,cb in ipairs(self.backpacks) do
		if cb.inventory == self.inventoryPane.inventory then
			containerButton = cb
			break
		end
	end
	if not containerButton then
		shouldBeVisible = false
	end
	if isVisible ~= shouldBeVisible and getCore():getGameMode() ~= "Tutorial" then
		self.toggleStove:setVisible(shouldBeVisible)
	end
	if shouldBeVisible then
		local className = stove:getObjectName()
		if TurnOnOff[className].isActivated(stove) then
			self.toggleStove:setTitle(getText("ContextMenu_Turn_Off"))
		else
			self.toggleStove:setTitle(getText("ContextMenu_Turn_On"))
		end
	end
end

function ISInventoryPage:syncSwitchOutfit()
	if self.onCharacter then return end
	local isVisible = self.switchOutfit:getIsVisible()
	local shouldBeVisible = false
	local mannequin = nil
    local playerObj = getSpecificPlayer(self.player)
	if self.inventoryPane.inventory then
		mannequin = self.inventoryPane.inventory:getParent()
	    if instanceof(mannequin, "IsoMannequin") and mannequin:getWornItems():size()>0 and playerObj:getWornItems():size()>0 then
			shouldBeVisible = true
		end
	end
	local containerButton
	for _,cb in ipairs(self.backpacks) do
		if cb.inventory == self.inventoryPane.inventory then
			containerButton = cb
			break
		end
	end
	if not containerButton then
		shouldBeVisible = false
	end
	if isVisible ~= shouldBeVisible then
		self.switchOutfit:setVisible(shouldBeVisible)
	end
end

function ISInventoryPage:syncStoreOutfit()
	if self.onCharacter then return end
	local isVisible = self.storeOutfit:getIsVisible()
	local shouldBeVisible = false
	local mannequin = nil
    local playerObj = getSpecificPlayer(self.player)
	if self.inventoryPane.inventory then
		mannequin = self.inventoryPane.inventory:getParent()
	    if instanceof(mannequin, "IsoMannequin") and mannequin:getWornItems():size()<1 and playerObj:getWornItems():size()>0 then
			shouldBeVisible = true
		end
	end
	local containerButton
	for _,cb in ipairs(self.backpacks) do
		if cb.inventory == self.inventoryPane.inventory then
			containerButton = cb
			break
		end
	end
	if not containerButton then
		shouldBeVisible = false
	end
	if isVisible ~= shouldBeVisible then
		self.storeOutfit:setVisible(shouldBeVisible)
	end
end

function ISInventoryPage:syncWearOutfit()
	if self.onCharacter then return end
	local isVisible = self.wearOutfit:getIsVisible()
	local shouldBeVisible = false
	local mannequin = nil
    local playerObj = getSpecificPlayer(self.player)
	if self.inventoryPane.inventory then
		mannequin = self.inventoryPane.inventory:getParent()
	    if instanceof(mannequin, "IsoMannequin") and mannequin:getWornItems():size()>0 and playerObj:getWornItems():size()<1 then
			shouldBeVisible = true
		end
	end
	local containerButton
	for _,cb in ipairs(self.backpacks) do
		if cb.inventory == self.inventoryPane.inventory then
			containerButton = cb
			break
		end
	end
	if not containerButton then
		shouldBeVisible = false
	end
	if isVisible ~= shouldBeVisible then
		self.wearOutfit:setVisible(shouldBeVisible)
	end
end

function ISInventoryPage:syncWearAll()
	if self.onCharacter then return end
	local isVisible = self.wearAll:getIsVisible()
	local shouldBeVisible = false
	local mannequin = nil
    local playerObj = getSpecificPlayer(self.player)
	if self.inventoryPane.inventory then
		mannequin = self.inventoryPane.inventory:getParent()
	    if instanceof(mannequin, "IsoMannequin") and mannequin:getWornItems():size()>0 and playerObj:getWornItems():size()>0 then
			shouldBeVisible = true
		end
	end
	local containerButton
	for _,cb in ipairs(self.backpacks) do
		if cb.inventory == self.inventoryPane.inventory then
			containerButton = cb
			break
		end
	end
	if not containerButton then
		shouldBeVisible = false
	end
	if isVisible ~= shouldBeVisible then
		self.wearAll:setVisible(shouldBeVisible)
	end
end

-- function ISInventoryPage:syncSetFireTileInfo()
-- 	if self.onCharacter then return end
-- 	local isVisible = self.fireTileInfo:getIsVisible()
-- 	local shouldBeVisible = false
-- 	local fireTile = nil
-- 	local campfire = nil
-- 	if self.inventoryPane.inventory and self.inventoryPane.inventory:getParent() then
-- 		fireTile = self.inventoryPane.inventory:getParent()
-- 		campfire = CCampfireSystem.instance:getLuaObjectOnSquare(fireTile:getSquare())
-- 		local text
-- 		if campfire then
-- 			shouldBeVisible = true
--             local fireState;
--             if campfire.isLit then
--                 fireState = getText("IGUI_Fireplace_Burning")
--             else
--                 fireState = getText("IGUI_Fireplace_Unlit")
--             end
--             local text = getText("IGUI_BBQ_FuelAmount", ISCampingMenu.timeString(luautils.round(campfire.fuelAmt))) .. " (" .. fireState .. ")"
--             self.fireTileInfo:setTitle(text)
-- 	    elseif fireTile and fireTile:isFireInteractionObject() then
-- 			shouldBeVisible = true
--             local fireState;
--             if fireTile:isLit() then
--                 fireState = getText("IGUI_Fireplace_Burning")
--             elseif fireTile:isSmouldering() then
--                 fireState = getText("IGUI_Fireplace_Smouldering")
--             else
--                 fireState = getText("IGUI_Fireplace_Unlit")
--             end
--             local text
--             if fireTile:isPropaneBBQ() and not fireTile:hasPropaneTank() then
--                 text = getText("IGUI_BBQ_NeedsPropaneTank")
--             else
--                 text = getText("IGUI_BBQ_FuelAmount", ISCampingMenu.timeString(fireTile:getFuelAmount())) .. " (" .. fireState .. ")"
--             end
--             self.fireTileInfo:setTitle(text)
-- 		end
-- 	end
-- 	local containerButton
-- 	for _,cb in ipairs(self.backpacks) do
-- 		if cb.inventory == self.inventoryPane.inventory then
-- 			containerButton = cb
-- 			break
-- 		end
-- 	end
-- 	if not containerButton then
-- 		shouldBeVisible = false
-- 	end
-- 	if isVisible ~= shouldBeVisible then
-- 		self.fireTileInfo:setVisible(shouldBeVisible)
-- 	end
-- end

function ISInventoryPage:syncPropaneTileToggle()
	if self.onCharacter then return end
	local isVisible = self.propaneTileToggle:getIsVisible()
	local shouldBeVisible = false
	local fireTile = nil
	if self.inventoryPane.inventory and self.inventoryPane.inventory:getParent() then
		fireTile = self.inventoryPane.inventory:getParent()
	    if fireTile and fireTile:isPropaneBBQ() and fireTile:hasFuel() then
-- 	    if fireTile then
			shouldBeVisible = true
            local text
            if fireTile:isLit() then
                text = getText("ContextMenu_Turn_Off")
            else
                text = getText("ContextMenu_Turn_On")
            end
            self.propaneTileToggle:setTitle(text)
		end
	end
	local containerButton
	for _,cb in ipairs(self.backpacks) do
		if cb.inventory == self.inventoryPane.inventory then
			containerButton = cb
			break
		end
	end
	if not containerButton then
		shouldBeVisible = false
	end
	if isVisible ~= shouldBeVisible then
		self.propaneTileToggle:setVisible(shouldBeVisible)
	end
end

function ISInventoryPage:syncRemovePropaneTileTank()
	if self.onCharacter then return end
	local isVisible = self.removePropaneTileTank:getIsVisible()
	local shouldBeVisible = false
	local fireTile = nil
	if self.inventoryPane.inventory and self.inventoryPane.inventory:getParent() then
		fireTile = self.inventoryPane.inventory:getParent()
	    if fireTile and fireTile:isPropaneBBQ() and fireTile:hasPropaneTank() then
			shouldBeVisible = true
		end
	end
	local containerButton
	for _,cb in ipairs(self.backpacks) do
		if cb.inventory == self.inventoryPane.inventory then
			containerButton = cb
			break
		end
	end
	if not containerButton then
		shouldBeVisible = false
	end
	if isVisible ~= shouldBeVisible then
		self.removePropaneTileTank:setVisible(shouldBeVisible)
	end
end

function ISInventoryPage:syncAddPropaneTileTank()
	if self.onCharacter then return end
	local isVisible = self.addPropaneTileTank:getIsVisible()
	local shouldBeVisible = false
	local fireTile = nil
    local playerObj = getSpecificPlayer(self.player)
	if self.inventoryPane.inventory and self.inventoryPane.inventory:getParent() then
		fireTile = self.inventoryPane.inventory:getParent()
        if fireTile and fireTile:isPropaneBBQ() and (not fireTile:hasPropaneTank()) and ISBBQMenu.FindPropaneTank(playerObj, fireTile) then
--         if fireTile and fireTile:isPropaneBBQ() and ISBBQMenu.FindPropaneTank(playerObj, fireTile) then
			shouldBeVisible = true
			if fireTile:hasPropaneTank() then
                shouldBeVisible = false
            end
		end
	end
	local containerButton
	for _,cb in ipairs(self.backpacks) do
		if cb.inventory == self.inventoryPane.inventory then
			containerButton = cb
			break
		end
	end
	if not containerButton then
		shouldBeVisible = false
	end
	if isVisible ~= shouldBeVisible then
		self.addPropaneTileTank:setVisible(shouldBeVisible)
	end
end

function ISInventoryPage:syncAddFuel()
	if self.onCharacter then return end
	local isVisible = self.addFuel:getIsVisible()
	self.addFuel:setTitle(getText("ContextMenu_DestroyForFuel"))
	local shouldBeVisible = false
	local fireTile = nil
	local campfire = nil
    local playerObj = getSpecificPlayer(self.player)
	local fuelInfo = ISCampingMenu.getNearbyFuelInfo(playerObj)
	if self.inventoryPane.inventory and self.inventoryPane.inventory:getParent() then
		fireTile = self.inventoryPane.inventory:getParent()
		campfire = CCampfireSystem.instance:getLuaObjectOnSquare(fireTile:getSquare())
		if campfire then
			shouldBeVisible = true
			local fuelAmt = campfire.fuelAmt or 0
			if (fuelAmt) >= getCampingFuelMax() then
	            self.addFuel:setTitle(getText("ContextMenu_Fuel_Full2"))
            elseif table.isempty(fuelInfo.fuelList) then
	            self.addFuel:setTitle(getText("ContextMenu_No_Fuel"))
            end
        elseif fireTile and fireTile:isFireInteractionObject() and (not fireTile:isPropaneBBQ()) then
			shouldBeVisible = true
			if fireTile:getFuelAmount() >= getCampingFuelMax() then
	            self.addFuel:setTitle(getText("ContextMenu_Fuel_Full2"))
            elseif table.isempty(fuelInfo.fuelList) then
	            self.addFuel:setTitle(getText("ContextMenu_No_Fuel"))
            end
		end
	end
	local containerButton
	for _,cb in ipairs(self.backpacks) do
		if cb.inventory == self.inventoryPane.inventory then
			containerButton = cb
			break
		end
	end
	if not containerButton then
		shouldBeVisible = false
	end
	if isVisible ~= shouldBeVisible then
		self.addFuel:setVisible(shouldBeVisible)
	end
end

function ISInventoryPage:syncPutOut()
	if self.onCharacter then return end
	local isVisible = self.putOut:getIsVisible()
	local shouldBeVisible = false
	local fireTile = nil
	local campfire = nil
    local playerObj = getSpecificPlayer(self.player)
	local fuelInfo = ISCampingMenu.getNearbyFuelInfo(playerObj)
	if self.inventoryPane.inventory and self.inventoryPane.inventory:getParent() then
		fireTile = self.inventoryPane.inventory:getParent()
		campfire = CCampfireSystem.instance:getLuaObjectOnSquare(fireTile:getSquare())
		if campfire and campfire.isLit then
			shouldBeVisible = true
		    self.lightFire:setVisible(false)
        elseif fireTile and fireTile:isFireInteractionObject() and (not fireTile:isPropaneBBQ()) and fireTile:isLit() then
			shouldBeVisible = true
		    self.lightFire:setVisible(false)
		end
	end
	local containerButton
	for _,cb in ipairs(self.backpacks) do
		if cb.inventory == self.inventoryPane.inventory then
			containerButton = cb
			break
		end
	end
	if not containerButton then
		shouldBeVisible = false
	end
	if isVisible ~= shouldBeVisible then
		self.putOut:setVisible(shouldBeVisible)
	end
end

function ISInventoryPage:syncLightFire()
	if self.onCharacter then return end
	local isVisible = self.lightFire:getIsVisible()
	local shouldBeVisible = false
	local fireTile = nil
	local campfire = nil
    local playerObj = getSpecificPlayer(self.player)
	local fuelInfo = ISCampingMenu.getNearbyFuelInfo(playerObj)
	if self.inventoryPane.inventory and self.inventoryPane.inventory:getParent() then
		fireTile = self.inventoryPane.inventory:getParent()
		campfire = CCampfireSystem.instance:getLuaObjectOnSquare(fireTile:getSquare())
		if campfire and not campfire.isLit then
            if not table.isempty(fuelInfo.starters) and hasFuel and fuelInfo.petrol then
			    shouldBeVisible = true
            elseif not table.isempty(fuelInfo.starters) and not table.isempty(fuelInfo.tinder) then
			    shouldBeVisible = true
            elseif fuelInfo.percedWood and hasFuel and playerObj:getStats():getEndurance() > 0 then
			    shouldBeVisible = true
            end

        elseif fireTile and fireTile:isFireInteractionObject() and (not fireTile:isPropaneBBQ()) and (not fireTile:isLit()) then
            if not table.isempty(fuelInfo.starters) and hasFuel and fuelInfo.petrol then
			    shouldBeVisible = true
            elseif not table.isempty(fuelInfo.starters) and not table.isempty(fuelInfo.tinder) then
			    shouldBeVisible = true
            elseif fuelInfo.percedWood and hasFuel and playerObj:getStats():getEndurance() > 0 then
			    shouldBeVisible = true
            end
		end
	end
	local containerButton
	for _,cb in ipairs(self.backpacks) do
		if cb.inventory == self.inventoryPane.inventory then
			containerButton = cb
			break
		end
	end
	if not containerButton then
		shouldBeVisible = false
	end
	if isVisible ~= shouldBeVisible then
		self.lightFire:setVisible(shouldBeVisible)
	end
end

function ISInventoryPage:setInfo(text)
    self.infoButton:setVisible(true);
    self.infoText = text;
end

function ISInventoryPage:onInfo()
    if not self.infoRichText then
        self.infoRichText = ISModalRichText:new(getCore():getScreenWidth()/2-300,getCore():getScreenHeight()/2-100,600,200,self.infoText, false);
        self.infoRichText:initialise();
        self.infoRichText.backgroundColor = {r=0, g=0, b=0, a=0.9};
        self.infoRichText.chatText:paginate();
        self.infoRichText:setHeightToContents()
        self.infoRichText:setY(getCore():getScreenHeight() / 2-self.infoRichText:getHeight() / 2);
        self.infoRichText:setVisible(true);
        self.infoRichText:addToUIManager();
    elseif self.infoRichText:isReallyVisible() then
        self.infoRichText:removeFromUIManager()
    else
        self.infoRichText:setVisible(true)
        self.infoRichText:addToUIManager()
    end
--    self.infoRichText:paginate();
end

function ISInventoryPage:collapse()
    if ISMouseDrag.dragging and #ISMouseDrag.dragging > 0 then
        return;
    end
    self.pin = false;
    self.collapseButton:setVisible(false);
    self.pinButton:setVisible(true);
    self.pinButton:bringToTop();
    self.inventoryPane:clearWorldObjectHighlights();
end

function ISInventoryPage:setPinned()
    self.pin = true;
    self.collapseButton:setVisible(true);
    self.pinButton:setVisible(false);
    self.collapseButton:bringToTop();
end

function ISInventoryPage:isRemoveButtonVisible()
	if self.onCharacter then return false end
	if self.inventory:isEmpty() then return false end
	if isClient() and not getServerOptions():getBoolean("TrashDeleteAll") then return false end
	local obj = self.inventory:getParent()
	if not instanceof(obj, "IsoObject") then return false end
	local sprite = obj:getSprite()
	return sprite and sprite:getProperties() and sprite:getProperties():Is("IsTrashCan")
end

-- Hack to give priority to another piece of code highlighting an object.
local ObjectsHighlightedElsewhere = {}
ObjectsHighlightedElsewhere[1] = {}
ObjectsHighlightedElsewhere[2] = {}
ObjectsHighlightedElsewhere[3] = {}
ObjectsHighlightedElsewhere[4] = {}
function ISInventoryPage.OnObjectHighlighted(playerNum, object, isHighlighted)
    ObjectsHighlightedElsewhere[playerNum+1][object] = isHighlighted or nil
    local pdata = getPlayerData(playerNum)
    if pdata then
        pdata.playerInventory:updateContainerHighlight()
        pdata.lootInventory:updateContainerHighlight()
    end
end

function ISInventoryPage:getContainerParent(container)
    if not container then return nil end
    if container:getParent() then return container:getParent() end
    local item = container:getContainingItem()
    if item and item:getWorldItem() then
        return item:getWorldItem()
    end
    return nil
end

function ISInventoryPage:updateContainerHighlight()
    local coloredObj = self:getContainerParent(self.coloredInv)
    if coloredObj and ((self.inventory ~= self.coloredInv) or self.isCollapsed) then
        if ObjectsHighlightedElsewhere[self.player+1][coloredObj] then
            -- Another piece of code is highlighting this object, don't change it.
        elseif coloredObj then
            coloredObj:setHighlighted(self.player, false)
            coloredObj:setOutlineHighlight(self.player, false);
            coloredObj:setOutlineHlAttached(self.player, false);
        end
        self.coloredInv = nil;
    end

    coloredObj = self:getContainerParent(self.inventory)
    if ObjectsHighlightedElsewhere[self.player+1][coloredObj] then
        -- Another piece of code is highlighting this object, don't change it.
    elseif not self.isCollapsed then
--        print(self.inventory:getParent());
        if coloredObj and ((not instanceof(coloredObj, "IsoPlayer")) or instanceof(coloredObj, "IsoDeadBody")) then
            coloredObj:setHighlighted(self.player, true, false);
            if getCore():getOptionDoContainerOutline() then -- TODO RJ: this make the player blink, not sure what was wanted here?
                coloredObj:setOutlineHighlight(self.player, true);
                coloredObj:setOutlineHlAttached(self.player, true);
                coloredObj:setOutlineHighlightCol(self.player, getCore():getObjectHighlitedColor():getR(), getCore():getObjectHighlitedColor():getG(), getCore():getObjectHighlitedColor():getB(), 1);
            end
            coloredObj:setHighlightColor(self.player, getCore():getObjectHighlitedColor());
--             coloredObj:setHighlightColor(ColorInfo.new(0.3,0.3,0.3,1));
--             coloredObj:setBlink(true);
--             coloredObj:setCustomColor(0.98,0.56,0.11,1);
            self.coloredInv = self.inventory;
        end
    end
end

function ISInventoryPage:update()
    local playerObj = getSpecificPlayer(self.player)
    if self.inventory:getEffectiveCapacity(playerObj) ~= self.capacity then
        self.capacity = self.inventory:getEffectiveCapacity(playerObj)
    end

    self:updateContainerHighlight()

    if (ISMouseDrag.dragging ~= nil and #ISMouseDrag.dragging > 0) or self.pin then
        self.collapseCounter = 0;
        if isClient() and self.isCollapsed then
            self.inventoryPane.inventory:requestSync();
        end
        self.isCollapsed = false;
        self:clearMaxDrawHeight();
        self.collapseCounter = 0;
    end

    if not self.onCharacter then
        -- add "remove all" button for trash can/bins
        self.removeAll:setVisible(self:isRemoveButtonVisible())

        local playerObj = getSpecificPlayer(self.player)
        if self.lastDir ~= playerObj:getDir() then
            self.lastDir = playerObj:getDir()
            self:refreshBackpacks()
        elseif self.lastSquare ~= playerObj:getCurrentSquare() then
            self.lastSquare = playerObj:getCurrentSquare()
            self:refreshBackpacks()
        end

        -- If the currently-selected container is locked to the player, select another container.
        local object = self.inventory and self.inventory:getParent() or nil
        if #self.backpacks > 1 and instanceof(object, "IsoThumpable") and object:isLockedToCharacter(playerObj) then
            local currentIndex = self:getCurrentBackpackIndex()
            local unlockedIndex = self:prevUnlockedContainer(currentIndex, false)
            if unlockedIndex == -1 then
                unlockedIndex = self:nextUnlockedContainer(currentIndex, false)
            end
            if unlockedIndex ~= -1 then
                if playerObj:getJoypadBind() ~= -1 then
                    self.backpackChoice = unlockedIndex
                end
                self:selectContainer(self.backpacks[unlockedIndex])
            end
        end
    end

	self:syncToggleStove()
	self:syncSwitchOutfit()
	self:syncStoreOutfit()
	self:syncWearOutfit()
	self:syncWearAll()
-- 	self:syncSetFireTileInfo()
	self:syncPropaneTileToggle()
	self:syncRemovePropaneTileTank()
	self:syncAddPropaneTileTank()
	self:syncAddFuel()
	self:syncLightFire()
	self:syncPutOut()
	self:updateContainerOpenCloseSounds()
end

function ISInventoryPage:setBlinkingContainer(blinking, containerType)
	if blinking then
		self.blinkContainer = true;
		self.blinkContainerType = containerType;
	else
		self.blinkContainer = false;
		self.blinkContainerType = nil;
		for i,v in ipairs(self.backpacks) do
			if v.inventory == self.inventoryPane.inventory then
				v:setBackgroundRGBA(0.7, 0.7, 0.7, 1.0)
			else
				v:setBackgroundRGBA(0.0, 0.0, 0.0, 0.0)
			end
		end
	end
end

function ISInventoryPage:setForceSelectedContainer(container, ms)
	self.forceSelectedContainer = container
	self.forceSelectedContainerTime = getTimestampMs() + (ms or 1000)
end

--************************************************************************--
--** ISInventoryPage:prerender
--**
--************************************************************************--
function ISInventoryPage:prerender()
    if self.blinkContainer then
        if not self.blinkAlphaContainer then self.blinkAlphaContainer = 0.7; self.blinkAlphaIncreaseContainer = false; end
        if not self.blinkAlphaIncreaseContainer then
            self.blinkAlphaContainer = self.blinkAlphaContainer - 0.04 * (UIManager.getMillisSinceLastRender() / 33.3);
            if self.blinkAlphaContainer < 0.3 then
                self.blinkAlphaContainer = 0.3;
                self.blinkAlphaIncreaseContainer = true;
            end
        else
            self.blinkAlphaContainer = self.blinkAlphaContainer + 0.04 * (UIManager.getMillisSinceLastRender() / 33.3);
            if self.blinkAlphaContainer > 0.7 then
                self.blinkAlphaContainer = 0.7;
                self.blinkAlphaIncreaseContainer = false;
            end
        end
        for i,v in ipairs(self.backpacks) do
            if (self.blinkContainerType and v.inventory:getType() == self.blinkContainerType) or not self.blinkContainerType then
                if v.inventory == self.inventoryPane.inventory then
                    v:setBackgroundRGBA(1, 0, 0, self.blinkAlphaContainer);
                else
                    v:setBackgroundRGBA(1, 0, 0, self.blinkAlphaContainer * 0.75);
                end
            end
        end
    end

    local titleBarHeight = self:titleBarHeight()
    local height = self:getHeight();
    if self.isCollapsed then
        height = titleBarHeight;
    end

	self:drawRect(0, 0, self:getWidth(), height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);

    if not self.blink then
        self:drawTextureScaled(self.titlebarbkg, 2, 1, self:getWidth() - 4, titleBarHeight - 2, 1, 1, 1, 1);
    else
        if not self.blinkAlpha then self.blinkAlpha = 1; end
        self:drawRect(1, 1, self:getWidth() - 2, titleBarHeight-2, self.blinkAlpha, 1, 1, 1);
--        self:drawTextureScaled(self.titlebarbkg, 2, 1, self:getWidth() - 4, 14, self.blinkAlpha, 1, 1, 1);

        if not self.blinkAlphaIncrease then
            self.blinkAlpha = self.blinkAlpha - 0.1 * (UIManager.getMillisSinceLastRender() / 33.3);
            if self.blinkAlpha < 0 then
                self.blinkAlpha = 0;
                self.blinkAlphaIncrease = true;
            end
        else
            self.blinkAlpha = self.blinkAlpha + 0.1 * (UIManager.getMillisSinceLastRender() / 33.3);
            if self.blinkAlpha > 1 then
                self.blinkAlpha = 1;
                self.blinkAlphaIncrease = false;
            end
        end
    end
    self:drawRectBorder(0, 0, self:getWidth(), titleBarHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if not self.isCollapsed then
        -- Draw border for backpack area...
        self:drawRect(self:getWidth()-self.buttonSize, titleBarHeight, self.buttonSize, height-titleBarHeight-7,  self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    end

--~ 	if not self.title then
--~ 		self.title = getSpecificPlayer(self.player):getDescriptor():getForename().." "..getSpecificPlayer(self.player):getDescriptor():getSurname().."'s Inventory";
--~ 	end

    if self.title and self.onCharacter then
        self:drawText(self.title, self.infoButton:getRight() + (5-getCore():getOptionFontSizeReal())*2, 0, 1,1,1,1);
    end

	local weightLabel;
    local buttonOffset = 1 + (5-getCore():getOptionFontSizeReal())*2

	-- load the current weight of the container
	self.totalWeight = ISInventoryPage.loadWeight(self.inventoryPane.inventory);
	-- used handle characters being in seats
	local occupied;

	local roundedWeight = round(self.totalWeight, 2)

	if self.capacity then
		local inventory = self.inventoryPane.inventory
		local part = inventory:getVehiclePart()
		if inventory == getSpecificPlayer(self.player):getInventory() then
			self:drawTextRight(roundedWeight .. " / " .. getSpecificPlayer(self.player):getMaxWeight(), self.pinButton:getX(), 0, 1,1,1,1);
		-- if a vehicle seat is occupied, display it's max maximum capacity at 25%/5 units
		elseif part and part:getId():contains("Seat") and part:getVehicle():getCharacter(part:getContainerSeatNumber()) then
			-- local part = inventory:getVehiclePart()
			-- local seat = vehiclePart.getId().contains("Seat")
			-- local occupied = part:getVehicle():getCharacter(part:getContainerSeatNumber())
			self:drawTextRight(roundedWeight .. " / " .. (self.capacity/4), self.pinButton:getX()-buttonOffset, 0, 1,1,1,1);
			occupied = true;
		else
			--display the item total and limit per container in MP
			if isClient() then
				local itemLimit = getServerOptions():getInteger("ItemNumbersLimitPerContainer");
				if itemLimit > 0 then
					weightLabel = roundedWeight .. " / " .. self.capacity .. " (" .. self.totalItems .. " / " .. itemLimit .. ")";
				else
					weightLabel = roundedWeight .. " / " .. self.capacity;
				end;
			else
				weightLabel = roundedWeight .. " / " .. self.capacity;
			end;
		end;
	else
		weightLabel = roundedWeight .. "";
	end;

	self:drawTextRight(weightLabel, self.pinButton:getX()-buttonOffset, 0, 1,1,1,1);

    local weightWid = getTextManager():MeasureStringX(UIFont.Small, "9999.99 / 9999") + 30;
    if not self.onCharacter or self.width < 370 then
        self.transferAll:setVisible(false)
    elseif "Tutorial" ~= getCore():getGameMode() then
        self.transferAll:setVisible(true)
    end

    local buttonHeight = titleBarHeight-2
    local textButtonOffset = buttonOffset * 3
    local textWid = getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_invpage_Transfer_all"))

    self.transferAll:setX(self.width - 1 - buttonHeight - buttonOffset - weightWid - textButtonOffset - textWid)
    
    if self.title and not self.onCharacter then
        local fontHgt = getTextManager():getFontHeight(self.font)
        local text = self.title
        if self.inventoryPane.inventory and self.inventoryPane.inventory:getParent() then
            local fireTile = self.inventoryPane.inventory:getParent()
            local campfire = CCampfireSystem.instance:getLuaObjectOnSquare(fireTile:getSquare())
            if campfire then
                shouldBeVisible = true
--                 local fireState;
--                 if campfire.isLit then
--                     fireState = getText("IGUI_Fireplace_Burning")
--                 else
--                     fireState = getText("IGUI_Fireplace_Unlit")
--                 end
                text = text .. ": " .. (ISCampingMenu.timeString(luautils.round(campfire.fuelAmt))) -- .. " (" .. fireState .. ")"
            elseif fireTile and fireTile:isFireInteractionObject() then
                shouldBeVisible = true
--                 local fireState;
--                 if fireTile:isLit() then
--                     fireState = getText("IGUI_Fireplace_Burning")
--                 elseif fireTile:isSmouldering() then
--                     fireState = getText("IGUI_Fireplace_Smouldering")
--                 else
--                     fireState = getText("IGUI_Fireplace_Unlit")
--                 end
                if fireTile:isPropaneBBQ() and not fireTile:hasPropaneTank() then
                    text = text .. ": " .. getText("IGUI_BBQ_NeedsPropaneTank")
                else
                    text = text .. ": " .. tostring(ISCampingMenu.timeString(fireTile:getFuelAmount())) -- .. " (" .. fireState .. ")"
                end
            end
        end
		if occupied then
			self:drawTextRight((text .. " " .. getText("IGUI_invpage_Occupied")), self.width - 20 - weightWid/1.5, (titleBarHeight - fontHgt) / 2, 1,1,1,1);
		else
			self:drawTextRight(text, self.width - 20 - weightWid/1.5, (titleBarHeight - fontHgt) / 2, 1,1,1,1);
		end
	end

    -- self:drawRectBorder(self:getWidth()-32, 15, 32, self:getHeight()-16-6, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:setStencilRect(0,0,self.width+1, height);

    local playerObj = getSpecificPlayer(self.player)
    if playerObj and playerObj:isInvPageDirty() then
        playerObj:setInvPageDirty(false);
        ISInventoryPage.renderDirty = false;
        ISInventoryPage.dirtyUI();
    end
    if ISInventoryPage.renderDirty then
        ISInventoryPage.renderDirty = false;
        ISInventoryPage.dirtyUI();
    end
end

function ISInventoryPage:drawTextRight(str, x, y, r, g, b, a, font)
    if self.javaObject ~= nil and str ~= nil then
        if font ~= nil then
            self.javaObject:DrawTextRight(font, str, x, y, r, g, b, a);
        else
            self.javaObject:DrawTextRight(UIFont.Small, str, x, y, r, g, b, a);
        end
    end
end

function ISInventoryPage:drawText(str, x, y, r, g, b, a, font)
    if self.javaObject ~= nil then
        if font ~= nil then
            self.javaObject:DrawText(font, str, x, y, r, g, b, a);
        else
            self.javaObject:DrawText(UIFont.Small, str, x, y, r, g, b, a);
        end
    end
end

function ISInventoryPage:close()
	ISPanel.close(self)
	if JoypadState.players[self.player+1] then
		setJoypadFocus(self.player, nil)
		local playerObj = getSpecificPlayer(self.player)
		playerObj:setBannedAttacking(false)
	end
    self.inventoryPane:clearWorldObjectHighlights();
    if not self:playContainerCloseSound(self.inventoryPane.inventory) then
        getSoundManager():playUISound("UIActivateButton")
    end
end

function ISInventoryPage:onToggleVisible()
    self.inventoryPane:clearWorldObjectHighlights();
end

function ISInventoryPage:onLoseJoypadFocus(joypadData)
    ISPanel.onLoseJoypadFocus(self, joypadData)

    self.inventoryPane.doController = false;
    local inv = getPlayerInventory(self.player);
	if not inv then
        return;
    end
    local loot = getPlayerLoot(self.player);
    if inv.joyfocus or loot.joyfocus then
      --  self.inventoryPane.doController = false;
        return;
    end

    if getFocusForPlayer(self.player) == nil then
        inv:setVisible(false);
        loot:setVisible(false);
        local playerObj = getSpecificPlayer(self.player)
        playerObj:setBannedAttacking(false)
        if playerObj:getVehicle() and playerObj:getVehicle():isDriver(playerObj) then
            getPlayerVehicleDashboard(self.player):addToUIManager()
        end
      --  self.inventoryPane.doController = false;
    end

end

function ISInventoryPage:onGainJoypadFocus(joypadData)
    ISPanel.onGainJoypadFocus(self, joypadData)

    local inv = getPlayerInventory(self.player);
    local loot = getPlayerLoot(self.player);
    inv:setVisible(true);
    loot:setVisible(true);
    getPlayerVehicleDashboard(self.player):removeFromUIManager()
    self.inventoryPane.doController = true;
end

function ISInventoryPage:getCurrentBackpackIndex()
    for index,backpack in ipairs(self.backpacks) do
        if backpack.inventory == self.inventory then
            return index
        end
    end
    return -1
end

function ISInventoryPage:prevUnlockedContainer(index, wrap)
    local playerObj = getSpecificPlayer(self.player)
    for i=index-1,1,-1 do
        local backpack = self.backpacks[i]
        local object = backpack.inventory:getParent()
        if not (instanceof(object, "IsoThumpable") and object:isLockedToCharacter(playerObj)) then
            return i
        end
    end
    return wrap and self:prevUnlockedContainer(#self.backpacks + 1, false) or -1
end

function ISInventoryPage:nextUnlockedContainer(index, wrap)
    if index < 0 then -- User clicked a container that isn't displayed
        return wrap and self:nextUnlockedContainer(0, false) or -1
    end
    local playerObj = getSpecificPlayer(self.player)
    for i=index+1,#self.backpacks do
        local backpack = self.backpacks[i]
        local object = backpack.inventory:getParent()
        if not (instanceof(object, "IsoThumpable") and object:isLockedToCharacter(playerObj)) then
            return i
        end
    end
    return wrap and self:nextUnlockedContainer(0, false) or -1
end

function ISInventoryPage:selectPrevContainer()
    local currentIndex = self:getCurrentBackpackIndex()
    local unlockedIndex = self:prevUnlockedContainer(currentIndex, true)
    if unlockedIndex == -1 then
        return
    end
    local playerObj = getSpecificPlayer(self.player)
    if playerObj and playerObj:getJoypadBind() ~= -1 then
        self.backpackChoice = unlockedIndex
    end
    self:selectContainer(self.backpacks[unlockedIndex])
end

function ISInventoryPage:selectNextContainer()
    local currentIndex = self:getCurrentBackpackIndex()
    local unlockedIndex = self:nextUnlockedContainer(currentIndex, true)
    if unlockedIndex == -1 then
        return
    end
    local playerObj = getSpecificPlayer(self.player)
    if playerObj and playerObj:getJoypadBind() ~= -1 then
        self.backpackChoice = unlockedIndex
    end
    self:selectContainer(self.backpacks[unlockedIndex])
end

function ISInventoryPage:onJoypadDown(button)
    ISContextMenu.globalPlayerContext = self.player;
    local playerObj = getSpecificPlayer(self.player)
    
    if button == Joypad.AButton then
        self.inventoryPane:doContextOnJoypadSelected();
    end

    if button == Joypad.BButton then
        if isPlayerDoingActionThatCanBeCancelled(playerObj) then
            stopDoingActionThatCanBeCancelled(playerObj)
            return
        end
        self.inventoryPane:doJoypadExpandCollapse()
    end
    if button == Joypad.XButton and not JoypadState.disableGrab then
        self.inventoryPane:doGrabOnJoypadSelected();
    end
    if button == Joypad.YButton and not JoypadState.disableYInventory then
        setJoypadFocus(self.player, nil);
    end

    -- 1: left button affects inventory, right button affects loot
    -- 2: both buttons affect same window
    -- 3: left + d-pad affects inventory, right + dpad affects loot
    local shoulderSwitch = getCore():getOptionShoulderButtonContainerSwitch()
    if getCore():getGameMode() == "Tutorial" then shoulderSwitch = 1 end
    if button == Joypad.LBumper then
        if shoulderSwitch == 1 then
            getPlayerInventory(self.player):selectNextContainer()
        elseif shoulderSwitch == 2 then
            self:selectPrevContainer()
        elseif shoulderSwitch == 3 then
            setJoypadFocus(self.player, getPlayerInventory(self.player))
        end
    end
    if button == Joypad.RBumper then
        if shoulderSwitch == 1 then
            getPlayerLoot(self.player):selectNextContainer()
        elseif shoulderSwitch == 2 then
            self:selectNextContainer()
        elseif shoulderSwitch == 3 then
            setJoypadFocus(self.player, getPlayerLoot(self.player))
        end
    end
end

function ISInventoryPage:onJoypadDirUp(joypadData)
    local shoulderSwitch = getCore():getOptionShoulderButtonContainerSwitch()
    if shoulderSwitch == 3 then
        if isJoypadPressed(joypadData.id, Joypad.LBumper) then
            getPlayerInventory(self.player):selectPrevContainer()
            return
        end
        if isJoypadPressed(joypadData.id, Joypad.RBumper) then
            getPlayerLoot(self.player):selectPrevContainer()
            return
        end
    end
    self.inventoryPane.joyselection = self.inventoryPane.joyselection - 1;
    self:ensureVisible(self.inventoryPane.joyselection + 1)
end

function ISInventoryPage:onJoypadDirDown(joypadData)
    local shoulderSwitch = getCore():getOptionShoulderButtonContainerSwitch()
    if shoulderSwitch == 3 then
        if isJoypadPressed(joypadData.id, Joypad.LBumper) then
            getPlayerInventory(self.player):selectNextContainer()
            return
        end
        if isJoypadPressed(joypadData.id, Joypad.RBumper) then
            getPlayerLoot(self.player):selectNextContainer()
            return
        end
    end
    self.inventoryPane.joyselection = self.inventoryPane.joyselection + 1;
    self:ensureVisible(self.inventoryPane.joyselection + 1)
end

function ISInventoryPage:ensureVisible(index)
	local lb = self.inventoryPane
	-- Wrap index same as ISInventoryPane:renderdetails does
    if index < 1 then index = #lb.items end
    if index > #lb.items then index = 1 end
    local headerHgt = 17
    local y = headerHgt + lb.itemHgt * (index - 1)
    local height = lb.itemHgt
	if y < 0-lb:getYScroll() + headerHgt then
		lb:setYScroll(0 - y + headerHgt)
	elseif y + height > 0 - lb:getYScroll() + (lb.height - headerHgt) then
		lb:setYScroll(0 - (y + height - lb.height))
	end
end

function ISInventoryPage:onJoypadDirLeft()
    local inv = getPlayerInventory(self.player);
    local loot = getPlayerLoot(self.player);

    if self == loot then
        setJoypadFocus(self.player, inv);
    elseif self == inv then
        setJoypadFocus(self.player, loot);
    end
end

function ISInventoryPage:onJoypadDirRight()
    local inv = getPlayerInventory(self.player);
    local loot = getPlayerLoot(self.player);

    if self == loot then
        setJoypadFocus(self.player, inv);
    elseif self == inv then
        setJoypadFocus(self.player, loot);
    end
end



function ISInventoryPage:render()
	local titleBarHeight = self:titleBarHeight()
    local rh = BUTTON_HGT/2+2
    local height = self:getHeight();
    if self.isCollapsed then
        height = titleBarHeight
    end
    -- Draw backpack border over backpacks....
    if not self.isCollapsed then
        self:drawRectBorder(self:getWidth()-self.buttonSize, titleBarHeight - 1, self.buttonSize, height-titleBarHeight-7, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
        --self:drawRect(0, 0, self.width-32, self.height, 1, 1, 1, 1);
        self:drawRectBorder(0, height-rh, self:getWidth(), rh, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
        self:drawTextureScaled(self.statusbarbkg, 1,  height-rh+1, self:getWidth() - 2, rh-2, 1, 1, 1, 1);
        self:drawTextureScaled(self.resizeimage, self:getWidth()-rh+1, height-rh+1, rh-2, rh-2, 1, 1, 1, 1);
    end

    self:clearStencilRect();
    self:drawRectBorder(0, 0, self:getWidth(), height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);


    if self.joyfocus then
        self:drawRectBorder(0, 0, self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
        self:drawRectBorder(1, 1, self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);
    end

    if self.render3DItems and #self.render3DItems > 0 then
        self:render3DItemPreview();
    end
end

function ISInventoryPage:dropItemsInContainer(button)
	if self.player ~= 0 then return false end
	if ISMouseDrag.dragging == nil then return false end
	local playerObj = getSpecificPlayer(self.player)
	if (getCore():getGameMode() ~= "Tutorial") and self:canPutIn() then
		local doWalk = true
		local items = {}
		local dragging = ISInventoryPane.getActualItems(ISMouseDrag.dragging)
		for i,v in ipairs(dragging) do
			local transfer = v:getContainer() and not button.inventory:isInside(v)
			if v:isFavorite() and not button.inventory:isInCharacterInventory(playerObj) then
				transfer = false
			end
			if not button.inventory:isItemAllowed(v) then
				transfer = false
			end
			if transfer then
				-- only walk for the first item
				if doWalk then
					if not luautils.walkToContainer(button.inventory, self.player) then
						break
					end
					doWalk = false
				end
				table.insert(items, v)
			end
		end
		self.inventoryPane:transferItemsByWeight(items, button.inventory)
		self.inventoryPane.selected = {};
		getPlayerLoot(self.player).inventoryPane.selected = {};
		getPlayerInventory(self.player).inventoryPane.selected = {};
	end
	if ISMouseDrag.draggingFocus then
		ISMouseDrag.draggingFocus:onMouseUp(0,0);
		ISMouseDrag.draggingFocus = nil;
		ISMouseDrag.dragging = nil;
	end
	self:refreshWeight();
    self:updateItemCount();
	return true
end

function ISInventoryPage:playContainerOpenCloseSounds(button)
    if button.inventory ~= self.inventoryPane.lastinventory then
        if button.inventory:getOpenSound() then
            if ISInventoryPage.bagSoundTime + ISInventoryPage.bagSoundDelay < getTimestamp() then
                local eventInstance = getSpecificPlayer(self.player):playSound(button.inventory:getOpenSound())
                if eventInstance ~= 0 then
                    ISInventoryPage.bagSoundTime = getTimestamp()
                    self.selectedContainerForSound = button.inventory
                end
            end
        end

        if not button.inventory:getOpenSound() and self.inventoryPane.lastinventory:getCloseSound() then
            if ISInventoryPage.bagSoundTime + ISInventoryPage.bagSoundDelay < getTimestamp() then
                ISInventoryPage.bagSoundTime = getTimestamp()
                local eventInstance = getSpecificPlayer(self.player):playSound(self.inventoryPane.lastinventory:getCloseSound())
                if eventInstance ~= 0 then
                    ISInventoryPage.bagSoundTime = getTimestamp()
                    self.selectedContainerForSound = button.inventory
                end
            end
        end
    end
end

function ISInventoryPage:playContainerOpenSound(container)
    if not container then return end
    if self.onCharacter then return false end
    if isGamePaused() then return false end
    if not container:getOpenSound() then return false end
    getSoundManager():playUISound(container:getOpenSound())
    return true
end

function ISInventoryPage:playContainerCloseSound(container)
    if not container then return end
    if self.onCharacter then return false end
    if isGamePaused() then return false end
    if not container:getCloseSound() then return false end
    getSoundManager():playUISound(container:getCloseSound())
    return true
end

-- NOTE: This expects to be called from update() when the window isn't visible, to play getCloseSound()
-- when the window collapses.
function ISInventoryPage:updateContainerOpenCloseSounds()
    if self.onCharacter then return end
    if isGamePaused() then return end
    if self:isReallyVisible() and not self.isCollapsed then
        if not self.selectedContainerForSound then
            self:playContainerOpenSound(self.inventoryPane.inventory)
        end
        self.selectedContainerForSound = self.inventoryPane.inventory
    else
        if self.selectedContainerForSound then
            self:playContainerCloseSound(self.selectedContainerForSound)
            self.selectedContainerForSound = nil
        end
    end
end

function ISInventoryPage:selectContainer(button)
	local playerObj = getSpecificPlayer(self.player)

    if button.inventory ~= self.inventoryPane.lastinventory then
        local object = button.inventory and button.inventory:getParent() or nil
        if instanceof(object, "IsoThumpable") and object:isLockedToCharacter(playerObj) then
            return
        end
        self:playContainerOpenCloseSounds(button)
    end

    self.inventoryPane.lastinventory = button.inventory;
    self.inventoryPane.inventory = button.inventory;
    self.inventoryPane.selected = {}
    if not button.inventory:isExplored() then
        if not isClient() then
			ItemPicker.fillContainer(button.inventory, playerObj);
        else
            button.inventory:requestServerItemsForContainer();
        end
        button.inventory:setExplored(true);
    end

	self.title = button.name;

	self.capacity = button.capacity;

    self:refreshBackpacks();
end

function ISInventoryPage:setNewContainer(inventory)
    self.inventoryPane.inventory = inventory;
    self.inventory = inventory;
    self.inventoryPane:refreshContainer();

    local playerObj = getSpecificPlayer(self.player)
    self.capacity = inventory:getEffectiveCapacity(playerObj);

    -- highlight the container if it is in the list
	for i,containerButton in ipairs(self.backpacks) do
		if containerButton.inventory == inventory then
			containerButton:setBackgroundRGBA(0.7, 0.7, 0.7, 1.0)
			self.title = containerButton.name;
            self:playContainerOpenCloseSounds(containerButton)
            self.inventoryPane.lastinventory = inventory;
		else
			containerButton:setBackgroundRGBA(0.0, 0.0, 0.0, 0.0)
		end
	end

	self:syncToggleStove()
	self:syncSwitchOutfit()
	self:syncStoreOutfit()
	self:syncWearOutfit()
	self:syncWearAll()
-- 	self:syncSetFireTileInfo()
	self:syncPropaneTileToggle()
	self:syncRemovePropaneTileTank()
	self:syncAddPropaneTileTank()
	self:syncAddFuel()
	self:syncLightFire()
	self:syncPutOut()
end

function ISInventoryPage:selectButtonForContainer(container)
	if self.inventoryPane.inventory == container then
		return
	end
	for index,containerButton in ipairs(self.backpacks) do
		if containerButton.inventory == container then
            local playerObj = getSpecificPlayer(self.player)
            local object = container and container:getParent() or nil
            if instanceof(object, "IsoThumpable") and object:isLockedToCharacter(playerObj) then
                return
            end
			if playerObj and playerObj:getJoypadBind() ~= -1 then
				self.backpackChoice = index
			end
			self:selectContainer(containerButton)
			return
		end
	end
end

function ISInventoryPage.loadWeight(inv)
    if inv == nil then return 0; end;

	return inv:getCapacityWeight();
end

--************************************************************************--
--** ISButton:onMouseMove
--**
--************************************************************************--
function ISInventoryPage:onMouseMove(dx, dy)
	self.mouseOver = true;

--    print(self:getMouseX(), self:getMouseY(), self:getWidth(), self:getHeight())

	if self.moving then
		self:setX(self.x + dx);
		self:setY(self.y + dy);

    end

    if not isGamePaused() then
        if self.isCollapsed and self.player and getSpecificPlayer(self.player) and getSpecificPlayer(self.player):isAiming() then
            return
        end
    end

    if self.isCollapsed and isKeyDown("PanCamera") then
        return
    end

    if not isMouseButtonDown(0) and not isMouseButtonDown(1) and not isMouseButtonDown(2) then

        self.collapseCounter = 0;
        if self.isCollapsed and self:getMouseY() < self:titleBarHeight() then
           self.isCollapsed = false;
		   	if isClient() and not self.onCharacter then
				self.inventoryPane.inventory:requestSync();
			end
           self:clearMaxDrawHeight();
           self.collapseCounter = 0;
        end
    end
end

--************************************************************************--
--** ISButton:onMouseMoveOutside
--**
--************************************************************************--
function ISInventoryPage:onMouseMoveOutside(dx, dy)
	self.mouseOver = false;

	if self.moving then
		self:setX(self.x + dx);
		self:setY(self.y + dy);
    end

    if ISMouseDrag.dragging ~= true and not self.pin and (self:getMouseX() < 0 or self:getMouseY() < 0 or self:getMouseX() > self:getWidth() or self:getMouseY() > self:getHeight()) then
--        if ISMouseDrag.dragging and #ISMouseDrag.dragging == 1 then
--            local dragging = ISInventoryPane.getActualItems(ISMouseDrag.dragging)
--            for i,v in ipairs(dragging) do
--                self.render3DItem = v;
--                break;
--            end
--        else
--            self.render3DItem = nil;
--        end
        self.collapseCounter = self.collapseCounter + getGameTime():getMultiplier() / getGameTime():getTrueMultiplier() / 0.8;
        local bDo = false;
        if ISMouseDrag.dragging == nil then
            bDo = true;
        else
            for i, k in ipairs(ISMouseDrag.dragging) do
               bDo = true;
               break;
            end
        end
        local playerObj = getSpecificPlayer(self.player)
        if playerObj and playerObj:isAiming() then
            self.collapseCounter = 1000
        end
        if ISMouseDrag.dragging and #ISMouseDrag.dragging > 0 then
            bDo = false;
        end
        if self.collapseCounter > 120 and not self.isCollapsed and bDo then
            self:collapseNow()
        end
    end
end

--************************************************************************--
--** ISButton:onMouseUp
--**
--************************************************************************--
function ISInventoryPage:onMouseUp(x, y)
	if not self:getIsVisible() then
		return;
	end
--~ 	print ("Mouse up on inventory page. Uhoh");

--	ISMouseDrag = {}
	self.moving = false;
	self:setCapture(false);
end

function ISInventoryPage:onMouseDown(x, y)

	if not self:getIsVisible() then
		return;
	end

	getSpecificPlayer(self.player):nullifyAiming();

	self.downX = self:getMouseX();
	self.downY = self:getMouseY();
	self.moving = true;
	self:setCapture(true);
end

function ISInventoryPage:onRightMouseDownOutside(x, y)
    if((self:getMouseX() < 0 or self:getMouseY() < 0 or self:getMouseX() > self:getWidth() or self:getMouseY() > self:getHeight()) and  not self.pin) then
        self:collapseNow()
    end
end
function ISInventoryPage:onMouseDownOutside(x, y)
    if((self:getMouseX() < 0 or self:getMouseY() < 0 or self:getMouseX() > self:getWidth() or self:getMouseY() > self:getHeight()) and  not self.pin) then
        self:collapseNow()
    end
end

function ISInventoryPage:onMouseUpOutside(x, y)
	if not self:getIsVisible() then
		return;
	end

--	ISMouseDrag = {}
	self.moving = false;
	self:setCapture(false);
end

function ISInventoryPage:collapseNow()
    if self.isCollapsed then return end
    self.isCollapsed = true
    self:setMaxDrawHeight(self:titleBarHeight())
end

function ISInventoryPage:isCycleContainerKeyDown()
	local keyName = getCore():getOptionCycleContainerKey()
	if keyName == "control" then
		return isCtrlKeyDown()
	end
	if keyName == "shift" then
		return isShiftKeyDown()
	end
	if keyName == "control+shift" then
		return isCtrlKeyDown() and isShiftKeyDown()
	end
	if keyName == "command" then
		return isMetaKeyDown()
	end
	if keyName == "command+shift" then
		return isMetaKeyDown() and isShiftKeyDown()
	end
	error "unknown cycle container key"
end

function ISInventoryPage:onMouseWheel(del)
	if self:getMouseX() < self:getWidth() - self.buttonSize and not self:isCycleContainerKeyDown() then
		return false
	end
	local currentIndex = self:getCurrentBackpackIndex()
	local unlockedIndex = -1
	if del < 0 then
		unlockedIndex = self:prevUnlockedContainer(currentIndex, true)
	else
		unlockedIndex = self:nextUnlockedContainer(currentIndex, true)
	end
	if unlockedIndex ~= -1 then
		local playerObj = getSpecificPlayer(self.player)
		if playerObj and playerObj:getJoypadBind() ~= -1 then
			self.backpackChoice = unlockedIndex
		end
		self:selectContainer(self.backpacks[unlockedIndex])
	end
	return true
end

ISInventoryPage.dirtyUI = function ()
   -- ISInventoryPage.playerInventory.inventoryPane:refreshContainer();
	for i=0, getNumActivePlayers() -1 do
		local pdata = getPlayerData(i)
		if pdata and pdata.playerInventory then
			pdata.playerInventory:refreshBackpacks()
			pdata.lootInventory:refreshBackpacks()
		end
	end
end

function ISInventoryPage:onBackpackMouseDown(button, x, y)
	ISMouseDrag = {}
	if not isKeyDown("Melee") then
	    getSpecificPlayer(self.player):nullifyAiming();
    end
end

function ISInventoryPage:onBackpackClick(button)
	local playerObj = getSpecificPlayer(self.player)
	if playerObj and playerObj:getJoypadBind() ~= -1 then
		for i,button2 in ipairs(self.backpacks) do
			if button2 == button then
				self.backpackChoice = index
				break
			end
		end
	end
	self:selectContainer(button)
end

function ISInventoryPage:onBackpackMouseUp(x, y)
	if not self.pressed and not ISMouseDrag.dragging then return end
	ISButton.onMouseUp(self, x, y)
	local page = self.parent
	if page:dropItemsInContainer(self) then return end
	page:onBackpackClick(self)
end

function ISInventoryPage:onBackpackRightMouseDown(x, y)
	local page = self.parent
	local container = self.inventory
	local item = container:getContainingItem()
	local context = ISContextMenu.get(page.player, getMouseX(), getMouseY())
	if item then
		context = ISInventoryPaneContextMenu.createMenu(page.player, page.onCharacter, {item}, getMouseX(), getMouseY())
		if context and context.numOptions > 1 and JoypadState.players[page.player+1] then
			context.origin = page
			context.mouseOver = 1
			setJoypadFocus(page.player, context)
		end
		return
	end
    if ISLootZed.cheat or isAdmin() then
        local playerObj = getSpecificPlayer(page.player)
        if not instanceof(container:getParent(), "BaseVehicle") and not (container:getType() == "inventorymale" or container:getType() == "inventoryfemale") then
            context:addOption("Refill container", container, function(container, playerObj)
                if container:getSourceGrid() then
                    if isClient() then
                        local items = container:getItems()
                        local tItems = {}
                        for i = items:size()-1, 0, -1 do
                            table.insert(tItems, items:get(i))
                        end

                        for i, v in ipairs(tItems) do
                            ISRemoveItemTool.removeItem(v, playerObj)
                        end

                        local sq = container:getSourceGrid()
                        local cIndex = -1
                        for i = 0, container:getParent():getContainerCount()-1 do
                            if container:getParent():getContainerByIndex(i) == container then
                                cIndex = i
                            end
                        end
                        local args = { x = sq:getX(), y = sq:getY(), z = sq:getZ(), index = container:getParent():getObjectIndex(), containerIndex = cIndex }
                        sendClientCommand(playerObj, 'object', 'clearContainerExplore', args)
                        container:removeItemsFromProcessItems()
                        container:clear()
                        container:requestServerItemsForContainer()
                        container:setExplored(true)
                        sendClientCommand(playerObj, 'object', 'updateOverlaySprite', args)
                    else
                        if container:getSourceGrid():getRoom() and container:getSourceGrid():getRoom():getRoomDef() and container:getSourceGrid():getRoom():getRoomDef():getProceduralSpawnedContainer() then
                            container:getSourceGrid():getRoom():getRoomDef():getProceduralSpawnedContainer():clear()
                        end
                        container:removeItemsFromProcessItems()
                        container:clear()
                        ItemPicker.fillContainer(container, playerObj)
                        if container:getParent() then
                            ItemPicker.updateOverlaySprite(container:getParent())
                        end
                        container:setExplored(true)
                    end
                end
            end, playerObj)
        end
        if ISLootZed.cheat then
            context:addOption("Open LootZed", container, function(container, playerObj)
                LootZedTool.SpawnItemCheckerList = {}
                LootZedTool.fillContainer_CalcChances(container, playerObj)

                if ISLootZed.instance ~= nil then
                    ISLootZed.instance:updateContent()
                    ISLootZed.instance:setVisible(true);
                else
                    local ui = ISLootZed:new(750, 800, playerObj);
                    ui:initialise();
                    ui:addToUIManager();
                    ISLootZed.instance:updateContent()
                end
            end, playerObj)
        end
        return
    end
	if context:isReallyVisible() then
		if context and JoypadState.players[page.player+1] then
			context.origin = page
		end
		context:closeAll()
	end
end

local sqsContainers = {}
local sqsVehicles = {}

function ISInventoryPage:addContainerButton(container, texture, name, tooltip)
    local titleBarHeight = self:titleBarHeight()
	local playerObj = getSpecificPlayer(self.player)
	local c = #self.backpacks + 1
	local x = self.width - self.buttonSize
	local y = ((c - 1) * self.buttonSize) + titleBarHeight - 1
	local button
	if #self.buttonPool > 0 then
		button = table.remove(self.buttonPool, 1)
		button:setX(x)
		button:setY(y)
	else
		button = ISButton:new(x, y, self.buttonSize, self.buttonSize, "", self, ISInventoryPage.onBackpackClick, ISInventoryPage.onBackpackMouseDown, false)
		button.anchorLeft = false
		button.anchorTop = false
		button.anchorRight = true
		button.anchorBottom = false
		button:initialise()
		button:forceImageSize(math.min(self.buttonSize - 2, 32), math.min(self.buttonSize - 2, 32))
	end
	button:setBackgroundRGBA(0.0, 0.0, 0.0, 0.0)
	button:setBackgroundColorMouseOverRGBA(0.3, 0.3, 0.3, 1.0)
	button:setBorderRGBA(0.7, 0.7, 0.7, 0.35)
	button:setTextureRGBA(1.0, 1.0, 1.0, 1.0)
	button.textureOverride = nil
	button.inventory = container
	button.onclick = ISInventoryPage.onBackpackClick
	button.onmousedown = ISInventoryPage.onBackpackMouseDown
	button.onMouseUp = ISInventoryPage.onBackpackMouseUp
	button.onRightMouseDown = ISInventoryPage.onBackpackRightMouseDown
	button:setOnMouseOverFunction(ISInventoryPage.onMouseOverButton)
	button:setOnMouseOutFunction(ISInventoryPage.onMouseOutButton)
	button:setSound("activate", nil)
	button.capacity = container:getEffectiveCapacity(playerObj)
	if instanceof(texture, "Texture") then
		button:setImage(texture)
    else
		if ContainerButtonIcons[container:getType()] ~= nil then
			button:setImage(ContainerButtonIcons[container:getType()])
		else
			button:setImage(self.conDefault)
		end
	end
	button.name = name
	button.tooltip = tooltip
	self:addChild(button)
	self.backpacks[c] = button
	return button
end

function ISInventoryPage:checkExplored(container, playerObj)
	if container:isExplored() then
		return
	end
	if isClient() then
		container:requestServerItemsForContainer()
	else
		ItemPicker.fillContainer(container, playerObj)
	end
	container:setExplored(true)
	if playerObj and playerObj:isLocalPlayer() then
		playerObj:triggerMusicIntensityEvent("SearchNewContainer")
	end
end

function ISInventoryPage.GetFloorContainer(playerNum)
	if ISInventoryPage.floorContainer == nil then
		ISInventoryPage.floorContainer = {}
	end
	if ISInventoryPage.floorContainer[playerNum+1] == nil then
		ISInventoryPage.floorContainer[playerNum+1] = ItemContainer.new("floor", nil, nil)
		ISInventoryPage.floorContainer[playerNum+1]:setExplored(true)
	end
	return ISInventoryPage.floorContainer[playerNum+1]
end

function ISInventoryPage:refreshBackpacks()
    ISHandCraftPanel.drawDirty = true;
    ISBuildPanel.drawDirty = true;

	self.buttonPool = self.buttonPool or {}
	for i,v in ipairs(self.backpacks) do
		self:removeChild(v)
		table.insert(self.buttonPool, i, v)
	end

	local floorContainer = ISInventoryPage.GetFloorContainer(self.player)

	self.inventoryPane.lastinventory = self.inventoryPane.inventory

	self.inventoryPane:hideButtons()

	local oldNumBackpacks = #self.backpacks
	table.wipe(self.backpacks)

	local containerButton = nil

	local playerObj = getSpecificPlayer(self.player)

	triggerEvent("OnRefreshInventoryWindowContainers", self, "begin")

	if self.onCharacter then
		local name = getText("IGUI_InventoryTooltip")
		containerButton = self:addContainerButton(playerObj:getInventory(), self.invbasic, name, nil)
		containerButton.capacity = self.inventory:getMaxWeight()
		if not self.capacity then
			self.capacity = containerButton.capacity
		end
		local it = playerObj:getInventory():getItems()
		for i = 0, it:size()-1 do
			local item = it:get(i)
			if item:getCategory() == "Container" and playerObj:isEquipped(item) or item:getType() == "KeyRing"  or item:hasTag( "KeyRing") then
				-- found a container, so create a button for it...
				containerButton = self:addContainerButton(item:getInventory(), item:getTex(), item:getName(), item:getName())
				if(item:getVisual() and item:getClothingItem()) then
					local tint = item:getVisual():getTint(item:getClothingItem());
					containerButton:setTextureRGBA(tint:getRedFloat(), tint:getGreenFloat(), tint:getBlueFloat(), 1.0);
				end
			end
		end
	elseif playerObj:getVehicle() then
		local vehicle = playerObj:getVehicle()
		for partIndex=1,vehicle:getPartCount() do
			local vehiclePart = vehicle:getPartByIndex(partIndex-1)
			if vehiclePart:getItemContainer() and vehicle:canAccessContainer(partIndex-1, playerObj) and vehiclePart:getId() ~= "TruckBed" then
				local tooltip = getText("IGUI_VehiclePart" .. vehiclePart:getItemContainer():getType())
                -- changed to include tooltips outside of the player inventory because some people want it
				containerButton = self:addContainerButton(vehiclePart:getItemContainer(), nil, tooltip, tooltip)
-- 				containerButton = self:addContainerButton(vehiclePart:getItemContainer(), nil, tooltip, nil)
				self:checkExplored(containerButton.inventory, playerObj)
                -- check for bags in seats/trunks
                if vehiclePart:getId() and vehiclePart:getId() ~= "GloveBox" then
                    local it = vehiclePart:getItemContainer():getItems()
                    for i = 0, it:size()-1 do
                        local item = it:get(i)
                        if item:getCategory() == "Container"  then
                            -- found a container, so create a button for it...
                            containerButton = self:addContainerButton(item:getInventory(), item:getTex(), item:getName(), item:getName())
                            if(item:getVisual() and item:getClothingItem()) then
                                local tint = item:getVisual():getTint(item:getClothingItem());
                                containerButton:setTextureRGBA(tint:getRedFloat(), tint:getGreenFloat(), tint:getBlueFloat(), 1.0);
                            end
                        end
                    end
                end
			end
	    end
		for partIndex=1,vehicle:getPartCount() do
			local vehiclePart = vehicle:getPartByIndex(partIndex-1)
			if vehiclePart:getItemContainer() and vehicle:canAccessContainer(partIndex-1, playerObj) and vehiclePart:getId() == "TruckBed" then
				local tooltip = getText("IGUI_VehiclePart" .. vehiclePart:getItemContainer():getType())
				-- changed to include tooltips outside of the player inventory because it matters to some people
				containerButton = self:addContainerButton(vehiclePart:getItemContainer(), nil, tooltip, tooltip)
-- 				containerButton = self:addContainerButton(vehiclePart:getItemContainer(), nil, tooltip, nil)
				self:checkExplored(containerButton.inventory, playerObj)
                -- check for bags in seats/trunks
                if vehiclePart:getId() and vehiclePart:getId() ~= "GloveBox" then
                    local it = vehiclePart:getItemContainer():getItems()
                    for i = 0, it:size()-1 do
                        local item = it:get(i)
                        if item:getCategory() == "Container"  then
                            -- found a container, so create a button for it...
                            containerButton = self:addContainerButton(item:getInventory(), item:getTex(), item:getName(), item:getName())
                            if(item:getVisual() and item:getClothingItem()) then
                                local tint = item:getVisual():getTint(item:getClothingItem());
                                containerButton:setTextureRGBA(tint:getRedFloat(), tint:getGreenFloat(), tint:getBlueFloat(), 1.0);
                            end
                        end
                    end
                end
			end
		end
	else
		local cx = playerObj:getX()
		local cy = playerObj:getY()
		local cz = playerObj:getZ()

		-- Do floor
		local container = floorContainer
		container:removeItemsFromProcessItems()
		container:clear()

		local sqs = sqsContainers
		table.wipe(sqs)

		local dir = playerObj:getDir()
		local lookSquare = nil
		if self.lookDir ~= dir then
			self.lookDir = dir
			local dx,dy = 0,0
			if dir == IsoDirections.NW or dir == IsoDirections.W or dir == IsoDirections.SW then
				dx = -1
			end
			if dir == IsoDirections.NE or dir == IsoDirections.E or dir == IsoDirections.SE then
				dx = 1
			end
			if dir == IsoDirections.NW or dir == IsoDirections.N or dir == IsoDirections.NE then
				dy = -1
			end
			if dir == IsoDirections.SW or dir == IsoDirections.S or dir == IsoDirections.SE then
				dy = 1
			end
			lookSquare = getCell():getGridSquare(cx + dx, cy + dy, cz)
		end

		local vehicleContainers = sqsVehicles
		table.wipe(vehicleContainers)

		for dy=-1,1 do
			for dx=-1,1 do
				local square = getCell():getGridSquare(cx + dx, cy + dy, cz)
				if square then
					table.insert(sqs, square)
				end
			end
		end

		for _,gs in ipairs(sqs) do
			-- stop grabbing thru walls...
			local currentSq = playerObj:getCurrentSquare()
			--if gs ~= currentSq and currentSq and currentSq:isBlockedTo(gs) then
            if gs ~= currentSq and currentSq and not currentSq:canReachTo(gs) then
				gs = nil
			end

            -- don't show containers in safehouse if you're not allowed
            if gs then
                if isClient() and not SafeHouse.isSafehouseAllowLoot(gs, playerObj) then
                    gs = nil
                end
            end

			if gs ~= nil then
				local numButtons = #self.backpacks

				local wobs = gs:getWorldObjects()
				for i = 0, wobs:size()-1 do
					local o = wobs:get(i)
					-- FIXME: An item can be in only one container in coop the item won't be displayed for every player.
					floorContainer:AddItem(o:getItem())
					if o:getItem() and o:getItem():getCategory() == "Container" then
						local item = o:getItem()
                        -- changed to include tooltips outside of the player inventory because some people want it
						containerButton = self:addContainerButton(item:getInventory(), item:getTex(), item:getName(), item:getName())
-- 						containerButton = self:addContainerButton(item:getInventory(), item:getTex(), item:getName(), nil)
						if item:getVisual() and item:getClothingItem() then
							local tint = item:getVisual():getTint(item:getClothingItem());
							containerButton:setTextureRGBA(tint:getRedFloat(), tint:getGreenFloat(), tint:getBlueFloat(), 1.0);
						end
					end
				end

				local sobs = gs:getStaticMovingObjects()
				for i = 0, sobs:size()-1 do
					local so = sobs:get(i)
					if so:getContainer() ~= nil then
					    -- added console spam when there's a missing container name translation string
					    if getTextOrNull("IGUI_ContainerTitle_" .. so:getContainer():getType()) == nil and isDebugEnabled() then
					        print("Missing IGUI_ContainerTitle_ tranlastion string for " .. tostring(so:getContainer():getType()))
					    end

					    -- changed to just show the container type if there's no translation string to make it easier to add the needed string
						local title = getTextOrNull("IGUI_ContainerTitle_" .. so:getContainer():getType()) or "!Needs IGUI_ContainerTitle defined for: " .. so:getContainer():getType()
-- 						local title = getTextOrNull("IGUI_ContainerTitle_" .. so:getContainer():getType()) or ""
                        -- changed to include tooltips outside of the player inventory because some people want it
                        if instanceof(so, "IsoDeadBody") and so:isAnimal() then
                            break;
                        end
						containerButton = self:addContainerButton(so:getContainer(), nil, title, title)
-- 						containerButton = self:addContainerButton(so:getContainer(), nil, title, nil)
						self:checkExplored(containerButton.inventory, playerObj)
					end
				end

				local obs = gs:getObjects()
				for i = 0, obs:size()-1 do
					local o = obs:get(i)
					for containerIndex = 1,o:getContainerCount() do
						local container = o:getContainerByIndex(containerIndex-1)
						-- added console spam when a container type doesn't have a translation string defined
					    if getTextOrNull("IGUI_ContainerTitle_" .. container:getType()) == nil and isDebugEnabled() then
					        print("Missing IGUI_ContainerTitle_ translation string for " .. tostring(container:getType()))
					    end
					    -- changed to just show the container type if there's no translation string to make it easier to add the needed string
						local title = getTextOrNull("IGUI_ContainerTitle_" .. container:getType()) or "!Needs IGUI_ContainerTitle defined for: " .. container:getType()
-- 						local title = getTextOrNull("IGUI_ContainerTitle_" .. container:getType()) or ""
                        -- changed to include tooltips outside of the player inventory because some people want it
						containerButton = self:addContainerButton(container, nil, title, title)
-- 						containerButton = self:addContainerButton(container, nil, title, nil)
						if instanceof(o, "IsoThumpable") and o:isLockedToCharacter(playerObj) then
							containerButton.onclick = nil
							containerButton.onmousedown = nil
							containerButton:setOnMouseOverFunction(nil)
							containerButton:setOnMouseOutFunction(nil)
							containerButton.textureOverride = getTexture("media/ui/lock.png")
						end

						if instanceof(o, "IsoThumpable") and o:isLockedByPadlock() and playerObj:getInventory():haveThisKeyId(o:getKeyId()) then
							containerButton.textureOverride = getTexture("media/ui/lockOpen.png")
						end

						self:checkExplored(containerButton.inventory, playerObj)
					end
				end

				local vehicle = gs:getVehicleContainer()
				if vehicle and not vehicleContainers[vehicle] then
					vehicleContainers[vehicle] = true
					for partIndex=1,vehicle:getPartCount() do
						local vehiclePart = vehicle:getPartByIndex(partIndex-1)
						if vehiclePart:getItemContainer() and vehicle:canAccessContainer(partIndex-1, playerObj) then
							local tooltip = getText("IGUI_VehiclePart" .. vehiclePart:getItemContainer():getType())
                            -- changed to include tooltips outside of the player inventory because some people want it
							containerButton = self:addContainerButton(vehiclePart:getItemContainer(), nil, tooltip, tooltip)
-- 							containerButton = self:addContainerButton(vehiclePart:getItemContainer(), nil, tooltip, nil)
							self:checkExplored(containerButton.inventory, playerObj)
							-- check for bags in seats/trunks
                            if vehiclePart:getId() and vehiclePart:getId() ~= "GloveBox" then
                                local it = vehiclePart:getItemContainer():getItems()
                                for i = 0, it:size()-1 do
                                    local item = it:get(i)
                                    if item:getCategory() == "Container"  then
                                        -- found a container, so create a button for it...
                                        containerButton = self:addContainerButton(item:getInventory(), item:getTex(), item:getName(), item:getName())
                                        if(item:getVisual() and item:getClothingItem()) then
                                            local tint = item:getVisual():getTint(item:getClothingItem());
                                            containerButton:setTextureRGBA(tint:getRedFloat(), tint:getGreenFloat(), tint:getBlueFloat(), 1.0);
                                        end
                                    end
                                end
                            end
						end
					end
				end

				if (numButtons < #self.backpacks) and (gs == lookSquare) then
					self.inventoryPane.inventory = self.backpacks[numButtons + 1].inventory
				end
			end
		end

		triggerEvent("OnRefreshInventoryWindowContainers", self, "beforeFloor")

		local title = getTextOrNull("IGUI_ContainerTitle_floor") or ""
		containerButton = self:addContainerButton(floorContainer, ContainerButtonIcons.floor, title, nil)
		containerButton.capacity = floorContainer:getMaxWeight()
	end

	triggerEvent("OnRefreshInventoryWindowContainers", self, "buttonsAdded")

	local found = false
	local foundIndex = -1
	for index,containerButton in ipairs(self.backpacks) do
		if containerButton.inventory == self.inventoryPane.inventory then
			foundIndex = index
			found = true
			break
		end
	end

	self.inventoryPane.inventory = self.inventoryPane.lastinventory
	self.inventory = self.inventoryPane.inventory
	if self.backpackChoice ~= nil and playerObj:getJoypadBind() ~= -1 then
		if not self.onCharacter and oldNumBackpacks == 1 and #self.backpacks > 1 then
			self.backpackChoice = 1
		end
		if self.backpackChoice > #self.backpacks then
			self.backpackChoice = 1
		end
		if self.backpacks[self.backpackChoice] ~= nil then
			self.inventoryPane.inventory = self.backpacks[self.backpackChoice].inventory
			self.capacity = self.backpacks[self.backpackChoice].capacity
		end
	else
		if not self.onCharacter and oldNumBackpacks == 1 and #self.backpacks > 1 then
			self.inventoryPane.inventory = self.backpacks[1].inventory
			self.capacity = self.backpacks[1].capacity
		elseif found then
			self.inventoryPane.inventory = self.backpacks[foundIndex].inventory
			self.capacity = self.backpacks[foundIndex].capacity
		elseif not found and #self.backpacks > 0 then
			if self.backpacks[1] and self.backpacks[1].inventory then
				self.inventoryPane.inventory = self.backpacks[1].inventory
				self.capacity = self.backpacks[1].capacity
			end
		elseif self.inventoryPane.lastinventory ~= nil then
			self.inventoryPane.inventory = self.inventoryPane.lastinventory
		end
	end

	-- ISInventoryTransferAction sometimes turns the player to face a container.
	-- Which container is selected changes as the player changes direction.
	-- Although ISInventoryTransferAction forces a container to be selected,
	-- sometimes the action completes before the player finishes turning.
	if self.forceSelectedContainer then
		if self.forceSelectedContainerTime > getTimestampMs() then
			for _,containerButton in ipairs(self.backpacks) do
				if containerButton.inventory == self.forceSelectedContainer then
					self.inventoryPane.inventory = containerButton.inventory
					self.capacity = containerButton.capacity
					break
				end
			end
		else
			self.forceSelectedContainer = nil
		end
	end

	self.inventoryPane:bringToTop()
	self.resizeWidget2:bringToTop()
	self.resizeWidget:bringToTop()

	self.inventory = self.inventoryPane.inventory

	self.title = nil
	for k,containerButton in ipairs(self.backpacks) do
		if containerButton.inventory == self.inventory then
            self.selectedButton = containerButton;
			containerButton:setBackgroundRGBA(0.7, 0.7, 0.7, 1.0)
			self.title = containerButton.name
		else
			containerButton:setBackgroundRGBA(0.0, 0.0, 0.0, 0.0)
		end
	end

	if self.inventoryPane ~= nil then
		self.inventoryPane:refreshContainer()
	end

	self:refreshWeight()

	self:updateItemCount()

    self:syncToggleStove()
	self:syncSwitchOutfit()
	self:syncStoreOutfit()
	self:syncWearOutfit()
	self:syncWearAll()
-- 	self:syncSetFireTileInfo()
	self:syncPropaneTileToggle()
	self:syncRemovePropaneTileTank()
	self:syncAddPropaneTileTank()
	self:syncAddFuel()
	self:syncLightFire()
	self:syncPutOut()

	triggerEvent("OnRefreshInventoryWindowContainers", self, "end")
end

--************************************************************************--
--** ISInventoryPage:new
--**
--************************************************************************--
function ISInventoryPage:new (x, y, width, height, inventory, onCharacter, zoom)
	local o = {}
	--o.data = {}
	o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
	o.x = x;
	o.y = y;
    o.anchorLeft = true;
    o.anchorRight = true;
    o.anchorTop = true;
    o.anchorBottom = true;
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
	o.backgroundColor = {r=0, g=0, b=0, a=0.8};
	o.width = width;
	o.height = height;
	o.anchorLeft = true;
    o.backpackChoice = 1;
    o.zoom = zoom;
    o.isCollapsed = true;
    if o.zoom == nil then o.zoom = 1; end

	o.inventory = inventory;
    o.onCharacter = onCharacter;
    o.titlebarbkg = getTexture("media/ui/Panel_TitleBar.png");
    o.statusbarbkg = getTexture("media/ui/Panel_StatusBar.png");
    o.resizeimage = getTexture("media/ui/ResizeIcon.png");
    o.invbasic = getTexture("media/ui/Icon_InventoryBasic.png");
    o.infoBtn = getTexture("media/ui/inventoryPanes/Button_Info.png");
    o.closebutton = getTexture("media/ui/inventoryPanes/Button_Close.png");
    o.collapsebutton = getTexture("media/ui/inventoryPanes/Button_Collapse.png");
    o.pinbutton = getTexture("media/ui/inventoryPanes/Button_Pin.png");

    o.conDefault = getTexture("media/ui/Container_Shelf.png");
    o.highlightColors = {r=0.98,g=0.56,b=0.11};

    o.containerIconMaps = ContainerButtonIcons

    o.pin = true;
    o.isCollapsed = false;
    o.backpacks = {}
    o.collapseCounter = 0;
	o.title = nil;
	o.titleFont = UIFont.Small
	o.titleFontHgt = getTextManager():getFontHeight(o.titleFont)
	local sizes = { 32, 40, 48 }
	o.buttonSize = sizes[getCore():getOptionInventoryContainerSize()]

    o.visibleTarget = o;
    o.visibleFunction = ISInventoryPage.onToggleVisible;

    -- The right shoulder button is used for navigation, and sometimes used for container switching.
    o.disableJoypadNavigation = true

   return o
end

function ISInventoryPage:onMouseOverButton(button,x,y)
	self.mouseOverButton = button;
end

function ISInventoryPage:onMouseOutButton(button,x,y)
	self.mouseOverButton = nil;
end

function ISInventoryPage:canPutIn()
    local playerObj = getSpecificPlayer(self.player)
    local container = self.mouseOverButton and self.mouseOverButton.inventory or nil
    if not container then
        return false
    end
    local items = {}
    local minWeight = 100000
    local dragging = ISInventoryPane.getActualItems(ISMouseDrag.dragging)
    for i,item in ipairs(dragging) do
        local itemOK = true
        if item:isFavorite() and not container:isInCharacterInventory(playerObj) then
            itemOK = false
        end
        if container:isInside(item) then
            itemOK = false
        end
        if container:getType() == "floor" and item:getWorldItem() then
            itemOK = false
        end
        if item:getContainer() == container then
            itemOK = false
        end
        if not container:isItemAllowed(item) then
            itemOK = false
        end
        if itemOK then
            table.insert(items, item)
        end
        if item:getUnequippedWeight() < minWeight then
            minWeight = item:getUnequippedWeight()
        end
    end
    if #items == 1 then
        return container:hasRoomFor(playerObj, items[1])
    elseif #items > 0 then
        return container:hasRoomFor(playerObj, minWeight)
    end
    return false
end

function ISInventoryPage:RestoreLayout(name, layout)
    if getJoypadData(self.player) then return end
    ISLayoutManager.DefaultRestoreWindow(self, layout)
    if layout.pin == 'true' then
        self:setPinned()
    end
    self.inventoryPane:RestoreLayout(name, layout)
end

function ISInventoryPage:SaveLayout(name, layout)
    if getJoypadData(self.player) then return end
    ISLayoutManager.DefaultSaveWindow(self, layout)
    if self.pin then layout.pin = 'true' else layout.pin = 'false' end
    self.inventoryPane:SaveLayout(name, layout)
end

ISInventoryPage.onKeyPressed = function(key)
	if getCore():isKey("Toggle Inventory", key) and getSpecificPlayer(0) and getGameSpeed() > 0 and getPlayerInventory(0) and getCore():getGameMode() ~= "Tutorial" then
        getPlayerInventory(0):setVisible(not getPlayerInventory(0):getIsVisible());
        getPlayerLoot(0):setVisible(getPlayerInventory(0):getIsVisible());
    end
end

ISInventoryPage.toggleInventory = function()
	if ISInventoryPage.playerInventory:getIsVisible() then
		ISInventoryPage.playerInventory:setVisible(false);
	else
		ISInventoryPage.playerInventory:setVisible(true);
	end
end

function ISInventoryPage:onInventoryContainerSizeChanged()
	local sizes = { 32, 40, 48 }
	self.buttonSize = sizes[getCore():getOptionInventoryContainerSize()]
	self.minimumWidth = 256 + self.buttonSize
	self.inventoryPane:setWidth(self.width - self.buttonSize)
	for _,button in ipairs(self.buttonPool) do
		button:setWidth(self.buttonSize)
		button:setHeight(self.buttonSize)
		button:forceImageSize(math.min(self.buttonSize - 2, 32), math.min(self.buttonSize - 2, 32))
	end
	local y = self:titleBarHeight() - 1
	for _,button in ipairs(self.backpacks) do
		button:setX(self.width - self.buttonSize)
		button:setY(y)
		y = y + self.buttonSize
		button:setWidth(self.buttonSize)
		button:setHeight(self.buttonSize)
		button:forceImageSize(math.min(self.buttonSize - 2, 32), math.min(self.buttonSize - 2, 32))
	end
end

ISInventoryPage.ContainerSizeChanged = function()
	for i=1,getNumActivePlayers() do
		local pdata = getPlayerData(i-1)
		if pdata then
			pdata.playerInventory:onInventoryContainerSizeChanged()
			pdata.lootInventory:onInventoryContainerSizeChanged()
		end
	end
end

ISInventoryPage.onInventoryFontChanged = function()
    for i=1,getNumActivePlayers() do
        local pdata = getPlayerData(i-1)
        if pdata then
            pdata.playerInventory.inventoryPane:onInventoryFontChanged()
            pdata.lootInventory.inventoryPane:onInventoryFontChanged()
        end
    end
end

-- Called when an object with a container is added/removed from the world.
-- Added this to handle campfire containers.
ISInventoryPage.OnContainerUpdate = function(object)
    ISInventoryPage.renderDirty = true
end

ISInventoryPage.ongamestart = function()
    ISInventoryPage.renderDirty = true;
end

function ISInventoryPage:removeAll()
	self.inventoryPane:removeAll(self.player);
end

function ISInventoryPage:render3DItemPreview()
    if isKeyDown("Rotate building") then
        if not self.render3DItemRot then
            self.render3DItemRot = 0;
        end
        local rot = self.render3DItemRot;
        if isKeyDown(Keyboard.KEY_LSHIFT) then
            rot = rot -10;
        else
            rot = rot + 10;
        end
        if rot < 0 then
            rot = 360;
        end
        if rot > 360 then
            rot = 0;
        end
        self.render3DItemRot = rot;
    end
    local playerObj = getSpecificPlayer(self.player)
    --        print(self.player, getMouseX())
    local worldX = screenToIsoX(self.player, getMouseX(), getMouseY(), playerObj:getZ())
    local worldY = screenToIsoY(self.player, getMouseX(), getMouseY(), playerObj:getZ())
    local sq = getSquare(worldX, worldY, playerObj:getZ());
    if not sq then
        return;
    end
    self.render3DItemXOffset = worldX - sq:getX();
    self.render3DItemYOffset = worldY - sq:getY();
    self.render3DItemZOffset = 0;
    -- check if we have a surface, so we can do a z offset to make items goes on this surface
    for i=0,sq:getObjects():size()-1 do
        local object = sq:getObjects():get(i);
        if object:getProperties():getSurface() and object:getProperties():getSurface() > 0 then
            -- the surface is in pixel, set for the 1X texture, so we *2 (192 pixels is 1X texture height)
            self.render3DItemZOffset = (object:getProperties():getSurface() / 192) * 2;
            break;
        end
    end
    self.selectedSqDrop = sq;
    if self.render3DItems then
        for i,v in ipairs(self.render3DItems) do
            Render3DItem(v, sq, worldX, worldY, self.render3DItemZOffset, self.render3DItemRot);
        end
    end
    --        print("gonna try to render ", self.render3DItem, worldX, playerObj:getX())
--    Render3DItem(self.render3DItem, sq, worldX, worldY, self.render3DItemZOffset, self.render3DItemRot);
end

Events.OnKeyPressed.Add(ISInventoryPage.onKeyPressed);
Events.OnContainerUpdate.Add(ISInventoryPage.OnContainerUpdate)

--Events.OnCreateUI.Add(testInventory);

Events.OnGameStart.Add(ISInventoryPage.ongamestart);
