require "ISBaseObject"
require "ISUI/ISLine"
require "ISUI/Gamepad/CharacterJoypadBindingUIRow"

CharacterJoypadBindingUIEntry = ISBaseObject:derive("CharacterJoypadBindingUIEntry")

function CharacterJoypadBindingUIEntry:new(characterJoypadBindingUI, containerPanel, bindingKey)
    local uiBinding = {}
    setmetatable(uiBinding, self)
    self.__index = self

    uiBinding.bindingKey = bindingKey
    uiBinding.characterJoypadBindingUI = characterJoypadBindingUI
    uiBinding.initialBevelDirection = CharacterJoypadBindingUI.BevelDirection.Auto
    uiBinding.containerPanel = containerPanel
    uiBinding:initBindingRowPanel()
    return uiBinding
end

function CharacterJoypadBindingUIEntry:tostring()
    return self.Type .. " { bindingKey:" .. typeof(self.bindingKey) .. "." .. tostring(self.bindingKey) .. ", initialBevelDirection:" .. self.initialBevelDirection .. ", bindingRowPanel:" .. tostring(self.bindingRowPanel) .. " }"
end

function CharacterJoypadBindingUIEntry:getStyle()
    return self.characterJoypadBindingUI:getStyle()
end

function CharacterJoypadBindingUIEntry:getBindingRowPanel()
    return self.bindingRowPanel
end

function CharacterJoypadBindingUIEntry:onBindingRowPanelLayoutChanged()
    self.characterJoypadBindingUI:onBindingEntryLayoutChanged()
end

function CharacterJoypadBindingUIEntry:onJoypadButtonBindingEdited()
    self.characterJoypadBindingUI:onJoypadButtonBindingEdited()
end

function CharacterJoypadBindingUIEntry:onJoypadAxisBindingValueEdited(sender, charBinding)
    self.characterJoypadBindingUI:onJoypadAxisBindingValueEdited(self, sender, charBinding)
end

function CharacterJoypadBindingUIEntry:onBindingRowPanelEditingActivated(rowPanel)
    self.characterJoypadBindingUI:onBindingUIPanelEditingActivated(self)
end

function CharacterJoypadBindingUIEntry:initBindingRowPanel()
    self.bindingRowPanel = self.containerPanel:addChild(CharacterJoypadBindingUIRow:new(0, 0, 10, 10, self, self.bindingKey))
end

function CharacterJoypadBindingUIEntry:setEditSelected(isEditing)
    self.bindingRowPanel:setEditSelected(isEditing)
end

function CharacterJoypadBindingUIEntry:setContainerPanel(containerPanel)
    if (self.containerPanel == containerPanel) then return end

    if (self.containerPanel ~= nil) then
        if (self.containerPanel.bindingRows ~= nil) then
            luautils.remove(self.containerPanel.bindingRows, self.bindingRowPanel)
        end
        self.bindingRowPanel:detachFromParent()
        self.containerPanel = nil
    end

    self.containerPanel = containerPanel

    if (self.containerPanel ~= nil) then
        self.bindingRowPanel.contentHorizontalAlignment = self.containerPanel.contentHorizontalAlignment
        if (self.containerPanel.bindingRows == nil) then
            self.containerPanel.bindingRows = {}
        end
        table.insert(self.containerPanel.bindingRows, self.bindingRowPanel)
        self.containerPanel:addChild(self.bindingRowPanel)
    end
end

function CharacterJoypadBindingUIEntry:getLineToRowAbsolute()
    if (self.characterJoypadBindingUI == nil) then
        return nil
    end

    local sprite = self.characterJoypadBindingUI:getSprite()
    if (sprite == nil or sprite.subSprites == nil) then
        return nil
    end

    local subSprite = sprite.subSprites[self.bindingKey]
    if (subSprite == nil or subSprite:isVisible() == false) then
        return nil
    end

    local subSpriteBounds = subSprite:getSpriteBounds()
    if (subSpriteBounds == nil) then
        return nil
    end

    local style = self:getStyle()
    local BEVEL_FINAL_APPROACH = style.buttonHeight * 0.25
    local BEVEL_INITIAL_NOTCH = style.buttonHeight * 0.25
    local BEVEL_ELBOW = style.buttonHeight * 0.5
    local FONT_HGT_LABEL = style:getFontHeight("Small") * 0.8
    local TARGET_MID_Y = FONT_HGT_LABEL * 0.5

    local initialBevelDirection = subSpriteBounds.initialBevelDirection

    local rowPanel = self.bindingRowPanel
    local line = ISLine:new(
        subSprite:getAbsoluteCenterX(),
        subSprite:getAbsoluteCenterY(),
        0,
        rowPanel:getAbsoluteY() + TARGET_MID_Y)
    line.thickness = 0.5

    -- Get shortest path
    local endXL = rowPanel:getAbsoluteX()
    local endXR = rowPanel:getAbsoluteRight()
    local lengthToL = math.abs(endXL - line.startX)
    local lengthToR = math.abs(endXR - line.startX)
    local finalApproachX = 0
    local finalApproachY = line.endY
    if (lengthToL > lengthToR) then
        line.endX = endXR
        finalApproachX = endXR + BEVEL_FINAL_APPROACH
    else
        line.endX = endXL
        finalApproachX = endXL - BEVEL_FINAL_APPROACH
    end

    local initialBevelX = line.startX
    local initialBevelY = line.startY
    local directionX = math.sign(finalApproachX - line.startX)
    local directionY = math.sign(finalApproachY - line.startY)
    if (initialBevelDirection == CharacterJoypadBindingUI.BevelDirection.Auto) then
        initialBevelX = line.startX + BEVEL_INITIAL_NOTCH * directionX
        initialBevelY = line.startY + BEVEL_INITIAL_NOTCH * directionY
    elseif (initialBevelDirection == CharacterJoypadBindingUI.BevelDirection.Left) then
        initialBevelX = line.startX - BEVEL_INITIAL_NOTCH
        initialBevelY = line.startY + BEVEL_INITIAL_NOTCH * directionY
    elseif (initialBevelDirection == CharacterJoypadBindingUI.BevelDirection.Right) then
        initialBevelX = line.startX + BEVEL_INITIAL_NOTCH
        initialBevelY = line.startY + BEVEL_INITIAL_NOTCH * directionY
    end

    line:appendPoint({ x = initialBevelX, y = initialBevelY })
    line:appendPoint({ x = initialBevelX, y = finalApproachY })
    line:appendPoint({ x = finalApproachX, y = finalApproachY })
    line:appendPoint({ x = line.endX, y = line.endY })

    line:bevelAllJoints(BEVEL_ELBOW)
    line:bevelAllJoints(BEVEL_ELBOW * 0.2)

    local intensity = subSprite.bindingIntensity
    line.color.a = 0.2 * (1 - intensity) + 0.8 * intensity
    line.color.r = 0.8
    line.color.g = 0.8
    line.color.b = 1.0
    line.thickness = 0.5 * (1 - intensity) + 0.65 * intensity

    return line
end

