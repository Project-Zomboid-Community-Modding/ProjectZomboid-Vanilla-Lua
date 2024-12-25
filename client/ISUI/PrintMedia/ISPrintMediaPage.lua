require "ISUI/ISButton"
require "ISUI/ISPanel"
-- require "ISUI/ISPrintMediaTextPanel"
require "ISUI/ISRichTextPanel"
-- require "ISUI/ISScrollingListBox"

ISPrintMediaPage = ISCollapsableWindowJoypad:derive("ISPrintMediaPage");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

ISPrintMediaRichText = ISPrintMediaTextPanel:derive("ISPrintMediaRichText")
-- ISPrintMediaRichText = ISRichTextPanel:derive("ISPrintMediaRichText")

function ISPrintMediaRichText:prerender()
	self:doRightJoystickScrolling(20, 20)
	self:updateSmoothScrolling()
	ISPrintMediaTextPanel.prerender(self)
-- 	ISRichTextPanel.prerender(self)
end

function ISPrintMediaRichText:onMouseWheel(del)
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

ISPrintMediaRichText.doRightJoystickScrolling = ISPanelJoypad.doRightJoystickScrolling

function ISPrintMediaRichText:updateSmoothScrolling()
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

function ISPrintMediaRichText:onJoypadDown(button, joypadData)
	if button == Joypad.BButton then
		self.parent.parent:close()
	end
end

function ISPrintMediaRichText:onJoypadDirLeft(joypadData)
-- 	joypadData.focus = self.parent.parent.chapterList
end

function ISPrintMediaRichText:onJoypadDirRight(joypadData)
	-- joypadData.focus = self.parent.parent.rightPanel
end

function ISPrintMediaRichText:onJoypadDirUp(joypadData)
	self:onMouseWheel(-1)
end

function ISPrintMediaRichText:onJoypadDirDown(joypadData)
	self:onMouseWheel(1)
end

function ISPrintMediaRichText:new(x, y, width, height)
-- 	local o = ISPrintMediaTextPanel.new(self, x, y, width, height)
	local o = ISRichTextPanel.new(self, x, y, width, height)
	o.printMedia = true
	return o
end


--************************************************************************--
--** ISPanel:initialise
--**
--************************************************************************--

function ISPrintMediaPage:initialise()
	ISCollapsableWindowJoypad.initialise(self);
end

--************************************************************************--
--** ISPanel:instantiate
--**
--************************************************************************--
function ISPrintMediaPage:createChildren()
	ISCollapsableWindowJoypad.createChildren(self)

	self.content = ISPanel:new(0, 0, self.width , self.height)

    self.centerText = ISPrintMediaRichText:new(0, 0, self.width , self.height)
	self.centerText:initialise();
	self.centerText:setAnchorBottom(true);
	self.centerText:setAnchorRight(true);
	self.content:addChild(self.centerText)
	local scrollBarWid = 0
	self.centerText.marginRight = self.centerText.marginLeft + scrollBarWid
	self.centerText.autosetheight = false;
	self.centerText.clip = true
	self.centerText:addScrollBars();

	self:setWidth(self.content.width)
	self:setHeight(self:titleBarHeight() + self.content.height)
	self:addView(self.content)

	self.centerText.textDirty = true;
	self.centerText.text = getText("Print_Media_"..self.index.."_info");
	self.centerText:paginate();
	self.centerText:setYScroll(0);
end

--************************************************************************--
--** ISPrintMediaPage:render
--**
--************************************************************************--
function ISPrintMediaPage:prerender()
    local player = self.player
    if player then
        if player:isRunning() or player:isAttacking() or player:isAiming() or player:isAsleep() or player:isClimbing()
        or player:isCurrentState(ClimbOverWallState.instance()) or player:isCurrentState(ClimbThroughWindowState:instance())
        or (player:getFallTime() > 0) or (not player:getCharacterActions():isEmpty()) then
            self:close()
        elseif player:tooDarkToRead() then
--         elseif player:getSquare():getLightLevel(player:getPlayerNum()) < 0.43 then
		    HaloTextHelper.addBadText(player, getText("ContextMenu_TooDark"));
-- 		    HaloTextHelper.addText(player, getText("ContextMenu_TooDark"), getCore():getGoodHighlitedColor());
		    self:close()
        elseif self.item and not (player:getInventory():contains(self.item)) then self:close() end
    end
-- 	self.backgroundColor.a = 0
	if not self.isCollapsed then
		local texture  = getTexture("media/textures/worldMap/Paper.png")
		self:drawTextureScaled(texture, 0, 0, self.width, self.height, 1);
    end
	ISCollapsableWindow.prerender(self)
	self.centerText.backgroundColor.a = 0.65
    self.centerText.backgroundColor.r = self.backgroundColor.r
    self.centerText.backgroundColor.g = self.backgroundColor.g
    self.centerText.backgroundColor.b = self.backgroundColor.b
end

function ISPrintMediaPage:render()
	ISCollapsableWindow.render(self)

	local a = 0.4

	local ui = self.centerText
	if ui.joyfocus then
		self:drawRectBorder(ui.x, self.content.y + ui.y, ui.width, ui.height, a, 0.2, 1.0, 1.0);
		self:drawRectBorder(ui.x + 1, self.content.y + ui.y + 1, ui.width - 2, ui.height - 2, a, 0.2, 1.0, 1.0);
	end

end


function ISPrintMediaPage:close()
	if JoypadState.players[1] then
		JoypadState.players[1].focus = nil
	end
	self:setVisible(false)
	self:removeFromUIManager()
end

function ISPrintMediaPage:onKeyRelease(key)
    if key == Keyboard.KEY_ESCAPE then
        self:close()
    end
end

function ISPrintMediaPage:isKeyConsumed(key)
    return key == Keyboard.KEY_ESCAPE
end

function ISPrintMediaPage:onGainJoypadFocus(joypadData)
	ISCollapsableWindowJoypad.onGainJoypadFocus(self, joypadData)
--	joypadData.lastfocus = nil
	self:setUseJoypad(true)
	joypadData.focus = self.chapterList
	updateJoypadFocus(joypadData)
end

function ISPrintMediaPage:onToggleVisible()
	if self:getIsVisible() then
		self:addToUIManager();
	else
		self:removeFromUIManager();
	end;
end

--************************************************************************--
--** ISPrintMediaPage:new
--**
--************************************************************************--
function ISPrintMediaPage:new(x, y, index, player, item)
	local o = ISCollapsableWindowJoypad.new(self, x, y, width, height);
--	o.borderColor = {r=1, g=1, b=1, a=0.7};
-- 	o.backgroundColor = {r=0.9, g=0.9, b=0.9, a=1};
	o.backgroundColor = {r=1, g=1, b=1, a=0};
	if PrintMediaDefinitions.MiscDetails[index] and PrintMediaDefinitions.MiscDetails[index].fill then
        o.backgroundColor.r = PrintMediaDefinitions.MiscDetails[index].fill.r
        o.backgroundColor.g = PrintMediaDefinitions.MiscDetails[index].fill.g
        o.backgroundColor.b = PrintMediaDefinitions.MiscDetails[index].fill.b
	end
	o.width = 700
	o.height = 500
	if PrintMediaDefinitions.MiscDetails[index] and PrintMediaDefinitions.MiscDetails[index].width then
        o.width = PrintMediaDefinitions.MiscDetails[index].width
	end
	if PrintMediaDefinitions.MiscDetails[index] and PrintMediaDefinitions.MiscDetails[index].height then
        o.height = PrintMediaDefinitions.MiscDetails[index].height
	end
	o.player = player
	o.item = item
    o.index = index
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
	o.resizable = false;
	if item then
        o.title = item:getDisplayName()
	else
-- 	    o.title = getText("Print_Media_"..index.."_title")
	end
	o:setWantKeyEvents(true)
	o.visibleTarget			= o;
	o.visibleFunction		= ISPrintMediaPage.onToggleVisible;
	return o
end
