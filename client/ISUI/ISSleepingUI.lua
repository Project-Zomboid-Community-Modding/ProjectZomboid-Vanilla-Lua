--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

ISSleepingUI = ISPanel:derive("ISSleepingUI")

function ISSleepingUI:createChildren()
end

function ISSleepingUI:prerender()
	ISPanel.prerender(self)
end

function ISSleepingUI:render()
	ISPanel.render(self)
	local minutes = (self.hourOfDay - math.floor(self.hourOfDay)) * 60
	local texName = string.format("media/ui/SleepClock%d.png", math.floor(minutes / 10))
	local tex = getTexture(texName)
	if not tex then return end
	local w = getPlayerScreenWidth(self.playerIndex)
	local h = getPlayerScreenHeight(self.playerIndex)
	self:drawTexture(tex,
		self.x + (w - tex:getWidth()) / 2,
		self.y + (h - tex:getHeight()) / 2,
		1.0, 1.0, 1.0, 1.0)
end

function ISSleepingUI:update()
	local playerObj = getSpecificPlayer(self.playerIndex)
	if not playerObj or playerObj:isDead() or not playerObj:isAsleep() then
		self:setVisible(false)
		self:removeFromUIManager()
	end
end

function ISSleepingUI:onMouseDown(x, y)
	return false
end

function ISSleepingUI:onMouseUp(x, y)
	return false
end

function ISSleepingUI:onMouseMove(dx, dy)
	return false
end

function ISSleepingUI:onMouseWheel(del)
	return false
end

function ISSleepingUI:onSleepingTick(hourOfDay)
	if not MainScreen.instance or not MainScreen.instance.inGame or MainScreen.instance:isReallyVisible() then
		return
	end
	if not self:isVisible() then
		self:setVisible(true)
		self:addToUIManager()
	end
	self.hourOfDay = hourOfDay
end

function ISSleepingUI:onResolutionChange()
	local x = getPlayerScreenLeft(self.playerIndex)
	local y = getPlayerScreenTop(self.playerIndex)
	local w = 1 -- getPlayerScreenWidth(self.playerIndex)
	local h = 1 -- getPlayerScreenHeight(self.playerIndex)
	self:setWidth(w)
	self:setHeight(h)
	self:setX(x)
	self:setY(y)
end

function ISSleepingUI:new(playerIndex)
	local x = getPlayerScreenLeft(playerIndex)
	local y = getPlayerScreenTop(playerIndex)
	local w = 1 -- getPlayerScreenWidth(playerIndex)
	local h = 1 -- getPlayerScreenHeight(playerIndex)
	local o = ISPanel.new(self, x, y, w, h)
	o.background = false
	o.playerIndex = playerIndex
	o:instantiate()
	o.javaObject:setConsumeMouseEvents(false)
	o:setAlwaysOnTop(true)
	o.javaObject:setIgnoreLossControl(true)
	return o
end

function ISSleepingUI.OnSleepingTick(playerIndex, hourOfDay)
	local ui = getPlayerSleepingUI(playerIndex)
	if not ui then return end
	ui:onSleepingTick(hourOfDay)
end

local function OnGameStart()
	Events.OnSleepingTick.Add(ISSleepingUI.OnSleepingTick)
end

Events.OnGameStart.Add(OnGameStart)

