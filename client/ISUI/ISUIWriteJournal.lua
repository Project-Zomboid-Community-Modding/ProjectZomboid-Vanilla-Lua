--***********************************************************
--**              	  ROBERT JOHNSON                       **
--***********************************************************

ISUIWriteJournal = ISCollapsableWindowJoypad:derive("ISUIWriteJournal");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)

--************************************************************************--
--** ISUIWriteJournal:initialise
--**
--************************************************************************--

function ISUIWriteJournal:initialise()
    ISCollapsableWindowJoypad.initialise(self);

--    self.winwo = self:wrapInCollapsableWindow();
--    self.winwo:addToUIManager();
--    self.winwo.closeButton:setVisible(false);
--    self.winwo:setX(self.x);
--    self.winwo:setY(self.y);

    local btnWid = 100
    local btnHgt = math.max(FONT_HGT_SMALL + 3 * 2, 25)
    local padBottom = 10

    self.title = ISTextEntryBox:new(self.title, self:getWidth() / 2 - ((self:getWidth() - 20) / 2), 20, self:getWidth() - 20, 2 + self.fontHgt + 2);
    self.title:initialise();
    self.title:instantiate();
    self.title.javaObject:setMaxTextLength(100);
    self:addChild(self.title);
    if self.locked then
        self.title:setEditable(false);
    end

    local inset = 2
    local height = inset + self.lineNumber * self.fontHgt + inset
    self.entry = ISTextEntryBox:new(self.defaultEntryText, self:getWidth() / 2 - ((self:getWidth() - 20) / 2), self.title:getBottom() + 4, self:getWidth() - 20, height);
    self.entry:initialise();
    self.entry:instantiate();
    self.entry:setMultipleLine(true);
    self.entry.javaObject:setMaxLines(self.lineNumber);
    self.entry.javaObject:setMaxTextLength(self.maxTextLength);
    self:addChild(self.entry);
    if self.locked then
        self.entry:setEditable(false);
    end

    local bottom = self.entry:getBottom()
    local btnHgt2 = math.max(FONT_HGT_SMALL, 20)

    if not self.locked then
        self.deleteButton = ISButton:new(self.entry.x, self.entry:getBottom() + 4, btnHgt2, btnHgt2, "", self, ISUIWriteJournal.onClick);
        self.deleteButton.internal = "DELETEPAGE";
        self.deleteButton:initialise();
        self.deleteButton:instantiate();
        self.deleteButton.borderColor = {r=1, g=1, b=1, a=0.1};
        self.deleteButton:setImage(getTexture("media/ui/trashIcon.png"));
        self.deleteButton:setTooltip(getText("Tooltip_Journal_Erase"));
        self:addChild(self.deleteButton);

        self.lockButton = ISButton:new(self.deleteButton.x + self.deleteButton.width + 3, self.deleteButton.y, btnHgt2, btnHgt2, "", self, ISUIWriteJournal.onClick);
        self.lockButton.internal = "LOCKBOOK";
        self.lockButton:initialise();
        self.lockButton:instantiate();
        self.lockButton.borderColor = {r=1, g=1, b=1, a=0.1};
        self.lockButton:setImage(getTexture("media/ui/lockOpen.png"));
        self.lockButton:setTooltip(getText("Tooltip_Journal_Lock"));
        self:addChild(self.lockButton);

        if self.notebook:getLockedBy() then
            self.lockButton.internal = "UNLOCKBOOK";
            self.lockButton:setImage(getTexture("media/ui/lock.png"));
            self.lockButton:setTooltip(getText("Tooltip_Journal_UnLock"));
            self.entry:setEditable(false);
            self.title:setEditable(false);
        end

        bottom = self.deleteButton:getBottom()
    end

    if self.numberOfPages > 1 then
        self.pageLabel = ISLabel:new (self.entry.x + self.entry.width, self.entry:getBottom() + 4, FONT_HGT_SMALL, getText("IGUI_Pages") .. self.currentPage .. "/" .. self.numberOfPages, 1, 1, 1, 1, UIFont.Small, false);
        self.pageLabel:initialise();
        self.pageLabel:instantiate();
        self:addChild(self.pageLabel);

        self.nextPage = ISButton:new(self.width / 2 + 3, self.pageLabel.y, btnHgt2, btnHgt2, ">", self, ISUIWriteJournal.onClick);
        self.nextPage.internal = "NEXTPAGE";
        self.nextPage:initialise();
        self.nextPage:instantiate();
        self.nextPage.borderColor = {r=1, g=1, b=1, a=0.1};
        self:addChild(self.nextPage);

        self.previousPage = ISButton:new(self.nextPage.x - btnHgt2 - 3, self.nextPage.y, btnHgt2, btnHgt2, "<", self, ISUIWriteJournal.onClick);
        self.previousPage.internal = "PREVIOUSPAGE";
        self.previousPage:initialise();
        self.previousPage:instantiate();
        self.previousPage.borderColor = {r=1, g=1, b=1, a=0.1};
        self.previousPage:setEnable(false);
        self:addChild(self.previousPage);

        bottom = math.max(bottom, self.pageLabel:getBottom())
    end

    self.yes = ISButton:new((self:getWidth() / 2) - btnWid - 5, bottom + 5, btnWid, btnHgt, getText("UI_Ok"), self, ISUIWriteJournal.onClick);
    self.yes.internal = "OK";
    self.yes:initialise();
    self.yes:instantiate();
    self.yes.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.yes);

    self.no = ISButton:new((self:getWidth() / 2) + 5, bottom + 5, btnWid, btnHgt, getText("UI_Cancel"), self, ISUIWriteJournal.onClick);
    self.no.internal = "CANCEL";
    self.no:initialise();
    self.no:instantiate();
    self.no.borderColor = {r=1, g=1, b=1, a=0.1};
    self:addChild(self.no);

    self:setHeight(self.yes:getBottom() + padBottom)
end

function ISUIWriteJournal:close()
    self:destroy()
end

function ISUIWriteJournal:destroy()
    UIManager.setShowPausedMessage(true);
    self:setVisible(false);
    self:removeFromUIManager();
    if UIManager.getSpeedControls() then
        UIManager.getSpeedControls():SetCurrentGameSpeed(1);
    end
    if JoypadState.players[self.playerNum+1] then
        local inv = getPlayerInventory(self.playerNum)
        setJoypadFocus(self.playerNum, inv:isReallyVisible() and inv or nil)
    end
end

function ISUIWriteJournal:setJoypadButtons(joypadData)
    if not joypadData then return end
    local isUnlocked = self.lockButton.internal == "LOCKBOOK"
    local firstShown = self.isUnlocked == nil
    if isUnlocked == self.isUnlocked then return end
    self.isUnlocked = isUnlocked
    self:clearJoypadFocus(joypadData)
    self.joypadButtonsY = {}
    local buttons = {}
    if isUnlocked then
        self:insertNewLineOfButtons(self.title)
        self:insertNewLineOfButtons(self.entry)
        if self.locked then
            self.joypadIndexY = 1
        else
            table.insert(buttons, self.deleteButton)
            table.insert(buttons, self.lockButton)
            self.joypadIndexY = 3
        end
    else
        if not self.locked then
            table.insert(buttons, self.deleteButton)
            table.insert(buttons, self.lockButton)
            self.joypadIndexY = 1
        end
    end
    if self.nextPage then
        table.insert(buttons, self.previousPage)
        table.insert(buttons, self.nextPage)
    end
    if #buttons > 0 then
        self:insertNewListOfButtons(buttons)
    end
    if firstShown then
        self.joypadIndexY = 1
    end
    self.joypadButtons = self.joypadButtonsY[self.joypadIndexY]
    self.joypadIndex = math.min(math.max(self.joypadIndex, 1), #self.joypadButtons)
    self:restoreJoypadFocus(joypadData)
end

function ISUIWriteJournal:onClick(button)
    if button.internal == "NEXTPAGE" then
--        print("add at pos " .. self.currentPage .. " text " .. self.entry:getText())
        self.newPage[self.currentPage] = self.entry:getText();
        self.currentPage = self.currentPage + 1;
        if self.currentPage == self.numberOfPages then
            self.nextPage:setEnable(false);
        else
            self.nextPage:setEnable(true);
        end
        self.previousPage:setEnable(true);
        self.entry.javaObject:setCursorLine(0);
        self.entry:setText(self.newPage[self.currentPage]);
    elseif button.internal == "PREVIOUSPAGE" then
        self.newPage[self.currentPage] = self.entry:getText();
        self.currentPage = self.currentPage - 1;
        if self.currentPage == 1 then
            self.previousPage:setEnable(false);
        else
            self.previousPage:setEnable(true);
        end
        self.nextPage:setEnable(true);
--        print("set text from pos " .. self.currentPage .. " text " .. self.newPage[self.currentPage]);
        self.entry.javaObject:setCursorLine(0);
        self.entry:setText(self.newPage[self.currentPage]);
    elseif button.internal == "DELETEPAGE" then
        self.newPage[self.currentPage] = "";
        self.entry:setText("");
        self.entry.javaObject:setCursorLine(0);
    elseif button.internal == "LOCKBOOK" then
        self.lockButton:setImage(getTexture("media/ui/lock.png"));
        self.lockButton.internal = "UNLOCKBOOK";
        self.notebook:setLockedBy(self.character:getUsername());
        self.title:setEditable(false);
        self.entry:setEditable(false);
        self.lockButton:setTooltip("Allow the journal to be edited");
        self:setJoypadButtons(self.joyfocus)
    elseif button.internal == "UNLOCKBOOK" then
        self.lockButton:setImage(getTexture("media/ui/lockOpen.png"));
        self.lockButton.internal = "LOCKBOOK";
        self.notebook:setLockedBy(nil);
        self.title:setEditable(true);
        self.entry:setEditable(true);
        self.lockButton:setTooltip("Prevent the journal from being edited");
        self:setJoypadButtons(self.joyfocus)
    else
        self.newPage[self.currentPage] = self.entry:getText();
        self:destroy();
        if self.onclick ~= nil then
            self.onclick(self.target, button, self.param1, self.param2);
        end
    end

    if self.pageLabel then
        self.pageLabel.name = getText("IGUI_Pages") .. self.currentPage .. "/" .. self.numberOfPages;
        self.pageLabel:setX(self.entry:getRight() - getTextManager():MeasureStringX(self.pageLabel.font, self.pageLabel.name))
    end

    self.pinButton:setVisible(false);
end

function ISUIWriteJournal:prerender()
    self.pinButton:setVisible(false);
    self.collapseButton:setVisible(false);
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
    self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
end

--************************************************************************--
--** ISUIWriteJournal:render
--**
--************************************************************************--
function ISUIWriteJournal:render()
    if self.joyfocus then
        if self.joypadIndexY <= #self.joypadButtonsY then
            self.ISButtonA = nil
            self.ISButtonB = nil
            self.yes:clearJoypadButton()
            self.no:clearJoypadButton()
        else
            self:setISButtonForA(self.yes)
            self:setISButtonForB(self.no)
        end
    end
end

function ISUIWriteJournal:onGainJoypadFocus(joypadData)
    ISCollapsableWindowJoypad.onGainJoypadFocus(self, joypadData)
--    self:setISButtonForA(self.yes)
--   self:setISButtonForB(self.no)
    self.yes:setJoypadButton(Joypad.Texture.AButton)
    self.no:setJoypadButton(Joypad.Texture.BButton)
    self:setJoypadButtons(joypadData)
end

function ISUIWriteJournal:onJoypadDown(button, joypadData)
    ISPanelJoypad.onJoypadDown(self, button, joypadData)
--[[
    if button == Joypad.AButton then
        self.yes:forceClick()
    end
    if button == Joypad.BButton then
        self.no:forceClick()
    end
--]]
end

function ISUIWriteJournal:onJoypadDirUp(joypadData)
    if self.joypadIndexY == #self.joypadButtonsY + 1 then
        self.joypadIndexY = #self.joypadButtonsY
        self:restoreJoypadFocus(joypadData)
        return
    end
    ISCollapsableWindowJoypad.onJoypadDirUp(self, joypadData)
end

function ISUIWriteJournal:onJoypadDirDown(joypadData)
    if self.joypadIndexY == #self.joypadButtonsY then
        self:clearJoypadFocus(joypadData)
        self.joypadIndexY = #self.joypadButtonsY + 1
        return
    end
    ISCollapsableWindowJoypad.onJoypadDirDown(self, joypadData)
end

--************************************************************************--
--** ISUIWriteJournal:new
--**
--************************************************************************--
function ISUIWriteJournal:new(x, y, width, height, target, onclick, character, notebook, defaultEntryText, title, lineNumber, editable, numberOfPages)
    local o = {}
    o = ISCollapsableWindowJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    if y == 0 then
        o.y = (getCore():getScreenHeight() / 2) - (height / 2);
        o:setY(o.y);
    end
    if x == 0 then
        o.x = (getCore():getScreenWidth() / 2) - (width / 2);
        o:setX(o.x);
    end
    o.name = nil;
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.width = width;
    local txtWidth = getTextManager():MeasureStringX(UIFont.Small, text) + 10;
    if width < txtWidth then
        o.width = txtWidth;
    end
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = true;
    o.anchorTop = true;
    o.anchorBottom = true;
    o.title = title;
    o.target = target;
    o.onclick = onclick;
    o.character = character;
    o.playerNum = character:getPlayerNum()
    o.defaultEntryText = defaultEntryText or "";
    o.lineNumber = lineNumber;
    o.maxTextLength = lineNumber * 80;
    o.editable = editable;
    o.text = text;
    o.numberOfPages = numberOfPages;
    o.currentPage = 1;
    o.notebook = notebook;
    o.newPage = {};
    o.fontHgt = getTextManager():getFontFromEnum(UIFont.Small):getLineHeight()
    for i=0,notebook:getCustomPages():size() - 1 do
        o.newPage[i + 1] = notebook:seePage(i + 1);
    end
    o.locked = not editable;
    if notebook:getLockedBy() and notebook:getLockedBy() ~= character:getUsername() and not isAdmin() then
        o.locked = true;
        o.numberOfPages = notebook:getCustomPages():size();
    end
    return o;
end

