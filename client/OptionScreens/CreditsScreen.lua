local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local UI_MARGIN = 30
local UI_MARGIN_RIGHT = UI_MARGIN
local UI_MARGIN_RIGHT_JOYPAD = 70
local AUTO_SCROLL_SPEED_NORMAL = 1
local AUTO_SCROLL_SPEED_FAST = 3
local AUTO_SCROLL_SPEED_PAUSE = 0
local AUTO_SCROLL_SPEED_REWIND = -1
local BTN_HEIGHT = 25
local BTN_PAUSE_WIDTH = 100

CreditsScreen = ISPanelJoypad:derive("CreditsScreen")

function CreditsScreen:create()
    self.richText = ISRichTextPanel:new(0, 0, self:getWidth(), self:getHeight())
    self.richText:initialise()
    self.richText.autosetheight = false
    self.richText:setMargins(0, 0, 0, 0)
    self.richText:setText(self:doCreditsText())
    self.richText:paginate()
    self.richText:setOnMouseDownFunction(self, self.onMouseDown)
    self.richText:setOnMouseUpFunction(self, self.onMouseUp)
    self.richText.blockMouseWheel = true
    self:addChild(self.richText)

    self.speedButton = ISButton:new(self:getWidth() - UI_MARGIN_RIGHT, self:getHeight() - UI_MARGIN, BTN_HEIGHT, BTN_HEIGHT, ">", self, CreditsScreen.changeSpeed)
    self.speedButton:initialise()
    self.speedButton.speed = AUTO_SCROLL_SPEED_NORMAL
    self.speedButton:setAnchorsTBLR(false, true, false, true)
    self:addChild(self.speedButton)

    self.pauseButton = ISButton:new(self.speedButton:getX() - 5 - BTN_PAUSE_WIDTH, self.speedButton:getY(), BTN_PAUSE_WIDTH, BTN_HEIGHT, getText("UI_Pause"), self, CreditsScreen.pause)
    self.pauseButton:initialise()
    self.pauseButton:setAnchorsTBLR(false, true, false, true)
    self:addChild(self.pauseButton)

    self.richTextQuit = ISRichTextPanel:new(self.speedButton:getRight() - self.escapeTextWidth, self.speedButton:getY() - FONT_HGT_SMALL - 5, self.escapeTextWidth + 10, FONT_HGT_SMALL + 2)
    self.richTextQuit:initialise()
    self.richTextQuit.autosetheight = false
    self.richTextQuit:setMargins(0, 0, 0, 0)
    self.richTextQuit:setAnchorsTBLR(false, true, false, true)
    self.richTextQuit:setText(self.escapeText)
    self.richTextQuit:paginate()
    self.richText.blockMouseWheel = true
    self:addChild(self.richTextQuit)

    self:setVisible(false)
end

function CreditsScreen:changeSpeed()
    if self.speedButton.speed == AUTO_SCROLL_SPEED_NORMAL then
        self:updateAutoScroll(AUTO_SCROLL_SPEED_FAST)
    elseif self.speedButton.speed == AUTO_SCROLL_SPEED_FAST then
        self:updateAutoScroll(AUTO_SCROLL_SPEED_REWIND)
    elseif self.speedButton.speed == AUTO_SCROLL_SPEED_REWIND then
        self:updateAutoScroll(AUTO_SCROLL_SPEED_NORMAL)
    end
    self.speedButton.speed = self.richText.autoScrollSpeed
    self:updateButtonTitles()
end

function CreditsScreen:pause()
    if self.richText.autoScrollSpeed == AUTO_SCROLL_SPEED_PAUSE then
        self:updateAutoScroll(self.speedButton.speed)
    else
        self:updateAutoScroll(AUTO_SCROLL_SPEED_PAUSE)
    end
    self:updateButtonTitles()
end

function CreditsScreen:updateButtonTitles()
    if self.richText.autoScrollSpeed == AUTO_SCROLL_SPEED_PAUSE then
        self.pauseButton:setTitle(getText("UI_Resume"))
    else
        self.pauseButton:setTitle(getText("UI_Pause"))
    end
    if self.richText.autoScrollSpeed == AUTO_SCROLL_SPEED_NORMAL then
        self.speedButton:setTitle(">")
    elseif self.richText.autoScrollSpeed == AUTO_SCROLL_SPEED_FAST then
        self.speedButton:setTitle(">>")
    elseif self.richText.autoScrollSpeed == AUTO_SCROLL_SPEED_REWIND then
        self.speedButton:setTitle("<")
    end
end

function CreditsScreen:updateAutoScroll(speed)
    self.richText.autoScrollSpeed = speed
end

function CreditsScreen:setVisible(visible, joypadData)
    ISPanelJoypad.setVisible(self, visible, joypadData)

    self:recalcButtonPosition(joypadData)

    if not visible then
        MainScreen.instance.bottomPanel:setVisible(true)
        self:updateAutoScroll(AUTO_SCROLL_SPEED_PAUSE)
    else
        self.richText:setYScroll(0)
    end

    self.fadeIn = visible
    self.currentAlpha = 0
end

function CreditsScreen:onJoypadDown(button, joypadData)
    if button == Joypad.AButton then
        self:setVisible(false, joypadData)
        self:clearJoypadFocus(joypadData)
        joypadData.focus = MainScreen.instance
        updateJoypadFocus(joypadData)
    elseif button == Joypad.XButton then
        self:changeSpeed()
    elseif button == Joypad.YButton then
        self:pause()
    end
end

function CreditsScreen:onGainJoypadFocus(joypadData)
    self:setISButtonForX(self.speedButton)
    self:setISButtonForY(self.pauseButton)

    self:recalcButtonPosition(joypadData)
end

function CreditsScreen:recalcButtonPosition(joypadData)
    local margin = UI_MARGIN
    if joypadData then
        self.escapeText = getText("UI_mainscreen_credits_escape_joypad", Keyboard.getKeyName(Keyboard.KEY_ESCAPE))
        self.escapeTextWidth = getTextManager():MeasureStringX(UIFont.NewSmall, self.escapeText)
        margin = UI_MARGIN_RIGHT_JOYPAD
    else
        self.escapeText = getText("UI_mainscreen_credits_escape", Keyboard.getKeyName(Keyboard.KEY_ESCAPE))
        self.escapeTextWidth = getTextManager():MeasureStringX(UIFont.NewSmall, self.escapeText)
    end

    self.richTextQuit:setText(self.escapeText)
    self.richTextQuit:paginate()

    self.speedButton:setX(self:getWidth() - margin)
    self.pauseButton:setX(self.speedButton:getX() - 5 - BTN_PAUSE_WIDTH)

    if joypadData then
        self.richTextQuit:setX(self.pauseButton:getX() - self.richTextQuit:getWidth() - 5)
        self.richTextQuit:setY(self.speedButton:getY() + 5)
    else
        self.richTextQuit:setX(self.speedButton:getRight() - self.escapeTextWidth)
        self.richTextQuit:setY(self.speedButton:getY() - FONT_HGT_SMALL - 5)
    end
end

function CreditsScreen:doCreditsText()
    local text = getText("credits_start")

    local roleGroupHeader = " <LINE> <LINE> <LINE> <LINE> <LINE> <LINE> <SIZE:credits2> "
    local roleHeader = " <LINE> <LINE> <SIZE:credits1> "
    local nameHeader = " <SIZE:medium> "
    local nameSeparator = " <LINE> "
    local logo = " <LINE> <LINE> <IMAGECENTRE:%s> "

    local allRoleGroup = CreditsRoleGroup.getAll()

    for i = 0, allRoleGroup:size() - 1 do
        local roleGroup = allRoleGroup:get(i)
        text = text .. roleGroupHeader .. getText(roleGroup:getTitle())
        if roleGroup:getLogo() then
            text = text .. string.format(logo, roleGroup:getLogo())
        end
        local allRoles = roleGroup:getRoles()
        for j = 0, allRoles:size() - 1 do
            local role = allRoles:get(j)
            text = text .. (getText(role:getTitle()) ~= "" and roleHeader or nameSeparator) .. getText(role:getTitle()) .. nameHeader
            local allNames = role:getNames()
            for k = 0, allNames:size() - 1 do
                local name = allNames:get(k)
                text = text .. nameSeparator .. name:getName()
            end
        end
    end

    text = text .. string.rep(nameSeparator, 5)

    return text
end

function CreditsScreen:addToMap(key, searchKey, map, name)
    if luautils.stringStarts(key, searchKey) then
        table.insert(map, name)
    end
end

function CreditsScreen:doCreditTable(title, creditTable)
    local text = getText(title)
    for _, name in ipairs(creditTable) do
        text = text .. name
    end
    return text
end

function CreditsScreen:prerender()
    ISPanelJoypad.prerender(self)

    if self.fadeIn then
        self.currentAlpha = self.currentAlpha + 0.01
        self.richText.backgroundColor.a = self.currentAlpha
        self.richText.contentTransparency = self.currentAlpha
        self.richTextQuit.backgroundColor.a = self.currentAlpha
        self.richTextQuit.contentTransparency = self.currentAlpha
        self.pauseButton.borderColor.a = self.currentAlpha
        self.pauseButton.textColor.a = self.currentAlpha
        self.speedButton.borderColor.a = self.currentAlpha
        self.speedButton.textColor.a = self.currentAlpha
        if self.currentAlpha >= 1 then
            self.currentAlpha = 1
            self.fadeIn = false
            self:updateAutoScroll(AUTO_SCROLL_SPEED_NORMAL)
        end
    end

    self:drawRectStatic(0, 0, self.width, self.height, self.currentAlpha, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
end

function CreditsScreen:render()
    ISPanelJoypad.render(self)
end

function CreditsScreen:onResolutionChange()
    if self.richText ~= null then
        self.richText:setWidth(self:getWidth())
        self.richText:setHeight(self:getHeight())
    end
end

function CreditsScreen:new(x, y, width, height)
    local o = ISPanelJoypad.new(self, x, y, width, height)
    o.backgroundColor = {r=0, g=0, b=0, a=1}
    o:noBackground()
    o.borderColor = {r=1, g=1, b=1, a=0.2}
    o.currentAlpha = 0
    o.escapeText = getText("UI_mainscreen_credits_escape", Keyboard.getKeyName(Keyboard.KEY_ESCAPE))
    o.escapeTextWidth = getTextManager():MeasureStringX(UIFont.NewSmall, o.escapeText)
    CreditsScreen.instance = o
    return o
end

CreditsScreen.onKeyPressed = function(key)
    if key == Keyboard.KEY_ESCAPE and CreditsScreen.instance and CreditsScreen.instance:isReallyVisible() then
        CreditsScreen.instance:setVisible(false)
    end
end

Events.OnKeyPressed.Add(CreditsScreen.onKeyPressed)
