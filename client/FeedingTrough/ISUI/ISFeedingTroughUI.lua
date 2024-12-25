--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 25/01/2022
-- Time: 08:44
-- To change this template use File | Settings | File Templates.
--

require "ISUI/ISCollapsableWindow"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

ISFeedingTroughUI = ISCollapsableWindow:derive("ISFeedingTroughUI");

function ISFeedingTroughUI:prerender()
    ISCollapsableWindow.prerender(self)
end

function ISFeedingTroughUI:render()
    ISCollapsableWindow.render(self);

    local x = 120;
    local y = 30;

    self:drawTextRight(getText("IGUI_FeedingTroughUI_AttachedAnimals"), x, y, 1,1,1,1, UIFont.Small);
    self:drawText(self.item:getLinkedAnimals():size() .. "", x + 10, y, 1,1,1,0.5, UIFont.Small);
    y = y + FONT_HGT_MEDIUM;

    local animalZone = DesignationZoneAnimal.getZone(self.item:getSquare():getX(), self.item:getSquare():getY(), self.item:getSquare():getZ())
    local text = getText("IGUI_Animal_TroughNotLinked");
    if animalZone then
        text = animalZone:getName();
    end

    self:drawTextRight(getText("IGUI_Animal_TroughLinkedTo"), x, y, 1,1,1,1, UIFont.Small);
    self:drawText(text, x + 10, y, 1,1,1,0.5, UIFont.Small);
    y = y + FONT_HGT_MEDIUM;

    --if self.item:getSquare():getIsoWorldRegion() and self.item:getSquare():getIsoWorldRegion():isEnclosed() then
    --    self:drawTextRight(getText("IGUI_FeedingTroughUI_Enclosure"), x, y, 1,1,1,1, UIFont.Small);
    --    self:drawText(self.item:getSquare():getIsoWorldRegion():getSquareSize() .. "", x + 10, y, 1,1,1,0.5, UIFont.Small);
    --else
    --    self:drawTextRight(getText("IGUI_FeedingTroughUI_Enclosure"), x, y, 1,1,1,1, UIFont.Small);
    --    self:drawText(getText("IGUI_FeedingTroughUI_EnclosureNotFound"), x + 10, y, 1,1,1,0.5, UIFont.Small);
    --end
    --y = y + FONT_HGT_MEDIUM;


--    if not self.item:getAllFeedingTypes():isEmpty() then
    self:drawTextRight(getText("IGUI_FeedingTroughUI_Feeding"), x, y, 1,1,1,1, UIFont.Small);
    self:drawText(round(self.item:getCurrentFeedAmount(), 2) .. "", x + 10, y, 1,1,1,0.5, UIFont.Small);
    y = y + FONT_HGT_MEDIUM;
--        for i=0, self.item:getAllFeedingTypes():size() - 1 do
--            local type = self.item:getAllFeedingTypes():get(i);
--            self:drawTextRight(getText("ContextMenu_FoodType_" .. type), x + 10, y, 1,1,1,1, UIFont.Small);
--            self:drawText(self.item:getFeedAmount(type) .. "", x + 20, y, 1,1,1,0.5, UIFont.Small);
--            y = y + FONT_HGT_MEDIUM;
--        end
--    end
--
--    if self.item:getWater() > 0 then
        self:drawTextRight(getText("IGUI_FeedingTroughUI_Water"), x, y, 1,1,1,1, UIFont.Small);
        self:drawText(round(self.item:getWater(), 2) * 1000 .. " / " .. self.item:getMaxWater() * 1000 .. " mL", x + 10, y, 1,1,1,0.5, UIFont.Small);
        y = y + FONT_HGT_MEDIUM;
--    end

    self:drawText(getText("Tooltip_trough_info1"), x - 30, y, 1,1,1,1, UIFont.Small);
    y = y + FONT_HGT_SMALL;
    self:drawText(getText("Tooltip_trough_info2"), x - 30, y, 1,1,1,1, UIFont.Small);
    y = y + FONT_HGT_SMALL;
    self:drawText(getText("Tooltip_trough_info3"), x - 30, y, 1,1,1,1, UIFont.Small);

    self:setInfo(getText("IGUI_Trough_Info"));
end

function ISFeedingTroughUI:initialise()
    ISCollapsableWindow.initialise(self);
    self:create();
end

function ISFeedingTroughUI:create()
end

function ISFeedingTroughUI:new(x, y, width, height, trough, player)
    local o = {};
    o = ISCollapsableWindow:new(x, y, width, height);
--    o:noBackground();
    setmetatable(o, self);
    self.__index = self;
    o.item = trough;
    o.chr = player;
    o.playerNum = player:getPlayerNum();
    o.refreshNeeded = true
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    return o;
end
