require "ISUI/ISPanel"

ISMPScreenShading = ISPanel:derive("ISMPScreenShading");

function ISMPScreenShading:initialise()
    ISPanel.initialise(self);
end

function ISMPScreenShading:destroy()
    self:setVisible(false);
    self:removeFromUIManager();
    if self.joyfocus and self.joyfocus.focus == self then
        self.joyfocus.focus = self.prevFocus
        updateJoypadFocus(self.joyfocus)
    end
end

function ISMPScreenShading:onMouseDown(x, y)
    if not self:getIsVisible() then
        return;
    end
    self:setVisible(false);
    --self.ui.screenShading = nil
    if self.ui.modal then
        self.ui.modal:destroy();
        self.ui.modal = nil
    end
end

function ISMPScreenShading:render()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
end

function ISMPScreenShading:onResolutionChange(oldw, oldh, neww, newh)
    self:setWidth(neww)
    self:setHeight(newh)
    self:setX(0)
    self:setY(0)
end

function ISMPScreenShading:new(ui)
    local o = ISPanel.new(self, x, y, width, height);
    o.backgroundColor = {r=0, g=0, b=0, a=0.5};
    o.width = getCore():getScreenWidth();
    o.height = getCore():getScreenHeight();
    o.x = 0;
    o.y = 0;
    o.ui = ui
    return o;
end

