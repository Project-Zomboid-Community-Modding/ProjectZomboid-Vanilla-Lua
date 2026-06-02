require "ISUI/ISCollapsableWindow"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local UI_BORDER_SPACING = 10

ISFeedingTroughUI = ISCollapsableWindow:derive("ISFeedingTroughUI");

function ISFeedingTroughUI:createChildren()
    ISCollapsableWindow.createChildren(self)

    self.ignoreChildren = ArrayList.new(self.javaObject:getControls())

    local x = getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_FeedingTroughUI_AttachedAnimals"));
    x = math.max(x, getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_Animal_TroughLinkedTo")));
    x = math.max(x, getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_FeedingTroughUI_Feeding")));
    x = math.max(x, getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_FeedingTroughUI_Water")));
    x = UI_BORDER_SPACING + x

    local r,g,b,a = 0.5, 0.5, 0.5, 1.0

    local y = self:titleBarHeight() + UI_BORDER_SPACING
    local label = ISLabel:new(x, y, FONT_HGT_SMALL, getText("IGUI_FeedingTroughUI_AttachedAnimals"), 1, 1, 1, 1, UIFont.Small, false)
    self:addChild(label)
    label = ISLabel:new(x + 10, label.y, FONT_HGT_SMALL, "", r, g, b, a, UIFont.Small, true)
    self:addChild(label)
    self.labelAttachedAnimals = label

    label = ISLabel:new(x, label:getBottom(), FONT_HGT_SMALL, getText("IGUI_Animal_TroughLinkedTo"), 1, 1, 1, 1, UIFont.Small, false)
    self:addChild(label)
    label = ISLabel:new(x + 10, label.y, FONT_HGT_SMALL, "", r, g, b, a, UIFont.Small, true)
    self:addChild(label)
    self.labelLinkedTo = label

    label = ISLabel:new(x, label:getBottom(), FONT_HGT_SMALL, getText("IGUI_FeedingTroughUI_Feeding"), 1, 1, 1, 1, UIFont.Small, false)
    self:addChild(label)
    label = ISLabel:new(x + 10, label.y, FONT_HGT_SMALL, "", r, g, b, a, UIFont.Small, true)
    self:addChild(label)
    self.labelFeed = label

    label = ISLabel:new(x, label:getBottom(), FONT_HGT_SMALL, getText("IGUI_FeedingTroughUI_Water"), 1, 1, 1, 1, UIFont.Small, false)
    self:addChild(label)
    label = ISLabel:new(x + 10, label.y, FONT_HGT_SMALL, "", r, g, b, a, UIFont.Small, true)
    self:addChild(label)
    self.labelWater = label

    y = label:getBottom() + 20
    label = ISLabel:new(UI_BORDER_SPACING, y, FONT_HGT_SMALL, getText("Tooltip_trough_info1"), 1, 1, 1, 1, UIFont.Small, true)
    self:addChild(label)
    label = ISLabel:new(UI_BORDER_SPACING, label:getBottom(), FONT_HGT_SMALL, getText("Tooltip_trough_info2"), 1, 1, 1, 1, UIFont.Small, true)
    self:addChild(label)
    label = ISLabel:new(UI_BORDER_SPACING, label:getBottom(), FONT_HGT_SMALL, getText("Tooltip_trough_info3"), 1, 1, 1, 1, UIFont.Small, true)
    self:addChild(label)

    self:shrinkWrap(UI_BORDER_SPACING + 1, UI_BORDER_SPACING + 1, function(_child)
        return not self.ignoreChildren:contains(_child.javaObject)
    end)
end

function ISFeedingTroughUI:prerender()
    if self.item:getObjectIndex() == -1 then
        self:close()
        return
    end
    ISCollapsableWindow.prerender(self)
end

function ISFeedingTroughUI:render()
    ISCollapsableWindow.render(self);

    self.labelAttachedAnimals:setName(tostring(self.item:getLinkedAnimals():size()));

    local animalZone = DesignationZoneAnimal.getZone(self.item:getSquare():getX(), self.item:getSquare():getY(), self.item:getSquare():getZ())
    local text = getText("IGUI_Animal_TroughNotLinked");
    if animalZone then
        text = animalZone:getName();
    end
    self.labelLinkedTo:setName(text);

    self.labelFeed:setName(tostring(round(self.item:getCurrentFeedAmount(), 2)));
    self.labelWater:setName(round(self.item:getWater(), 2) * 1000 .. " / " .. self.item:getMaxWater() * 1000 .. " mL");

    self:shrinkWrap(UI_BORDER_SPACING + 1, UI_BORDER_SPACING + 1, function(_child)
        return not self.ignoreChildren:contains(_child.javaObject)
    end)

    self:setInfo(getText("IGUI_Trough_Info"));
end

function ISFeedingTroughUI:initialise()
    ISCollapsableWindow.initialise(self);
    self:create();
end

function ISFeedingTroughUI:create()
end

function ISFeedingTroughUI:close()
    self:setVisible(false)
    self:removeFromUIManager()
end

function ISFeedingTroughUI:new(x, y, width, height, trough, player)
    local o = ISCollapsableWindow.new(self, x, y, width, height);
    o.title = getText("ContextMenu_FeedingTrough")
    o.item = trough;
    o.chr = player;
    o.playerNum = player:getPlayerNum();
    o.refreshNeeded = true
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o:setResizable(false)
    return o;
end
