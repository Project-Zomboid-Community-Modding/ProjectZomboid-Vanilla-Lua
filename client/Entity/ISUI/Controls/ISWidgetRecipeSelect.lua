--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

-- TODO DEPRECATED
require "ISUI/ISPanel"

local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small);

ISWidgetRecipeSelect = ISPanel:derive("ISWidgetRecipeSelect");

function ISWidgetRecipeSelect:initialise()
	ISPanel.initialise(self);
end

function ISWidgetRecipeSelect:createChildren()
    ISPanel.createChildren(self);

    local list = ArrayList.new();

    if self.craftProcessor then
        self.craftProcessor:getRecipes(list);
    end

    local style = self.styleComboBox or "S_ComboBox_RecipeSelect";
    self.comboBox = ISXuiSkin.build(self.xuiSkin, style, ISComboBox, 0, 0, 150, FONT_HGT_SMALL + 2 * 2, self, ISWidgetRecipeSelect.comboChange)
    self.comboBox:initialise();
    self.comboBox:instantiate();
    self:addChild(self.comboBox);

    for i=0,list:size()-1 do
        local title = list:get(i):getTranslationName();
        self.comboBox:addOptionWithData(title, list:get(i));
    end

    self.comboBox:setWidthToOptions(self.comboBox.width);

    self.originalComboBoxWidth = self.comboBox:getWidth();
    self.originalComboBoxHeight = self.comboBox:getHeight();
end

function ISWidgetRecipeSelect:calculateLayout(_preferredWidth, _preferredHeight)
    local width = math.max(self.minimumWidth, _preferredWidth or 0);
    local height = math.max(self.minimumHeight, _preferredHeight or 0);

    local margin2x = self.margin*2;

    if self.autoFillContents or self.comboBox.isAutoFill or self.comboBox.isAutoFillX then
        self.comboBox:setWidthToOptions(math.max(self.originalComboBoxWidth, width - margin2x));
    else
        self.comboBox:setWidthToOptions(self.originalComboBoxWidth);
    end

    width = math.max(width, self.comboBox:getWidth() + margin2x);
    height = math.max(height, self.comboBox:getHeight() + margin2x);

    local x = (width/2) - (self.comboBox:getWidth()/2);
    local y = (height/2) - (self.comboBox:getHeight()/2);

    self.comboBox:setX(x);
    self.comboBox:setY(y);

    self:setWidth(width);
    self:setHeight(height);
end

function ISWidgetRecipeSelect:onResize()
    --ISUIElement.onResize(self)
    ISUIElement.onResize(self)
end

function ISWidgetRecipeSelect:prerender()
    ISPanel.prerender(self);

end

function ISWidgetRecipeSelect:render()
    ISPanel.render(self);

    if ISEntityUI.drawDebugLines or self.drawDebugLines then
        self:drawRectBorderStatic(0, 0, self.width, self.height, 1.0, 0.25, 1.0, 0.75);
    end
end

function ISWidgetRecipeSelect:update()
    ISPanel.update(self);

    if self.comboBox and self.craftProcessor then

        if self.craftProcessor:isRunning() then
            if self.comboBox.expanded then
                self.comboBox.expanded = false;
                self.comboBox:hidePopup();
            end
            self.comboBox.disabled = true;
        else
            self.comboBox.disabled = false;
			local list = ArrayList.new();

			if self.craftProcessor then
				self.craftProcessor:getRecipes(list);
			end
			self.comboBox:clear();
			for i=0,list:size()-1 do
				if self.craftProcessor and self.craftProcessor:canConsumeRecipeInputs(list:get(i)) then
					local title = list:get(i):getTranslationName();
					self.comboBox:addOptionWithData(title, list:get(i));
				end
			end
        end

        if not self.comboBox.expanded then
            local recipe = self.craftProcessor:getManualSelectedRecipe();

            if recipe then
                self.comboBox:selectData(recipe);
            end
        end

    end
end

function ISWidgetRecipeSelect:comboChange(_combo, _arg1, _arg2)
    if self.comboBox and _combo==self.comboBox then
        local recipe = self.comboBox:getOptionData(self.comboBox.selected);
        if self.craftProcessor then
            self.craftProcessor:setManualSelectedRecipe(recipe);
        end
    end
end

--************************************************************************--
--** ISWidgetRecipeSelect:new
--**
--************************************************************************--
function ISWidgetRecipeSelect:new (x, y, width, height, player, entity, component, craftProcessor, _styleComboBox)
	local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.player = player;
    o.entity = entity;
    o.component = component;
    o.craftProcessor = craftProcessor;

    o.background = false;

    o.styleComboBox = _styleComboBox;

    o.margin = 5;
    o.minimumWidth = 0;
    o.minimumHeight = 0;

    o.autoFillContents = false;

    -- these may or may not be used by a parent control while calculating layout:
    o.isAutoFill = false;
    o.isAutoFillX = false;
    o.isAutoFillY = false;

    return o
end