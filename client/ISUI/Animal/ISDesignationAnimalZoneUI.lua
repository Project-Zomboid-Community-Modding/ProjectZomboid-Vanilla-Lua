--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

ISDesignationZoneAnimalZoneUI = ISPanel:derive("ISDesignationZoneAnimalZoneUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.NewMedium)
local updateTick = 0;
local zOffsetBeforeAnimal = 0;
local zOffsetAfterAnimal = 0;

--************************************************************************--
--** ISDesignationZoneAnimalZoneUI:initialise
--**
--************************************************************************--

function ISDesignationZoneAnimalZoneUI:initialise()
    ISPanel.initialise(self);
    local btnWid = 100
    local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
    local btnHgt2 = FONT_HGT_SMALL + 2 * 2
    local padBottom = 10

--    self.parentUI:setVisible(false);

    self.ok = ISButton:new(self:getWidth() - btnWid - 10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("UI_Ok"), self, ISDesignationZoneAnimalZoneUI.onClick);
    self.ok.internal = "OK";
    self.ok.anchorTop = false
    self.ok.anchorBottom = true
    self.ok:initialise();
    self.ok:instantiate();
    self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.ok);

    self.reloadBtn = ISButton:new(self.ok:getRight() - btnWid - btnWid - 10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("UI_Reload"), self, ISDesignationZoneAnimalZoneUI.onClick);
    self.reloadBtn.internal = "RELOAD";
    self.reloadBtn.anchorTop = false
    self.reloadBtn.anchorBottom = true
    self.reloadBtn:initialise();
    self.reloadBtn:instantiate();
    self.reloadBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.reloadBtn);

    self.infoBtn = ISButton:new(10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("ContextMenu_Info"), self, ISDesignationZoneAnimalZoneUI.onClick);
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
        self:setVisible(false);
        self:removeFromUIManager();
        return;
    end

    local z = 20;
    local splitPoint = getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_PvpZone_ZoneName")) + 10;
    local x = 10;
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    self:drawText(self.zone:getName(), self.width/2 - (getTextManager():MeasureStringX(UIFont.NewMedium, self.zone:getName()) / 2), z, 1,1,1,1,UIFont.NewMedium);
    z = z + FONT_HGT_MEDIUM + 20;

    self:drawText(getText("IGUI_DesignationZone_Animals") .. self.zone:getAnimalsConnected():size(), 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;
    if self.nbOfAnimals == -1 then
        self.nbOfAnimals = self.zone:getAnimalsConnected():size()
    end
    if self.nbOfAnimals ~= self.zone:getAnimalsConnected():size() then
        zOffsetAfterAnimal = self:updateAnimals();
        self.nbOfAnimals = self.zone:getAnimalsConnected():size()
    end

    zOffsetBeforeAnimal = z;
    updateTick = updateTick - getGameTime():getMultiplier();
    if updateTick <= 0 then
        updateTick = 1000;
        zOffsetAfterAnimal = self:updateAnimals();
        self:reload();
    end

    z = zOffsetAfterAnimal + FONT_HGT_SMALL + 3;

    self:drawText(getText("IGUI_FeedingTroughUI_Enclosure") .. self.zone:getFullZoneSize(), 10, z, 1,1,1,1, UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    self:drawText(getText("IGUI_DesignationZone_FeedingTroughs") .. self.zone:getTroughsConnected():size(), 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    self:drawText(getText("IGUI_DesignationZone_Hutchs") .. self.zone:getHutchsConnected():size(), 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    local food = self:calcFood();
    self:drawText(getText("IGUI_DesignationZone_Food") .. food, 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    local water = self:calcWater();
    self:drawText(getText("IGUI_DesignationZone_Water") .. water .. " mL", 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    self:drawText(getText("IGUI_DesignationZone_RoofArea") .. self.zone:getRoofAreasConnected():size(), 10, z, 1,1,1,1,UIFont.NewSmall);
    z = z + FONT_HGT_SMALL + 5;

    self:setHeight(z + 50);
end

function ISDesignationZoneAnimalZoneUI:updateAnimals()
    local btnWid = 100
    local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
    local z = zOffsetBeforeAnimal;

    for i,v in ipairs(self.animalbuttons) do
        v:setVisible(false);
        v:removeFromUIManager();
    end
    for i,v in ipairs(self.animalLabels) do
        v:setVisible(false);
        v:removeFromUIManager();
    end

    -- sort by alphabetical order because i'm nice like that
    local animalListSorted = {};
    for i=0, self.zone:getAnimalsConnected():size()-1 do

        table.insert(animalListSorted, self.zone:getAnimalsConnected():get(i));
    end

    table.sort(animalListSorted, function(a,b) return not string.sort(a:getFullName(), b:getFullName()) end)

    self.animalbuttons = {};
    self.animalLabels = {};
    local maxwidth = 0;
    for i,v in ipairs(animalListSorted) do
        local btn = ISButton:new(0, z-8, btnWid, btnHgt, getText("IGUI_Animal_Info"), self, ISDesignationZoneAnimalZoneUI.onClick);
        btn.internal = "INFO";
        btn.animal = v;
        --btn.anchorTop = false
        --btn.anchorBottom = true
        btn:initialise();
        btn:instantiate();
        btn.borderColor = {r=1, g=1, b=1, a=0.1};
        btn:setVisible(true);
        self:addChild(btn);
        table.insert(self.animalbuttons, btn);

        local txt = "    - " .. v:getFullName();
        --print("animal present: ", txt, z)
        local label = ISLabel:new(10, z, 10, txt ,1,1,1,1,UIFont.Small, true);
        self:addChild(label);
        table.insert(self.animalLabels, label);
        --self:drawText(txt, 10, z, 1,1,1,1,UIFont.NewSmall);
        local width = getTextManager():MeasureStringX(UIFont.NewSmall, txt) + 30;
        if width > maxwidth then
            maxwidth = width;
        end
        --if self.animalbuttons[i] then
        --    self.animalbuttons[i+1]:setVisible(true);
        --    --self.animalbuttons[i+1]:setX(width)
        --    self.animalbuttons[i+1]:setY(z-8)
        --end
        if i<#animalListSorted then
            z = z + FONT_HGT_SMALL + 10;
        end
    end

    for i,v in ipairs(self.animalbuttons) do
        v:setX(maxwidth)
    end

    return z;
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
            local millilitres = fluidContainer:getAmount() * 1000
            result = result + millilitres;
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
        self:setVisible(false);
        self:removeFromUIManager();
        self.player:setSeeDesignationZone(false);
    end
    if button.internal == "RELOAD" then
        self.zone:check();
        self:reload();
        zOffsetAfterAnimal = self:updateAnimals();
    end
    if button.internal == "INFO" then
        if AnimalContextMenu.cheat then
            local ui = ISAnimalUI:new(100, 100, 680, 500, button.animal, self.player)
            ui:initialise();
            ui:addToUIManager();
            return;
        end
        if luautils.walkAdj(self.player, button.animal:getSquare()) then
            ISTimedActionQueue.add(ISOpenAnimalInfo:new(self.player, button.animal))
        end
    end
    if button.internal == "READINFO" then
        ISAnimalZoneFirstInfo.showUI(true);
    end
end

function ISDesignationZoneAnimalZoneUI:reload()
    self:calcFood();
    self:calcWater();
end

--************************************************************************--
--** ISDesignationZoneAnimalZoneUI:new
--**
--************************************************************************--
function ISDesignationZoneAnimalZoneUI:new(x, y, width, height, player, zone)
    local o = {}
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
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
    o.animalbuttons = {};
    o.animalLabels = {};
    zone:check();
    o.moveWithMouse = true;
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    player:setSeeDesignationZone(true);
    updateTick = 0;
    o.nbOfAnimals = -1; -- this is used so i can auto refresh when animals nb change
    return o;
end
