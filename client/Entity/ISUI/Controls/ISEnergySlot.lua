--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

ISEnergySlot = ISPanel:derive("ISEnergySlot");

function ISEnergySlot:initialise()
    ISPanel.initialise(self)
end

function ISEnergySlot:createChildren()
    ISEnergySlot.initialise(self);

    if self.enableIcon and self.energy then
        local style = self.styleIcon or "S_Image_EnergyIcon";
        self.icon = ISXuiSkin.build(self.xuiSkin, style, ISImage, 0, 0, 24, 24, self.energy:getIconTexture());
        --self.icon.autoScale = true;
        self.icon:initialise();
        self.icon:instantiate();
        self:addChild(self.icon);
    end

    local style = self.styleBar or ((self.isVertical and "S_EnergyBar_Vertical") or "S_EnergyBar_Horizontal");
    self.energyBar = ISXuiSkin.build(self.xuiSkin, style, ISEnergyBar, 0, 0, 20, 20, self.player, self.resource);
    --self.energyBar.isHorizontal = true;
    self.energyBar.isVertical = self.isVertical; --override to always match parent.
    self.energyBar:initialise();
    self.energyBar:instantiate();
    self:addChild(self.energyBar);

    self.energyBorderColorOrig = self.energyBar.borderColor;
    if self.resource and self.resource:getChannel()~=ResourceChannel.NO_CHANNEL then
        self.energyBar.borderColor = colorToTable(self.resource:getChannel():getColor());
    end
end

function ISEnergySlot:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local margin2x = self.margin*2;

    if self.isVertical then
        if self.icon then
            width = math.max(width, self.icon:getWidth() + margin2x);
        end

        width = math.max(width, self.energyBar:getWidth() + margin2x);

        local minHeight = margin2x;
        if self.icon then
            minHeight = minHeight + self.icon:getHeight() + self.margin;
        end

        minHeight = minHeight + self.minimumBarSize + self.margin;

        height = math.max(height, minHeight);

        local barHeight = height - margin2x;
        if self.icon then
            barHeight = barHeight - self.icon:getHeight() - self.margin;
        end

        local y = self.margin;
        if self.icon then
            self.icon:setX((width/2) - (self.icon:getWidth()/2));
            self.icon:setY(y);

            y = self.icon:getY() + self.icon:getHeight() + self.margin;
        end

        self.energyBar:setX((width/2) - (self.energyBar:getWidth()/2));
        self.energyBar:setY(y);
        self.energyBar:setHeight(barHeight);
    else
        if self.icon then
            height = math.max(height, self.icon:getHeight() + margin2x);
        end

        height = math.max(height, self.energyBar:getHeight() + margin2x);

        local minWidth = margin2x;
        if self.icon then
            minWidth = minWidth + self.icon:getWidth() + self.margin;
        end

        minWidth = minWidth + self.minimumBarSize + self.margin;

        width = math.max(width, minWidth);

        local barWidth = width - margin2x;
        if self.icon then
            barWidth = barWidth - self.icon:getWidth() - self.margin;
        end

        local x = self.margin;
        if self.icon then
            self.icon:setX(x);
            self.icon:setY((height/2) - (self.icon:getHeight()/2));

            x = self.icon:getX() + self.icon:getWidth() + self.margin;
        end

        self.energyBar:setX(x);
        self.energyBar:setY((height/2) - (self.energyBar:getHeight()/2));
        self.energyBar:setWidth(barWidth);
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISEnergySlot:prerender()
    ISPanel.prerender(self);
end

function ISEnergySlot:render()
    --[[
    if true then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0, 1, 0);
    end
    --]]
end

function ISEnergySlot:update()
end

function ISEnergySlot:setResource(_resource)
    if self.resource~= _resource then
        self.resource = _resource;

        if self.energyBar then
            if self.resource and self.resource:getChannel()~=ResourceChannel.NO_CHANNEL then
                self.energyBar.borderColor = colorToTable(self.resource:getChannel():getColor());
            elseif self.energyBorderColorOrig then
                self.energyBar.borderColor = self.energyBorderColorOrig;
            end
        end
    end
end

function ISEnergySlot:new (x, y, width, height, player, resource, styleIcon, styleBar)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.background = true;

    o.player = player;
    o.resource = resource;
    o.energy = resource:getEnergy();

    o.styleIcon = styleIcon;
    o.styleBar = styleBar;

    o.margin = 5;
    o.minimumBarSize = 100;

    o.minimumWidth = 0;
    o.minimumHeight = 0;

    o.enableIcon = true;
    o.isVertical = true;
    o.equalSpacing = true; --if true adds the icon space on opposite side

    return o;
end