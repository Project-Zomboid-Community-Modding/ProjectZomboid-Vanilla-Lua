--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

WorldFlaresDebug = ISPanel:derive("WorldFlaresDebug");
WorldFlaresDebug.instance = nil;

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
local FONT_HGT_MEDIUM = getTextManager():getFontHeight(UIFont.Medium)
local UI_BORDER_SPACING = 10
local BUTTON_HGT = FONT_HGT_SMALL + 6

local function roundstring(_val)
    return tostring(ISDebugUtils.roundNum(_val,2));
end

function WorldFlaresDebug.OnOpenPanel()
    if WorldFlaresDebug.instance==nil then
        WorldFlaresDebug.instance = WorldFlaresDebug:new (100, 100, 642+(getCore():getOptionFontSizeReal()*90), 600, getText("IGUI_DebugMenu_Dev_WorldFlares"));
        WorldFlaresDebug.instance:initialise();
        WorldFlaresDebug.instance:instantiate();
    end

    WorldFlaresDebug.instance:addToUIManager();
    WorldFlaresDebug.instance:setVisible(true);

    return WorldFlaresDebug.instance;
end

function WorldFlaresDebug:initialise()
    ISPanel.initialise(self);

    self.flareCount = false;
    self.colExt = { r=1, g=1, b=1 };
    self.colInt = { r=1, g=1, b=1 };
    self.flareID = -1;
end

function WorldFlaresDebug:createChildren()
    ISPanel.createChildren(self);

    local labelWidth = getTextManager():MeasureStringX(UIFont.Small, getText("IGUI_DebugMenu_Dev_WorldFlares"))
    ISDebugUtils.addLabel(self, {}, (self.width - labelWidth)/2, UI_BORDER_SPACING+1, getText("IGUI_DebugMenu_Dev_WorldFlares"), UIFont.Medium, true);
    local columnWidth = (self.width - UI_BORDER_SPACING*4 - 2)/3
    local top = UI_BORDER_SPACING*2+FONT_HGT_MEDIUM+1
    local x, y, obj = UI_BORDER_SPACING+1, top, false;

    local tickOptions = {};
    table.insert(tickOptions, { text = getText("IGUI_WorldFlares_ShowRange"), ticked = WorldFlares.getDebugDraw() });
    y, obj = ISDebugUtils.addTickBox(self,{},x,y,BUTTON_HGT,BUTTON_HGT,"Debug range",tickOptions,WorldFlaresDebug.onTicked);
    y = y + UI_BORDER_SPACING;

    local _, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_WorldFlares_Lifetime")..":", UIFont.Small, true);
    local boxWidth = columnWidth-obj.width - UI_BORDER_SPACING
    y, self.entryBoxLifeTime = ISDebugUtils.addTextEntryBox(self, {}, "60", obj:getRight() + UI_BORDER_SPACING, y, boxWidth, BUTTON_HGT);
    self.entryBoxLifeTime:setOnlyNumbers(true);
    y = y + UI_BORDER_SPACING;

    _, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_WorldFlares_Range")..":", UIFont.Small, true);
    boxWidth = columnWidth-obj.width - UI_BORDER_SPACING
    y, self.entryBoxRange = ISDebugUtils.addTextEntryBox(self, {}, "50", obj:getRight() + UI_BORDER_SPACING, y, boxWidth, BUTTON_HGT);
    self.entryBoxRange:setOnlyNumbers(true);
    y = y + UI_BORDER_SPACING;

    _, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_WorldFlares_Windspeed")..":", UIFont.Small, true);
    boxWidth = columnWidth-obj.width - UI_BORDER_SPACING
    y, self.entryBoxWindspeed = ISDebugUtils.addTextEntryBox(self, {}, "0.00014", obj:getRight() + UI_BORDER_SPACING, y, boxWidth, BUTTON_HGT);
    self.entryBoxWindspeed:setOnlyNumbers(true);
    y = y + UI_BORDER_SPACING;

    y, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_WorldFlares_ColorExt")..":", UIFont.Small, true);
    y = y + UI_BORDER_SPACING;

    self.colExtBoxY = y;
    self.colBoxWidth = columnWidth;
    y = y + BUTTON_HGT+UI_BORDER_SPACING;

    local objLabel;
    y, obj = ISDebugUtils.addSlider(self, "ext_r", x, y, columnWidth, BUTTON_HGT, WorldFlaresDebug.onSliderChange);
    obj.valueLabel = objLabel;
    obj:setValues(0, 1, 0.01, 0.01);
    obj:setCurrentValue(1);
    y = y + UI_BORDER_SPACING;

    y, obj = ISDebugUtils.addSlider(self, "ext_g", x, y, columnWidth, BUTTON_HGT, WorldFlaresDebug.onSliderChange);
    obj.valueLabel = objLabel;
    obj:setValues(0, 1, 0.01, 0.01);
    obj:setCurrentValue(1);
    y = y + UI_BORDER_SPACING;

    y, obj = ISDebugUtils.addSlider(self, "ext_b", x, y, columnWidth, BUTTON_HGT, WorldFlaresDebug.onSliderChange);
    obj.valueLabel = objLabel;
    obj:setValues(0, 1, 0.01, 0.01);
    obj:setCurrentValue(1);
    y = y + UI_BORDER_SPACING;

    y, obj = ISDebugUtils.addLabel(self, {}, x, y, getText("IGUI_WorldFlares_ColorInt")..":", UIFont.Small, true);
    y = y + UI_BORDER_SPACING;

    self.colIntBoxY = y;
    y = y + BUTTON_HGT+UI_BORDER_SPACING;

    local objLabel;
    y, obj = ISDebugUtils.addSlider(self, "int_r", x, y, columnWidth, BUTTON_HGT, WorldFlaresDebug.onSliderChange);
    obj.valueLabel = objLabel;
    obj:setValues(0, 1, 0.01, 0.01);
    obj:setCurrentValue(1);
    y = y + UI_BORDER_SPACING;

    y, obj = ISDebugUtils.addSlider(self, "int_g", x, y, columnWidth, BUTTON_HGT, WorldFlaresDebug.onSliderChange);
    obj.valueLabel = objLabel;
    obj:setValues(0, 1, 0.01, 0.01);
    obj:setCurrentValue(1);
    y = y + UI_BORDER_SPACING;

    y, obj = ISDebugUtils.addSlider(self, "int_b", x, y, columnWidth, BUTTON_HGT, WorldFlaresDebug.onSliderChange);
    obj.valueLabel = objLabel;
    obj:setValues(0, 1, 0.01, 0.01);
    obj:setCurrentValue(1);
    y = y + UI_BORDER_SPACING;

    y, obj = ISDebugUtils.addButton(self,"close", x,y,columnWidth,BUTTON_HGT,getText("IGUI_WorldFlares_AddFlare"),WorldFlaresDebug.onClickAddFlare);
    local addFlareBtn = obj
    self:setHeight(y+UI_BORDER_SPACING+1);

    self.flaresList = ISScrollingListBox:new(x+columnWidth+UI_BORDER_SPACING, top, columnWidth, self.height - top - UI_BORDER_SPACING*2 - BUTTON_HGT - 1);
    self.flaresList:initialise();
    self.flaresList:instantiate();
    self.flaresList.itemheight = BUTTON_HGT;
    self.flaresList.selected = 0;
    self.flaresList.joypadParent = self;
    self.flaresList.font = UIFont.NewSmall;
    self.flaresList.doDrawItem = self.drawFlaresList;
    self.flaresList.drawBorder = true;
    self.flaresList.onmousedown = WorldFlaresDebug.OnFlaresListMouseDown;
    self.flaresList.target = self;
    self:addChild(self.flaresList);

    y, obj = ISDebugUtils.addButton(self,"close",addFlareBtn:getRight()+UI_BORDER_SPACING,addFlareBtn.y,columnWidth,BUTTON_HGT,getText("IGUI_WorldFlares_DeleteFlares"),WorldFlaresDebug.onClickDeleteFlares);
    local deleteFlareBtn = obj

    self.infoX = self.flaresList:getRight()+UI_BORDER_SPACING;
    self.infoY = top;
    self.infoWidth = self:getWidth() - self.infoX - UI_BORDER_SPACING - 1;

    y, obj = ISDebugUtils.addButton(self,"close",deleteFlareBtn:getRight()+UI_BORDER_SPACING,deleteFlareBtn.y,columnWidth,BUTTON_HGT,getText("IGUI_CraftUI_Close"),WorldFlaresDebug.onClickClose);

    self:populateList();
end

function WorldFlaresDebug:onTicked(_index, _selected, _arg1, _arg2, _tickbox)
    --local v = _tickbox.customData;
    --v.lua.cheat = not v.lua.cheat;
    print("index = "..tostring(_index))
    print("selected = "..tostring(_selected))
    print("arg1 = "..tostring(_arg1))
    print("arg2 = "..tostring(_arg2))
    WorldFlares.setDebugDraw(_selected);
end

function WorldFlaresDebug:onSliderChange(_newVal, _slider)
    if _slider.customData=="ext_r" then
        self.colExt.r = _newVal;
    end
    if _slider.customData=="ext_g" then
        self.colExt.g = _newVal;
    end
    if _slider.customData=="ext_b" then
        self.colExt.b = _newVal;
    end
    if _slider.customData=="int_r" then
        self.colInt.r = _newVal;
    end
    if _slider.customData=="int_g" then
        self.colInt.g = _newVal;
    end
    if _slider.customData=="int_b" then
        self.colInt.b = _newVal;
    end

end

function WorldFlaresDebug:onClickDeleteFlares()
    WorldFlares.Clear();
end

function WorldFlaresDebug:onClickAddFlare()
    local lifeTime = self.entryBoxLifeTime:getInternalText();
    lifeTime = (not lifeTime or lifeTime=="") and 60 or tonumber(lifeTime);
    local range = self.entryBoxRange:getInternalText();
    range = (not range or range=="") and 50 or tonumber(range);
    local windspeed = self.entryBoxWindspeed:getInternalText();
    windspeed = (not windspeed or windspeed=="") and -1 or tonumber(windspeed);
    if windspeed<0 then
        windspeed = 0;
    end
    local plr = getPlayer(0);
    local x = plr:getX();
    local y = plr:getY();
    local c = self.colExt;
    local c2 = self.colInt;

    lifeTime = lifeTime*60;
    WorldFlares.launchFlare(lifeTime, x, y, range, windspeed, c.r, c.g, c.b, c2.r, c2.g, c2.b);
end

function WorldFlaresDebug:onClickClose()
    self:close();
end

function WorldFlaresDebug:OnFlaresListMouseDown(item)
    --self:populateInfoList(item);
    self.flareID = item:getId();
end

function WorldFlaresDebug:populateList()
    local count = WorldFlares.getFlareCount();

    if self.flareCount and self.flareCount==count then
        return;
    end

    self.flaresList:clear();

    for i=0, count-1 do
        local flare = WorldFlares.getFlare(i);

        local id = flare:getId();
        self.flaresList:addItem(getText("IGUI_WorldFlares_Flare").." ["..tostring(id).."]", flare);
    end

    self.flareCount = count;
end

function WorldFlaresDebug:drawFlaresList(y, item, alt)
    local a = 0.9;

    self:drawRectBorder(0, (y), self:getWidth(), self.itemheight - 1, a, self.borderColor.r, self.borderColor.g, self.borderColor.b);

    if self.selected == item.index then
        self:drawRect(0, (y), self:getWidth(), self.itemheight - 1, 0.3, 0.7, 0.35, 0.15);
    end

    local flare = item.item;

    --drawRect( x, y, w, h, a, r, g, b)
    local alpha = 1.0;
    local c = flare:getColor():getExterior();
    self:drawRect( self:getWidth()-62, (y+2), 20, self.itemheight - 6, alpha, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
    c = flare:getColor():getInterior();
    self:drawRect( self:getWidth()-40, (y+2), 20, self.itemheight - 6, alpha, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());

    --local prefix = item.item:getIndexOffset()==0 and "TODAY" or tostring(item.item:getIndexOffset());
    --self:drawText( prefix .. " :: " .. item.item:getName(), 10, y + 2, 1, 1, 1, a, self.font);
    --if item.item:isHasFog() then
    --    self:drawText( item.text .. " (F)", 10, y + 2, 0.8, 1, 0.75, a, self.font);
    --else
        self:drawText( item.text, 10, y + 2, 1, 1, 1, a, self.font);
    --end

    return y + self.itemheight;
end


function WorldFlaresDebug:prerender()
    ISPanel.prerender(self);
    self:populateList();

    self:drawRect( UI_BORDER_SPACING+1, self.colExtBoxY, self.colBoxWidth, BUTTON_HGT, 1.0, self.colExt.r, self.colExt.g, self.colExt.b);
    self:drawRect( UI_BORDER_SPACING+1, self.colIntBoxY, self.colBoxWidth, BUTTON_HGT, 1.0, self.colInt.r, self.colInt.g, self.colInt.b);

    local x = self.infoX;
    local y = self.infoY;
    local w = self.infoWidth;
    local w2 = (w-UI_BORDER_SPACING)/2
    local a = 1.0;

    local flare = false;
    if self.flareID and self.flareID>=0 then
        flare = WorldFlares.getFlareID(self.flareID);
    end

    if flare then
        local yOffset = BUTTON_HGT;
        self:drawText( getText("IGUI_WorldFlares_Flare").." ["..tostring(flare:getId()).."]", x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        self:drawText( "x = "..roundstring(flare:getX()), x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        self:drawText( "y = "..roundstring(flare:getY()), x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        self:drawText( getText("IGUI_WorldFlares_Range").." = "..tostring(flare:getRange()), x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        self:drawText( getText("IGUI_WorldFlares_Windspeed").." = "..roundstring(flare:getWindSpeed()), x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        self:drawText( getText("IGUI_WorldFlares_Intensity").."(b) = "..roundstring(flare:getIntensity()), x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        self:drawText( getText("IGUI_WorldFlares_MaxLifetime").." = "..roundstring(flare:getMaxLifeTime()), x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        self:drawText( getText("IGUI_WorldFlares_Lifetime").." = "..roundstring(flare:getLifeTime()), x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        self:drawText( getText("IGUI_WorldFlares_Percent").." = "..roundstring(flare:getPercent()), x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        self:drawText( getText("IGUI_WorldFlares_Intensity").." = "..roundstring(flare:getIntensityPlayer(0)), x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        self:drawText( getText("IGUI_WorldFlares_Lerp").." = "..roundstring(flare:getLerpPlayer(0)), x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        self:drawText( getText("IGUI_WorldFlares_DistMod").." = "..roundstring(flare:getDistModPlayer(0)), x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        self:drawText( getText("IGUI_WorldFlares_FlareColor")..":", x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        local fcol = flare:getColorPlayer(0);
        local c = fcol:getExterior();
        local h = BUTTON_HGT;
        self:drawRect( x, y, w2, h, 1.0, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
        c = fcol:getInterior();
        self:drawRect( x+w2+UI_BORDER_SPACING, y, w2, h, 1.0, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
        y = y+h+UI_BORDER_SPACING;
        self:drawText( getText("IGUI_WorldFlares_FinalColor")..":", x, y, 1, 1, 1, a, UIFont.Small);
        y = y+yOffset;
        fcol = flare:getOutColorPlayer(0);
        c = fcol:getExterior();
        self:drawRect( x, y, w2, h, 1.0, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
        c = fcol:getInterior();
        self:drawRect( x+w2+UI_BORDER_SPACING, y, w2, h, 1.0, c:getRedFloat(), c:getGreenFloat(), c:getBlueFloat());
    end
end

function WorldFlaresDebug:update()
    ISPanel.update(self);
end

function WorldFlaresDebug:close()
    self:setVisible(false);
    self:removeFromUIManager();
    WorldFlaresDebug.instance = nil
end

function WorldFlaresDebug:new(x, y, width, height, title)
    local o = {};
    o = ISPanel:new(x, y, width, height);
    setmetatable(o, self);
    self.__index = self;
    o.variableColor={r=0.9, g=0.55, b=0.1, a=1};
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.buttonBorderColor = {r=0.7, g=0.7, b=0.7, a=0.5};
    o.zOffsetSmallFont = 25;
    o.moveWithMouse = true;
    o.panelTitle = title;
    ISDebugMenu.RegisterClass(self);
    return o;
end


