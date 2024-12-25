--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

ISInventoryItem = {};

--[[
    Universal function to draw Inventory Icons
--]]
function ISInventoryItem.renderItemIcon(self, _item, _x, _y, _alpha, _w, _h)
    if _item and _item:getTex() then
        local tex = _item:getTex();
        if tex then
            if _item:getFluidContainer() and _item:getTextureFluidMask() then
                _alpha = 1.0;
            end
            if _item:getFluidContainer() and _item:getTextureColorMask() then
                _alpha = 1.0;
            end
            if _w and _h then
                self:drawItemIcon(_item, _x, _y, _alpha, _w, _h);
            else
                local w = tex:getWidthOrig();
                local h = tex:getHeightOrig();
                self:drawItemIcon(_item, _x, _y, _alpha, w, h);
            end
        end
    end
end

function ISInventoryItem.renderScriptItemIcon(self, _scriptItem, _x, _y, _alpha, _w, _h)
    if _scriptItem and _scriptItem:getNormalTexture() then
        local tex = _scriptItem:getNormalTexture();

		if _scriptItem:getIconsForTexture() and not _scriptItem:getIconsForTexture():isEmpty() then
			tex = _scriptItem:getIconsForTexture():get(0)
		end

        if tex then
            if _w and _h then
                self:drawScriptItemIcon(_scriptItem, _x, _y, _alpha, _w, _h);
            else
                local w = tex:getWidthOrig();
                local h = tex:getHeightOrig();
                self:drawScriptItemIcon(_scriptItem, _x, _y, _alpha, w, h);
            end
        end
    end
end

