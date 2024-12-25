--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 18/10/2022
-- Time: 08:35
-- To change this template use File | Settings | File Templates.
--

-- This UI is just here to make easy avatar portrait for animals, they're always tricky 'cause their size varies a lot

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
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.NewLarge)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISDebugAvatarUI = ISCollapsableWindow:derive("ISDebugAvatarUI");

function ISDebugAvatarUI:prerender()
    --    if not self.animal:isExistInTheWorld() then
    --        self:close();
    --    end
    ISCollapsableWindow.prerender(self)

--    self.avatarPanel:setZoom(self.avatarDefinition.zoom * self.animal:getData():getSize());
--    self.avatarPanel:setXOffset(self.avatarDefinition.xoffset * self.animal:getData():getSize());
--    self.avatarPanel:setYOffset(self.avatarDefinition.yoffset * self.animal:getData():getSize());

    local th = self:titleBarHeight()

    local x,y,w,h = UI_BORDER_SPACING+1, th+UI_BORDER_SPACING, self.avatarWidth, self.avatarHeight
    self:drawRectBorder(x - 2, y - 2, w + 4, h + 4, 1, 0.3, 0.3, 0.3);
    self:drawTextureScaled(self.avatarBackgroundTexture, x, y, w, h, 1, 0.4, 0.4, 0.4);

    self.animalList:setX(self.avatarPanel:getRight() + UI_BORDER_SPACING);
    self.animalList:setY(self.avatarY);

    self.breedList:setX(self.avatarPanel:getRight() + UI_BORDER_SPACING);
    self.breedList:setY(self.animalList:getBottom() + UI_BORDER_SPACING);

    self:setWidth(self.breedList:getRight() + UI_BORDER_SPACING + 1)

    self.dirLeft:setX(self.avatarX)
    self.dirLeft:setY(self.avatarY + self.avatarHeight + UI_BORDER_SPACING);

    self.dirRight:setX(self.dirLeft.x + self.dirLeft.width + UI_BORDER_SPACING)
    self.dirRight:setY(self.dirLeft.y);

    self.zoomMinus:setX(self.avatarX)
    self.zoomMinus:setY(self.dirLeft.y + self.dirLeft.height + UI_BORDER_SPACING);

    self.zoomPlus:setX(self.zoomMinus.x + self.zoomMinus.width + UI_BORDER_SPACING)
    self.zoomPlus:setY(self.zoomMinus.y);

    self.xOffsetMinus:setX(self.avatarX)
    self.xOffsetMinus:setY(self.zoomMinus.y + self.zoomMinus.height + UI_BORDER_SPACING);

    self.xOffsetPlus:setX(self.xOffsetMinus.x + self.xOffsetMinus.width + UI_BORDER_SPACING)
    self.xOffsetPlus:setY(self.xOffsetMinus.y);

    self.yOffsetMinus:setX(self.avatarX)
    self.yOffsetMinus:setY(self.xOffsetMinus.y + self.xOffsetMinus.height + UI_BORDER_SPACING);

    self.yOffsetPlus:setX(self.yOffsetMinus.x + self.yOffsetMinus.width + UI_BORDER_SPACING)
    self.yOffsetPlus:setY(self.yOffsetMinus.y);

    self.avatarWidthBtn:setX(self.avatarX)
    self.avatarWidthBtn:setY(self.yOffsetPlus.y + self.yOffsetPlus.height + UI_BORDER_SPACING);

    self.avatarHeightBtn:setX(self.avatarX)
    self.avatarHeightBtn:setY(self.avatarWidthBtn.y + self.avatarWidthBtn.height + UI_BORDER_SPACING);

    self:setHeight(self.avatarHeightBtn:getBottom() + UI_BORDER_SPACING + 1)
end

function ISDebugAvatarUI:render()
    ISCollapsableWindow.render(self);

    local dir = self.direction:toString();
    self:drawText(getText("IGUI_DebugAvatar_Direction")..": " .. dir, self.dirRight.x + self.dirRight.width + UI_BORDER_SPACING, self.dirRight.y, 1,1,1,1, UIFont.NewSmall);

    self:drawText(getText("IGUI_DebugAvatar_Zoom")..": " .. self.zoom, self.zoomPlus.x + self.zoomPlus.width + UI_BORDER_SPACING, self.zoomPlus.y, 1,1,1,1, UIFont.NewSmall);
    self:drawText(getText("IGUI_DebugAvatar_XOffset")..": " .. self.xoffset, self.xOffsetPlus.x + self.xOffsetPlus.width + UI_BORDER_SPACING, self.xOffsetPlus.y, 1,1,1,1, UIFont.NewSmall);
    self:drawText(getText("IGUI_DebugAvatar_YOffset")..": " .. self.yoffset, self.yOffsetPlus.x + self.yOffsetPlus.width + UI_BORDER_SPACING, self.yOffsetPlus.y, 1,1,1,1, UIFont.NewSmall);

    self:drawText(getText("IGUI_DebugAvatar_AvatarW")..": " .. self.avatarWidth, self.avatarWidthBtn.x + self.avatarWidthBtn.width + UI_BORDER_SPACING, self.avatarWidthBtn.y, 1,1,1,1, UIFont.NewSmall);
    self:drawText(getText("IGUI_DebugAvatar_AvatarH")..": " .. self.avatarHeight, self.avatarHeightBtn.x + self.avatarHeightBtn.width + UI_BORDER_SPACING, self.avatarHeightBtn.y, 1,1,1,1, UIFont.NewSmall);
end

function ISDebugAvatarUI:initialise()
    ISCollapsableWindow.initialise(self);
    self:create();
end

function ISDebugAvatarUI:close()
    self:setVisible(false);
    self:removeFromUIManager();
end

function ISDebugAvatarUI:create()

    self.avatarPanel = ISCharacterScreenAvatar:new(self.avatarX, self.avatarY, self.avatarWidth, self.avatarHeight)
    self.avatarPanel:setVisible(true)
    self:addChild(self.avatarPanel)

    self.animalList = ISComboBox:new(0, 0, 100, BUTTON_HGT, self, ISDebugAvatarUI.onSelectAnimal);
    self.animalList:initialise();
    self:addChild(self.animalList);

    self.breedList = ISComboBox:new(0, 0, 100, BUTTON_HGT, self, ISDebugAvatarUI.onSelectBreed);
    self.breedList:initialise();
    self:addChild(self.breedList);

    self:populateAnimalComboBox();
    self:populateBreedComboBox();

--    self.avatarPanel:setState("idle")
--    self.avatarPanel:setDirection(self.avatarDefinition.avatarDir or IsoDirections.S)
--    self.avatarPanel:setIsometric(false)
--    self.avatarPanel:setAnimSetName(self.animal:GetAnimSetName())
--    self.avatarPanel:setCharacter(self.animal)

    self.avatarBackgroundTexture = getTexture("media/ui/avatarBackgroundWhite.png")

    local btnWid = 70
    local btnHgt = FONT_HGT_SMALL

    self.dirLeft = ISButton:new(0,0, BUTTON_HGT, BUTTON_HGT, "", self, ISDebugAvatarUI.onChangeDir);
    self.dirLeft.internal = "LEFT";
    self.dirLeft:initialise();
    self.dirLeft:instantiate();
    self.dirLeft.borderColor = {r=1, g=1, b=1, a=0.1};
    self.dirLeft:setImage(getTexture("media/ui/ArrowLeft.png"))
    self:addChild(self.dirLeft);

    self.dirRight = ISButton:new(0,0, BUTTON_HGT, BUTTON_HGT, "", self, ISDebugAvatarUI.onChangeDir);
    self.dirRight.internal = "RIGHT";
    self.dirRight:initialise();
    self.dirRight:instantiate();
    self.dirRight.borderColor = {r=1, g=1, b=1, a=0.1};
    self.dirRight:setImage(getTexture("media/ui/ArrowRight.png"))
    self:addChild(self.dirRight);

    self.zoomMinus = ISButton:new(0,0, BUTTON_HGT, BUTTON_HGT, "-", self, ISDebugAvatarUI.onChangeStuff);
    self.zoomMinus.internal = "ZOOMMINUS";
    self.zoomMinus:initialise();
    self.zoomMinus:instantiate();
    self.zoomMinus.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.zoomMinus);

    self.zoomPlus = ISButton:new(0,0, BUTTON_HGT, BUTTON_HGT, "+", self, ISDebugAvatarUI.onChangeStuff);
    self.zoomPlus.internal = "ZOOMPLUS";
    self.zoomPlus:initialise();
    self.zoomPlus:instantiate();
    self.zoomPlus.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.zoomPlus);

    self.xOffsetMinus = ISButton:new(0,0, BUTTON_HGT, BUTTON_HGT, "-", self, ISDebugAvatarUI.onChangeStuff);
    self.xOffsetMinus.internal = "XOFFSETMINUS";
    self.xOffsetMinus:initialise();
    self.xOffsetMinus:instantiate();
    self.xOffsetMinus.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.xOffsetMinus);

    self.xOffsetPlus = ISButton:new(0,0, BUTTON_HGT, BUTTON_HGT, "+", self, ISDebugAvatarUI.onChangeStuff);
    self.xOffsetPlus.internal = "XOFFSETPLUS";
    self.xOffsetPlus:initialise();
    self.xOffsetPlus:instantiate();
    self.xOffsetPlus.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.xOffsetPlus);

    self.yOffsetMinus = ISButton:new(0,0, BUTTON_HGT, BUTTON_HGT, "-", self, ISDebugAvatarUI.onChangeStuff);
    self.yOffsetMinus.internal = "YOFFSETMINUS";
    self.yOffsetMinus:initialise();
    self.yOffsetMinus:instantiate();
    self.yOffsetMinus.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.yOffsetMinus);

    self.yOffsetPlus = ISButton:new(0,0, BUTTON_HGT, BUTTON_HGT, "+", self, ISDebugAvatarUI.onChangeStuff);
    self.yOffsetPlus.internal = "YOFFSETPLUS";
    self.yOffsetPlus:initialise();
    self.yOffsetPlus:instantiate();
    self.yOffsetPlus.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.yOffsetPlus);

    local btnWidth = UI_BORDER_SPACING*2 + getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Change"))

    self.avatarWidthBtn = ISButton:new(0,0, btnWidth, BUTTON_HGT, getText("IGUI_DebugMenu_Change"), self, ISDebugAvatarUI.onChangeAvatarWidth);
    self.avatarWidthBtn:initialise();
    self.avatarWidthBtn:instantiate();
    self.avatarWidthBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.avatarWidthBtn);

    self.avatarHeightBtn = ISButton:new(0,0, btnWidth, BUTTON_HGT, getText("IGUI_DebugMenu_Change"), self, ISDebugAvatarUI.onChangeAvatarHeight);
    self.avatarHeightBtn:initialise();
    self.avatarHeightBtn:instantiate();
    self.avatarHeightBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.avatarHeightBtn);

    self:doNewAnimal(self.animal, self.breed);
end

function ISDebugAvatarUI:onChangeAvatarHeight()
    local modal = ISTextBox:new(0, 0, 180, 180, "Height", self.avatarHeight .. "", self, ISDebugAvatarUI.changeHeight);
    modal:initialise()
    modal:addToUIManager()
end

function ISDebugAvatarUI:changeHeight(button)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            self.avatarHeight = tonumber(button.parent.entry:getText());
            self.avatarPanel:setHeight(self.avatarHeight)
        end
    end
end

function ISDebugAvatarUI:onChangeAvatarWidth()
    local modal = ISTextBox:new(0, 0, 280, 180, "Width", self.avatarWidth .. "", self, ISDebugAvatarUI.changeWidth);
    modal:initialise()
    modal:addToUIManager()
end

function ISDebugAvatarUI:changeWidth(button)
    if button.internal == "OK" then
        if button.parent.entry:getText() and button.parent.entry:getText() ~= "" then
            self.avatarWidth = tonumber(button.parent.entry:getText());
            self.avatarPanel:setWidth(self.avatarWidth)
        end
    end
end

function ISDebugAvatarUI:onChangeDir(button, x, y)
    if button.internal == "LEFT" then
        self.direction = IsoDirections.RotLeft(self.direction)
    elseif button.internal == "RIGHT" then
        self.direction = IsoDirections.RotRight(self.direction)
    end
    self.avatarPanel:setDirection(self.direction)
end

function ISDebugAvatarUI:onChangeStuff(button, x, y)
    --the lines that use tonumber() are where floating point inaccuracies kept stacking up.
    if button.internal == "ZOOMMINUS" then
        self.zoom = self.zoom - 0.5;
    elseif button.internal == "ZOOMPLUS" then
        self.zoom = self.zoom + 0.5;
    elseif button.internal == "XOFFSETMINUS" then
        self.xoffset = tonumber(string.format("%.1f", self.xoffset - 0.1));
    elseif button.internal == "XOFFSETPLUS" then
        self.xoffset = tonumber(string.format("%.1f", self.xoffset + 0.1));
    elseif button.internal == "YOFFSETMINUS" then
        self.yoffset = tonumber(string.format("%.1f", self.yoffset - 0.1));
    elseif button.internal == "YOFFSETPLUS" then
        self.yoffset = tonumber(string.format("%.1f", self.yoffset + 0.1));
    end

    self.avatarPanel:setZoom(self.zoom * self.animalObj:getData():getSize());
    self.avatarPanel:setXOffset(self.xoffset * self.animalObj:getData():getSize());
    self.avatarPanel:setYOffset(self.yoffset * self.animalObj:getData():getSize());

    print("final values zoom: ", self.zoom * self.animalObj:getData():getSize(), ", X offset: ", self.xoffset * self.animalObj:getData():getSize(), ", Y offset:", self.yoffset * self.animalObj:getData():getSize())
end

function ISDebugAvatarUI:populateAnimalComboBox()
    self.animalList:clear();

    local defs = getAllAnimalsDefinitions();
    self.currentDef = nil;
    for i=0, defs:size()-1 do
        local def = defs:get(i);
        self.animalList:addOptionWithData(def:getAnimalType(), def);
        if def:getAnimalType() == self.animal then
            self.animalList.selected = i + 1;
            self.currentDef = def;
        end
    end

    self.animalList:setWidthToOptions()
end

function ISDebugAvatarUI:populateBreedComboBox()
    self.breedList:clear();

    local breeds = self.currentDef:getBreeds();
    for i=0,breeds:size()-1 do
        local breed = breeds:get(i);
        self.breedList:addOption(breed:getName());
        if not self.breed and i == 0 then
            self.breed = breed:getName();
        end
    end

    self.breedList:setWidth(self.animalList.width)
end

function ISDebugAvatarUI:onSelectBreed(combo)
    self.breed = combo:getOptionText(combo.selected);

    self:doNewAnimal(self.animal, self.breed)
end

function ISDebugAvatarUI:onSelectAnimal(combo)
    self.breed = nil;
    self.currentDef = combo:getOptionData(combo.selected);
    self.animal = combo:getOptionText(combo.selected);

    self:populateBreedComboBox();

    self:doNewAnimal(self.animal, self.breed)
end

function ISDebugAvatarUI:doNewAnimal(animal, breed)
    local animal = IsoAnimal.new(getCell(), self.chr:getCurrentSquare():getX(), self.chr:getCurrentSquare():getY() - 2, self.chr:getCurrentSquare():getZ(), animal, breed);
    self.animalObj = animal;
    animal:setMaxSizeDebug();
    animal:addToWorld();
    animal:removeFromWorld();

    self.avatarPanel:setState("idle")
    self.avatarPanel:setDirection(self.direction)
    self.avatarPanel:setIsometric(false)
    self.avatarPanel:setAnimSetName(animal:GetAnimSetName())
    self.avatarPanel:setCharacter(animal)
end

function ISDebugAvatarUI:new(player)
    local x = 300;
    local y = 300;
    local width = 500;
    local height = 500;
    local o = {};
    o = ISCollapsableWindow:new(x, y, width, height);
    --    o:noBackground();
    setmetatable(o, self);

    self.__index = self;
    o.chr = player;
    o.playerNum = player:getPlayerNum();
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.animal = "cow";
    o.breed = "angus";
    o.zoom = 0;
    o.xoffset = 0;
    o.yoffset = 0;
    o.avatarX = UI_BORDER_SPACING+1
    o.avatarY = o:titleBarHeight() + UI_BORDER_SPACING
    o.avatarWidth = 200;
    o.avatarHeight = 200;
    o:setResizable(false)
    o.title = getText("IGUI_DebugContext_AvatarUI")
    o.direction = IsoDirections.SW;
    return o;
end


