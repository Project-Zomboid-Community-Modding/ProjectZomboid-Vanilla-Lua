ISSpawnVehicleUI = ISPanelJoypad:derive("ISSpawnVehicleUI");

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local FONT_HGT_LARGE = getTextManager():getFontHeight(UIFont.NewLarge)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

function ISSpawnVehicleUI:initialise()
	ISPanelJoypad.initialise(self);

	local th = self:titleBarHeight()
	local y = th + UI_BORDER_SPACING*2+FONT_HGT_LARGE+1

	self.vehicleComboBox = ISComboBox:new(UI_BORDER_SPACING+1, y, self.width - (UI_BORDER_SPACING+1)*2, BUTTON_HGT)
	self.vehicleComboBox:initialise()
	self.vehicleComboBox:setEditable(true)
	self:addChild(self.vehicleComboBox)

	y = y + UI_BORDER_SPACING + BUTTON_HGT

	self.boolOptions = ISTickBox:new(UI_BORDER_SPACING+1, y, 200, BUTTON_HGT, "", self, self.onSelectOption);
	self.boolOptions:initialise()
	self:addChild(self.boolOptions)
	self.boolOptions:addOption(getText("IGUI_SpawnVehicle_RealNames"));
	self.boolOptions:addOption(getText("IGUI_SpawnVehicle_Normal"));
	self.boolOptions.selected[2] = true
	self.boolOptions:addOption(getText("IGUI_SpawnVehicle_Burnt"));
	self.boolOptions:addOption(getText("IGUI_SpawnVehicle_Smashed"));
	self.boolOptions.autoWidth = true;
	self.boolOptions:setX((self:getWidth()-self.boolOptions:getWidth())/2 - UI_BORDER_SPACING)

	self:setHeight(self.boolOptions:getBottom() + BUTTON_HGT*2 + UI_BORDER_SPACING*3 + 1)

	local buttonWid = UI_BORDER_SPACING*2 + math.max(
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_StashDebug_Spawn")),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_SpawnVehicle_GetKey")),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Close")),
			getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_SpawnVehicle_Repair"))
	)

	local x = (self.width - buttonWid*2 - UI_BORDER_SPACING)/2

	self.spawn = ISButton:new(x, self.height - UI_BORDER_SPACING - BUTTON_HGT - 1, buttonWid, BUTTON_HGT, getText("IGUI_StashDebug_Spawn"), self, ISSpawnVehicleUI.onClick);
	self.spawn.internal = "SPAWN";
	self.spawn:initialise();
	self.spawn:instantiate();
	self.spawn:enableAcceptColor()
	self:addChild(self.spawn);

	self.close = ISButton:new(self.spawn:getRight() + UI_BORDER_SPACING, self.spawn.y, buttonWid, BUTTON_HGT, getText("IGUI_DebugMenu_Close"), self, ISSpawnVehicleUI.onClick);
	self.close.internal = "CLOSE";
	self.close:initialise();
	self.close:instantiate();
	self.close:enableCancelColor()
	self:addChild(self.close);

	self.getKey = ISButton:new(self.spawn.x, self.spawn:getY()-UI_BORDER_SPACING-BUTTON_HGT, buttonWid, BUTTON_HGT, getText("IGUI_SpawnVehicle_GetKey"), self, ISSpawnVehicleUI.onClick);
	self.getKey.internal = "GETKEY";
	self.getKey:initialise();
	self.getKey:instantiate();
	self.getKey.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.getKey);

	self.repair = ISButton:new(self.getKey:getRight() + UI_BORDER_SPACING, self.getKey:getY(), buttonWid, BUTTON_HGT, getText("IGUI_SpawnVehicle_Repair"), self, ISSpawnVehicleUI.onClick);
	self.repair.internal = "REPAIR";
	self.repair:initialise();
	self.repair:instantiate();
	self.repair.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.repair);

	self:populateList()
end

function ISSpawnVehicleUI:onSelectOption()
	self:populateList()
end

function ISSpawnVehicleUI:populateList()
	self.vehicleComboBox:clear()

	local scripts = getScriptManager():getAllVehicleScripts()
	local sorted = {}
	for i=1,scripts:size() do
		local script = scripts:get(i-1)
		local name = string.lower(script:getName())
		if string.contains(name, "burnt") then
			if self.boolOptions.selected[3] then
				table.insert(sorted, { script:getFullName(), script:getName() })
			end
		elseif string.contains(name, "smashed") then
			if self.boolOptions.selected[4] then
				table.insert(sorted, { script:getFullName(), script:getName() })
			end
		else
			if self.boolOptions.selected[2] then
				table.insert(sorted, { script:getFullName(), script:getName() })
			end
		end
	end
	if self.boolOptions.selected[1] then
		table.sort(sorted, function(a, b) return getText("IGUI_VehicleName" .. a[2]) < getText("IGUI_VehicleName" .. b[2]) end)
	else
		table.sort(sorted, function(a, b) return a[1] < b[1] end)
	end

	for i=1, #sorted do
		local txt = sorted[i][1]
		if self.boolOptions.selected[1] then
			txt = getText("IGUI_VehicleName" .. sorted[i][2])
		end
		self.vehicleComboBox:addOptionWithData(txt, sorted[i][1])
	end
end

function ISSpawnVehicleUI:destroy()
	UIManager.setShowPausedMessage(true);
	self:setVisible(false);
	self:removeFromUIManager();
end

function ISSpawnVehicleUI:getVehicle()
	return self.vehicleComboBox.options[self.vehicleComboBox.selected].data;
end

function ISSpawnVehicleUI:update()
	self.vehicle = self.player:getNearVehicle()
	if self.vehicle then
		self.repair:setEnable(true);
		self.getKey:setEnable(true);
	else
		self.repair:setEnable(false);
		self.getKey:setEnable(false);
	end
end

function ISSpawnVehicleUI:onClick(button)
	if self.player ~= nil then
		if button.internal == "SPAWN" then
			self.player:setDir(IsoDirections.W)
			if isClient() then
				local command = string.format("/addvehicle %s", tostring(self:getVehicle()))
				SendCommandToServer(command)
			else
				--addVehicle(tostring(self:getVehicle()))
				addVehicle(tostring(self:getVehicle()), self.player:getX(), self.player:getY(), self.player:getZ())
			end
		elseif button.internal == "GETKEY" then
			if self.vehicle ~= nil then
				sendClientCommand(self.player, "vehicle", "getKey", { vehicle = self.vehicle:getId() })
			end
		elseif button.internal == "REPAIR" then
			if self.vehicle ~= nil then
				sendClientCommand(self.player, "vehicle", "repair", { vehicle = self.vehicle:getId() })
			end
		elseif button.internal == "CLOSE" then
			self:destroy();
		end
	end
end

function ISSpawnVehicleUI:titleBarHeight()
	return 16
end

function ISSpawnVehicleUI:prerender()
	self.backgroundColor.a = 0.8

	self:drawRect(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	
	local th = self:titleBarHeight()
	self:drawTextureScaled(self.titlebarbkg, 2, 1, self:getWidth() - 4, th - 2, 1, 1, 1, 1);
	
	self:drawRectBorder(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	
	self:drawTextCentre(getText("IGUI_DebugContext_SpawnVehicle"), self:getWidth() / 2, UI_BORDER_SPACING+th+1, 1, 1, 1, 1, UIFont.NewLarge);
end

function ISSpawnVehicleUI:render()

end

function ISSpawnVehicleUI:onMouseMove(dx, dy)
	self.mouseOver = true
	if self.moving then
		self:setX(self.x + dx)
		self:setY(self.y + dy)
		self:bringToTop()
	end
end

function ISSpawnVehicleUI:onMouseMoveOutside(dx, dy)
	self.mouseOver = false
	if self.moving then
		self:setX(self.x + dx)
		self:setY(self.y + dy)
		self:bringToTop()
	end
end

function ISSpawnVehicleUI:onMouseDown(x, y)
	if not self:getIsVisible() then
		return
	end
	self.downX = x
	self.downY = y
	self.moving = true
	self:bringToTop()
end

function ISSpawnVehicleUI:onMouseUp(x, y)
	if not self:getIsVisible() then
		return;
	end
	self.moving = false
	if ISMouseDrag.tabPanel then
		ISMouseDrag.tabPanel:onMouseUp(x,y)
	end
	ISMouseDrag.dragView = nil
end

function ISSpawnVehicleUI:onMouseUpOutside(x, y)
	if not self:getIsVisible() then
		return
	end
	self.moving = false
	ISMouseDrag.dragView = nil
end

function ISSpawnVehicleUI:new(x, y, width, height, player)
	local o = {}
	o = ISPanelJoypad:new(x, y, 500, 500);
	setmetatable(o, self)
	self.__index = self
	o.width = 500;
	o.height = 500;

	if y == 0 then
		o.y = o:getMouseY() - (o.height / 2)
		o:setY(o.y)
	end
	if x == 0 then
		o.x = o:getMouseX() - (o.width / 2)
		o:setX(o.x)
	end
	o.name = nil;
	o.backgroundColor = {r=0, g=0, b=0, a=0.5};
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;
	o.player = player;
	o.titlebarbkg = getTexture("media/ui/Panel_TitleBar.png");
	return o;
end
