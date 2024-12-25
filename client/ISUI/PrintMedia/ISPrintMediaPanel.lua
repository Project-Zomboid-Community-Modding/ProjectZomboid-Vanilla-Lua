require "ISUI/ISButton"
require "ISUI/ISPanel"
-- require "ISUI/ISRichTextPanel"
require "ISUI/ISPrintMediaTextPanel"
require "ISUI/ISScrollingListBox"

ISPrintMediaPanel = ISCollapsableWindowJoypad:derive("ISPrintMediaPanel");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = FONT_HGT_SMALL + 6

-----

ISPrintMediaListBox = ISScrollingListBox:derive("ISPrintMediaListBox")

function ISPrintMediaListBox:doDrawItem(y, item, alt)
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

function ISPrintMediaListBox:onGainJoypadFocus(joypadData)
	ISScrollingListBox.onGainJoypadFocus(self, joypadData)
--	self.joypadFocused = true
end

function ISPrintMediaListBox:onLoseJoypadFocus(joypadData)
	ISScrollingListBox.onLoseJoypadFocus(self, joypadData)
--	self.joypadFocused = false
end

function ISPrintMediaListBox:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
		self.parent.parent:close()
	end
end

function ISPrintMediaListBox:onJoypadDirRight(joypadData)
	joypadData.focus = self.parent.parent.centerText
end

function ISPrintMediaListBox:new(x, y, width, height)
	local o = ISScrollingListBox.new(self, x, y, width, height)
	return o
end

--************************************************************************--
--** ISPanel:initialise
--**
--************************************************************************--

function ISPrintMediaPanel:initialise()
	ISCollapsableWindowJoypad.initialise(self);
end

--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function ISPrintMediaPanel:createChildren()
	ISCollapsableWindowJoypad.createChildren(self)
    local chapterWidth = math.max(getTextManager():MeasureStringX(UIFont.Small, getText("Print_Media_WindowTitle")), 200)
	for i=1,PrintMediaEntries.list:size() do
		local entry = PrintMediaEntries.getEntry(i-1)
		local width = getTextManager():MeasureStringX(UIFont.Small, entry.title)
		chapterWidth = math.max(chapterWidth, width + 6 * 2)
	end

	if chapterWidth  > getCore():getScreenWidth() then
		chapterWidth = 200
	end

	self.content = ISPanel:new(0, 0, chapterWidth, 500)

	local reloadBtnHgt = 0
	if getDebug() then
		reloadBtnHgt = BUTTON_HGT
		local reloadBtn = ISButton:new(0, self.content.height - reloadBtnHgt, chapterWidth, reloadBtnHgt, "DBG: RELOAD", self, self.reload)
		self.content:addChild(reloadBtn)
	end

	self.chapterList = ISPrintMediaListBox:new(0, 0, chapterWidth, 500 - reloadBtnHgt)
	self.chapterList:setAnchorBottom(true)
	self.chapterList:setFont(UIFont.Small, 3)
	self.chapterList.drawBorder = true
	self.content:addChild(self.chapterList)

-- 	self.centerText = ISPrintMediaRichText:new(self.chapterList:getRight(), 0, 700, 500);
-- 	self.centerText:initialise();
-- 	self.centerText:setAnchorBottom(true);
-- 	self.centerText:setAnchorRight(true);
-- 	self.content:addChild(self.centerText)
-- 	local scrollBarWid = 0
-- 	self.centerText.marginRight = self.centerText.marginLeft + scrollBarWid
-- 	self.centerText.autosetheight = false;
-- 	self.centerText.clip = true
-- 	self.centerText:addScrollBars();

	self:setWidth(self.content.width)
	self:setHeight(self:titleBarHeight() + self.content.height)
	self:addView(self.content)

	self.tutorialSetInfo = ISPrintMediaSetInfo:new();
	for i=1,PrintMediaEntries.list:size() do
		local entry = PrintMediaEntries.getEntry(i-1)
		self.tutorialSetInfo:addPage(entry.title, entry.text, entry.info)
	end

-- 	self.tutorialSetInfo:applyPageToRichTextPanel(self.rightPanelText)

	self:fillChapterList()
	self:setPage(1)
end

function ISPrintMediaPanel:setUseJoypad(useJoypad)
	PrintMediaEntries.useJoypad = useJoypad
	self.tutorialSetInfo = ISPrintMediaSetInfo:new()
	for i=1,PrintMediaEntries.list:size() do
		local entry = PrintMediaEntries.getEntry(i-1)
		self.tutorialSetInfo:addPage(entry.title, entry.text, entry.info)
	end
	self:fillChapterList()
	self:setPage(self.chapterList.selected)
end

function ISPrintMediaPanel:reload()
	Translator.loadFiles()
	reloadLuaFile("media/lua/shared/PrintMedia/PrintMediaDefinitions.lua")
	reloadLuaFile("media/lua/client/ISUI/PrintMedia/PrintMediaEntries.lua")
	self.tutorialSetInfo = ISPrintMediaSetInfo:new()
	for i=1,PrintMediaEntries.list:size() do
		local entry = PrintMediaEntries.getEntry(i-1)
		self.tutorialSetInfo:addPage(entry.title, entry.text, entry.info)
	end
	self:fillChapterList()
	self:setPage(self.chapterList.selected)
end

--************************************************************************--
--** ISPrintMediaPanel:setPage
--**
--************************************************************************--
function ISPrintMediaPanel:setPage(pageNum)
    self.tutorialSetInfo.currentPage = pageNum;
	self.chapterList.selected = pageNum;
-- 	self.info = self.tutorialSetInfo:getCurrent().moreTextInfo;
-- 	self.centerText.textDirty = true;
-- 	self.centerText.text = self.info;
-- 	self.centerText:paginate();
-- 	self.centerText:setYScroll(0);

-- 	    self.panel2 = ISPrintMediaPage:new(0, 0, 200, 200, self.chapterList.selected);
--         self.panel2:initialise();
--         self.panel2:addToUIManager();
--
--         self.panel2:setX((getCore():getScreenWidth() / 2) - (self.panel2.width / 2));
--         self.panel2:setY((getCore():getScreenHeight() / 2) - (self.panel2.height / 2));
--
--         ISLayoutManager.RegisterWindow('PrintMedia', PrintMediaManager, self)
end

function ISPrintMediaPanel:fillChapterList()
	local selected = self.chapterList.selected
	self.chapterList:clear()
	for i,page in ipairs(self.tutorialSetInfo.pages) do
		self.chapterList:addItem(page.title, page)
	end
	self.chapterList.selected = math.min(selected, self.chapterList:size())
end

--************************************************************************--
--** ISPrintMediaPanel:render
--**
--************************************************************************--
function ISPrintMediaPanel:prerender()
	self.backgroundColor.a = 0.5
	ISCollapsableWindow.prerender(self)
-- 	self.centerText.backgroundColor.a = 0.5
end

function ISPrintMediaPanel:render()
	ISCollapsableWindow.render(self)

	local a = 0.4
	local ui = self.chapterList
	if ui.joyfocus then
		self:drawRectBorder(ui.x, self.content.y + ui.y, ui.width, ui.height, a, 0.2, 1.0, 1.0);
		self:drawRectBorder(ui.x + 1, self.content.y + ui.y + 1, ui.width - 2, ui.height - 2, a, 0.2, 1.0, 1.0);
	end
-- 	ui = self.centerText
-- 	if ui.joyfocus then
-- 		self:drawRectBorder(ui.x, self.content.y + ui.y, ui.width, ui.height, a, 0.2, 1.0, 1.0);
-- 		self:drawRectBorder(ui.x + 1, self.content.y + ui.y + 1, ui.width - 2, ui.height - 2, a, 0.2, 1.0, 1.0);
-- 	end

end

--************************************************************************--
--** ISPrintMediaPanel:update
--**
--************************************************************************--
function ISPrintMediaPanel:update()
	if self.chapterList then
		if self.chapterList.selected ~= self.tutorialSetInfo.currentPage then
			self:setPage(self.chapterList.selected)

-- 	        getPlayer():Say("AAA " .. tostring(self.chapterList.selected))
            local entry = PrintMediaEntries.getEntry(self.chapterList.selected-1)
            local item
            if entry.index then
                if self.panel then
                    self.panel:close()
                end
-- --                 self.panel = ISPrintMediaPage:new(200, 200, entry.index, nil, nil);
--                 self.panel:initialise();
--                 self.panel:addToUIManager();
--
--                 self.panel:setX((getCore():getScreenWidth() / 2) - (self.panel.width / 2));
--                 self.panel:setY((getCore():getScreenHeight() / 2) - (self.panel.height / 2));
--
--                 ISLayoutManager.RegisterWindow('PrintMedia', PrintMediaManager, self)
            end
            if entry.type then
--                 local item = InventoryItemFactory.CreateItem(entry.type)
	            local item = instanceItem(entry.type)
                item:getModData().printMedia = entry.index
                local script = ScriptManager.instance:getItem(entry.type)
                local text = (getText(script:getDisplayName()) .. ": " .. getText("Print_Media_" .. entry.index .. "_title" ))
	            item:setName(text)
	            item:setBookName(text)
                self.panel = ISPrintMediaPage:new(200, 200, entry.index, nil, item);
                self.panel:initialise();
                self.panel:addToUIManager();

                self.panel:setX((getCore():getScreenWidth() / 2) - (self.panel.width / 2));
                self.panel:setY((getCore():getScreenHeight() / 2) - (self.panel.height / 2));

                ISLayoutManager.RegisterWindow('PrintMedia', PrintMediaManager, self)
                if item and getPlayer() then
                    getPlayer():getInventory():addItem(item)
                end
            else
                self.panel = ISPrintMediaPage:new(200, 200, entry.index, nil, nil);
                self.panel:initialise();
                self.panel:addToUIManager();

                self.panel:setX((getCore():getScreenWidth() / 2) - (self.panel.width / 2));
                self.panel:setY((getCore():getScreenHeight() / 2) - (self.panel.height / 2));

                ISLayoutManager.RegisterWindow('PrintMedia', PrintMediaManager, self)
            end
		end
	end
-- 	self.tutorialSetInfo:update(self.richtext);
end

function ISPrintMediaPanel:close()
    if self.panel then
        self.panel:close()
    end
	if JoypadState.players[1] then
		JoypadState.players[1].focus = nil
	end
	self:setVisible(false)
	self:removeFromUIManager()
end

function ISPrintMediaPanel:onKeyRelease(key)
    if key == Keyboard.KEY_ESCAPE then
        self:close()
    end
end

function ISPrintMediaPanel:isKeyConsumed(key)
    return key == Keyboard.KEY_ESCAPE
end

function ISPrintMediaPanel:onGainJoypadFocus(joypadData)
	ISCollapsableWindowJoypad.onGainJoypadFocus(self, joypadData)
--	joypadData.lastfocus = nil
	self:setUseJoypad(true)
	joypadData.focus = self.chapterList
	updateJoypadFocus(joypadData)
end

function ISPrintMediaPanel:onToggleVisible()
	if self:getIsVisible() then
		self:addToUIManager();
	else
		self:removeFromUIManager();
	end;
end

--************************************************************************--
--** ISPrintMediaPanel:new
--**
--************************************************************************--
function ISPrintMediaPanel:new(x, y, width, height)
	local o = ISCollapsableWindowJoypad.new(self, x-200, y, width, height);
--	o.borderColor = {r=1, g=1, b=1, a=0.7};
--	o.backgroundColor = {r=0, g=0, b=0, a=0.5};
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
	o.resizable = false;
	o.title = getText("Print_Media_WindowTitle")
	o:setWantKeyEvents(true)
	o.visibleTarget			= o;
	o.visibleFunction		= ISPrintMediaPanel.onToggleVisible;
	return o
end
