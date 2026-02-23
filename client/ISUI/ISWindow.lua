require "ISUI/ISUIElement"

ISWindow = ISUIElement:derive("ISWindow");

ISWindow.TitleBarHeight = 19;
ISWindow.SideMargin = 12;
ISWindow.BottomMargin = 12;

function ISWindow:initialise()
	ISUIElement.initialise(self);

	self.hasClose = true;
	self.toolbars = {};
end

function ISWindow:onMouseUp(x, y)
	if(self.resizing) then
		self:setCapture(false);
	end
	self.resizing = false;

end

function ISWindow:onMouseDown(x, y)
	if x + ISWindow.SideMargin > self:getWidth() and y + ISWindow.SideMargin > self:getHeight() then
		self.resizing = true;
		self.mDownX = x;
		self.mDownY = y;
		self:setCapture(true);
	end
end

function ISWindow:onMouseMove(dx, dy)
	if self.resizing then
		self:setWidth(self:getWidth()+dx);
		self:setHeight(self:getHeight()+dy);
	end
end

function ISWindow:onMouseMoveOutside(dx, dy)
	if self.resizing then
		self:setWidth(self:getWidth()+dx);
		self:setHeight(self:getHeight()+dy);
	end
end

function ISWindow:getClientLeft()
	return ISWindow.SideMargin;
end

function ISWindow:getClientRight()
	return self:getWidth() - ISWindow.SideMargin;
end

function ISWindow:getClientBottom()
	return self:getHeight() - ISWindow.BottomMargin;
end

function ISWindow:getClientTop()
	return self:getNClientTop() + self:getTotalToolbarHeight();
end

function ISWindow:getNClientTop()
	return ISWindow.TitleBarHeight;
end

function ISWindow:getTotalToolbarHeight()
	local total = 0;
	for i, element in ipairs(self.toolbars) do
		total = total + element:getHeight();
	end

	return total;
end

function ISWindow:addToolbar(toolbar, height)
	toolbar:setX(0);
	toolbar:setY(self:getClientTop());
	toolbar:setWidth(self:getWidth());
	toolbar:setHeight(height);
	toolbar:setAnchorBottom(true);
	toolbar:setAnchorRight(true);
	toolbar:setAnchorLeft(true);
	toolbar:setAnchorTop(true);
	toolbar.isToolbar = true;
	self.toolbars[toolbar.ID] = toolbar;

	self:addChild(toolbar);
end

function ISWindow:removeToolbar(toolbar)
	self.toolbars[toolbar.ID] = nil;
	self:removeChild(toolbar);
	toolbar.isToolbar = false;
end

function ISWindow:getClientWidth()
	return self:getWidth() - (ISWindow.SideMargin*2);
end

function ISWindow:getClientHeight()
	return self:getHeight() - (ISWindow.BottomMargin+ISWindow.TitleBarHeight);
end

function ISWindow:render()
	self:drawTextCentre(self.title, self:getCentreX(), 3, 1, 1, 1, 1);
end

function ISWindow:new (title, x, y, width, height)
	local o = {}
	o = ISUIElement:new(x, y, width, height);
	setmetatable(o, self)
    self.__index = self
	o.title = title;
	o.x = x;
	o.y = y;
	o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
   return o
end

