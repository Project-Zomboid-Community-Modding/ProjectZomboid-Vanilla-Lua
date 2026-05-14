SurvivalGuide = ISCollapsableWindowJoypad:derive("SurvivalGuide")

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.NewMedium)
local VIDEO_WIDTH = 960
local VIDEO_HEIGHT = 480
local MIN_LIST_WIDTH = 100
local UI_BORDER_SPACING = 2
local BTN_WIDTH = 100
local BTN_HEIGHT = 25
local DESCRIPTION_HEIGHT = 150
local BOTTOM_PANEL_HEIGHT = BTN_HEIGHT + UI_BORDER_SPACING * 2

function SurvivalGuide:RestoreLayout(name, layout)
	if not getCore():getOptionShowSurvivalGuide() then
		self:setVisible(false)
	end

    self.showGuideTickBox:setSelected(1, getCore():getOptionShowSurvivalGuide())
end

function SurvivalGuide:SaveLayout(name, layout)
    if self.panel then
        if getCore():getOptionShowSurvivalGuide() then
            layout.visible = 'true'
        else
            layout.visible = 'false'
        end
        ISLayoutManager.SaveWindowVisible(self.panel, layout)
    end
end

function SurvivalGuide:initialise()
    ISCollapsableWindowJoypad.initialise(self)
end

function SurvivalGuide:createChildren()
    ISCollapsableWindowJoypad.createChildren(self)

    self.listBox = ISScrollingListBox:new(0, self:titleBarHeight(), MIN_LIST_WIDTH, self.height - self:titleBarHeight() - BOTTOM_PANEL_HEIGHT)
    self.listBox:initialise()
    self.listBox:instantiate()
    self.listBox:setAnchorsTBLR(true, true, true, false)
    self.listBox.itemheight = FONT_HGT_SMALL + 2
    self.listBox.drawBorder = true
    self.listBox.backgroundColor = {r=0, g=0, b=0, a=0.5}
    self.listBox.font = UIFont.NewSmall
    self.listBox.doDrawItem = SurvivalGuide.doDrawItem
    self.listBox:setOnMouseDownFunction(self, SurvivalGuide.onClickList)
    self.listBox:setOverrideAButtonFunction(self, SurvivalGuide.onClose)
    self:addChild(self.listBox)

    self.videoRichText = ISRichTextPanel:new(self.listBox:getRight(), self.listBox:getY(), VIDEO_WIDTH, VIDEO_HEIGHT)
    self.videoRichText:initialise()
    self.videoRichText:setAnchorsTBLR(true, false, true, false)
    self.videoRichText.autosetheight = false
    self.videoRichText.clip = true
    self.videoRichText:setMargins(0, 0, 0, 0)
    self.videoRichText.blockMouseWheel = true
    self:addChild(self.videoRichText)

    self.descriptionRichText = ISRichTextPanel:new(self.listBox:getRight(), self.videoRichText:getBottom(), self.videoRichText:getWidth(), self.listBox:getHeight() - self.videoRichText:getHeight())
    self.descriptionRichText:initialise()
    self.descriptionRichText:setAnchorsTBLR(false, true, true, false)
    self.descriptionRichText.autosetheight = false
    self.descriptionRichText:setMargins(10, 10, 10, 0)
    self:addChild(self.descriptionRichText)

    local textWid = getTextManager():MeasureStringX(UIFont.NewSmall, getText("IGUI_Tutorial_ShowGuide"))
    self.showGuideTickBox = ISTickBox:new(UI_BORDER_SPACING + 1, self.height - BTN_HEIGHT - 2, textWid + 30, BTN_HEIGHT, "", self, SurvivalGuide.onClickShowSurvivalGuide)
    self.showGuideTickBox:setAnchorsTBLR(false, true, true, false)
    self.showGuideTickBox:setFont(UIFont.NewSmall)
    self.showGuideTickBox:initialise()
    self.showGuideTickBox:addOption(getText("IGUI_Tutorial_ShowGuide"), nil)
    self.showGuideTickBox:setSelected(1, getCore():getOptionShowSurvivalGuide())
    self:addChild(self.showGuideTickBox)

    self.closeButton = ISButton:new(self:getWidth() - BTN_WIDTH - UI_BORDER_SPACING, self.height - BTN_HEIGHT - 2, BTN_WIDTH, BTN_HEIGHT, getText("UI_btn_close"), self, SurvivalGuide.onClose)
    self.closeButton:initialise()
    self.closeButton:instantiate()
    self.closeButton:setAnchorsTBLR(false, true, false, true)
    self.closeButton:setFont(UIFont.NewSmall)
    self.closeButton:ignoreWidthChange()
    self.closeButton:ignoreHeightChange()
    self.closeButton:enableCancelColor()
    self:addChild(self.closeButton)

    self:populateList()
    self:restorePosition()

    self.listBox.selected = 2
    self:onClickList()
end

function SurvivalGuide:onClose()
    self:setVisible(false)
end

function SurvivalGuide:setVisible(visible, joypadData)
    ISCollapsableWindowJoypad.setVisible(self, visible)
    setGameSpeed(visible and 0 or 1)
    local joypadData = JoypadState.players[1]
    if joypadData then
        joypadData.focus = visible and self or nil
        if visible then
            joypadData.activeWhilePaused = true
        else
            joypadData.focus = self.previousJoypadFocus
            self.previousJoypadFocus = nil
        end
        updateJoypadFocus(joypadData)
    end
end

function SurvivalGuide:onClickShowSurvivalGuide(index, selected)
    getCore():setOptionShowSurvivalGuide(selected)
    getCore():saveOptions()
    if not selected then
        local modal = ISModalDialog:new((getCore():getScreenWidth() / 2) - 150, (getCore():getScreenHeight() / 2) - 60, 300, 120, getText("IGUI_Tutorial_PressF1"), false, nil, nil, nil)
        modal:initialise()
        modal:addToUIManager()
    end
end

function SurvivalGuide:onClickList()
    self.selectedItem = self.listBox.items[self.listBox.selected].item

    local text = " <CENTRE> <SIZE:medium> " .. self.selectedItem.title
    if self.selectedItem.video then
        text = text .. string.format(" <VIDEOCENTRE:%s,%u,%u,%u,%u,%s> ", self.selectedItem.video, VIDEO_WIDTH, VIDEO_HEIGHT, VIDEO_WIDTH, VIDEO_HEIGHT, "")
    end
    if self.selectedItem.spiffo then
        text = text .. self.selectedItem.spiffo
    end
    self.videoRichText.text = text

    if self.selectedItem.description then
        self.descriptionRichText.text = " <SIZE:" .. (self.smallResolution and "small" or self.mediumResolution and "medium" or "large") .. "> " .. self.selectedItem.description
    else
        self.descriptionRichText.text = ""
    end

    self.descriptionRichText:paginate()
    self.videoRichText:paginate()
end

function SurvivalGuide:prerender()
    ISCollapsableWindowJoypad.prerender(self)
    self:drawRectBorder(0, self.listBox:getBottom(), self:getWidth(), self:getHeight() - self.listBox:getBottom(), 1, 1, 1, 1)
end

function SurvivalGuide:populateList()
    self.listBox:clear()
    if not self.smallResolution then
        self.listBox:setFont(UIFont.NewMedium)
        self.listBox.itemheight = FONT_HGT_MEDIUM
    end
    local entries = SurvivalGuideEntry.getAll()
    local listWidth = MIN_LIST_WIDTH
    for i = 0, entries:size() - 1 do
        local entry = entries:get(i)
        local name = getText(entry:getTitle())
        local title = name
        local subCategory = false
        if entry:getSubCategory() then
            subCategory = true
            name = "    " .. name
            local translatedKeyList = ArrayList.new()
            local keysList = entry:getKeys()
            if JoypadState.players[1] then
                keysList = entry:getJoypadKeys()
            end
            if keysList then
                for j = 0, keysList:size() - 1 do
                    translatedKeyList:add(self:getKeyName(keysList:get(j)))
                end
            end
            local text = getTextOrNull(entry:getDescription() .. "_joypad")
            if text and JoypadState.players[1] then
                text = entry:getDescription() .. "_joypad"
            else
                text = entry:getDescription()
            end
            if getText(text) ~= "<IGNORE>" then
                self.listBox:addItem(name, { title = title, description = getTextList(text, translatedKeyList), video = entry:getVideo(), subCategory = subCategory, id = entry:toString() })
            end
        else
            self.listBox:addItem(name, { title = title, spiffo = getText(entry:getDescription()), id = entry:toString(), category_image = getTextOrNull(entry:getCategoryImage()) })
        end
        local textWidth = getTextManager():MeasureStringX(subCategory and UIFont.NewSmall or UIFont.NewMedium, name) + 35
        if textWidth > listWidth then
            listWidth = textWidth
        end
    end
    self.listBox:setWidth(listWidth)
end

function SurvivalGuide:getKeyName(key)
    if string.contains(key, "IGUI_") then
        return getText(key)
    elseif not string.contains(key, "<JOYPAD") and not string.contains(key, "<IMAGE") then
        local keyTxt = getKeyName(getCore():getKey(key))
        local altKey = getCore():getAltKey(key)
        if altKey > 0 then
            keyTxt = keyTxt .. " " .. getText("ContextMenu_or") .. " " .. getKeyName(altKey)
        end
        return keyTxt
    end
    return key
end

function SurvivalGuide:doDrawItem(y, item, alt)
    self:drawRectBorder(0, y, self:getWidth(), self.itemheight - 1, 0.9, self.borderColor.r, self.borderColor.g, self.borderColor.b)

    if self.selected == item.index then
        self:drawRect(0, y, self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15)
    end

    local font = item.item.subCategory and UIFont.NewSmall or UIFont.NewMedium
    local textY = item.item.subCategory and y + 3 or y
    if item.item.category_image then
        self:drawText(item.text, 2 + self.itemheight, textY, 1, 1, 1, 0.9, font)
        self:drawTextureScaledAspect(getTexture(item.item.category_image), 2, y + 2, self.itemheight - 4, self.itemheight - 4, 0.8, 1, 1, 1)
    else
        self:drawText(item.text, 2, textY, 1, 1, 1, 0.9, font)
    end

    return y + self.itemheight
end

function createSurvivalGuide()
	if isServer() then
        return
    end

    SurvivalGuide.instance = SurvivalGuide:new()
    SurvivalGuide.instance:initialise()
    SurvivalGuide.instance:addToUIManager()

    if not getCore():getOptionShowSurvivalGuide() or (getCore():getGameMode() == "Tutorial" and SurvivalGuide.blockSurvivalGuide) or (isDemo() and ISDemoPopup.instance) then
        SurvivalGuide.instance:setVisible(false)
    end

    if JoypadState.players[1] then
        SurvivalGuide.instance:onGainJoypadFocus(JoypadState.players[1])
    end
end

function SurvivalGuide:restorePosition()
    self.smallResolution = getCore():getScreenWidth() <= 1600
    self.mediumResolution = getCore():getScreenWidth() <= 1920

    self:setWidth(self.listBox:getWidth() + VIDEO_WIDTH)
    self.videoRichText:setX(self.listBox:getRight())
    self.descriptionRichText:setX(self.listBox:getRight())
    self:setX(getCore():getScreenWidth() / 2 - self:getWidth() / 2)
    self:setY(getCore():getScreenHeight() / 2 - self:getHeight() / 2)
end

function SurvivalGuide:onGainJoypadFocus(joypadData)
    joypadData.activeWhilePaused = true
    self.listBox:setJoypadFocused(true, joypadData)
    self:setISButtonForA(self.closeButton)
    updateJoypadFocus(joypadData)
end

function SurvivalGuide:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self.listBox:unfocus()
    self:clearJoypadFocus(joypadData)
end

function SurvivalGuide.openEntry(entry)
    if not SurvivalGuide.instance then
        createSurvivalGuide()
    end
    self = SurvivalGuide.instance
    local joypadData = JoypadState.players[1]
    if joypadData then
        self.previousJoypadFocus = joypadData.focus
    end
    for index, option in ipairs(self.listBox.items) do
        if option.item.id == entry:toString() then
            self:setVisible(true)
            self.listBox.selected = index
            self:onClickList()
            self.listBox.smoothScrollY = self.listBox:getYScroll()
            self.listBox.smoothScrollTargetY = self.listBox.itemheight - index * self.listBox.itemheight
            return
        end
    end
    self:setVisible(true)
    self:bringToTop()
end

SurvivalGuide.onKeyPressed = function(key)
    if MainScreen.instance and MainScreen.instance:isVisible() then
        return
    end
	if getCore():isKey("Toggle Survival Guide", key) and not SurvivalGuide.blockSurvivalGuide then
		if not SurvivalGuide.instance then
			createSurvivalGuide()
        else
			local panel = SurvivalGuide.instance
            panel:populateList()
			panel:setVisible(not panel:getIsVisible())
            panel:restorePosition()
            panel.listBox.selected = 2
            panel.listBox.smoothScrollY = panel.listBox:getYScroll()
            panel.listBox.smoothScrollTargetY = 0
            panel:onClickList()
		end
	end
end

function SurvivalGuide:onKeyRelease(key)
    if Keyboard.KEY_ESCAPE == key and SurvivalGuide.instance then
        SurvivalGuide.instance:setVisible(false)
    end
end

function SurvivalGuide:isKeyConsumed(key)
    return key == Keyboard.KEY_ESCAPE
end

function SurvivalGuide:new()
    local o = ISCollapsableWindowJoypad.new(self, 0, 0, 0, VIDEO_HEIGHT + BOTTOM_PANEL_HEIGHT + DESCRIPTION_HEIGHT)
    o.resizable = false
    o.title = getText("SurvivalGuide_WindowTitle")
    o:setWantKeyEvents(true)
    o.smallResolution = false
    o.mediumResolution = false
    setmetatable(o, self)
    self.__index = self
    return o
end

SurvivalGuide.OnGameStart = function()
	createSurvivalGuide()
	if SurvivalGuide.instance:isVisible() then
	    setGameSpeed(0)
    end
end

Events.OnGameStart.Add(SurvivalGuide.OnGameStart)
Events.OnKeyPressed.Add(SurvivalGuide.onKeyPressed)
