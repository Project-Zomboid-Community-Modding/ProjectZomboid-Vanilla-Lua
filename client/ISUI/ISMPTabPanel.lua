require "ISUI/ISPanel"

ISMPTabPanel = ISPanel:derive("ISMPTabPanel");
ISMPTabPanel.xMouse = -1;
ISMPTabPanel.yMouse = -1;
ISMPTabPanel.mouseOut = false;
ISMPTabPanel.viewDragging = nil;

function ISMPTabPanel:initialise()
	ISPanel.initialise(self);
end

function ISMPTabPanel:updateSmoothScrolling()
	if not self.smoothScrollTargetX then return end
	local dx = self.smoothScrollTargetX - self.smoothScrollX
	local inset = 1
	local maxXScroll = self:getWidthOfAllTabs() - (self:getWidth() - inset * 2)
	if maxXScroll < 0 then maxXScroll = 0 end
	local frameRateFrac = UIManager.getMillisSinceLastRender() / 33.3
	local targetX = self.smoothScrollX + dx * 0.25 * frameRateFrac
	if targetX > 0 then targetX = 0 end
	if targetX < -maxXScroll then targetX = -maxXScroll end
	if math.abs(targetX - self.smoothScrollTargetX) > 1 then
		self.scrollX = math.floor(targetX)
		self.smoothScrollX = targetX
	else
		self.scrollX = self.smoothScrollTargetX
		self.smoothScrollTargetX = nil
	end
end

function ISMPTabPanel:ensureVisible(index)
    if not index or index < 1 or index > #self.viewList then return end
	if not self.smoothScrollTargetX then self.smoothScrollX = self.scrollX end
	local inset = 1
	local x = self:getTabX(index, 0) - inset
	local tabWidth = self.equalTabWidth and self.maxLength or self.viewList[index].tabWidth
	if x < 0-self.scrollX then
		self.smoothScrollTargetX = 0 - x
	elseif x + tabWidth > 0 - self.scrollX + (self.width - inset * 2) then
		self.smoothScrollTargetX = 0 - (x + tabWidth - (self.width - inset * 2))
	end
end

function ISMPTabPanel:setTabsTransparency(alpha)
    self.tabTransparency = alpha;
end

function ISMPTabPanel:setTextTransparency(alpha)
    self.textTransparency = alpha;
end

function ISMPTabPanel:prerender2()
	-- if the mouse is over the tab panel and we got a tab to drag, we gonna display it outside
	if ISMPTabPanel.mouseOut and ISMPTabPanel.viewDragging and not ISMouseDrag.dragView then
		self:clearStencilRect();
		self:setStencilRect(0 - self:getAbsoluteX(), 0 - self:getAbsoluteY(), getCore():getScreenWidth(), getCore():getScreenHeight());
		self:drawRectBorder(self:getMouseX(), self:getMouseY(), ISMPTabPanel.viewDragging.view:getWidth(), ISMPTabPanel.viewDragging.view:getHeight(), 1,1,1,1);
		self:clearStencilRect();
	end
	self:updateSmoothScrolling()
end

function ISMPTabPanel:prerender()
	local newViewList = {};
	local tabDragSelected = -1;
	if self.draggingTab and not self.isDragging and ISMPTabPanel.xMouse > -1 and ISMPTabPanel.xMouse ~= self:getMouseX() then -- do we move the mouse since we have let the left button down ?
		self.isDragging = self.allowDraggingTabs;
	end
	local tabWidth = self.maxLength
	local inset = 1 -- assumes a 1-pixel window border on the left to avoid
	local gap = 12 -- gap between tabs
	if self.isDragging and not ISMPTabPanel.mouseOut then
		-- we fetch all our view to remove the tab of the view we're dragging
		for i,viewObject in ipairs(self.viewList) do
			if i ~= (self.draggingTab + 1) then
				table.insert(newViewList, viewObject);
			else
				ISMPTabPanel.viewDragging = viewObject;
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
	for i,viewObject in ipairs(newViewList) do
		tabWidth = self.equalTabWidth and self.maxLength or viewObject.tabWidth
		-- if we drag a tab over an existing one, we move the other
		if tabDragSelected ~= -1 and i == (tabDragSelected + 1) then
			x = x + tabWidth + gap;
		end
		-- if this tab is the active one, we make the tab btn lighter
		if viewObject.name == self.activeView.name and not self.isDragging and not ISMPTabPanel.mouseOut then
            self:drawRect(x, 0, tabWidth, self.tabHeight, self.backgroundColorSelected.a, self.backgroundColorSelected.r, self.backgroundColorSelected.g, self.backgroundColorSelected.b);
            self:drawTextureScaled(viewObject.iconEnabled, x + self.tabPadX, self.tabPadX, self.tabHeight - (self.tabPadX*2), self.tabHeight - (self.tabPadX*2), 1,1,1,1);
            -- Draw one dark line
            self:drawRect(x+1, self.tabHeight, tabWidth-2, 1, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
            -- Draw panel border
            self:drawRect(0, self.tabHeight, x+1, 1, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
            self:drawRect(x+tabWidth-1, self.tabHeight, self.width-(x+tabWidth-1), 1, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
            self:drawRect(0, self.tabHeight, 1, self:getHeight() - self.tabHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
            self:drawRect(self:getWidth()-1, self.tabHeight, 1, self:getHeight() - self.tabHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
            self:drawRect(1, self.tabHeight + self:getHeight() - self.tabHeight - 1, self:getWidth()-2, 1, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
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
                self:drawRect(x, 0, tabWidth, self.tabHeight, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
                self:drawTextureScaled(viewObject.iconDisabled, x + self.tabPadX, self.tabPadX, self.tabHeight - (self.tabPadX*2), self.tabHeight - (self.tabPadX*2), 1,1,1,1);


                self:drawRect(x, 0, tabWidth, self.tabHeight - 1, alpha, 1, 1, 1);
            elseif shouldBlink then
                alpha = self.blinkTabAlpha;
                self:drawRect(x, 0, tabWidth, self.tabHeight - 1, alpha, 1, 1, 1);
                self:drawTextureScaled(viewObject.iconDisabled, x + self.tabPadX, self.tabPadX, self.tabHeight - (self.tabPadX*2), self.tabHeight - (self.tabPadX*2), 1,1,1,1);

            else
                self:drawRect(x, 0, tabWidth, self.tabHeight, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b);
                self:drawTextureScaled(viewObject.iconDisabled, x + self.tabPadX, self.tabPadX, self.tabHeight - (self.tabPadX*2), self.tabHeight - (self.tabPadX*2), 1,1,1,1);


			    if self:getMouseY() >= 0 and self:getMouseY() < self.tabHeight and self:isMouseOver() and self:getTabIndexAtX(self:getMouseX()) == i then
					viewObject.fade:setFadeIn(true)
				else
					viewObject.fade:setFadeIn(false)
			    end
			    viewObject.fade:update()
           end
		end
        -- Draw tab border
        self:drawRect(x, 0, 1, self.tabHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
        self:drawRect(x+1, 0, tabWidth-2, 1, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);
        self:drawRect(x+tabWidth-1, 0, 1, self.tabHeight, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b);


		self:drawText(viewObject.name, x  + self.tabHeight, 3, 1, 1, 1, self.textTransparency, UIFont.Large);
		x = x + tabWidth + gap;
	end
    -- Draw panel background
    self:drawRect(1, self.tabHeight+1, self:getWidth()-2, self:getHeight()-self.tabHeight-2, self.backgroundColorPanel.a, self.backgroundColorPanel.r, self.backgroundColorPanel.g, self.backgroundColorPanel.b);

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
	if self.draggingTab and self.isDragging and not ISMPTabPanel.mouseOut then
		if self.draggingTab > 0 then
			self:drawTextCentre(ISMPTabPanel.viewDragging.name, inset + (self.draggingTab * (tabWidth + gap)) + (self:getMouseX() - ISMPTabPanel.xMouse) + (tabWidth / 2), 3, 1, 1, 1, 1, UIFont.Normal);
		else
			self:drawTextCentre(ISMPTabPanel.viewDragging.name, inset + (self:getMouseX() - ISMPTabPanel.xMouse) + (tabWidth / 2), 3, 1, 1, 1, 1, UIFont.Normal);
		end
    end
end

function ISMPTabPanel:onMouseDown(x, y)
	if self.isDragging then
		ISMPTabPanel.redoTab(self);
	elseif self:getMouseY() >= 0 and self:getMouseY() < self.tabHeight then
		if self:getScrollButtonAtX(x) == "left" then
			self:onMouseWheel(-1)
			return
		end
		if self:getScrollButtonAtX(x) == "right" then
			self:onMouseWheel(1)
			return
		end
		local tabIndex = self:getTabIndexAtX(self:getMouseX())
		if tabIndex >= 1 and tabIndex <= #self.viewList and ISMPTabPanel.xMouse == -1 and ISMPTabPanel.yMouse == -1 then -- if we clicked on a tab, the first time we set up the x,y of the mouse, so next time we can see if the player moved the mouse (moved the tab)
			ISMPTabPanel.xMouse = self:getMouseX();
			ISMPTabPanel.yMouse = self:getMouseY();
			self.draggingTab = tabIndex - 1;
			local clickedTab = self.viewList[self.draggingTab + 1];
			getSoundManager():playUISound("UIActivateTab")
			self:activateView(clickedTab.name)
		end
	end
end

-- if you drag a tab outside the panel
function ISMPTabPanel:onMouseMoveOutside(dx, dy)
	if self.draggingTab and self.allowTornOffTabs then
		ISMPTabPanel.mouseOut = true;
	end
end

-- if you drag a tab inside the panel
function ISMPTabPanel:onMouseMove(dx, dy)
	ISMPTabPanel.mouseOut = false;
	if ISMouseDrag.dragView and not self.draggingTab then
		-- we create a "false" view so we can drag it easily
		ISMPTabPanel.viewDraggin = {};
		ISMPTabPanel.viewDraggin.view = ISMouseDrag.dragView;
		if ISMPTabPanel.viewDraggin.view:getTitle() then
			ISMPTabPanel.viewDraggin.name = ISMPTabPanel.viewDraggin.view:getTitle();
		else
			ISMPTabPanel.viewDraggin.name = "Tab " .. #self.viewList + 1;
		end
		table.insert(self.viewList, ISMPTabPanel.viewDraggin);
		self.draggingTab = #self.viewList - 1;
		self.isDragging = true;
		ISMPTabPanel.xMouse = self:getMouseX();
		ISMPTabPanel.fromOutside = true;
		ISMouseDrag.tabPanel = self;
	end
end


-- if you dragged a tab out of the panel and release the button, we place the view here
function ISMPTabPanel:onMouseUpOutside(x, y)
	if ISMPTabPanel.mouseOut and self.isDragging and ISMPTabPanel.viewDragging then
		local newViewList = {};
		for i,viewObject in ipairs(self.viewList) do
			if i ~= (self.draggingTab + 1) then
				table.insert(newViewList, viewObject);
			end
		end
		self.viewList = newViewList;
		self.draggingTab = nil;
		ISMPTabPanel.xMouse = -1;
		ISMPTabPanel.yMouse = -1;
		self.isDragging = false;
		ISMPTabPanel.mouseOut = false;
		-- we start to remove the view from our tab panel
		self:removeChild(ISMPTabPanel.viewDragging.view);
		local newWindow = ISCollapsableWindow:new(self:getMouseX() + self:getAbsoluteX(), self:getMouseY() + self:getAbsoluteY(), ISMPTabPanel.viewDragging.view:getWidth(), ISMPTabPanel.viewDragging.view:getHeight());
		newWindow:initialise();
		newWindow:addToUIManager();
		newWindow:addView(ISMPTabPanel.viewDragging.view);
		newWindow:setTitle(ISMPTabPanel.viewDragging.name);
		local tornOff = ISMPTabPanel.viewDragging.view
		ISMPTabPanel.viewDragging = nil;
		local clickedView = nil;
		-- if we doesn't have any view anymore, we close this tab panel and his parent
		if #self.viewList == 0 then
			if self.parent then
				self.parent:setVisible(false);
				self.parent:setRemoved(true);
			end
			self:setVisible(false);
			self:removeFromUIManager();
		else
			for ind,value in ipairs(self.viewList) do
				-- we get the view we clicked on
				clickedView = value;
				break;
			end
			-- if we clicked on another view, we display it and make the previous one not visible
			if clickedView then
				clickedView.view:setVisible(true);
				self.activeView = clickedView;
			end
		end
		if self.tabTornOff ~= nil then
			self.tabTornOff(self.tabTornOffTarget, tornOff, newWindow)
		end
	else
		self.draggingTab = nil
		self.isDragging = false;
		ISMPTabPanel.xMouse = -1;
		ISMPTabPanel.yMouse = -1;
		ISMPTabPanel.mouseOut = false;
	end
end

ISMPTabPanel.redoTab = function(self)
	local newView = {};
	if ISMPTabPanel.fromOutside then
		-- we now remove our false view created when we mouse over this tab panel with our collapsable window
		local trueViewList = {};
		for i,viewObject in ipairs(self.viewList) do
			if viewObject.name ~= ISMPTabPanel.viewDragging.view:getTitle() then
				table.insert(trueViewList, viewObject);
			end
		end
		self.viewList = trueViewList;
		-- we remove all the child view from the collapsable window and add them to our own tab panel
		for i,v in pairs(ISMPTabPanel.viewDragging.view:getViews()) do
			self:addChild(v);
			v:setY(self.y + self.tabHeight);
			v:setX(self.x);
			newView.view = v;
			newView.name = ISMPTabPanel.viewDragging.view:getTitle();
			table.insert(self.viewList, self:getTabIndexAtX(self:getMouseX()), newView);
		end
		ISMPTabPanel.viewDragging.view:clearChildren();
		ISMPTabPanel.viewDragging.view:setVisible(false);
		ISMPTabPanel.viewDragging.view:removeFromUIManager();
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
	ISMPTabPanel.xMouse = -1;
	ISMPTabPanel.yMouse = -1;
	self.isDragging = false;
	ISMPTabPanel.viewDragging = nil;
end

function ISMPTabPanel:onMouseUp(x, y)
	if self.isDragging then
		ISMPTabPanel.redoTab(self);
	else
		self.draggingTab = nil;
		ISMPTabPanel.xMouse = -1;
		ISMPTabPanel.yMouse = -1;
		self.isDragging = false;
		ISMPTabPanel.viewDragging = nil;
	end
end

function ISMPTabPanel:onMouseWheel(del)
	if self:isMouseOver() and self:getMouseY() < self.tabHeight then
		if not self.smoothScrollTargetX then self.smoothScrollX = self.scrollX end
		local inset = 1
		local scrollIndex = self:getTabIndexAtX(inset, self.smoothScrollTargetX or self.scrollX)
		self.smoothScrollTargetX = 0
		if scrollIndex == -1 then return true end
		if del > 0 then
			scrollIndex = scrollIndex + 1
		else
			if scrollIndex > 1 then
				scrollIndex = scrollIndex - 1
			end
		end
		local gap = 1
		local maxXScroll = self:getWidthOfAllTabs() - (self:getWidth() - inset * 2)
		for ind,view in ipairs(self.viewList) do
			if scrollIndex > ind then
				local tabWidth = self.equalTabWidth and self.maxLength or view.tabWidth
				self.smoothScrollTargetX = self.smoothScrollTargetX - tabWidth - gap
				if self.smoothScrollTargetX <= -maxXScroll then
					self.smoothScrollTargetX = -maxXScroll
					break
				end
			end
		end
		return true
	end
	return false
end

function ISMPTabPanel:getView(viewName)
	for ind,value in ipairs(self.viewList) do
		-- we get the view we want to display
		if value.name == viewName then
			return value.view;
		end
	end
	return nil;
end

function ISMPTabPanel:setWidth(w)
    self.activeView.view:setWidth(w)
    ISPanel.setWidth(self, w);
end

function ISMPTabPanel:setHeight(h)
    self.activeView.view:setHeight(h-self.tabHeight)
    ISPanel.setHeight(self, h);
end

function ISMPTabPanel:activateView(viewName)
	for ind,value in ipairs(self.viewList) do
		-- we get the view we want to display
		if value.name == viewName then
			self.activeView.view:setVisible(false);
			value.view:setVisible(true);
			value.view:setX(1)
			value.view:setY(self.tabHeight)
			value.view:setWidth(self:getWidth())
            value.view:setHeight(self:getHeight() - self.tabHeight)
			self.activeView = value;
			self:ensureVisible(ind)

			if self.parent and self.parent.infoButton then
				if self.activeView.view.infoText then
					self.parent:setInfo(self.activeView.view.infoText)
				else
					self.parent:setInfo(nil)
				end
			end

			if self.onActivateView and self.target then
				self.onActivateView(self.target, self);
			end

			return true;
		end
	end
	return false;
end

function ISMPTabPanel:getActiveView()
	if self.activeView then
		return self.activeView.view
	end
	return nil
end

function ISMPTabPanel:getActiveViewIndex()
	if self.activeView then
		for index,value in ipairs(self.viewList) do
			if value == self.activeView then
				return index
			end
		end
	end
	return nil
end

-- add a view to our tab panel
function ISMPTabPanel:addView(name, iconEnabled, iconDisabled, view)
	local viewObject = {};
	viewObject.name = name;
	viewObject.view = view;
	viewObject.iconEnabled = iconEnabled;
	viewObject.iconDisabled = iconDisabled;
	viewObject.tabWidth = self.tabWidth
	viewObject.fade = UITransition.new()
	table.insert(self.viewList, viewObject);
	-- the view have to be under our tab
	view:setY(self.tabHeight);
	self:addChild(view);
	view.parent = self;
	-- the 1st view will be default visible
	if #self.viewList == 1 then
		view:setVisible(true);
		self.activeView = viewObject;
		self.maxLength = viewObject.tabWidth;
	else
		view:setVisible(false);
		if viewObject.tabWidth > self.maxLength then
			self.maxLength = viewObject.tabWidth;
		end
	end
end

function ISMPTabPanel:removeView(view)
	local newViewList = {};
	for _,viewObject in ipairs(self.viewList) do
		if viewObject.view ~= view then
			table.insert(newViewList, viewObject);
		end
	end
	if self.activeView and self.activeView.view == view then
		self.activeView = newViewList[1]
	end
	self.viewList = newViewList;
	self:removeChild(view);
end

function ISMPTabPanel:replaceView(view, panel)
	local previous = nil
	for _,viewObject in ipairs(self.viewList) do
		if viewObject.view == view then
			previous = viewObject.view
			viewObject.view = panel
			return previous
		end
	end
	return nil
end

function ISMPTabPanel:setEqualTabWidth(equal)
	self.equalTabWidth = equal
end

function ISMPTabPanel:setCenterTabs(center)
	self.centerTabs = center
end

function ISMPTabPanel:getWidthOfAllTabs()
	local gap = 1
	local width = (#self.viewList - 1) * gap
	if self.equalTabWidth then
		return width + #self.viewList * self.maxLength
	end
	for _,viewObject in ipairs(self.viewList) do
		width = width + viewObject.tabWidth
	end
	return width
end

function ISMPTabPanel:getTabX(tabIndex, scrollX)
	if tabIndex < 1 or tabIndex > #self.viewList then
		return -1
	end
	local inset = 1
	local gap = 1
	local left = inset
	if self.centerTabs and (self:getWidth() >= self:getWidthOfAllTabs()) then
		left = (self:getWidth() - self:getWidthOfAllTabs()) / 2
	else
		left = left + (scrollX or self.scrollX)
	end
	for i=1,tabIndex-1 do
		local viewObject = self.viewList[i]
		local tabWidth = self.equalTabWidth and self.maxLength or viewObject.tabWidth
		left = left + tabWidth + gap
	end
	return left
end

function ISMPTabPanel:getTabIndexAtX(x, scrollX)
	local inset = 1
	local gap = 1
	local left = inset
	if self.centerTabs and (self:getWidth() >= self:getWidthOfAllTabs()) then
		left = (self:getWidth() - self:getWidthOfAllTabs()) / 2
	else
		left = left + (scrollX or self.scrollX)
	end
	for index,viewObject in ipairs(self.viewList) do
		local tabWidth = self.equalTabWidth and self.maxLength or viewObject.tabWidth
		if x >= left and x < left + tabWidth + gap then
			return index
		end
		left = left + tabWidth + gap
	end
	return -1
end

function ISMPTabPanel:getScrollButtonAtX(x)
	local inset = 1
	local butPadX = 3
	local butWid = butPadX + getTexture("media/ui/ArrowRight.png"):getWidth() + butPadX
	local overflowLeft = self.scrollX < 0
	local overflowRight = inset + self.scrollX + self:getWidthOfAllTabs() > self.width
	if overflowLeft and x < inset + butWid then
		return "left"
	end
	if overflowRight and x >= self.width - inset - butWid then
		return "right"
	end
	return nil
end

function ISMPTabPanel:setOnTabTornOff(target, method)
	self.tabTornOffTarget = target
	self.tabTornOff = method
end

function ISMPTabPanel:new (x, y, width, height)
	local o = {};
	o = ISPanel:new(x, y, width, height);
	setmetatable(o, self);
	self.__index = self;
	o.x = x;
	o.y = y;
	o.backgroundColorPanel = {r=0, g=0, b=0, a=0.8};
	o.backgroundColor = {r=0, g=0, b=0, a=0.8};
	o.backgroundColorSelected = {r=0.61, g=0.23, b=0.11, a=0.8};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.tabTransparency = 1.0;
    o.textTransparency = 1.0;
	o.width = width;
	o.height = height;
	o.anchorLeft = true;
	o.anchorRight = false;
	o.anchorTop = true;
	o.anchorBottom = false;
	o.viewList = {};
	o.activeView = nil;
    o.blinkTabs = {};
	o:noBackground();
	o.draggingTab = nil;
	o.isDragging = false
	o.tabTornOffTarget = nil
	o.tabTornOff = nil
	o.maxLength = 0
	o.tabHeight = getTextManager():getFontHeight(UIFont.Small) + 6
	o.tabPadX = 20
	o.allowDraggingTabs = false
	o.allowTornOffTabs = false
	o.equalTabWidth = true
	o.centerTabs = false
	o.scrollX = 0
	return o;
end


