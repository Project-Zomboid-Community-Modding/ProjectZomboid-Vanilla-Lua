--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

ISEquippedItem = ISPanel:derive("ISEquippedItem");
ISEquippedItem.text = nil;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
local UI_BORDER_SPACING = 10
local TEXTURE_WIDTH = 0
local TEXTURE_HEIGHT = 0

local function setTextureWidth()
    local size = getCore():getOptionSidebarSize()
    if size == 6 then
        size = getCore():getOptionFontSizeReal() - 1
    end
        TEXTURE_WIDTH = 48
    if size == 2  then
        TEXTURE_WIDTH = 64
    elseif size == 3  then
        TEXTURE_WIDTH = 80
    elseif size == 4  then
        TEXTURE_WIDTH = 96
    elseif size == 5 then
        TEXTURE_WIDTH = 128
    end

    TEXTURE_HEIGHT = TEXTURE_WIDTH * 0.75
end


function ISEquippedItem:prerender()
    self:checkSidebarSizeOption()
--	self:drawTexture(self.HandSecondaryTexture, -1, 50, 1, 1, 1, 1);

    if self.invBtn == nil then
        return;
    end
	if self.inventory ~= nil and self.inventory:getIsVisible() then
		self.invBtn:setImage(self.inventoryTextureOn);
	else
		self.invBtn:setImage(self.inventoryTexture);
    end
    if getPlayerZoneUI(0) and getPlayerZoneUI(0):getIsVisible() then
        self.zoneBtn:setImage(self.zoneIconOn);
    else
        self.zoneBtn:setImage(self.zoneIcon);
    end
    if ISEntityUI.players[self.chr:getPlayerNum()] and ISEntityUI.players[self.chr:getPlayerNum()].windows["HandcraftWindow"] and ISEntityUI.players[self.chr:getPlayerNum()].windows["HandcraftWindow"].instance then
        self.craftingBtn:setImage(self.craftingIconOn);
    else
        self.craftingBtn:setImage(self.craftingIcon);
    end

    if ISEntityUI.players[self.chr:getPlayerNum()] and ISEntityUI.players[self.chr:getPlayerNum()].windows["BuildWindow"] and ISEntityUI.players[self.chr:getPlayerNum()].windows["BuildWindow"].instance then
        self.buildBtn:setImage(self.moveableIconBuildOn);
    else
        self.buildBtn:setImage(self.moveableIconBuild);
    end

    if getPlayerInfoPanel(0) and getPlayerInfoPanel(0):getIsVisible() then
        self.healthBtn:setImage(self.heartIconOn);
    else
        self.healthBtn:setImage(self.heartIcon);
    end

    if self.movableBtn:isMouseOver() then
        self.movableTooltip:setVisible(false);
        self.movableBtn:setVisible(false);
        self.movablePopup:setVisible(true);
    elseif self.movablePopup:isMouseOver() then
        --
    elseif getCell():getDrag(0) and getCell():getDrag(0).isMoveableCursor then
        if getCell():getDrag(0):getMoveableMode() == "pickup" then
            self.movableBtn:setImage(self.movableIconPickup);
        elseif getCell():getDrag(0):getMoveableMode() == "place" then
            self.movableBtn:setImage(self.movableIconPlace);
        elseif getCell():getDrag(0):getMoveableMode() == "rotate" then
            self.movableBtn:setImage(self.movableIconRotate);
        elseif getCell():getDrag(0):getMoveableMode() == "scrap" then
            self.movableBtn:setImage(self.movableIconScrap);
        elseif getCell():getDrag(0):getMoveableMode() == "repair" then
            self.movableBtn:setImage(self.moveableIconRepair);
        end
        self.movableTooltip:setVisible(true);
        self.movableBtn:setVisible(true);
        self.movablePopup:setVisible(false);
    else
        self.movableTooltip:setVisible(false);
        self.movableBtn:setImage(self.movableIconOff);
        self.movableBtn:setVisible(true);
        self.movablePopup:setVisible(false);
    end

    ----
    if self.searchBtn then
        if ISSearchManager.players[self.chr] and ISSearchManager.players[self.chr].isSearchMode then
            self.searchBtn:setImage(self.searchIconOn);
        else
            self.searchBtn:setImage(self.searchIcon);
        end;
    end;
    ----

    if self.mapPopup then
        -- The check for ISWorldMap_instance:isVisible() is to prevent the popup becoming visible again
        -- after clicking it to display the world map.  UIManager.render() happens after UIManager.update().
        -- The world map is displayed by calling UIElement:addToUIManager(), but that doesn't take effect
        -- until the *next* UIManager.update() call.  So WorldMap is visible but not yet in UIManager's
        -- list of top-level widgets.
        if self.mapBtn:isMouseOver() and (not ISWorldMap_instance or not ISWorldMap_instance:isVisible()) then
            self.mapPopup:setVisible(true)
        elseif self.mapPopup:isMouseOver() then
            --
        else
            self.mapPopup:setVisible(false)
        end
    end

    if self.debugBtn then
        if ISDebugMenu.instance then
            self.debugBtn:setImage(self.debugIconOn);
        else
            self.debugBtn:setImage(self.debugIcon);
        end
    end
    
    if self.clientBtn then
        if ISUserPanelUI.instance then
            self.clientBtn:setImage(self.clientIconOn);
        else
            self.clientBtn:setImage(self.clientIcon);
        end
    end
    
    if self.adminBtn then
        local isVisible = self.chr:getRole():hasAdminTool()
        self.adminBtn:setVisible(isVisible)
        if not isVisible then
            if ISAdminPanelUI.instance then
                ISAdminPanelUI.instance:close()
            end
        end

        if ISAdminPanelUI.instance then
            self.adminBtn:setImage(self.adminIconOn)
        else
            self.adminBtn:setImage(self.adminIcon)
        end
    end

    if self.warManagerBtn then
        local war = getWarNearest()
        if war then
            self.warManagerBtn:setVisible(true)

            if not self.adminBtn:isVisible() then
                self.warManagerBtn:setX(self.adminBtn:getX())
                self.warManagerBtn:setY(self.adminBtn:getY())
            else
                self.warManagerBtn:setX(self.warManagerBtnX)
                self.warManagerBtn:setY(self.warManagerBtnY)
            end

            local warX = self.warManagerBtn:getX()
            local warY = self.warManagerBtn:getY()

            if war:getState():name() == "Claimed" then
                self:drawTexture(self.lockTexture, warX + UI_BORDER_SPACING, warY + UI_BORDER_SPACING, 1,1,1,1)
                self:drawText(tostring(war:getTime()), warX + self.lockTexture:getWidthOrig() + UI_BORDER_SPACING + 5, warY + UI_BORDER_SPACING, 1,1,1,1, UIFont.Small)
                self.warManagerBtn:setImage(self.warInactive)
            end

            if war:getState():name() == "Accepted" then
                self:drawTexture(self.lockTexture, warX + UI_BORDER_SPACING, warY + UI_BORDER_SPACING, 1,1,1,1)
                self:drawText(tostring(war:getTime()), warX + self.lockTexture:getWidthOrig() + UI_BORDER_SPACING + 5, warY + UI_BORDER_SPACING, 1,1,1,1,UIFont.Small)
                self.warManagerBtn:setImage(self.warSoon)
            end

            if war:getState():name() == "Started" then
                self:drawTexture(self.lockTexture, warX + UI_BORDER_SPACING, warY + UI_BORDER_SPACING, 1,1,1,1)
                self:drawText(tostring(war:getTime()), warX + self.lockTexture:getWidthOrig() + UI_BORDER_SPACING + 5, warY + UI_BORDER_SPACING, 1,1,1,1,UIFont.Small)
                self.warManagerBtn:setImage(self.warActive)
            end
        else
            self.warManagerBtn:setVisible(false)
            if ISWarManagerUI.instance then
                ISWarManagerUI.instance:closeModal()
            end
        end
    end

    ---

    local safetyEnabled = getServerOptions():getBoolean("SafetySystem");
    local toggleTimeMax = getServerOptions():getInteger("SafetyToggleTimer");
    local cooldownTimerMax = getServerOptions():getInteger("SafetyCooldownTimer");
    local isNonPvpZone = NonPvpZone.getNonPvpZone(self.chr:getX(), self.chr:getY())



    if isClient() then
        self.safetyBtn:setVisible(safetyEnabled);
        self.radialIcon:setVisible(false);

        if safetyEnabled then

            local safetyX = self.safetyBtn:getX();
            local safetyY = self.safetyBtn:getY();

            if self.safety:getToggle() > 0 or self.safety:getCooldown() > 0 then

                self:drawTexture(self.lockTexture, safetyX + UI_BORDER_SPACING, safetyY + UI_BORDER_SPACING, 1,1,1,1);

                if self.safety:getToggle() > 0 then

                    self.radialIcon:setVisible(true);
                    self.radialIcon:setValue(self.safety:getToggle() / toggleTimeMax);

                    if self.safety:isEnabled() then
                        self.radialIcon:setTexture(self.offTexture);
                        self.safetyBtn:setImage(self.onTexture);
                    else
                        self.radialIcon:setTexture(self.onTexture);
                        self.safetyBtn:setImage(self.offTexture);
                    end

                    self:drawText(tostring(math.ceil(self.safety:getToggle())), safetyX + self.lockTexture:getWidthOrig() + UI_BORDER_SPACING + 5, safetyY + UI_BORDER_SPACING, 1,1,1,1, UIFont.Small);

                elseif self.safety:getCooldown() > 0 then

                    self.radialIcon:setVisible(true);
                    self.radialIcon:setValue(1 - self.safety:getCooldown() / cooldownTimerMax);

                    if self.safety:isEnabled() then
                        self.radialIcon:setTexture(self.onTexture);
                        self.safetyBtn:setImage(self.onTexture);
                    else
                        self.radialIcon:setTexture(self.offTexture);
                        self.safetyBtn:setImage(self.offTexture);
                    end

                    self:drawText(tostring(math.ceil(self.safety:getCooldown())), safetyX + self.lockTexture:getWidthOrig() + UI_BORDER_SPACING + 5, safetyY + UI_BORDER_SPACING, 1,1,1,1, UIFont.Small);

                end
            elseif not isNonPvpZone then
                if self.safety:isEnabled() then
                    self.safetyBtn:setImage(self.onTexture);
                else
                    self.safetyBtn:setImage(self.offTexture);
                end
            end
        end

        if isNonPvpZone then
            self.safetyBtn:setImage(self.disableTexture);
            self.radialIcon:setVisible(false);
            if self:isMouseOver() then
                self:drawText(getText("IGUI_PvpZone_NonPvpZone"), self.width + 10, self.height/2, 1, 0, 0, 1, self.Small);
            end
        end
    end
    ---

    if "Tutorial" == getCore():getGameMode() then
        self.movableBtn:setVisible(false);
        self.invBtn:setVisible(false);
        self.craftingBtn:setVisible(false);
        self.zoneBtn:setVisible(false);
        self.searchBtn:setVisible(false);
        self.buildBtn:setVisible(false);
        self.healthBtn:setY(self.invBtn:getY());
    end

    local playerID = self.chr:getPlayerNum()
    if getCell():getDrag(playerID) and getCell():getDrag(playerID).isPlace3DCursor then -- draw some help text when placing a 3D item in the world
        local cursor = getCell():getDrag(playerID);
        cursor:drawPrompt(playerID, self);
    end

    if isClient() then

        local maxY = getCore():getScreenHeight();
        local maxX = getCore():getScreenWidth();
        local statusData = getMPStatus()

        local tmpY = UI_BORDER_SPACING*2 + FONT_HGT_MEDIUM*2
        local tmpX = UI_BORDER_SPACING*3

        if tonumber(getMaxPlayers()) > 32 then
            self:drawTextRight(getText("UI_MaxPlayers_Notification"), maxX-tmpX, maxY-tmpY , 0.8, 0.8, 0.8, 1, UIFont.NewMedium);
            tmpY = tmpY + UI_BORDER_SPACING + FONT_HGT_MEDIUM
        end

        if isShowServerInfo() then
            self:drawTextRight(statusData.serverTime .. "   " .. statusData.position .. " : " .. statusData.lastPing, maxX-tmpX, maxY-tmpY, 0.8, 0.8, 0.8, 1, UIFont.NewMedium);
            tmpY = tmpY + UI_BORDER_SPACING + FONT_HGT_MEDIUM
        end

        if isShowConnectionInfo() then
            self:drawTextRight("\"" .. getServerName() .. "\" (" .. getServerIP() .. ":" .. getServerPort() .. ")", maxX-tmpX, maxY-tmpY, 0.8, 0.8, 0.8, 1, UIFont.NewMedium);
            tmpY = tmpY + UI_BORDER_SPACING + FONT_HGT_MEDIUM
        end
    end
end

function ISEquippedItem:getDraggedEquippableItem()
    if "Tutorial" == getCore():getGameMode() then
        return
    end
    local dragging = ISInventoryPane.getActualItems(ISMouseDrag.dragging);
    for _,item in ipairs(dragging) do
        -- TODO: ISInventoryPaneContextMenu.doEquipOption() checks hand injuries.
        if item:getScriptItem():getReplaceWhenUnequip() then
            -- not allowed
        elseif item:IsWeapon() then
            if item:getCondition() > 0 then
                return item;
            end
        elseif item:IsFood() then
            -- not allowed
        elseif item:IsClothing() then
            -- not allowed
        else
            return item
        end
    end
    return nil;
end

function ISEquippedItem:getDraggedEquippableItems()
    local primaryItem = nil;
    local secondaryItem = nil;
    local mouseY = self:getMouseY()
    if (mouseY >= self.mainHand:getBottom() - 4) and (mouseY < self.offHand:getY() + 4) then
        local item = self:getDraggedEquippableItem()
        if item and (item:isTwoHandWeapon() or item:isRequiresEquippedBothHands()) then
            primaryItem = item;
            secondaryItem = item;
        end
    elseif mouseY < self.mainHand:getBottom() then
        local item = self:getDraggedEquippableItem()
        if item then
            primaryItem = item;
            if item:isRequiresEquippedBothHands() then
                secondaryItem = item;
            end
        end
    elseif mouseY < self.offHand:getBottom() then
        local item = self:getDraggedEquippableItem()
        if item then
            secondaryItem = item;
            if item:isRequiresEquippedBothHands() then
                primaryItem = item;
            end
        end
    end
    return primaryItem,secondaryItem
end

function ISEquippedItem:render()
	local primaryItem = self.chr:getPrimaryHandItem();
	local secondaryItem = self.chr:getSecondaryHandItem();

	if ISMouseDrag.dragging and self:isMouseOver() then
		local item1,item2 = self:getDraggedEquippableItems()
		if item1 and secondaryItem and (primaryItem == secondaryItem or item1 == secondaryItem) then
			secondaryItem = nil;
		end
		if item2 and primaryItem and (primaryItem == secondaryItem or primaryItem == item2) then
			primaryItem = nil;
		end
		primaryItem = item1 or primaryItem
		secondaryItem = item2 or secondaryItem
	end

	if primaryItem then
		local item = primaryItem
        if item:getTex() then
            local scale = TEXTURE_WIDTH * 0.75
            local hand = self.mainHand
            self:drawTextureScaledAspect(item:getTex(), hand.x+(hand.width/2) - (scale/2), hand.y+(hand.height/2)-(scale/2), scale, scale, item:getA(),item:getR(),item:getG(),item:getB());
        end
        -- This handles the condition star. commented out in case it's to be readded later
--		if instanceof(item,"HandWeapon") then
--			local n = math.floor(((item:getCondition() / item:getConditionMax()) * 5));

--			if(item:getCondition() > 0 and n == 0) then
--				n = 1;
--			end

--			self:drawTexture(getTexture("media/ui/QualityStar_" .. n .. ".png"),5,10,1,1,1,1);
--		end
	end
	if secondaryItem then
        local item = secondaryItem
        if item:getTex() then
            local scale = TEXTURE_HEIGHT * 0.75
            local hand = self.offHand
            self:drawTextureScaledAspect(item:getTex(), hand.x+(hand.width/2) - (scale/2), hand.y+(hand.height/2)-(scale/2), scale, scale, item:getA(),item:getR(),item:getG(),item:getB());
        end
	end

    if self.chr:getBodyDamage():getHealth() ~= self.previousHealth then
        if self.previousHealth > self.chr:getBodyDamage():getHealth() then
            self.healthIconOscillatorLevel = 1;
        end
        self.previousHealth = self.chr:getBodyDamage():getHealth()
    end

    --code for the oscillation of the heart icon when attacked
    if not self.healthBtn then
        -- Player 1/2/3
    elseif self.healthIconOscillatorLevel > 0.01 then
        local fpsFrac = (UIManager.getMillisSinceLastRender() / 33.3) * 0.5;
        self.healthIconOscillatorLevel = self.healthIconOscillatorLevel * self.healthIconOscillatorDecelerator
        self.healthIconOscillatorLevel = self.healthIconOscillatorLevel - (self.healthIconOscillatorLevel * (1 - self.healthIconOscillatorDecelerator) * fpsFrac)
        self.healthIconOscillatorStep = self.healthIconOscillatorStep + self.healthIconOscillatorRate * fpsFrac
        self.healthIconOscillator = math.sin(self.healthIconOscillatorStep)
        self.healthBtn:setX(self.healthIconOscillator * self.healthIconOscillatorLevel * self.healthIconOscillatorScalar)
    elseif self.healthIconOscillatorLevel < 0.01 then
        self.healthIconOscillatorLevel = 0
        self.healthBtn:setX(self.healthIconOscillator * self.healthIconOscillatorLevel * self.healthIconOscillatorScalar)
    end

    if self.invBtn == nil then
        return;
    end

	if ISEquippedItem.text then
		self:drawText(ISEquippedItem.text, 50,0,1,1,1,1,UIFont.Medium);
    end

    self:checkToolTip();

    self:renderFPS();
end

function ISEquippedItem:renderFPS()
    if not ISFPS or not ISFPS.start then return end
    local second = getTimestamp()
    if (ISFPS.lastSec ~= second) or (ISEquippedItem.text == nil) then
        ISEquippedItem.text = "FPS: " .. getAverageFPS() .. "\r\nCPU Waiting for GPU: " .. getCPUWait() .. "ms\r\nGPU Waiting for CPU: " .. getGPUWait() .. "ms\r\nCPU Time: " .. getCPUTime() .. "ms\r\nGPU Time: " .. getGPUTime() .. "ms"
        ISFPS.lastSec = second
    end
end

function ISEquippedItem:onOptionMouseDown(button, x, y)
    local focus = nil
    local playerNum = self.chr:getPlayerNum()
	if button.internal == "INVENTORY" then
        self.inventory:setVisible(not self.inventory:getIsVisible());
        self.loot:setVisible(self.inventory:getIsVisible());
        if self.inventory:isVisible() then
            focus = self.inventory
        end
    elseif button.internal == "HEALTH" then
	--	xpUpdate.toggleCharacterInfo(self.chr);
		self.infopanel:toggleView(getText("IGUI_XP_Health"));
        if self.infopanel:isVisible() then
            focus = self.infopanel.panel:getActiveView()
        end
    elseif button.internal == "CRAFTING" then
        if ISEntityUI.players[self.chr:getPlayerNum()] and ISEntityUI.players[self.chr:getPlayerNum()].windows["HandcraftWindow"] and ISEntityUI.players[self.chr:getPlayerNum()].windows["HandcraftWindow"].instance then
            ISEntityUI.players[self.chr:getPlayerNum()].windows["HandcraftWindow"].instance:close();
        else
            if isKeyDown(Keyboard.KEY_LMENU) then
                ISEntityUI.OpenHandcraftWindow(self.chr, nil, "*");
            else
                -- temporary option to open handcraft window
                ISEntityUI.OpenHandcraftWindow(self.chr, nil);
            end
        end
--         elseif isKeyDown(Keyboard.KEY_LSHIFT) then
--             -- temporary option to open handcraft window
--             ISEntityUI.OpenHandcraftWindow(self.chr, nil);
--         else
--             ISCraftingUI.toggleCraftingUI();
--             if getPlayerCraftingUI(playerNum):isVisible() then
--                 focus = getPlayerCraftingUI(playerNum)
--             end
--         end
    elseif button.internal == "ZONE" then
        ISDesignationZonePanel.toggleZoneUI(playerNum);
        if getPlayerZoneUI(playerNum) and getPlayerZoneUI(playerNum):isVisible() then
            focus = getPlayerZoneUI(playerNum)
        end
        ISAnimalZoneFirstInfo.showUI(playerNum, false);
    elseif button.internal == "MAP" then
        ISWorldMap.ToggleWorldMap(self.chr:getPlayerNum())
    elseif button.internal == "DEBUG" and (getCore():getDebug() or ISDebugMenu.forceEnable) then
        if ISDebugMenu.instance then
            ISDebugMenu.instance:close();
        else
            ISDebugMenu.OnOpenPanel();
        end
    elseif button.internal == "USERPANEL" then
        if ISUserPanelUI.instance then
            ISUserPanelUI.instance:close()
        else
            local modal = ISUserPanelUI:new(200, 200, 400, 250, self.chr)
            modal:initialise();
            modal:addToUIManager();
        end
    elseif button.internal == "ADMINPANEL" then
        if ISAdminPanelUI.instance then
            ISAdminPanelUI.instance:close()
        else
            local modal = ISAdminPanelUI:new(200, 200, 350, 400)
            modal:initialise();
            modal:addToUIManager();
        end
    elseif button.internal == "WARMANAGERPANEL" then
        if ISWarManagerUI.instance then
            ISWarManagerUI.instance:closeModal()
        else
            local modal = ISWarManagerUI:new(200, 200, 350, 270, getPlayer())
            modal:initialise();
            modal:addToUIManager();
        end
    elseif button.internal == "BUILD" then
        if ISEntityUI.players[self.chr:getPlayerNum()] and ISEntityUI.players[self.chr:getPlayerNum()].windows["BuildWindow"] and ISEntityUI.players[self.chr:getPlayerNum()].windows["BuildWindow"].instance then
            ISEntityUI.players[self.chr:getPlayerNum()].windows["BuildWindow"].instance:close();
        else
            ISEntityUI.OpenBuildWindow(self.chr, nil, "*");
        end
    elseif button.internal == "SEARCH" then
        ISSearchWindow.toggleWindow(self.chr);
    elseif button.internal == "SAFETY" then
        self:toggleSafety();
    end
    if focus and JoypadState.players[playerNum+1] then
        setJoypadFocus(playerNum, focus)
    end
end

local activateCounter = 0;
local activateTicks = 10; -- the actual value * 2;
local lastId = 0;
function ISEquippedItem:checkToolTip()
    local mx, my = getMouseX(), getMouseY();
    local mouseOverID, tooltiptext = -1, nil;
    if self:isMouseOver() and self.mouseOverList ~= nil then
        for k,v in ipairs(self.mouseOverList) do
            if self:checkBounds(v.object, mx, my) then
                mouseOverID = k;
                tooltiptext = v.displayString;
            end
        end
    end
    local activate = false;
    if mouseOverID > 0 then
        if activateCounter < activateTicks then
            activateCounter = activateCounter+1;
        end
        if activateCounter > activateTicks/2 then
            activate = true;
        elseif mouseOverID~=lastId then
            --reset counting
            activateCounter = 0;
        end
        lastId = mouseOverID;
    elseif activateCounter > 0 then
        activateCounter = activateCounter-1;
    end
    self:doToolTip(activate, tooltiptext);
end

function ISEquippedItem:doToolTip( _state, _text )
    if _state then
        if self.toolTip == nil then
            self.toolTip = ISToolTip:new();
            self.toolTip:initialise();
            self.toolTip:addToUIManager();
            self.toolTip:setOwner(self);
            self.toolTip:setWidth(100);
            self.toolTip.description = _text;
            self.toolTip:doLayout();
            self.toolTip:setVisible(true);
        else
            if self.toolTip then
                if self.toolTip:getIsVisible()==false then
                    self.toolTip:setVisible(true);
                    self.toolTip:addToUIManager();
                end
                if self.toolTip.description ~= _text then
                    self.toolTip.description = _text;
                    self.toolTip:doLayout();
                end

                self.toolTip:bringToTop();
            end
        end
    else
        if self.toolTip and self.toolTip:getIsVisible() then
            self.toolTip:removeFromUIManager();
            self.toolTip:setVisible(false);
        end
    end
end

function ISEquippedItem:checkBounds( _boundsItem, _x, _y)
    if _boundsItem~=nil and _x>=_boundsItem:getX() and _x<=_boundsItem:getX()+_boundsItem:getWidth() and _y>=_boundsItem:getY() and _y<=_boundsItem:getY()+_boundsItem:getHeight() then
        return true;
    end
    return false;
end

function ISEquippedItem:new (x, y, width, height, chr)
    setTextureWidth()
	local o = ISPanel.new(self, x, y, width, height);
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.5};
    o.playerNum = chr:getPlayerNum();
    o.inventory = getPlayerInventory(o.playerNum);
    o.loot = getPlayerLoot(o.playerNum);
    o.infopanel = getPlayerInfoPanel(o.playerNum);
    o.anchorLeft = true;
    o.chr = chr;
    o.safety = o.chr:getSafety()
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
	o.handMainTexture = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/HandMain_Off_" .. TEXTURE_WIDTH .. ".png");
	o.HandSecondaryTexture = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/HandSecondary_Off_" .. TEXTURE_WIDTH .. ".png");
    --inventory
	o.inventoryTexture = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Inventory_Off_" .. TEXTURE_WIDTH .. ".png");
	o.inventoryTextureOn = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Inventory_On_" .. TEXTURE_WIDTH .. ".png");
    --health
    o.heartIcon = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Heart_Off_" .. TEXTURE_WIDTH .. ".png");
    o.heartIconOn = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Heart_On_" .. TEXTURE_WIDTH .. ".png");
    --crafting
    o.craftingIcon = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Carpentry_Off_" .. TEXTURE_WIDTH .. ".png");
    o.craftingIconOn = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Carpentry_On_" .. TEXTURE_WIDTH .. ".png");
    --building
    o.moveableIconBuild = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Build_Off_" .. TEXTURE_WIDTH .. ".png");
    o.moveableIconBuildOn = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Build_On_" .. TEXTURE_WIDTH .. ".png");
    --move furniture
    o.movableIcon = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Furniture_On_" .. TEXTURE_WIDTH .. ".png");
    o.movableIconOff = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Furniture_Off_" .. TEXTURE_WIDTH .. ".png");
    o.movableIconPickup = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Furniture_Pickup_" .. TEXTURE_WIDTH .. ".png");
    o.movableIconPlace = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Furniture_Place_" .. TEXTURE_WIDTH .. ".png");
    o.movableIconRotate = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Furniture_Rotate_" .. TEXTURE_WIDTH .. ".png");
    o.movableIconScrap = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Furniture_Disassemble_" .. TEXTURE_WIDTH .. ".png");
    o.moveableIconRepair = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Furniture_Repair_" .. TEXTURE_WIDTH .. ".png");
    --investigate area
    o.searchIcon = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Search_Off_" .. TEXTURE_WIDTH .. ".png");
    o.searchIconOn = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Search_On_" .. TEXTURE_WIDTH .. ".png");
    --designated zones
    o.zoneIcon = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/AnimalZone_Off_" .. TEXTURE_WIDTH .. ".png");
    o.zoneIconOn = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/AnimalZone_On_" .. TEXTURE_WIDTH .. ".png");
    --map
    o.mapIconOff = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Map_Off_" .. TEXTURE_WIDTH .. ".png");
    o.mapIconOn = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Map_On_" .. TEXTURE_WIDTH .. ".png");
    --debug
    o.debugIcon = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Debug_Off_" .. TEXTURE_WIDTH .. ".png");
    o.debugIconOn = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Debug_On_" .. TEXTURE_WIDTH .. ".png");

    o.clientIcon = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Client_Icon_Off_" .. TEXTURE_WIDTH .. ".png");
    o.clientIconOn = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Client_Icon_On_" .. TEXTURE_WIDTH .. ".png");
    o.adminIcon = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Admin_Icon_Off_" .. TEXTURE_WIDTH .. ".png");
    o.adminIconOn = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Admin_Icon_On_" .. TEXTURE_WIDTH .. ".png");
    o.warActive = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/War_Inactive_" .. TEXTURE_WIDTH .. ".png");
    o.warInactive = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/War_Active_" .. TEXTURE_WIDTH .. ".png");
    o.warSoon = getTexture("media/ui/war_soon.png");
    o.lockTexture = getTexture("media/ui/pvpicon_clock.png");

    o.offTexture = getTexture("media/ui/pvpicon_on.png"); --getTexture("media/ui/SafetyOFF.png");
    o.onTexture = getTexture("media/ui/pvpicon_off.png"); --getTexture("media/ui/SafetyON.png");
    o.disableTexture = getTexture("media/ui/pvpicon_off.png"); --getTexture("media/ui/SafetyDISABLE.png");
    o.healthIconOscillatorLevel = 0.0;
    o.healthIconOscillator = 0.0;
    o.healthIconOscillatorDecelerator = 0.96;
    o.healthIconOscillatorRate = 0.8;
    o.healthIconOscillatorScalar = 15.6;
    o.healthIconOscillatorStartLevel = 1.0;
    o.healthIconOscillatorStep = 0.0;
    o.previousHealth = 0.0;
    o.sidebarSizeOption = getCore():getOptionSidebarSize()
    ISEquippedItem.instance = o;
	return o;
end

local function createFakeObject(_x,_y,_w,_h)
    local self = {};
    self.x = _x;
    self.y = _y;
    self.w = _w;
    self.h = _h;
    function self:getX() return self.x end
    function self:getY() return self.y end
    function self:getWidth() return self.w end
    function self:getHeight() return self.h end
    return self;
end

function ISEquippedItem:addMouseOverToolTipItem( _object, _displayString )
    if self.mouseOverList == nil then
        self.mouseOverList = {};
    end
    if _object~=nil and _object.getX and _object.getY and _object.getWidth and _object.getHeight then
        table.insert(self.mouseOverList, { object = _object, displayString =  _displayString } );
    end
end



function ISEquippedItem:initialise()
    setTextureWidth()
	ISPanel.initialise(self);

    self.mainHand = ISImage:new(0, 0, TEXTURE_WIDTH, TEXTURE_WIDTH, self.handMainTexture);
    self.mainHand.scaledWidth = TEXTURE_WIDTH;
    self.mainHand.scaledHeight = TEXTURE_WIDTH;
    self.mainHand:initialise();
    self.mainHand.onMouseUp = self.onMouseUpPrimary;
    self.mainHand.onRightMouseUp = self.rightClickPrimary;
    self.mainHand.parent = self;
    self:addChild(self.mainHand);
    local y = self.mainHand:getBottom() + UI_BORDER_SPACING + 5

    --    self:drawTexture(self.HandSecondaryTexture, -1, 50, 1, 1, 1, 1);
    self.offHand = ISImage:new(0, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, self.HandSecondaryTexture);
    self.offHand.scaledWidth = TEXTURE_WIDTH;
    self.offHand.scaledHeight = TEXTURE_HEIGHT;
    self.offHand:initialise();
    self.offHand.onMouseUp = self.onMouseUpSecondary;
    self.offHand.onRightMouseUp = self.rightClickSecondary;
    self.offHand.parent = self;
    self:addChild(self.offHand);

    self:setHeight(self.offHand:getBottom());
    local y = self.offHand:getBottom() + UI_BORDER_SPACING + 5

    if self.chr:getPlayerNum() == 0 then
        self:addMouseOverToolTipItem(createFakeObject(self.mainHand.x,self.mainHand.y,self.mainHand.width,self.mainHand.height), getText("IGUI_PrimaryTooltip") );
        self:addMouseOverToolTipItem(createFakeObject(self.offHand.x,self.offHand.y,self.offHand.width,self.offHand.height), getText("IGUI_SecondaryTooltip") );

        -- inv btn
        self.invBtn = ISButton:new(0, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, "", self, ISEquippedItem.onOptionMouseDown);
        self.invBtn:setImage(self.inventoryTexture);
        self.invBtn.internal = "INVENTORY";
        self.invBtn:initialise();
        self.invBtn:instantiate();
        self.invBtn:setDisplayBackground(false);
        self.invBtn:ignoreWidthChange();
        self.invBtn:ignoreHeightChange();
        self:addChild(self.invBtn);
        self:addMouseOverToolTipItem(self.invBtn, getText("IGUI_InventoryTooltip") );

        local y = self.invBtn:getBottom() + UI_BORDER_SPACING + 5

        -- health btn
        self.healthBtn = ISButton:new(0, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, "", self, ISEquippedItem.onOptionMouseDown);
        self.healthBtn:setImage(self.heartIcon);
        self.healthBtn.internal = "HEALTH";
        self.healthBtn:initialise();
        self.healthBtn:instantiate();
        self.healthBtn:setDisplayBackground(false);
        self.healthBtn:ignoreWidthChange();
        self.healthBtn:ignoreHeightChange();
        self:addChild(self.healthBtn);
        self:addMouseOverToolTipItem(self.healthBtn, getText("IGUI_HealthTooltip"));

        y = self.healthBtn:getBottom() + UI_BORDER_SPACING + 5

        -- crafting button
        self.craftingBtn = ISButton:new(0, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, "", self, ISEquippedItem.onOptionMouseDown);
        self.craftingBtn:setImage(self.craftingIcon);
        self.craftingBtn.internal = "CRAFTING";
        self.craftingBtn:initialise();
        self.craftingBtn:instantiate();
        self.craftingBtn:setDisplayBackground(false);
        self.craftingBtn:ignoreWidthChange();
        self.craftingBtn:ignoreHeightChange();
        self:addChild(self.craftingBtn);
        self:addMouseOverToolTipItem(self.craftingBtn, getText("IGUI_CraftingTooltip") );

        y = self.craftingBtn:getBottom() + UI_BORDER_SPACING + 5

        -- building button
        self.buildBtn = ISButton:new(5, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, "", self, ISEquippedItem.onOptionMouseDown);
        self.buildBtn:setImage(self.moveableIconBuild);
        self.buildBtn.internal = "BUILD";
        self.buildBtn:initialise();
        self.buildBtn:instantiate();
        self.buildBtn:setDisplayBackground(false);
        self.buildBtn:ignoreWidthChange();
        self.buildBtn:ignoreHeightChange();
        self:addChild(self.buildBtn);
        self:addMouseOverToolTipItem(self.buildBtn, getText("IGUI_Build_Name") );

        y = self.buildBtn:getBottom() + UI_BORDER_SPACING + 5

        -- moveable button
        self.movableBtn = ISButton:new(0, y, TEXTURE_WIDTH, TEXTURE_WIDTH, "", self, ISEquippedItem.onOptionMouseDown);
        self.movableBtn:setImage(self.movableIcon);
        self.movableBtn.internal = "MOVABLE";
        self.movableBtn:initialise();
        self.movableBtn:instantiate();
        self.movableBtn:setDisplayBackground(false);
        self.movableBtn:ignoreWidthChange();
        self.movableBtn:ignoreHeightChange();

        self.movableTooltip = ISMoveablesIconToolTip:new (0, self.movableBtn:getY(), 120, TEXTURE_WIDTH, self.movableBtn:getRight());

        self.movablePopup = ISMoveablesIconPopup:new(10 + self.movableBtn:getX(), 10 + self.movableBtn:getY(), TEXTURE_WIDTH * 6, TEXTURE_WIDTH)
        self.movablePopup.owner = self
        self.movablePopup:addToUIManager()
        self.movablePopup:setVisible(false)

        self:addChild(self.movableTooltip);
        self:addChild(self.movableBtn);
        self:addMouseOverToolTipItem(self.movableBtn, getText("IGUI_MovableTooltip") );

        y = self.movableBtn:getBottom() + UI_BORDER_SPACING + 5

        -- search button
        self.searchBtn = ISButton:new(0, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, "", self, ISEquippedItem.onOptionMouseDown);
        self.searchBtn:setImage(self.searchIcon);
        self.searchBtn.internal = "SEARCH";
        self.searchBtn:initialise();
        self.searchBtn:instantiate();
        self.searchBtn:setDisplayBackground(false);
        self.searchBtn:ignoreWidthChange();
        self.searchBtn:ignoreHeightChange();
        self:addChild(self.searchBtn);
        self:addMouseOverToolTipItem(self.searchBtn, getText("UI_investigate_area_window_title") );

        y = self.searchBtn:getBottom() + UI_BORDER_SPACING + 5

        -- animal zone button
        self.zoneBtn = ISButton:new(0, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, "", self, ISEquippedItem.onOptionMouseDown);
        self.zoneBtn:setImage(self.zoneIcon);
        self.zoneBtn.internal = "ZONE";
        self.zoneBtn:initialise();
        self.zoneBtn:instantiate();
        self.zoneBtn:setDisplayBackground(false);
        self.zoneBtn:ignoreWidthChange();
        self.zoneBtn:ignoreHeightChange();
        self:addChild(self.zoneBtn);
        self:addMouseOverToolTipItem(self.zoneBtn, getText("IGUI_Zone_Name") );

        y = self.zoneBtn:getBottom() + UI_BORDER_SPACING + 5

        if ISWorldMap.IsAllowed() then
            self.mapBtn = ISButton:new(0, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, "", self, ISEquippedItem.onOptionMouseDown);
            self.mapBtn:setImage(self.mapIconOff);
            self.mapBtn.internal = "MAP";
            self.mapBtn:initialise();
            self.mapBtn:instantiate();
            self.mapBtn:setDisplayBackground(false);
            self.mapBtn:ignoreWidthChange();
            self.mapBtn:ignoreHeightChange();
            self:addChild(self.mapBtn);

            if ISMiniMap.IsAllowed() then
                self.mapPopup = ISMapPopup:new(10 + self.mapBtn:getX(), 10 + self.mapBtn:getY(), TEXTURE_WIDTH * 2, TEXTURE_HEIGHT)
                self.mapPopup.owner = self
                self.mapPopup:addToUIManager()
                self.mapPopup:setVisible(false)
            end

            y = self.mapBtn:getBottom() + UI_BORDER_SPACING + 5
        end

        if getCore():getDebug() or (ISDebugMenu.forceEnable and not isClient()) then
            self.debugBtn = ISButton:new(0, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, "", self, ISEquippedItem.onOptionMouseDown);
            self.debugBtn:setImage(self.debugIcon);
            self.debugBtn.internal = "DEBUG";
            self.debugBtn:initialise();
            self.debugBtn:instantiate();
            self.debugBtn:setDisplayBackground(false);
            self.debugBtn:ignoreWidthChange();
            self.debugBtn:ignoreHeightChange();

            self:addChild(self.debugBtn);
            self:addMouseOverToolTipItem(self.debugBtn, getText("IGUI_DebugMenu"));

            self:setHeight(self.debugBtn:getBottom())
            y = self.debugBtn:getY() + self.debugIcon:getHeightOrig() + 5
        elseif self.mapBtn then
            self:setHeight(self.mapBtn:getBottom());
        elseif self.searchBtn then
            self:setHeight(self.searchBtn:getBottom());
        else
            self:setHeight(self.movableBtn:getBottom());
        end;

        if isClient() then
            self.safetyBtn = ISButton:new(2, y, self.disableTexture:getWidthOrig(), self.disableTexture:getHeightOrig(), "", self, ISEquippedItem.onOptionMouseDown);
            self.safetyBtn:setImage(self.disableTexture);
            self.safetyBtn.internal = "SAFETY";
            self.safetyBtn:initialise();
            self.safetyBtn:instantiate();
            self.safetyBtn:setDisplayBackground(false);
            self.safetyBtn.borderColor = {r=1, g=1, b=1, a=0.1};
            self.safetyBtn:ignoreWidthChange();
            self.safetyBtn:ignoreHeightChange();
            self:addChild(self.safetyBtn);

            self.radialIcon = ISRadialProgressBar:new(2, y, self.disableTexture:getWidthOrig(), self.disableTexture:getHeight(), nil);
            self.radialIcon:setVisible(false);
            self:addChild(self.radialIcon);

            self:setHeight(self.safetyBtn:getBottom())
            y = self.safetyBtn:getBottom() + UI_BORDER_SPACING + 5
        end
        if isClient() then
            self.clientBtn = ISButton:new(0, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, "", self, ISEquippedItem.onOptionMouseDown);
            self.clientBtn:setImage(self.clientIcon);
            self.clientBtn.internal = "USERPANEL";
            self.clientBtn:initialise();
            self.clientBtn:instantiate();
            self.clientBtn:setDisplayBackground(false);
            self.clientBtn.borderColor = {r=1, g=1, b=1, a=0.1};
            self.clientBtn:ignoreWidthChange();
            self.clientBtn:ignoreHeightChange();
            self:addChild(self.clientBtn);
    
            self:setHeight(self.clientBtn:getBottom())
            y = y + self.clientIcon:getHeightOrig() + 5

            self.adminBtn = ISButton:new(0, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, "", self, ISEquippedItem.onOptionMouseDown);
            self.adminBtn:setImage(self.adminIcon);
            self.adminBtn.internal = "ADMINPANEL";
            self.adminBtn:initialise();
            self.adminBtn:instantiate();
            self.adminBtn:setDisplayBackground(false);
            self.adminBtn.borderColor = {r=1, g=1, b=1, a=0.1};
            self.adminBtn:ignoreWidthChange();
            self.adminBtn:ignoreHeightChange();
            self:addChild(self.adminBtn);

            self:setHeight(self.adminBtn:getBottom())
            y = y + self.adminIcon:getHeightOrig() + 5

            self.warManagerBtnX = 5
            self.warManagerBtnY = y
            self.warManagerBtn = ISButton:new(0, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, "", self, ISEquippedItem.onOptionMouseDown);
            self.warManagerBtn:setImage(self.warSoon);
            self.warManagerBtn.internal = "WARMANAGERPANEL";
            self.warManagerBtn:initialise();
            self.warManagerBtn:instantiate();
            self.warManagerBtn:setDisplayBackground(false);
            self.warManagerBtn.borderColor = {r=1, g=1, b=1, a=0.1};
            self.warManagerBtn:ignoreWidthChange();
            self.warManagerBtn:ignoreHeightChange();
            self:addChild(self.warManagerBtn);

            self:setHeight(self.warManagerBtn:getBottom())
            y = self.warManagerBtn:getY() + self.warActive:getHeightOrig() + 5
        end
    end

    self:shrinkWrap()
end

function ISEquippedItem:shrinkWrap()
    local xMax = 0
    local yMax = 0
    local children = self:getChildren()
    for _,child in pairs(children) do
        if child.Type == "ISButton" then
            xMax = math.max(xMax, child:getRight())
            yMax = math.max(yMax, child:getBottom())
        end
    end
    self:setWidth(xMax)
    self:setHeight(yMax)
end

function ISEquippedItem:onMouseUp(x, y)
    if ISMouseDrag.dragging then
        local item1,item2 = self:getDraggedEquippableItems()
        if isForceDropHeavyItem(item1) then
            ISInventoryPaneContextMenu.equipHeavyItem(self.chr, item1)
        elseif item1 and (item1 == item2) then
            ISInventoryPaneContextMenu.equipWeapon(item1, true, true, self.chr:getPlayerNum())
        elseif item1 then
            ISInventoryPaneContextMenu.equipWeapon(item1, true, item1:isRequiresEquippedBothHands(), self.chr:getPlayerNum())
        elseif item2 then
            ISInventoryPaneContextMenu.equipWeapon(item2, false, item2:isRequiresEquippedBothHands(), self.chr:getPlayerNum())
        end
    end
end

function ISEquippedItem:onMouseUpPrimary(x, y)
    if ISMouseDrag.dragging then
        getPlayerInventory(self.parent.chr:getPlayerNum()).render3DItems = {};
        getPlayerLoot(self.parent.chr:getPlayerNum()).render3DItems = {};
        local item1,item2 = self.parent:getDraggedEquippableItems()
        if item1 and item2 then
            return self.parent:onMouseUp(x, y)
        end
        local item = item1 or item2
        if item then
            if isForceDropHeavyItem(item) then
                ISInventoryPaneContextMenu.equipHeavyItem(self.parent.chr, item)
            else
                ISInventoryPaneContextMenu.equipWeapon(item, true, item:isRequiresEquippedBothHands(), self.parent.chr:getPlayerNum())
            end
        end
    end
end

function ISEquippedItem:onMouseUpSecondary(x, y)
    if ISMouseDrag.dragging then
        getPlayerInventory(self.parent.chr:getPlayerNum()).render3DItems = {};
        getPlayerLoot(self.parent.chr:getPlayerNum()).render3DItems = {};
        local item1,item2 = self.parent:getDraggedEquippableItems()
        if item1 and item2 then
            return self.parent:onMouseUp(x, y)
        end
        local item = item1 or item2
        if item then
            if isForceDropHeavyItem(item) then
                ISInventoryPaneContextMenu.equipHeavyItem(self.parent.chr, item)
            else
                ISInventoryPaneContextMenu.equipWeapon(item, false, item:isRequiresEquippedBothHands(), self.parent.chr:getPlayerNum())
            end
        end
    end
end

function ISEquippedItem:rightClickPrimary(x, y)
    local context = ISContextMenu.get(self.parent.chr:getPlayerNum(), getMouseX(), getMouseY());
    context = ISInventoryPaneContextMenu.createMenu(self.parent.chr:getPlayerNum(), true, {self.parent.chr:getPrimaryHandItem()}, getMouseX(), getMouseY());
end

function ISEquippedItem:rightClickSecondary(x, y)
    local context = ISContextMenu.get(self.parent.chr:getPlayerNum(), getMouseX(), getMouseY());
    context = ISInventoryPaneContextMenu.createMenu(self.parent.chr:getPlayerNum(), true, {self.parent.chr:getSecondaryHandItem()}, getMouseX(), getMouseY());
end

function ISEquippedItem:removeFromUIManager()
	if self.movablePopup then
		self.movablePopup:removeFromUIManager()
	end
	if self.mapPopup then
        self.mapPopup:removeFromUIManager()
    end
	ISPanel.removeFromUIManager(self)
end

function ISEquippedItem:checkSidebarSizeOption()
    local playerData = getPlayerData(self.playerNum)
    if playerData == nil then return end
    if playerData.equipped ~= self then return end
    if self.sidebarSizeOption == getCore():getOptionSidebarSize() then return end
    self.sidebarSizeOption = getCore():getOptionSidebarSize()
    self:setVisible(false)
    self:removeFromUIManager()
    playerData.equipped = launchEquippedItem(self.chr)
end

-----

ISMoveablesIconPopup = ISPanel:derive("ISMoveablesIconPopup")

function ISMoveablesIconPopup:prerender()
    self:setAlwaysOnTop(true)
end

function ISMoveablesIconPopup:render()

    local playerID = self.owner.chr:getPlayerNum()
    local mode = nil
    if getCell():getDrag(playerID) and getCell():getDrag(playerID).isMoveableCursor then
        mode = getCell():getDrag(playerID):getMoveableMode()
    end

    local fontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
    self:drawRect(0, 0, self.width, self.height + fontHgt + 2 * 2, 0.80, 0, 0, 0)

    local index = math.floor(self:getMouseX() / TEXTURE_WIDTH)
    if index > 0 or mode then
        self:drawRect(index * TEXTURE_WIDTH, 0, TEXTURE_WIDTH, self.height, 0.15, 1, 1, 1)
    end
    
    local texts = { getText("IGUI_Exit"), getText("IGUI_Pickup"), getText("IGUI_Place"), getText("IGUI_Rotate"), getText("IGUI_Scrap"), getText("IGUI_Repair") }
    if not mode then
        texts[1] = ""
    end
    local text = texts[index+1]
    self:drawText(text, UI_BORDER_SPACING, self.height + 2, 1.0, 0.85, 0.05, 1.0, UIFont.Small)

    local x = 0
    local y = 0
    local tex = self.owner.movableIcon
    self:drawTexture(tex, x, y+((TEXTURE_WIDTH-TEXTURE_HEIGHT)/2), 1, 1, 1, 1)

    if mode == "pickup" then
        self:drawRectBorder(x + TEXTURE_WIDTH, 0, TEXTURE_WIDTH, self.height, 0.5, 1, 1, 1)
    end
    tex = self.owner.movableIconPickup
    self:drawTexture(tex, x + TEXTURE_WIDTH, y, 1, 1, 1, 1)

    if mode == "place" then
        self:drawRectBorder(x + TEXTURE_WIDTH * 2, 0, TEXTURE_WIDTH, self.height, 0.5, 1, 1, 1)
    end
    tex = self.owner.movableIconPlace
    self:drawTexture(tex, x + TEXTURE_WIDTH * 2, y, 1, 1, 1, 1)

    if mode == "rotate" then
        self:drawRectBorder(x + TEXTURE_WIDTH * 3, 0, TEXTURE_WIDTH, self.height, 0.5, 1, 1, 1)
    end
    tex = self.owner.movableIconRotate
    self:drawTexture(tex, x + TEXTURE_WIDTH * 3, y, 1, 1, 1, 1)

    if mode == "scrap" then
        self:drawRectBorder(x + TEXTURE_WIDTH * 4, 0, TEXTURE_WIDTH, self.height, 0.5, 1, 1, 1)
    end
    tex = self.owner.movableIconScrap
    self:drawTexture(tex, x + TEXTURE_WIDTH * 4, y, 1, 1, 1, 1)

    if mode == "repair" then
        self:drawRectBorder(x + TEXTURE_WIDTH * 5, 0, TEXTURE_WIDTH, self.height, 0.5, 1, 1, 1)
    end
    tex = self.owner.moveableIconRepair
    self:drawTexture(tex, x + TEXTURE_WIDTH * 5, y, 1, 1, 1, 1)
end

function ISMoveablesIconPopup:onMouseDown(x, y)
    return true
end

function ISMoveablesIconPopup:onMouseUp(x, y)
    local playerID = self.owner.chr:getPlayerNum()
    local cursor
    if getCell():getDrag(playerID) and getCell():getDrag(playerID).isMoveableCursor then
        cursor = getCell():getDrag(playerID)
    end

    local index = math.floor(x / TEXTURE_WIDTH)
    local mode = nil
    if index == 0 then
        if cursor then
            cursor:exitCursor()
        end
        return
    elseif index == 1 then
        mode = "pickup"
    elseif index == 2 then
        mode = "place"
    elseif index == 3 then
        mode = "rotate"
    elseif index == 4 then
        mode = "scrap"
    elseif index == 5 then
        mode = "repair"
    end
    if not cursor then
        cursor = ISMoveableCursor:new(self.owner.chr)
        getCell():setDrag(cursor, cursor.player)
    end
    cursor:setMoveableMode(mode)
    self:setVisible(false)
    return true
end

function ISMoveablesIconPopup:new (x, y, width, height)
    setTextureWidth()
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    return o
end

-----

ISMapPopup = ISPanel:derive("ISMapPopup")

function ISMapPopup:prerender()
    self:setAlwaysOnTop(true)
end

function ISMapPopup:render()
    local fontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()

    local boxWidth = math.max(
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_ViewMap")) + UI_BORDER_SPACING*2,
            getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_ToggleMinimap")) + UI_BORDER_SPACING*2,
            self.width
    )

    self:drawRect(0, 0, boxWidth, self.height + fontHgt + 2 * 2, 0.80, 0, 0, 0)

    local index = math.floor(self:getMouseX() / TEXTURE_WIDTH)
    if index > 0 then
        self:drawRect(index * TEXTURE_WIDTH, 0, TEXTURE_WIDTH, self.height, 0.15, 1, 1, 1)
    end

    local texts = { getText("IGUI_ViewMap"), getText("IGUI_ToggleMinimap")}
    local text = texts[index+1]
    self:drawText(text, UI_BORDER_SPACING, self.height + 2, 1.0, 0.85, 0.05, 1.0, UIFont.Small)

    local x = 0
    local y = 0

    local tex = self.texMap
    self:drawTextureScaled(tex, x, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, 1, 1, 1, 1)

    tex = self.texMiniMap
    self:drawTextureScaled(tex, x + TEXTURE_WIDTH, y, TEXTURE_WIDTH, TEXTURE_HEIGHT, 1, 1, 1, 1)
end

function ISMapPopup:onMouseDown(x, y)
    return true
end

function ISMapPopup:onMouseUp(x, y)
    self:setVisible(false)
    local playerNum = self.owner.chr:getPlayerNum()
    local index = math.floor(x / TEXTURE_WIDTH)
    local mode = nil
    if index == 0 then
        ISWorldMap.ToggleWorldMap(playerNum)
    elseif index == 1 then
        ISMiniMap.ToggleMiniMap(playerNum)
    end
    return true
end

function ISMapPopup:new(x, y, width, height)
    setTextureWidth()

    local o = ISPanel.new(self, x, y, width, height)
    o.texMap = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Map_On_" .. TEXTURE_WIDTH .. ".png")
    o.texMiniMap = getTexture("media/ui/Sidebar/" .. TEXTURE_WIDTH .."/Map_On_" .. TEXTURE_WIDTH .. ".png")

    return o
end

-----

function ISEquippedItem:toggleSafety()
    local player = getPlayer()
    if player:getSafety():isToggleAllowed() then
        player:getSafety():toggleSafety();
        local action = { character = player,
                         Type = "Safety",
                         getExtraLogData = function() return (player:getSafety():isCurrent() and "Safety On") or "Safety Off" end }
        ISLogSystem.logAction(action);
    end
end

ISEquippedItem.onKeyPressed = function(key)
    if getCore():isKey("Toggle Safety", key) then
        if isClient() then
            if getServerOptions():getBoolean("SafetySystem") then
                ISEquippedItem:toggleSafety()
            end
        else
            IsoPlayer.setCoopPVP(not IsoPlayer.getCoopPVP())
        end
    end
end

-----

function launchEquippedItem(playerObj)
	local playerNum = playerObj:getPlayerNum()
	local x = getPlayerScreenLeft(playerNum)
    local y = getPlayerScreenTop(playerNum)
	local panel = ISEquippedItem:new(x + 10, y + 10, 100, 250, playerObj);
    panel:initialise();
	panel:addToUIManager();
    return panel;
end

--Events.OnCreateUI.Add(launchEquippedItem);
Events.OnKeyPressed.Add(ISEquippedItem.onKeyPressed);
