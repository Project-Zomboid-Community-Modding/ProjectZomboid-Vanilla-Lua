--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 14/06/2022
-- Time: 11:09
-- To change this template use File | Settings | File Templates.
--

require "ISUI/ISPanelJoypad"

ISExtAnimListDebugUI = ISCollapsableWindow:derive("ISExtAnimListDebugUI");

--************************************************************************--
--** ISExtAnimListDebugUI:initialise
--**
--************************************************************************--

function ISExtAnimListDebugUI:createChildren()
    local btnWid = 100
    local btnHgt = 25
    local padBottom = self:resizeWidgetHeight() + 10

    self:createList()
    ISCollapsableWindow.createChildren(self)

    self.combo = ISComboBox:new(self.width/2 - 100, self.height/2 - 10, 200, 20, self);
    self.combo:initialise();
    self:addChild(self.combo);

    for i, anim in ipairs(self.extList) do
        self.combo:addOption(anim);
    end
--    self.combo:setWidthToOptions()

    self.start = ISButton:new(10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, "Play", self, ISExtAnimListDebugUI.playAnim);
    self.start.anchorTop = false
    self.start.anchorBottom = true
    self.start:initialise();
    self.start:instantiate();
    self.start.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.start);

    self.closeBtn = ISButton:new(self:getWidth() - btnWid - 20, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, "Close", self, ISExtAnimListDebugUI.closeUI);
    self.closeBtn.anchorLeft = false
    self.closeBtn.anchorRight = true
    self.closeBtn.anchorTop = false
    self.closeBtn.anchorBottom = true
    self.closeBtn:initialise();
    self.closeBtn:instantiate();
    self.closeBtn.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.closeBtn);
end

function ISExtAnimListDebugUI:playAnim()
    self.chr:setVariable("Ext", self.combo.options[self.combo.selected]);
    self.chr:reportEvent("EventDoExt");
end

function ISExtAnimListDebugUI:closeUI()
    self:removeFromUIManager();
end

function ISExtAnimListDebugUI:update()
    ISCollapsableWindow.update(self);
end

function ISExtAnimListDebugUI:render()
    ISCollapsableWindow.render(self);

    self:drawTextCentre("Extended Anim List" , self.width / 2, 20, 1, 1, 1, 1, UIFont.Medium);
end

--************************************************************************--
--** ISExtAnimListDebugUI:new
--**
--************************************************************************--
function ISExtAnimListDebugUI:new(x, y, character)
    local o = {}
    local width = 500;
    local height = 300;
    o = ISCollapsableWindow:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.playerNum = character:getPlayerNum()
    if y == 0 then
        o.y = getPlayerScreenTop(o.playerNum) + (getPlayerScreenHeight(o.playerNum) - height) / 2
        o:setY(o.y)
    end
    if x == 0 then
        o.x = 200;
--        o.x = getPlayerScreenLeft(o.playerNum) + (getPlayerScreenWidth(o.playerNum) - width) / 2
        o:setX(o.x)
    end

--    x = 200
    o.width = width;
    o.height = height;
    o.character = character;
    o.chr = character;
    o.moveWithMouse = true;
    o.anchorLeft = true;
    o.anchorRight = true;
    o.anchorTop = true;
    o.anchorBottom = true;
    return o;
end

function ISExtAnimListDebugUI:createList()
    self.extList = {};
    table.insert(self.extList, "BentDouble");
    table.insert(self.extList, "BridgeNose");
    table.insert(self.extList, "ChewNails");
    table.insert(self.extList, "Cough");
    table.insert(self.extList, "1");
    table.insert(self.extList, "2");
    table.insert(self.extList, "3");
    table.insert(self.extList, "4");
    table.insert(self.extList, "5");
    table.insert(self.extList, "PainHead1");
    table.insert(self.extList, "PainHead2");
    table.insert(self.extList, "PainStomach1");
    table.insert(self.extList, "PainStomach2");
    table.insert(self.extList, "WipeLeftArm");
    table.insert(self.extList, "PainArmL");
    table.insert(self.extList, "PainArmR");
    table.insert(self.extList, "PainHandL");
    table.insert(self.extList, "PainHandR");
    table.insert(self.extList, "PainLegL");
    table.insert(self.extList, "PainLegR");
    table.insert(self.extList, "PainTorso");
    table.insert(self.extList, "PullAtColar");
    table.insert(self.extList, "ShiftWeight");
    table.insert(self.extList, "Shiver");
    table.insert(self.extList, "Sneeze1");
    table.insert(self.extList, "Sneeze2");
    table.insert(self.extList, "TiredStretch");
    table.insert(self.extList, "WipeArmL");
    table.insert(self.extList, "WipeArmR");
    table.insert(self.extList, "WipeBrow");
    table.insert(self.extList, "WipeHead");
    table.insert(self.extList, "WipeLegL");
    table.insert(self.extList, "WipeLegR");
    table.insert(self.extList, "WipeTorso1");
    table.insert(self.extList, "Yawn");
end