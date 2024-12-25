--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 25/01/2022
-- Time: 08:44
-- To change this template use File | Settings | File Templates.
--

require "ISUI/ISCollapsableWindow"
require "ISUI/ISUI3DModel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

ISAnimalUI = ISCollapsableWindow:derive("ISAnimalUI");
ISAnimalUI.maxDist = 5;
ISAnimalUI.btnOffset = 210;

ISAnimalAvatar = ISUI3DModel:derive("ISAnimalAvatar")

function ISAnimalUI:prerender()
--    print("animaluiprerender", self.animal:getVehicle())
    if not self.animal or (not self.animal:isExistInTheWorld() and not self.animal:getHutch() and not self.animal:getVehicle() and not self.animal:isHeld()) or self.animal:getHealth() <= 0 then
        self:close();
    end
    if not AnimalContextMenu.cheat then
        if self.animal:isExistInTheWorld() and self.animal:getCurrentSquare():DistToProper(self.chr) > ISAnimalUI.maxDist then
            self:close();
        end
        if self.animal:getVehicle() and self.animal:getVehicle():getCurrentSquare():DistToProper(self.chr) > 4 then
            self:close();
        end
        if self.animal:getHutch() and self.animal:getHutch():getSquare():DistToProper(self.chr) > 4 then
            self:close();
        end
    end
    ISCollapsableWindow.prerender(self)

--    self.avatarPanel:setZoom(6 * self.animal:getData():getSize());
--    self.avatarPanel:setXOffset(-0.1 * self.animal:getData():getSize());
--    self.avatarPanel:setYOffset(-0.22 * self.animal:getData():getSize());
    self.avatarPanel:setZoom(self.avatarDefinition.zoom * self.animal:getData():getSize());
    self.avatarPanel:setXOffset(self.avatarDefinition.xoffset * self.animal:getData():getSize());
    self.avatarPanel:setYOffset(self.avatarDefinition.yoffset * self.animal:getData():getSize());

    self:updateAvatar()

    local x,y,w,h = self.avatarX, self.avatarY, self.avatarWidth, self.avatarHeight
    self:drawRectBorder(x - 2, y - 2, w + 4, h + 4, 1, 0.3, 0.3, 0.3);
    self:drawTextureScaled(self.avatarBackgroundTexture, x, y, w, h, 1, 0.4, 0.4, 0.4);
end

function ISAnimalUI:render()
    ISCollapsableWindow.render(self);

    local x = self.avatarPanel.x + self.avatarPanel.width + 30;
    local y = self.avatarPanel.y;

    self.renameBtn:setX(self.xOffset + ISAnimalUI.btnOffset);
    self.renameBtn:setY(y + 4);

    local txt = "";
    if AnimalContextMenu.cheat then
        txt = " (" .. self.animal:getAnimalID() .. ")";
    end

    local nameWid = getTextManager():MeasureStringX(UIFont.Medium, self.animalName .. txt)

    self:drawText(self.animalName .. txt, x, y, 1,1,1,1, UIFont.Medium);

    y = y + FONT_HGT_MEDIUM;
    self:drawRect(x, y, nameWid + 2, 1, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    y = y + 10;
    self:drawTextRight(getText("IGUI_AnimalType"), self.xOffset, y, 1,1,1,1, UIFont.Small);
    self:drawText(getText("IGUI_AnimalType_" .. self.animal:getAnimalType()), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);

    y = y + FONT_HGT_SMALL + 4;
    self:drawTextRight(getText("IGUI_AnimalBreed"), self.xOffset, y, 1,1,1,1, UIFont.Small);
    self:drawText(getText("IGUI_Breed_" .. self.animal:getData():getBreed():getName()), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);

    y = y + FONT_HGT_SMALL + 4;
    self:drawTextRight(getText("UI_characreation_gender"), self.xOffset, y, 1,1,1,1, UIFont.Small);
    local text = getText("IGUI_Animal_Female");
    if not self.animal:isFemale() then
        text = getText("IGUI_Animal_Male");
    end
    self:drawText(text, self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);

    self.genderBtn:setX(self.xOffset + ISAnimalUI.btnOffset);
    self.genderBtn:setY(y + 2);
    self.genderBtn:setVisible(AnimalContextMenu.cheat);

    y = y + FONT_HGT_SMALL + 4;
    self:drawTextRight(getText("IGUI_char_Age"), self.xOffset, y, 1,1,1,1, UIFont.Small);
    self:drawText(self.animal:getAgeText(AnimalContextMenu.cheat, self.skillLvl) .. "", self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);

    self.ageBtn:setX(self.xOffset + ISAnimalUI.btnOffset);
    self.ageBtn:setY(y + 2);
    self.ageBtn:setVisible(AnimalContextMenu.cheat);

    y = y + FONT_HGT_SMALL + 4;
    self:drawTextRight(getText("IGUI_XP_Health"), self.xOffset, y, 1,1,1,1, UIFont.Small);
    self:drawText(self.animal:getHealthText(AnimalContextMenu.cheat, self.skillLvl), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);

    y = y + FONT_HGT_SMALL + 4;
    self:drawTextRight(getText("IGUI_Animal_Appearance"), self.xOffset, y, 1,1,1,1, UIFont.Small);
    self:drawText(self.animal:getAppearanceText(AnimalContextMenu.cheat), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
    self.feedBtn:setX(self.xOffset + ISAnimalUI.btnOffset);
    self.feedBtn:setY(y + 2);

    y = y + FONT_HGT_SMALL + 4;
    if self.skillLvl > 4 or AnimalContextMenu.cheat then
        self:drawTextRight(getText("IGUI_invpanel_weight"), self.xOffset, y, 1,1,1,1, UIFont.Small);
        local addedTxt = "";
        if AnimalContextMenu.cheat then
            addedTxt = " (size: " .. round(self.animal:getData():getSize(),2) .. ")";
        end

        if self.animal:getData():getWeight() > 1 then
            self:drawText(getText("IGUI_AnimalWeight", round(self.animal:getData():getWeight(), 2)) .. addedTxt, self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
        else
            self:drawText(getText("IGUI_AnimalWeightG", round(self.animal:getData():getWeight() * 1000, 2)) .. addedTxt, self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
        end

        y = y + FONT_HGT_SMALL + 4;
    end

    if self.animal:getData():getClutchSize() > 0 and (self.skillLvl > 3 or AnimalContextMenu.cheat) then
        self:drawTextRight(getText("IGUI_Animal_ClutchSize"), self.xOffset, y, 1,1,1,1, UIFont.Small);
        local txt = "";
        if AnimalContextMenu.cheat then
            txt = " (" .. self.animal:getData():getClutchSize() .. " / " .. self.animal:getMinClutchSize() .. "-" .. self.animal:getMaxClutchSize() .. ")";
        end
        self:drawText(self:getClutchSizeText() .. txt, self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
        y = y + FONT_HGT_SMALL + 4;
    end

    if self.animal:getData():haveLayingEggPeriod() and (self.skillLvl > 3 or AnimalContextMenu.cheat) then
        self:drawTextRight(getText("IGUI_Animal_LayingEggPeriod"), self.xOffset, y, 1,1,1,1, UIFont.Small);
        if self.animal:getData():isInLayingEggPeriod(getGameTime():getCalender()) then
            self:drawText(getText("IGUI_Yes") .. "", self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
        else
            self:drawText(getText("IGUI_No") .. "", self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
        end
        y = y + FONT_HGT_SMALL + 4;
    end

    if self.skillLvl > 2 or AnimalContextMenu.cheat then
        if self.animal:getBabyType() and self.animal:isFemale() then
            if self.animal:getEggsPerDay() > 0 then
                self:drawTextRight(getText("IGUI_Animal_Fertilized"), self.xOffset, y, 1,1,1,1, UIFont.Small);
                if self.animal:getData():isFertilized() then
                    if AnimalContextMenu.cheat then
                        self:drawText(self.animal:getData():getFertilizedTime() .. "/" .. self.animal:getFertilizedTimeMax() .. " hours", self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
                    else
                        self:drawText(getText("IGUI_Yes"), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
                    end
                else
                    self:drawText(getText("IGUI_No"), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
                end
            else
                self:drawTextRight(getText("IGUI_Animal_Pregnant"), self.xOffset, y, 1,1,1,1, UIFont.Small);
                if self.animal:getData():isPregnant() then
                    --if AnimalContextMenu.cheat then
                    --    self:drawText(self.animal:getData():getPregnancyTime() .. "/" .. self.animal:getData():getPregnantPeriod(), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
                    --else
                        self:drawText(self:getPregnantText(), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
                        --self:drawText(getText("IGUI_True"), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
                    --end
                else
                    self:drawText(getText("IGUI_No"), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
                end
            end
            y = y + FONT_HGT_SMALL + 4;
            -- mating season
            if not self.animal:isBaby() and (self.skillLvl > 4 or AnimalContextMenu.cheat) then
                --if self.animal:getData():getLastPregnancyPeriod() or self.animal:haveMatingSeason() then
                    self:drawTextRight(getText("IGUI_Animal_MatingSeason"), self.xOffset, y, 1,1,1,1, UIFont.Small);
                    if self.animal:getData():getLastPregnancyPeriod() then
                        local text = "";
                        if AnimalContextMenu.cheat then
                            text = " ( " .. self.animal:getData():getLastPregnancyPeriod() .. " days)";
                        end
                        self:drawText(getText("IGUI_Animal_TooSoonForBaby") .. text, self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
                    else
                        if self.animal:getData():getDaysSurvived() >= self.animal:getMinAgeForBaby() then
                            if self.animal:isInMatingSeason() then
                                self:drawText(getText("IGUI_Yes"), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
                            else
                                self:drawText(getText("IGUI_No"), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
                            end
                        else
                            self:drawText(getText("IGUI_Animal_TooYoungForBaby"), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
                        end
                    end
                    y = y + FONT_HGT_SMALL + 4;
                --end
            end
        end
    end

    self:drawTextRight(getText("IGUI_Animal_Stress"), self.xOffset, y, 1,1,1,1, UIFont.Small);
    self:drawText(self.animal:getStressTxt(AnimalContextMenu.cheat, self.skillLvl), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
    y = y + FONT_HGT_SMALL + 4;

    if self.animal:attackOtherMales() then
        self:drawTextRight(getText("IGUI_Animal_AttackOtherMales"), self.xOffset, y, 1,0.2,0.2,1, UIFont.Small);
        y = y + FONT_HGT_SMALL + 4;
    end

    -- male display too young to have baby
    if not self.animal:isFemale() and (AnimalContextMenu.cheat or self.skillLvl > 4) and self.animal:getData():getDaysSurvived() < self.animal:getMinAgeForBaby() then
        self:drawTextRight(getText("IGUI_Animal_MatingSeason"), self.xOffset, y, 1,1,1,1, UIFont.Small);
        self:drawText(getText("IGUI_Animal_TooYoungForBaby"), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
        y = y + FONT_HGT_SMALL + 4;
    end

    -- last impregnation
    if (AnimalContextMenu.cheat or self.skillLvl > 3) and not self.animal:isFemale() and self.animal:getData():getLastImpregnatePeriod(nil) >= 0 then
        if self.animal:getData():getLastImpregnatePeriod(nil) == 0 then
            if self.animal:haveMatingSeason() and not self.animal:isInMatingSeason() then
                self:drawTextRight(getText("IGUI_Animal_MatingSeason"), self.xOffset, y, 1,1,1,1, UIFont.Small);
                self:drawText(getText("IGUI_No"), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
            else
                self:drawTextRight(getText("IGUI_Animal_ReadyToImpregnate"), self.xOffset, y, 1,1,1,1, UIFont.Small);
            end
        else
            self:drawTextRight(getText("IGUI_Animal_ReadyToImpregnateIn"), self.xOffset, y, 1,1,1,1, UIFont.Small);
            self:drawText(self.animal:getData():getLastImpregnatePeriod(nil) .. " " .. getText("IGUI_Gametime_hours"), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
        end
        y = y + FONT_HGT_SMALL + 4;
    end

    if self.animal:getDZone() then
        self:drawTextRight(getText("IGUI_Animal_ZoneName"), self.xOffset, y, 1,1,1,1, UIFont.Small);
        self:drawText(self.animal:getDZone():getName(), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
    else
        if not self.animal:getVehicle() and not self.animal:isHeld() then
            self:drawTextRight(getText("IGUI_Animal_NoZoneFound"), self.xOffset, y, 1,0.2,0.2,1, UIFont.Small);
        end
    end
    y = y + FONT_HGT_SMALL + 4;

    -- show list of this animal's babies, only in debug for now?
    --if AnimalContextMenu.cheat then
        if self.animal:getBabies() and not self.animal:getBabies():isEmpty() and self.animal:getCurrentSquare() then
            self:drawTextRight(getText("IGUI_Animal_Babies"), self.xOffset, y, 1,1,1,1, UIFont.Small);
            for i=0,self.animal:getBabies():size()-1 do
                local baby = self.animal:getBabies():get(i);
                if not baby then
                    break;
                end
                local r,g,b = 1,1,1;
                if (self.animal:getDZone() ~= baby:getDZone() and (self.animal:getCurrentSquare():DistToProper(baby) > 10) or not baby:isExistInTheWorld()) then
                    r,g,b = 1,0.2,0.2;
                end
                self:drawText("- " .. baby:getFullName(), self.xOffset + 10, y, r,g,b,0.5, UIFont.Small);
                y = y + FONT_HGT_SMALL + 4;
            end
        end
    --end

    -- somehow baby lost his mom, debug stuff for now, might stay in?
    if self.animal:isBaby() and self.animal:needMom() and (not self.animal:getMother() or not self.animal:getMother():isExistInTheWorld()) then
        if not self.animal:getMother() or (self.animal:getMother() and self.animal:getVehicle() ~= self.animal:getMother():getVehicle()) then
            self:drawTextRight(getText("IGUI_Animal_CantFindMom"), self.xOffset, y, 1,0.2,0.2,1, UIFont.Small);
            y = y + FONT_HGT_SMALL + 4;
        end
    end
    if AnimalContextMenu.cheat then
        if self.animal:isBaby() and self.animal:getMother() then
            self:drawTextRight("Mother", self.xOffset, y, 1,1,1,1, UIFont.Small);
            self:drawText(self.animal:getMother():getFullName(), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
            y = y + FONT_HGT_SMALL + 4;
        end
    end

    self.milkAnimalBtn:setVisible(false);
    if self.animal:canBeMilked() or AnimalContextMenu.cheat then
        if self.animal:hasUdder() and not self.animal:getData():canHaveMilk() then
            self:drawTextRight(getText("IGUI_Animal_Udder"), self.xOffset, y, 1,1,1,1, UIFont.Small);
            self:drawText(getText("IGUI_Animal_NeedBaby"), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
            self.milkAnimalBtn:setVisible(false);
            y = y + FONT_HGT_SMALL + 4;
        elseif self.animal:hasUdder() and self.animal:getData():getMilkQuantity() > 0.1 then
            local text = self:getUdderText(AnimalContextMenu.cheat, self.skillLvl);
            --if AnimalContextMenu.cheat then
            --    text = text .. " / " .. round(self.animal:getData():getMaxMilkActual(), 2) .. " (max: " .. round(self.animal:getData():getMaxMilk(), 2) .. ")";
            --end
            self:drawTextRight(getText("IGUI_Animal_Udder"), self.xOffset, y, 1,1,1,1, UIFont.Small);
            self:drawText(text, self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
            local width = getTextManager():MeasureStringX(UIFont.Small, text) + 20;
            if ISAnimalUI.btnOffset < width then
                ISAnimalUI.btnOffset = width;
            end
            if self.animal:canBeMilked() then
                self.milkAnimalBtn:setX(self.xOffset + ISAnimalUI.btnOffset);
                self.milkAnimalBtn:setY(y - 2);
                self.milkAnimalBtn:setVisible(true);
                local bucket = self.chr:getInventory():getFirstAvailableFluidContainer(self.animal:getData():getBreed():getMilkType())
                self.milkAnimalBtn.enable = (bucket ~= nil);
            else
                self.milkAnimalBtn:setVisible(false);
                end
            y = y + FONT_HGT_SMALL + 4;
            if AnimalContextMenu.cheat then
                self:drawTextRight("Last Time Milked", self.xOffset, y, 1,1,1,1, UIFont.Small);
                self:drawText(round(self.animal:getData():getLastTimeMilkedInHour(),2) .. "", self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
                y = y + FONT_HGT_SMALL + 4;
            end
        else
            self.milkAnimalBtn:setVisible(false);
        end
    end

    if self.animal:canBeSheared() then
        self:drawTextRight(getText("IGUI_Animal_Wool"), self.xOffset, y, 1,1,1,1, UIFont.Small);
        self:drawText(self:getWoolText(), self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
        y = y + FONT_HGT_SMALL + 4;
    end

    --self:drawTextRight(getText("IGUI_Animal_AttachedTo"), self.xOffset, y, 1,1,1,1, UIFont.Small);
    --if self.animal:getData():getAttachedPlayer() then
    --    local nameText = self.animal:getData():getAttachedPlayer():getDescriptor():getForename().." "..self.animal:getData():getAttachedPlayer():getDescriptor():getSurname()
    --    self:drawText(nameText, self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
    --    self.attachAnimalBtn.title = getText("ContextMenu_DetachAnimalSimple");
    --else
    --    self.attachAnimalBtn.title = getText("ContextMenu_AttachAnimalSimple");
    --    local nbOfRopes = self.chr:getInventory():getNumberOfItem("Base.Rope");
    --    -- disable the button if no cheat or not enough rope
    --    self.attachAnimalBtn.enable = (nbOfRopes > self.chr:getAttachedAnimals():size());
    --    if AnimalContextMenu.cheat then
    --        self.attachAnimalBtn.enable = true;
    --    end
    --end
    --self.attachAnimalBtn:setX(self.xOffset + ISAnimalUI.btnOffset);
    --self.attachAnimalBtn:setY(y + 2);
    --y = y + FONT_HGT_SMALL + 4;

    if self.animal:shouldAnimalStressAboveGround() then
        self:drawTextRight(getText("IGUI_Animal_StressAboveGround"), self.xOffset, y, 1,0.2,0.2,1, UIFont.Small);
        y = y + FONT_HGT_SMALL + 4;
    end

    if AnimalContextMenu.cheat and not self.animal:getGeneticDisorder():isEmpty() then
        local txt = "";
        for i=0, self.animal:getGeneticDisorder():size() -1 do
            txt = txt .. self.animal:getGeneticDisorder():get(i);
            if self.animal:getGeneticDisorder():size() > i+1 then
                txt = txt .. ",";
            end
        end
        self:drawTextRight("Genetic Disorder: " .. txt, self.xOffset, y, 1,0.2,0.2,1, UIFont.Small);
        y = y + FONT_HGT_SMALL + 4;
    end

    if self.animal:needHutch() and self.animal:getDZone() and not self.animal:getData():getRegionHutch() then
        self:drawTextRight(getText("IGUI_Animal_NoHutch"), self.xOffset, y, 1,0.2,0.2,1, UIFont.Small);
        y = y + FONT_HGT_SMALL + 4;
    end

    if AnimalContextMenu.cheat then
        local playerAcceptance = self.animal:getPlayerAcceptance(self.chr);
        local zoneAcceptance = self.animal:getZoneAcceptance();

        if playerAcceptance then
            self:drawTextRight(getText("IGUI_Animal_PlayerAcceptance"), self.xOffset, y, 1,1,1,1, UIFont.Small);
            self:drawText(playerAcceptance .. "", self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
            y = y + FONT_HGT_SMALL + 4;
        end

        --if zoneAcceptance then
        --    self:drawTextRight(getText("IGUI_Animal_ZoneAcceptance"), self.xOffset, y, 1,1,1,1, UIFont.Small);
        --    self:drawText(zoneAcceptance .. "", self.xOffset + 10, y, 1,1,1,0.5, UIFont.Small);
        --    y = y + FONT_HGT_SMALL + 4;
        --end
    end

    self:setHeight(math.max(self.avatarPanel.y + self.avatarPanel.height + 30, y + 30))
end

function ISAnimalUI:initialise()
    ISCollapsableWindow.initialise(self);
    self:create();
end

function ISAnimalUI:close()
    self:setVisible(false);
    self:removeFromUIManager();
end

function ISAnimalUI:create()

    self.avatarX = 25
    self.avatarY = 25
    self.avatarWidth = self.avatarDefinition.avatarWidth or 128;
    self.avatarHeight = self.avatarDefinition.avatarHeight or 128
    self.avatarPanel = ISCharacterScreenAvatar:new(self.avatarX, self.avatarY, self.avatarWidth, self.avatarHeight)
    self.avatarPanel:setVisible(true)
    self:addChild(self.avatarPanel)
    self.avatarPanel:setState("idle")
    self.avatarPanel:setDirection(self.avatarDefinition.avatarDir or IsoDirections.S)
    self.avatarPanel:setIsometric(false)
    self.avatarPanel:setAnimSetName(self.animal:GetAnimSetName())
    self.avatarPanel:setCharacter(self.animal)

    self.avatarBackgroundTexture = getTexture("media/ui/avatarBackgroundWhite.png")

    local textWid = 0
    textWid = self:maxTextWidth(UIFont.Small, getText("IGUI_char_Age"), textWid)
    textWid = self:maxTextWidth(UIFont.Small, getText("IGUI_char_Sex"), textWid)
    textWid = self:maxTextWidth(UIFont.Small, getText("IGUI_char_Weight"), textWid)
    self.xOffset = self.avatarPanel.x + self.avatarPanel.width + 55 + textWid

    local btnWid = 70
    local btnHgt = FONT_HGT_SMALL

    self.renameBtn = ISButton:new(0,0, btnWid, btnHgt, getText("ContextMenu_RenameBag"), self, ISAnimalUI.renameAnimal);
    self.renameBtn:initialise();
    self.renameBtn:instantiate();
    self.renameBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self.renameBtn:setVisible(true);
    self:addChild(self.renameBtn);

    self.feedBtn = ISButton:new(0,0, btnWid, btnHgt, "Feed", self, ISAnimalUI.feedAnimal);
    self.feedBtn:initialise();
    self.feedBtn:instantiate();
    self.feedBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self.feedBtn:setVisible(false);
    self:addChild(self.feedBtn);

    --self.attachAnimalBtn = ISButton:new(0,0, btnWid, btnHgt, getText("ContextMenu_AttachAnimalSimple"), self, ISAnimalUI.attachAnimal);
    --self.attachAnimalBtn:initialise();
    --self.attachAnimalBtn:instantiate();
    --self.attachAnimalBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    --self.attachAnimalBtn:setVisible(true);
    --self:addChild(self.attachAnimalBtn);
--
    self.milkAnimalBtn = ISButton:new(0,0, btnWid, btnHgt, "Milk Animal", self, ISAnimalUI.onMilkAnimal);
    self.milkAnimalBtn:initialise();
    self.milkAnimalBtn:instantiate();
    self.milkAnimalBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self.milkAnimalBtn:setVisible(true);
    self:addChild(self.milkAnimalBtn);

    self.ageBtn = ISButton:new(0,0, btnWid, btnHgt, "Set Age", self, ISAnimalUI.onSetAge);
    self.ageBtn:initialise();
    self.ageBtn:instantiate();
    self.ageBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self.ageBtn:setVisible(AnimalContextMenu.cheat);
    self:addChild(self.ageBtn);

    self.genderBtn = ISButton:new(0,0, btnWid, btnHgt, "Change", self, ISAnimalUI.onChangeGender);
    self.genderBtn:initialise();
    self.genderBtn:instantiate();
    self.genderBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self.genderBtn:setVisible(AnimalContextMenu.cheat);
    self:addChild(self.genderBtn);

    local infoTxt = getText("IGUI_AnimalUI_Info");
    if not self.animal:isBaby() then
        infoTxt = infoTxt .. getText("IGUI_AnimalUI_Info_" .. self.animal:getAnimalType());
    else
        infoTxt = infoTxt .. getText("IGUI_AnimalUI_Info_" .. self.animal:getNextStageAnimalType());
    end
    self:setInfo(infoTxt);
end

function ISAnimalUI:attachAnimal()
    if self.animal:getData():getAttachedPlayer() then
        AnimalContextMenu.onDetachAnimal(self.animal, self.chr);
    else
        AnimalContextMenu.onAttachAnimal(self.animal, self.chr);
    end
end

function ISAnimalUI:onChangeGender()
    self.animal:setFemale(not self.animal:isFemale());
end

function ISAnimalUI:onSetAge()
    AnimalContextMenu.onSetAnimalAge(self.animal, self.chr:getPlayerNum())
end

function ISAnimalUI:renameAnimal()
    local modal = ISTextBox:new(0, 0, 280, 180, getText("ContextMenu_RenameBag"), self.animalName, self, ISAnimalUI.onRenameAnimalClick);
    modal:initialise();
    modal:addToUIManager();
    modal.maxChars = 30;
    if JoypadState.players[self.playerNum+1] then
        setJoypadFocus(self.playerNum, modal)
    end
end

function ISAnimalUI:onRenameAnimalClick(button, animal)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            self.animal:setCustomName(button.parent.entry:getText());
            self.animalName = button.parent.entry:getText();
        end
    end
end

function ISAnimalUI:maxTextWidth(font, text, maxWidth)
    local width = getTextManager():MeasureStringX(font, text)
    return math.max(width, maxWidth)
end

function ISAnimalUI:updateAvatar()
    if not self.refreshNeeded then return end
    self.refreshNeeded = false
    self.avatarPanel:setCharacter(self.animal)
end

function ISAnimalUI:getWoolText()
    local dbgTxt = "";
    if AnimalContextMenu.cheat then
        dbgTxt = " (" .. round(self.animal:getData():getWoolQuantity(), 1) .. "/" .. round(self.animal:getData():getMaxWool(),1) .. ")";
    end

    local qty = self.animal:getData():getWoolQuantity();
    if qty < 1 then
        return getText("IGUI_Animal_Wool_None") .. dbgTxt
    elseif qty < 5 then
        return getText("IGUI_Animal_Wool_Handful") .. dbgTxt
    elseif qty < 8 then
        return getText("IGUI_Animal_Wool_Little") .. dbgTxt
    elseif qty < 15 then
        return getText("IGUI_Animal_Wool_Moderate") .. dbgTxt
    else
        return getText("IGUI_Animal_Wool_Abundant") .. dbgTxt
    end
end

function ISAnimalUI:getUdderText()
    local dbgTxt = "";
    if AnimalContextMenu.cheat then
        dbgTxt = " (" .. round(self.animal:getData():getMilkQuantity(), 1) .. " / " .. round(self.animal:getData():getMaxMilkActual(), 2) .. " (max: " .. round(self.animal:getData():getMaxMilk(), 2) .. "))";
    end
    if not self.animal:getData():canHaveMilk() then
        return getText("IGUI_Animal_UdderNothing") .. dbgTxt;
    end
    if self.animal:getData():getMilkQuantity() > self.animal:getData():getMaxMilk() and self.skillLvl > 4 then
        return getText("IGUI_Animal_UdderUrgent") .. dbgTxt;
    end
    if self.animal:getData():getMilkQuantity() < 1 and self.animal:getData():getMilkQuantity() > 0.1 then
        return getText("IGUI_Animal_UdderSmall") .. dbgTxt;
    end
    if self.animal:getData():getMilkQuantity() < 0.1 then
        return getText("IGUI_Animal_UdderNotEnough") .. dbgTxt;
    end
    if self.animal:getData():getMilkQuantity() > (self.animal:getData():getMaxMilk() / 24) then
        return getText("IGUI_Animal_UdderReady") .. dbgTxt;
    end
        return getText("IGUI_Animal_UdderMilked") .. dbgTxt;
    end

function ISAnimalUI:getPregnantText()
    local dbgTxt = "";
    if AnimalContextMenu.cheat then
        dbgTxt = " (" .. self.animal:getData():getPregnancyTime() .. "/" .. self.animal:getData():getPregnantPeriod() .. ")";
    end
    local time = self.animal:getData():getPregnancyTime();
    local perc = time / self.animal:getData():getPregnantPeriod();
    if self.skillLvl > 4 then -- skilled farmer sees soon if the animal is pregnant or not, and with more accuracy
        if perc < 0.08 then
            return getText("IGUI_No") .. dbgTxt;
        else
            if perc < 0.3 then
                return getText("IGUI_Animal_Pregnancy_Begin") .. dbgTxt;
            elseif perc < 0.65 then
                return getText("IGUI_Animal_Pregnancy_Gestating") .. dbgTxt;
            elseif perc < 0.85 then
                return getText("IGUI_Animal_Pregnancy_Almost") .. dbgTxt;
            else
                return getText("IGUI_Animal_Pregnancy_Ready") .. dbgTxt;
            end
        end
    else
        if perc < 0.2 then
            return getText("IGUI_No") ..dbgTxt;
        else
            if perc < 0.4 then
                return getText("IGUI_Animal_Pregnancy_Begin") .. dbgTxt;
            elseif perc < 0.8 then
                return getText("IGUI_Animal_Pregnancy_Gestating") .. dbgTxt;
            elseif perc < 0.95 then
                return getText("IGUI_Animal_Pregnancy_Almost") .. dbgTxt;
            else
                return getText("IGUI_Animal_Pregnancy_Ready") .. dbgTxt;
            end
        end
    end
end

function ISAnimalUI:getClutchSizeText()
    local min = self.animal:getMinClutchSize();
    local max = self.animal:getMaxClutchSize();
    local current = self.animal:getCurrentClutchSize();

    local currentPerc = (current - min) / (max - min);

    if current <= min then
        return getText("IGUI_Animal_ClutchSize_Small");
    end
    if currentPerc < 0.3 then
        return getText("IGUI_Animal_ClutchSize_Small");
    elseif currentPerc < 0.6 then
        return getText("IGUI_Animal_ClutchSize_Medium");
    else
        return getText("IGUI_Animal_ClutchSize_Large");
    end
end

function ISAnimalUI:onMilkAnimal()
    local bucket = self.chr:getInventory():getFirstAvailableFluidContainer(self.animal:getData():getBreed():getMilkType())
    AnimalContextMenu.onMilkAnimal(self.animal, self.chr, bucket, true);
end

function ISAnimalUI:new(x, y, width, height, animal, player)
    local o = {};
    o = ISCollapsableWindow:new(x, y, width, height);
--    o:noBackground();
    setmetatable(o, self);

    self.__index = self;
    o.animal = animal;
    o.chr = player;
    o.playerNum = player:getPlayerNum();
    o.avatarDefinition = AnimalAvatarDefinition[animal:getAnimalType()];
    o.refreshNeeded = true
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.animalName = getText("IGUI_AnimalType_" .. animal:getAnimalType());
    if animal:getData():getBreed() then
        o.animalName = getText("IGUI_Breed_" .. animal:getData():getBreed():getName()) .. " " .. o.animalName;
    end
    o.animalName = animal:getCustomName() or o.animalName;
    o.skillLvl = player:getPerkLevel(Perks.Husbandry);
    o:setResizable(false)
    return o;
end
