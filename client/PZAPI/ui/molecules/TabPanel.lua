-- local t1 = getTexture("media/ui/XpSystemUI/tab_selected.png") 43 19
-- local t2 = getTexture("media/ui/XpSystemUI/tab_unselected.png") 43 19

require "PZAPI/ui/atoms/Node"
require "PZAPI/ui/atoms/Texture"
require "PZAPI/ui/molecules/Panel"
local UI = PZAPI.UI

local tabButton = UI.Texture{
    height = 19, width = 43,
    anchorTop = 0,
    name = "",
    a = 0.6,
    texture = getTexture("media/ui/XpSystemUI/tab_unselected.png"),
    textureUnselected = getTexture("media/ui/XpSystemUI/tab_unselected.png"),
    textureSelected = getTexture("media/ui/XpSystemUI/tab_selected.png"),

    children = {
        label = UI.Text{
            anchorLeft = 0, anchorRight = 0, anchorTop = 0, anchorDown = 0,
            pivotX = 0.5, pivotY = 0.5,
            scaleX = 0.35, scaleY = 0.35,
            text = ""
        }
    },
    init = function(self)
        self.children.label:setText(self.name)
        self:setWidth(math.floor(self.children.label.javaObj:getTextWidth() * self.children.label.scaleX + 16))
    end,
    onHover = function(self, state)
        if self.selected then return end
        if state then
            self:setColor(1, 1, 1, 0.9)
        else
            self:setColor(1, 1, 1, 0.6)
        end
    end,
    onLeftClick = function(self)
        getSoundManager():playUISound("UIActivateTab")
        self.parent:select(self.id)
    end,
    setSelected = function(self, value)
        if value then
            self:setTexture(self.textureSelected)
            self:setColor(1, 1, 1, 0.9)
        else
            self:setTexture(self.textureUnselected)
            self:setColor(1, 1, 1, 0.6)
        end
        self.selected = value
    end
}

UI.TabPanel = UI.Node{
    anchorLeft = 1, anchorRight = -1, anchorTop = 1, anchorDown = -1,
    selected = nil,
    -- tabs = {},
    children = {
        panel = UI.Panel{
            height = 21,
            anchorTop = -1, anchorLeft = -1, anchorRight = 1,
            a = 0,
        }
    },
    init = function(self)
        if self.tabs == nil then return end
        local x = 1
        for _, key in ipairs(self.tabs) do
            local element = self.children[key]
            self.children["button_" .. key] = tabButton{
                x = x,
                name = element.name,
                id = key
            }
            UI._addChild(self, self.children["button_" .. key])
            x = x + self.children["button_" .. key].width + 1
        end
        for _, key in ipairs(self.tabs) do
            self.children[key]:setVisible(false)
            self.children[key]:setEnabled(false)
        end
        self.children[self.tabs[1]]:setVisible(true)
        self.children[self.tabs[1]]:setEnabled(true)
        self.children["button_" .. self.tabs[1]]:setSelected(true)
    end,
    onResize = function(self)
        for _, key in ipairs(self.tabs) do
            local element = self.children[key]
            element:setWidth(self.width)
            element:setHeight(self.height - 20)
            element:setY(20)
        end
    end,
    select = function(self, id)
        for _, key in ipairs(self.tabs) do
            self.children[key]:setVisible(false)
            self.children[key]:setEnabled(false)
            self.children["button_" .. key]:setSelected(false)
        end
        self.children[id]:setVisible(true)
        self.children[id]:setEnabled(true)
        self.children["button_" .. id]:setSelected(true)
    end
}