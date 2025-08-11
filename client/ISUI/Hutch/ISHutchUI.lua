--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "ISUI/ISCollapsableWindowJoypad"
require "ISUI/ISUI3DModel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local UI_BORDER_SPACING = 10
local NEST_BOX_WIDTH = 160
local NEST_BOX_HEIGHT = 130
local SHELF_WIDTH = 510;
local SHELF_HEIGHT = 10
local ROOST_WIDTH = 90
local ROOST_HEIGHT = NEST_BOX_HEIGHT - SHELF_HEIGHT - 5
local PROGRESS_HEIGHT = FONT_HGT_SMALL
local PROGRESS_WIDTH = 200
local PADXY = 20

local function predicateNotBroken(item)
    return not item:isBroken()
end

-----

-- Panel to show one chicken
ISHutch3DModel = ISUI3DModel:derive("ISHutch3DModel")

function ISHutch3DModel:instantiate()
    ISUI3DModel.instantiate(self)
    self:setIsometric(false)
--    self.javaObject:setConsumeMouseEvents(false)
end

function ISHutch3DModel:onMouseDown(x, y)
    return false
end

function ISHutch3DModel:onMouseMove(dx, dy)
    return false
end

function ISHutch3DModel:onMouseMoveOutside(dx, dy)
    return false
end

function ISHutch3DModel:onMouseUp(x, y)
    return false
end

function ISHutch3DModel:onMouseUpOutside(x, y)
    return false
end

function ISHutch3DModel:onRightMouseUp(x, y)
    return false
end

function ISHutch3DModel:new(x, y, width, height)
    local o = ISUI3DModel.new(self, x, y, width, height)
    return o
end


-----

-- Panel with eggs or a chicken
ISHutchNestBox = ISPanel:derive("ISHutchNestBox")

function ISHutchNestBox:createChildren()
    self.avatar = ISHutch3DModel:new(0, 0, 330, 330)
    self.avatar:setVisible(false)
    self:addChild(self.avatar)
    self.avatar:setX(self.width / 2 - 330 / 2)
    self.avatar:setY(self.height - 330 - 25)
    self.avatar:setVariable("HutchAnimation", "sitting1")
end

function ISHutchNestBox:render()
    if self.hutchUI.hutch:isAllDoorClosed() then return; end
    ISPanel.render(self)
    local animal = self:getAnimal()
    local nest = self:getNest()
    self:drawRectBorder(0, 0, self.width, self.height, 0.7, 1, 1, 1)
    self:doNestStuff()
    if animal then
        self:drawText(getText("IGUI_Hutch_EggsNb", nest:getEggsNb()), 3, self.height - FONT_HGT_SMALL, 1, 1, 1, 1, UIFont.NewSmall)
    end
    self.avatar:setVariable("HutchAnimation", "sitting1")
    self:renderJoypadFocus()
end

function ISHutchNestBox:doNestStuff()
    self:initEggPos()
    local animal = self:getAnimal()
    local nest = self:getNest()
    if animal then
        self.hutchUI:add3DAnimal(self.avatar, animal, self.x + 55, self.y + 34)
    else
        -- draw eggs
        for i,pos in ipairs(self.possibleEggPosition) do
            if nest:getEggsNb() >= i then
                self:drawTexture(getTexture("Item_Egg"), pos.x, pos.y, 1, 1, 1, 1)
--                local egg = nest:getEgg(i-1)
--                if egg and egg:isFertilized() then
--                    self:drawTexture(self.favoriteStar, pos.x + 10, pos.y + 10, 1, 1, 1, 1)
--                end
            else
                self:drawTexture(getTexture("Item_Egg"), pos.x, pos.y, 0.2, 1, 1, 1)
            end
        end
        self.avatar:setCharacter(nil)
        self.avatar:setVisible(false)
    end
end

function ISHutchNestBox:getNest()
    return self.hutchUI.hutch:getNestBox(self.index)
end

function ISHutchNestBox:getAnimal()
    return self.hutchUI.hutch:getAnimalInNestBox(self.index)
end

function ISHutchNestBox:initEggPos()
    if #self.possibleEggPosition > 0 then return; end

    local x = 15;
    local y = 20;
    for i=0, 9 do
        local pos = {};
        pos.x = x;
        pos.y = y;
--        pos.x = pos.x + ZombRand(0,4);
--        pos.y = pos.y + ZombRand(0,4);
        table.insert(self.possibleEggPosition, pos);
        if i == 4 then
            x = 15;
            y = 70;
        else
            x = x + 25;
        end
    end
end

function ISHutchNestBox:onButtonGrab()
    local animal = self:getAnimal()
    if animal then
        -- TODO: Grab chicken, not possible for now, don't wanna grab animal that is in his nest box
    else
        local nest = self:getNest()
        if luautils.walkAdj(self.playerObj, self.hutchUI.hutch:getEntrySq()) then
            if self.playerObj:getPrimaryHandItem() then
                ISTimedActionQueue.add(ISUnequipAction:new(self.playerObj, self.playerObj:getPrimaryHandItem(), 50));
            end
            if self.playerObj:getSecondaryHandItem() and self.playerObj:getSecondaryHandItem() ~= self.playerObj:getPrimaryHandItem() then
                ISTimedActionQueue.add(ISUnequipAction:new(self.playerObj, self.playerObj:getSecondaryHandItem(), 50));
            end
            ISTimedActionQueue.add(ISHutchGrabEgg:new(self.playerObj, nest, self.hutchUI.hutch))
        end
    end
end

function ISHutchNestBox:onRightMouseUp(x, y)
    local context = ISContextMenu.get(self.playerNum, x + self:getAbsoluteX(), y + self:getAbsoluteY())
    if self:getAnimal() then
        context:addOption(getText("ContextMenu_AnimalInfo"), self:getAnimal(), AnimalContextMenu.onAnimalInfo, self.chr);
        --context:addDebugOption("Remove Animal", self, ISHutchNestBox.onCheatRemoveAnimal)
    elseif AnimalContextMenu.cheat then
        context:addDebugOption("Add Animal", self, ISHutchNestBox.onCheatAddAnimal)
    end
    --if self:getNest():getEggsNb() < 10 then
    --    context:addDebugOption("Add Egg", self, ISHutchNestBox.onCheatAddEgg)
    --end
    if self:getNest():getEggsNb() > 0 then
        context:addOption(getText("IGUI_Hutch_GrabEggs"), self, ISHutchNestBox.onButtonGrab)
    end
    if AnimalContextMenu.cheat and self:getNest():getEggsNb() > 0 then
        context:addDebugOption("Remove Egg", self, ISHutchNestBox.onCheatRemoveEgg)
    end
    if #context.options == 0 then
        local option = context:addOption(getText("UI_Cancel"), nil, nil)
        option.notAvailable = true
    end
    if getJoypadData(self.playerNum) then
        context.mouseOver = 1
        context.origin = self.parent
        setJoypadFocus(self.playerNum, context)
    end
end

function ISHutchNestBox:onCheatAddAnimal()
    local animalType = "hen"
    local breed = AnimalDefinitions.getDef(animalType):getBreedByName("rhodeisland")
    if isClient() then
        sendClientCommandV(self.playerObj, "animal", "hutch",
                "type", animalType,
                "breed", breed:getName(),
                "x", self.hutchUI.hutch:getX(),
                "y", self.hutchUI.hutch:getY(),
                "z", self.hutchUI.hutch:getZ())
    else
        local animal = addAnimal(getCell(), 0, 0, 0, animalType, breed)
        self.hutchUI.hutch:addAnimalInNestBox(animal)
    end
end

function ISHutchNestBox:onCheatRemoveAnimal()
    
end

function ISHutchNestBox:onCheatAddEgg()
    
end

function ISHutchNestBox:onCheatRemoveEgg()
    if isClient() then
        sendClientCommandV(self.playerObj, "animal", "removeEggFromNestBox",
                "x", self.hutchUI.hutch:getX(),
                "y", self.hutchUI.hutch:getY(),
                "z", self.hutchUI.hutch:getZ(),
                "nestIdx", self.index)
    else
        local index = ZombRand(self:getNest():getEggsNb())
        local egg = self:getNest():removeEgg(index)
        self.hutchUI.hutch:sync()
        self.playerObj:getInventory():AddItem(egg)
    end
end

function ISHutchNestBox:onJoypadDownInParent(button, joypadData)
    if button == Joypad.AButton then
        self:onRightMouseUp(self.width, 0)
    end
end

function ISHutchNestBox:new(x, y, width, height, hutchUI, index)
    local o = ISPanel.new(self, x, y, width, height)
    o:noBackground()
    o.hutchUI = hutchUI
    o.index = index
    o.chr = hutchUI.chr
    o.playerObj = hutchUI.chr
    o.playerNum = hutchUI.playerNum
    o.possibleEggPosition = {}
    o.favoriteStar = getTexture("media/ui/FavoriteStar.png")
    return o
end

-----

ISHutchNestParentPanel = ISPanelJoypad:derive("ISHutchNestParentPanel")

function ISHutchNestParentPanel:createChildren()
    local boxX = PADXY
    local boxY = PADXY
    local boxPerRow = 2
    local requiredNestWid = NEST_BOX_WIDTH * boxPerRow + UI_BORDER_SPACING * (boxPerRow - 1)
    local boxX1 = (self.width - requiredNestWid) / 2
    local boxY1 = boxY
    local numNestBoxes = self.hutchUI.hutch:getMaxNestBox() + 1 -- zero-based counting, max=3 means 4 boxes :-(
    self.nestBoxUI = {}
    for i=1,numNestBoxes do
        local nestBoxUI = ISHutchNestBox:new(boxX1, boxY1, NEST_BOX_WIDTH, NEST_BOX_HEIGHT, self.hutchUI, i-1)
        self:addChild(nestBoxUI)
        table.insert(self.nestBoxUI, nestBoxUI)
        boxX1 = boxX1 + NEST_BOX_WIDTH + 10
        if i % boxPerRow == 0 then
            boxX1 = (self.width - requiredNestWid) / 2
            boxY1 = boxY1 + NEST_BOX_HEIGHT + 10
        end
    end

    -----

    --self.boxCleanBtn = ISButton:new(0, 0, 90, BUTTON_HGT, "", self.hutchUI, ISHutchUI.onCleanNest);
    --self.boxCleanBtn:initialise();
    --self.boxCleanBtn.anchorTop = false
    --self.boxCleanBtn.anchorBottom = false
    --self.boxCleanBtn.borderColor = self.hutchUI.btnBorder;
    --self:addChild(self.boxCleanBtn);

    self.eggHatchDoorBtn = ISButton:new(0, 0, 80, BUTTON_HGT, "", self.hutchUI, ISHutchUI.onToggleEggHatchDoor);
    self.eggHatchDoorBtn:initialise();
    self.eggHatchDoorBtn:setTitle(getText("IGUI_Hutch_CloseEggDoors"));
    self.eggHatchDoorBtn:setWidthToTitle()
    self.eggHatchDoorBtn.anchorTop = false
    self.eggHatchDoorBtn.anchorBottom = false
    self.eggHatchDoorBtn.borderColor = self.hutchUI.btnBorder
    self:addChild(self.eggHatchDoorBtn);

    -----

    self.closedDoorPanel = ISPanel:new(0, 0, self.width, self.height)
    self.closedDoorPanel.backgroundColor = {r=0, g=0, b=0, a=1}
    self.closedDoorPanel.borderColor = {r=0, g=0, b=0, a=0}
    self:addChild(self.closedDoorPanel)
    self.closedDoorPanel:setVisible(false)

    local width1 = getTextManager():MeasureStringX(UIFont.Large, getText("IGUI_Hutch_OpenDoors"))
    local width2 = getTextManager():MeasureStringX(UIFont.Large, getText("IGUI_Hutch_OpenEggDoors"))
    local maxButtonWidth = math.max(width1, width2)
    local bigButtonWid = math.max(200, maxButtonWidth + 10 * 2)
    local bigButtonHgt = math.max(60, FONT_HGT_LARGE + 6)

    local doorBtn2 = ISButton:new(self.width / 2 - bigButtonWid / 2, self.height / 2 - bigButtonHgt / 2, bigButtonWid, bigButtonHgt,
                        getText("IGUI_Hutch_OpenEggDoors"), self.hutchUI, ISHutchUI.onToggleEggHatchDoor)
    doorBtn2.font = UIFont.Large
    doorBtn2:initialise()
    doorBtn2.anchorTop = false
    doorBtn2.anchorBottom = false
    doorBtn2.borderColor = self.hutchUI.btnBorder
    self.closedDoorPanel:addChild(doorBtn2)
    self.openDoorBtn = doorBtn2

    self:configJoypad()
end

function ISHutchNestParentPanel:prerender()
    ISPanelJoypad.prerender(self)

    self.openDoorBtn:setWidthToTitle(nil, self.openDoorBtn.isJoypad)
    self.openDoorBtn:setX((self.width - self.openDoorBtn.width) / 2)

    self.eggHatchDoorBtn:setWidthToTitle(nil, self.eggHatchDoorBtn.isJoypad) -- joypad texture may appear or disappear
    self.eggHatchDoorBtn:setX(self.width - PADXY - self.eggHatchDoorBtn.width)
    self.eggHatchDoorBtn:setY(self.height - UI_BORDER_SPACING - BUTTON_HGT)
end

function ISHutchNestParentPanel:render()
    ISPanelJoypad.render(self)

    if self.hutchUI.hutch:isEggHatchDoorOpen() then
        self.eggHatchDoorBtn:setTitle(getText("IGUI_Hutch_CloseEggDoors"));
    else
        self.eggHatchDoorBtn:setTitle(getText("IGUI_Hutch_OpenEggDoors"));
    end
    if self.hutchUI.hutch:isEggHatchDoorOpen() or self.hutchUI.hutch:isOpen() then
        if self.closedDoorPanel:isVisible() then
            self.closedDoorPanel:setVisible(false)
            self:configJoypad()
        end
    else
        if not self.closedDoorPanel:isVisible() then
            self.closedDoorPanel:setWidth(self.width)
            self.closedDoorPanel:setHeight(self.height)
            self.closedDoorPanel:bringToTop()
            self.closedDoorPanel:setVisible(true)
            self:configJoypad()
        end
        return
    end

    --local hutch = self.hutchUI.hutch
    --local fgBar = self.hutchUI.fgBar;
    --if hutch:getHutchDirt() > 70 then
    --    fgBar = self.hutchUI.fgBarRed;
    --elseif hutch:getHutchDirt() > 40 then
    --    fgBar = self.hutchUI.fgBarOrange;
    --end
    --local rowX = PADXY
    --local rowY = self.height - UI_BORDER_SPACING - BUTTON_HGT - PROGRESS_HEIGHT
    --self:drawProgressBar(rowX, rowY, PROGRESS_WIDTH, FONT_HGT_SMALL, hutch:getNestBoxDirt() / 100, fgBar)
    --self:drawText(getText("IGUI_Hutch_Dirt", round(hutch:getNestBoxDirt(), 2)), rowX + 7, rowY, 1,1,1,1, UIFont.NewSmall);
    --self.boxCleanBtn:setX(rowX)
    --self.boxCleanBtn:setY(rowY + PROGRESS_HEIGHT + 2)
    --self.boxCleanBtn:setTitle(getText("IGUI_Hutch_Clean"))
    --self.boxCleanBtn:setVisible(hutch:getNestBoxDirt() > 0);
end

function ISHutchNestParentPanel:configJoypad()
    local joypadData = getJoypadData(self.hutchUI.playerNum)
    if not joypadData then return end
    self:clearJoypadFocus(joypadData)
    self.joypadIndexY = 1
    self.joypadIndex = 1
    self.joypadButtonsY = {}
    self.joypadButtons = {}
    if self.closedDoorPanel:isVisible() then
        self:insertNewLineOfButtons(self.openDoorBtn)
        self:setISButtonForX(self.openDoorBtn)
    else
        local boxPerRow = 2
        local joypadButtons = {}
        for i,panel in ipairs(self.nestBoxUI) do
            table.insert(joypadButtons, panel)
            if #joypadButtons == boxPerRow then
                self:insertNewListOfButtons(joypadButtons)
                joypadButtons = {}
            end
        end
        if #joypadButtons > 0 then
            self:insertNewListOfButtons(joypadButtons)
        end
        --self:setISButtonForY(self.boxCleanBtn)
        self:setISButtonForX(self.eggHatchDoorBtn)
    end
    self:restoreJoypadFocus(joypadData)
end

function ISHutchNestParentPanel:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    if self.closedDoorPanel:isVisible() then
        self:setISButtonForX(self.openDoorBtn)
    else
        --self:setISButtonForY(self.boxCleanBtn)
        self:setISButtonForX(self.eggHatchDoorBtn)
    end
    self:restoreJoypadFocus(joypadData)
end

function ISHutchNestParentPanel:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearISButtons()
    self:clearJoypadFocus(joypadData)
end

function ISHutchNestParentPanel:new(x, y, width, height, hutchUI)
    local o = ISPanelJoypad.new(self, x, y, width, height)
    o.disableJoypadNavigation = true
    o.hutchUI = hutchUI
    return o
end

-----

-- Panel to show a roosting chicken (not in a nest)
ISHutchRoost = ISPanelJoypad:derive("ISHutchRoost")

function ISHutchRoost:createChildren()
    self.avatar = ISHutch3DModel:new(0, 0, 330, 330)
    self.avatar:setVisible(false)
    self:addChild(self.avatar)
    self.avatar:setX(self.width / 2 - 330 / 2)
    self.avatar:setY(self.height - 330 + 5)
    self.avatar:setVariable("HutchAnimation", "idle1")
end

function ISHutchRoost:render()
    if self.hutchUI.hutch:isAllDoorClosed() then return; end
    ISPanelJoypad.render(self)
    local rowY = self:getBottom() + 5
    self.hutchUI:checkAnimal(self.index, self.x, self.y, rowY, SHELF_HEIGHT, btnGrabOffset)
    if self:isMouseOver() then
        self:drawRectBorder(0, 0, self.width, self.height, 1.0, 0.5, 0.5, 0.5)
    end
--    if self:getAnimal() and self:getAnimal():getData():isFertilized() then
--        self:drawTexture(self.favoriteStar, self.width - 20, self.height - 20, 1, 1, 1, 1)
--    end

    local animal = self:getAnimal()
    if animal ~= nil and animal:getCustomName() ~= nil then
        self:drawTextCentre(animal:getCustomName(), self:getWidth() / 2, 1, 1, 1, 1, 1, UIFont.NewSmall)
    end

    if self.joypadFocused then
        self:renderJoypadFocus()
    elseif getJoypadData(self.playerNum) and self == self.parent:getJoypadFocus() then
        local x,y,w,h = 0, 0, self.width, self.height
        self:drawRectBorderStatic(x, y, w, h, 1.0, 0.25, 0.25, 0.25)
        self:drawRectBorderStatic(x+1, y+1, w-2, h-2, 1.0, 0.25, 0.25, 0.25)
    end
end

function ISHutchRoost:getAnimal()
    return self.hutchUI.hutch:getAnimal(self.index)
end

function ISHutchRoost:getBody()
    return self.hutchUI.hutch:getDeadBody(self.index)
end

function ISHutchRoost:onButtonGrab()
    if self.playerObj:getPrimaryHandItem() or self.playerObj:getSecondaryHandItem() then
        return;
    end
    local animal = self:getAnimal()
    if animal then
        if luautils.walkAdj(self.playerObj, self.hutchUI.hutch:getEntrySq()) then
            -- if animal is dead, grab the body instead
            if animal:isDead() then
                if not self:getBody() then
                    ISTimedActionQueue.add(ISHutchGrabAnimal:new(self.playerObj, self.index, self.hutchUI.hutch))
                    return;
                end
                ISTimedActionQueue.add(ISHutchGrabCorpseAction:new(self.playerObj, self.index, self.hutchUI.hutch))
            else
                ISTimedActionQueue.add(ISHutchGrabAnimal:new(self.playerObj, self.index, self.hutchUI.hutch))
            end
        end
    end
end

function ISHutchRoost:onRightMouseUp(x, y)
    local context = ISContextMenu.get(self.playerNum, x + self:getAbsoluteX(), y + self:getAbsoluteY())
    local animal = self.hutchUI.hutch:getAnimal(self.index)
    local option = nil
    if animal then
        option = context:addOption(getText("ContextMenu_Grab"), self, self.onButtonGrab);
        if self.playerObj:getPrimaryHandItem() or self.playerObj:getSecondaryHandItem() then
            option.notAvailable = true;
            local toolTip = ISToolTip:new()
            toolTip:initialise()
            toolTip:setVisible(false)
            toolTip:setName(getText("IGUI_Hutch_EmptyHands"))
            option.toolTip = toolTip
        end
        context:addOption(getText("ContextMenu_AnimalInfo"), animal, AnimalContextMenu.onAnimalInfo, self.chr);
        if AnimalContextMenu.cheat then
            context:addDebugOption("Force egg now", self, ISHutchRoost.onForceEgg, animal)
            context:addDebugOption("Kill", self, ISHutchRoost.onKill, animal)
            context:addDebugOption(getText("ContextMenu_RemoveAnimal"), self, ISHutchRoost.onCheatRemoveAnimal, animal)
        end
    else
        if AnimalContextMenu.cheat then
            context:addDebugOption("Add Animal", self, ISHutchRoost.onCheatAddAnimal)
        end
    end
    if #context.options == 0 then
        option = context:addOption(getText("UI_Cancel"), nil, nil)
        option.notAvailable = true
    end
    if getJoypadData(self.playerNum) then
        context.mouseOver = 1
        context.origin = self.parent
        setJoypadFocus(self.playerNum, context)
    end
end

function ISHutchRoost:onForceEgg(animal)
    if isClient() then
        sendClientCommandV(self.playerObj, "animal", "forceEgg",
                "id", animal:getOnlineID())
    else
        animal:debugForceEgg();
    end
end

function ISHutchRoost:onKill(animal)
    if isClient() then
        sendClientCommandV(self.playerObj, "animal", "kill",
                "id", animal:getOnlineID(),
                "index", animal:getData():getHutchPosition(),
                "x", self.hutchUI.hutch:getX(),
                "y", self.hutchUI.hutch:getY(),
                "z", self.hutchUI.hutch:getZ())
    else
        self.hutchUI.hutch:killAnimal(animal)
    end
end

function ISHutchRoost:onCheatAddAnimal()
    local animalType = "hen"
    local breed = AnimalDefinitions.getDef(animalType):getBreedByName("rhodeisland")
    if isClient() then
        sendClientCommandV(self.playerNum, "animal", "hutch",
                "type", animalType,
                "breed", breed:getName(),
                "index", self.index,
                "x", self.hutchUI.hutch:getX(),
                "y", self.hutchUI.hutch:getY(),
                "z", self.hutchUI.hutch:getZ())
    else
        local animal = addAnimal(getCell(), 0, 0, 0, animalType, breed)
        animal:getData():setPreferredHutchPosition(self.index)
        self.hutchUI.hutch:addAnimalInside(animal)
    end
end

function ISHutchRoost:onCheatRemoveAnimal(animal)
    if isClient() then
        sendClientCommandV(self.playerObj, "animal", "removeFromHutch",
                "id", animal:getOnlineID())
    else
        if self.hutchUI.hutch ~= nil then
            self.hutchUI.hutch:removeAnimal(animal)
        end

        removeAnimal(animal:getOnlineID())
    end
end

function ISHutchRoost:onJoypadDownInParent(button, joypadData)
    if button == Joypad.AButton then
        self:onRightMouseUp(self.width, 0)
    end
end

function ISHutchRoost:new(x, y, width, height, hutchUI, index)
    local o = ISPanelJoypad.new(self, x, y, width, height)
    o:noBackground()
    o.hutchUI = hutchUI
    o.index = index
    o.chr = hutchUI.chr
    o.playerObj = hutchUI.chr
    o.playerNum = hutchUI.playerNum
    o.favoriteStar = getTexture("media/ui/FavoriteStar.png")
    return o
end

-----

ISHutchRoostParentPanel = ISPanelJoypad:derive("ISHutchRoostParentPanel")

function ISHutchRoostParentPanel:createChildren()

    self.roostUI = {}
    self.avatarPanel = {}
    local animalIndex = 0
    local chickenX = PADXY
    local chickenY = PADXY
    local rowX = PADXY
    local rowY = PADXY
    for row=1,4 do
        for i=1,5 do
            local roostUI = ISHutchRoost:new(chickenX, chickenY, ROOST_WIDTH, ROOST_HEIGHT, self.hutchUI, animalIndex)
            self:addChild(roostUI)
            table.insert(self.roostUI, roostUI)
            table.insert(self.avatarPanel, roostUI.avatar)
            animalIndex = animalIndex + 1
            chickenX = chickenX + ROOST_WIDTH + 10
        end
        rowY = rowY + NEST_BOX_HEIGHT + 10
        chickenX = rowX
        chickenY = rowY
    end

    -----

    self.birdPooCleanBtn = ISButton:new(0, 0, 60, BUTTON_HGT, "", self.hutchUI, ISHutchUI.onCleanFloor);
    self.birdPooCleanBtn:initialise();
    self.birdPooCleanBtn.anchorTop = false
    self.birdPooCleanBtn.anchorBottom = false
    self.birdPooCleanBtn.borderColor = self.hutchUI.btnBorder
    self:addChild(self.birdPooCleanBtn);

    self.doorBtn = ISButton:new(0, 0, 80, BUTTON_HGT, "", self.hutchUI, ISHutchUI.onToggleDoor);
    self.doorBtn:initialise();
    self.doorBtn:setTitle(getText("IGUI_Hutch_CloseDoors"));
    self.doorBtn:setWidthToTitle()
    self.doorBtn.anchorTop = false
    self.doorBtn.anchorBottom = false
    self.doorBtn.borderColor = self.hutchUI.btnBorder
    self:addChild(self.doorBtn);

    -----

    self.closedDoorPanel = ISPanel:new(0, 0, self.width, self.height)
    self.closedDoorPanel.backgroundColor = {r=0, g=0, b=0, a=1}
    self.closedDoorPanel.borderColor = {r=0, g=0, b=0, a=0}
    self:addChild(self.closedDoorPanel)

    local width1 = getTextManager():MeasureStringX(UIFont.Large, getText("IGUI_Hutch_OpenDoors"))
    local width2 = getTextManager():MeasureStringX(UIFont.Large, getText("IGUI_Hutch_OpenEggDoors"))
    local maxButtonWidth = math.max(width1, width2)
    local bigButtonWid = math.max(200, maxButtonWidth + 10 * 2)
    local bigButtonHgt = math.max(60, FONT_HGT_LARGE + 6)

    local doorBtn2 = ISButton:new(self.width / 2 - bigButtonWid / 2, self.height / 2 - bigButtonHgt / 2, bigButtonWid, bigButtonHgt,
                        getText("IGUI_Hutch_OpenDoors"), self.hutchUI, ISHutchUI.onToggleDoor)
    doorBtn2.font = UIFont.Large
    doorBtn2:initialise()
    doorBtn2.anchorTop = false
    doorBtn2.anchorBottom = false
    doorBtn2.borderColor = self.hutchUI.btnBorder
    self.closedDoorPanel:addChild(doorBtn2)
    self.openDoorBtn = doorBtn2

    self:configJoypad()
end

function ISHutchRoostParentPanel:prerender()
    ISPanelJoypad.prerender(self)

    self.doorBtn:setWidthToTitle(nil, self.doorBtn.isJoypad)
    self.doorBtn:setX(self.width - PADXY - self.doorBtn.width)
    self.doorBtn:setY(self.height - UI_BORDER_SPACING - BUTTON_HGT)
end

function ISHutchRoostParentPanel:render()
    ISPanelJoypad.render(self)

    local playerInv = self.hutchUI.chr:getInventory()
    local waterSources = playerInv:getAllWaterFluidSources(true);
    --local cleaningSources = playerInv:getAllCleaningFluidSources();
    local mop = playerInv:containsTagEvalRecurse("CleanStains", predicateNotBroken)
    --local canClean = playerInv:containsTypeRecurse("Bleach") and (playerInv:containsTypeRecurse("BathTowel") or playerInv:containsTypeRecurse("DishCloth") or playerInv:containsTypeRecurse("Mop") or playerInv:containsTypeEvalRecurse("Broom", predicateNotBroken))
    local canClean = mop and not waterSources:isEmpty() --and not cleaningSources:isEmpty();
    if not canClean then
        self.birdPooCleanBtn.enable = false;
        self.birdPooCleanBtn.tooltip = getText("IGUI_Hutch_NeedWaterMop");
    else
        self.birdPooCleanBtn.enable = true;
        self.birdPooCleanBtn.tooltip = nil;
    end

    if self.hutchUI.hutch:isOpen() then
        if self.closedDoorPanel:isVisible() then
            self.closedDoorPanel:setVisible(false)
            self:configJoypad()
        end
    else
        if not self.closedDoorPanel:isVisible() then
            self.closedDoorPanel:setWidth(self.width)
            self.closedDoorPanel:setHeight(self.height)
            self.closedDoorPanel:bringToTop()
            self.closedDoorPanel:setVisible(true)
            self:configJoypad()
        end
        return
    end

    local rowX = 10;
    local rowY = PADXY + NEST_BOX_HEIGHT - SHELF_HEIGHT;

    ---- ROW 1 ----
    self:drawRectBorder(rowX, rowY, SHELF_WIDTH, SHELF_HEIGHT, 0.7, 1, 1, 1)

    ---- ROW 2 ----
    rowY = rowY + NEST_BOX_HEIGHT + 10;
    self:drawRectBorder(rowX, rowY, SHELF_WIDTH, SHELF_HEIGHT, 0.7, 1, 1, 1)

    ---- ROW 3 ----
    rowY = rowY + NEST_BOX_HEIGHT + 10;
    self:drawRectBorder(rowX, rowY, SHELF_WIDTH, SHELF_HEIGHT, 0.7, 1, 1, 1)

    ---- ROW 4 ----
    rowY = rowY + NEST_BOX_HEIGHT + 10;
    self:drawRectBorder(rowX, rowY, SHELF_WIDTH, SHELF_HEIGHT, 0.7, 1, 1, 1)

    local boxY = rowY + SHELF_HEIGHT + UI_BORDER_SPACING
    rowX = PADXY
    local hutch = self.hutchUI.hutch
    local fgBar = self.hutchUI.fgBar;
    if hutch:getHutchDirt() > 70 then
        fgBar = self.hutchUI.fgBarRed;
    elseif hutch:getHutchDirt() > 40 then
        fgBar = self.hutchUI.fgBarOrange;
    end
    self:drawProgressBar(rowX, boxY, PROGRESS_WIDTH, FONT_HGT_SMALL, hutch:getHutchDirt() / 100, fgBar)
    self:drawText(getText("IGUI_Hutch_Dirt", round(hutch:getHutchDirt(), 2)), rowX + 7, boxY, 1,1,1,1, UIFont.NewSmall);
    self.birdPooCleanBtn:setX(rowX)
    self.birdPooCleanBtn:setY(boxY + FONT_HGT_SMALL + 2)
    self.birdPooCleanBtn:setTitle(getText("IGUI_Hutch_Clean"))
    self.birdPooCleanBtn:setVisible(hutch:getHutchDirt() > 0);
end

function ISHutchRoostParentPanel:configJoypad()
    local joypadData = getJoypadData(self.hutchUI.playerNum)
    if not joypadData then return end
    self:clearJoypadFocus(joypadData)
    self.joypadIndexY = 1
    self.joypadIndex = 1
    self.joypadButtonsY = {}
    self.joypadButtons = {}
    if self.closedDoorPanel:isVisible() then
        self:insertNewLineOfButtons(self.openDoorBtn)
        self:setISButtonForX(self.openDoorBtn)
    else
        local boxPerRow = 5
        local joypadButtons = {}
        for i,panel in ipairs(self.roostUI) do
            table.insert(joypadButtons, panel)
            if #joypadButtons == boxPerRow then
                self:insertNewListOfButtons(joypadButtons)
                joypadButtons = {}
            end
        end
        if #joypadButtons > 0 then
            self:insertNewListOfButtons(joypadButtons)
        end
        self:setISButtonForY(self.birdPooCleanBtn)
        self:setISButtonForX(self.doorBtn)
    end
    self:restoreJoypadFocus(joypadData)
end

function ISHutchRoostParentPanel:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    if self.closedDoorPanel:isVisible() then
        self:setISButtonForX(self.openDoorBtn)
    else
        self:setISButtonForY(self.birdPooCleanBtn)
        self:setISButtonForX(self.doorBtn)
    end
    self:restoreJoypadFocus(joypadData)
end

function ISHutchRoostParentPanel:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self:clearISButtons()
    self:clearJoypadFocus(joypadData)
end

function ISHutchRoostParentPanel:hasConflictWithJoypadNavigateStart()
    return true
end

function ISHutchRoostParentPanel:new(x, y, width, height, hutchUI)
    local o = ISPanelJoypad.new(self, x, y, width, height)
    o.disableJoypadNavigation = true
    o.hutchUI = hutchUI
    return o
end

-----

ISHutchUI = ISCollapsableWindowJoypad:derive("ISHutchUI");
ISHutchUI.instance = nil
ISHutchUI.ui = {};

function ISHutchUI:prerender()
    ISCollapsableWindowJoypad.prerender(self)

    if not self.chr or not self.chr:getCurrentSquare() or self.chr:getCurrentSquare():DistToProper(self.hutch:getEntrySq()) > 5 then
        self:close();
    end
end

function ISHutchUI:render()
    ISCollapsableWindowJoypad.render(self);
    self:setInfo(getText("IGUI_Hutch_Info"));

    if self.isCollapsed then return end

    self.tabPanel:setWidth(self.tabPanel:getActiveView().width)
    self.tabPanel:setHeight(self.tabPanel.tabHeight + self.tabPanel:getActiveView().height)
    self:setWidth(self.tabPanel.width)
    self:setHeight(self:titleBarHeight() + self.tabPanel.height)
end

function ISHutchUI:initialise()
    ISCollapsableWindowJoypad.initialise(self);
    self:create();
end

function ISHutchUI:create()
    ISHutchUI.instance = self
    local titleBarHeight = self:titleBarHeight()

    self.tabPanel = ISTabPanel:new(0, titleBarHeight, self.width, self.height-titleBarHeight);
    self.tabPanel.onActivateView = ISHutchUI.onTabsActivateView
    self.tabPanel.target = self
    self:addChild(self.tabPanel)

    local numNestBoxes = self.hutch:getMaxNestBox() + 1 -- zero-based counting, max=3 means 4 boxes :-(
    local boxPerRow = 2
    local numRows = math.ceil(numNestBoxes / boxPerRow)
    local requiredNestWid = NEST_BOX_WIDTH * boxPerRow + UI_BORDER_SPACING * 1
    local nestParentPanelWid = PADXY * 2 + requiredNestWid
    local btnJoypadTextureWid = 5 + 32
    local closeDoorBtnWid = getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_Hutch_CloseEggDoors")) + 10 + btnJoypadTextureWid
    nestParentPanelWid = math.max(nestParentPanelWid, PADXY * 2 + PROGRESS_WIDTH + 20 + closeDoorBtnWid)
    local nestParentPanelHgt = PADXY + NEST_BOX_HEIGHT * numRows + 10 * (numRows - 1)
    nestParentPanelHgt = nestParentPanelHgt + UI_BORDER_SPACING + PROGRESS_HEIGHT + BUTTON_HGT + UI_BORDER_SPACING
    self.nestParentPanel = ISHutchNestParentPanel:new(0, 0, nestParentPanelWid, nestParentPanelHgt, self)
    self.nestParentPanel:noBackground()
    self.nestParentPanel:setUIName("nestParentPanel")
    self.tabPanel:addView(getText("IGUI_Hutch_EggLayingBox"), self.nestParentPanel)

    local roostParentPanelWid = PADXY + ROOST_WIDTH * 5 + 10 * 4 + PADXY
    local roostParentPanelHgt = PADXY + (NEST_BOX_HEIGHT + 10) * 4
    roostParentPanelHgt = roostParentPanelHgt + PROGRESS_HEIGHT + BUTTON_HGT + UI_BORDER_SPACING
    self.roostParentPanel = ISHutchRoostParentPanel:new(0, 0, roostParentPanelWid, roostParentPanelHgt, self)
    self.roostParentPanel:noBackground()
    self.roostParentPanel:setUIName("roostParentPanel")
    self.tabPanel:addView(getText("IGUI_Hutch_CoopRoosting"), self.roostParentPanel)

    self.avatarBackgroundTexture = getTexture("media/ui/avatarBackgroundWhite.png")
end

function ISHutchUI:onCleanNest()
--    ISTimedActionQueue.add(ISHutchClean:new(self.playerObj, self.hutch, "nest", self.hutch:getNestBoxDirt() * 20))
    if luautils.walkAdj(self.chr, self.hutch:getEntrySq()) then
        ISTimedActionQueue.add(ISHutchCleanNest:new(self.chr, self.hutch))
    end
end

function ISHutchUI:onCleanFloor()
    if luautils.walkAdj(self.chr, self.hutch:getEntrySq()) then
        local water = self.chr:getInventory():getFirstWaterFluidSources(true, true)
        local bleach = self.chr:getInventory():getFirstCleaningFluidSources()
        local mop = self.chr:getInventory():getFirstTagEvalRecurse("CleanStains", predicateNotBroken)
        ISWorldObjectContextMenu.equip(self.chr, self.chr:getPrimaryHandItem(), mop, true, false)
        ISTimedActionQueue.add(ISHutchCleanFloor:new(self.chr, self.hutch, water, mop, bleach))
    end
end

function ISHutchUI:onToggleDoor()
    ISHutchMenu.onToggleDoor(self.hutch, self.chr)
end

function ISHutchUI:onToggleEggHatchDoor()
    ISHutchMenu.onToggleEggHatchDoor(self.hutch, self.chr)
end

function ISHutchUI:onGrabNest(index)
    self.nestParentPanel.nestBoxUI[index+1]:onButtonGrab()
end

function ISHutchUI:onGrabRoost(index)
    self.roostParentPanel.roostUI[index+1]:onButtonGrab()
end

function ISHutchUI:add3DAnimal(panel, animal, chickenX, chickenY)
    if panel:getCharacter() then
        self:checkAnimalSit(panel, animal);
        if animal:isDead() then
            panel:setVariable("HutchAnimation", "dead")
        end
        panel:setVisible(true)
        return;
    end
    panel:setAnimSetName(animal:GetAnimSetName())
    panel:setCharacter(animal)
    panel:setDirection(IsoDirections.W)
    panel:setVariable("HutchAnimation", "idle1")
    if ZombRand(2) == 0 then
        panel:setDirection(IsoDirections.E)
    end
end

-- The animal will randomly sit after a random time
function ISHutchUI:checkAnimalSit(panel, animal)
    local currentState = panel:getVariable("HutchAnimation");
    if "sitting" == currentState then
        return;
    end

    if ZombRand(200) == 0 then
        panel:setVariable("HutchAnimation", "sitting1")
    end
end

function ISHutchUI:checkAnimal(index, chickenX, chickenY, rowY, SHELF_HEIGHT, btnGrabOffset)
    local animal = self.hutch:getAnimal(index);
    local panel = self.roostParentPanel.avatarPanel[index + 1];
    if animal then
        self:add3DAnimal(panel, animal, chickenX, chickenY)
    else
        panel:setCharacter(nil);
        panel:setVisible(false)
    end
end

function ISHutchUI:onTabsActivateView()
    -- Handle clicking in a tab when a controller is active
    local joypadData = getJoypadData(self.playerNum)
    if joypadData then
        joypadData.focus = self.tabPanel:getActiveView()
    end
end

function ISHutchUI:showRoosts()
    self.tabPanel:activateView(self.tabPanel.viewList[2].name)
end

function ISHutchUI:showNestBoxes()
    self.tabPanel:activateView(self.tabPanel.viewList[1].name)
end

function ISHutchUI:isKeyConsumed(key)
    return self.playerNum == 0 and key == Keyboard.KEY_ESCAPE
end

function ISHutchUI:onKeyRelease(key)
    if self.playerNum == 0 and key == Keyboard.KEY_ESCAPE then
        self:close()
        self:removeFromUIManager();
        return
    end
end

function ISHutchUI:close()
    self:setVisible(false);
    self:removeFromUIManager();
    if getJoypadData(self.playerNum) then
        setJoypadFocus(self.playerNum, nil)
    end
    ISHutchUI.instance = nil
end

function ISHutchUI:setVisible(vis)
    ISCollapsableWindowJoypad.setVisible(self, vis)
    if not vis then
        ISHutchUI.ui[self.playerNum] = nil;
    end
end

function ISHutchUI:onGainJoypadFocus(joypadData)
    ISCollapsableWindowJoypad.onGainJoypadFocus(self, joypadData)
    joypadData.focus = self.tabPanel:getActiveView()
    updateJoypadFocus(joypadData)
end

function ISHutchUI:onJoypadDown(button, joypadData)
    if button == Joypad.BButton then
        self:close()
        return
    end
    ISCollapsableWindowJoypad.onJoypadDown(self, button, joypadData)
end

function ISHutchUI:onJoypadDown_Descendant(descendant, button, joypadData)
    if button == Joypad.BButton then
        self:close()
        return
    end
    if button == Joypad.LBumper or button == Joypad.RBumper then
        local viewIndex = self.tabPanel:getActiveViewIndex()
        if button == Joypad.LBumper then
            if viewIndex == 1 then
                viewIndex = #self.tabPanel.viewList
            else
                viewIndex = viewIndex - 1
            end
        elseif button == Joypad.RBumper then
            if viewIndex == #self.tabPanel.viewList then
                viewIndex = 1
            else
                viewIndex = viewIndex + 1
            end
        end
        getSoundManager():playUISound("UIActivateTab")
        self.tabPanel:activateView(self.tabPanel.viewList[viewIndex].name)
        return
    end
    ISCollapsableWindowJoypad.onJoypadDown_Descendant(self, descendant, button, joypadData)
end

function ISHutchUI:new(x, y, width, height, hutch, player)
    local o = ISCollapsableWindowJoypad.new(self, x, y, width, height);
    o:setTitle(getText("ContextMenu_Hutch_Info"))
    o.hutch = hutch;
    o.chr = player;
    o:setResizable(false);
    o.playerNum = player:getPlayerNum();
    o.refreshNeeded = true
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.btnBorder = {r=1, g=1, b=1, a=0.7};
    o.fgBar = {r=0, g=0.6, b=0, a=0.7 }
    o.fgBarOrange = {r=1, g=0.3, b=0, a=0.7 }
    o.fgBarRed = {r=1, g=0, b=0, a=0.7 }
--    o.chickenTexture = getTexture("media/ui/Animals/chicken.png");
    o.chickenTexture = getTexture("media/ui/Animals/ChickenSlot_occupied.png");
    o.chickenEmptyTexture = getTexture("media/ui/Animals/ChickenSlot_empty.png");
    o.eggTexture = getTexture("media/ui/Animals/egg.png");
    o:setWantKeyEvents(true)
    -- just in case something went amiss and the hutch isn't updating anymore, forcing it again
    hutch:reforceUpdate();
    ISHutchUI.ui[o.playerNum] = o;
    return o;
end

function ISHutchUI.ShowWindow(playerObj, hutch)
    local playerNum = playerObj:getPlayerNum()
    local ui = ISHutchUI.ui[playerNum]
    if ui == nil then
        ui = ISHutchUI:new(getPlayerScreenLeft(playerNum)+100, getPlayerScreenTop(playerNum)+100, 200, 200, hutch, playerObj)
        ui:initialise()
    end
    ui:addToUIManager()
    return ui
end