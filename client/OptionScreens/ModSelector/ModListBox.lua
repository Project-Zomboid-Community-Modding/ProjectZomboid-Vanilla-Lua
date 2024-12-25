--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISScrollingListBox"
require "OptionScreens/ModSelector/ModSelector"

ModSelector.ModListBox = ISScrollingListBox:derive("ModListBox")
local ModListBox = ModSelector.ModListBox

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local UI_BORDER_SPACING = 10
local GHC = getCore():getGoodHighlitedColor()
local BHC = getCore():getBadHighlitedColor()

function ModListBox:new(x, y, width, height, model)
    local o = ISScrollingListBox:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.backgroundColor = {r=0, g=0, b=0, a=0.3}
    o.borderColor = {r=1, g=1, b=1, a=0.2}
    o.boxSize = BUTTON_HGT
    o.tickTexture = getTexture("media/ui/inventoryPanes/Tickbox_Tick.png")
    o.cantTexture = getTexture("media/ui/inventoryPanes/Tickbox_Cross.png")
    o.starUnsetTexture = getTexture("media/ui/inventoryPanes/FavouriteNo.png")
    o.starSetTexture = getTexture("media/ui/inventoryPanes/FavouriteYes.png")
    o.joypadStarButtonTex = Joypad.Texture.XButton
    o.model = model
    return o
end

function ModListBox:sort()
    table.sort(self.items, function(a, b)
        return not string.sort(a.item.name, b.item.name)
    end)
end

function ModListBox:enableTickMod()
    self.model:forceActivateMods(self.mouseOverTickBox.item.modInfo, not self.mouseOverTickBox.item.isActive)
end

function ModListBox:onMouseDown(x, y)
    if #self.items == 0 then return end
    local row = self:rowAt(x, y)
    if row == -1 then return end

    getSoundManager():playUISound("UISelectListItem")
    if self.mouseOverTickBox then
        if self.mouseOverTickBox.item.modInfo:getId() == "ModTemplate" and not self.mouseOverTickBox.item.isActive then
            local w = 300
            local h = 100
            local modal = ISModalDialog:new(getCore():getScreenWidth()/2 - w/2, getCore():getScreenHeight() / 2 - h/2, w, h, getText("UI_modselector_modTemplateWarn"), true, nil, function(_, button, mInfo, m)
                if button.internal == "YES" then
                    m:forceActivateMods(mInfo, true)
                end
            end, nil, self.mouseOverTickBox.item.modInfo, self.model)
            modal:initialise()
            modal:addToUIManager()
            modal:bringToTop()
        else
            self.model:forceActivateMods(self.mouseOverTickBox.item.modInfo, not self.mouseOverTickBox.item.isActive)
        end
    else
        if self.mouseOverFavoriteButton then
            self.model:setFavorite(self.mouseOverFavoriteButton.item.modId, not self.mouseOverFavoriteButton.item.favorite)
        else
            self.selected = row
            self.parent.parent.modInfoPanel:updateView(self.items[row].item.modInfo)
        end
    end
end

function ModListBox:getSelectedModData()
    for i, v in ipairs(self.items) do
        if i == self.selected then
            return v.item
        end
    end
end

function ModListBox:prerender()
    if self.items == nil then
        return
    end

    self.mouseOverTickBox = nil
    self.mouseOverFavoriteButton = nil
    local stencilX = 0
    local stencilY = 0
    local stencilX2 = self.width
    local stencilY2 = self.height

    self:drawRect(0, -self:getYScroll(), self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    if self.drawBorder then
        self:drawRectBorder(0, -self:getYScroll(), self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
        stencilX = 1
        stencilY = 1
        stencilX2 = self.width - 1
        stencilY2 = self.height - 1
    end

    if self:isVScrollBarVisible() then
        stencilX2 = self.vscroll.x + 3 -- +3 because the scrollbar texture is narrower than the scrollbar width
    end

    -- This is to handle this listbox being inside a scrolling parent.
    if self.parent and self.parent:getScrollChildren() then
        stencilX = self.javaObject:clampToParentX(self:getAbsoluteX() + stencilX) - self:getAbsoluteX()
        stencilX2 = self.javaObject:clampToParentX(self:getAbsoluteX() + stencilX2) - self:getAbsoluteX()
        stencilY = self.javaObject:clampToParentY(self:getAbsoluteY() + stencilY) - self:getAbsoluteY()
        stencilY2 = self.javaObject:clampToParentY(self:getAbsoluteY() + stencilY2) - self:getAbsoluteY()
    end
    self:setStencilRect(stencilX, stencilY, stencilX2 - stencilX, stencilY2 - stencilY)

    local y = 0;
    local alt = false;

    if self.selected ~= -1 and self.selected > #self.items then
        self.selected = #self.items
    end

    local altBg = self.altBgColor

    self.listHeight = 0;
    local i = 1;
    for k, v in ipairs(self.items) do
        if not v.height then v.height = self.itemheight end -- compatibililty

        if alt and altBg then
            self:drawRect(0, y, self:getWidth(), v.height-1, altBg.r, altBg.g, altBg.b, altBg.a);
        else

        end
        v.index = i;
        local y2 = self:doDrawItem(y, v, alt);
        self.listHeight = y2;
        v.height = y2 - y
        y = y2

        alt = not alt;
        i = i + 1;
    end

    self:setScrollHeight(y);
    self:clearStencilRect();
    if self.doRepaintStencil then
        self:repaintStencilRect(stencilX, stencilY, stencilX2 - stencilX, stencilY2 - stencilY)
    end

    local mouseY = self:getMouseY()
    self:updateSmoothScrolling()
    if mouseY ~= self:getMouseY() and self:isMouseOver() then
        self:onMouseMove(0, self:getMouseY() - mouseY)
    end
    self:updateTooltip()

    if #self.columns > 0 then
        self:drawRectBorderStatic(0, 0 - self.itemheight, self.width, self.itemheight - 1, 1, self.borderColor.r, self.borderColor.g, self.borderColor.b);
        self:drawRectStatic(0, 0 - self.itemheight - 1, self.width, self.itemheight-2,self.listHeaderColor.a,self.listHeaderColor.r, self.listHeaderColor.g, self.listHeaderColor.b);
        local dyText = (self.itemheight - FONT_HGT_SMALL) / 2
        for _, v in ipairs(self.columns) do
            self:drawRectStatic(v.size, 0 - self.itemheight, 1, self.itemheight + math.min(self.height, self.itemheight * #self.items - 1), 1, self.borderColor.r, self.borderColor.g, self.borderColor.b);
            if v.name then
                self:drawText(v.name, v.size + 10, 0 - self.itemheight - 1 + dyText - self:getYScroll(), 1,1,1,1,UIFont.Small);
            end
        end
    end
end

function ModListBox:doDrawItem(y, item, alt)
    local isMouseOver = self.mouseoverselected == item.index
    local height = UI_BORDER_SPACING*2 + BUTTON_HGT + 2

    if self.selected == item.index then
        self:drawRect(0, y, self:getWidth(), height, 0.3, 0.7, 0.35, 0.15)

        if self.parent.joyfocus ~= nil and self.parent.joypadListFocus then
            self:drawTextureScaled(self.joypadStarButtonTex, self:getWidth() - 48 - 40, 8 + y, 24, 24, 1, 1, 1, 1)
        end
    end
    self:drawRectBorder(0, y, self:getWidth(), height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    self:drawRectBorder(height-1, y, 1, height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b)

    local shift = (height - self.boxSize)/2
    self:drawRectBorder(shift, shift + y, self.boxSize, self.boxSize, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    if isMouseOver and ((self:getMouseX() > shift) and (self:getMouseX() < self.boxSize + shift) and (self:getMouseY() > shift + y) and (self:getMouseY() < shift + y + self.boxSize)) then
        self.mouseOverTickBox = item
    end

    if item.item.isActive then
        self:drawTextureScaled(self.tickTexture, shift + 2, shift + 2 + y, self.boxSize-4, self.boxSize-4, 1, GHC:getR(), GHC:getG(), GHC:getB())
    else
        if not item.item.isAvailable then
            self:drawTextureScaled(self.cantTexture, shift + 2, shift + 2 + y, self.boxSize-4, self.boxSize-4, 1, BHC:getR(), BHC:getG(), BHC:getB())
        end
    end

    if item.item.icon ~= "" then
        self:drawTextureScaled(getTexture(item.item.icon), height + UI_BORDER_SPACING, y + (height - BUTTON_HGT) / 2, BUTTON_HGT, BUTTON_HGT, 1, 1, 1, 1)
    else
        self:drawTextureScaled(Texture.getWhite(), height + UI_BORDER_SPACING, y + (height - BUTTON_HGT) / 2, BUTTON_HGT, BUTTON_HGT, 0.1, 1, 1, 1)
    end

    local itemPadY = (height - self.fontHgt) / 2

    if item.item.isAvailable then
        if item.item.isActive then
            self:drawText(item.item.name, height*2, y+itemPadY, GHC:getR(), GHC:getG(), GHC:getB(), 0.9, self.font)
        else
            if not item.item.isIncompatible then
                self:drawText(item.item.name, height*2, y+itemPadY, 0.9, 0.9, 0.9, 0.9, self.font)
            else
                self:drawText(item.item.name, height*2, y+itemPadY, 0.9, 0.45, 0.0, 0.9, self.font)
                item.tooltip = getText("UI_modselector_incompatibleWith")
                for v, _ in pairs(item.item.incompatibleWith) do
                    item.tooltip = item.tooltip .. "\n" .. v
                end
            end
        end
    else
        self:drawText(item.item.name, height*2, y+itemPadY, BHC:getR(), BHC:getG(), BHC:getB(), 0.9, self.font)
    end

    if item.item.favorite then
        self:drawTextureScaled(self.starSetTexture, self:getWidth() - UI_BORDER_SPACING-BUTTON_HGT-1, y + UI_BORDER_SPACING+1, BUTTON_HGT, BUTTON_HGT, 1, 1, 1, 1)
    else
        self:drawTextureScaled(self.starUnsetTexture, self:getWidth() - UI_BORDER_SPACING-BUTTON_HGT-1, y + UI_BORDER_SPACING+1, BUTTON_HGT, BUTTON_HGT, 1, 1, 1, 1)
    end

    if isMouseOver and (
            (self:getMouseX() > self:getWidth() - UI_BORDER_SPACING-BUTTON_HGT-1) and
            (self:getMouseX() < self:getWidth() - UI_BORDER_SPACING-1) and
            (self:getMouseY() > UI_BORDER_SPACING + y + 1) and
            (self:getMouseY() < UI_BORDER_SPACING + y + 1 + BUTTON_HGT)) then
        self.mouseOverFavoriteButton = item
    end

    y = y + height
    return y
end


function ModListBox:setJoypadFocused(focused, joypadData)
    if focused then
        if self.selected == -1 then
            self.selected = 1;
            if self.resetSelectionOnChangeFocus then
                if self.items[self.selectedBeforeReset] then
                    self.selected = self.selectedBeforeReset
                end
                self.selectedBeforeReset = nil
            end
            if self.onmousedown and self.items[self.selected] then
                self.onmousedown(self.target, self.items[self.selected].item);
            end
        end
    end
    self.joypadFocused = focused;
end


function ModListBox:onJoypadDown(button, joypadData)
    if button == Joypad.AButton then
        if (#self.items > 0) and (self.selected ~= -1) then
            self.model:forceActivateMods(self.items[self.selected].item.modInfo, not self.items[self.selected].item.isActive)
        end
    elseif button == Joypad.XButton then
        if (#self.items > 0) and (self.selected ~= -1) then
            self.model:setFavorite(self.items[self.selected].item.modId, not self.items[self.selected].item.favorite)
        end
    else
        ISPanelJoypad.onJoypadDown(self, button);
    end
end