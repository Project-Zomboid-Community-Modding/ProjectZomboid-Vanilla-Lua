--***********************************************************
--**                    THE INDIE STONE                    **
--**				    Author: Aiteron				       **
--***********************************************************

FireBrushUI = ISPanelJoypad:derive("FireBrushUI");
FireBrushUI.instance = nil

function FireBrushUI.openPanel(x, y, playerObj)
    if FireBrushUI.instance == nil then
        local window = FireBrushUI:new(x, y, 200, 400, playerObj)
        window:initialise()
        window:addToUIManager()
        FireBrushUI.instance = window
    end
end

function FireBrushUI:initialise()
    ISPanelJoypad.initialise(self);

    local buttonWid = 150
    local buttonHgt = 25

    self.brushType = ISRadioButtons:new(self:getWidth()/2 - 50, 26, 150, 20, self)
    self.brushType.choicesColor = {r=1, g=1, b=1, a=1}
    self.brushType:initialise()
    self.brushType.autoWidth = true;
    self:addChild(self.brushType)
    self.brushType:addOption("Fire");
    self.brushType:addOption("Smoke")
    self.brushType:addOption("Explosion")
    self.brushType:setSelected(1)

    self.addByClick = ISButton:new(self:getWidth() / 2 - buttonWid/2, self.brushType:getBottom() + 10, buttonWid, buttonHgt, "Add by click", self, FireBrushUI.onClick);
    self.addByClick.internal = "ADDBYCLICK";
    self.addByClick:initialise();
    self.addByClick:instantiate();
    self:addChild(self.addByClick);

    self.removeByClick = ISButton:new(self:getWidth() / 2 - buttonWid/2, self.addByClick:getBottom() + 10, buttonWid, buttonHgt, "Remove by click", self, FireBrushUI.onClick);
    self.removeByClick.internal = "REMOVEBYCLICK";
    self.removeByClick:initialise();
    self.removeByClick:instantiate();
    self:addChild(self.removeByClick);

    self.addByArea = ISButton:new(self:getWidth() / 2 - buttonWid/2, self.removeByClick:getBottom() + 10, buttonWid, buttonHgt, "Add by area", self, FireBrushUI.onClick);
    self.addByArea.internal = "ADDBYAREA";
    self.addByArea:initialise();
    self.addByArea:instantiate();
    self:addChild(self.addByArea);

    self.removeByArea = ISButton:new(self:getWidth() / 2 - buttonWid/2, self.addByArea:getBottom() + 10, buttonWid, buttonHgt, "Remove by area", self, FireBrushUI.onClick);
    self.removeByArea.internal = "REMOVEBYAREA";
    self.removeByArea:initialise();
    self.removeByArea:instantiate();
    self:addChild(self.removeByArea);

    self.close = ISButton:new(self:getWidth() / 2 - buttonWid/2, self.removeByArea:getBottom() + 10, buttonWid, buttonHgt, "Close", self, FireBrushUI.onClick);
    self.close.internal = "CLOSE";
    self.close:initialise();
    self.close:instantiate();
    self:addChild(self.close);
end

function FireBrushUI:destroy()
    FireBrushUI.instance = nil
    self:setVisible(false);
    self:removeFromUIManager();
end

function FireBrushUI:onClick(button)
    if button.internal == "ADDBYAREA" then
        self.selectEnd = false
        self.startPos = nil
        self.endPos = nil
        self.zPos = self.player:getZ()
        self.selectStart = true

        self.selectByClick = false
        self.isAdd = true
    elseif button.internal == "REMOVEBYAREA" then
        self.selectEnd = false
        self.startPos = nil
        self.endPos = nil
        self.zPos = self.player:getZ()
        self.selectStart = true

        self.selectByClick = false
        self.isAdd = false
    elseif button.internal == "ADDBYCLICK" then
        self.selectByClick = true
        self.isAdd = true
        self.selectStart = false
        self.selectEnd = false
    elseif button.internal == "REMOVEBYCLICK" then
        self.selectByClick = true
        self.isAdd = false
        self.selectStart = false
        self.selectEnd = false
    elseif button.internal == "CLOSE" then
        self:destroy();
    end
end

function FireBrushUI:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawTextureScaled(self.titlebarbkg, 2, 1, self:getWidth() - 4, 16 - 2, 1, 1, 1, 1);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
end

function FireBrushUI:render()
    if self.selectStart or self.selectByClick then
        local xx, yy = ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled(), self.zPos)
        local sq = getCell():getGridSquare(math.floor(xx), math.floor(yy), self.zPos)
        if sq and sq:getFloor() then sq:getFloor():setHighlighted(true) end
    elseif self.selectEnd then
        local xx, yy = ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled(), self.zPos)
        xx = math.floor(xx)
        yy = math.floor(yy)
        local cell = getCell()
        local x1 = math.min(xx, self.startPos.x)
        local x2 = math.max(xx, self.startPos.x)
        local y1 = math.min(yy, self.startPos.y)
        local y2 = math.max(yy, self.startPos.y)

        for x = x1, x2 do
            for y = y1, y2 do
                local sq = cell:getGridSquare(x, y, self.zPos)
                if sq and sq:getFloor() then sq:getFloor():setHighlighted(true) end
            end
        end
    elseif self.startPos ~= nil and self.endPos ~= nil then
        local cell = getCell()
        local x1 = math.min(self.startPos.x, self.endPos.x)
        local x2 = math.max(self.startPos.x, self.endPos.x)
        local y1 = math.min(self.startPos.y, self.endPos.y)
        local y2 = math.max(self.startPos.y, self.endPos.y)
        for x = x1, x2 do
            for y = y1, y2 do
                local sq = cell:getGridSquare(x, y, self.zPos)
                if sq and sq:getFloor() then sq:getFloor():setHighlighted(true) end
            end
        end
    end
end

function FireBrushUI:onMouseMove(dx, dy)
    self.mouseOver = true
    if self.moving then
        self:setX(self.x + dx)
        self:setY(self.y + dy)
        self:bringToTop()
    end
end

function FireBrushUI:onMouseMoveOutside(dx, dy)
    self.mouseOver = false
    if self.moving then
        self:setX(self.x + dx)
        self:setY(self.y + dy)
        self:bringToTop()
    end
end

function FireBrushUI:onMouseDown(x, y)
    if not self:getIsVisible() then
        return
    end
    self.downX = x
    self.downY = y
    self.moving = true
    self:bringToTop()
end

function FireBrushUI:onMouseUp(x, y)
    if not self:getIsVisible() then
        return;
    end
    self.moving = false
    if ISMouseDrag.tabPanel then
        ISMouseDrag.tabPanel:onMouseUp(x,y)
    end
    ISMouseDrag.dragView = nil
end

function FireBrushUI:onMouseUpOutside(x, y)
    if not self:getIsVisible() then
        return
    end
    self.moving = false
    ISMouseDrag.dragView = nil
end

function FireBrushUI:applyOnArea()
    local cell = getCell()
    local x1 = math.min(self.startPos.x, self.endPos.x)
    local x2 = math.max(self.startPos.x, self.endPos.x)
    local y1 = math.min(self.startPos.y, self.endPos.y)
    local y2 = math.max(self.startPos.y, self.endPos.y)
    local z1 = self.zPos
    local z2 = self.zPos
    if not self.isAdd then
        z1 = 0
        z2 = 8
    end

    for z = z1, z2 do
        for x = x1, x2 do
            for y = y1, y2 do
                local sq = cell:getGridSquare(x, y, z)
                if sq ~= nil then
                    if self.brushType:isSelected(1) then
                        if self.isAdd then
                            self:addFire(sq)
                        else
                            self:removeFire(sq)
                        end
                    elseif self.brushType:isSelected(2) then
                        if self.isAdd then
                            self:addSmoke(sq)
                        else
                            self:removeSmoke(sq)
                        end
                    else
                        if self.isAdd then
                            self:addExplosion(sq)
                        end
                    end
                end
            end
        end
    end

    self.selectEnd = false
    self.startPos = nil
    self.endPos = nil
    self.selectStart = false
end

function FireBrushUI:addFire(square)
    local args = { x = square:getX(), y = square:getY(), z = square:getZ() }
    sendClientCommand(self.player, 'object', 'addFireOnSquare', args)
end

function FireBrushUI:removeFire(square)
    square:stopFire()
    square:transmitStopFire()
end

function FireBrushUI:addSmoke(square)
    local args = { x = square:getX(), y = square:getY(), z = square:getZ() }
    sendClientCommand(self.player, 'object', 'addSmokeOnSquare', args)
end

function FireBrushUI:removeSmoke(square)
    square:stopFire()
    square:transmitStopFire()
end

function FireBrushUI:addExplosion(square)
    local args = { x = square:getX(), y = square:getY(), z = square:getZ() }
    sendClientCommand(self.player, 'object', 'addExplosionOnSquare', args)
end

function FireBrushUI:onMouseDownOutside(x, y)
    if x >= 0 and x <= self:getWidth() and y >= 0 and y <= self:getHeight() then return end

    local xx, yy = ISCoordConversion.ToWorld(getMouseXScaled(), getMouseYScaled(), self.zPos)
    if self.selectStart then
        self.startPos = { x = math.floor(xx), y = math.floor(yy) }
        self.selectStart = false
        self.selectEnd = true
    elseif self.selectEnd then
        self.endPos = { x = math.floor(xx), y = math.floor(yy) }
        self.selectEnd = false
        self:applyOnArea()
    end
    if self.selectByClick then
        local sq = getCell():getGridSquare(xx, yy, self.zPos)
        if self.brushType:isSelected(1) then
            if self.isAdd then
                self:addFire(sq)
            else
                self:removeFire(sq)
            end
        elseif self.brushType:isSelected(2) then
            if self.isAdd then
                self:addSmoke(sq)
            else
                self:removeSmoke(sq)
            end
        else
            if self.isAdd then
                self:addExplosion(sq)
            end
        end
    end
end

function FireBrushUI:new(x, y, width, height, player)
    local o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.titlebarbkg = getTexture("media/ui/Panel_TitleBar.png");
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};

    o.isAdd = true

    o.selectStart = false
    o.selectEnd = false
    o.startPos = nil
    o.endPos = nil
    o.zPos = 0

    return o;
end
