--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

require "Map/CGlobalObjectSystem"

CFeedingTroughSystem = CGlobalObjectSystem:derive("CFeedingTroughSystem")

function CFeedingTroughSystem:new()
	local o = CGlobalObjectSystem.new(self, "feedingTrough")
	return o
end

function CFeedingTroughSystem:isValidIsoObject(isoObject)
	return instanceof(isoObject, "IsoFeedingTrough")
end

function CFeedingTroughSystem:newLuaObject(globalObject)
--	print("new lua object C")
	return CFeedingTroughGlobalObject:new(self, globalObject)
end

function CFeedingTroughSystem:OnLuaObjectUpdated(luaObject)
	-- feedAmount was changed
	luaObject:OnLuaObjectUpdated()
end

local function DoSpecialTooltip1(tooltip, square)
	local luaObject = CFeedingTroughSystem.instance:getLuaObjectOnSquare(square)
	if not luaObject then return; end

	if luaObject.linkedX and luaObject.linkedY and luaObject.linkedX > 0 and luaObject.linkedY > 0 then
		local square2 = getSquare(luaObject.linkedX, luaObject.linkedY, square:getZ());
		if square2 then
			luaObject = CFeedingTroughSystem.instance:getLuaObjectOnSquare(square2)
		end
	end

	local trough = luaObject:getIsoObject();
	if not trough then return; end

	if getPlayer() and getPlayer():DistToProper(trough) > 13 then return; end

	tooltip:DrawTextureScaled(tooltip:getTexture(), 0, 0, tooltip:getWidth(), tooltip:getHeight(), 0.75)
	tooltip:DrawTextCentre(tooltip:getFont(), getText("ContextMenu_FeedingTrough"), tooltip:getWidth() / 2, 5, 1, 1, 1, 1)
	tooltip:adjustWidth(15, getText("ContextMenu_FeedingTrough"))
	local feedAmount = trough:getCurrentFeedAmount();
	local waterAmount = trough:getWater();

	local layout = tooltip:beginLayout()
	local text = getText("Fluid_Empty");
	if waterAmount > 0 then
		text = round(trough:getWater(), 2) * 1000 .. " / " .. trough:getMaxWater() * 1000 .. " mL";
	end
	-- only display water if there's no food
	if feedAmount <= 0 then
		local layoutItem = layout:addItem()
		layoutItem:setLabel(getText("IGUI_FeedingTroughUI_Water") .. ": " .. text, 1, 1, 1, 1)
	end
	text = getText("Fluid_Empty");
	if feedAmount > 0 then
		text = round(feedAmount, 2);
	end
	-- only display food if there's no water
	if waterAmount <= 0 then
		local layoutItem = layout:addItem()
		layoutItem:setLabel(getText("IGUI_FeedingTroughUI_Feeding") .. ": " .. text, 1, 1, 1, 1)
	end

	local layoutItem = layout:addItem()
	local layoutItem = layout:addItem()
	layoutItem:setLabel(getText("Tooltip_trough_info1"), 1, 1, 1, 1);
	local layoutItem = layout:addItem()
	layoutItem:setLabel(getText("Tooltip_trough_info2"), 1, 1, 1, 1);
	local layoutItem = layout:addItem()
	layoutItem:setLabel(getText("Tooltip_trough_info3"), 1, 1, 1, 1);

	local y = layout:render(5, 5 + getTextManager():getFontHeight(tooltip:getFont()), tooltip)
	tooltip:setHeight(y + 5)
	tooltip:endLayout(layout)
end

CGlobalObjectSystem.RegisterSystemClass(CFeedingTroughSystem)

local function DoSpecialTooltip(tooltip, square)
	tooltip:setWidth(100)
	tooltip:setMeasureOnly(true)
	DoSpecialTooltip1(tooltip, square)
	tooltip:setMeasureOnly(false)
	DoSpecialTooltip1(tooltip, square)
end

Events.DoSpecialTooltip.Add(DoSpecialTooltip)