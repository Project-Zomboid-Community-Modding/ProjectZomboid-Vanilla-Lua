--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 05/04/2022
-- Time: 11:33
-- To change this template use File | Settings | File Templates.
--

--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "ISUI/ISPanel"

ISAddGeneticDisorderUI = ISPanel:derive("ISAddGeneticDisorderUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

--************************************************************************--
--** ISPanel:initialise
--**
--************************************************************************--

function ISAddGeneticDisorderUI:initialise()
    ISPanel.initialise(self);
    self:create();
end


function ISAddGeneticDisorderUI:setVisible(visible)
    --    self.parent:setVisible(visible);
    self.javaObject:setVisible(visible);
end

function ISAddGeneticDisorderUI:render()

end

function ISAddGeneticDisorderUI:create()
    for i=0,AnimalGenomeDefinitions.getGeneticDisorderList():size()-1 do
        local gd = AnimalGenomeDefinitions.getGeneticDisorderList():get(i)
        table.insert(self.gdList, gd)
    end

    self.combo = ISComboBox:new(10, 70, 100, FONT_HGT_SMALL + 3 * 2, nil,nil);
    self.combo:initialise();
    self:addChild(self.combo);

    self:populateComboList();

    local btnWid = 100
    local btnHgt = math.max(25, FONT_HGT_SMALL + 3 * 2)
    local padBottom = 10

    self.ok = ISButton:new((self:getWidth() / 2) - 100 - 5, self.combo:getBottom() + padBottom, btnWid, btnHgt, getText("UI_Ok"), self, ISAddGeneticDisorderUI.onOptionMouseDown);
    self.ok.internal = "OK";
    self.ok:initialise();
    self.ok:instantiate();
    self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.ok);

    self.cancel = ISButton:new((self:getWidth() / 2) + 5, self.ok:getY(), btnWid, btnHgt, getText("UI_Cancel"), self, ISAddGeneticDisorderUI.onOptionMouseDown);
    self.cancel.internal = "CANCEL";
    self.cancel:initialise();
    self.cancel:instantiate();
    self.cancel.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.cancel);

    self:setHeight(self.cancel:getBottom() + padBottom)
end

function ISAddGeneticDisorderUI:populateComboList()
    self.combo:clear();
    for _,v in ipairs(self.gdList) do
        self.combo:addOption(v);
    end
    self.combo:setWidthToOptions()
end

function ISAddGeneticDisorderUI:onOptionMouseDown(button, x, y)
    if button.internal == "OK" then
        self:setVisible(false);
        self:removeFromUIManager();
        if self.onclick ~= nil then
            self.onclick(self.target, button, self.gdList[self.combo.selected], self.allele);
        end
    end
    if button.internal == "CANCEL" then
        self:setVisible(false);
        self:removeFromUIManager();
    end
end

function ISAddGeneticDisorderUI:new(x, y, width, height, target, onclick, allele)
    local o = {};
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.target = target;
    o.onclick = onclick;
    o.allele = allele;
    o.comboList = {};
    o.zOffsetSmallFont = 25;
    o.gdList = {};
    o.moveWithMouse = true;
    return o;
end


