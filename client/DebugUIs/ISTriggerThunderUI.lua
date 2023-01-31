--***********************************************************
--**                    THE INDIE STONE                    **
--**				    Author: Aiteron				       **
--***********************************************************

ISTriggerThunderUI = ISCollapsableWindow:derive("ISTriggerThunderUI");

function ISTriggerThunderUI:createChildren()
    ISCollapsableWindow.createChildren(self);

    local th = self:titleBarHeight()
    local buttonWid = 120
    local buttonHgt = 24

    self.users = ISComboBox:new(10, th + 10, 180, 20)
    self.users:initialise()
    self:addChild(self.users)
    self.onlineUsers = getOnlinePlayers()
    for i=0, self.onlineUsers:size()-1 do
        self.users:addOptionWithData(self.onlineUsers:get(i):getUsername(), self.onlineUsers:get(i));
    end

    self.tickBox = ISTickBox:new(10, self.users:getBottom() + 10, self:getWidth(), buttonHgt, "")
    self.tickBox:initialise()
    self.tickBox:addOption("All", "ALL")
    self.tickBox:setWidthToFit()
    self:addChild(self.tickBox)

    self.triggerThunder = ISButton:new(self:getWidth()/2 - buttonWid/2, self.tickBox:getBottom() + 10, buttonWid, buttonHgt, "Trigger thunder", self, ISTriggerThunderUI.onClick);
    self.triggerThunder.internal = "TRIGGER";
    self.triggerThunder:initialise();
    self.triggerThunder:instantiate();
    self:addChild(self.triggerThunder);
end

function ISTriggerThunderUI:onClick(button)
    if button.internal == "TRIGGER" then
        if self.tickBox:isSelected(1) then
            local args = { isAll = true }
            sendClientCommand(self.character, 'event', 'thunder', args)
        else
            local sq = self.users.options[self.users.selected].data:getSquare()
            local args = { x = sq:getX(), y = sq:getY(), isAll = false }
            sendClientCommand(self.character, 'event', 'thunder', args)
        end
    end
end

function ISTriggerThunderUI:close()
    self:setVisible(false);
    self:removeFromUIManager()
end

function ISTriggerThunderUI:new(x, y, width, height, character)
    local o = ISCollapsableWindow.new(self, x, y, width, height);
    o:setResizable(false)
    o.title = ""
    o.character = character

    return o
end

