--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

ISTiledIconPanel = ISPanel:derive("ISTiledIconPanel");

function ISTiledIconPanel:initialise()
	ISPanel.initialise(self);
end

function ISTiledIconPanel:createChildren()
    ISPanel.createChildren(self);

    self.buttonPrev = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_HGT, BUTTON_HGT, nil)
    --self.buttonPrev.image = (not self.showInfo) and self.iconInfo or self.iconPanel;
    self.buttonPrev.image = getTexture("ArrowLeft");
    self.buttonPrev.target = self;
    self.buttonPrev.onclick = ISTiledIconPanel.onButtonClick;
    self.buttonPrev.enable = true;
    self.buttonPrev:initialise();
    self.buttonPrev:instantiate();
    self:addChild(self.buttonPrev);

    local fontHeight = -1; -- <=0 sets label initial height to font
    self.pagesLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, "1 / 1", 1.0, 1.0, 1.0, 1, UIFont.Small, true)
    --self.borderLabel.center = true;
    self.pagesLabel.textColor = self.textColor;
    self.pagesLabel:initialise();
    self.pagesLabel:instantiate();
    --self:addChild(self.borderLabel);
    self:addChild(self.pagesLabel);

    self.buttonNext = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISButton, 0, 0, BUTTON_HGT, BUTTON_HGT, nil)
    --self.buttonNext.image = (not self.showInfo) and self.iconInfo or self.iconPanel;
    self.buttonNext.image = getTexture("ArrowRight");
    self.buttonNext.target = self;
    self.buttonNext.onclick = ISTiledIconPanel.onButtonClick;
    self.buttonNext.enable = true;
    self.buttonNext:initialise();
    self.buttonNext:instantiate();
    self:addChild(self.buttonNext);
    
    self.tiledIconListBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTiledIconListBox, 0, 0, 10, 10, self.dataList);
    self.tiledIconListBox.minimumColumns = 5;
    self.tiledIconListBox.callbackTarget = self;
    self.tiledIconListBox.onRenderTile = self.onRenderTile;
    self.tiledIconListBox.onClickTile = self.onTileClicked;
    self.tiledIconListBox.onHoverTile = self.onTileMouseHover;
    self.tiledIconListBox.onPageChanged = self.onPageChanged;
    self.tiledIconListBox.onPageScrolled = self.onPageScrolled;
    self.tiledIconListBox:initialise();
    self.tiledIconListBox:instantiate();
    self:addChild(self.tiledIconListBox);

    if self.enableSearchBox then
    self.entryBox = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISTextEntryBox, "", 0, 0, 100, BUTTON_HGT);
    self.entryBox.font = UIFont.Small;
    self.entryBox:initialise();
    self.entryBox:instantiate();
    self.entryBox.onTextChange = ISTiledIconPanel.onTextChange;
    self.entryBox.target = self;
    self.entryBox:setClearButton(true);
    self:addChild(self.entryBox);

    self.searchHackLabel = ISXuiSkin.build(self.xuiSkin, "S_NeedsAStyle", ISLabel, 0, 0, fontHeight, self.searchInfoText, 0.3, 0.3, 0.3, 1, UIFont.Small, true)
    --self.searchHackLabel.center = true;
    --self.searchHackLabel.textColor = self.textColor;
    self.searchHackLabel:initialise();
    self.searchHackLabel:instantiate();
    self:addChild(self.searchHackLabel);
end
end

function ISTiledIconPanel:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local testHeight = 0;
    if self.buttonPrev then
        testHeight = self.buttonPrev:getHeight()+(self.margin*2);
    end

    if self.tiledIconListBox then
        self.tiledIconListBox:calculateLayout(0,0);
        testHeight = testHeight+self.tiledIconListBox:getHeight()+self.margin;
        width = math.max(width, self.tiledIconListBox:getWidth()+(self.margin*2));
    end

    if self.entryBox then
        testHeight = testHeight+self.entryBox:getHeight()+self.margin;
    end

    height = math.max(height, testHeight);

    self.buttonPrev:setX(UI_BORDER_SPACING+1);
    self.buttonPrev:setY(UI_BORDER_SPACING+1);

    self.pagesLabel:setX((width/2)-(self.pagesLabel:getWidth()/2));
    self.pagesLabel.originalX = self.pagesLabel:getX();
    self.pagesLabel:setY(UI_BORDER_SPACING+1)

    self.buttonNext:setX(width-self.buttonNext:getWidth()-UI_BORDER_SPACING-1);
    self.buttonNext:setY(UI_BORDER_SPACING+1);

    if self.tiledIconListBox then
        local boxHeight = height-(UI_BORDER_SPACING*4+2)-self.buttonPrev:getHeight() - (self.entryBox and self.entryBox:getHeight() or 0);
        self.tiledIconListBox:setX(UI_BORDER_SPACING+1);
        self.tiledIconListBox:setY(UI_BORDER_SPACING*2+1+self.buttonPrev:getHeight());
        self.tiledIconListBox:calculateLayout(width-((UI_BORDER_SPACING+1)*2), boxHeight);

        --width = math.max(width, self.tiledIconListBox:getWidth());
        --height = math.max(height, self.tiledIconListBox:getHeight());
    end

    if self.entryBox then
    self.entryBox:setX(UI_BORDER_SPACING+1);
    self.entryBox:setY(height-UI_BORDER_SPACING-1-self.entryBox:getHeight())
    self.entryBox:setWidth(width-(UI_BORDER_SPACING+1)*2);

    self.searchHackLabel:setX(self.entryBox:getX()+4);
    self.searchHackLabel.originalX = self.searchHackLabel:getX();
    local y = self.entryBox:getY() + (self.entryBox:getHeight()/2);
    y = y - self.searchHackLabel:getHeight()/2;
    self.searchHackLabel:setY(y);
    end

    self:setWidth(width);
    self:setHeight(height);
end

function ISTiledIconPanel:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISTiledIconPanel:prerender()
    ISPanel.prerender(self);

    if self.entryBox then
    if self.entryBox:isFocused() or (self.entryBox:getText() and #self.entryBox:getText()>0) then
        self.searchHackLabel:setVisible(false);
    else
        self.searchHackLabel:setVisible(true);
    end
end
end

function ISTiledIconPanel:render()
    ISPanel.render(self);
end

function ISTiledIconPanel:update()
    ISPanel.update(self);
end

function ISTiledIconPanel:onPageChanged()
    self.pagesLabel:setName(tostring(self.tiledIconListBox:getCurrentPage()+1).." / "..tostring(self.tiledIconListBox:getPages()))
end

-- optional override
function ISTiledIconPanel:onPageScrolled(_newPage)
end

-- override this function for correct tile render
-- tileData is object of type that the tilediconpanel is displaying (recipe,inventoryitem etc)
function ISTiledIconPanel:onRenderTile(_tileData, _x, _y, _width, _height, _mouseover)
    self:drawRectBorderStatic(_x, _y, _width, _height, 1.0, 0.5, 0.5, 0.5);
end

-- optional override
function ISTiledIconPanel:onTileClicked(_tileData, _x, _y, _width, _height, _mouseover)
end

-- optional override
function ISTiledIconPanel:onTileMouseHover(_tileData)
    --[[
    if _tileData then
        self:activateToolTip(_tileData);
    else
        self:deactivateToolTip();
    end
    --]]
end

-- optional override
function ISTiledIconPanel:onFilterData(_string, _dataList, _sourceDataList)
end

function ISTiledIconPanel:onButtonClick(_button)
    if self.buttonPrev and _button==self.buttonPrev then
        self.tiledIconListBox:setCurrentPage(self.tiledIconListBox:getCurrentPage()-1)
    elseif self.buttonNext and _button==self.buttonNext then
        self.tiledIconListBox:setCurrentPage(self.tiledIconListBox:getCurrentPage()+1)
    end
end

function ISTiledIconPanel.onTextChange(box)
    if not box then
        return;
    end
    if box:getInternalText()~=box.target.searchText then
        box.target.searchText = box:getInternalText();
        box.target:filterData(box.target.searchText);
    end
end

function ISTiledIconPanel:filterData(_string)
    if self.onFilterData and self.callbackTarget then
        --self.dataList = self.onFilterData(self.callbackTarget, _string, self.dataList, self.sourceDataList);
        self.onFilterData(self.callbackTarget, _string, self.dataList, self.sourceDataList);
    end

    if self.tiledIconListBox then
        self.tiledIconListBox:calculateTiles();
    end
end

function ISTiledIconPanel:setDataList(_dataList)
    local currentRecipe = self.callbackTarget and self.callbackTarget.logic and self.callbackTarget.logic:getRecipe();
    local currentRecipeFound = false;
    
    self.sourceDataList = ArrayList.new();
    for i = 0, _dataList:size()-1 do
        local failed = false;
        if _dataList:get(i):getOnAddToMenu() then
            local func = _dataList:get(i):getOnAddToMenu();
            local params = {player = self.player, recipe = _dataList:get(i)}

            failed = not callLuaBool(func, params);
        end
        if not failed then
            self.sourceDataList:add(_dataList:get(i));

            if _dataList:get(i) == currentRecipe then
                currentRecipeFound = true;
            end
        end
    end

    self.dataList:clear();
    self.dataList:addAll(self.sourceDataList);
    
    self:filterData(self.searchText);

    if currentRecipeFound then
        -- restore selection
        self:setSelectedData(currentRecipe);
    --elseif self.dataList:size() > 0 then
    --    self:setSelectedData(self.dataList:get(0));
    --    if self.callbackTarget and self.callbackTarget.logic then
    --        self.callbackTarget.logic:setRecipe(self.dataList:get(0));
    --    end
    end
end

function ISTiledIconPanel:setSearchInfoText(_text)
    self.searchInfoText = _text;
    if self.searchHackLabel then
        self.searchHackLabel:setName(self.searchInfoText);
    end
end

function ISTiledIconPanel:setSelectedData(_data)
    if self.sourceDataList and self.sourceDataList:contains(_data) then
        self.tiledIconListBox.selectedTileData = _data;
    end
end

function ISTiledIconPanel:onJoypadButtonReleased(button, joypadData)
    if button == Joypad.LBumper then
        local currentPage = self.tiledIconListBox:getCurrentPage()
        self.buttonPrev:forceClick()
        if currentPage ~= self.tiledIconListBox:getCurrentPage() then
            self.tiledIconListBox:trySelectDataElement(self.tiledIconListBox.currentPage * self.tiledIconListBox.tileCount)
        end
    end
    if button == Joypad.RBumper then
        local currentPage = self.tiledIconListBox:getCurrentPage()
        self.buttonNext:forceClick()
        if currentPage ~= self.tiledIconListBox:getCurrentPage() then
            self.tiledIconListBox:trySelectDataElement(self.tiledIconListBox.currentPage * self.tiledIconListBox.tileCount)
        end
    end
end

function ISTiledIconPanel:onJoypadDirLeft(joypadData)
    self.tiledIconListBox:onJoypadDirLeft(joypadData)
end

function ISTiledIconPanel:onJoypadDirRight(joypadData)
    self.tiledIconListBox:onJoypadDirRight(joypadData)
end

function ISTiledIconPanel:onJoypadDirUp(joypadData)
    self.tiledIconListBox:onJoypadDirUp(joypadData)
end

function ISTiledIconPanel:onJoypadDirDown(joypadData)
    self.tiledIconListBox:onJoypadDirDown(joypadData)
end

--************************************************************************--
--** ISTiledIconPanel:new
--**
--************************************************************************--
function ISTiledIconPanel:new (x, y, width, height, player, dataList, callbackTarget)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.sourceDataList = dataList;
    o.callbackTarget = callbackTarget;

    o.dataList = ArrayList.new();
    if o.sourceDataList then
        o.dataList:addAll(o.sourceDataList);
    end

    o.background = false;
    o.searchText = "";
    o.searchInfoText = getText("IGUI_DebugMenu_Search");
    o.enableSearchBox = true;

    o.margin = UI_BORDER_SPACING;
    o.minimumWidth = 0;
    o.minimumHeight = 0;

    --o.doToolTip = true;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end