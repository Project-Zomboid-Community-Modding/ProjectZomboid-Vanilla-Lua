require "ISUI/ISPanel"

ISSLEvent = ISPanel:derive("ISSLEvent");

function ISSLEvent:initialise()
    ISPanel.initialise(self)
end

function ISSLEvent:createChildren()
    self.eventFrame = ISSLFrame:new(20,20,300,200);
    self.eventFrame:initialise();
    self:addChild(self.eventFrame);

    self.eventSoundList = ISScrollingListBox:new(0, 0, 200, self.height);
    self.eventSoundList:initialise();
    self.eventSoundList:instantiate();
    self.eventSoundList.itemheight = 30;
    self.eventSoundList.selected = 0;
    self.eventSoundList.doDrawItem = ISSLEvent.drawEventSoundItem;
    self.eventSoundList.drawBorder = false;
    self:addChild(self.eventSoundList);

    self:onResize();
end

function ISSLEvent:setEvent(_event)
    self.storyEvent = _event;
    self.eventData = {};
    if self.storyEvent~=nil then
        local eventSounds = self.storyEvent:getEventSounds();
        if eventSounds~=nil and eventSounds:size()>0 then
            for i=0, eventSounds:size()-1 do
                local eSound = eventSounds:get(i);
                local dataPoints = eSound:getDataPoints();

                self:addEventSoundItem(eSound);

                table.insert(self.eventData, {eventSound=eSound, dataPoints= dataPoints});
            end
        end
    end
    self.eventFrame:setStoryEvent(_event);
end

function ISSLEvent:addEventSoundItem(_eventSound)
    local name = _eventSound:getCat();
    local item = {};
    item.eventSound = _eventSound;

    self.eventSoundList:addItem(name, item);
end

function ISSLEvent:drawEventSoundItem(y, item, alt)
    local a = 0.9;

    self:drawRectBorder(0, y, self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, y, self:getWidth(), self.itemheight - 1, 0.3, 0.35, 0.7, 0.15);
    end

    self:drawText(item.item.eventSound:getName(), 6, y + 2, 1, 1, 1, a, UIFont.Medium);

    return y + self.itemheight;
end

function ISSLEvent:update()
    ISPanel.update(self);
end

function ISSLEvent:prerender()
    ISPanel.prerender(self);
end

function ISSLEvent:render()
    ISPanel.render(self);
end

function ISSLEvent:onResize()
    ISUIElement.onResize(self);
    self.eventFrame:setX(200);
    self.eventFrame:setY(0)
    self.eventFrame:setWidth(self:getWidth()-200);
    self.eventFrame:setHeight(self:getHeight());

    self.eventSoundList:setHeight(self:getHeight());
end

function ISSLEvent:new (x, y, width, height)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.background = true;
    o.backgroundColor = {r=0, g=0, b=0, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    return o
end
