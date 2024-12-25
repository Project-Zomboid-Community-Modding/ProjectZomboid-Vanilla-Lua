--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISScrollingListBox"
require "OptionScreens/ModSelector/ModSelector"

ModSelector.MapOrderListBox = ISScrollingListBox:derive("MapOrderListBox")
local MapOrderListBox = ModSelector.MapOrderListBox

function MapOrderListBox:new(x, y, width, height)
    local o = ISScrollingListBox:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.backgroundColor = {r=0, g=0, b=0, a=0.3}
    o.borderColor = {r=1, g=1, b=1, a=0.2}
    o.boxSize = 22
    o.dragTexture = getTexture("media/ui/dragModIcon.png")
    o.dragItem = nil
    return o
end


function MapOrderListBox:onMouseDown(x, y)
    if #self.items == 0 then return end
    local row = self:rowAt(x, y)
    local doSound = true
    if row > #self.items then
        row = #self.items
        doSound = false
    end
    if row < 1 then
        row = 1
        doSound = false
    end
    if doSound then
        getSoundManager():playUISound("UISelectListItem")
    end
    if self.mouseOverDragIcon then
        self.dragItem = self.items[row]
    end
end

function MapOrderListBox:onMouseUp(x, y)
    ISScrollingListBox.onMouseUp(self, x, y)
    if self.dragItem ~= nil then
        local row = self:rowAt(x, y)
        if row <= #self.items and row >= 1 then
            local temp = {}
            for i,v in ipairs(self.items) do
                if i == row then
                    table.insert(temp, self.dragItem)
                end
                if v ~= self.dragItem then
                    table.insert(temp, v)
                end
            end
            self.items = temp
        end
        local tx = (#self.items)*self.dragItem.height
        if row == -1 and y > tx and y < tx + 100 then
            local temp = {}
            for i,v in ipairs(self.items) do
                if v ~= self.dragItem then
                    table.insert(temp, v)
                end
            end
            table.insert(temp, self.dragItem)
            self.items = temp
        end
    end
    self.dragItem = nil
end

function MapOrderListBox:onMouseUpOutside(x, y)
    ISScrollingListBox.onMouseUpOutside(self, x, y)
    self.dragItem = nil
end

function MapOrderListBox:prerender()
    self.mouseOverDragIcon = nil
    ISScrollingListBox.prerender(self)
end

function MapOrderListBox:render()
    ISScrollingListBox.render(self)
    local item = self.dragItem
    local x = self:getMouseX()
    local y = self:getMouseY()

    if item ~= nil then
        local y0 = 0
        for _, v in ipairs(self.items) do
            if not v.height then v.height = self.itemheight end
            if y >= y0 and y < y0 + v.height/2 and v ~= item then
                self:drawRect(0, y0 - v.height/8, self:getWidth(), v.height/4, 0.5, 1, 1, 1)
                break
            end
            y0 = y0 + v.height
        end
        if y >= y0 and y < y0 + item.height/2 then
            self:drawRect(0, y0 - item.height/8, self:getWidth(), item.height/4, 0.5, 1, 1, 1)
        end

        y = y - item.height/2

        self:drawRect(0, (y), self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15)
        self:drawRectBorder(0, (y), self:getWidth(), item.height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b)

        local shift = (item.height - self.boxSize)/2
        self:drawTexture(self.dragTexture, shift, shift + y, 1, 1, 1, 1)

        local itemPadY = self.itemPadY or (item.height - self.fontHgt) / 2
        self:drawText(item.item, item.height + 16, (y)+itemPadY, 0.9, 0.9, 0.9, 0.9, self.font)
    end
end

function MapOrderListBox:doDrawItem(y, item, alt)
    local isMouseOver = self.mouseoverselected == item.index

    if self.parent.joyfocus ~= nil and self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15)
    end

    if self.dragItem == item then
        self:drawRect(0, (y), self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15)
    end
    self:drawRectBorder(0, (y), self:getWidth(), item.height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b)

    local shift = (item.height - self.boxSize)/2
    self:drawTexture(self.dragTexture, shift, shift + y, 1, 1, 1, 1)
    if isMouseOver and ((self:getMouseX() > shift) and (self:getMouseX() < self.boxSize + shift) and (self:getMouseY() > shift + y) and (self:getMouseY() < shift + y + self.boxSize)) then
        self.mouseOverDragIcon = item
    end

    local itemPadY = self.itemPadY or (item.height - self.fontHgt) / 2
    self:drawText(item.item, item.height + 16, (y)+itemPadY, item.color.r, item.color.g, item.color.b, 0.9, self.font)

    y = y + item.height
    return y
end


function MapOrderListBox.tooltipRender(self)
    self:setX(self.xRender)
    self:setY(self.yRender)

    if self.contextMenu and self.contextMenu.joyfocus then
        local playerNum = self.contextMenu.player
        self:setX(getPlayerScreenLeft(playerNum) + 60);
        self:setY(getPlayerScreenTop(playerNum) + 60);
    elseif self.contextMenu and self.contextMenu.currentOptionRect then
        if self.contextMenu.currentOptionRect.height > 32 then
            self:setY(my + self.contextMenu.currentOptionRect.height)
        end
        self:adjustPositionToAvoidOverlap(self.contextMenu.currentOptionRect)
    elseif self.owner and self.owner.isButton then
        local ownerRect = { x = self.owner:getAbsoluteX(), y = self.owner:getAbsoluteY(), width = self.owner.width, height = self.owner.height }
        self:adjustPositionToAvoidOverlap(ownerRect)
    end

    -- big rectangle (our background)
    self:drawRect(0, 0, self.width, self.height, 0.7, 0.05, 0.05, 0.05)
    self:drawRectBorder(0, 0, self.width, self.height, 0.5, 0.9, 0.9, 1)

    -- render texture
    if self.texture then
        local widthTexture = self.texture:getWidth()
        local heightTexture = self.texture:getHeight()
        local textureY = self.name and 35 or 5
        self:drawTextureScaled(self.texture, 8, textureY, widthTexture, heightTexture, 1, 1, 1, 1)
    end

    -- render name
    if self.name then
        self:drawText(self.name, 8, 5, 1, 1, 1, 1, UIFont.Medium)
    end

    self:renderContents()

    -- render a how to rotate message at the bottom if needed
    if self.footNote then
        local fontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
        self:drawTextCentre(self.footNote, self:getWidth() / 2, self:getHeight() - fontHgt - 4, 1, 1, 1, 1, UIFont.Small)
    end
end

function MapOrderListBox:updateTooltip()
    if self.parent.joyfocus then
        if self.items[self.selected] and self.items[self.selected].tooltip then
            local text = self.items[self.selected].tooltip
            if not self.tooltipUI then
                self.tooltipUI = ISToolTip:new()
                self.tooltipUI:setOwner(self)
                self.tooltipUI:setVisible(false)
                self.tooltipUI:setAlwaysOnTop(true)
                self.tooltipUI.render = self.tooltipRender
                self.tooltipUI.maxLineWidth = 1000 -- don't wrap the lines
            end
            if not self.tooltipUI:getIsVisible() then
                self.tooltipUI:addToUIManager()
                self.tooltipUI:setVisible(true)
            end
            self.tooltipUI.description = text

            self.tooltipUI.xRender = self.x + self.parent.x + 23 + 400
            local y0 = 0
            for i,v in ipairs(self.items) do
                if i == self.selected then
                    self.tooltipUI.yRender = self.y + y0 + v.height/2 + 23 + 80
                end
                y0 = y0 + v.height
            end
        else
            if self.tooltipUI and self.tooltipUI:getIsVisible() then
                self.tooltipUI:setVisible(false)
                self.tooltipUI:removeFromUIManager()
            end
        end
    else
        ISScrollingListBox.updateTooltip(self)
    end
end

function MapOrderListBox:moveItemUp()
    if self.selected <= 1 then return end

    local temp = self.items[self.selected]
    self.items[self.selected] = self.items[self.selected-1]
    self.items[self.selected-1] = temp
    self.selected = self.selected-1
end

function MapOrderListBox:moveItemDown()
    if self.selected == #self.items or self.selected == -1 then return end

    local temp = self.items[self.selected]
    self.items[self.selected] = self.items[self.selected+1]
    self.items[self.selected+1] = temp
    self.selected = self.selected+1
end