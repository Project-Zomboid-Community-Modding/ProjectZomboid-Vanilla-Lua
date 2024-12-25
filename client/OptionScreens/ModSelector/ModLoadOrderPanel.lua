--***********************************************************
--**                      Aiteron                          **
--***********************************************************

require "ISUI/ISPanelJoypad"
require "OptionScreens/ModSelector/ModSelector"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local BUTTON_HGT = math.max(25, FONT_HGT_SMALL + 3 * 2)

ModSelector.ModLoadOrderPanel = ISPanelJoypad:derive("ModLoadOrderPanel")
local ModLoadOrderPanel = ModSelector.ModLoadOrderPanel

function ModLoadOrderPanel:new(x, y, width, height, model)
    local o = ISPanelJoypad:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.backgroundColor = {r=0, g=0, b=0, a=0.9}
    o.model = model
    o.upTexture = Joypad.Texture.YButton
    o.downTexture = Joypad.Texture.XButton
    return o
end

function ModLoadOrderPanel:instantiate()
    ISPanelJoypad.instantiate(self)
    self.modList:clear()
    local modArray = self.model:getActiveMods():getMods()
    self.defaultOrder = {}

    for i = 0, modArray:size()-1 do
        local modId = modArray:get(i)
        local modData = {}
        modData.name = self.model.mods[modId].name
        modData.icon = self.model.mods[modId].icon
        modData.modId = self.model.mods[modId].modId
        modData.modInfo = self.model.mods[modId].modInfo
        local item = self.modList:addItem("", modData)
        item.color = {r = 0.9, g = 0.9, b = 0.9}
        item.tooltip = self:getTooltip(modData.modInfo)
        table.insert(self.defaultOrder, self.model.mods[modId].modId)
    end
    self.modList:updateModsColor()
end

function ModLoadOrderPanel:getModName(id)
    if self.model.mods[id] then
        return self.model.mods[id].name
    end
    return id
end

function ModLoadOrderPanel:getTooltip(modInfo)
    local text = getText("UI_modselector_orderFor") .. " '" .. modInfo:getName() .. "':\n"

    local afterList = modInfo:getLoadAfter()
    if afterList ~= nil then
        for j = 0, afterList:size()-1 do
            text = text .. self:getModName(afterList:get(j)) .. "\n"
        end
    end

    local reqList = modInfo:getRequire()
    if reqList ~= nil then
        for j = 0, reqList:size()-1 do
            text = text .. self:getModName(reqList:get(j)) .. "\n"
        end
    end

    text = text .. modInfo:getName() .. "\n"

    local beforeList = modInfo:getLoadBefore()
    if beforeList ~= nil then
        for j = 0, beforeList:size()-1 do
            text = text .. self:getModName(beforeList:get(j)) .. "\n"
        end
    end

    if afterList == nil and beforeList == nil and reqList == nil then
        return nil
    end

    return text
end

function ModLoadOrderPanel:prerender()
    self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    ISPanelJoypad.prerender(self)
    self:drawTextCentre(getText("UI_modselector_modLoadOrder"), self.width / 2, 10, 1, 1, 1, 1, UIFont.Title)

    if self.joyfocus then
        self:drawTextureScaled(self.upTexture, self.backButton.x + 150, self.backButton.y+2, 20, 20, 1, 1, 1, 1)
        self:drawText(getText("UI_ServerSettings_ButtonMoveUp"), self.backButton.x + 180, self.backButton.y+4, 1, 1, 1, 1, UIFont.Small)
        self:drawTextureScaled(self.downTexture, self.backButton.x + 300, self.backButton.y+2, 20, 20, 1, 1, 1, 1)
        self:drawText(getText("UI_ServerSettings_ButtonMoveDown"), self.backButton.x + 330, self.backButton.y+4, 1, 1, 1, 1, UIFont.Small)
    end
end

function ModLoadOrderPanel:createChildren()
    self.modList = ModSelector.ModOrderListBox:new(20, 80, self.width - 40, self.height - 80 - 60)
    self.modList:initialise()
    self.modList:instantiate()
    self:addChild(self.modList)

    self.backButton = ISButton:new(16, self.height - BUTTON_HGT - 8, 100, BUTTON_HGT, getText("UI_btn_back"), self, ModLoadOrderPanel.onOptionMouseDown);
    self.backButton.internal = "BACK";
    self.backButton:initialise();
    self.backButton:instantiate();
    self.backButton:setAnchorLeft(true);
    self.backButton:setAnchorRight(false);
    self.backButton:setAnchorTop(false);
    self.backButton:setAnchorBottom(true);
    self.backButton.borderColor = {r=1, g=1, b=1, a=0.1};
    self.backButton:setFont(UIFont.Small);
    self.backButton:ignoreWidthChange();
    self.backButton:ignoreHeightChange();
    self:addChild(self.backButton);

    self.acceptButton = ISButton:new(self.width - 16, self.height - BUTTON_HGT - 8, 100, BUTTON_HGT, getText("UI_btn_accept"), self, ModLoadOrderPanel.onOptionMouseDown);
    self.acceptButton.internal = "ACCEPT";
    self.acceptButton:initialise();
    self.acceptButton:instantiate();
    self.acceptButton:setAnchorLeft(false);
    self.acceptButton:setAnchorRight(true);
    self.acceptButton:setAnchorTop(false);
    self.acceptButton:setAnchorBottom(true);
    self.acceptButton.borderColor = {r=1, g=1, b=1, a=0.1};
    self.acceptButton:setFont(UIFont.Small);
    self.acceptButton:ignoreWidthChange();
    self.acceptButton:ignoreHeightChange();
    self:addChild(self.acceptButton);
    self.acceptButton:setX(self.width - 16 - self.acceptButton.width)

    self.autoButton = ISButton:new(self.width - 16, self.height - BUTTON_HGT - 8, 100, BUTTON_HGT, getText("UI_modselector_auto"), self, ModLoadOrderPanel.onOptionMouseDown);
    self.autoButton.internal = "AUTO";
    self.autoButton:initialise();
    self.autoButton:instantiate();
    self.autoButton:setAnchorLeft(false);
    self.autoButton:setAnchorRight(true);
    self.autoButton:setAnchorTop(false);
    self.autoButton:setAnchorBottom(true);
    self.autoButton.borderColor = {r=1, g=1, b=1, a=0.1};
    self.autoButton:setFont(UIFont.Small);
    self.autoButton:ignoreWidthChange();
    self.autoButton:ignoreHeightChange();
    self:addChild(self.autoButton);
    self.autoButton:setX(self.acceptButton.x - 16 - self.autoButton.width)
end

function ModLoadOrderPanel:onAccept()
    local data = {}
    for i, val in ipairs(self.modList.items) do
        table.insert(data, val.item.modId)
    end
    self.model:correctAndSaveModOrder(data)
end

function ModLoadOrderPanel:onOptionMouseDown(button, x, y)
    if button.internal == "ACCEPT" then
        self:onAccept()
        self:setVisible(false)
        self:removeFromUIManager()
        ModSelector.instance:setVisible(true, self.joyfocus)
    elseif button.internal == "BACK" then
        local isChanged = false
        for i, val in ipairs(self.modList.items) do
            if self.defaultOrder[i] ~= val.item.modId then
                isChanged = true
                break
            end
        end

        if isChanged then
            self:setVisible(false)
            local w = 300
            local h = 100
            local modal = ISModalDialog:new(getCore():getScreenWidth()/2 - w/2, getCore():getScreenHeight() / 2 - h/2, w, h, getText("UI_mods_backAccept"), true, self, self.acceptChanges)
            modal:initialise()
            modal:addToUIManager()
            modal:bringToTop()
            return
        else
            self:setVisible(false)
            self:removeFromUIManager()
            ModSelector.instance:setVisible(true, self.joyfocus)
        end
    elseif button.internal == "AUTO" then
        self:autoSort()
        self.modList:updateModsColor()
    end
end

local function getIndexOfId(data, id)
    for i, val in ipairs(data) do
        if val == id then return i end
    end
    return -1
end

function ModLoadOrderPanel:autoSort()
    local baseModOrder = {}
    local idToItem = {}
    for i, val in ipairs(self.modList.items) do
        table.insert(baseModOrder, { modInfo = val.item.modInfo, modId = val.item.modId })
        idToItem[val.item.modId] = val
    end

    table.sort(baseModOrder, function(a, b) return a.modId<b.modId end)

    local autoOrder = {}
    local added = {}
    for i, val in ipairs(baseModOrder) do
        local temp = {}

        local loadAfterAndRequire = self:getLoadAfterAndRequire(val.modInfo)
        for _, val2 in ipairs(loadAfterAndRequire) do
            if added[val2] == nil then
                table.insert(temp, val2)
                added[val2] = true
            end
        end

        table.insert(temp, val.modId)
        local mIndex = #temp

        local loadBefore = val.modInfo:getLoadBefore()
        if loadBefore ~= nil then
            for j = 0, loadBefore:size()-1 do
                local iid = loadBefore:get(j)
                if added[iid] == nil then
                    table.insert(temp, iid)
                    added[iid] = true
                end
            end
        end
        --
        if added[val.modId] then
            local index = getIndexOfId(autoOrder, val.modId)
            for j = mIndex+1, #temp do
                table.insert(autoOrder, index+1, temp[j])
            end
            for j = 1, mIndex-1 do
                table.insert(autoOrder, index, temp[j])
            end
        else
            for j = 1, #temp do
                table.insert(autoOrder, temp[j])
            end
            added[val.modId] = true
        end
    end

    local newItems = {}
    for i, val in ipairs(autoOrder) do
        newItems[i] = idToItem[val]
    end
    self.modList.items = newItems
end

function ModLoadOrderPanel:getLoadAfterAndRequire(modInfo)
    local result = {}
    local loadAfter = modInfo:getLoadAfter()
    if loadAfter ~= nil then
        for j = 0, loadAfter:size()-1 do
            local id = loadAfter:get(j)
            table.insert(result, id)
        end
    end
    local require = modInfo:getRequire()
    if require ~= nil then
        for j = 0, require:size()-1 do
            local id = require:get(j)
            table.insert(result, id)
        end
    end
    return result
end

function ModLoadOrderPanel:isCorrectOrder()
    local loadedMods = {}
    for i, val in ipairs(self.modList.items) do
        local loadAfter = val.item.modInfo:getRequire()
        if loadAfter ~= nil then
            for j = 0, loadAfter:size()-1 do
                local iid = loadAfter:get(j)
                if loadedMods[iid] == nil then
                    return false, val.item.modId
                end
            end
        end
        loadedMods[val.item.modId] = true
    end
    return true, nil
end

function ModLoadOrderPanel:acceptChanges(button)
    if button.internal == "YES" then
        self:onAccept()
    end
    self:setVisible(false)
    self:removeFromUIManager()
    ModSelector.instance:setVisible(true, self.joyfocus)
end


----


function ModLoadOrderPanel:onGainJoypadFocus(joypadData)
    self:setISButtonForB(self.backButton)
    self.joypadIndex = self.acceptButton.ID
    self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData)
end


function ModLoadOrderPanel:onJoypadDown(button, joypadData)
    local child = self.children[self.joypadIndex]

    if button == Joypad.AButton and child and child.isButton then
        child:forceClick()
        return
    end
    if button == Joypad.XButton then
        self.modList:moveItemDown()
        return
    end
    if button == Joypad.YButton then
        self.modList:moveItemUp()
        return
    end
    if button == Joypad.BButton then
        self.backButton:forceClick()
        return
    end
end


function ModLoadOrderPanel:onJoypadDirUp(joypadData)
    self.modList:onJoypadDirUp(joypadData)
end

function ModLoadOrderPanel:onJoypadDirDown(joypadData)
    self.modList:onJoypadDirDown(joypadData)
end


function ModLoadOrderPanel:onJoypadDirLeft(joypadData)
    if self.joypadIndex == self.acceptButton.ID then
        self.children[self.joypadIndex]:setJoypadFocused(false, joypadData)
        self.joypadIndex = self.autoButton.ID
        self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
    end
end

function ModLoadOrderPanel:onJoypadDirRight(joypadData)
    if self.joypadIndex == self.autoButton.ID then
        self.children[self.joypadIndex]:setJoypadFocused(false, joypadData)
        self.joypadIndex = self.acceptButton.ID
        self.children[self.joypadIndex]:setJoypadFocused(true, joypadData)
    end
end


