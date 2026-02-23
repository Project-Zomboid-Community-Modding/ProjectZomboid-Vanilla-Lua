require "ISUI/ISCollapsableWindow"

TextureWindow = ISCollapsableWindow:derive("TextureWindow");

function TextureWindow:initialise()
    ISCollapsableWindow.initialise(self);
    self.title = self.tex:getName();
end

function TextureWindow:createChildren()
    ISCollapsableWindow.createChildren(self);

    local width = math.max(self.width, self:minTitleBarWidth())
    self:setWidth(width)

    self.renderPanel = ISPanel:new(1, self:titleBarHeight() + 1, self:getWidth(), self.tex:getHeightOrig());
    self.renderPanel.render = TextureWindow.renderTex;
    self.renderPanel.tex = self.tex;
    self.renderPanel:initialise();
    self:addChild(self.renderPanel);
end


function TextureWindow:renderTex()
    self:drawTexture(self.tex, self.width / 2 - self.tex:getWidthOrig() / 2, 0, 1, 1, 1, 1);
end

function TextureWindow:new(x, y, width, height, tex)
    width = math.max(width, 2 + tex:getWidthOrig())
    height = math.max(height, ISCollapsableWindow.TitleBarHeight() + 2 + tex:getHeightOrig())
    local o = ISCollapsableWindow.new(self, x, y, width, height);
    o:setResizable(false)
    o.tex = tex;
    o.backgroundColor = {r=0, g=0, b=0, a=1.0};
    return o
end
