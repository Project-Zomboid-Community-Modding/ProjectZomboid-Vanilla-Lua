require "ISUI/ISCollapsableWindow"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10

ISAnimalTracksUI = ISCollapsableWindow:derive("ISAnimalTracksUI");

function ISAnimalTracksUI:prerender()
    ISCollapsableWindow.prerender(self)
end

function ISAnimalTracksUI:render()
    ISCollapsableWindow.render(self);

    local xoffset = UI_BORDER_SPACING
    local yoffset = self:titleBarHeight() + UI_BORDER_SPACING;
    self:drawRect(xoffset, yoffset, self.iconSize, self.iconSize, 0.5, 0.8, 0.8, 0.8);
    self:drawRectBorder(xoffset, yoffset, self.iconSize, self.iconSize, 1, 1, 1, 1);
    self:drawTextureScaled(self.texture, xoffset + 3, yoffset + 3, 64, 64, 1, 1, 1, 1);

    local textX = UI_BORDER_SPACING * 2 + 70
    local textX2 = textX + UI_BORDER_SPACING + self.maxLabelWidth
    self:drawText(getText("IGUI_AnimalTracks_Type"), textX, yoffset, 1,1,1,1, UIFont.NewSmall);
    self:drawText(getText("IGUI_AnimalTracks_" .. self.track:getTrackType()), textX2, yoffset, 1,1,1,1, UIFont.NewSmall);
    yoffset = yoffset + FONT_HGT_SMALL;
    if self.track:getDir() then
        self:drawText(getText("IGUI_AnimalTracks_Direction"), textX, yoffset, 1,1,1,1, UIFont.NewSmall);
        self:drawText(self.track:getDir():toString(), textX2, yoffset, 1,1,1,1, UIFont.NewSmall);
        yoffset = yoffset + FONT_HGT_SMALL;
    end
    self:drawText(getText("IGUI_AnimalTracks_Animal"), textX, yoffset, 1,1,1,1, UIFont.NewSmall);
    self:drawText(self:getAnimalType(), textX2, yoffset, 1,1,1,1, UIFont.NewSmall);
    yoffset = yoffset + FONT_HGT_SMALL;
    self:drawText(getText("IGUI_AnimalTracks_Freshness"), textX, yoffset, 1,1,1,1, UIFont.NewSmall);
    self:drawText(self.track:getFreshnessString(self.trackingLevel), textX2, yoffset, 1,1,1,1, UIFont.NewSmall);

    self:setWidth(self.textRight + UI_BORDER_SPACING)
    self:setHeight(yoffset + FONT_HGT_SMALL + UI_BORDER_SPACING)
end

function ISAnimalTracksUI:drawText(str, x, y, r, g, b, a, font)
	ISUIElement.drawText(self, str, x, y, r, g, b, a, font)
	local width = getTextManager():MeasureStringX(font or UIFont.Small, str)
	self.textRight = math.max(self.textRight or 0, x + width)
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
    local o = ISCollapsableWindow.new(self, x, y, width, height);
--     o:noBackground();
    o:setResizable(false)
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
    o.iconSize = 70
    local labelWidth1 = getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_AnimalTracks_Type"))
    local labelWidth2 = getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_AnimalTracks_Animal"))
    local labelWidth3 = getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_AnimalTracks_Freshness"))
    o.maxLabelWidth = math.max(labelWidth1, labelWidth2, labelWidth3)
    return o;
end
