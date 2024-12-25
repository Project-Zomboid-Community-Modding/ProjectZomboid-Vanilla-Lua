--[[---------------------------------------------
-------------------------------------------------
--
-- ISAddSafeZoneUI
--
-- eris
--
-------------------------------------------------
--]]---------------------------------------------
require "ISUI/ISPanel"
require "ISUI/ISLayoutManager"
-------------------------------------------------
-------------------------------------------------
ISAddSafeZoneUI = ISPanel:derive("ISAddSafeZoneUI");
ISAddSafeZoneUI.instance = nil;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)

local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6
-------------------------------------------------
-------------------------------------------------
function ISAddSafeZoneUI:highlightZone(_x1, _x2, _y1, _y2, _fullHighlight)
	local r = (self.notIntersecting and 0.4) or 1;
	local g = (self.notIntersecting and 1) or 0;
	local b = (self.notIntersecting and 1) or 0;
	local a = 0.9;
	addAreaHighlight(_x1, _y1, _x2, _y2, 0, r, g, b, a)
--[[
	if _fullHighlight then
		for xVal = _x1, _x2 do
			for yVal = _y1, _y2 do
				local sqObj = getCell():getOrCreateGridSquare(xVal,yVal,0);
				if sqObj then
					for n = 0,sqObj:getObjects():size()-1 do
						local obj = sqObj:getObjects():get(n);
						obj:setHighlighted(true);
						obj:setHighlightColor(r,g,b,a);
					end;
				end;
			end;
		end;
	else
		for xVal = _x1, _x2 do
			local yVal1 = _y1;
			local yVal2 = _y2;
			local sqObj1 = getCell():getOrCreateGridSquare(xVal,yVal1,0);
			local sqObj2 = getCell():getOrCreateGridSquare(xVal,yVal2,0);
			if sqObj1 then
				for n = 0,sqObj1:getObjects():size()-1 do
					local obj = sqObj1:getObjects():get(n);
					obj:setHighlighted(true);
					obj:setHighlightColor(r,g,b,a);
				end;
			end;
			if sqObj2 then
				for n = 0,sqObj2:getObjects():size()-1 do
					local obj = sqObj2:getObjects():get(n);
					obj:setHighlighted(true);
					obj:setHighlightColor(r,g,b,a);
				end;
			end;
		end;
		for yVal = _y1, _y2 do
			local xVal1 = _x1;
			local xVal2 = _x2;
			local sqObj1 = getCell():getOrCreateGridSquare(xVal1,yVal,0);
			local sqObj2 = getCell():getOrCreateGridSquare(xVal2,yVal,0);
			if sqObj1 then
				for n = 0,sqObj1:getObjects():size()-1 do
					local obj = sqObj1:getObjects():get(n);
					obj:setHighlighted(true);
					obj:setHighlightColor(r,g,b,a);
				end;
			end;
			if sqObj2 then
				for n = 0,sqObj2:getObjects():size()-1 do
					local obj = sqObj2:getObjects():get(n);
					obj:setHighlighted(true);
					obj:setHighlightColor(r,g,b,a);
				end;
			end;
		end;
	end;
--]]
end
-------------------------------------------------
-------------------------------------------------
local function setSafehouseData(_title, _owner, _x, _y, _w, _h)
	sendSafezoneClaim(_owner, _x, _y, _w, _h, _title)
end
-------------------------------------------------
-------------------------------------------------
function ISAddSafeZoneUI:checkIfIntersectingAnotherZone()
	self.notIntersecting = true;
	for xVal = self.X1, self.X2 do
		for yVal = self.Y1, self.Y2 do
			local sqObj = getCell():getOrCreateGridSquare(xVal,yVal,0);
			if sqObj then
				if SafeHouse.getSafeHouse(sqObj) then
					self.notIntersecting = false;
				end;
			end;
		end;
	end;
end
-------------------------------------------------
-------------------------------------------------
function ISAddSafeZoneUI:updateButtons()
	self.ok.enable = self.size > 1
					and string.trim(self.ownerEntry:getInternalText()) ~= ""
					and string.trim(self.titleEntry:getInternalText()) ~= ""
					and self.notIntersecting;
end

function ISAddSafeZoneUI:prerender()
	local splitPoint = UI_BORDER_SPACING*2 + 1 + math.max(getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_PvpZone_StartingPoint")), getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_PvpZone_CurrentPoint")))
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawText(getText("IGUI_Safezone_Title"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_Safezone_Title")) / 2), UI_BORDER_SPACING+1, 1,1,1,1, UIFont.Medium);

	local z = UI_BORDER_SPACING*2 + FONT_HGT_MEDIUM + 1;
	self:drawText(getText("IGUI_SafehouseUI_Title"), UI_BORDER_SPACING+1, z+3,1,1,1,1,UIFont.Small);
	self.titleEntry:setY(z);
	self.titleEntry:setX(splitPoint);
	self.titleEntry:setWidth(self.width - splitPoint - UI_BORDER_SPACING - 1);
	self.titleEntry:setHeight(BUTTON_HGT)
	z = z + UI_BORDER_SPACING + BUTTON_HGT;

	self:drawText(getText("IGUI_SafehouseUI_Owner"), UI_BORDER_SPACING+1, z+3,1,1,1,1,UIFont.Small);
	self.ownerEntry:setY(z);
	self.ownerEntry:setX(splitPoint);
	self.ownerEntry:setWidth(self.width - splitPoint - UI_BORDER_SPACING - 1);
	self.ownerEntry:setHeight(BUTTON_HGT)
	z = z + UI_BORDER_SPACING + BUTTON_HGT;

	self:drawText(getText("IGUI_PvpZone_StartingPoint"), UI_BORDER_SPACING+1, z+3,1,1,1,1,UIFont.Small);
	self:drawText(math.floor(self.X2) .. " x " .. math.floor(self.Y2), splitPoint, z+3,1,1,1,1,UIFont.Small);
	z = z + UI_BORDER_SPACING + BUTTON_HGT;

	self:drawText(getText("IGUI_PvpZone_CurrentPoint"), UI_BORDER_SPACING+1, z+3,1,1,1,1,UIFont.Small);
	self:drawText(math.floor(self.character:getX()) .. " x " .. math.floor(self.character:getY()), splitPoint, z+3, 1,1,1,1, UIFont.Small);
	z = z + UI_BORDER_SPACING + BUTTON_HGT;

	local startingX = math.floor(self.startingX);
	local startingY = math.floor(self.startingY);
	local endX = math.floor(self.character:getX());
	local endY = math.floor(self.character:getY());

	if startingX > endX then
		local x2 = endX;
		endX = startingX;
		startingX = x2;
	end
	if startingY > endY then
		local y2 = endY;
		endY = startingY;
		startingY = y2;
	end

	local bwidth = math.abs(startingX - endX) * 2;
	local bheight = math.abs(startingY - endY) * 2;
	self.zonewidth = math.abs(startingX - endX);
	self.zoneheight = math.abs(startingY - endY);

	self:drawText(getText("IGUI_PvpZone_CurrentZoneSize"), UI_BORDER_SPACING+1, z+3,1,1,1,1,UIFont.Small);
	self.size = math.floor(self.zonewidth * self.zoneheight);
	self:drawText(self.size .. "", splitPoint, z+3,1,1,1,1,UIFont.Small);

	self:highlightZone(startingX, endX, startingY, endY, self.fullHighlight)

	self.X1, self.Y1 = startingX, startingY;
	self.X2, self.Y2 = endX, endY;

	self:setHeight(z+UI_BORDER_SPACING*4 + BUTTON_HGT*4+1)

	self:checkIfIntersectingAnotherZone();
	self:updateButtons();

	if not self.character:getRole():haveCapability(Capability.CanSetupSafezones) then
		self:close()
	end
end

function ISAddSafeZoneUI:initialise()
	ISPanel.initialise(self);

	local btnWid = 100
	local padBottom = UI_BORDER_SPACING+1

	self.cancel = ISButton:new(self:getWidth() - btnWid - UI_BORDER_SPACING-1, self:getHeight() - padBottom - BUTTON_HGT, btnWid, BUTTON_HGT, getText("UI_Cancel"), self, ISAddSafeZoneUI.onClick);
	self.cancel.internal = "CANCEL";
	self.cancel.anchorTop = false
	self.cancel.anchorBottom = true
	self.cancel:initialise();
	self.cancel:instantiate();
	self.cancel.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.cancel);

	self.ok = ISButton:new(UI_BORDER_SPACING+1, self:getHeight() - padBottom - BUTTON_HGT, btnWid, BUTTON_HGT, getText("IGUI_PvpZone_AddZone"), self, ISAddSafeZoneUI.onClick);
	self.ok.internal = "OK";
	self.ok.anchorTop = false
	self.ok.anchorBottom = true
	self.ok:initialise();
	self.ok:instantiate();
	self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.ok);

	self.startingPoint = ISButton:new(UI_BORDER_SPACING+1, self.ok.y - BUTTON_HGT - UI_BORDER_SPACING, self.width - (UI_BORDER_SPACING+1)*2, BUTTON_HGT, getText("IGUI_PvpZone_RedefineStartingPoint"), self, ISAddSafeZoneUI.onClick);
	self.startingPoint.internal = "STARTINGPOINT";
	self.startingPoint.anchorTop = false
	self.startingPoint.anchorBottom = true
	self.startingPoint:initialise();
	self.startingPoint:instantiate();
	self.startingPoint.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.startingPoint);

	self.titleEntry = ISTextEntryBox:new("Safezone #" .. SafeHouse.getSafehouseList():size() + 1, UI_BORDER_SPACING+1, 10, 200, 18);
	self.titleEntry:initialise();
	self.titleEntry:instantiate();
	self:addChild(self.titleEntry);

	self.ownerEntry = ISTextEntryBox:new(self.character:getUsername(), UI_BORDER_SPACING+1, 10, 200, 18);
	self.ownerEntry:initialise();
	self.ownerEntry:instantiate();
	self:addChild(self.ownerEntry);

	self.claimOptions = ISTickBox:new(UI_BORDER_SPACING+1, 1 + UI_BORDER_SPACING*7 + FONT_HGT_MEDIUM + BUTTON_HGT*5, 20, BUTTON_HGT, "", self, ISAddSafeZoneUI.onClickClaimOptions);
	self.claimOptions:initialise();
	self.claimOptions:instantiate();
	self.claimOptions.selected[1] = false;
	self.claimOptions.selected[2] = true;
	self.claimOptions.selected[3] = true;
	self.claimOptions:addOption(getText("IGUI_Safezone_FullHighlight"));

	self:addChild(self.claimOptions);
end

function ISAddSafeZoneUI:redefineStartingPoint()
	local character = self.character;
	self.startingX = character:getX();
	self.startingY = character:getY();
	self.X1 = character:getX();
	self.Y1 = character:getY();
	self.X2 = character:getX();
	self.Y2 = character:getY();
end

function ISAddSafeZoneUI:onClickClaimOptions(_clickedOption, _ticked)
	if _clickedOption == 1 then
		self.fullHighlight = _ticked;
	end;
end

function ISAddSafeZoneUI:onClick(button)
	if button.internal == "OK" then
		self.creatingZone = false;
		self:setVisible(false);
		self:removeFromUIManager();
		local setX = math.floor(math.min(self.X1, self.X2));
		local setY = math.floor(math.min(self.Y1, self.Y2));
		local setW = math.floor(math.abs(self.X1 - self.X2) + 1);
		local setH = math.floor(math.abs(self.Y1 - self.Y2) + 1);
		setSafehouseData(self.titleEntry:getInternalText(), self.ownerEntry:getInternalText(), setX, setY, setW, setH)
		return;
	end
	if button.internal == "STARTINGPOINT" then
		self:redefineStartingPoint();
	end;
	if button.internal == "CANCEL" then
		self.creatingZone = false;
		self:setVisible(false);
		self:removeFromUIManager();
		return;
	end;
end
-------------------------------------------------
-------------------------------------------------
function ISAddSafeZoneUI:new(x, y, width, height, character)
	local o = {}
	o = ISPanel:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
	o.backgroundColor = {r=0, g=0, b=0, a=0.8};
	o.width = width;
	o.height = height;
	o.character = character;
	o.startingX = character:getX();
	o.startingY = character:getY();
	o.X1 = character:getX();
	o.Y1 = character:getY();
	o.X2 = character:getX();
	o.Y2 = character:getY();
	o.moveWithMouse = true;
	o.creatingZone = false;
	o.fullHighlight = false;
	o.notIntersecting = true;
	ISAddSafeZoneUI.instance = o;
	o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
	return o;
end
-------------------------------------------------
-------------------------------------------------