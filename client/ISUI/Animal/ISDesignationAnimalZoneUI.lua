--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

ISDesignationZoneAnimalZoneUI = ISPanelJoypad:derive("ISDesignationZoneAnimalZoneUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.NewMedium)

-----

ISDesignationZoneAnimalZoneUI_AnimalsPanel = ISPanelJoypad:derive("ISDesignationZoneAnimalZoneUI_AnimalsPanel")
local AnimalsPanel = ISDesignationZoneAnimalZoneUI_AnimalsPanel

function AnimalsPanel:prerender()
	ISPanelJoypad.prerender(self)
	local stencilX = 1
	local stencilY = 1
	local stencilX2 = self.width - 1
	local stencilY2 = self.height - 1
--[[
	if self:isVScrollBarVisible() then
		stencilX2 = self.vscroll.x + 3 -- +3 because the scrollbar texture is narrower than the scrollbar width
	end
--]]
	self:setStencilRect(stencilX, stencilY, stencilX2 - stencilX, stencilY2 - stencilY)

	local x = 1
	local y = 1
	while y < self:getScrollHeight() do
		self:drawRect(x, y, self.width - x * 2, self.ui.itemHgt, 1.0, 0.125, 0.125, 0.125)
		y = y + self.ui.itemHgt * 2
	end

    self:updateSmoothScrolling()

    if (getJoypadData(self.ui.playerNum) ~= nil) and (self:size() > 0) and (self.selected < 1 or self.selected > self:size()) then
        self.selected = 1
    end
    for _,button in ipairs(self.ui.animalbuttons) do
        if button.joypadFocused then
            button:setJoypadFocused(false, self.joyfocus)
        end
    end
	if (not self.ui.listTakesFocus or self.joyfocus) and self.selected ~= -1 then
		local y = 1 + (self.selected - 1) * self.ui.itemHgt
		self:drawRect(x, y, self.width - x * 2, self.ui.itemHgt, 1.0, 0.25, 0.25, 0.25)
		self.ui.animalbuttons[self.selected]:setJoypadFocused(true, self.joyfocus)
	end
	if not self.joyfocus and not self.parent.joyfocus and self:isMouseOver() then
		local row = math.floor(self:getMouseY() / self.ui.itemHgt)
		if row >= 0 and row < #self.ui.animalbuttons then
			local y = 1 + row * self.ui.itemHgt
			self:drawRect(x, y, self.width - x * 2, self.ui.itemHgt, 1.0, 0.25, 0.25, 0.25)
		end
	end
end

function AnimalsPanel:render()
	ISPanelJoypad.render(self)
    local text = getText("IGUI_DesignationZone_InHutch")
    local rgb = 0.8
    for _,button in ipairs(self.ui.animalbuttons) do
        if button.animal:getHutch() then
            local textX = button:isVisible() and button:getRight() or button:getX()
            self:drawText(text, textX + 20, button:getY() + (button:getHeight() - FONT_HGT_SMALL) / 2, rgb, rgb, rgb, 1.0, UIFont.Small)
        end
    end
	self:clearStencilRect()
	if self.joyfocus then
	    self:renderJoypadFocus()
    elseif self.joypadFocused then
		local x,y,w,h = 0, 0, self.width, self.height
		self:drawRectBorderStatic(x, y, w, h, 1.0, 1.0, 1.0, 1.0)
		self:drawRectBorderStatic(x+1, y+1, w-2, h-2, 1.0, 1.0, 1.0, 1.0)
	end

    self:highlightAnimal()
end

function AnimalsPanel:highlightAnimal()
    local animal = nil
    local row = -1
    if self.joyfocus or self.parent.joyfocus then
        if self.selected ~= nil and self.selected >= 1 and self.selected <= #self.ui.animalbuttons then
            row = self.selected
        end
    elseif self:isMouseOver() then
        row = math.floor(self:getMouseY() / self.ui.itemHgt) + 1
    end
    if row >= 1 and row <= #self.ui.animalbuttons then
        animal = self.ui.animalbuttons[row].animal
    end
    if animal ~= nil and animal:getHutch() then
        animal = nil
    end
    if self.mouseOverAnimal and (animal ~= self.mouseOverAnimal) then
        self.mouseOverAnimal:setOutlineHighlight(self.ui.playerNum, false)
    end
    self.mouseOverAnimal = animal
    if self.mouseOverAnimal then
--        self.mouseOverAnimal:setHighlighted(self.ui.playerNum, true)
        self.mouseOverAnimal:setOutlineHighlight(self.ui.playerNum, true)
        self.mouseOverAnimal:setOutlineHighlightCol(1.0, 1.0, 1.0, 1.0)
    end
end

function AnimalsPanel:onMouseWheel(del)
	local rowHgt = FONT_HGT_SMALL + 10
    self:setYScroll(self:getYScroll() - (del * rowHgt))
	return true
end

function AnimalsPanel:size()
    return #self.ui.animalbuttons
end

function AnimalsPanel:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
end

function AnimalsPanel:onLoseJoypadFocus(joypadData)
    self.joyfocus = nil -- don't call setJoypadFocused(false)
end

function AnimalsPanel:onJoypadDown(button, joypadData)
    if button == Joypad.AButton then
        self.ui.animalbuttons[self.selected]:forceClick()
    end
    if button == Joypad.BButton then
        setJoypadFocus(self.ui.playerNum, self.ui)
    end
end

function AnimalsPanel:onJoypadDirUp(joypadData)
    if self.selected > 1 then
        self.selected = self.selected - 1
        self:ensureVisible(self.selected)
    end
end

function AnimalsPanel:onJoypadDirDown(joypadData)
    if self.selected > 0 and self.selected < self:size() then
        self.selected = self.selected + 1
        self:ensureVisible(self.selected)
    end
end

function AnimalsPanel:ensureVisible(index)
    if not index or index < 1 or index > self:size() then return end
    local y = self.ui.animalbuttons[index]:getY()
    local height = self.ui.animalbuttons[index]:getHeight()
    if not self.smoothScrollTargetY then self.smoothScrollY = self:getYScroll() end
    if y <= 0-self:getYScroll() then
        self.smoothScrollTargetY = 0 - y
    elseif y + height > 0 - self:getYScroll() + self.height then
        self.smoothScrollTargetY = 0 - (y + height - self.height)
    end
end

function AnimalsPanel:updateSmoothScrolling()
    if not self.smoothScrollTargetY or self:size() == 0 then return end
    local dy = self.smoothScrollTargetY - self.smoothScrollY
    local maxYScroll = self:getScrollHeight() - self:getHeight()
    local frameRateFrac = UIManager.getMillisSinceLastRender() / 33.3
    local itemHeightFrac = 160 / (self:getScrollHeight() / self:size())
    local targetY = self.smoothScrollY + dy * math.min(0.5, 0.25 * frameRateFrac * itemHeightFrac)
    if frameRateFrac > 1 then
        targetY = self.smoothScrollY + dy * math.min(1.0, math.min(0.5, 0.25 * frameRateFrac * itemHeightFrac) * frameRateFrac)
    end
    if targetY > 0 then targetY = 0 end
    if targetY < -maxYScroll then targetY = -maxYScroll end
    if math.abs(targetY - self.smoothScrollY) > 0.1 then
        self:setYScroll(targetY)
        self.smoothScrollY = targetY
    else
        self:setYScroll(self.smoothScrollTargetY)
        self.smoothScrollTargetY = nil
        self.smoothScrollY = nil
    end
end

function AnimalsPanel:new(x, y, width, height, ui)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	o.ui = ui
	o.selected = -1
	return o
end

-----

--************************************************************************--
--** ISDesignationZoneAnimalZoneUI:initialise
--**
--************************************************************************--

function ISDesignationZoneAnimalZoneUI:initialise()
    ISPanelJoypad.initialise(self);
    local btnWid = 100
    local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
    local btnHgt2 = FONT_HGT_SMALL + 2 * 2
    local padBottom = 10

--    self.parentUI:setVisible(false);

	local listBorderWidth = 1
	self.itemPadY = 4
	self.itemHgt = btnHgt + self.itemPadY * 2
	self.animalPanel = AnimalsPanel:new(10, 20 + FONT_HGT_MEDIUM + 20 + FONT_HGT_SMALL, self.width - 10 * 2 - listBorderWidth * 2, self.itemHgt * 5 + listBorderWidth * 2, self)
	self:addChild(self.animalPanel)
	self.animalPanel:setScrollChildren(true)
	self.animalPanel:addScrollBars()

    self.ok = ISButton:new(self:getWidth() - btnWid - 10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("UI_Close"), self, ISDesignationZoneAnimalZoneUI.onClick);
    self.ok.internal = "OK";
    self.ok.anchorTop = false
    self.ok.anchorBottom = true
    self.ok:initialise();
    self.ok:instantiate();
    self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
    self.ok:enableCancelColor()
    self:addChild(self.ok);

    self.reloadBtn = ISButton:new(self.ok:getRight() - btnWid - btnWid - 10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("UI_Reload"), self, ISDesignationZoneAnimalZoneUI.onClick);
    self.reloadBtn.internal = "RELOAD";
    self.reloadBtn.anchorTop = false
    self.reloadBtn.anchorBottom = true
    self.reloadBtn:initialise();
    self.reloadBtn:instantiate();
    self.reloadBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.reloadBtn);

    self.animalInfoBtn = ISButton:new(self.reloadBtn:getX() - 10 - btnWid, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("ContextMenu_Info"), self, ISDesignationZoneAnimalZoneUI.onClick);
    self.animalInfoBtn.internal = "INFO";
    self.animalInfoBtn.anchorTop = false
    self.animalInfoBtn.anchorBottom = true
    self.animalInfoBtn:initialise();
    self.animalInfoBtn:instantiate();
    self.animalInfoBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.animalInfoBtn);

    self.infoBtn = ISButton:new(10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("UI_btn_help"), self, ISDesignationZoneAnimalZoneUI.onClick);
    self.infoBtn.internal = "READINFO";
    self.infoBtn.anchorTop = false
    self.infoBtn.anchorBottom = true
    self.infoBtn:initialise();
    self.infoBtn:instantiate();
    self.infoBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.infoBtn);

    --self:reload();
    --self:updateAnimals();
end

function ISDesignationZoneAnimalZoneUI:checkExist()
    if not self.zone then return false; end

    return self.zone:isFullyStreamed();
end

function ISDesignationZoneAnimalZoneUI:prerender()
    if not self:checkExist() then
        self:close();
        return;
    end

    local z = 20;
    local x = 10;
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    self:drawTextCentre(self.zone:getName(), self.width/2, z, 1,1,1,1,UIFont.NewMedium);
    z = z + FONT_HGT_MEDIUM + 20;

    local nbOfAnimals = self.zone:getAnimalsConnected():size()
    local hutches = self.zone:getHutchsConnected()
    for i=1,hutches:size() do
        local hutch = hutches:get(i-1)
        nbOfAnimals = nbOfAnimals + hutch:getAnimalInside():size()
    end
    self:drawText(getText("IGUI_DesignationZone_Animals") .. nbOfAnimals, 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    if self.nbOfAnimals ~= nbOfAnimals then
        self:updateAnimals();
        self.nbOfAnimals = nbOfAnimals
    end

    self.updateTick = self.updateTick - UIManager.getMillisSinceLastRender();
    if self.updateTick <= 0 then
        self.updateTick = 1000;
        self:updateAnimals();
        self:reload();
    end

    z = self.animalPanel:getBottom() + FONT_HGT_SMALL + 3;

    self:drawText(getText("IGUI_FeedingTroughUI_Enclosure") .. self.zone:getFullZoneSize(), 10, z, 1,1,1,1, UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    self:drawText(getText("IGUI_DesignationZone_FeedingTroughs") .. self.zone:getTroughsConnected():size(), 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    self:drawText(getText("IGUI_DesignationZone_Hutchs") .. hutches:size(), 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    local food = self:calcFood();
    self:drawText(getText("IGUI_DesignationZone_Food") .. food, 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    local water = self:calcWater();
    self:drawText(getText("IGUI_DesignationZone_Water") .. water .. " mL", 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    local nearRiver = self:calcNearRiver();
    self:drawText(getText("IGUI_DesignationZone_NearRiver") .. nearRiver, 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    self:drawText(getText("IGUI_DesignationZone_RoofArea") .. self.zone:getRoofAreasConnected():size(), 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    self:setHeight(z + 50);

    self.animalInfoBtn:setEnable(#self.animalbuttons > 0)
    self.animalInfoBtn:setVisible(getJoypadData(self.playerNum) ~= nil)
end

function ISDesignationZoneAnimalZoneUI:render()
    ISPanelJoypad.render(self)
    self:renderJoypadFocus()
end

function ISDesignationZoneAnimalZoneUI:updateAnimals()
    local btnWid = 100
    local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
    local z = 1

    local buttonForAnimal = {}
    for i,v in ipairs(self.animalbuttons) do
        v:setVisible(false);
        self.animalPanel:removeChild(v);
        buttonForAnimal[v.animal] = v
    end
    local labelForAnimal = {}
    for i,v in ipairs(self.animalLabels) do
        v:setVisible(false);
        self.animalPanel:removeChild(v);
        labelForAnimal[v.animal] = v
    end

    -- sort by alphabetical order because i'm nice like that
    local animalListSorted = {};
    local animals = self.zone:getAnimalsConnected()
    local hutches = self.zone:getHutchsConnected()
    for i=1,hutches:size() do
        local hutch = hutches:get(i-1)
        animals:addAll(hutch:getAnimalInside():values())
    end
    for i=1,animals:size() do
        table.insert(animalListSorted, animals:get(i-1));
    end

    table.sort(animalListSorted, function(a,b) return not string.sort(a:getFullName(), b:getFullName()) end)

    self.animalbuttons = {};
    self.animalLabels = {};
    local maxwidth = 0;
    for i,v in ipairs(animalListSorted) do
        local btn = buttonForAnimal[v]
        if btn then
            btn:setY(z + self.itemPadY)
        else
            btn = ISButton:new(0, z + self.itemPadY, btnWid, btnHgt, getText("IGUI_Animal_Info"), self, ISDesignationZoneAnimalZoneUI.onClick);
            btn.internal = "INFO";
            btn.animal = v;
            --btn.anchorTop = false
            --btn.anchorBottom = true
            btn:initialise();
            btn:instantiate();
            btn.borderColor = {r=1, g=1, b=1, a=0.1};
        end
        btn:setVisible(getJoypadData(self.playerNum) == nil);
        self.animalPanel:addChild(btn);
        table.insert(self.animalbuttons, btn);

        local txt = v:getFullName();
        local label = labelForAnimal[v]
        if label then
            label:setY(z + self.itemPadY)
            label:setName(txt)
            label:setVisible(true)
        else
            label = ISLabel:new(10, z + self.itemPadY, btnHgt, txt ,1,1,1,1,UIFont.Small, true);
            label.animal = v
        end
        self.animalPanel:addChild(label);
        table.insert(self.animalLabels, label);
        --self:drawText(txt, 10, z, 1,1,1,1,UIFont.NewSmall);
        local width = getTextManager():MeasureStringX(UIFont.Small, txt) + 30;
        if width > maxwidth then
            maxwidth = width;
        end
        --if self.animalbuttons[i] then
        --    self.animalbuttons[i+1]:setVisible(true);
        --    --self.animalbuttons[i+1]:setX(width)
        --    self.animalbuttons[i+1]:setY(z-8)
        --end
        z = z + self.itemHgt;
    end

    for i,v in ipairs(self.animalbuttons) do
        v:setX(maxwidth)
    end

    self.animalPanel:setScrollHeight(z)

    local joypadData = getJoypadData(self.playerNum)
    if self.listTakesFocus and joypadData then
        self:clearJoypadFocus(joypadData)
        self.joypadIndexY = 1
        self.joypadIndex = 1
        self.joypadButtonsY = {}
        self.joypadButtons = {}
        self:insertNewLineOfButtons(self.animalPanel)
        self:insertNewLineOfButtons(self.infoBtn, self. reloadBtn, self.ok)
        self:restoreJoypadFocus(joypadData)
    end

    return self.animalPanel:getBottom();
end

function ISDesignationZoneAnimalZoneUI:calcNearRiver()
    return self.zone:getNearWaterSquaresConnected():size();
end

function ISDesignationZoneAnimalZoneUI:calcWater()
    local result = 0;
    for i=0, self.zone:getTroughsConnected():size()-1 do
        result = result + self.zone:getTroughsConnected():get(i):getWater() * 1000;
    end

    for i=0, self.zone:getFoodOnGroundConnected():size()-1 do
        local food = self.zone:getFoodOnGroundConnected():get(i):getItem();
        if food:isPureWater(true) then
            local fluidContainer = food:getFluidContainer();
            if not fluidContainer and food:getWorldItem() ~= nil then
                fluidContainer = food:getWorldItem():getFluidContainer()
            end
            if fluidContainer then
                local millilitres = fluidContainer:getAmount() * 1000
                result = result + millilitres;
            end
        end
    end

    return round(result, 0);
end

function ISDesignationZoneAnimalZoneUI:calcFood()
    local result = 0;
    for i=0, self.zone:getFoodOnGroundConnected():size()-1 do
        local food = self.zone:getFoodOnGroundConnected():get(i):getItem();
        if instanceof(food, "Food") then
            result = result + (math.abs(food:getHungChange()));
        end
        if instanceof(food, "DrainableComboItem") then
            result = result + (food:getCurrentUsesFloat() / food:getUseDelta()) * 0.1; -- 1 use of a drainable = 0.1 food reduction;
        end
    end
    for i=0, self.zone:getTroughsConnected():size()-1 do
        result = result + self.zone:getTroughsConnected():get(i):getCurrentFeedAmount();
    end
    return round(result, 2);
end

function ISDesignationZoneAnimalZoneUI:onClick(button)
    if button.internal == "OK" then
        self:close();
    end
    if button.internal == "RELOAD" then
        local connectedZones = DesignationZoneAnimal.getAllDZones(nil, self.zone, nil);
        for i=1,connectedZones:size() do
            connectedZones:get(i-1):check()
        end
        self:reload();
        self:updateAnimals();
    end
    if button.internal == "INFO" then
        if AnimalContextMenu.cheat then
            local ui = ISAnimalUI:new(getPlayerScreenLeft(self.playerNum)+100, getPlayerScreenTop(self.playerNum)+100, 680, 500, button.animal, self.player)
            ui:initialise();
            ui:addToUIManager();
            if getJoypadData(self.playerNum) then
                ui.prevFocus = getJoypadFocus(self.playerNum)
                setJoypadFocus(self.playerNum, ui)
            end
            return;
        end
        if button.animal:getHutch() then
            if getJoypadData(self.playerNum) then
                self:close()
            end
            local hutch = button.animal:getHutch()
            if self.player:getCurrentSquare() ~= hutch:getEntrySq() then
                ISTimedActionQueue.add(ISWalkToTimedAction:new(self.player, hutch:getEntrySq()))
            end
            ISTimedActionQueue.queueActions(self.player, self.queueCheckHutchDoor, self, hutch, button.animal)
            ISTimedActionQueue.queueActions(self.player, self.queueOpenAnimalInfo, self, hutch, button.animal)
        elseif luautils.walkAdj(self.player, button.animal:getSquare()) then
            ISTimedActionQueue.add(ISOpenAnimalInfo:new(self.player, button.animal, self))
        end
    end
    if button.internal == "READINFO" then
        ISAnimalZoneFirstInfo.showUI(self.playerNum, true);
    end
end

function ISDesignationZoneAnimalZoneUI.queueCheckHutchDoor(playerObj, self, hutch, animal)
    if animal:getNestBoxIndex() == -1 and hutch:isDoorClosed() then
        ISTimedActionQueue.add(ISToggleHutchDoor:new(playerObj, hutch))
    elseif animal:getNestBoxIndex() ~= -1 and hutch:isEggHatchDoorClosed() then
        ISTimedActionQueue.add(ISToggleHutchEggHatchDoor:new(playerObj, hutch))
    end
    -- FIXME: At least one action must be added, otherwise ISQueueActionsAction will fail.
    ISTimedActionQueue.add(ISGetHutchInfo:new(playerObj, hutch, animal))
end

function ISDesignationZoneAnimalZoneUI.queueOpenAnimalInfo(playerObj, self, hutch, animal)
    local ui = ISHutchUI.ShowWindow(playerObj, hutch) -- already shown by a previous action
    ISTimedActionQueue.add(ISOpenAnimalInfo:new(playerObj, animal, ui))
end

function ISDesignationZoneAnimalZoneUI:reload()
    self:calcFood();
    self:calcWater();
    self:calcNearRiver();
end

function ISDesignationZoneAnimalZoneUI:close()
    self:setVisible(false)
    self:removeFromUIManager()
    self.player:setSeeDesignationZone(false);
    if getJoypadData(self.playerNum) then
        setJoypadFocus(self.playerNum, nil)
    end
end

function ISDesignationZoneAnimalZoneUI:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    if self.listTakesFocus then
        if joypadData.switchingFocusFrom == self.animalPanel then
            self:restoreJoypadFocus(joypadData)
            self:setISButtonForY(self.infoBtn)
            self:setISButtonForA(self.animalInfoBtn)
            self:setISButtonForX(self.reloadBtn)
            self:setISButtonForB(self.ok)
        else
            joypadData.focus = self.animalPanel
            updateJoypadFocus(joypadData)
        end
    else
        self:setISButtonForY(self.infoBtn)
        self:setISButtonForA(self.animalInfoBtn)
        self:setISButtonForX(self.reloadBtn)
        self:setISButtonForB(self.ok)
    end
end

function ISDesignationZoneAnimalZoneUI:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearJoypadFocus(joypadData)
    self:clearISButtons()
end

function ISDesignationZoneAnimalZoneUI:onJoypadDown(button, joypadData)
    if self.listTakesFocus then
        if button == Joypad.AButton and self.animalPanel.joypadFocused then
            joypadData.focus = self.animalPanel
            return
        end
    else
        if button == Joypad.AButton then
            local selected = self.animalPanel.selected
            if self.animalbuttons[selected] then
                self.animalInfoBtn.animal = self.animalbuttons[selected].animal
                self.animalInfoBtn:forceClick()
            end
            return
        end
    end
    if button == Joypad.BButton then
        self:close()
        return
    end
    ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function ISDesignationZoneAnimalZoneUI:onJoypadDown_Descendant(descendant, button, joypadData)
    ISPanelJoypad.onJoypadDown_Descendant(self, descendant, button, joypadData)
end

function ISDesignationZoneAnimalZoneUI:onJoypadDirUp(joypadData)
    if not self.listTakesFocus then
        self.animalPanel:onJoypadDirUp(joypadData)
    end
end

function ISDesignationZoneAnimalZoneUI:onJoypadDirDown(joypadData)
    if not self.listTakesFocus then
        self.animalPanel:onJoypadDirDown(joypadData)
    end
end

--************************************************************************--
--** ISDesignationZoneAnimalZoneUI:new
--**
--************************************************************************--
function ISDesignationZoneAnimalZoneUI:new(x, y, width, height, player, zone)
    local o = {}
    o = ISPanelJoypad.new(self, x, y, width, height);
    if y == 0 then
        o.y = o:getMouseY() - (height / 2)
        o:setY(o.y)
    end
    if x == 0 then
        o.x = o:getMouseX() - (width / 2)
        o:setX(o.x)
    end
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.zone = zone;
    o.width = width;
    o.height = height;
    o.player = player;
    o.playerNum = player:getPlayerNum()
    o.animalbuttons = {};
    o.animalLabels = {};
    zone:check();
    o.moveWithMouse = true;
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    player:setSeeDesignationZone(true);
    player:resetSelectedZonesForHighlight()
    local connectedZones = DesignationZoneAnimal.getAllDZones(nil, zone, nil);
    for i=1,connectedZones:size() do
        player:addSelectedZoneForHighlight(connectedZones:get(i-1):getId())
    end
    o.nbOfAnimals = -1; -- this is used so i can auto refresh when animals nb change
    o.listTakesFocus = false
    o.updateTick = 0
    return o;
end
