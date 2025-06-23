--***********************************************************
--**                    ROBERT JOHNSON                     **
--** A collapsable window with multiple tab, can be dragged out or in to make new tab **
--***********************************************************

require "ISUI/ISTabPanel"

ISTabPanelPaginated = ISTabPanel:derive("ISTabPanelPaginated");

--ISTabPanelPaginated.tabSelected = nil;
--ISTabPanelPaginated.tabUnSelected = nil;
--ISTabPanelPaginated.xMouse = -1;
--ISTabPanelPaginated.yMouse = -1;
--ISTabPanelPaginated.mouseOut = false;
--ISTabPanelPaginated.viewDragging = nil;

ISTabPanelPaginated.tooMuchViews = false;
ISTabPanelPaginated.shownViewsCount = 5;
ISTabPanelPaginated.shownViews = {}
ISTabPanelPaginated.forwardView = nil
ISTabPanelPaginated.backwardView = nil
ISTabPanelPaginated.forwardIndex = -2
ISTabPanelPaginated.backwardIndex = -1

--************************************************************************--
--** ISTabPanelPaginated:initialise
--**
--************************************************************************--

function ISTabPanelPaginated:initialise()
	ISTabPanel.initialise(self);
	for i = 1, self.pagesCount do
        self:addView(tostring(i),ISUIElement:new(0,0,100,100))
    end
    self:addForwardBackwardViews()
end

-- add a view to our tab panel
function ISTabPanelPaginated:addForwardBackwardViews()
	local forwardViewObject = {};
	forwardViewObject.name = ">>";
	local view = ISUIElement:new(0,0,100,100);
	forwardViewObject.view = view
	forwardViewObject.tabWidth = getTextManager():MeasureStringX(UIFont.Small, forwardViewObject.name) + self.tabPadX;
	forwardViewObject.fade = UITransition.new()
	self.forwardView = forwardViewObject

	view:setY(self.tabHeight);
	self:addChild(view);
	view.parent = self;
	view:setVisible(false);

	local backwardViewObject = {};
    backwardViewObject.name = "<<";
    view = ISUIElement:new(0,0,100,100);
    backwardViewObject.view = view
    backwardViewObject.tabWidth = getTextManager():MeasureStringX(UIFont.Small, backwardViewObject.name) + self.tabPadX;
    backwardViewObject.fade = UITransition.new()
    self.backwardView = backwardViewObject

    view:setY(self.tabHeight);
    self:addChild(view);
    view.parent = self;
    view:setVisible(false);
end

function ISTabPanelPaginated:getWidthOfAllTabs()
	local gap = 1
	local width = (#self.viewList - 1) * gap
	if self.equalTabWidth then
	    local maxCount = #self.viewList
	    if maxCount > self.shownViewsCount then
	        maxCount = self.shownViewsCount
	    end
		return width + maxCount * self.maxLength
	end
	for _,viewObject in ipairs(self.viewList) do
	    if self.shownViews[_] then
		    width = width + viewObject.tabWidth
		end
	end
	return width
end

--************************************************************************--
--** ISTabPanelPaginated:render
--**
--************************************************************************--

function ISTabPanelPaginated:renderView(viewObject, tabDragSelected, _x, tabWidth, gap)
    tabWidth = self.equalTabWidth and self.maxLength or viewObject.tabWidth
    -- if we drag a tab over an existing one, we move the other
    local x = _x
	--FIXME: nil cannot be equal to a value
    if tabDragSelected ~= -1 and nil == (tabDragSelected + 1) then
        x = x + tabWidth + gap;
    end
    -- if this tab is the active one, we make the tab btn lighter
    if self.activeView and viewObject.name == self.activeView.name and not self.isDragging and not ISTabPanel.mouseOut then
        self:drawTextureScaled(ISTabPanel.tabSelected, x, 0, tabWidth, self.tabHeight - 1, self.tabTransparency,1,1,1);
    else
        local alpha = self.tabTransparency;
        local shouldBlink = false;
        if self.blinkTabs then
            for j,tab in ipairs(self.blinkTabs) do
                if tab and tab == viewObject.name then
                    shouldBlink = true;
                end
            end
        end
        if (self.blinkTab and self.blinkTab == viewObject.name) or (shouldBlink and blinkTabsAlphaNotUpdated) then
            blinkTabsAlphaNotUpdated = false;
            if not self.blinkTabAlpha then
                self.blinkTabAlpha = self.tabTransparency;
                self.blinkTabAlphaIncrease = false;
            end

            if not self.blinkTabAlphaIncrease then
                self.blinkTabAlpha = self.blinkTabAlpha - 0.1 * self.tabTransparency * (UIManager.getMillisSinceLastRender() / 33.3);
                if self.blinkTabAlpha < 0 then
                    self.blinkTabAlpha = 0;
                    self.blinkTabAlphaIncrease = true;
                end
            else
                self.blinkTabAlpha = self.blinkTabAlpha + 0.1 * self.tabTransparency * (UIManager.getMillisSinceLastRender() / 33.3);
                if self.blinkTabAlpha > self.tabTransparency then
                    self.blinkTabAlpha = self.tabTransparency;
                    self.blinkTabAlphaIncrease = false;
                end
            end
            alpha = self.blinkTabAlpha;
            self:drawTextureScaled(ISTabPanel.tabUnSelected, x, 0, tabWidth, self.tabHeight - 1, self.tabTransparency,1,1,1);
            self:drawRect(x, 0, tabWidth, self.tabHeight - 1, alpha, 1, 1, 1);
        elseif shouldBlink then
            alpha = self.blinkTabAlpha;
            self:drawTextureScaled(ISTabPanel.tabUnSelected, x, 0, tabWidth, self.tabHeight - 1, self.tabTransparency,1,1,1);
            self:drawRect(x, 0, tabWidth, self.tabHeight - 1, alpha, 1, 1, 1);
        else
            self:drawTextureScaled(ISTabPanel.tabUnSelected, x, 0, tabWidth, self.tabHeight - 1, self.tabTransparency,1,1,1);
			--FIXME: nil cannot be equal to a value
            if self:getMouseY() >= 0 and self:getMouseY() < self.tabHeight and self:isMouseOver() and self:getTabIndexAtX(self:getMouseX()) == nil then
                viewObject.fade:setFadeIn(true)
            else
                viewObject.fade:setFadeIn(false)
            end
            viewObject.fade:update()
            self:drawTextureScaled(ISTabPanel.tabSelected, x, 0, tabWidth, self.tabHeight - 1, 0.2 * viewObject.fade:fraction(),1,1,1);
       end
    end
    self:drawTextCentre(viewObject.name, x + (tabWidth / 2), 3, 1, 1, 1, self.textTransparency, UIFont.Small);
    x = x + tabWidth + gap;
    return x;
end

function ISTabPanelPaginated:getTabIndexAtX(x, scrollX)
	local inset = 1
	local gap = 1
	local left = inset
	if self.centerTabs and (self:getWidth() >= self:getWidthOfAllTabs()) then
		left = (self:getWidth() - self:getWidthOfAllTabs()) / 2
	else
		left = left + (scrollX or self.scrollX)
	end
	if x >= left and x < left + self.backwardView.tabWidth + gap then
        return self.backwardIndex
    end
    left = left + self.backwardView.tabWidth
	for index,viewObject in ipairs(self.viewList) do
	    if self.shownViews[index] then
            local tabWidth = self.equalTabWidth and self.maxLength or viewObject.tabWidth
            if x >= left and x < left + tabWidth + gap then
                return index
            end
            left = left + tabWidth + gap
		end
	end
	if x >= left and x < left + self.forwardView.tabWidth + gap then
        return self.forwardIndex
    end
	return -3
end

function ISTabPanelPaginated:onMouseDown(x, y)
	if self:getMouseY() >= 0 and self:getMouseY() < self.tabHeight then
	    local tabIndex = self:getTabIndexAtX(self:getMouseX())
	    local activeIndex = self:getActiveViewIndex()
	    if activeIndex then
            if tabIndex == self.forwardIndex and activeIndex < self.pagesCount then
                self:activateView(tostring(activeIndex+1))
            end
            if tabIndex == self.backwardIndex and activeIndex > 1 then
                self:activateView(tostring(activeIndex-1))
            end
        end
	end
	if self.mouseDownHook then
	    self.mouseDownHook(self,x,y)
	end
end

function ISTabPanelPaginated:render()
	local newViewList = {};
	local tabDragSelected = -1;
	if self.draggingTab and not self.isDragging and ISTabPanel.xMouse > -1 and ISTabPanel.xMouse ~= self:getMouseX() then -- do we move the mouse since we have let the left button down ?
		self.isDragging = self.allowDraggingTabs;
	end
	local tabWidth = self.maxLength
	local inset = 1 -- assumes a 1-pixel window border on the left to avoid
	local gap = 1 -- gap between tabs
	if self.isDragging and not ISTabPanel.mouseOut then
		-- we fetch all our view to remove the tab of the view we're dragging
		for i,viewObject in ipairs(self.viewList) do
			if i ~= (self.draggingTab + 1) then
				table.insert(newViewList, viewObject);
			else
				ISTabPanel.viewDragging = viewObject;
			end
		end
		-- in wich tab slot are we dragging our tab
		tabDragSelected = self:getTabIndexAtX(self:getMouseX()) - 1;
		tabDragSelected = math.min(#self.viewList - 1, math.max(tabDragSelected, 0))
		-- we draw a white rectangle to show where our tab is going to be
		self:drawRectBorder(inset + (tabDragSelected * (tabWidth + gap)), 0, tabWidth, self.tabHeight - 1, 1,1,1,1);
	else -- no dragging, we display all our tabs
		newViewList = self.viewList;
	end
	-- our principal rect, wich display our different view
	self:drawRect(0, self.tabHeight, self.width, self.height - self.tabHeight, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
	self:drawRectBorder(0, self.tabHeight, self.width, self.height - self.tabHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
	local x = inset;
	if self.centerTabs and (self:getWidth() >= self:getWidthOfAllTabs()) then
		x = (self:getWidth() - self:getWidthOfAllTabs()) / 2
	else
		x = x + self.scrollX
	end
	local widthOfAllTabs = self:getWidthOfAllTabs()
	local overflowLeft = self.scrollX < 0
	local overflowRight = x + widthOfAllTabs > self.width
    local blinkTabsAlphaNotUpdated = true;
	if widthOfAllTabs > self.width then
		self:setStencilRect(0, 0, self.width, self.tabHeight)
	end
	if self.backwardView.view:isVisible() then
	    x = self:renderView(self.backwardView, tabDragSelected, x, tabWidth, gap)
	end
	for i,viewObject in ipairs(newViewList) do
        if self.shownViews and self.shownViews[i] then
            x = self:renderView(viewObject, tabDragSelected, x, tabWidth, gap)
        end
	end
	if self.forwardView.view:isVisible() then
	    x = self:renderView(self.forwardView, tabDragSelected, x, tabWidth, gap)
    end
	local butPadX = 3
	if overflowLeft then
		local tex = getTexture("media/ui/ArrowLeft.png")
		local butWid = tex:getWidthOrig() + butPadX * 2
		self:drawRect(inset, 0, butWid, self.tabHeight, 1, 0, 0, 0)
		self:drawRectBorder(inset, 0, butWid, self.tabHeight, 1, 1, 1, 1)
		self:drawTexture(tex, inset + butPadX, (self.tabHeight - tex:getHeight()) / 2, 1, 1, 1, 1)
	end
	if overflowRight then
		local tex = getTexture("media/ui/ArrowRight.png")
		local butWid = tex:getWidthOrig() + butPadX * 2
		self:drawRect(self.width - inset - butWid, 0, butWid, self.tabHeight, 1, 0, 0, 0)
		self:drawRectBorder(self.width - inset - butWid, 0, butWid, self.tabHeight, 1, 1, 1, 1)
		self:drawTexture(tex, self.width - butWid + butPadX, (self.tabHeight - tex:getHeight()) / 2, 1, 1, 1, 1)
	end
	if widthOfAllTabs > self.width then
		self:clearStencilRect()
	end
	-- we draw a ghost of our tab we currently dragging
	if self.draggingTab and self.isDragging and not ISTabPanel.mouseOut then
		if self.draggingTab > 0 then
			self:drawTextureScaled(ISTabPanel.tabSelected, inset + (self.draggingTab * (tabWidth + gap)) + (self:getMouseX() - ISTabPanel.xMouse), 0, tabWidth, self.tabHeight - 1, 0.8,1,1,1);
			self:drawTextCentre(ISTabPanel.viewDragging.name, inset + (self.draggingTab * (tabWidth + gap)) + (self:getMouseX() - ISTabPanel.xMouse) + (tabWidth / 2), 3, 1, 1, 1, 1, UIFont.Normal);
		else
			self:drawTextureScaled(ISTabPanel.tabSelected, inset + (self:getMouseX() - ISTabPanel.xMouse), 0, tabWidth, self.tabHeight - 1, 0.8,1,1,1);
			self:drawTextCentre(ISTabPanel.viewDragging.name, inset + (self:getMouseX() - ISTabPanel.xMouse) + (tabWidth / 2), 3, 1, 1, 1, 1, UIFont.Normal);
		end
    end
end

ISTabPanelPaginated.redoTab = function(self)
	local newView = {};
	if ISTabPanel.fromOutside then
		-- we now remove our false view created when we mouse over this tab panel with our collapsable window
		local trueViewList = {};
		for i,viewObject in ipairs(self.viewList) do
			if viewObject.name ~= ISTabPanel.viewDragging.view:getTitle() then
				table.insert(trueViewList, viewObject);
			end
		end
		self.viewList = trueViewList;
--~ 		print(#self.viewList);
		-- we remove all the child view from the collapsable window and add them to our own tab panel
		for i,v in pairs(ISTabPanel.viewDragging.view:getViews()) do
			self:addChild(v);
			v:setY(self.y + self.tabHeight);
			v:setX(self.x);
			newView.view = v;
			newView.name = ISTabPanel.viewDragging.view:getTitle();
			table.insert(self.viewList, self:getTabIndexAtX(self:getMouseX()), newView);
--~ 			print(#self.viewList);
		end
		ISTabPanel.viewDragging.view:clearChildren();
		ISTabPanel.viewDragging.view:setVisible(false);
		ISTabPanel.viewDragging.view:removeFromUIManager();
	-- we re do all our tab in the list to display them in the new order we choose (by dragging a tab)
	else
		local newViewList = {};
		for i,viewObject in ipairs(self.viewList) do
			if i ~= (self.draggingTab + 1) then
				table.insert(newViewList, viewObject);
			else
				newView = viewObject;
			end
		end
		local tabIndex = self:getTabIndexAtX(self:getMouseX()) - 1
		if tabIndex >= 0 then
			tabIndex = math.min(tabIndex, #self.viewList - 1)
			table.insert(newViewList, tabIndex + 1, newView);
			self.viewList = newViewList;
		end
	end
	-- reset the dragging
	self.activeView.view:setVisible(false);
	newView.view:setVisible(true);
	self.activeView = newView;
	self.draggingTab = nil;
	ISTabPanel.xMouse = -1;
	ISTabPanel.yMouse = -1;
	self.isDragging = false;
	ISTabPanel.viewDragging = nil;
end

--************************************************************************--
--** ISTabPanelPaginated:onMouseUp
--**
--************************************************************************--

function ISTabPanelPaginated:getViewByIndex(index)
	for ind,value in ipairs(self.viewList) do
		-- we get the view we want to display
		if ind == index then
			return value.view;
		end
	end
	return nil;
end

function ISTabPanelPaginated:setPagesCount(pagesCount)
    if pagesCount == self.pagesCount then
        return
    end
    if pagesCount == 0 then
        self.forwardView.view:setVisible(false);
        self.backwardView.view:setVisible(false);
    else
        self.forwardView.view:setVisible(true);
        self.backwardView.view:setVisible(true);
    end
    if pagesCount > self.shownViewsCount then
        self.tooMuchViews = true
    else
        self.tooMuchViews = false
    end

    local toRemove = {}
    if pagesCount < self.pagesCount then
        for i, view in ipairs(self.viewList) do
            if i > pagesCount then
                table.insert(toRemove, view.name)
            end
        end
    elseif pagesCount > self.pagesCount then
        for i = self.pagesCount + 1, pagesCount do
            self:addView(tostring(i), ISUIElement:new(0,0,100,100))
        end
    end
    if toRemove then
        for i, viewName in ipairs(toRemove) do
            self:removeView(self:getView(viewName))
        end
    end
    self.pagesCount = pagesCount
    self.shownViews = {}
    for i = 1, self.pagesCount do
        if self.tooMuchViews then
            if i >= self:getActiveViewIndex() - 1 and i < self:getActiveViewIndex() + 3 or i == self.pagesCount then
                self.shownViews[i] = true
            end
        else
            self.shownViews[i] = true
        end
    end
end

function ISTabPanelPaginated:getPagesCount()
    return self.pagesCount
end

function ISTabPanelPaginated:new (x, y, width, height, pagesCount)
	local o = {};
	o = ISTabPanel:new(x, y, width, height);
	setmetatable(o, self);
	self.__index = self;
	o.pagesCount = pagesCount;
	o.mouseDownHook = nil;
	return o;
end


ISTabPanelPaginated.tabSelected = getTexture("media/ui/XpSystemUI/tab_selected.png");
ISTabPanelPaginated.tabUnSelected = getTexture("media/ui/XpSystemUI/tab_unselected.png");

