local UI = PZAPI.UI

local BG_COLOR = {r = 30/255, g = 30/255, b = 30/255, a = 0.7}
local BG_SELECTED_COLOR = {r = 119/255, g = 93/255, b = 22/255, a = 0.7}
local BG_HIGHLIGHT_COLOR = {r = 60/255, g = 60/255, b = 60/255, a = 0.7}

-- logic = BuildLogic.new(player, craftBench, isoObject)
-- list = logic:getAllBuildableRecipes()
-- recipe = list:get(0):getCraftRecipe()
-- list2 = recipe:getTags()
-- list2

local CATEGORY_DATA = {
    {type = "All", tex = getTexture("media/textures/Item_FishHookBox.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            table.insert(result, el:getCraftRecipe())
        end
        return result
    end},
    {type = "Favourite", tex = getTexture("media/textures/Item_Keychain_RainbowStar.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            --table.insert(result, el:getCraftRecipe())
        end
        return result
    end},
    {type = "Animal", tex = getTexture("media/textures/Item_Head_CowFemale_Brown.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            if el:getCraftRecipe():getTags():get(0) == "animal" then
                table.insert(result, el:getCraftRecipe())
            end
        end
        return result
    end},
    {type = "Blacksmithing", tex = getTexture("media/textures/Item_Anvil_Forged.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            if el:getCraftRecipe():getTags():get(0) == "blacksmithing" then
                table.insert(result, el:getCraftRecipe())
            end
        end
        return result
    end},
    {type = "Carpentry", tex = getTexture("media/textures/Item_Plank.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            if el:getCraftRecipe():getTags():get(0) == "carpentry" then
                table.insert(result, el:getCraftRecipe())
            end
        end
        return result
    end},
    {type = "Demo", tex = getTexture("media/textures/Item_Dice.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            if el:getCraftRecipe():getTags():get(0) == "demo" then
                table.insert(result, el:getCraftRecipe())
            end
        end
        return result
    end},
    {type = "Farming", tex = getTexture("media/textures/Item_SunflowerHead.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            if el:getCraftRecipe():getTags():get(0) == "farming" then
                table.insert(result, el:getCraftRecipe())
            end
        end
        return result
    end},
    {type = "Masonry", tex = getTexture("media/textures/Item_ClayBrick_Fired.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            if el:getCraftRecipe():getTags():get(0) == "masonry" then
                table.insert(result, el:getCraftRecipe())
            end
        end
        return result
    end},
    {type = "Metalwork", tex = getTexture("media/textures/Item_Ingot_Iron.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            if el:getCraftRecipe():getTags():get(0) == "metalwork" then
                table.insert(result, el:getCraftRecipe())
            end
        end
        return result
    end},
    {type = "Outdoors", tex = getTexture("media/textures/Item_Tent1_Open.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            if el:getCraftRecipe():getTags():get(0) == "outdoors" then
                table.insert(result, el:getCraftRecipe())
            end
        end
        return result
    end},
    {type = "Pottery", tex = getTexture("media/textures/Item_ClayJar_Fired.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            if el:getCraftRecipe():getTags():get(0) == "pottery" then
                table.insert(result, el:getCraftRecipe())
            end
        end
        return result
    end},
    {type = "Stonemasonry", tex = getTexture("media/textures/Item_Boulder.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            if el:getCraftRecipe():getTags():get(0) == "stonemasonry" then
                table.insert(result, el:getCraftRecipe())
            end
        end
        return result
    end},
    {type = "Survival", tex = getTexture("media/textures/Item_FishingHook_Bone.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            if el:getCraftRecipe():getTags():get(0) == "survival" then
                table.insert(result, el:getCraftRecipe())
            end
        end
        return result
    end},
    {type = "Welding", tex = getTexture("media/textures/Item_BlowTorch.png"), filter = function(elements)
        local result = {}
        for i = 0, elements:size()-1 do
            local el = elements:get(i)
            if el:getCraftRecipe():getTags():get(0) == "welding" then
                table.insert(result, el:getCraftRecipe())
            end
        end
        return result
    end}
}

local HOVER_FUNC = function(self, val)
    if val then
        self._prevColor = {r = self.r, g = self.g, b = self.b, a = self.a}
        self:setColor(BG_HIGHLIGHT_COLOR.r, BG_HIGHLIGHT_COLOR.g, BG_HIGHLIGHT_COLOR.b, BG_HIGHLIGHT_COLOR.a)
    else
        self:setColor(self._prevColor.r, self._prevColor.g, self._prevColor.b, self._prevColor.a)
    end
end

local catButtonTemplate = UI.Texture{
    width = 48, height = 48,
    r = BG_COLOR.r, g = BG_COLOR.g, b = BG_COLOR.b, a = BG_COLOR.a,
    children = {
        icon = UI.Texture{
            width = 32, height = 32,
            x = 24, y = 24,
            a = 0.9,
            pivotX = 0.5, pivotY = 0.5,
            scaleX = 1, scaleY = 1
        }
    },
    onLeftClick = function(self)
        self.parent.currentCatIndex = self.catIndex
        self.parent:updateCatPanel()
        self.parent.parent.children.itemsPanel:updateItems()
    end,
    onHover = function(self, val)
        if val then
            self:setColor(BG_HIGHLIGHT_COLOR.r, BG_HIGHLIGHT_COLOR.g, BG_HIGHLIGHT_COLOR.b, BG_HIGHLIGHT_COLOR.a)
        else
            if self.catIndex == self.parent.currentCatIndex then
                self:setColor(BG_SELECTED_COLOR.r, BG_SELECTED_COLOR.g, BG_SELECTED_COLOR.b, BG_SELECTED_COLOR.a)
            else
                self:setColor(BG_COLOR.r, BG_COLOR.g, BG_COLOR.b, BG_COLOR.a)
            end
        end
    end
}

local itemButtonTemplate = UI.Texture{
    width = 320, height = 320,
    r = 0, g = 0, b = 0, a = 0.8,
    texture = getTexture("media/ui/icon_roundrect.png"),
    scaleX = 0.25, scaleY = 0.25,
    children = {
        icon = UI.Texture{
            width = 32, height = 32,
            x = 40*4, y = 40*4,
            a = 0.9,
            pivotX = 0.5, pivotY = 0.5,
            scaleX = 2 * 4, scaleY = 2 * 4,
            texture = getTexture("media/textures/Item_TShirt_TieDye4.png")
        }
    },
    onLeftClick = function(self)
        getCell():setDrag(ISBrushToolTileCursor:new("carpentry_01_40", "carpentry_01_40", getPlayer()), getPlayer():getPlayerNum());
    end,
    onHover = function(self, val)
        if not val and self.parent.parent.parent.tooltip.recipe == self.recipe then
            self.parent.parent.parent.tooltip:setEnabled(false)
            self.parent.parent.parent.tooltip:setVisible(false)
        end
    end,
    onMouseMove = function(self)
        if self.recipe then
            self.parent.parent.parent.tooltip:setData(self.recipe)
            self.parent.parent.parent.tooltip:setEnabled(true)
            self.parent.parent.parent.tooltip:setVisible(true)
        end
    end
}

local whiteText = UI.Text{
    r = 1, g = 1, b = 1, a = 0.8,
    scaleX = 0.5, scaleY = 0.5,
    font = UIFont.SdfBold,
    text = ""
}

local greenText = whiteText{r = 33/255, g = 143/255, b = 41/255}
local redText = whiteText{r = 144/255, g = 41/255, b = 41/255}

local tooltip = UI.Node{
    width = 632, height = 400,
    visible = false,
    enabled = false,
    children = {
        background = UI.Texture{
            anchorLeft = 0, anchorRight = 0, anchorDown = 0, anchorTop = 0,
            r = BG_COLOR.r, g = BG_COLOR.g, b = BG_COLOR.b, a = 0.95,
        },
        icon = UI.Texture{
            x = 16, y = 16,
            width = 320, height = 320,
            r = 0, g = 0, b = 0, a = 0.8,
            texture = getTexture("media/ui/icon_roundrect.png"),
            scaleX = 0.5, scaleY = 0.5,
            children = {
                img = UI.Texture{
                    x = 160, y = 160,
                    width = 63, height = 108,
                    pivotX = 0.5, pivotY = 0.5,
                    scaleX = 2, scaleY = 2,
                    texture = getTexture("carpentry_01_40"),
                }
            }
        },
        title = UI.Text{
            x = 216, y = 24,
            a = 0.9,
            pivotY = 0.5,
            scaleX = 0.6, scaleY = 0.6,
            font = UIFont.SdfBold,
            text = "Building"
        },
        description = UI.Text{
            x = 216, y = 40,
            a = 0.7,
            pivotY = 0,
            scaleX = 0.5, scaleY = 0.5,
            font = UIFont.SdfBold,
            text = "Just some cool text about, bla bla bla bla bla \nbla bla bla bla bla bla bla bla bla \nbla bla bla bla, bla bla bla bla bla bla."
        },
        required = whiteText{text = "Required:", x = 16, y = 200},
        req1 = greenText{text = "Light around", x = 16, y = 230},
        req2 = redText{text = "Fishing 0/2", x = 16, y = 260},
        req3 = greenText{text = "Carpentry 10/6", x = 16, y = 290},
        req4 = redText{text = "Crafting table", x = 16, y = 320},
        keep = whiteText{text = "Keep:", x = 216, y = 200},
        k1 = greenText{text = "Scredriver", x = 216, y = 230},
        resources = whiteText{text = "Resources:", x = 416, y = 200},
        r1 = greenText{text = "Metal bar 10/1", x = 416, y = 230},
        r2 = greenText{text = "Propane (20)", x = 416, y = 260},
        r3 = redText{text = "Fish sticks 0/20", x = 416, y = 290},
        r4 = greenText{text = "Spiffo suit 1/1", x = 416, y = 320},
    },
    setData = function(self, recipe)
        self.recipe = recipe
        self.children.title:setText(recipe:getTranslationName() or recipe:getName())
    end,
    onMouseMoveOutside = function(self, dx, dy)
        local mx = getMouseX()
        local my = getMouseY()
        self:setX(mx + 30)
        self:setY(my + 10)
    end,
    onMouseMove = function(self, dx, dy)
        local mx = getMouseX()
        local my = getMouseY()
        self:setX(mx + 30)
        self:setY(my + 10)
    end,
    init = function(self)
        local mx = getMouseX()
        local my = getMouseY()
        self:setX(mx + 30)
        self:setY(my + 10)
    end
}

UI.BuildUI = UI.Node{
    x = 100, y = 100,
    width = 464, height = 482,
    children = {
        topPanel = UI.Node{
            anchorLeft = 0, anchorRight = 0,
            height = 48,
            children = {
                titlePanel = UI.Texture{
                    height = 48,
                    r = BG_COLOR.r, g = BG_COLOR.g, b = BG_COLOR.b, a = BG_COLOR.a,
                    children = {
                        title = UI.Text{
                            x = 16, y = 24,
                            a = 0.9,
                            pivotY = 0.5,
                            scaleX = 0.75, scaleY = 0.75,
                            font = UIFont.SdfBold,
                            text = "Building"
                        },
                        searchText = UI.TextEntry{
                            enable = false,
                            visible = false,
                            x = 16, y = 24,
                            a = 0.9,
                            pivotY = 0.5,
                            scaleX = 0.75, scaleY = 0.75,
                            font = UIFont.SdfBold,
                            text = "",
                            onTextChange = function(self)
                                local itemsPanel = self.parent.parent.parent.children.itemsPanel
                                itemsPanel.itemShift = 0
                                itemsPanel:updateItems()
                                itemsPanel.children.scrollPanel:updateBar()
                            end,
                            filter = function(self, elements)
                                local stext = self:getText()
                                local result = {}
                                for i, v in ipairs(elements) do
                                    if string.find(string.lower(v:getTranslationName()), string.lower(stext)) then
                                        table.insert(result, v)
                                    end
                                end
                                return result
                            end
                        }
                    },
                    onResize = function(self)
                        self:setWidthSilent(self.parent.width - 48*2 - 4*2)
                    end
                },
                searchButton = UI.Texture{
                    anchorRight = -(48 + 4),
                    width = 48, height = 48,
                    r = BG_COLOR.r, g = BG_COLOR.g, b = BG_COLOR.b, a = BG_COLOR.a,
                    isSearch = false,
                    children = {
                        icon = UI.Texture{
                            width = 128, height = 128,
                            x = 24, y = 24,
                            a = 0.9,
                            pivotX = 0.5, pivotY = 0.5,
                            scaleX = 0.25, scaleY = 0.25,
                            texture = getTexture("media/ui/icon_search.png")
                        }
                    },
                    onHover = function(self, val)
                        if val then
                            self:setColor(BG_HIGHLIGHT_COLOR.r, BG_HIGHLIGHT_COLOR.g, BG_HIGHLIGHT_COLOR.b, BG_HIGHLIGHT_COLOR.a)
                        else
                            if self.isSearch then
                                self:setColor(BG_SELECTED_COLOR.r, BG_SELECTED_COLOR.g, BG_SELECTED_COLOR.b, BG_SELECTED_COLOR.a)
                            else
                                self:setColor(BG_COLOR.r, BG_COLOR.g, BG_COLOR.b, BG_COLOR.a)
                            end
                        end
                    end,
                    onLeftClick = function(self)
                        if self.isSearch then
                            self.isSearch = false
                            self:setColor(BG_COLOR.r, BG_COLOR.g, BG_COLOR.b, 0.9)
                            self.parent.children.titlePanel.children.title:setVisible(true)
                            self.parent.children.titlePanel.children.title:setEnabled(true)
                            self.parent.children.titlePanel.children.searchText:setVisible(false)
                            self.parent.children.titlePanel.children.searchText:setEnabled(false)
                        else
                            self.isSearch = true
                            self:setColor(BG_SELECTED_COLOR.r, BG_SELECTED_COLOR.g, BG_SELECTED_COLOR.b, BG_SELECTED_COLOR.a)
                            self.parent.children.titlePanel.children.title:setVisible(false)
                            self.parent.children.titlePanel.children.title:setEnabled(false)
                            self.parent.children.titlePanel.children.searchText:setVisible(true)
                            self.parent.children.titlePanel.children.searchText:setEnabled(true)
                            self.parent.children.titlePanel.children.searchText:setText("")
                            self.parent.children.titlePanel.children.searchText:focus()
                        end
                    end
                },
                settingsButton = UI.Texture{
                    anchorRight = 0,
                    width = 48, height = 48,
                    r = BG_COLOR.r, g = BG_COLOR.g, b = BG_COLOR.b, a = BG_COLOR.a,
                    children = {
                        icon = UI.Texture{
                            width = 128, height = 128,
                            x = 24, y = 24,
                            a = 0.9,
                            pivotX = 0.5, pivotY = 0.5,
                            scaleX = 0.25, scaleY = 0.25,
                            texture = getTexture("media/ui/icon_settings.png")
                        }
                    },
                    onHover = HOVER_FUNC
                }
            },
            onLeftDrag = function(self, data, dx, dy)
                self.parent:setX(self.parent.x + dx)
                self.parent:setY(self.parent.y + dy)
            end
        },
        catPanel = UI.Node{
            y = 48 + 4,
            height = 48,
            anchorLeft = 0, anchorRight = 0,
            currentCatIndex = 1,
            catShift = 0,
            children = {
                leftButton = UI.Texture{
                    anchorLeft = 0,
                    width = 48, height = 48,
                    r = BG_COLOR.r, g = BG_COLOR.g, b = BG_COLOR.b, a = BG_COLOR.a,
                    children = {
                        icon = UI.Texture{
                            width = 128, height = 128,
                            x = 24, y = 24,
                            a = 0.9,
                            pivotX = 0.5, pivotY = 0.5,
                            scaleX = 0.25, scaleY = 0.25,
                            angle = 180,
                            texture = getTexture("media/ui/icon_right_button.png")
                        }
                    },
                    onLeftClick = function(self)
                        if self.parent.catShift > 0 then
                            self.parent.catShift = self.parent.catShift - 1
                        end
                        self.parent:updateCatPanel()
                    end,
                    onHover = HOVER_FUNC
                },
                rightButton = UI.Texture{
                    anchorRight = 0,
                    width = 48, height = 48,
                    r = BG_COLOR.r, g = BG_COLOR.g, b = BG_COLOR.b, a = BG_COLOR.a,
                    children = {
                        icon = UI.Texture{
                            width = 128, height = 128,
                            x = 24, y = 24,
                            a = 0.9,
                            pivotX = 0.5, pivotY = 0.5,
                            scaleX = 0.25, scaleY = 0.25,
                            texture = getTexture("media/ui/icon_right_button.png")
                        }
                    },
                    onLeftClick = function(self)
                        if self.parent.catShift < #CATEGORY_DATA - 8 - 1 then
                            self.parent.catShift = self.parent.catShift + 1
                        end
                        self.parent:updateCatPanel()
                    end,
                    onHover = HOVER_FUNC
                }
            },
            updateCatPanel = function(self)
                self.parent.children.topPanel.children.titlePanel.children.title:setText(CATEGORY_DATA[self.currentCatIndex].type)

                if self.catShift == #CATEGORY_DATA - 8 - 1 then
                    self.children.rightButton:setVisible(false)
                    self.children.rightButton:setEnabled(false)
                    self.children["cat_9"]:setVisible(true)
                    self.children["cat_9"]:setEnabled(true)
                else
                    self.children.rightButton:setVisible(true)
                    self.children.rightButton:setEnabled(true)
                    self.children["cat_9"]:setVisible(false)
                    self.children["cat_9"]:setEnabled(false)
                end

                if self.catShift > 0 then
                    self.children.leftButton:setVisible(true)
                    self.children.leftButton:setEnabled(true)
                    self.children["cat_1"]:setVisible(false)
                    self.children["cat_1"]:setEnabled(false)
                else
                    self.children.leftButton:setVisible(false)
                    self.children.leftButton:setEnabled(false)
                    self.children["cat_1"]:setVisible(true)
                    self.children["cat_1"]:setEnabled(true)
                end

                for i = 1, 9 do
                    local button = self.children["cat_" .. i]
                    local catData = CATEGORY_DATA[self.catShift + i]
                    if catData == nil then
                        button.children.icon:setVisible(false)
                        button.category = nil
                    else
                        button.category = catData.type
                        button.catIndex = self.catShift + i
                        button.children.icon:setVisible(true)
                        button.children.icon:setTexture(catData.tex)
                        button.children.icon:setWidth(catData.tex:getWidth())
                        button.children.icon:setHeight(catData.tex:getHeight())
                        if self.catShift + i == self.currentCatIndex then
                            button:setColor(BG_SELECTED_COLOR.r, BG_SELECTED_COLOR.g, BG_SELECTED_COLOR.b, BG_SELECTED_COLOR.a)
                        else
                            button:setColor(BG_COLOR.r, BG_COLOR.g, BG_COLOR.b, BG_COLOR.a)
                        end
                    end
                end
            end,
            onMouseWheel = function(self, delta)
                if delta < 0 then
                    if self.currentCatIndex > 1 then
                        self.currentCatIndex = self.currentCatIndex - 1
                        if self.currentCatIndex - self.catShift - 1 <= 0 then
                            self.children.leftButton:onLeftClick()
                        end
                        self:updateCatPanel()
                    end
                else
                    if self.currentCatIndex < #CATEGORY_DATA then
                        self.currentCatIndex = self.currentCatIndex + 1
                        if self.currentCatIndex - self.catShift > 8 then
                            self.children.rightButton:onLeftClick()
                        end
                        self:updateCatPanel()
                    end
                end
                self.parent.children.itemsPanel:updateItems()
                return true
            end,
            init = function(self)
                local x = 0
                for i = 1, 9 do
                    self.children["cat_" .. i] = catButtonTemplate{
                        x = x,
                    }
                    UI._addChild(self, self.children["cat_" .. i])
                    x = x + 48 + 4
                end
                self.children["cat_9"]:setEnabled(false)
                self.children["cat_9"]:setVisible(false)
                self:updateCatPanel()
            end
        },
        itemsPanel = UI.Node{
            anchorLeft = 0, anchorRight = 0, anchorDown = 0, anchorTop = 48*2 + 4*2,
            itemShift = 0,
            children = {
                background = UI.Texture{
                    anchorLeft = 0, anchorRight = 0, anchorDown = 0, anchorTop = 0,
                    r = BG_COLOR.r, g = BG_COLOR.g, b = BG_COLOR.b, a = BG_COLOR.a,
                },
                items = UI.Node{
                    anchorLeft = 24, anchorRight = -20, anchorTop = 20, anchorDown = -20,
                    children = {},
                    init = function(self)
                        local index = 1
                        for i = 1, 4 do
                            for j = 1, 5 do
                                self.children["item_" .. index] = itemButtonTemplate{
                                    x = (j - 1) * (80+4),
                                    y = (i - 1) * (80+4)
                                }
                                UI._addChild(self, self.children["item_" .. index])
                                index = index + 1
                            end
                        end
                        self.parent:updateItems()
                    end
                },
                scrollPanel = UI.Texture{
                    width = 8,
                    anchorTop = 0, anchorDown = 0, anchorRight = 8 + 4,
                    r = BG_COLOR.r, g = BG_COLOR.g, b = BG_COLOR.b, a = BG_COLOR.a,
                    children = {
                        bar = UI.Texture{
                            anchorRight = 0, anchorLeft = 0,
                            height = 100,
                            a = 0.8
                        }
                    },
                    updateBar = function(self)
                        local shift = self.parent.itemShift / 5
                        local rows = math.floor(#self.parent.parent:getRecipes() / 5)
                        if math.fmod(#self.parent.parent:getRecipes(), 5) ~= 0 then
                            rows = rows + 1
                        end
                        rows = rows - 4

                        local h = (self.height / rows)*4
                        self.children.bar:setHeight(h)
                        self.children.bar:setY((self.height - h) * (shift/rows))
                    end,
                }
            },
            updateItems = function(self)
                local recipes = self.parent:getRecipes()
                for i = 1, 20 do
                    local item = self.children.items.children["item_" .. i]
                    local recipe = recipes[self.itemShift + i]
                    if recipe ~= nil then
                        local tex = recipe:getIconTexture()
                        local scale = 1
                        local tw = tex:getWidth()
                        local th = tex:getHeight()
                        if tw <= 32 and th <= 32 then
                            scale = 1
                        else
                            local m = math.max(tw, th)
                            scale = 32 / m
                        end
                        item.children.icon:setWidth(tw)
                        item.children.icon:setHeight(th)
                        item.children.icon:setScaleX(scale * 4 * 2)
                        item.children.icon:setScaleY(scale * 4 * 2)
                        item.children.icon:setTexture(recipe:getIconTexture())
                        item.children.icon:setVisible(true)
                    else
                        item.children.icon:setVisible(false)
                    end
                    item.recipe = recipe
                end
            end,
            onMouseWheel = function(self, delta)
                if delta < 0 then
                    if self.itemShift >= 5 then
                        self.itemShift = self.itemShift - 5
                        self:updateItems()
                        self.children.scrollPanel:updateBar()
                        self.parent.tooltip:setEnabled(false)
                        self.parent.tooltip:setVisible(false)
                    end
                else
                    if self.itemShift < #self.parent:getRecipes() - 20 then
                        self.itemShift = self.itemShift + 5
                        self:updateItems()
                        self.children.scrollPanel:updateBar()
                        self.parent.tooltip:setEnabled(false)
                        self.parent.tooltip:setVisible(false)
                    end
                end
                return true
            end,
        }
    },
    init = function(self)
        self.logic = BuildLogic.new(getPlayer(), nil, nil)
        self.recipes = self.logic:getAllBuildableRecipes()
        self.tooltip = tooltip{}
        self.tooltip:instantiate()
        self.tooltip:setAlwaysOnTop(true)
    end,
    getRecipes = function(self)
        local catData = CATEGORY_DATA[self.children.catPanel.currentCatIndex]
        local searchEl = self.children.topPanel.children.titlePanel.children.searchText
        if catData ~= self.prevCatData or (searchEl.enable and searchEl:getText() ~= self.searchtext)  then
            self.filteredRecipes = catData.filter(self.recipes)
            if self.children.topPanel.children.titlePanel.children.searchText.enable then
                self.searchtext = searchEl:getText()
                self.filteredRecipes = searchEl:filter(self.filteredRecipes)
            end
            self.prevCatData = catData
            self.children.itemsPanel.itemShift = 0
            self.children.itemsPanel.children.scrollPanel:setVisible(#self.filteredRecipes > 20)
            self.children.itemsPanel.children.scrollPanel:updateBar()
        end
        return self.filteredRecipes
    end
}

