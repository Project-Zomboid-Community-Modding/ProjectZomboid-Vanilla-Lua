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
-------------------------------------------------
-------------------------------------------------
function ISAddSafeZoneUI:highlightZone(_x1, _x2, _y1, _y2, _fullHighlight)
	local r = (self.notIntersecting and 0.4) or 1;
	local g = (self.notIntersecting and 1) or 0;
	local b = (self.notIntersecting and 1) or 0;
	local a = 0.9;
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
end
-------------------------------------------------
-------------------------------------------------
local function setSafehouseData(_title, _owner, _x, _y, _w, _h)
	local playerObj = getSpecificPlayer(0);
	local safeObj = SafeHouse.addSafeHouse(_x, _y, _w, _h, _owner, false);
	safeObj:setTitle(_title);
	safeObj:setOwner(_owner);
	safeObj:updateSafehouse(playerObj);
	safeObj:syncSafehouse();
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
function ISAddSafeZoneUI:checkIfAdmin()
	if self.character:getAccessLevel() ~= "Admin" then self:close(); end;
end

function ISAddSafeZoneUI:updateButtons()
	self.ok.enable = self.size > 1
					and string.trim(self.ownerEntry:getInternalText()) ~= ""
					and string.trim(self.titleEntry:getInternalText()) ~= ""
					and self.notIntersecting
					and self.character:getAccessLevel() == "Admin";
end

function ISAddSafeZoneUI:prerender()
	local z = 10;
	local splitPoint = self.width / 2;
	local x = 10;
	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	self:drawText(getText("IGUI_Safezone_Title"), self.width/2 - (getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_Safezone_Title")) / 2), z, 1,1,1,1, UIFont.Medium);

	z = z + 30;
	self:drawText(getText("IGUI_SafehouseUI_Title"), x, z,1,1,1,1,UIFont.Small);
	self.titleEntry:setY(z + 3);
	self.titleEntry:setX(splitPoint);
	self.titleEntry:setWidth(splitPoint - 10);

	z = z + 30;
	self:drawText(getText("IGUI_SafehouseUI_Owner"), x, z,1,1,1,1,UIFont.Small);
	self.ownerEntry:setY(z + 3);
	self.ownerEntry:setX(splitPoint);
	self.ownerEntry:setWidth(splitPoint - 10);

	z = z + 30;
	self:drawText(getText("IGUI_PvpZone_StartingPoint"), x, z,1,1,1,1,UIFont.Small);
	self:drawText(math.floor(self.X1) .. " x " .. math.floor(self.Y1), splitPoint, z,1,1,1,1,UIFont.Small);
	z = z + 30;

	self:drawText(getText("IGUI_PvpZone_CurrentPoint"), x, z,1,1,1,1,UIFont.Small);
	self:drawText(math.floor(self.character:getX()) .. " x " .. math.floor(self.character:getY()), splitPoint, z, 1,1,1,1, UIFont.Small);
	z = z + 30;

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

	self:drawText(getText("IGUI_PvpZone_CurrentZoneSize"), x, z,1,1,1,1,UIFont.Small);
	self.size = math.floor(self.zonewidth * self.zoneheight);
	self:drawText(self.size .. "", splitPoint, z,1,1,1,1,UIFont.Small);
	z = z + 30;

	self:drawText("X1: " .. self.X1 .. "     Y1: " .. self.Y1, splitPoint, z, 1,1,1,1, UIFont.Small);
	z = z + 30;
	self:drawText("X2: " .. self.X2 .. "     Y2: " .. self.Y2, splitPoint, z, 1,1,1,1, UIFont.Small);
	z = z + 30;

	self:highlightZone(startingX, endX, startingY, endY, self.fullHighlight)

	self.X1, self.Y1 = startingX, startingY;
	self.X2, self.Y2 = endX, endY;

	self:checkIfIntersectingAnotherZone();
	self:updateButtons();
	self:checkIfAdmin();
end

function ISAddSafeZoneUI:initialise()
	ISPanel.initialise(self);
	if self.character:getAccessLevel() ~= "Admin" then self:close(); return; end;

	local btnWid = 100
	local btnHgt = 25
	local btnHgt2 = 18
	local padBottom = 10

	--btnWid = getTextManager():MeasureStringX(UIFont.Medium, getText("UI_Cancel")) + 20;
	btnWid = 100;
	self.cancel = ISButton:new(self:getWidth() - btnWid - 10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("UI_Cancel"), self, ISAddSafeZoneUI.onClick);
	self.cancel.internal = "CANCEL";
	self.cancel.anchorTop = false
	self.cancel.anchorBottom = true
	self.cancel:initialise();
	self.cancel:instantiate();
	self.cancel.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.cancel);

	--btnWid = getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_PvpZone_AddZone")) + 20;
	btnWid = 100;
	self.ok = ISButton:new(10, self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("IGUI_PvpZone_AddZone"), self, ISAddSafeZoneUI.onClick);
	self.ok.internal = "OK";
	self.ok.anchorTop = false
	self.ok.anchorBottom = true
	self.ok:initialise();
	self.ok:instantiate();
	self.ok.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.ok);

	btnWid = getTextManager():MeasureStringX(UIFont.Medium, getText("IGUI_PvpZone_RedefineStartingPoint")) + 20;
	self.startingPoint = ISButton:new((self.width/2) - (btnWid/2), self:getHeight() - padBottom - btnHgt, btnWid, btnHgt, getText("IGUI_PvpZone_RedefineStartingPoint"), self, ISAddSafeZoneUI.onClick);
	self.startingPoint.internal = "STARTINGPOINT";
	self.startingPoint.anchorTop = false
	self.startingPoint.anchorBottom = true
	self.startingPoint:initialise();
	self.startingPoint:instantiate();
	self.startingPoint.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.startingPoint);

	self.titleEntry = ISTextEntryBox:new("Safezone #" .. SafeHouse.getSafehouseList():size() + 1, 10, 10, 200, 18);
	self.titleEntry:initialise();
	self.titleEntry:instantiate();
	self:addChild(self.titleEntry);

	self.ownerEntry = ISTextEntryBox:new(self.character:getUsername(), 10, 10, 200, 18);
	self.ownerEntry:initialise();
	self.ownerEntry:instantiate();
	self:addChild(self.ownerEntry);

	self.claimOptions = ISTickBox:new(10, 270, 20, 18, "", self, ISAddSafeZoneUI.onClickClaimOptions);
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