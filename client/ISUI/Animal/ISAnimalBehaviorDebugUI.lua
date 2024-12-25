--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 27/03/2023
-- Time: 09:56
-- To change this template use File | Settings | File Templates.
--


require "ISUI/ISCollapsableWindow"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

ISAnimalBehaviorDebugUI = ISCollapsableWindow:derive("ISAnimalBehaviorDebugUI");

function ISAnimalBehaviorDebugUI:prerender()
    ISCollapsableWindow.prerender(self)
end

function ISAnimalBehaviorDebugUI:render()
    ISCollapsableWindow.render(self);

    self:drawText(self.animal:getData():getDebugBehaviorString(), 10, 20, 1,1,1,1, UIFont.Small);

end

function ISAnimalBehaviorDebugUI:initialise()
    ISCollapsableWindow.initialise(self);
    self:create();
end

function ISAnimalBehaviorDebugUI:create()

end

function ISAnimalBehaviorDebugUI:new(x, y, width, height, animal, player)
    local o = {};
    o = ISCollapsableWindow:new(x, y, width, height);
    --    o:noBackground();
    setmetatable(o, self);
    self.__index = self;
    o.animal = animal;
    o.chr = player;
    o.playerNum = player:getPlayerNum();
    o.refreshNeeded = true
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    return o;
end
