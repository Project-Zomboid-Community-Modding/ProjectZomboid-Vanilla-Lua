require "ISUI/ISCollapsableWindow"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

ISAnimalTracksUI = ISCollapsableWindow:derive("ISAnimalTracksUI");

function ISAnimalTracksUI:prerender()
    ISCollapsableWindow.prerender(self)
end

function ISAnimalTracksUI:render()
    ISCollapsableWindow.render(self);

    self:drawRect(10, 20, 70, 70, 0.5, 0.8, 0.8, 0.8);
    self:drawRectBorder(10, 20, 70, 70, 1, 1, 1, 1);
    self:drawTextureScaled(self.texture, 13, 23, 64, 64, 1, 1, 1, 1);

    local yoffset = 20;
    self:drawText(getText("IGUI_AnimalTracks_Type"), 85, yoffset, 1,1,1,1, UIFont.NewSmall);
    self:drawText(getText("IGUI_AnimalTracks_" .. self.track:getTrackType()), self.xoffset + 5 + 80, yoffset, 1,1,1,1, UIFont.NewSmall);
    yoffset = yoffset + FONT_HGT_SMALL;
    if self.track:getDir() then
        self:drawText(getText("IGUI_AnimalTracks_Direction"), 85, yoffset, 1,1,1,1, UIFont.NewSmall);
        self:drawText(self.track:getDir():toString(), self.xoffset + 5 + 80, yoffset, 1,1,1,1, UIFont.NewSmall);
        yoffset = yoffset + FONT_HGT_SMALL;
    end
    self:drawText(getText("IGUI_AnimalTracks_Animal"), 85, yoffset, 1,1,1,1, UIFont.NewSmall);
    self:drawText(self:getAnimalType(), self.xoffset + 5 + 80, yoffset, 1,1,1,1, UIFont.NewSmall);
    yoffset = yoffset + FONT_HGT_SMALL;
    self:drawText(getText("IGUI_AnimalTracks_Freshness"), 85, yoffset, 1,1,1,1, UIFont.NewSmall);
    self:drawText(self.track:getFreshnessString(self.trackingLevel), self.xoffset + 5 + 80, yoffset, 1,1,1,1, UIFont.NewSmall);
end

function ISAnimalTracksUI:getAnimalType()
    if not MigrationGroupDefinitions[self.track:getAnimalType()] then
        return "???";
    end

    if self.trackingLevel > 4 then
        return getText("IGUI_MigrationGroup_" .. self.track:getAnimalType());
    else
        return getText("IGUI_MigrationGroup_" .. MigrationGroupDefinitions[self.track:getAnimalType()].trackSize);
    end
end

function ISAnimalTracksUI:initialise()
    ISCollapsableWindow.initialise(self);
    self:create();
end

function ISAnimalTracksUI:create()

end

function ISAnimalTracksUI:new(x, y, width, height, track, player)
    local o = {};
    o = ISCollapsableWindow:new(x, y, width, height);
    --    o:noBackground();
    setmetatable(o, self);
    self.__index = self;
    o.track = track:getAnimalTracks();
    o.chr = player;
    o.playerNum = player:getPlayerNum();
    o.refreshNeeded = true
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.texture = nil;
    o.trackingLevel = player:getPerkLevel(Perks.Tracking);
    o.isSprite = instanceof(track, "IsoAnimalTrack");
    if o.isSprite then
        o.texture = getTexture(track:getSprite():getName());
    else
        o.texture = track:getTexture();
    end
    o.xoffset = getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_AnimalTracks_Type"))
    if getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_AnimalTracks_Animal")) > o.xoffset then
        o.xoffset = getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_AnimalTracks_Animal"));
    end
    if getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_AnimalTracks_Freshness")) > o.xoffset then
        o.xoffset = getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_AnimalTracks_Freshness"));
    end
    return o;
end
