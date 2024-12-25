--***********************************************************
--**                    THE INDIE STONE                    **
--**				    Author: Aiteron				       **
--***********************************************************

FishingDebugWindow = ISPanelJoypad:derive("FishingDebugWindow");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

function FishingDebugWindow:initialise()
    ISPanelJoypad.initialise(self);
end

function FishingDebugWindow:destroy()
    self:setVisible(false);
    self:removeFromUIManager();
end

function FishingDebugWindow:onClick(button)
    self:destroy()
end

function FishingDebugWindow:titleBarHeight()
    return 16
end

function FishingDebugWindow:prerender()
    self.backgroundColor.a = 0.8

    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);

    local th = self:titleBarHeight()
    self:drawTextureScaled(self.titlebarbkg, 2, 1, self:getWidth() - 4, th - 2, 1, 1, 1, 1);

    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
end

function FishingDebugWindow:render()
    local xx, yy = ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled(), 0)
    local sq = getCell():getGridSquare(math.floor(xx), math.floor(yy), 0)
    if sq == nil then return end
    self:drawText("Coords: " .. sq:getX() .. ", " .. sq:getY(), 10, 22, 1,1,1,1, UIFont.Small)

    local temperatureData = Fishing.Utils.getTemperatureParams(self.player)
    self:drawText("Temperature: " .. math.floor(temperatureData.temperature) .. " (" .. temperatureData.coeff .. ")", 200, 22, 1,1,1,1, UIFont.Small)

    local weatherData = Fishing.Utils.getWeatherParams()
    local weather = "" .. (weatherData.isRain and "Rain; " or "") .. (weatherData.isFog and "Fog; " or "") .. (weatherData.isWind and "Wind; " or "")
    self:drawText("Weather: " .. (weather == "" and "Normal" or weather) .. " (" .. weatherData.coeff .. ")", 10, 34, 1,1,1,1, UIFont.Small)

    local timeData = Fishing.Utils.getTimeParams()
    self:drawText("Time: " .. timeData.time .. " (" .. timeData.coeff .. ")", 200, 34, 1,1,1,1, UIFont.Small)

    local manager = Fishing.ManagerInstances[self.player:getPlayerNum()]
    if manager == nil then return end

    if sq:getProperties() and sq:getProperties():Is(IsoFlagType.water) then
        local fishNumberData = Fishing.Utils.getFishNumParams(xx, yy)

        self:drawText("Fish number: " .. fishNumberData.value .. " (" .. fishNumberData.coeff .. ")", 10, 46, 1,1,1,1, UIFont.Small)

        local trashAbundance = FishSchoolManager.getInstance():getTrashAbundance(xx, yy)
        self:drawText("Trash: " .. math.floor(trashAbundance * 100.0) .. "%", 200, 46, 1,1,1,1, UIFont.Small)

        self:drawText("Is near shore: " .. tostring(Fishing.Utils.isNearShore(xx, yy)), 10, 58, 1,1,1,1, UIFont.Small)
    end

    if manager.fishingRod ~= nil and manager.fishingRod.bobber ~= nil and manager.fishingRod.rodItem ~= nil then
        self:drawText("Fishing rod:", 10, 76, 1,1,1,1, UIFont.Small)
        local hookData = Fishing.Utils.getHookParams(manager.fishingRod.rodItem:getModData().fishing_HookType)
        self:drawText("Hook: " .. hookData.hook .. " (" .. hookData.coeff .. ")", 10, 88, 1, 1, 1, 1, UIFont.Small)
        self:drawText("Tension: " .. math.floor(manager.fishingRod:getTension()*100.0)/100.0, 10, 100, 1,1,1,1, UIFont.Small)
        self:drawText("Timer limit: " .. manager.fishingRod.tensionLimit, 10, 112, 1,1,1,1, UIFont.Small)
        self:drawText("High tension timer: " .. manager.fishingRod.highTensionTimer, 10, 124, 1,1,1,1, UIFont.Small)
        self:drawText("Low tension timer: " .. manager.fishingRod.lowTensionTimer, 10, 136, 1,1,1,1, UIFont.Small)

        self:drawText("Bobber:", 200, 76, 1,1,1,1, UIFont.Small)
        self:drawText("Attract timer: " .. manager.fishingRod.bobber.attractTimer, 200, 88, 1,1,1,1, UIFont.Small)
        self:drawText("Nibble timer: " .. manager.fishingRod.bobber.nibbleTimer, 200, 100, 1,1,1,1, UIFont.Small)
        self:drawText("Lure: " .. (manager.fishingRod.bobber.lure ~= nil and manager.fishingRod.bobber.lure or "None"), 200, 112, 1,1,1,1, UIFont.Small)
        self:drawText("Fishing skill: " .. self.player:getPerkLevel(Perks.Fishing), 200, 124, 1,1,1,1, UIFont.Small)
    end

    local smallCh, mediumCh, bigCh = Fishing.Utils.getFishSizeChancesBySkillLevel(self.player:getPerkLevel(Perks.Fishing), Fishing.Utils.isNearShore(xx, yy))

    self:drawText("Chances:", 10, 148, 1,1,1,1, UIFont.Small)
    self:drawText("Small fish: " .. smallCh, 10, 160, 1,1,1,1, UIFont.Small)
    self:drawText("Medium fish: " .. mediumCh, 10, 172, 1,1,1,1, UIFont.Small)
    self:drawText("Big fish: " .. bigCh, 10, 184, 1,1,1,1, UIFont.Small)

    local y = 212
    local primHand = self.player:getPrimaryHandItem()
    if sq:getProperties() and sq:getProperties():Is(IsoFlagType.water) and primHand ~= nil and primHand:hasTag("FishingRod") and primHand:getModData().fishing_Lure ~= nil then
        self:drawText("Fishes: ", 10, 200, 1,1,1,1, UIFont.Small)

        local lure = primHand:getModData().fishing_Lure
        local isRiver = sq:getWater():getFlow() > 0
        local fishes = {}
        local fishChanceNumber = 0
        for _, fishConfig in ipairs(Fishing.fishes) do
            if isRiver and fishConfig.isRiver then
                if fishConfig.lure[lure] ~= nil then
                    fishChanceNumber = fishChanceNumber + fishConfig.lure[lure]
                    table.insert(fishes, fishConfig)
                end
            elseif not isRiver and fishConfig.isLake then
                if fishConfig.lure[lure] ~= nil then
                    fishChanceNumber = fishChanceNumber + fishConfig.lure[lure]
                    table.insert(fishes, fishConfig)
                end
            end
        end

        local coeff = 100.0 / fishChanceNumber
        local dx = 0
        local dy = 0
        for _, fishConfig in ipairs(fishes) do
            self:drawText(fishConfig.itemType .. " " .. math.floor(fishConfig.lure[lure] * coeff * 100.0)/100.0 .. "%", 10 + dx, 212 + dy, 1,1,1,1, UIFont.Small)
            if dx == 0 then
                dx = 190
            else
                dx = 0
                dy = dy + 12
            end
        end
    end

    self:drawRectBorder(200, 360, 120, 32, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
    self:drawText("Close", 230, 365, 1, 1, 1, 1, UIFont.Small)
end

function FishingDebugWindow:onMouseMove(dx, dy)
    self.mouseOver = true
    if self.moving then
        self:setX(self.x + dx)
        self:setY(self.y + dy)
        self:bringToTop()
    end
end

function FishingDebugWindow:onMouseMoveOutside(dx, dy)
    self.mouseOver = false
    if self.moving then
        self:setX(self.x + dx)
        self:setY(self.y + dy)
        self:bringToTop()
    end
end

function FishingDebugWindow:onMouseDown(x, y)
    if x > 200 and x < 320 and y > 360 and y < 360+32 then
        self:destroy()
        return
    end

    if not self:getIsVisible() then
        return
    end
    self.downX = x
    self.downY = y
    self.moving = true
    self:bringToTop()
end

function FishingDebugWindow:onMouseUp(x, y)
    if not self:getIsVisible() then
        return;
    end
    self.moving = false
    if ISMouseDrag.tabPanel then
        ISMouseDrag.tabPanel:onMouseUp(x,y)
    end
    ISMouseDrag.dragView = nil
end

function FishingDebugWindow:onMouseUpOutside(x, y)
    if not self:getIsVisible() then
        return
    end
    self.moving = false
    ISMouseDrag.dragView = nil
end

function FishingDebugWindow:onMouseDownOutside(x, y)
end

function FishingDebugWindow:new(player)
    local o = ISPanelJoypad:new(100, 100, 400, 400);
    setmetatable(o, self)
    self.__index = self

    o.name = nil;
    o.backgroundColor = {r=0, g=0, b=0, a=0.5};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = 400;
    o.height = 400;
    o.anchorLeft = true;
    o.anchorRight = true;
    o.anchorTop = true;
    o.anchorBottom = true;
    o.player = player;
    o.titlebarbkg = getTexture("media/ui/Panel_TitleBar.png");

    return o;
end