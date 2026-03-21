require "ISUI/ISPanel"
require "ISUI/ISButton"
require "ISUI/ISInventoryPane"
require "ISUI/ISResizeWidget"
require "ISUI/ISMouseDrag"

require "defines"

NewGameScreen = ISPanelJoypad:derive("NewGameScreen");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.Large)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32


local HorizontalLine = ISPanel:derive("HorizontalLine")

function HorizontalLine:prerender()
end

function HorizontalLine:render()
	self:drawRect(0, 0, self.width, 2, 1.0, 0.5, 0.5, 0.5)
end

function HorizontalLine:new(x, y, width)
	local o = ISPanel:new(x, y, width, 2)
	setmetatable(o, self)
	self.__index = self
	return o
end

local MainPanel = ISPanelJoypad:derive("NewGameScreen_MainPanel")

function MainPanel:prerender()
    if self.joyfocus then
        self:doRightJoystickScrolling(20, 20)
    end

    if self.joyfocus and (self:getJoypadFocus() ~= self.lastSelectedChild) then
        self.lastSelectedChild = self:getJoypadFocus()
        self:ensureVisible()
    end

    local scrollBarWid = (self:getScrollHeight() > self.height) and self.vscroll:getWidth() or 0
    local scrollBarHgt = (self:getScrollWidth() > self.width) and self.hscroll:getHeight() or 0
    self:setStencilRect(0, 0, self:getWidth() - scrollBarWid, self:getHeight() - scrollBarHgt)
    ISPanelJoypad.prerender(self)
end

function MainPanel:render()
    ISPanelJoypad.render(self)
    self:renderActiveMods()
    self:clearStencilRect()

    if self.joyfocus then
        self:drawRectBorderStatic(0, 0, self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
        self:drawRectBorderStatic(1, 1, self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);
    end
end

function MainPanel:renderActiveMods()
    local x = UI_BORDER_SPACING+1
    local xoffset = UI_BORDER_SPACING*2
    local y = self.activeModsY
    local activeMods = ActiveMods.getById("currentGame")
    if activeMods:getMods():isEmpty() then
        self:drawText(getText("UI_LoadGameScreen_NoMods"), x + xoffset, y, 1, 1, 1, 1, UIFont.Small)
        y = y + FONT_HGT_SMALL
    end
    for i=1,activeMods:getMods():size() do
        local modID = activeMods:getMods():get(i-1)
        local modInfo = getModInfoByID(modID)
        if modInfo then
            self:drawText(modInfo:getName(), x + xoffset, y, 1, 1, 1, 1, UIFont.Small)
        else
            self:drawText(modID, x + xoffset, y, 1, 0, 0, 1, UIFont.Small)
        end
        y = y + FONT_HGT_SMALL
    end
    self.parent.buttonMods:setY(y + 8)

    self:setScrollHeight(self.parent.buttonMods:getBottom() + 20)
end

function MainPanel:ensureVisible()
    local child = self:getJoypadFocus()
    if not child then return end
    local y = child:getY()
    if y - 40 < 0 - self:getYScroll() then
        self:setYScroll(0 - y + 40)
    elseif y + child:getHeight() + 40 > 0 - self:getYScroll() + self:getHeight() then
        self:setYScroll(0 - (y + child:getHeight() + 40 - self:getHeight()))
    end
end

function MainPanel:onMouseWheel(del)
    self:setYScroll(self:getYScroll() - (del * 40))
    return true
end

function MainPanel:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    if self.joypadIndex == 0 then
        self.joypadIndex = 1
        self.joypadIndexY = 1
        self.joypadButtons = self.joypadButtonsY[1]
    end
    if #self.joypadButtons >= 1 and self.joypadIndex <= #self.joypadButtons then
        self.joypadButtons[self.joypadIndex]:setJoypadFocused(true, joypadData)
    end
end

function MainPanel:onLoseJoypadFocus(joypadData)
    self:clearJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
end

function MainPanel:onJoypadBeforeDeactivate(joypadData)
    self.parent:onJoypadBeforeDeactivate(joypadData)
end


local RichText = ISRichTextPanel:derive("NewGameScreen_RichText")

function RichText:prerender()
	self:doRightJoystickScrolling(20, 20)
	ISRichTextPanel.prerender(self)
end

function RichText:render()
	ISRichTextPanel.render(self)
	if self.joyfocus then
		self:drawRectBorderStatic(0, 0, self:getWidth(), self:getHeight(), 0.4, 0.2, 1.0, 1.0);
		self:drawRectBorderStatic(1, 1, self:getWidth()-2, self:getHeight()-2, 0.4, 0.2, 1.0, 1.0);
	end
end

RichText.doRightJoystickScrolling = ISPanelJoypad.doRightJoystickScrolling

function RichText:onJoypadDown(button, joypadData)
	self.parent:onJoypadDown(button, joypadData)
end

function RichText:onJoypadDirUp(joypadData)
	self:setYScroll(self:getYScroll() + 50)
end

function RichText:onJoypadDirDown(joypadData)
	self:setYScroll(self:getYScroll() - 50)
end

function RichText:onJoypadBeforeDeactivate(joypadData)
	self.parent:onJoypadBeforeDeactivate(joypadData)
end

function NewGameScreen:initialise()
	ISPanel.initialise(self);
end

function NewGameScreen:instantiate()
	self.javaObject = UIElement.new(self);
	self.javaObject:setX(self.x);
	self.javaObject:setY(self.y);
	self.javaObject:setHeight(self.height);
	self.javaObject:setWidth(self.width);
	self.javaObject:setAnchorLeft(self.anchorLeft);
	self.javaObject:setAnchorRight(self.anchorRight);
	self.javaObject:setAnchorTop(self.anchorTop);
	self.javaObject:setAnchorBottom(self.anchorBottom);
end

function NewGameScreen:create()
    self.mainPanel = MainPanel:new(UI_BORDER_SPACING+1, self.startY, self:getWidth() / 2, self:getHeight() - self.startY - UI_BORDER_SPACING*2 - BUTTON_HGT - 1);
    self.mainPanel:initialise();
    self.mainPanel:instantiate();
    self.mainPanel:setAnchorRight(false);
    self.mainPanel:setAnchorLeft(true);
    self.mainPanel:setAnchorTop(true);
    self.mainPanel:setAnchorBottom(true);
    self.mainPanel:noBackground();
    self.mainPanel.borderColor = {r=0, g=0, b=0, a=0};
    self.mainPanel:setScrollChildren(true);
    self.mainPanel:addScrollBars(true);
    self.mainPanel.vscroll.doSetStencil = true
    self.mainPanel.hscroll.doSetStencil = true
    self:addChild(self.mainPanel);

    local y = 0;
    local x = UI_BORDER_SPACING;
    local xoffset = UI_BORDER_SPACING*2;
    local gapY = UI_BORDER_SPACING

    local mediumFontHgt = FONT_HGT_MEDIUM + 4

    local playstyle = ISLabel:new(x, y, FONT_HGT_LARGE, getText("UI_NewGame_PlayStyle"), 1, 1, 1, 1, UIFont.NewLarge, true);
    playstyle:initialise();
    self.mainPanel:addChild(playstyle);
    y = y + FONT_HGT_LARGE + 4

    local apocalypse = ISLabel:new(x + xoffset, y, mediumFontHgt, getText("UI_NewGame_Apocalypse"), 1, 1, 1, 1, UIFont.NewMedium, true);
    apocalypse.mode = "Apocalypse";
    apocalypse.desc = getText("UI_NewGame_Apocalypse_desc");
    apocalypse.thumb = "media/ui/playstyleIcons/apocalypse.png"
    apocalypse:initialise();
    self.mainPanel:addChild(apocalypse);
    apocalypse.onMouseDown = NewGameScreen.onMenuItemMouseDown;
    apocalypse:setOnMouseDoubleClick(self, NewGameScreen.dblClickPlaystyle);
    self.survival = apocalypse;

    local apocalypseDesc = ISLabel:new(apocalypse:getRight(), y, mediumFontHgt, " - " .. getText("UI_NewGame_Apocalypse_desc"), 0.5, 0.5, 0.5, 1, UIFont.Small, true);
    apocalypseDesc:initialise();
    self.mainPanel:addChild(apocalypseDesc);
    y = y + FONT_HGT_LARGE + 4;

    local outbreak = ISLabel:new(x + xoffset, y, mediumFontHgt, getText("UI_NewGame_Outbreak"), 1, 1, 1, 1, UIFont.NewMedium, true);
    outbreak.mode = "Outbreak";
    outbreak.desc = getText("UI_NewGame_Outbreak_desc");
    outbreak.thumb = "media/ui/playstyleIcons/outbreak.png"
    outbreak:initialise();
    self.mainPanel:addChild(outbreak);
    outbreak.onMouseDown = NewGameScreen.onMenuItemMouseDown;
    outbreak:setOnMouseDoubleClick(self, NewGameScreen.dblClickPlaystyle);

    local outbreakDesc = ISLabel:new(outbreak:getRight(), y, mediumFontHgt, " - " .. getText("UI_NewGame_Outbreak_desc"), 0.5, 0.5, 0.5, 1, UIFont.Small, true);
    outbreakDesc:initialise();
    self.mainPanel:addChild(outbreakDesc);
    y = y + FONT_HGT_LARGE + 4;

    local extinction = ISLabel:new(x + xoffset, y, mediumFontHgt, getText("UI_NewGame_Extinction"), 1, 1, 1, 1, UIFont.NewMedium, true);
    extinction.mode = "Extinction";
    extinction.desc = getText("UI_NewGame_Extinction_desc");
    extinction.thumb = "media/ui/playstyleIcons/extinction.png"
    extinction:initialise();
    self.mainPanel:addChild(extinction);
    extinction.onMouseDown = NewGameScreen.onMenuItemMouseDown;
    extinction:setOnMouseDoubleClick(self, NewGameScreen.dblClickPlaystyle);

    local extinctionDesc = ISLabel:new(extinction:getRight(), y, mediumFontHgt, " - " .. getText("UI_NewGame_Extinction_desc"), 0.5, 0.5, 0.5, 1, UIFont.Small, true);
    extinctionDesc:initialise();
    self.mainPanel:addChild(extinctionDesc);
    y = y + FONT_HGT_LARGE + 4;

    local rising = ISLabel:new(x + xoffset, y, mediumFontHgt, getText("UI_NewGame_Rising"), 1, 1, 1, 1, UIFont.NewMedium, true);
    rising.mode = "Rising";
    rising.desc = getText("UI_NewGame_Rising_desc");
    rising.thumb = "media/ui/playstyleIcons/rising.png"
    rising:initialise();
    self.mainPanel:addChild(rising);
    rising.onMouseDown = NewGameScreen.onMenuItemMouseDown;
    rising:setOnMouseDoubleClick(self, NewGameScreen.dblClickPlaystyle);

    local risingDesc = ISLabel:new(rising:getRight(), y, mediumFontHgt, " - " .. getText("UI_NewGame_Rising_desc"), 0.5, 0.5, 0.5, 1, UIFont.Small, true);
    risingDesc:initialise();
    self.mainPanel:addChild(risingDesc);
    y = y + FONT_HGT_LARGE + 4;

    local sandbox = ISLabel:new(x + xoffset, y, mediumFontHgt, getText("UI_NewGame_Sandbox"), 1, 1, 1, 1, UIFont.NewMedium, true);
    sandbox.mode = "Sandbox";
    sandbox.desc = getText("UI_NewGame_Sandbox_desc");
    sandbox.thumb = "media/ui/playstyleIcons/sandbox.png"
    sandbox:initialise();
    self.mainPanel:addChild(sandbox);
    sandbox.onMouseDown = NewGameScreen.onMenuItemMouseDown;
    sandbox:setOnMouseDoubleClick(self, NewGameScreen.dblClickChallenge);

    local sandboxDesc = ISLabel:new(sandbox:getRight(), y, mediumFontHgt, " - " .. getText("UI_NewGame_Sandbox_desc2"), 0.5, 0.5, 0.5, 1, UIFont.Small, true);
    sandboxDesc:initialise();
    self.mainPanel:addChild(sandboxDesc);
    y = y + FONT_HGT_LARGE

    local sep3 = HorizontalLine:new(x, y + 10, 1000)
    sep3:initialise()
    self.mainPanel:addChild(sep3)
    y = y + 10 + 2 + 10

    local challenges = ISLabel:new(x, y, FONT_HGT_LARGE, getText("UI_NewGame_Challenges"), 1, 1, 1, 1, UIFont.NewLarge, true);
    challenges:initialise();
    self.mainPanel:addChild(challenges);
    y = y + FONT_HGT_LARGE + 4;

    local disabledLabel = ISLabel:new(x, y, FONT_HGT_MEDIUM, getText("UI_NewGame_ChallengesDisabled"), 0.6, 0.6, 0.6, 1, UIFont.NewSmall, true);
    challenges:initialise();
    self.mainPanel:addChild(disabledLabel);
    y = y + FONT_HGT_MEDIUM + 4;

    local challenges = {}
    table.sort(LastStandChallenge, function(a,b) return a.name < b.name end)
    for i,info in ipairs(LastStandChallenge) do
        local challenge = ISLabel:new(x+xoffset, y, mediumFontHgt, info.name, 1, 1, 1, 1, UIFont.NewMedium, true);
        challenge:initialise();
        challenge.internal = info.name;
        challenge.challenge= info;
        challenge.desc = info.description or "NO DESCRIPTION";
        challenge.mode = "Challenge";
        challenge.thumb = info.image;
        challenge.video = info.video;
        self.mainPanel:addChild(challenge);
        challenge:setOnMouseDoubleClick(self, NewGameScreen.dblClickChallenge);
        challenge.onMouseDown = NewGameScreen.onMenuItemMouseDown;
        table.insert(challenges, challenge)
        y = y + mediumFontHgt + gapY

    end
    y = y - gapY

    local sep4 = HorizontalLine:new(x, y + UI_BORDER_SPACING, 1000)
    sep4:initialise()
    self.mainPanel:addChild(sep4)
    y = y + 10 + 2 + 10

    local mods = ISLabel:new(x, y, FONT_HGT_LARGE, getText("UI_NewGame_Mods"), 1, 1, 1, 1, UIFont.NewLarge, true);
    mods:initialise();
    self.mainPanel:addChild(mods);
    y = y + FONT_HGT_LARGE + 4;

    self.mainPanel.activeModsY = y

    self.buttonMods = ISButton:new(x + xoffset, y, 150, BUTTON_HGT, getText("UI_NewGame_ChooseMods"), self, NewGameScreen.onOptionMouseDown)
    self.buttonMods.internal = "MODS";
    self.buttonMods:initialise();
    self.buttonMods:instantiate();
    self.mainPanel:addChild(self.buttonMods);

    y = self.buttonMods:getBottom()

    self.mainPanel:setScrollHeight(y + UI_BORDER_SPACING);

    self.mainPanel.javaObject:BringToTop(self.mainPanel.vscroll.javaObject)
    self.mainPanel.javaObject:BringToTop(self.mainPanel.hscroll.javaObject)

    local width = 0
    for _,child in pairs(self.mainPanel:getChildren()) do
        if child.mode and child.Type ~= "ISButton" then
            child.prerender = NewGameScreen.prerenderBottomPanelLabel;
            child.setJoypadFocused = NewGameScreen.Label_setJoypadFocused
        end
        if child.Type == "ISLabel" then
            width = math.max(width, child:getRight())
        end
    end
    self.mainPanel:setScrollWidth(width + UI_BORDER_SPACING);
    width = width + self.mainPanel.vscroll:getWidth() + 4
    self.mainPanelReqWidth = width
    width = math.min(width, (self.width / 2) + 90 - self.mainPanel.x)
    self.mainPanel:setWidth(width)

    self.mainPanel:insertNewLineOfButtons(apocalypse)
    self.mainPanel:insertNewLineOfButtons(outbreak)
    self.mainPanel:insertNewLineOfButtons(rising)
    self.mainPanel:insertNewLineOfButtons(sandbox)
    for _,challenge in ipairs(challenges) do
        self.mainPanel:insertNewLineOfButtons(challenge)
    end
    self.mainPanel:insertNewLineOfButtons(self.buttonMods)

    local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
    local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_back"))
    self.backButton = ISButton:new(UI_BORDER_SPACING+1, self.height - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWidth, BUTTON_HGT, getText("UI_btn_back"), self, NewGameScreen.onOptionMouseDown);
	self.backButton.internal = "BACK";
	self.backButton:initialise();
	self.backButton:instantiate();
	self.backButton:setAnchorLeft(true);
	self.backButton:setAnchorTop(false);
	self.backButton:setAnchorBottom(true);
	self.backButton.borderColor = {r=1, g=1, b=1, a=0.1};
	self.backButton:setFont(UIFont.Small);
	self.backButton:ignoreWidthChange();
	self.backButton:ignoreHeightChange();
    self.backButton:enableCancelColor()
	self:addChild(self.backButton);

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.Small, getText("UI_btn_next"))
	self.nextButton = ISButton:new(self.width - UI_BORDER_SPACING - btnWidth - 1, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_btn_next"), self, NewGameScreen.onOptionMouseDown);
	self.nextButton.internal = "NEXT";
	self.nextButton:initialise();
	self.nextButton:instantiate();
	self.nextButton:setAnchorLeft(false);
	self.nextButton:setAnchorRight(true);
	self.nextButton:setAnchorTop(false);
	self.nextButton:setAnchorBottom(true);
    self.nextButton:enableAcceptColor()

	self.nextButton:setFont(UIFont.Small);
	self.nextButton:ignoreWidthChange();
	self.nextButton:ignoreHeightChange();
	self:addChild(self.nextButton);

    self.richText = RichText:new(UI_BORDER_SPACING, 10, 500,200);
    self.richText:initialise();
    self.richText.autosetheight = false;
    self.richText.background = false;
    self.richText.clip = true
    self.richText.marginRight = 20
    self.richText:setAnchorBottom(true);
    self.richText:setAnchorRight(true);
    self:addChild(self.richText);
    self.richText:addScrollBars()

    self.selectedItem = self.survival

	self:setVisible(false);
end

NewGameScreen.dblClickTutorial = function(item, x, y)
    NewGameScreen.onMenuItemMouseDown(item, x, y)
    NewGameScreen.instance:clickPlay();
end

NewGameScreen.dblClickPlaystyle = function(item, x, y)
    NewGameScreen.onMenuItemMouseDown(item, x, y)
    NewGameScreen.instance:clickPlay();
end

NewGameScreen.dblClickChallenge = function(item, x, y)
    NewGameScreen.onMenuItemMouseDown(item, x, y)
    NewGameScreen.instance:clickPlay();
end

NewGameScreen.dblClickSurvival = function(item, x, y)
    NewGameScreen.instance:clickPlay();
end

NewGameScreen.onMenuItemMouseDown = function(item, x, y)
    getSoundManager():playUISound("UIActivateMainMenuItem")

    local screen = NewGameScreen.instance;
    screen.selectedItem = item;
end

function NewGameScreen:prerenderBottomPanelLabel()
    local padLeft = 6
    local padRight = 6
    local alpha = 0.5
    if NewGameScreen.instance.selectedItem == self then
        self:drawRect(0 - padLeft, 0, self:getWidth() + padLeft + padRight, self:getHeight(), alpha, 0.3, 0.3, 0.3)
        if self.joypadFocused then
            self:drawRectBorder(0 - padLeft, 0, self:getWidth() + padLeft + padRight, self:getHeight(), 0.9, 0.6, 0.6, 0.6)
        else
            self:drawRectBorder(0 - padLeft, 0, self:getWidth() + padLeft + padRight, self:getHeight(), 0.9, 0.3, 0.3, 0.3)
        end
    elseif self.fadeOut or self.fadeIn then
        if self.fadeIn then
            local fadeIn = getPerformance():getUIRenderFPS() / 12
            alpha = 0.5 * (self.fadeIn / fadeIn)
            self.fadeIn = math.min(self.fadeIn + 1, fadeIn)
        else
            local fadeOut = getPerformance():getUIRenderFPS() / 4
            alpha = 0.5 * (1 - self.fadeOut / fadeOut)
            self.fadeOut = math.min(self.fadeOut + 1, fadeOut)
            if self.fadeOut == fadeOut then
                self.fadeOut = nil
            end
        end
        self:drawRect(0 - padLeft, 0, self:getWidth() + padLeft + padRight, self:getHeight(), alpha, 0.3, 0.3, 0.3)
    end
    ISLabel.prerender(self)
end

function NewGameScreen:update()
    NewGameScreen.instance = self
    self:updateBottomPanelButtons();
    self:disableBtn();
    if self.mainPanel.hscroll then
        self.mainPanel.hscroll:setVisible(self.mainPanel:getScrollAreaWidth() < self.mainPanel:getScrollWidth())
    end

    local focusOnChild = self.mainPanel.joyfocus or self.richText.joyfocus
    if self.ISButtonA and not focusOnChild then
        self.ISButtonA = nil
        self.ISButtonB = nil
        self.mainPanel.ISButtonA = nil
        self.mainPanel.ISButtonB = nil
        self.nextButton:clearJoypadButton()
        self.backButton:clearJoypadButton()
    elseif not self.ISButtonA and focusOnChild then
        self:setISButtonForA(self.nextButton)
        self:setISButtonForB(self.backButton)
        self.mainPanel:setISButtonForA(self.nextButton)
        self.mainPanel:setISButtonForB(self.backButton)
    end

    if self.ISButtonA and self.mainPanel.joyfocus and self.mainPanel:getJoypadFocus() == self.buttonMods then
        self.ISButtonA = nil
        self.mainPanel.ISButtonA = nil
        self.nextButton:clearJoypadButton()
    end
end

function NewGameScreen:disableBtn()
    self.nextButton:setEnable(self.selectedItem ~= nil);
    self.nextButton:setTooltip(nil);
end

function NewGameScreen:updateBottomPanelButtons()
    local overButton = nil
    for _,child in pairs(self.mainPanel:getChildren()) do
        if not child.disabled and child:isMouseOver() or child.joypadFocused then
            overButton = child
            break
        end
    end
    if overButton ~= self.overBottomPanelButton then
        if self.overBottomPanelButton then
            self.overBottomPanelButton.fadeIn = nil
            self.overBottomPanelButton.fadeOut = 0
        end
        self.overBottomPanelButton = overButton
        if self.overBottomPanelButton then
            self.overBottomPanelButton.fadeIn = 0
            self.overBottomPanelButton.fadeOut = nil

            local sound = getSoundManager():playUISound("UIHighlightMainMenuItem")
            if self.MouseEnterMainMenuItem then
                getSoundManager():stopUISound(self.MouseEnterMainMenuItem)
            end
            self.MouseEnterMainMenuItem = sound and sound or nil
        end
    end
end

function NewGameScreen:render()
    local selectedItem = self.selectedItem;
    if not selectedItem then return; end

    local descRectWidth = self.width - self.mainPanel:getWidth() - UI_BORDER_SPACING*3 - 2
    local descRectHeight = self.mainPanel:getHeight()

    local text = ""
    if selectedItem.video then
        local w = 1920
        local h = 1080
        local div = w/(self.richText:getWidth() - UI_BORDER_SPACING*2 - 2)
        local w2 = w / div
        local h2 = h / div
        text = "<VIDEOCENTRE:".. selectedItem.video ..","..w..","..h..","..w2..","..h2..">\n"
    elseif selectedItem.thumb then
        local thumb = getTexture(selectedItem.thumb)
        local thumbH = thumb:getHeight()
        local thumbW = thumb:getWidth()
        local targetThumbW = descRectWidth/2
        local scaleFactor = math.min(targetThumbW / thumbW, 1)
        text = "<IMAGECENTRE:" .. selectedItem.thumb .. ",".. thumbW*scaleFactor..",".. thumbH*scaleFactor .."><LINE> "
    end

    self.richText:setX(self.mainPanel:getRight() + UI_BORDER_SPACING)
    self.richText:setY(self.mainPanel:getY())
    self.richText:setWidth(descRectWidth)
    self.richText:setHeight(descRectHeight)
    local name = selectedItem.name;
    if selectedItem.moreTextToRemove then
        name = name:gsub(selectedItem.moreTextToRemove, "");
        name = name:gsub("-", "");
    end
    text = text .. " <H1> " .. name .. " <LINE> ";
    text = text .. " <LINE>";
    text = text .. " <H2><CENTRE> " .. selectedItem.desc;
    self.richText.text = text;
    self.richText:paginate();
    self:drawRectBorder( self.richText:getX(), self.richText:getY(), self.richText:getWidth(), self.richText:getHeight(), 0.3, 1, 1, 1);

    local playerNum = 0
    self:renderJoypadNavigateOverlay(playerNum)
end

function NewGameScreen:prerender()
    NewGameScreen.instance = self
	ISPanel.prerender(self);
	self:drawTextCentre(getText("UI_NewGameScreen_title"), self.width / 2, UI_BORDER_SPACING+1, 1, 1, 1, 1, UIFont.Large);
end

function NewGameScreen:onOptionMouseDown(button, x, y)
    if self.modal then
        self.modal:setVisible(false);
        self.modal = nil;
    end
    if button.internal == "BACK" then
        MainScreen.resetLuaIfNeeded()
        self:setVisible(false);
        MainScreen.instance.bottomPanel:setVisible(true);
        if self.joyfocus then
            self:clearJoypadFocus(self.joyfocus)
            self.joypadIndex = 1
            self.joypadIndexY = 1
            self.joypadButtons = self.joypadButtonsY[self.joypadIndexY]
            self.joyfocus.focus = MainScreen.instance;
            updateJoypadFocus(self.joyfocus);
        end
    end
    if button.internal == "NEXT" then
        self:clickPlay();
    end
    if button.internal == "MODS" then
        self:setVisible(false)
        ModSelector.instance:setNewGame()
        ModSelector.instance:setVisible(true, self.joyfocus)
        ModSelector.instance:reloadMods()
        ModSelector.showNagPanel()
        ModSelector.instance.returnToUI = NewGameScreen.instance
    end
end

function NewGameScreen:clickPlay()
    self:setVisible(false);

    MainScreen.instance.charCreationProfession.previousScreen = "NewGameScreen";
    getWorld():setGameMode(self.selectedItem.mode);

    if self.selectedItem.mode == "Tutorial" then
        MainScreen.startTutorial();
        return;
    end

	MainScreen.instance:setDefaultSandboxVars()

    if self.selectedItem.mode == "Challenge" then
        LastStandData.chosenChallenge = self.selectedItem.challenge;
        local worldName = ZombRand(100000)..ZombRand(100000)..ZombRand(100000)..ZombRand(100000);
        doChallenge(self.selectedItem.challenge);
        getWorld():setWorld(worldName);
        if getCore():getGameMode() ~= "LastStand" then
            MainScreen.instance.createWorld = true
            if MapSpawnSelect.instance:hasChoices() then
                MapSpawnSelect.instance:fillList();
                MapSpawnSelect.instance.previousScreen = "NewGameScreen"
                MapSpawnSelect.instance:setVisible(true, self.joyfocus);
            else
                MapSpawnSelect.instance:useDefaultSpawnRegion()
                MainScreen.instance.charCreationProfession.previousScreen = "NewGameScreen";
                MainScreen.instance.charCreationProfession:setVisible(true, self.joyfocus);
            end
        elseif #MainScreen.instance.lastStandPlayerSelect.listbox.items > 0 then
            createWorld(worldName);
            MainScreen.instance.lastStandPlayerSelect:setVisible(true, self.joyfocus);
        else
            createWorld(worldName);
            MapSpawnSelect.instance:useDefaultSpawnRegion()
            MainScreen.instance.charCreationProfession.previousScreen = "NewGameScreen"
            MainScreen.instance.charCreationProfession:setVisible(true, self.joyfocus);
        end
        return;
    end

    if self.selectedItem.mode ~= "Sandbox" then
        MainScreen.instance:setSandboxPreset(MainScreen.instance.sandOptions:getSandboxPreset(self.selectedItem.mode));
        getWorld():setPreset(self.selectedItem.mode)
    end

    getWorld():setMap("DEFAULT")
    MainScreen.instance.createWorld = true;
    if getWorld():getGameMode() == "Sandbox" then
        if WorldSelect.instance:hasChoices() then
            WorldSelect.instance:fillList()
            WorldSelect.instance.previousScreen = "NewGameScreen"
            WorldSelect.instance:setVisible(true, self.joyfocus)
        elseif MainScreen.instance.createWorld or MapSpawnSelect.instance:hasChoices() then
            MapSpawnSelect.instance:fillList()
            MapSpawnSelect.instance.previousScreen = "NewGameScreen"
            MapSpawnSelect.instance:setVisible(true, self.joyfocus)
        else
            MapSpawnSelect.instance:useDefaultSpawnRegion()
            MainScreen.instance.sandOptions:setVisible(true, self.joyfocus)
        end
    else
        if WorldSelect.instance:hasChoices() then
            WorldSelect.instance:fillList()
            WorldSelect.instance.previousScreen = "NewGameScreen"
            WorldSelect.instance:setVisible(true, self.joyfocus)
        elseif MainScreen.instance.createWorld or MapSpawnSelect.instance:hasChoices() then
            MapSpawnSelect.instance:fillList()
            MapSpawnSelect.instance.previousScreen = "NewGameScreen"
            MapSpawnSelect.instance:setVisible(true, self.joyfocus)
        else
            MapSpawnSelect.instance:useDefaultSpawnRegion()
            MainScreen.instance.charCreationProfession.previousScreen = "NewGameScreen"
            MainScreen.instance.charCreationProfession:setVisible(true, self.joyfocus)
        end
    end
end

function NewGameScreen:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData);
    joypadData.focus = self.mainPanel
    updateJoypadFocus(joypadData)
end

function NewGameScreen:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self.backButton:clearJoypadButton()
    self.nextButton:clearJoypadButton()
end

function NewGameScreen:Label_setJoypadFocused(focused, joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self.joypadFocused = focused
    self:onMouseDown(0, 0)
end

function NewGameScreen:onResolutionChange(oldw, oldh, neww, newh)
    local width = math.min(self.mainPanelReqWidth, self.width / 2 + 90 - self.mainPanel.x)
    self.mainPanel:setWidth(width)
end

function NewGameScreen:onResetLua(reason)
    if reason == "NewGameMods" then
        MainScreen.instance.bottomPanel:setVisible(false)
        if DebugScenarios.instance ~= nil then
            MainScreen.instance:removeChild(DebugScenarios.instance);
            DebugScenarios.instance = nil;
        end
        self.onMenuItemMouseDown(self.survival, 0, 0)
        self:setVisible(true)
        reactivateJoypadAfterResetLua()
        local joypadData = JoypadState.getMainMenuJoypad()
        if not joypadData then
            joypadData = JoypadState.joypads[1]
        end
        if joypadData and joypadData:isConnected() then
            joypadData.inMainMenu = true
            joypadData.focus = self
        end
    end
end

function NewGameScreen:onJoypadNavigateStart_Descendant(descendant, joypadData)
	self.mainPanel.joypadNavigate = { right = self.richText }
	self.richText.joypadNavigate = { left = self.mainPanel }
end

function NewGameScreen:onJoypadBeforeDeactivate(joypadData)
	self.backButton:clearJoypadButton()
	self.nextButton:clearJoypadButton()
end

function NewGameScreen:onKeyRelease(key)
    if key == Keyboard.KEY_ESCAPE then
        self.backButton:forceClick()
        return
    end
    if key == Keyboard.KEY_RETURN then
        self.nextButton:forceClick()
        return
    end
end

function NewGameScreen:new (x, y, width, height)
	local o = ISPanelJoypad.new(self, x, y, width, height);
	o.backgroundColor = {r=0, g=0, b=0, a=0.8};
	o.borderColor = {r=1, g=1, b=1, a=0.2};
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
	o.itemheightoverride = {}
	o.selected = 1;
    o.startY = UI_BORDER_SPACING*2+1 + FONT_HGT_LARGE;
	NewGameScreen.instance = o;
	return o
end

Events.OnResetLua.Add(function(reason) NewGameScreen.instance:onResetLua(reason) end)
