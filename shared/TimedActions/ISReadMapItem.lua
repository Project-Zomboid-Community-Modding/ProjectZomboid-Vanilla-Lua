require "TimedActions/ISBaseTimedAction"

ISReadMapItem = ISBaseTimedAction:derive("ISReadMapItem")

function ISReadMapItem:isValid()
    return self.character:getInventory():containsID(self.item:getID())
end

function ISReadMapItem:waitToStart()
    return false
end

function ISReadMapItem:update()
end

function ISReadMapItem:start()
    self:setAnimVariable("ReadType", "newspaper")
    self:setActionAnim(CharacterActionAnims.Read)
    self:setOverrideHandModelsString(nil, "MapInHand")
    self.character:playSoundLocal("MapOpen")
end

function ISReadMapItem:stop()
    ISBaseTimedAction.stop(self)
end

function ISReadMapItem:perform()
    if isClient() then
        self.character:addReadMap(self.item)
    end
    self:showUI()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self)
end

function ISReadMapItem:complete()
    self.item:doBuildingStash()
    self.character:addReadMap(self.item)
    return true
end

function ISReadMapItem:getDuration()
    if self.character:isTimedActionInstant() then
        return 1
    end
    return 30
end

function ISReadMapItem:showUI()
    local player = self.playerNum
    local map = self.item
    if JoypadState.players[player+1] then
        local inv = getPlayerInventory(player)
        local loot = getPlayerLoot(player)
        inv:setVisible(false)
        loot:setVisible(false)
    end
    local titleBarHgt = ISCollapsableWindow.TitleBarHeight()
    local x = getPlayerScreenLeft(player) + 20
    local y = getPlayerScreenTop(player) + 20
    local width = getPlayerScreenWidth(player) - 20 * 2
    local height = getPlayerScreenHeight(player) - 20 * 2 - titleBarHgt
    local mapUI = ISMap:new(x, y, width, height, map, player)
    mapUI:initialise()
    local wrap = mapUI:wrapInCollapsableWindow(map:getName(), false, ISMapWrapper)
    wrap:setInfo(getText("IGUI_Map_Info"))
    wrap:setWantKeyEvents(true)
    mapUI.wrap = wrap
    wrap.mapUI = mapUI
    wrap:setVisible(true)
    wrap:addToUIManager()
    if JoypadState.players[player+1] then
        setJoypadFocus(player, mapUI)
    end
end

function ISReadMapItem:new(character, item)
    local o = ISBaseTimedAction.new(self, character)
    o.playerNum = character:getIndex()
    o.item = item
    o.caloriesModifier = 8
    o.maxTime = o:getDuration()
    return o
end
