--***********************************************************
--**                    THE INDIE STONE                    **
--**				    Author: Aiteron				       **
--***********************************************************

BrushToolManager = ISCollapsableWindow:derive("BrushToolManager");
BrushToolManager.cheat = false
BrushToolManager.instance = nil

function BrushToolManager.openPanel(playerObj)
    if BrushToolManager.instance == nil then
        local window = BrushToolManager:new(100, 350, 160, 130, playerObj)
        window:initialise()
        window:addToUIManager()
        BrushToolManager.instance = window
    end
end

function BrushToolManager:createChildren()
    ISCollapsableWindow.createChildren(self);

    local th = self:titleBarHeight()
    local buttonWid = 120
    local buttonHgt = 24

    self.chooseTile = ISButton:new(self:getWidth()/2 - buttonWid/2, th + 10, buttonWid, buttonHgt, "Choose tile", self, BrushToolManager.onClick);
    self.chooseTile.internal = "CHOOSETILE";
    self.chooseTile:initialise();
    self.chooseTile:instantiate();
    self:addChild(self.chooseTile);

    self.controlFire = ISButton:new(self:getWidth()/2 - buttonWid/2, self.chooseTile:getBottom() + 10, buttonWid, buttonHgt, "Control fire", self, BrushToolManager.onClick);
    self.controlFire.internal = "CONTROLFIRE";
    self.controlFire:initialise();
    self.controlFire:instantiate();
    self:addChild(self.controlFire);

    self.help = ISButton:new(self:getWidth()/2 - buttonWid/2, self.controlFire:getBottom() + 10, buttonWid, buttonHgt, "Help", self, BrushToolManager.onClick);
    self.help.internal = "HELP";
    self.help:initialise();
    self.help:instantiate();
    self:addChild(self.help);
end

function BrushToolManager:onClick(button)
    if button.internal == "CHOOSETILE" then
        BrushToolChooseTileUI.openPanel(self:getRight() + 10, self:getY() + self:getHeight()/2 - 330, self.character)
    elseif button.internal == "CONTROLFIRE" then
        FireBrushUI.openPanel(self:getRight() + 10, self:getY(), self.character)
    elseif button.internal == "HELP" then
        local w = 300
        local h = 300
        local text = "Controls:\n" ..
                    "RMC -> Copy/Destroy tile\n" ..
                    "When tile chosen -> keys '[' ']' to move between tiles"
        local modal = ISModalDialog:new(getCore():getScreenWidth()/2 - w/2, getCore():getScreenHeight() / 2 - h/2, w, h, text,false)
        modal:initialise()
        modal:addToUIManager()
    end
end

function BrushToolManager:close()
    BrushToolManager.instance = nil
    self:setVisible(false);
    self:removeFromUIManager()
end

function BrushToolManager:new(x, y, width, height, character)
    local o = ISCollapsableWindow.new(self, x, y, width, height);
    o:setResizable(false)
    o.title = "Brush Tool Manager"
    o.character = character

    return o
end

