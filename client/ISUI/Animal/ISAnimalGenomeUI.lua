--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 29/03/2022
-- Time: 10:10
-- To change this template use File | Settings | File Templates.
--

require "ISUI/ISCollapsableWindow"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

ISAnimalGenomeUI = ISCollapsableWindow:derive("ISAnimalGenomeUI");

function ISAnimalGenomeUI:prerender()
    if not self.animal:isExistInTheWorld() then
        self:close();
    end
    ISCollapsableWindow.prerender(self)
end

function ISAnimalGenomeUI:render()
    ISCollapsableWindow.render(self);

    local nameWid = getTextManager():MeasureStringX(UIFont.Medium, self.animalName)

    local xoffsetbtn = 150;
    local y = 10;
    local xoffset = 0;

    for i,gene in ipairs(self.allGenes) do
        local x = 50 + xoffset;
        local xBtn = 190 + xoffset;
        local xBtn2 = 480 + xoffset;
        local xallele2 = 280;
        local xvalue = 110;
        self:drawRectBorderStatic(x - 40, y + 25, 550, 80, 1, 0.5, 0.5, 0.5);
        y = y + 20;


        self.mainPanel:drawTextRight("name: ", x, y, 1,1,1,1, UIFont.Small);
        self.mainPanel:drawText(gene.name, x + 10, y, 1,1,1,1, UIFont.Small);
        y = y + 13;
        x = 20 + xoffset;

        self.mainPanel:drawText("allele1:", x, y, 1,1,1,1, UIFont.Small);
        self.mainPanel:drawText("allele2:", x + xallele2, y, 1,1,1,1, UIFont.Small);
        local usedOffset = 40;
        if gene.allele2.used then
            usedOffset = xallele2 + usedOffset;
        end
        self.mainPanel:drawText("(used)", x + usedOffset, y, 0,1,0,1, UIFont.Small);

        gene.used1Btn:setX(xBtn)
        if gene.allele2.used then
            gene.used1Btn:setX(xBtn2)
        end
        gene.used1Btn:setY(y)

        y = y + 13;
        local txt1 = gene.allele1.value .. "";
        if gene.allele1.childValue then
            txt1 = txt1 .. " (" .. gene.allele1.childValue .. ")";
        end
        local txt2 = gene.allele2.value .. "";
        if gene.allele2.childValue then
            txt2 = txt2 .. " (" .. gene.allele2.childValue .. ")";
        end
        self.mainPanel:drawText("value: ", x, y, 1,1,1,1, UIFont.Small);
        self.mainPanel:drawText("value: ", x + xallele2, y, 1,1,1,1, UIFont.Small);
        self.mainPanel:drawText(txt1, x + xvalue, y, 1,1,1,1, UIFont.Small);
        self.mainPanel:drawText(txt2, x + xvalue + xallele2, y, 1,1,1,1, UIFont.Small);
        gene.currentValue1Btn:setX(xBtn)
        gene.currentValue1Btn:setY(y);
        gene.currentValue2Btn:setX(xBtn2)
        gene.currentValue2Btn:setY(y);
        y = y + 13;


        self.mainPanel:drawText("dominant: ", x, y, 1,1,1,1, UIFont.Small);
        self.mainPanel:drawText("dominant: ", x + xallele2, y, 1,1,1,1, UIFont.Small);
        self.mainPanel:drawText(gene.allele1.dominant, x + xvalue, y, 1,1,1,1, UIFont.Small);
        self.mainPanel:drawText(gene.allele2.dominant, x + xvalue + xallele2, y, 1,1,1,1, UIFont.Small);
        gene.dominant1Btn:setX(xBtn)
        gene.dominant1Btn:setY(y);
        gene.dominant2Btn:setX(xBtn2)
        gene.dominant2Btn:setY(y);
        y = y + 13;

        self.mainPanel:drawText("genetic disorder: ", x, y, 1,1,1,1, UIFont.Small);
        self.mainPanel:drawText("genetic disorder: ", x + xallele2, y, 1,1,1,1, UIFont.Small);
        local r,g,b = 1,1,1;
        gene.gd1Btn:setTitle("Add")
        if gene.allele1.geneticDisorder ~= "none" then
            g,b = 0,0;
            gene.gd1Btn:setTitle("Remove")
        end
        self.mainPanel:drawText(gene.allele1.geneticDisorder, x + xvalue, y, r,g,b,1, UIFont.Small);
        r,g,b = 1,1,1;
        gene.gd2Btn:setTitle("Add")
        if gene.allele2.geneticDisorder ~= "none" then
            g, b = 0,0;
            gene.gd2Btn:setTitle("Remove")
        end
        self.mainPanel:drawText(gene.allele2.geneticDisorder, x + xvalue + xallele2, y, r,g,b,1, UIFont.Small);
        gene.gd1Btn:setX(xBtn)
        gene.gd1Btn:setY(y);
        gene.gd2Btn:setX(xBtn2)
        gene.gd2Btn:setY(y);
        y = y + 20;

        if xoffset == 0 then xoffset = 600; y = y - 90 else xoffset = 0 end
    end

    self:setHeight(y + 200)
--    self:setStencilRect(0,0,self:getWidth(),self:getHeight());
end

function ISAnimalGenomeUI:initialise()
    ISCollapsableWindow.initialise(self);
    self:create();
end

function ISAnimalGenomeUI:close()
    self:setVisible(false);
    self:removeFromUIManager();
end

function ISAnimalGenomeUI:subPanelPreRender()
    self:setStencilRect(0,0,self:getWidth(),self:getHeight() - 30);
    ISPanel.prerender(self);
end

function ISAnimalGenomeUI:subPanelRender()
    ISPanel.render(self);
    self:clearStencilRect();
end

function ISAnimalGenomeUI:create()

    self.mainPanel = ISPanel:new(0, 10, self:getWidth(), self:getHeight() - 60)
    self.mainPanel:initialise()
    self.mainPanel:instantiate()
    self.mainPanel:setAnchorRight(true)
    self.mainPanel:setAnchorLeft(true)
    self.mainPanel:setAnchorTop(true)
    self.mainPanel:setAnchorBottom(true)
    self.mainPanel:noBackground()
    self.mainPanel.borderColor = {r=0, g=0, b=0, a=0};
    self.mainPanel.moveWithMouse = true;
    self.mainPanel.render = ISAnimalGenomeUI.subPanelRender
    self.mainPanel.prerender = ISAnimalGenomeUI.subPanelPreRender
    self.mainPanel:addScrollBars(); -- TODO meh. where's my scroll bar
    self:addChild(self.mainPanel)
    self.mainPanel:setScrollChildren(true)


    local btnWid = 70
    local btnHgt = FONT_HGT_SMALL

    for i=0,self.genomeList:size()-1 do
        local gene = self.genomeList:get(i);
        local stuff = {};
        stuff.name = gene:getName();
        stuff.allele1 = {};
        stuff.allele1.allele = gene:getAllele1();
        stuff.allele1.value = round(gene:getAllele1():getCurrentValue(), 2);
        if gene:getAllele1():getTrueRatioValue() > 0 then -- when a value is affected by a ratio, we first gonna show the truue valuue (one that is used in calc) and in () the one that'll be passed onto children
            stuff.allele1.value = round(gene:getAllele1():getTrueRatioValue(), 2);
            stuff.allele1.childValue = round(gene:getAllele1():getCurrentValue(), 2);
        end
        stuff.allele1.used = stuff.allele1.allele:isUsed();
        if gene:getAllele1():isDominant() then
            stuff.allele1.dominant = "true";
        else
            stuff.allele1.dominant = "false";
        end
        stuff.allele1.geneticDisorder = gene:getAllele1():getGeneticDisorder() or "none";
        stuff.allele2 = {};
        stuff.allele2.allele = gene:getAllele2();
        stuff.allele2.value = round(gene:getAllele2():getCurrentValue(), 2);
        if gene:getAllele2():getTrueRatioValue() > 0 then
            stuff.allele2.value = round(gene:getAllele2():getTrueRatioValue(), 2);
            stuff.allele2.childValue = round(gene:getAllele2():getCurrentValue(), 2);
        end
        stuff.allele2.used = stuff.allele2.allele:isUsed();
        if gene:getAllele2():isDominant() then
            stuff.allele2.dominant = "true";
        else
            stuff.allele2.dominant = "false";
        end
        stuff.allele2.geneticDisorder = gene:getAllele2():getGeneticDisorder() or "none";

--        print("init ", gene:getGene1():getName(), gene:getGene1():getCurrentValue(), gene:getGene2():getCurrentValue())

        local currentValue1Btn = ISButton:new(0,0, btnWid, btnHgt, getText("ContextMenu_AnimalGenome_Edit"), self, ISAnimalGenomeUI.changeValue);
        currentValue1Btn:initialise();
        currentValue1Btn:instantiate();
        currentValue1Btn.internal = "currentValue";
        currentValue1Btn.allele = stuff.allele1.allele;
        currentValue1Btn.borderColor = {r=1, g=1, b=1, a=0.1};
        currentValue1Btn:setVisible(true);
        self.mainPanel:addChild(currentValue1Btn);
        stuff.currentValue1Btn = currentValue1Btn;

        local currentValue2Btn = ISButton:new(0,0, btnWid, btnHgt, getText("ContextMenu_AnimalGenome_Edit"), self, ISAnimalGenomeUI.changeValue);
        currentValue2Btn:initialise();
        currentValue2Btn:instantiate();
        currentValue2Btn.internal = "currentValue";
        currentValue2Btn.allele = stuff.allele2.allele;
        currentValue2Btn.borderColor = {r=1, g=1, b=1, a=0.1};
        currentValue2Btn:setVisible(true);
        self.mainPanel:addChild(currentValue2Btn);
        stuff.currentValue2Btn = currentValue2Btn;

        local dominant1Btn = ISButton:new(0,0, btnWid, btnHgt, getText("ContextMenu_AnimalGenome_Edit"), self, ISAnimalGenomeUI.changeValue);
        dominant1Btn:initialise();
        dominant1Btn:instantiate();
        dominant1Btn.internal = "dominant";
        dominant1Btn.allele = stuff.allele1.allele;
        dominant1Btn.borderColor = {r=1, g=1, b=1, a=0.1};
        dominant1Btn:setVisible(true);
        self.mainPanel:addChild(dominant1Btn);
        stuff.dominant1Btn = dominant1Btn;

        local dominant2Btn = ISButton:new(0,0, btnWid, btnHgt, getText("ContextMenu_AnimalGenome_Edit"), self, ISAnimalGenomeUI.changeValue);
        dominant2Btn:initialise();
        dominant2Btn:instantiate();
        dominant2Btn.internal = "dominant";
        dominant2Btn.allele = stuff.allele2.allele;
        dominant2Btn.borderColor = {r=1, g=1, b=1, a=0.1};
        dominant2Btn:setVisible(true);
        self.mainPanel:addChild(dominant2Btn);
        stuff.dominant2Btn = dominant2Btn;

        local used1Btn = ISButton:new(0,0, btnWid, btnHgt, "Switch", self, ISAnimalGenomeUI.changeValue);
        used1Btn:initialise();
        used1Btn:instantiate();
        used1Btn.internal = "used";
        used1Btn.allele1 = stuff.allele1.allele;
        used1Btn.allele2 = stuff.allele2.allele;
        used1Btn.borderColor = {r=1, g=1, b=1, a=0.1};
        used1Btn:setVisible(true);
        self.mainPanel:addChild(used1Btn);
        stuff.used1Btn = used1Btn;

        local gd1Btn = ISButton:new(0,0, btnWid, btnHgt, "Remove", self, ISAnimalGenomeUI.changeValue);
        gd1Btn:initialise();
        gd1Btn:instantiate();
        gd1Btn.internal = "geneticDisorder";
        gd1Btn.allele = stuff.allele1.allele;
        gd1Btn.borderColor = {r=1, g=1, b=1, a=0.1};
        gd1Btn:setVisible(true);
        self.mainPanel:addChild(gd1Btn);
        stuff.gd1Btn = gd1Btn;

        local gd2Btn = ISButton:new(0,0, btnWid, btnHgt, "Remove", self, ISAnimalGenomeUI.changeValue);
        gd2Btn:initialise();
        gd2Btn:instantiate();
        gd2Btn.internal = "geneticDisorder";
        gd2Btn.allele = stuff.allele2.allele;
        gd2Btn.borderColor = {r=1, g=1, b=1, a=0.1};
        gd2Btn:setVisible(true);
        self.mainPanel:addChild(gd2Btn);
        stuff.gd2Btn = gd2Btn;

        table.insert(self.allGenes, stuff);
    end
end

function ISAnimalGenomeUI:changeValue(button)
    if button.internal == "currentValue" then
        local modal = ISTextBox:new(0, 0, 280, 180, "Change " .. button.allele:getName(), round(button.allele:getCurrentValue(), 2) .. "", self, ISAnimalGenomeUI.onChangeValue, nil, button.allele);
        modal.allele = button.allele;
        modal:initialise();
        modal:addToUIManager();
        modal:setOnlyNumbers(true);
    end
    if button.internal == "dominant" then
        local modal = ISModalDialog:new(0, 0, 280, 180, "Dominant?", true, self, ISAnimalGenomeUI.onChangeDominant, nil, button.allele)
        modal:initialise();
        modal:addToUIManager();
    end
    if button.internal == "used" then
        if button.allele1:isUsed() then
            button.allele1:setUsed(false);
            button.allele2:setUsed(true);
        else
            button.allele2:setUsed(false);
            button.allele1:setUsed(true);
        end
        self:reinit();
    end
    if button.internal == "geneticDisorder" then
        if button.allele:getGeneticDisorder() then
            button.allele:setGeneticDisorder(nil);
            AnimalGene.checkGeneticDisorder(self.animal);
            self:reinit();
        else
            local modal = ISAddGeneticDisorderUI:new(self.x + 200, self.y + 200, 350, 250, self, ISAnimalGenomeUI.onAddGb, button.allele)
            modal:initialise();
            modal:addToUIManager();
        end
    end
end

function ISAnimalGenomeUI:onAddGb(button, gd, allele)
    allele:setGeneticDisorder(gd);
    AnimalGene.checkGeneticDisorder(self.animal);
    self:reinit();
end


function ISAnimalGenomeUI:onChangeDominant(modal, allele)
    allele:setDominant(modal.internal == "YES");
    self:reinit();
end

function ISAnimalGenomeUI:reinit()
    for i,gene in ipairs(self.allGenes) do
        gene.currentValue1Btn:removeFromUIManager();
        gene.currentValue2Btn:removeFromUIManager();
        gene.dominant1Btn:removeFromUIManager();
        gene.dominant2Btn:removeFromUIManager();
        gene.gd1Btn:removeFromUIManager();
        gene.gd2Btn:removeFromUIManager();
        gene.used1Btn:removeFromUIManager();
        gene.used1Btn:setVisible(false);
    end
    self.allGenes = {};
    self:create();
    if isClient() then
        sendAnimalGenome(self.animal)
    end
end

function ISAnimalGenomeUI:onChangeValue(button, allele)
    allele:setCurrentValue(tonumber(button.parent.entry:getText()));
    self:reinit();
end

function ISAnimalGenomeUI:new(x, y, width, height, animal, player)
    local o = {};
    width = 1400;
    o = ISCollapsableWindow:new(x, y, width, height);
    --    o:noBackground();
    setmetatable(o, self);

    self.__index = self;
    o.title = getText("ContextMenu_ModifyGenome");
    o.animal = animal;
    o.chr = player;
    o.playerNum = player:getPlayerNum();
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.animalName = getText("IGUI_AnimalType_" .. animal:getAnimalType());
    if animal:getData():getBreed() then
        o.animalName = getText("IGUI_Breed_" .. animal:getData():getBreed():getName()) .. " " .. o.animalName;
    end
    o.animalName = animal:getCustomName() or o.animalName;
    o.genomeList = animal:getFullGenomeList();
    o.allGenes = {};
    return o;
end


