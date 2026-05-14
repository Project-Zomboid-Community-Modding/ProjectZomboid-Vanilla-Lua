local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.NewSmall)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.NewMedium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.NewLarge)
local BUTTON_HGT = FONT_HGT_SMALL + 6
local JOYPAD_TEX_SIZE = 32
local UI_BORDER_SPACING = 10
local VIDEO_SOURCE_WIDTH = 1920
local VIDEO_SOURCE_HEIGHT = 658
local PANEL_COUNT = 6
local DATA_SHIFT_NUM = PANEL_COUNT

local ModePanel = ISPanel:derive("ModePanel")

function ModePanel:createChildren()
    self.richText = ISRichTextPanel:new(0, 0, self.width, self.height)
    self.richText:initialise()
    self.richText.background = false
    self.richText.clip = true
    self.richText:setMargins(0, 0, 0, 0)
    self.richText.onMouseDown = self.onMouseDownRichText
    self:addChild(self.richText)
end

function ModePanel:setData(data)
    self.data = data
    if not data then
        self.texture = nil
        self.title = nil
        self.richText.text = ""
        self.richText.textRaw = ""
        self.richText:paginate()
        self.selected = false
        self.centerThumbnail = false
        return
    end

    self.texture = getTexture(data.thumb)
    self.title = getText(data.title)
    self.richText.textRaw = getText(data.desc)
    self.centerThumbnail = data.centerThumbnail
    self.mode = data.mode
    self:updateView()
end

function ModePanel:updateView()
    local texCoeff = self.texture ~= nil and self.texture:getWidth() / self.texture:getHeight() or 1
    self.textureHeight = self.parent.smallResolution and self.height / 3 or self.parent.mediumResolution and self.height / 2.5 or self.height / 2
    self.textureWidth = self.textureHeight * texCoeff
    if self.textureWidth > (self.width - UI_BORDER_SPACING * 2) then
        self.textureWidth = self.width - UI_BORDER_SPACING * 2
        self.textureHeight = self.textureWidth / texCoeff
    end
    self.textureX = self.width / 2 - self.textureWidth / 2

    local richTextMargin = UI_BORDER_SPACING / 2
    self.richText:setX(richTextMargin)
    self.richText:setY(UI_BORDER_SPACING * 2 + self.textureHeight + 20)
    self.richText:setWidth(self.width -  richTextMargin * 2)
    self.richText:setHeight(self.height / 2)
    self.richText.text = string.format(" <CENTRE> <SIZE:%s> %s", self.parent.smallResolution and "small" or self.parent.mediumResolution and "medium" or "large", self.richText.textRaw)
    self.richText:paginate()
end

function ModePanel:render()
    if not self.title then
        self.borderColor.a = 0
        self.backgroundColor.a = 0
        return
    end
    local alpha = self.selected and 1.0 or (self.mouseOver and 0.8 or 0.5)
    self.backgroundColor.a = 0.5
    self.borderColor = self.selected and self.borderColorMouseOver or self.borderColorInactive
    self.borderColor.a = alpha
    self:drawTextCentre(getText(self.title), self.width / 2, 2, 1, 1, 1, alpha, self.parent.smallResolution and UIFont.NewSmall or self.parent.mediumResolution and UIFont.NewMedium or UIFont.NewLarge)
    self.richText.contentTransparency = alpha
    if self.texture then
        local textureY = (self.parent.smallResolution and FONT_HGT_SMALL or self.parent.mediumResolution and FONT_HGT_MEDIUM or FONT_HGT_LARGE) + 3
        if self.centerThumbnail then
            textureY = self.height / 2 - self.textureHeight / 2
        end
        self:drawTextureScaled(self.texture, self.textureX, textureY, self.textureWidth, self.textureHeight, alpha, 1, 1, 1)
    end
end

function ModePanel:onMouseMove(dx, dy)
    self.mouseOver = self:isMouseOver()
end

function ModePanel:onMouseMoveOutside(dx, dy)
    self.mouseOver = false
end

function ModePanel:onMouseDoubleClick(x, y)
    if self.title then
        self.callback(self.target, self, x, y)
        self.parent:clickPlay()
    end
end

function ModePanel:onMouseDown(x, y)
    if self.title then
        self.callback(self.target, self, x, y)
    end
end

function ModePanel:onMouseDownRichText(x, y)
    self.parent.callback(self.parent.target, self.parent, x, y)
end

function ModePanel:setSelected(val)
    self.selected = val
end

function ModePanel:new(x, y, width, height, target, callback)
    local o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self

    o.mouseOver = false
    o.selected = false

    o.texture = nil
    o.data = nil
    o.title = "NONE"

    o.borderColorMouseOver = {r=1, g=1, b=1, a=1}
    o.borderColorInactive = {r=0.4, g=0.4, b=0.4, a=0.5}

    o.target = target
    o.callback = callback

    return o
end

NewGameScreen = ISPanelJoypad:derive("NewGameScreen")

function NewGameScreen:clickChallenges()
    self.gameModeData = {}
    self.dataShift = 0
    self:loadChallenges()
    self:selectNewPanel(1)
    self:updatePanels()
    self:updatePreview()
    self.inChallengesView = true
end

function NewGameScreen:create()
    local btnPadding = JOYPAD_TEX_SIZE + UI_BORDER_SPACING*2
    local btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.NewSmall, getText("UI_btn_back"))
    self.backButton = ISButton:new(UI_BORDER_SPACING+1, self.height - UI_BORDER_SPACING - BUTTON_HGT - 1, btnWidth, BUTTON_HGT, getText("UI_btn_back"), self, NewGameScreen.onOptionMouseDown)
    self.backButton.internal = "BACK"
    self.backButton:initialise()
    self.backButton:instantiate()
    self.backButton:setAnchorsTBLR(false, true, true, false)
    self.backButton.borderColor = {r=1, g=1, b=1, a=0.1}
    self.backButton:setFont(UIFont.NewSmall)
    self.backButton:ignoreWidthChange()
    self.backButton:ignoreHeightChange()
    self.backButton:enableCancelColor()
    self:addChild(self.backButton)

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.NewSmall, getText("UI_btn_next"))
    self.nextButton = ISButton:new(self.width - UI_BORDER_SPACING - btnWidth - 1, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_btn_next"), self, NewGameScreen.onOptionMouseDown)
    self.nextButton.internal = "NEXT"
    self.nextButton:initialise()
    self.nextButton:instantiate()
    self.nextButton:setAnchorsTBLR(false, true, false, true)
    self.nextButton:enableAcceptColor()
    self.nextButton:setFont(UIFont.NewSmall)
    self.nextButton:ignoreWidthChange()
    self.nextButton:ignoreHeightChange()
    self:addChild(self.nextButton)

    btnWidth = btnPadding + getTextManager():MeasureStringX(UIFont.NewSmall, getText("UI_NewGame_ChooseMods"))
    self.modsButton = ISButton:new(self.nextButton.x - UI_BORDER_SPACING - btnWidth - 1, self.backButton.y, btnWidth, BUTTON_HGT, getText("UI_NewGame_ChooseMods"), self, NewGameScreen.onOptionMouseDown)
    self.modsButton.internal = "MODS"
    self.modsButton:initialise()
    self.modsButton:instantiate()
    self.modsButton:setAnchorsTBLR(false, true, false, true)
    self.modsButton:setFont(UIFont.NewSmall)
    self.modsButton:ignoreWidthChange()
    self.modsButton:ignoreHeightChange()
    self:addChild(self.modsButton)

    self.titleLabel = ISLabel:new(self.width / 2, UI_BORDER_SPACING / 2, FONT_HGT_SMALL, getText("UI_NewGameScreen_title"), 1.0, 1.0, 1.0, 1.0, UIFont.NewLarge, true)
    self.titleLabel:initialise()
    self.titleLabel:instantiate()
    self.titleLabel:setAnchorsTBLR(true, false, true, false)
    self.titleLabel:setWidthToName()
    self.titleLabel:setX(self.width / 2 - self.titleLabel.width / 2)
    self:addChild(self.titleLabel)

    self:calcViewDimensions()

    self.richText = ISRichTextPanel:new(self.viewDimensions.x, self.viewDimensions.y, self.viewDimensions.previewWidth, self.viewDimensions.previewHeight)
    self.richText:initialise()
    self.richText.background = false
    self.richText.autosetheight = false
    self.richText.clip = true
    self.richText:setMargins(0, 0, 0, 0)
    self:addChild(self.richText)

    self.panels = {}
    for i = 1, PANEL_COUNT do
        local ui = ModePanel:new(0, 0, 100, 100, self, NewGameScreen.onItemClick)
        ui:initialise()
        ui:instantiate()
        self:addChild(ui)
        table.insert(self.panels, ui)
    end

    self.selectedItem = self.panels[1]
    self:updatePanels()
    self:onResolutionChange()

    self:setVisible(false)
end

function NewGameScreen:loadChallenges()
    table.sort(LastStandChallenge, function(a,b) return a.name < b.name end)
    for i, info in ipairs(LastStandChallenge) do
        table.insert(self.gameModeData, {
            mode = info.name,
            title = info.name,
            desc = info.description or "NO DESCRIPTION",
            thumb = info.image,
            video = info.video,

            internal = info.name,
            challenge = info
        })
    end
end

function NewGameScreen:calcViewDimensions()
    local wDelta = 0 + (self.width - self.height * (16 / 9))
    wDelta = wDelta < 0 and 0 or wDelta

    local previewWidth = self.width - UI_BORDER_SPACING * 2 - wDelta
    local previewHeight = previewWidth * (VIDEO_SOURCE_HEIGHT / VIDEO_SOURCE_WIDTH)
    local newHeight = PZMath.clamp(previewHeight, 0, self.height * (self.smallResolution and 0.55 or self.mediumResolution and 0.6 or 0.65))
    previewWidth = previewWidth * (newHeight / previewHeight) - UI_BORDER_SPACING
    previewHeight = newHeight

    self.viewDimensions = {
        x = UI_BORDER_SPACING,
        y = self.titleLabel:getBottom() + UI_BORDER_SPACING / 2,
        previewWidth = previewWidth,
        previewHeight = previewHeight,
        panelWidth = ((self.richText and self.richText:getRight() or self.width) / PANEL_COUNT)  - UI_BORDER_SPACING,
    }
end

function NewGameScreen:updatePanels()
    local content = {}

    for i = 1, PANEL_COUNT do
        table.insert(content, self.gameModeData[i + self.dataShift])
    end
    if self.dataShift > 0 then
        table.insert(content, 1, self.prevData)
    end
    if self.dataShift < #self.gameModeData - PANEL_COUNT then
        table.insert(content, PANEL_COUNT, self.nextData)
    end
    for i, panel in ipairs(self.panels) do
        panel:setData(content[i])
    end
end

function NewGameScreen:onItemDblClick(item, x, y)
    self:onItemClick(item, x, y)
    self:clickPlay()
end

function NewGameScreen:onItemClick(item, x, y)
    getSoundManager():playUISound("UIActivateMainMenuItem")

    for _, panel in ipairs(self.panels) do
        panel:setSelected(false)
    end

    if item.data then
        if item.data.mode == "PREV" then
            self.dataShift = self.dataShift - (DATA_SHIFT_NUM)
            if self.dataShift < 0 then
                self.dataShift = 0
            end
            self.selectedItem = self.panels[PANEL_COUNT - 1]
            self.selectedJoypad = PANEL_COUNT - 1
            self.selectedItem:setSelected(true)
            self:updatePanels()
        elseif item.data.mode == "NEXT" then
            self.dataShift = self.dataShift + DATA_SHIFT_NUM
            if self.dataShift > #self.gameModeData - PANEL_COUNT + 1 then
                self.dataShift = #self.gameModeData - PANEL_COUNT + 1
            end
            self.selectedItem = self.panels[2]
            self.selectedJoypad = 2
            self.selectedItem:setSelected(true)
            self:updatePanels()
        else
            self.selectedItem = item
            item:setSelected(true)
        end
    end
    self:updatePreview()
end

function NewGameScreen:updatePreview()
    if self.selectedItem.data and self.selectedItem.data.video and self.selectedItem.data.thumb then
        self.richText.text = string.format(" <VIDEOCENTRE:%s,%u,%u,%u,%u,%s> ", self.selectedItem.data.video, VIDEO_SOURCE_WIDTH, VIDEO_SOURCE_HEIGHT, self.viewDimensions.previewWidth, self.viewDimensions.previewHeight, self.selectedItem.data.thumb)
        self.richText:paginate()
    end
end

function NewGameScreen:update()
    self.nextButton:setEnable(self.selectedItem ~= nil)
    self.nextButton:setTooltip(nil)
end

function NewGameScreen:prerender()
    ISPanelJoypad.prerender(self)
    self:drawRectBorder(self.richText.x-1, self.richText.y-1, self.richText.width+2, self.richText.height+10, 0.9, 0.3, 0.3, 0.3)
end

function NewGameScreen:setVisible(visible, joypadData)
    ISPanelJoypad.setVisible(self, visible, joypadData)
    if visible then
        self.selectedJoypad = 1
        self:selectNewPanel(1)
        self:updatePanels()
        self:updatePreview()
    end
end

function NewGameScreen:onOptionMouseDown(button, x, y)
    if self.selectedItem.data and self.selectedItem.data.arrowButton then
        self:onItemClick(self.selectedItem, x, y)
        return
    end
    if button.internal == "BACK" then
        if self.inChallengesView then
            self.gameModeData = NewGameScreen.defaultGameModeData
            self.dataShift = 0
            for i, panel in ipairs(self.panels) do
                if panel.mode == GameMode.CHALLENGES:toString() then
                    self.selectedItem = self.panels[i]
                    self.panels[i].selected = true
                    self.selectedJoypad = i
                else
                    self.panels[i].selected = false
                end
            end
            self:updatePanels()
            self:updatePreview()
            self.inChallengesView = false
            return
        end
        MainScreen.resetLuaIfNeeded()
        self:setVisible(false)
        MainScreen.instance.bottomPanel:setVisible(true)
        if self.joyfocus then
            self:clearJoypadFocus(self.joyfocus)
            self.joypadIndex = 1
            self.joypadIndexY = 1
            self.joypadButtons = self.joypadButtonsY[self.joypadIndexY]
            self.joyfocus.focus = MainScreen.instance
            updateJoypadFocus(self.joyfocus)
        end
    end
    if button.internal == "NEXT" then
        self:clickPlay()
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
    if self.selectedItem.data.arrowButton then
        return;
    end
    if self.selectedItem.data.mode == GameMode.CHALLENGES:toString() and not self.inChallengesView then
        self:clickChallenges()
        return
    end

    self:setVisible(false)

    local mainScreenInstance = MainScreen.instance
    local mapSpawnSelectInstance = MapSpawnSelect.instance
    local worldSelectInstance = WorldSelect.instance

    mainScreenInstance.charCreationProfession.previousScreen = "NewGameScreen"
    getWorld():setGameMode(self.selectedItem.data.mode)

    mainScreenInstance:setDefaultSandboxVars()

    if self.selectedItem.data.challenge then
        LastStandData.chosenChallenge = self.selectedItem.data.challenge
        local worldName = ZombRand(100000)..ZombRand(100000)..ZombRand(100000)..ZombRand(100000)
        doChallenge(self.selectedItem.data.challenge)
        getWorld():setWorld(worldName)
        if getCore():getGameMode() ~= "LastStand" then
            mainScreenInstance.createWorld = true
            if mapSpawnSelectInstance:hasChoices() then
                mapSpawnSelectInstance:fillList()
                mapSpawnSelectInstance.previousScreen = "NewGameScreen"
                mapSpawnSelectInstance:setVisible(true, self.joyfocus)
            else
                mapSpawnSelectInstance:useDefaultSpawnRegion()
                mainScreenInstance.charCreationProfession.previousScreen = "NewGameScreen"
                mainScreenInstance.charCreationProfession:setVisible(true, self.joyfocus)
            end
        elseif #mainScreenInstance.lastStandPlayerSelect.listbox.items > 0 then
            createWorld(worldName)
            mainScreenInstance.lastStandPlayerSelect:setVisible(true, self.joyfocus)
        else
            createWorld(worldName)
            mapSpawnSelectInstance:useDefaultSpawnRegion()
            mainScreenInstance.charCreationProfession.previousScreen = "NewGameScreen"
            mainScreenInstance.charCreationProfession:setVisible(true, self.joyfocus)
        end
        mapSpawnSelectInstance:saveGenParams()
        return
    end

    if self.selectedItem.data.mode ~= GameMode.SANDBOX:toString() then
        mainScreenInstance:setSandboxPreset(mainScreenInstance.sandOptions:getSandboxPreset(self.selectedItem.data.mode))
        getWorld():setPreset(self.selectedItem.data.mode)
    end

    getWorld():setMap("DEFAULT")
    mainScreenInstance.createWorld = true
    if getWorld():getGameMode() == GameMode.SANDBOX:toString() then
        if worldSelectInstance:hasChoices() then
            worldSelectInstance:fillList()
            worldSelectInstance.previousScreen = "NewGameScreen"
            worldSelectInstance:setVisible(true, self.joyfocus)
        elseif mainScreenInstance.createWorld or mapSpawnSelectInstance:hasChoices() then
            mapSpawnSelectInstance:fillList()
            mapSpawnSelectInstance.previousScreen = "NewGameScreen"
            mapSpawnSelectInstance:setVisible(true, self.joyfocus)
        else
            mapSpawnSelectInstance:useDefaultSpawnRegion()
            mainScreenInstance.sandOptions:setVisible(true, self.joyfocus)
        end
    else
        if worldSelectInstance:hasChoices() then
            worldSelectInstance:fillList()
            worldSelectInstance.previousScreen = "NewGameScreen"
            worldSelectInstance:setVisible(true, self.joyfocus)
        elseif mainScreenInstance.createWorld or mapSpawnSelectInstance:hasChoices() then
            mapSpawnSelectInstance:fillList()
            mapSpawnSelectInstance.previousScreen = "NewGameScreen"
            mapSpawnSelectInstance:setVisible(true, self.joyfocus)
        else
            mapSpawnSelectInstance:useDefaultSpawnRegion()
            mainScreenInstance.charCreationProfession.previousScreen = "NewGameScreen"
            mainScreenInstance.charCreationProfession:setVisible(true, self.joyfocus)
        end
    end
end

function NewGameScreen:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
    self:setISButtonForA(self.nextButton)
    self:setISButtonForB(self.backButton)
    self:setISButtonForY(self.modsButton)
    self.selectedJoypad = 1
end

function NewGameScreen:onLoseJoypadFocus(joypadData)
    ISPanelJoypad.onLoseJoypadFocus(self, joypadData)
    self.backButton:clearJoypadButton()
    self.nextButton:clearJoypadButton()
    self.modsButton:clearJoypadButton()
end

function NewGameScreen:onJoypadDirLeft(joypadData)
    self.selectedJoypad = self.selectedJoypad - 1
    if not self.panels[self.selectedJoypad] or not self.panels[self.selectedJoypad].title then
        self.selectedJoypad = self:findLastPanel()
    end
    self:selectNewPanel(self.selectedJoypad)
    self:updatePreview()
end

function NewGameScreen:onJoypadDirRight(joypadData)
    self.selectedJoypad = self.selectedJoypad + 1
    if not self.panels[self.selectedJoypad] or not self.panels[self.selectedJoypad].title then
        self.selectedJoypad = 1
    end
    self:selectNewPanel(self.selectedJoypad)
    self:updatePreview()
end

function NewGameScreen:selectNewPanel(index)
    for _, panel in ipairs(self.panels) do
        panel.selected = false
    end
    self.selectedItem = self.panels[index]
    self.panels[index].selected = true
    self.selectedJoypad = index
end

function NewGameScreen:findLastPanel()
    for i = #self.panels, 1, -1 do
        if self.panels[i] and self.panels[i].title then
            return i
        end
    end
    return 1
end

function NewGameScreen:onResolutionChange()
    self.smallResolution = getCore():getScreenWidth() <= 1600
    self.mediumResolution = getCore():getScreenWidth() <= 1920

    self.titleLabel.font = self.smallResolution and UIFont.NewSmall or self.mediumResolution and UIFont.NewMedium or UIFont.NewLarge
    self.titleLabel:setWidthToName()
    self.titleLabel:setX(self.width / 2 - self.titleLabel.width / 2)

    self:calcViewDimensions()
    self.richText:setX(self.viewDimensions.x)
    self.richText:setY(self.viewDimensions.y)
    self.richText:setWidth(self.width - (UI_BORDER_SPACING * 2))
    self.richText:setHeight(self.viewDimensions.previewHeight)
    self:calcViewDimensions()
    self:updatePreview()

    local marginUnderVideo = 6

    for i, panel in ipairs(self.panels) do
        panel:setX(UI_BORDER_SPACING + (i - 1) * (self.viewDimensions.panelWidth + UI_BORDER_SPACING))
        panel:setY(self.viewDimensions.y + self.viewDimensions.previewHeight + UI_BORDER_SPACING + marginUnderVideo)
        panel:setWidth(self.viewDimensions.panelWidth)
        panel:setHeight(self.backButton:getY() - panel:getY() - UI_BORDER_SPACING)
        panel:updateView()
    end
end

function NewGameScreen:onResetLua(reason)
    if reason == "NewGameMods" then
        MainScreen.instance.bottomPanel:setVisible(false)
        if DebugScenarios.instance ~= nil then
            MainScreen.instance:removeChild(DebugScenarios.instance)
            DebugScenarios.instance = nil
        end
        self:onItemClick(self.panels[1], 0, 0)
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

NewGameScreen.defaultGameModeData = {
    {
        mode = GameMode.APOCALYPSE:toString(),
        title = GameMode.APOCALYPSE:getTitle(),
        desc = GameMode.APOCALYPSE:getDescription(),
        thumb = GameMode.APOCALYPSE:getThumbnail(),
        video = GameMode.APOCALYPSE:getVideo()
    },
    {
        mode = GameMode.OUTBREAK:toString(),
        title = GameMode.OUTBREAK:getTitle(),
        desc = GameMode.OUTBREAK:getDescription(),
        thumb = GameMode.OUTBREAK:getThumbnail(),
        video = GameMode.OUTBREAK:getVideo()
    },
    {
        mode = GameMode.RISING:toString(),
        title = GameMode.RISING:getTitle(),
        desc = GameMode.RISING:getDescription(),
        thumb = GameMode.RISING:getThumbnail(),
        video = GameMode.RISING:getVideo()
    },
    {
        mode = GameMode.EXTINCTION:toString(),
        title = GameMode.EXTINCTION:getTitle(),
        desc = GameMode.EXTINCTION:getDescription(),
        thumb = GameMode.EXTINCTION:getThumbnail(),
        video = GameMode.EXTINCTION:getVideo()
    },
    {
        mode = GameMode.SANDBOX:toString(),
        title = GameMode.SANDBOX:getTitle(),
        desc = GameMode.SANDBOX:getDescription(),
        thumb = GameMode.SANDBOX:getThumbnail(),
        video = GameMode.SANDBOX:getVideo()
    },
    {
        mode = GameMode.CHALLENGES:toString(),
        title = GameMode.CHALLENGES:getTitle(),
        desc = GameMode.CHALLENGES:getDescription(),
        thumb = GameMode.CHALLENGES:getThumbnail(),
        video = GameMode.CHALLENGES:getVideo()
    }
}

function NewGameScreen:new(x, y, width, height)
    local o = ISPanelJoypad.new(self, x, y, width, height)
    o.backgroundColor = {r=0, g=0, b=0, a=0.8}
    o.borderColor = {r=1, g=1, b=1, a=0.2}
    o.nextData = {mode = "NEXT", title = "", desc = "", thumb = "media/ui/arrow_right.png", centerThumbnail = true, arrowButton = true}
    o.prevData = {mode = "PREV", title = "", desc = "", thumb = "media/ui/arrow_left.png", centerThumbnail = true, arrowButton = true}
    o.dataShift = 0
    o.gameModeData = NewGameScreen.defaultGameModeData
    NewGameScreen.instance = o
    return o
end

Events.OnResetLua.Add(function(reason) NewGameScreen.instance:onResetLua(reason) end)
