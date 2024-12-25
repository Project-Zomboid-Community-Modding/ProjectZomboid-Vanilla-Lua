--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 04/12/2017
-- Time: 10:19
-- To change this template use File | Settings | File Templates.
--

---FOX, FIX HEIGHT OF WINDOW

require "ISUI/ISPanelJoypad"

ISRunningDebugUI = ISCollapsableWindow:derive("ISRunningDebugUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.NewLarge)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

--************************************************************************--
--** ISRunningDebugUI:initialise
--**
--************************************************************************--

function ISRunningDebugUI:createChildren()
	local btnWid = UI_BORDER_SPACING*2 + math.max(
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_RunningDebug_TimerStart")),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_RunningDebug_TimerStop")),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_RunningDebug_RestoreEndurance"))
	)

	ISCollapsableWindow.createChildren(self)

	local buttonY = self.height - BUTTON_HGT - UI_BORDER_SPACING - 1
	
	self.start = ISButton:new(UI_BORDER_SPACING + 1, buttonY, btnWid, BUTTON_HGT, getText("IGUI_RunningDebug_TimerStart"), self, ISRunningDebugUI.startTrip);
	self.start.internal = "START";
	self.start.anchorTop = false
	self.start.anchorBottom = true
	self.start:initialise();
	self.start:instantiate();
	self.start:enableAcceptColor()
	self:addChild(self.start);
	
	self.restoreEnd = ISButton:new(self:getWidth() - btnWid - UI_BORDER_SPACING - 1, self.start.y, btnWid, BUTTON_HGT, getText("IGUI_RunningDebug_RestoreEndurance"), self, ISRunningDebugUI.restoreEndurance);
	self.restoreEnd.internal = "RESTOREENDURANCE";
	self.restoreEnd.anchorTop = false
	self.restoreEnd.anchorBottom = true
	self.restoreEnd.anchorLeft = false
	self.restoreEnd.anchorRight = true
	self.restoreEnd:initialise();
	self.restoreEnd:instantiate();
	self.restoreEnd.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.restoreEnd);
	
	self:setInfo(getText("IGUI_RunningDebug_Info"));
end

function ISRunningDebugUI:restoreEndurance()
	self.chr:getStats():setEndurance(1);
end

function ISRunningDebugUI:update()
	ISCollapsableWindow.update(self);
	
	if self.startedTrip then
		self.start.internal = "STOP";
		self.start.title = getText("IGUI_RunningDebug_TimerStop");
	end
	
	-- update variables
	if self.startedTrip then
		self.totalEndurance = self.startingEndurance - self.chr:getStats():getEndurance();
	end
end

function ISRunningDebugUI:startTrip()
	-- start
	if not self.startedTrip then
		self.startedTrip = true;
		self.startTimer = Calendar.getInstance():getTimeInMillis();
		self.stopTimer = nil;
		self.totalEndurance = 0;
		self.startingEndurance = self.chr:getStats():getEndurance();
		self.totalDistance = 0;
		self.start.title = getText("IGUI_RunningDebug_TimerStop");
		self.start:enableCancelColor()
		self.totalDist = 0;
		self.previousSq = self.chr:getSquare();
	else -- stop
		self.startedTrip = false;
		self.stopTimer = Calendar.getInstance():getTimeInMillis();
		self.start.title = getText("IGUI_RunningDebug_TimerStart");
		self.start:enableAcceptColor()
	end
end

function ISRunningDebugUI:render()
	ISCollapsableWindow.render(self);

	local y = self:titleBarHeight();
	local x = UI_BORDER_SPACING+1;
	self:drawText(getText("IGUI_RunningDebug_Roadtrip") , x, y, 1, 1, 1, 1, UIFont.Medium);
	-- time
	y = y + FONT_HGT_MEDIUM;
	local sec = 0;
	if self.stopTimer or self.startTimer then
		local cal = Calendar.getInstance();
		if self.stopTimer then
			cal:setTimeInMillis(self.stopTimer - self.startTimer);
		else
			cal:setTimeInMillis(Calendar.getInstance():getTimeInMillis() - self.startTimer);
		end
		sec = cal:get(Calendar.SECOND);
		if sec < 10 then sec = "0" .. sec;  end
		self:drawText(getText("IGUI_RunningDebug_RealTime")..": " .. cal:get(Calendar.MINUTE) .. ":" .. sec, x, y, 1, 1, 1, 1, UIFont.Small);
	else
		self:drawText(getText("IGUI_RunningDebug_RealTime")..": " .. sec, x, y, 1, 1, 1, 1, UIFont.Small);
	end
	y = y + BUTTON_HGT;
	-- endurance
	self:drawText(getText("IGUI_RunningDebug_EnduranceUsed")..": " .. round(self.totalEndurance, 4), x, y, 1, 1, 1, 1, UIFont.Small);
	y = y + BUTTON_HGT;
	-- distance
	if self.startedTrip then
		self.totalDist = self.totalDist + self.previousSq:DistToProper(self.chr:getSquare());
		self.previousSq = self.chr:getSquare();
	end
	self:drawText(getText("IGUI_RunningDebug_TotalDistance")..": ~" .. round(self.totalDist,2) .. " " .. getText("IGUI_RunningDebug_Tiles"), x, y, 1, 1, 1, 1, UIFont.Small);
	y = y + BUTTON_HGT + UI_BORDER_SPACING;
	-- variables
	self:drawText(getText("IGUI_RunningDebug_Variables"), x, y, 1, 1, 1, 1, UIFont.Medium);
	y = y + FONT_HGT_MEDIUM;
	self:drawText(getText("IGUI_RunningDebug_BaseSpeed")..": " .. round(self.chr:calculateBaseSpeed(), 2), x, y, 1, 1, 1, 1, UIFont.Small);
	y = y + BUTTON_HGT;
	self:drawText(getText("IGUI_RunningDebug_Clothing")..": " .. round(self.chr:getRunSpeedModifier(), 2), x, y, 1, 1, 1, 1, UIFont.Small);
	y = y + BUTTON_HGT;
	self:drawText(getText("IGUI_RunningDebug_Injuries")..": " .. round(self.chr:getVariableFloat("WalkInjury", 0), 2), x, y, 1, 1, 1, 1, UIFont.Small);
	y = y + BUTTON_HGT;
	self:drawText(getText("IGUI_RunningDebug_TotalCurrentSpeed")..": " .. round(self.chr:getVariableFloat("WalkSpeed", 0), 2), x, y, 1, 1, 1, 1, UIFont.Small);
	y = y + BUTTON_HGT;
end

--************************************************************************--
--** ISRunningDebugUI:new
--**
--************************************************************************--
function ISRunningDebugUI:new(x, y, character)
	local o = {}
	local width = 550;
	local height = 550;
	o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
	o.playerNum = character:getPlayerNum()
	if y == 0 then
		o.y = getPlayerScreenTop(o.playerNum) + (getPlayerScreenHeight(o.playerNum) - height) / 2
		o:setY(o.y)
	end
	if x == 0 then
		o.x = getPlayerScreenLeft(o.playerNum) + (getPlayerScreenWidth(o.playerNum) - width) / 2
		o:setX(o.x)
	end
	o.width = width;
	o.height = height;
	o.title = getText("IGUI_DebugContext_RunningUI")
	o.character = character;
	o.chr = character;
	o:setResizable(false);
	o.moveWithMouse = true;
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;
	o.totalDistance = 0;
	o.totalEndurance = 0;
	o.totalDist = 0;
	return o;
end
