require "ISUI/ISUIElement"

ISAlert = ISUIElement:derive("ISAlert");

function ISAlert:new (x, y, width, height)
    local o = {}
    o = ISUIElement:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.width = width;
    o.height = height;
    o.servermsg = "";
    o.servermsgTimer = 0;
    ISAlert.instance = o;
    return o
end

ISAlert.getAlert = function(message, tabID)
    local line = message:getTextWithPrefix();
    ISAlert.instance.servermsg = "";
    if message:isShowAuthor() then
        ISAlert.instance.servermsg = message:getAuthor() .. ": ";
    end
    ISAlert.instance.servermsg = ISAlert.instance.servermsg .. message:getText();
    ISAlert.instance.servermsgTimer = 5000;
end

function ISAlert:prerender()
    ISAlert.instance = self
    if self.servermsg then
                local x = getCore():getScreenWidth() / 2 - self:getX()
                local y = getCore():getScreenHeight() / 4 - self:getY();
                self:drawTextCentre(self.servermsg, x, y, 1, 0.1, 0.1, 1, UIFont.Title);
                self.servermsgTimer = self.servermsgTimer - UIManager.getMillisSinceLastRender();
                if self.servermsgTimer < 0 then
                    self.servermsg = nil;
                    self.servermsgTimer = 0;
                end
        end
end

--function ISAlert:render()
--    ISUIElement.render(self);
--end

function ISAlert:initialise()
    ISUIElement.initialise(self);
end

ISAlert.setupAlerts = function()
    if not isClient() then
        return;
    end
    ISAlert.alert = ISAlert:new(0, 0, 1, 1);
    ISAlert.alert:initialise();
    ISAlert.alert:addToUIManager();
    ISAlert.alert:setVisible(true);

    ISAlert.instance:setVisible(true);
    Events.OnAlertMessage.Add(ISAlert.getAlert);
end

Events.OnGameStart.Add(ISAlert.setupAlerts);
