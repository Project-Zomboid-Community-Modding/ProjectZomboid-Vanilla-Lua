ISSpawnVehicleUI = ISPanelJoypad:derive("ISSpawnVehicleUI");

function ISSpawnVehicleUI:initialise()
	ISPanelJoypad.initialise(self);

	local y=60

	self.vehicleComboBox = ISComboBox:new(10, y, 180, 20)
	self.vehicleComboBox:initialise()
	self.vehicleComboBox:setEditable(true)
	self:addChild(self.vehicleComboBox)

	y=y+40

	self.boolOptions = ISTickBox:new(10, y, 200, 20, "", self, self.onSelectOption);
	self.boolOptions:initialise()
	self:addChild(self.boolOptions)
	self.boolOptions:addOption("Real names");
	self.boolOptions.selected[1] = false
	self.boolOptions:addOption("Normal cars");
	self.boolOptions.selected[2] = true
	self.boolOptions:addOption("Burnt cars");
	self.boolOptions.selected[3] = false
	self.boolOptions:addOption("Smashed cars");
	self.boolOptions.selected[4] = false

	y=y+80

	self.spawn = ISButton:new(10, self.height-35, 80, 25, "Spawn", self, ISSpawnVehicleUI.onClick);
	self.spawn.anchorTop = false
	self.spawn.anchorBottom = true
	self.spawn.internal = "SPAWN";
	self.spawn:initialise();
	self.spawn:instantiate();
	self.spawn.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.spawn);

	self.close = ISButton:new(110, self.height-35, 80, 25, "Close", self, ISSpawnVehicleUI.onClick);
	self.close.anchorTop = false
	self.close.anchorBottom = true
	self.close.internal = "CLOSE";
	self.close:initialise();
	self.close:instantiate();
	self.close.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.close);

	self.getKey = ISButton:new(10, self.spawn:getY() - 5 - 25, 80, 25, "Get key", self, ISSpawnVehicleUI.onClick);
	self.getKey.anchorTop = false
	self.getKey.anchorBottom = true
	self.getKey.internal = "GETKEY";
	self.getKey:initialise();
	self.getKey:instantiate();
	self.getKey.borderColor = {r=1, g=1, b=1, a=0.1};
	self:addChild(self.getKey);

	self.repair = ISButton:new(110, self.close:getY() - 5 - 25, 80, 25, "Repair", self, ISSpawnVehicleUI.onClick);
	self.repair.anchorTop = false
	self.repair.anchorBottom = true
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
				addVehicle(tostring(self:getVehicle()))
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
	
	self:drawTextCentre("Spawn Vehicle", self:getWidth() / 2, 20, 1, 1, 1, 1, UIFont.NewLarge);
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
	o = ISPanelJoypad:new(x, y, width, height);
	setmetatable(o, self)
	self.__index = self
	if y == 0 then
		o.y = o:getMouseY() - (height / 2)
		o:setY(o.y)
	end
	if x == 0 then
		o.x = o:getMouseX() - (width / 2)
		o:setX(o.x)
	end
	o.name = nil;
	o.backgroundColor = {r=0, g=0, b=0, a=0.5};
	o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
	o.width = width;
	local txtWidth = getTextManager():MeasureStringX(UIFont.Small, text) + 10;
	if width < txtWidth then
		o.width = txtWidth;
	end
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = true;
	o.anchorTop = true;
	o.anchorBottom = true;
	o.player = player;
	o.titlebarbkg = getTexture("media/ui/Panel_TitleBar.png");
	return o;
end
