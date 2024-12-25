--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 25/03/2022
-- Time: 11:32
-- To change this template use File | Settings | File Templates.
--

require "ISUI/ISCollapsableWindow"
require "ISUI/ISUI3DModel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

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
--    self:drawText("Rhode Island Red Chicken", boxX + 3, animalNameY, 1, 1, 1, 1, UIFont.NewSmall)
    if animal then
        self:drawText(getText("IGUI_Hutch_EggsNb", nest:getEggsNb()), 3, self.height - FONT_HGT_SMALL, 1, 1, 1, 1, UIFont.NewSmall)
    end
    self.avatar:setVariable("HutchAnimation", "sitting1")
    local btn = self.hutchUI.grabEggsBtnList[self.index + 1]
    self:checkGrabBtn(btn);
end

function ISHutchNestBox:checkGrabBtn(btn)
    --if self.playerObj:getPrimaryHandItem() or self.playerObj:getSecondaryHandItem() then
    --    btn.enable = false;
    --    btn.tooltip = getText("IGUI_Hutch_EmptyHands");
    --else
        btn.enable = true;
        btn.tooltip = nil;
    --end
end

function ISHutchNestBox:doNestStuff()
    self:initEggPos()
    local animal = self:getAnimal()
    local nest = self:getNest()
    local btn = self.hutchUI.grabEggsBtnList[self.index + 1]
    btn.nestBox = self.index
    btn:setX(self.x)
    btn:setY(self:getBottom() + 2)
    btn:setVisible(false)
    if animal then
        self.hutchUI:add3DAnimal(self.avatar, animal, self.x + 55, self.y + 34)
--        btn:setVisible(true) -- RJ: Prob best to not take the animal wihle he's in the nest box?
--        btn:setTitle("Grab")
--        btn:setWidthToTitle()
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
        if nest:getEggsNb() > 0 then
            btn:setVisible(true)
            btn:setTitle(getText("IGUI_Hutch_GrabEggs"))
            btn:setWidthToTitle()
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
            if self.playerObj:getSecondaryHandItem() then
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
    if AnimalContextMenu.cheat and self:getNest():getEggsNb() > 0 then
        context:addDebugOption("Remove Egg", self, ISHutchNestBox.onCheatRemoveEgg)
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

-- Panel to show a roosting chicken (not in a nest)
ISHutchRoost = ISPanel:derive("ISHutchRoost")

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
    ISPanel.render(self)
    local rowY = self:getBottom() + 5
    local rowHeight = 10
    local btn = self.hutchUI.grabBtnList[self.index + 1]
    local btnGrabOffset = self.width / 2 - btn.width / 2
    self.hutchUI:checkAnimal(self.index, self.x, self.y, rowY, rowHeight, btnGrabOffset)
    if self:isMouseOver() then
        self:drawRectBorder(0, 0, self.width, self.height, 1.0, 0.5, 0.5, 0.5)
    end
--    if self:getAnimal() and self:getAnimal():getData():isFertilized() then
--        self:drawTexture(self.favoriteStar, self.width - 20, self.height - 20, 1, 1, 1, 1)
--    end
    self:checkGrabBtn(btn);
end

function ISHutchRoost:checkGrabBtn(btn)
    if self.playerObj:getPrimaryHandItem() or self.playerObj:getSecondaryHandItem() then
        btn.enable = false;
        btn.tooltip = getText("IGUI_Hutch_EmptyHandsAnimal");
    else
        btn.enable = true;
        btn.tooltip = nil;
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
    if animal then
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
        sendClientCommandV(player, "animal", "hutch",
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

function ISHutchRoost:new(x, y, width, height, hutchUI, index)
    local o = ISPanel.new(self, x, y, width, height)
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

ISHutchUI = ISCollapsableWindow:derive("ISHutchUI");
ISHutchUI.instance = nil

function ISHutchUI:prerender()
    ISCollapsableWindow.prerender(self)

    if self.chr:getCurrentSquare():DistToProper(self.hutch:getEntrySq()) > 5 then
        self:close();
    end
end

function ISHutchUI:render()
    ISCollapsableWindow.render(self);
    self:setInfo(getText("IGUI_Hutch_Info"));
    if self.hutch:isAllDoorClosed() then
        self.closedDoorPanel:setVisible(true)
        for i,v in ipairs(self.grabBtnList) do
            v:setVisible(false)
        end
        self.doorBtn:setVisible(false)
        self.eggHatchDoorBtn:setVisible(false)
        self.boxCleanBtn:setVisible(false)
        self.birdPooCleanBtn:setVisible(false)
        return;
    else
        self.doorBtn:setVisible(true)
        self.eggHatchDoorBtn:setVisible(true)
        self.boxCleanBtn:setVisible(true)
        self.birdPooCleanBtn:setVisible(true)
        self.closedDoorPanel:setVisible(false)
    end
    if self.isCollapsed then return end

--    local x = 120;
--    local y = 30;

    local btnHeight = 25;
    local btnWid = 60;

    local boxX = 20;
    local boxY = 50;
    local boxWidth = 160;
    local boxHeight = 130;

    local eggsY = boxY + boxHeight - 18;
    local animalNameY = eggsY - 13;

    local chickenWidth = 90;
    local chickenHeight = 40;

    local titleX = 35;
    local titleY = 20;

    --------- NEST BOX ---------
    self:drawText(getText("IGUI_Hutch_EggLayingBox"), titleX, titleY, 1,1,1,1, UIFont.NewMedium);

    for i=0, self.hutch:getMaxNestBox() do
        boxY = boxY + boxHeight + btnHeight + 10;
        eggsY = eggsY + boxHeight + btnHeight + 10;
    end

--    boxY = boxY + boxHeight + btnHeight + 20;
--    local fgBar = self.fgBar;
--    if self.hutch:getNestBoxDirt() > 70 then
--        fgBar = self.fgBarRed;
--    elseif self.hutch:getNestBoxDirt() > 40 then
--        fgBar = self.fgBarOrange;
--    end
    --self:drawProgressBar(boxX, boxY, boxWidth, FONT_HGT_SMALL, self.hutch:getNestBoxDirt() / 100, fgBar)
    --self:drawText(getText("IGUI_Hutch_StrawDirt", round(self.hutch:getNestBoxDirt(), 2)), boxX + 7, boxY, 1,1,1,1, UIFont.NewSmall);
    --self.boxCleanBtn:setX(boxX)
    --self.boxCleanBtn:setY(boxY + FONT_HGT_SMALL + 2)
    --self.boxCleanBtn:setTitle(getText("IGUI_Hutch_ChangeStraw"))
    self.boxCleanBtn:setVisible(false);

    ------------ CHICKEN ------------

    titleX = 430;
    self:drawText(getText("IGUI_Hutch_CoopRoosting"), titleX, titleY, 1,1,1,1, UIFont.NewMedium);

    local rowX = boxX + boxWidth + 50;
    local rowWidth = 510;
    local rowHeight = 10;
    local rowY = 50 + boxHeight - rowHeight;
    local chickenNameX = rowX + 2;
    local chickenNameY = rowY + rowHeight + 5;
    local chickenX = rowX + 20;
    local chickenY = rowY - chickenHeight - 5;
    local btnGrabOffset = -9;

    self:drawRectBorder(rowX, rowY, rowWidth, rowHeight, 0.7, 1, 1, 1)

    ---- ROW 2 ----
    rowY = rowY + boxHeight - rowHeight + btnHeight + 20;
    self:drawRectBorder(rowX, rowY, rowWidth, rowHeight, 0.7, 1, 1, 1)

    ---- ROW 3 ----
    rowY = rowY + boxHeight - rowHeight + btnHeight + 20;
    self:drawRectBorder(rowX, rowY, rowWidth, rowHeight, 0.7, 1, 1, 1)

    ---- ROW 4 ----
    rowY = rowY + boxHeight - rowHeight + btnHeight + 20;
    self:drawRectBorder(rowX, rowY, rowWidth, rowHeight, 0.7, 1, 1, 1)

    local fgBar = self.fgBar;
    if self.hutch:getHutchDirt() > 70 then
        fgBar = self.fgBarRed;
    elseif self.hutch:getHutchDirt() > 40 then
        fgBar = self.fgBarOrange;
    end
    self:drawProgressBar(rowX, boxY, 200, FONT_HGT_SMALL, self.hutch:getHutchDirt() / 100, fgBar)
    self:drawText(getText("IGUI_Hutch_Dirt", round(self.hutch:getHutchDirt(), 2)), rowX + 7, boxY, 1,1,1,1, UIFont.NewSmall);
    self.birdPooCleanBtn:setX(rowX)
    self.birdPooCleanBtn:setY(boxY + FONT_HGT_SMALL + 2)
    self.birdPooCleanBtn:setTitle(getText("IGUI_Hutch_Clean"))

    if self.hutch:getHutchDirt() <= 0 then
        self.birdPooCleanBtn:setVisible(false);
    end
    local playerInv = self.chr:getInventory()
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

    self.doorBtn:setTitle(self.hutch:isOpen() and getText("IGUI_Hutch_CloseDoors") or getText("IGUI_Hutch_OpenDoors"));
    self.doorBtn:setX(self.width - 138)
    self.doorBtn:setY(boxY + 13 + 2)

    self.eggHatchDoorBtn:setTitle(self.hutch:isEggHatchDoorOpen() and getText("IGUI_Hutch_CloseEggHatchDoors") or getText("IGUI_Hutch_OpenEggHatchDoors"));
    self.eggHatchDoorBtn:setX(self.doorBtn.x - self.eggHatchDoorBtn.width - 8)
    self.eggHatchDoorBtn:setY(boxY + 13 + 2)
end

function ISHutchUI:initialise()
    ISCollapsableWindow.initialise(self);
    self:create();
end

function ISHutchUI:create()
    ISHutchUI.instance = self
    self.avatarPanel = {};
    self.grabBtnList = {};
    self.nestBoxPanelList = {}
    self.grabEggsBtnList = {};
    for i=0, self.hutch:getMaxAnimals()-1 do
        local grabBtn = ISButton:new(0, 0, 60, 25, "", self, function(self) self:onGrabRoost(i) end);
        grabBtn:initialise();
        grabBtn:setVisible(false)
        grabBtn.anchorTop = false
        grabBtn.anchorBottom = false
        grabBtn.borderColor = self.btnBorder
        table.insert(self.grabBtnList, grabBtn)
        self:addChild(grabBtn);
    end

    for _,button in ipairs(self.grabBtnList) do
        button:bringToTop()
    end

    for i=0, self.hutch:getMaxNestBox() do
        local grabBtn = ISButton:new(0, 0, 60, 25, "", self, function(self) self:onGrabNest(i) end);
        grabBtn:initialise();
        grabBtn:setVisible(false)
        grabBtn.anchorTop = false
        grabBtn.anchorBottom = false
        grabBtn.borderColor = self.btnBorder
        table.insert(self.grabEggsBtnList, grabBtn)
        self:addChild(grabBtn);
    end

    local boxX = 20
    local boxY = 50
    local boxWidth = 160
    local boxHeight = 130
    local btnHeight = 25

    local rowX = boxX + boxWidth + 50
    local rowWidth = 510
    local rowHeight = 10
    local rowY = 50 + boxHeight - rowHeight
    local chickenNameX = rowX + 2
    local chickenNameY = rowY + rowHeight + 5

    local chickenWidth = 90
    local chickenHeight = boxHeight - rowHeight - 5
    local chickenX = rowX + 10
    local chickenY = rowY - chickenHeight - 5

    self.nestBoxUI = {}
    for i=0,self.hutch:getMaxNestBox() do
        local nestBoxUI = ISHutchNestBox:new(boxX, boxY, boxWidth, boxHeight, self, i)
        nestBoxUI:initialise()
        nestBoxUI:instantiate()
        self:addChild(nestBoxUI)
        table.insert(self.nestBoxUI, nestBoxUI)
        table.insert(self.nestBoxPanelList, nestBoxUI.avatar)
        boxY = boxY + boxHeight + btnHeight + 10
    end

    self.roostUI = {}
    local animalIndex = 0
    for row=1,4 do
        for i=1,5 do
            local roostUI = ISHutchRoost:new(chickenX, chickenY, chickenWidth, chickenHeight, self, animalIndex)
            self:addChild(roostUI)
            table.insert(self.roostUI, roostUI)
            table.insert(self.avatarPanel, roostUI.avatar)
            animalIndex = animalIndex + 1
            chickenX = chickenX + chickenWidth + 10
        end
        rowY = rowY + boxHeight - rowHeight + btnHeight + 20
        chickenX = rowX + 10
        chickenY = rowY - chickenHeight - 5
    end
    
    self.avatarBackgroundTexture = getTexture("media/ui/avatarBackgroundWhite.png")

    self.boxCleanBtn = ISButton:new(0, 0, 90, 25, "", self, self.onCleanNest);
    self.boxCleanBtn:initialise();
    self.boxCleanBtn.anchorTop = false
    self.boxCleanBtn.anchorBottom = false
    self.boxCleanBtn.borderColor = self.btnBorder;
    self:addChild(self.boxCleanBtn);

    self.birdPooCleanBtn = ISButton:new(0, 0, 60, 25, "", self, self.onCleanFloor);
    self.birdPooCleanBtn:initialise();
    self.birdPooCleanBtn.anchorTop = false
    self.birdPooCleanBtn.anchorBottom = false
    self.birdPooCleanBtn.borderColor = self.btnBorder
    self:addChild(self.birdPooCleanBtn);

    self.doorBtn = ISButton:new(0, 0, 80, 25, "", self, self.onToggleDoor);
    self.doorBtn:initialise();
    self.doorBtn:setTitle(getText("IGUI_Hutch_CloseDoors"));
    self.doorBtn:setWidthToTitle()
    self.doorBtn.anchorTop = false
    self.doorBtn.anchorBottom = false
    self.doorBtn.borderColor = self.btnBorder
    self:addChild(self.doorBtn);

    self.eggHatchDoorBtn = ISButton:new(0, 0, 80, 25, "", self, self.onToggleEggHatchDoor);
    self.eggHatchDoorBtn:initialise();
    self.eggHatchDoorBtn:setTitle(getText("IGUI_Hutch_CloseEggDoors"));
    self.eggHatchDoorBtn:setWidthToTitle()
    self.eggHatchDoorBtn.anchorTop = false
    self.eggHatchDoorBtn.anchorBottom = false
    self.eggHatchDoorBtn.borderColor = self.btnBorder
    self:addChild(self.eggHatchDoorBtn);

    self.closedDoorPanel = ISPanel:new(1, 16, self.width-2, self.height-17)
    self.closedDoorPanel.backgroundColor = {r=0, g=0, b=0, a=1};
    self.closedDoorPanel.borderColor = {r=0, g=0, b=0, a=0};
    self:addChild(self.closedDoorPanel);

    local doorBtn2 = ISButton:new((self.width / 2) - 100, (self.height / 2) - 20, 200, 60, getText("IGUI_Hutch_OpenDoors"), self, self.onToggleDoor);
    doorBtn2.font = UIFont.NewLarge
    doorBtn2:initialise();
--    doorBtn2:setWidthToTitle()
    doorBtn2.anchorTop = false
    doorBtn2.anchorBottom = false
    doorBtn2.borderColor = self.btnBorder
    doorBtn2:setX((self.width / 2) - doorBtn2.width / 2)
    doorBtn2:setY((self.height / 2) - doorBtn2.height / 2 - 32)
    self.closedDoorPanel:addChild(doorBtn2);

    local doorBtn2 = ISButton:new((self.width / 2) - 100, (self.height / 2) - 20, 200, 60, getText("IGUI_Hutch_OpenEggDoors"), self, self.onToggleEggHatchDoor);
    doorBtn2.font = UIFont.NewLarge
    doorBtn2:initialise();
--    doorBtn2:setWidthToTitle()
    doorBtn2.anchorTop = false
    doorBtn2.anchorBottom = false
    doorBtn2.borderColor = self.btnBorder
    doorBtn2:setX((self.width / 2) - doorBtn2.width / 2)
    doorBtn2:setY((self.height / 2) - doorBtn2.height / 2 + 32)
    self.closedDoorPanel:addChild(doorBtn2);
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
        local mop = self.chr:getInventory():getAllTagEval("CleanStains", predicateNotBroken):get(0)
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
    self.nestBoxUI[index+1]:onButtonGrab()
end

function ISHutchUI:onGrabRoost(index)
    self.roostUI[index+1]:onButtonGrab()
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

function ISHutchUI:checkAnimal(index, chickenX, chickenY, rowY, rowHeight, btnGrabOffset)
    local animal = self.hutch:getAnimal(index);
    local btn = self.grabBtnList[index + 1];
    local panel = self.avatarPanel[index + 1];
    if animal then
        self:add3DAnimal(panel, animal, chickenX, chickenY)
        btn:setVisible(true)
        btn:setTitle(getText("ContextMenu_Grab"))
        btn:setX(chickenX + btnGrabOffset)
        btn:setY(rowY + rowHeight + 2)
        btn.animal = animal;
        local body = self.hutch:getDeadBody(index);

        if body then
            btn:setVisible(true)
            btn:setTitle(getText("ContextMenu_Grab"))
            btn:setX(chickenX + btnGrabOffset)
            btn:setY(rowY + rowHeight + 2)
            btn.body = body;
        end

        btn:setWidthToTitle(60);

        if animal:getCustomName() then
            self:drawTextCentre(animal:getCustomName(), btn:getX() + (btn:getWidth()/2), chickenY + 10, 1, 1, 1, 1, UIFont.NewSmall)
        end
    else
    --        self:drawTexture(self.chickenEmptyTexture, chickenX, chickenY, 1, 1, 1, 1)
        panel:setCharacter(nil);
        panel:setVisible(false)
        btn:setVisible(false)
        btn.enable = true;
        btn.tooltip = nil;
    end
end

function ISHutchUI:isKeyConsumed(key)
    return key == Keyboard.KEY_ESCAPE
end

function ISHutchUI:onKeyRelease(key)
    if key == Keyboard.KEY_ESCAPE then
        self:close()
        self:removeFromUIManager();
        return
    end
end

function ISHutchUI:close()
    self:setVisible(false);
    self:removeFromUIManager();
    ISHutchUI.instance = nil
end

function ISHutchUI:new(x, y, width, height, hutch, player)
    local o = {};
    width = 800;
    height = 780;
    local x = (getCore():getScreenWidth() / 2) - (width / 2);
    local y = (getCore():getScreenHeight() / 2) - (height / 2);
    o = ISCollapsableWindow:new(x, y, width, height);
    --    o:noBackground();
    setmetatable(o, self);
    self.__index = self;
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
    return o;
end
