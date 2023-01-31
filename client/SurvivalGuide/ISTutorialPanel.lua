require "ISUI/ISButton"
require "ISUI/ISPanel"
require "ISUI/ISRichTextPanel"
require "ISUI/ISScrollingListBox"

ISTutorialPanel = ISCollapsableWindowJoypad:derive("ISTutorialPanel");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

-----

ISSurvivalGuideListBox = ISScrollingListBox:derive("ISSurvivalGuideListBox")

function ISSurvivalGuideListBox:doDrawItem(y, item, alt)
	if not item.height then item.height = self.itemheight end
	if self.selected == item.index then
		self:drawRect(0, y, self:getWidth(), item.height-1, 0.3, 0.7, 0.35, 0.15)
	end
	self:drawRectBorder(0, y, self:getWidth(), item.height, 0.5, self.borderColor.r, self.borderColor.g, self.borderColor.b)
	local itemPadY = self.itemPadY or (item.height - self.fontHgt) / 2
	self:drawText(item.text, 6, y + itemPadY, 0.9, 0.9, 0.9, 0.9, self.font)
	y = y + item.height
	return y
end

function ISSurvivalGuideListBox:onGainJoypadFocus(joypadData)
	ISScrollingListBox.onGainJoypadFocus(self, joypadData)
--	self.joypadFocused = true
end

function ISSurvivalGuideListBox:onLoseJoypadFocus(joypadData)
	ISScrollingListBox.onLoseJoypadFocus(self, joypadData)
--	self.joypadFocused = false
end

function ISSurvivalGuideListBox:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
		self.parent.parent:close()
	end
end

function ISSurvivalGuideListBox:onJoypadDirRight(joypadData)
	joypadData.focus = self.parent.parent.centerText
end

function ISSurvivalGuideListBox:new(x, y, width, height)
	local o = ISScrollingListBox.new(self, x, y, width, height)
	return o
end

-----

ISSurvivalGuideRichText = ISRichTextPanel:derive("ISSurvivalGuideRichText")

function ISSurvivalGuideRichText:prerender()
	self:doRightJoystickScrolling(20, 20)
	self:updateSmoothScrolling()
	ISRichTextPanel.prerender(self)
end

function ISSurvivalGuideRichText:onMouseWheel(del)
	self.yScrollDelta = 50
	local yScroll = self.smoothScrollTargetY or self:getYScroll()
	local topRow = math.floor(-yScroll / self.yScrollDelta) + 1
	if not self.smoothScrollTargetY then self.smoothScrollY = self:getYScroll() end
	local y = (topRow - 1) * self.yScrollDelta
	if del < 0 then
		if yScroll == -y and topRow > 1 then
			local prev = topRow - 1
			y = (prev - 1) * self.yScrollDelta
		end
		self.smoothScrollTargetY = -y
	else
		self.smoothScrollTargetY = -(y + self.yScrollDelta)
	end
    return true
end

ISSurvivalGuideRichText.doRightJoystickScrolling = ISPanelJoypad.doRightJoystickScrolling

function ISSurvivalGuideRichText:updateSmoothScrolling()
	if not self.smoothScrollTargetY then return end
	local dy = self.smoothScrollTargetY - self.smoothScrollY
	local maxYScroll = self:getScrollHeight() - self:getHeight()
	local frameRateFrac = UIManager.getMillisSinceLastRender() / 33.3
	local itemHeightFrac = 160 / self.yScrollDelta
	local targetY = self.smoothScrollY + dy * math.min(0.5, 0.25 * frameRateFrac * itemHeightFrac)
	if frameRateFrac > 1 then
		targetY = self.smoothScrollY + dy * math.min(1.0, math.min(0.5, 0.25 * frameRateFrac * itemHeightFrac) * frameRateFrac)
	end
	if targetY > 0 then targetY = 0 end
	if targetY < -maxYScroll then targetY = -maxYScroll end
	if math.abs(targetY - self.smoothScrollY) > 0.1 then
		self:setYScroll(targetY)
		self.smoothScrollY = targetY
	else
		self:setYScroll(self.smoothScrollTargetY)
		self.smoothScrollTargetY = nil
		self.smoothScrollY = nil
	end
end

function ISSurvivalGuideRichText:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
		self.parent.parent:close()
	end
end

function ISSurvivalGuideRichText:onJoypadDirLeft(joypadData)
	joypadData.focus = self.parent.parent.chapterList
end

function ISSurvivalGuideRichText:onJoypadDirRight(joypadData)
	joypadData.focus = self.parent.parent.rightPanel
end

function ISSurvivalGuideRichText:onJoypadDirUp(joypadData)
	self:onMouseWheel(-1)
end

function ISSurvivalGuideRichText:onJoypadDirDown(joypadData)
	self:onMouseWheel(1)
end

function ISSurvivalGuideRichText:new(x, y, width, height)
	local o = ISRichTextPanel.new(self, x, y, width, height)
	return o
end

-----

ISSurvivalGuideRightPanel = ISPanelJoypad:derive("ISSurvivalGuideRightPanel")

function ISSurvivalGuideRightPanel:createChildren()
	local tickHgt = math.max(FONT_HGT_SMALL + 4, 20)
	local richText = ISRichTextPanel:new(1, 1, self.width - 2, self.height - 2 - tickHgt - 10)
	richText:setAnchorBottom(true)
	local scrollbarWidth = 13
	richText.marginLeft, richText.marginRight, richText.marginTop, richText.marginBottom = 4,4+scrollbarWidth,4,4
	richText.borderColor.a = 0
	self:addChild(richText)
	richText.autosetheight = false
	richText.clip = true
	richText:addScrollBars();
	self.richText = richText

	local tickBox = ISTickBox:new(10, richText:getBottom() + 10, self.width - 10 * 2, tickHgt, "", self, self.onTickBox)
	tickBox:setAnchorTop(false)
	tickBox:setAnchorRight(true)
	tickBox:setAnchorBottom(true)
	tickBox:initialise()
	tickBox:addOption(getText("IGUI_Tutorial_ShowGuide"), nil)
	self:addChild(tickBox)
	self.tickBox = tickBox

	self:insertNewLineOfButtons(self.tickBox)
	self.joypadIndex = 1
	self.joypadIndexY = 1
end

function ISSurvivalGuideRightPanel:prerender()
	ISPanelJoypad.prerender(self)
	if self.tickBox:isSelected(1) ~= getCore():getOptionShowSurvivalGuide() then
		self.tickBox:setSelected(1, getCore():getOptionShowSurvivalGuide())
	end
end

function ISSurvivalGuideRightPanel:onTickBox(index, selected)
	getCore():setOptionShowSurvivalGuide(selected)
	getCore():saveOptions();
	if not selected then
		local modal = ISModalDialog:new((getCore():getScreenWidth() / 2) - 150, (getCore():getScreenHeight() / 2) - 60, 300, 120, getText("IGUI_Tutorial_PressF1"), false, nil, nil, nil)
		modal:initialise()
		modal:addToUIManager()
		if JoypadState.players[1] then
			JoypadState.players[1].focus = modal
			modal.prevFocus = self.parent.parent.rightPanel
		end
	end
end

function ISSurvivalGuideRightPanel:onGainJoypadFocus(joypadData)
	ISPanelJoypad.onGainJoypadFocus(self, joypadData)
	self.tickBox:setJoypadFocused(true, joypadData)
end

function ISSurvivalGuideRightPanel:onLoseJoypadFocus(joypadData)
	ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
	self.tickBox:setJoypadFocused(false, joypadData)
end

function ISSurvivalGuideRightPanel:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
		self.parent.parent:close()
		return
	end
	ISPanelJoypad.onJoypadDown(self, button, joypadData)
end

function ISSurvivalGuideRightPanel:onJoypadDirLeft(joypadData)
	joypadData.focus = self.parent.parent.centerText
end

function ISSurvivalGuideRightPanel:onJoypadDirUp(joypadData)
	self.richText:setYScroll(self.richText:getYScroll() + 48)
end

function ISSurvivalGuideRightPanel:onJoypadDirDown(joypadData)
	self.richText:setYScroll(self.richText:getYScroll() - 48)
end

function ISSurvivalGuideRightPanel:new(x, y, width, height)
	local o = ISPanelJoypad.new(self, x, y, width, height)
	return o
end

-----

--************************************************************************--
--** ISPanel:initialise
--**
--************************************************************************--

function ISTutorialPanel:initialise()
	ISCollapsableWindowJoypad.initialise(self);
end

--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function ISTutorialPanel:createChildren()
	ISCollapsableWindowJoypad.createChildren(self)

	local chapterWidth = 200
	for i=1,SurvivalGuideEntries.list:size() do
		local entry = SurvivalGuideEntries.getEntry(i-1)
		local width = getTextManager():MeasureStringX(UIFont.Small, entry.title)
		chapterWidth = math.max(chapterWidth, width + 6 * 2)
	end

	local showGuideWidth = getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_Tutorial_ShowGuide"))
	local rightWidth = math.max(240, 10 + 16 + 4 + showGuideWidth + 10)

	if chapterWidth + 500 + rightWidth > getCore():getScreenWidth() then
		chapterWidth = 200
		rightWidth = 240
	end

	self.content = ISPanel:new(0, 0, chapterWidth + 500 + rightWidth, 500)

	local reloadBtnHgt = 0
	if getDebug() then
		reloadBtnHgt = FONT_HGT_SMALL + 3 * 2
		local reloadBtn = ISButton:new(0, self.content.height - reloadBtnHgt, chapterWidth, reloadBtnHgt, "DBG: RELOAD", self, self.reload)
		self.content:addChild(reloadBtn)
	end

	self.chapterList = ISSurvivalGuideListBox:new(0, 0, chapterWidth, 500 - reloadBtnHgt)
	self.chapterList:setAnchorBottom(true)
	self.chapterList:setFont(UIFont.Small, 4)
	self.chapterList.drawBorder = true
	self.content:addChild(self.chapterList)

	self.centerText = ISSurvivalGuideRichText:new(self.chapterList:getRight(), 0, 500, 500);
	self.centerText:initialise();
	self.centerText:setAnchorBottom(true);
	self.centerText:setAnchorRight(true);
	self.content:addChild(self.centerText)
	local scrollBarWid = 0
	self.centerText.marginRight = self.centerText.marginLeft + scrollBarWid
	self.centerText.autosetheight = false;
	self.centerText.clip = true
	self.centerText:addScrollBars();

	self.rightPanel = ISSurvivalGuideRightPanel:new(self.centerText:getRight(), 0, rightWidth, 500)
	self.rightPanel:setAnchorBottom(true)
	self.content:addChild(self.rightPanel)
	self.rightPanelText = self.rightPanel.richText
	self.rightPanel.tickBox:setSelected(1, getCore():getOptionShowSurvivalGuide())

	self:setWidth(self.content.width)
	self:setHeight(self:titleBarHeight() + self.content.height)
	self:addView(self.content)

	self.tutorialSetInfo = ISTutorialSetInfo:new();
	for i=1,SurvivalGuideEntries.list:size() do
		local entry = SurvivalGuideEntries.getEntry(i-1)
		self.tutorialSetInfo:addPage(entry.title, entry.text, entry.moreInfo)
	end

	self.tutorialSetInfo:applyPageToRichTextPanel(self.rightPanelText)

	self:fillChapterList()
	self:setPage(1)
end

function ISTutorialPanel:setUseJoypad(useJoypad)
	SurvivalGuideEntries.useJoypad = useJoypad
	self.tutorialSetInfo = ISTutorialSetInfo:new()
	for i=1,SurvivalGuideEntries.list:size() do
		local entry = SurvivalGuideEntries.getEntry(i-1)
		self.tutorialSetInfo:addPage(entry.title, entry.text, entry.moreInfo)
	end
	self:fillChapterList()
	self:setPage(self.chapterList.selected)
end

function ISTutorialPanel:reload()
	Translator.loadFiles()
	reloadLuaFile("media/lua/client/SurvivalGuide/SurvivalGuideEntries.lua")
	self.tutorialSetInfo = ISTutorialSetInfo:new()
	for i=1,SurvivalGuideEntries.list:size() do
		local entry = SurvivalGuideEntries.getEntry(i-1)
		self.tutorialSetInfo:addPage(entry.title, entry.text, entry.moreInfo)
	end
	self:fillChapterList()
	self:setPage(self.chapterList.selected)
end

--************************************************************************--
--** ISTutorialPanel:setPage
--**
--************************************************************************--
function ISTutorialPanel:setPage(pageNum)
    self.tutorialSetInfo.currentPage = pageNum;
	self.tutorialSetInfo:applyPageToRichTextPanel(self.rightPanelText);
	self.chapterList.selected = pageNum;
	self.moreInfo = self.tutorialSetInfo:getCurrent().moreTextInfo;
	self.centerText.textDirty = true;
	self.centerText.text = self.moreInfo;
	self.centerText:paginate();
	self.centerText:setYScroll(0);
end

function ISTutorialPanel:fillChapterList()
	local selected = self.chapterList.selected
	self.chapterList:clear()
	for i,page in ipairs(self.tutorialSetInfo.pages) do
		self.chapterList:addItem(page.title, page)
	end
	self.chapterList.selected = math.min(selected, self.chapterList:size())
end

--************************************************************************--
--** ISTutorialPanel:render
--**
--************************************************************************--
function ISTutorialPanel:prerender()
	self.backgroundColor.a = 0.5
	ISCollapsableWindow.prerender(self)
	self.centerText.backgroundColor.a = 0.5
end

function ISTutorialPanel:render()
	ISCollapsableWindow.render(self)

	local a = 0.4
	local ui = self.chapterList
	if ui.joyfocus then
		self:drawRectBorder(ui.x, self.content.y + ui.y, ui.width, ui.height, a, 0.2, 1.0, 1.0);
		self:drawRectBorder(ui.x + 1, self.content.y + ui.y + 1, ui.width - 2, ui.height - 2, a, 0.2, 1.0, 1.0);
	end
	ui = self.centerText
	if ui.joyfocus then
		self:drawRectBorder(ui.x, self.content.y + ui.y, ui.width, ui.height, a, 0.2, 1.0, 1.0);
		self:drawRectBorder(ui.x + 1, self.content.y + ui.y + 1, ui.width - 2, ui.height - 2, a, 0.2, 1.0, 1.0);
	end
	ui = self.rightPanel
	if ui.joyfocus then
		self:drawRectBorder(ui.x, self.content.y + ui.y, ui.width, ui.height, a, 0.2, 1.0, 1.0);
		self:drawRectBorder(ui.x + 1, self.content.y + ui.y + 1, ui.width - 2, ui.height - 2, a, 0.2, 1.0, 1.0);
	end
end

--************************************************************************--
--** ISTutorialPanel:update
--**
--************************************************************************--
function ISTutorialPanel:update()
	if self.chapterList then
		if self.chapterList.selected ~= self.tutorialSetInfo.currentPage then
			self:setPage(self.chapterList.selected)
		end
	end
	self.tutorialSetInfo:update(self.richtext);
end

function ISTutorialPanel:close()
	if JoypadState.players[1] then
		JoypadState.players[1].focus = nil
	end
	self:setVisible(false)
	self:removeFromUIManager()
end

function ISTutorialPanel:onKeyRelease(key)
    if key == Keyboard.KEY_ESCAPE then
        self:close()
    end
end

function ISTutorialPanel:isKeyConsumed(key)
    return key == Keyboard.KEY_ESCAPE
end

function ISTutorialPanel:onGainJoypadFocus(joypadData)
	ISCollapsableWindowJoypad.onGainJoypadFocus(self, joypadData)
--	joypadData.lastfocus = nil
	self:setUseJoypad(true)
	joypadData.focus = self.chapterList
	updateJoypadFocus(joypadData)
end

function ISTutorialPanel:onToggleVisible()
	if self:getIsVisible() then
		self:addToUIManager();
	else
		self:removeFromUIManager();
	end;
end

--************************************************************************--
--** ISTutorialPanel:new
--**
--************************************************************************--
function ISTutorialPanel:new(x, y, width, height)
	local o = ISCollapsableWindowJoypad.new(self, x, y, width, height);
--	o.borderColor = {r=1, g=1, b=1, a=0.7};
--	o.backgroundColor = {r=0, g=0, b=0, a=0.5};
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
	o.resizable = false;
	o.title = getText("SurvivalGuide_WindowTitle")
	o:setWantKeyEvents(true)
	o.visibleTarget			= o;
	o.visibleFunction		= ISTutorialPanel.onToggleVisible;
	return o
end
