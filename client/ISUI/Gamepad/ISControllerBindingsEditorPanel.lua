require "ISBaseObject"
require "ISUI/ISLine"
require "ISUI/ISPanel"
require "ISUI/ISPanelJoypad"
require "ISUI/ISButton"
require "ISUI/ISUISprite"
require "ISUI/Gamepad/ISControllerTestPanel"
require "ISUI/Gamepad/CharacterJoypadBindingUI"
require "ISUI/Gamepad/SpriteBounds_XBox"
require "ISUI/Gamepad/SpriteBounds_PlayStation"
require "ISUI/Gamepad/SpriteBounds_SteamDeck"
require "ISUI/Style/ISStyle"
require "OptionScreens/GameOption"
require "gamepadBinding"

require "defines"

ISControllerBindingsEditorPanel = ISPanel:derive("ISControllerBindingsEditorPanel")
ISControllerBindingsEditorPanel.spriteBoundsRepo = {}
ISControllerBindingsEditorPanel.spriteBoundsRepo["XBOX"] = SpriteBounds_XBox:new()
ISControllerBindingsEditorPanel.spriteBoundsRepo["PS4"] = SpriteBounds_PlayStation:new()
ISControllerBindingsEditorPanel.spriteBoundsRepo["STEAMDECK"] = SpriteBounds_SteamDeck:new()

function ISControllerBindingsEditorPanel:new(gameOptionControllerTab, containerPanel, x, y, width, height)
	local newInstance = ISPanel:new(x, y, width, height)
	setmetatable(newInstance, self)
	self.__index = self

    newInstance.SuperType = ISPanel
	newInstance.parentContainerPanel = containerPanel
	newInstance.gameOptionControllerTab = gameOptionControllerTab
	newInstance.content = {}
	newInstance.layoutOrderings = nil
	newInstance:initContent()

	return newInstance
end

function ISControllerBindingsEditorPanel:initContent()
    self:createMainSprite()
    self:createBindingGroupPanels()

    self.unusedBindingsPanel = self:addChild(ISPanel:new(0, 0, 100, 100):noBackground())
    self.unusedBindingsPanel:setVisible(false)

    self.uiBindings = CharacterJoypadBindingUI:new(self)
    for _, physicalElement in ipairs(CharacterJoypadBindingUI.getAllPhysicalJoypadElements()) do
        self.uiBindings:createGamepadUIBinding(self.unusedBindingsPanel, physicalElement)
    end

    self:createSubSprites()
    self:populateAllBindingBoxes()
    self:createLineOverlayPanel()

    self:addOnOptionGamepadBindingPresetChanged(ISControllerBindingsEditorPanel.onGamepadBindingPresetsChanged)
    return self
end

function ISControllerBindingsEditorPanel:getStyle()
    return self.gameOptionControllerTab:getStyle()
end

function ISControllerBindingsEditorPanel:populateAllBindingBoxes()
    for _,uiBinding in ipairs(self.uiBindings:getAllEntries()) do
        local containerPanel = uiBinding:getBindingRowPanel()
        containerPanel:populate()
    end

    self:doLayout()
    self.gameOptionControllerTab:onContentChanged()
end

function ISControllerBindingsEditorPanel:createMainSprite()
    local spriteBounds = ISUISpriteBoundsGetter:new()
    function spriteBounds:loadSpriteBounds()
        local gamepadType = getCore():getOptionControllerButtonStyleString()
        DebugType.ISUI:trace("spriteBounds:loadSpriteBounds for gamepadType: " .. gamepadType)
        local repo = ISControllerBindingsEditorPanel.spriteBoundsRepo[gamepadType]
        return repo["Gamepad"]
    end

    local controllerBackgroundSprite = ISUISprite:newFromBounds(spriteBounds, 0, 0, 100, 100)
    self.content.controllerBackgroundSprite = controllerBackgroundSprite
    self:addChild(controllerBackgroundSprite)

    ISControllerBindingsEditorPanel.addOnOptionControllerButtonStyleChanged(self, ISControllerBindingsEditorPanel.onControllerButtonStyleChanged)
end

function ISControllerBindingsEditorPanel:createSubSprites()
    local controllerBackgroundSprite = self.content.controllerBackgroundSprite
    local parentSpriteBounds = controllerBackgroundSprite.spriteBounds

    local subSprites = {}
    for _, bindingKey in ipairs(self.uiBindings.bindingKeys) do
        local subSpriteBounds = ISUISpriteBoundsGetter:new()
        subSpriteBounds.parentSpriteBounds = parentSpriteBounds
        subSpriteBounds.bindingKey = bindingKey
        function subSpriteBounds:loadSpriteBounds()
            local parentSpriteBounds = self.parentSpriteBounds:getSpriteBounds()
            local subSpriteBounds = parentSpriteBounds.subSprites[self.bindingKey]
            if (subSpriteBounds == nil) then
                return nil
            end

            subSpriteBounds.bindingKey = self.bindingKey
            return subSpriteBounds
        end

        local subSprite = ISUISprite:newFromBounds(subSpriteBounds, 0, 0, 100, 100)
        subSprite.bindingIntensity = 0

        function subSprite:update()
            ISUISprite.update(self)

            local spriteBounds = self:getSpriteBounds()
            if (spriteBounds == nil) then
                self:setVisible(false)
                return
            end

            local bindingKey = spriteBounds.bindingKey

            if (instanceof(bindingKey, "JoypadButton")) then
                self.bindingIntensity = bindingKey:isDown(0) and 1 or 0
                self.color.a = self.bindingIntensity
            end

            if (instanceof(bindingKey, "JoypadAxis1d")) then
                self.bindingIntensity = (bindingKey:getValue(0) + 1) / 2
                self.color.a = self.bindingIntensity
            end

            local offsetX = 0
            local offsetY = 0
            if (instanceof(bindingKey, "JoypadAxis2d")) then
                self.bindingIntensity = math.max(math.abs(bindingKey:getValueX(0)), math.abs(bindingKey:getValueY(0)))
                offsetX = bindingKey:getValueX(0) * self:getWidth() / 2
                offsetY = bindingKey:getValueY(0) * self:getHeight() / 2
            end

            if (bindingKey == JoypadButton.LeftStick) then
                offsetX = JoypadAxis2d.LeftStick:getValueX(0) * self:getWidth() / 2
                offsetY = JoypadAxis2d.LeftStick:getValueY(0) * self:getHeight() / 2
            end

            if (bindingKey == JoypadButton.RightStick) then
                offsetX = JoypadAxis2d.RightStick:getValueX(0) * self:getWidth() / 2
                offsetY = JoypadAxis2d.RightStick:getValueY(0) * self:getHeight() / 2
            end

            local containerWidth = self:getParent():getWidth()
            local containerHeight = self:getParent():getHeight()
            local mainSpriteBounds = self:getParent():getSpriteBounds()
            if (mainSpriteBounds == nil) then
                self:setVisible(false)
                return
            end

            local u = (spriteBounds.x - mainSpriteBounds.subTextureBounds.x) / mainSpriteBounds.subTextureBounds.width
            local v = (spriteBounds.y - mainSpriteBounds.subTextureBounds.y) / mainSpriteBounds.subTextureBounds.height
            local sizeU = spriteBounds.subTextureBounds.width / mainSpriteBounds.subTextureBounds.width
            local sizeV = spriteBounds.subTextureBounds.height / mainSpriteBounds.subTextureBounds.height

            self:setX(u * containerWidth + offsetX)
            self:setWidth(sizeU * containerWidth)
            self:setY(v * containerHeight + offsetY)
            self:setHeight(sizeV * containerHeight)
            self:setVisible(true)
        end

        subSprites[bindingKey] = subSprite
    end

    controllerBackgroundSprite.subSprites = subSprites
    for _,subSprite in pairs(subSprites) do
        controllerBackgroundSprite:addChild(subSprite)
    end
end

function ISControllerBindingsEditorPanel:invalidateSprites()
    local mainSprite = self.content.controllerBackgroundSprite
    mainSprite:invalidateSpriteBounds()

    for _,subSprite in pairs(mainSprite.subSprites) do
        subSprite:invalidateSpriteBounds()
    end
end

function ISControllerBindingsEditorPanel:createBindingGroupPanels()
    local BUTTON_HGT = self:getStyle().buttonHeight

    self.content.bindingGroupPanels = {
        parentContainer = self
    }

    local bindingGroupPanels = self.content.bindingGroupPanels
    function bindingGroupPanels:getCenterBoundsWidth()
        local centerBounds = self:getCenterBounds()
        return centerBounds:getWidth()
    end
    function bindingGroupPanels:getMinHeight()
        return math.max(self:getMinHeightLeft(), self:getMinHeightRight())
    end
    function bindingGroupPanels:getMinHeightLeft()
        local panelTL = self[CharacterJoypadBindingUI.BindingPanel.TopLeft]
        local panelBL = self[CharacterJoypadBindingUI.BindingPanel.BottomLeft]
        return panelTL:getHeight() + panelBL:getHeight()
    end
    function bindingGroupPanels:getMinHeightRight()
        local panelTR = self[CharacterJoypadBindingUI.BindingPanel.TopRight]
        local panelBR = self[CharacterJoypadBindingUI.BindingPanel.BottomRight]
        return panelTR:getHeight() + panelBR:getHeight()
    end
    function bindingGroupPanels:getCenterBounds()
        local panelTL = self[CharacterJoypadBindingUI.BindingPanel.TopLeft]
        local panelTR = self[CharacterJoypadBindingUI.BindingPanel.TopRight]
        local panelBL = self[CharacterJoypadBindingUI.BindingPanel.BottomLeft]
        local panelBR = self[CharacterJoypadBindingUI.BindingPanel.BottomRight]

        local centerBounds = ISBounds:new(0, 0, 10, 10)
        centerBounds:setLeft(math.max(panelTL:getRight(), panelBL:getRight()))
        centerBounds:setRight(math.min(panelTR:getLeft(), panelBR:getLeft()))
        centerBounds:setTop(math.max(panelTL:getBottom(), panelTR:getBottom()))
        centerBounds:setBottom(math.max(panelBL:getTop(), panelBR:getTop()))
        return centerBounds
    end
    function bindingGroupPanels:getAllPanels()
        return {
            self[CharacterJoypadBindingUI.BindingPanel.TopLeft],
            self[CharacterJoypadBindingUI.BindingPanel.TopRight],
            self[CharacterJoypadBindingUI.BindingPanel.BottomLeft],
            self[CharacterJoypadBindingUI.BindingPanel.BottomRight]
        }
    end
    function bindingGroupPanels:getLeftPanels()
        return {
            self[CharacterJoypadBindingUI.BindingPanel.TopLeft],
            self[CharacterJoypadBindingUI.BindingPanel.BottomLeft],
        }
    end
    function bindingGroupPanels:getRightPanels()
        return {
            self[CharacterJoypadBindingUI.BindingPanel.TopRight],
            self[CharacterJoypadBindingUI.BindingPanel.BottomRight],
         }
    end

    function bindingGroupPanels:clearAllPanelsContent()
        local allPanels = self:getAllPanels()
        for _,panel in ipairs(allPanels) do
            panel:clearChildren()
            panel.bindingRows = {}
        end
    end
    function bindingGroupPanels:addPanel(bindingPanelKey, dock, contentHorizontalAlignment)
        local newPanel = self.parentContainer:addChild(ISPanel:new(0, 0, BUTTON_HGT, BUTTON_HGT):noBackground())
        newPanel.bindingRows = {}
        newPanel.dock = dock
        newPanel.contentHorizontalAlignment = contentHorizontalAlignment
        self[bindingPanelKey] = newPanel
    end

    bindingGroupPanels.inputBlockerPanel = self:addChild(ISPanel:new(0, 0, 10, 10):noBackground())
    bindingGroupPanels.inputBlockerPanel.dock = ISDock.Fill
    bindingGroupPanels.inputBlockerPanel:setVisible(false)
    function bindingGroupPanels.inputBlockerPanel:onMouseDown(x, y)
        getSoundManager():playUISound("UIActivateButton")
        self:getParent():setActiveEditingBindingUI(nil)
    end

    bindingGroupPanels:addPanel(CharacterJoypadBindingUI.BindingPanel.TopLeft, ISDock.TopLeft, UIHorizontalAlignment.Right)
    bindingGroupPanels:addPanel(CharacterJoypadBindingUI.BindingPanel.TopRight, ISDock.TopRight, UIHorizontalAlignment.Left)
    bindingGroupPanels:addPanel(CharacterJoypadBindingUI.BindingPanel.BottomLeft, ISDock.BottomLeft, UIHorizontalAlignment.Right)
    bindingGroupPanels:addPanel(CharacterJoypadBindingUI.BindingPanel.BottomRight, ISDock.BottomRight, UIHorizontalAlignment.Left)
end

function ISControllerBindingsEditorPanel:createLineOverlayPanel()
    local lineOverlayPanel = self:addChild(ISPanel:new(0, 0, self:getWidth(), self:getHeight()))
    lineOverlayPanel:setWantMouseEvents(false)
    lineOverlayPanel:noBackground()
    lineOverlayPanel.dock = ISDock.Fill
    function lineOverlayPanel:render()
        ISPanel:render(self)
        for _, physicalElement in ipairs(CharacterJoypadBindingUI.getAllPhysicalJoypadElements()) do
            self:renderLineToBinding(physicalElement)
        end
    end
    function lineOverlayPanel:renderLineToBinding(bindingKey)
        local uiBinding = self:getParent().uiBindings[bindingKey]
        if (uiBinding == nil) then return end

        local line = uiBinding:getLineToRowAbsolute()
        if (line ~= nil) then
            line:render(self)
        end
    end

    self.lineOverlayPanel = lineOverlayPanel
    return lineOverlayPanel
end

function ISControllerBindingsEditorPanel:onResize()
    ISUIElement.onResize(self)
    self:doLayout()
end

function ISControllerBindingsEditorPanel:onBindingUILayoutChanged()
    self:doLayout()
end

function ISControllerBindingsEditorPanel:onControllerButtonStyleChanged()
    self:invalidateSprites()
    self:doLayout()
end

function ISControllerBindingsEditorPanel:onGamepadBindingPresetsChanged()
    self:populateAllBindingBoxes()
    self:setActiveEditingBindingUI(nil)
end

function ISControllerBindingsEditorPanel:onJoypadButtonBindingEdited()
    self.gameOptionControllerTab:onJoypadButtonBindingEdited()
    self:populateAllBindingBoxes()
end

function ISControllerBindingsEditorPanel:onJoypadAxisBindingValueEdited(uiBinding, uiRow, charBinding)
    self.gameOptionControllerTab:onJoypadButtonBindingEdited()
end

function ISControllerBindingsEditorPanel:onBindingUIPanelEditingActivated(uiBinding)
    self:setActiveEditingBindingUI(uiBinding)
end

function ISControllerBindingsEditorPanel:setActiveEditingBindingUI(uiBinding)
    if (self.editedUIBinding == uiBinding) then
        return
    end

    if (self.editedUIBinding ~= nil) then
        self.editedUIBinding:setEditSelected(false)
    end

    self.editedUIBinding = uiBinding
    self.content.bindingGroupPanels.inputBlockerPanel:setVisible(uiBinding ~= nil)

    if (uiBinding == nil) then
        self:populateAllBindingBoxes()
    else
        self.gameOptionControllerTab:onContentChanged()
    end
end

function ISControllerBindingsEditorPanel:doLayout()
    -- bindingGroupPanels
    local bindingGroupPanels = self.content.bindingGroupPanels

    local gamepadType = getCore():getOptionControllerButtonStyleString()
    local layoutOrderings = ISControllerBindingsEditorPanel.spriteBoundsRepo[gamepadType].layoutOrderings
    if (self.layoutOrderings ~= layoutOrderings) then
        self.layoutOrderings = layoutOrderings

        -- Clear first
        for _,uiBindingEntry in ipairs(self.uiBindings:getAllEntries()) do
            uiBindingEntry:setContainerPanel(nil)
        end
        bindingGroupPanels:clearAllPanelsContent()

        -- Populate
        for panelKey,order in pairs(self.layoutOrderings) do
            local panel = bindingGroupPanels[panelKey]
            DebugType.ISUI:trace("Populating binding panel: " .. tostring(panelKey))
            for _,bindingKey in ipairs(order) do
                local uiBindingEntry = self.uiBindings[bindingKey]
                if (uiBindingEntry ~= nil) then
                    DebugType.ISUI:trace("  Adding bindingKey: " .. typeof(bindingKey) .. "." .. tostring(bindingKey) .. ", entry:" .. tostring(uiBindingEntry))
                    uiBindingEntry:setContainerPanel(panel)
                else
                    DebugType.ISUI:warn("  CharacterJoypadBindingUIEntry not found for bindingKey: " .. typeof(bindingKey) .. "." .. tostring(bindingKey))
                end
            end
        end
    end

    for _,panel in pairs(bindingGroupPanels:getAllPanels()) do
        CharacterJoypadBindingUI.performLayoutRows(panel)
    end

    local minHeight = bindingGroupPanels:getMinHeight()
    if (minHeight > self:getHeight()) then
        self:setScrollHeight(minHeight)
        self:addScrollBars(false)
        self:setScrollChildren(true)
    else
        self:removeScrollBars()
        self:setScrollHeight(0)
        self:setScrollChildren(false)
    end

    self.SuperType.doLayout(self)

    -- Sprite bounds
    self:updateCenterSpriteBounds()
    self:updateCornerPanelsToScroll()
end

function ISControllerBindingsEditorPanel:onScrollPosChanged()
    self:updateCenterSpriteBounds()
    self:updateCornerPanelsToScroll()
end

function ISControllerBindingsEditorPanel:updateCornerPanelsToScroll()
    local bindingGroupPanels = self.content.bindingGroupPanels
    if (bindingGroupPanels == nil) then return end

    local minHeightLeft = bindingGroupPanels:getMinHeightLeft()
    if (minHeightLeft < self:getHeight()) then
        local selfBounds = self:getBounds()
        local scrollY = self:getYScroll()
        for _,panel in ipairs(bindingGroupPanels:getLeftPanels()) do
            local childDock = panel.dock
            local childBounds = panel:getBounds()
            if (childDock == ISDock.TopLeft) then
                childBounds.x = 0
                childBounds.y = -scrollY
                panel:setBounds(childBounds)
            elseif (childDock == ISDock.BottomLeft) then
                childBounds.x = 0
                childBounds.y = selfBounds.height - childBounds.height - scrollY
                panel:setBounds(childBounds)
            end
        end
    end

    local minHeightRight = bindingGroupPanels:getMinHeightRight()
    if (minHeightRight < self:getHeight()) then
        local selfBounds = self:getBounds()
        if (self.vscroll ~= nil) then
            selfBounds.width = selfBounds.width - self.vscroll:getWidth()
        end
        local scrollY = self:getYScroll()
        for _,panel in ipairs(bindingGroupPanels:getRightPanels()) do
            local childDock = panel.dock
            local childBounds = panel:getBounds()
            if (childDock == ISDock.TopRight) then
                childBounds.x = selfBounds.width - childBounds.width
                childBounds.y = -scrollY
                panel:setBounds(childBounds)
            elseif (childDock == ISDock.BottomRight) then
                childBounds.x = selfBounds.width - childBounds.width
                childBounds.y = selfBounds.height - childBounds.height - scrollY
                panel:setBounds(childBounds)
            end
        end
    end
end

function ISControllerBindingsEditorPanel:onMouseWheel(del)
    local BUTTON_HGT = self:getStyle().buttonHeight
    self:setYScroll(self:getYScroll() - del * BUTTON_HGT)
end

function ISControllerBindingsEditorPanel:updateCenterSpriteBounds()
    local bindingGroupPanels = self.content.bindingGroupPanels
    if (bindingGroupPanels == nil) then return end

    local centerBounds = bindingGroupPanels:getCenterBounds()
    local controllerBackgroundSprite = self.content.controllerBackgroundSprite
    local spriteBounds = controllerBackgroundSprite:getSpriteBounds()
    local spriteBoundsLeft = centerBounds:getLeft() + spriteBounds.leftMargin * centerBounds:getWidth()
    local spriteBoundsRight = centerBounds:getRight() - spriteBounds.rightMargin * centerBounds:getWidth()

    controllerBackgroundSprite:setX(spriteBoundsLeft)
    controllerBackgroundSprite:setWidth(spriteBoundsRight - spriteBoundsLeft)
    controllerBackgroundSprite:setHeightToPreserveAspect()
    controllerBackgroundSprite:setCenterY(self:getHeight() * 0.5 - self:getYScroll())

    local maxSpriteHeight = self:getHeight() * 0.8
    if (controllerBackgroundSprite:getHeight() > maxSpriteHeight) then
        local posU = controllerBackgroundSprite:getCenterX() / self:getWidth()
        local posV = controllerBackgroundSprite:getCenterY() / self:getHeight()
        local scaleToFit = maxSpriteHeight / controllerBackgroundSprite:getHeight()
        controllerBackgroundSprite:setWidth(controllerBackgroundSprite:getWidth() * scaleToFit)
        controllerBackgroundSprite:setHeight(controllerBackgroundSprite:getHeight() * scaleToFit)
        controllerBackgroundSprite:setCenterX(self:getWidth() * posU)
        controllerBackgroundSprite:setCenterY(self:getHeight() * posV)
    end
end

ISControllerBindingsEditorPanel.onOptionControllerButtonStyleChanged = {}
function ISControllerBindingsEditorPanel.optionControllerButtonStyleChanged(optionStr)
    for _,listener in ipairs(ISControllerBindingsEditorPanel.onOptionControllerButtonStyleChanged) do
        listener.callback(listener.target, optionStr)
    end
end

function ISControllerBindingsEditorPanel.addOnOptionControllerButtonStyleChanged(target, callbackFunc)
    local listener = {
        target = target,
        callback = callbackFunc
    }
    table.insert(ISControllerBindingsEditorPanel.onOptionControllerButtonStyleChanged, listener)
end

ISControllerBindingsEditorPanel.onOptionGamepadBindingPresetChanged = {}
function ISControllerBindingsEditorPanel.optionGamepadBindingPresetChanged(optionStr)
    for _,listener in ipairs(ISControllerBindingsEditorPanel.onOptionGamepadBindingPresetChanged) do
        listener.callback(listener.target, optionStr)
    end
end

function ISControllerBindingsEditorPanel.addOnOptionGamepadBindingPresetChanged(target, callbackFunc)
    local listener = {
        target = target,
        callback = callbackFunc
    }
    table.insert(ISControllerBindingsEditorPanel.onOptionGamepadBindingPresetChanged, listener)
end

Events.OptionControllerButtonStyleChanged.Add(ISControllerBindingsEditorPanel.optionControllerButtonStyleChanged);
Events.OptionGamepadBindingPresetChanged.Add(ISControllerBindingsEditorPanel.optionGamepadBindingPresetChanged);
