local UI = PZAPI.UI

local gridItem = UI.Texture{
    width = 64*4, height = 64*4,
    scaleX = 0.25, scaleY = 0.25,
    r = 0, g = 0, b = 0, a = 0.56,
    texture = getTexture("media/ui/icon_square_ui.png")
}

UI.playerInventory = UI.Node{
    children = {
        titlePanel = UI.Texture{
            x = 38, y = 39,
            width = 565, height = 42,
            r = 38/255, g = 38/255, b = 38/255, a = 0.9,
            children = {
                title = UI.Text{
                    x = 16, y = 21,
                    a = 0.9,
                    pivotY = 0.5,
                    scaleX = 0.65, scaleY = 0.65,
                    font = UIFont.SdfBold,
                    text = "Backpack"
                }
            }
        },
        searchPanel = UI.Texture{
            x = 38, y = 86,
            width = 471, height = 42,
            r = 38/255, g = 38/255, b = 38/255, a = 0.9,
            children = {
                textEntry = UI.TextEntry{
                    x = 16, y = 21,
                    a = 0.9,
                    pivotY = 0.5,
                    scaleX = 0.65, scaleY = 0.65,
                    font = UIFont.SdfBold,
                    text = ""
                }
            }
        },
        filterButton = UI.Texture{
            x = 514, y = 86,
            width = 42, height = 42,
            r = 38/255, g = 38/255, b = 38/255, a = 0.9,
            children = {
                icon = UI.Texture{
                    width = 109, height = 99,
                    x = 21, y = 21,
                    a = 0.9,
                    pivotX = 0.5, pivotY = 0.5,
                    scaleX = 0.25, scaleY = 0.25,
                    texture = getTexture("media/ui/icon_filter_ui.png")
                }
            }
        },
        settingsButton = UI.Texture{
            x = 561, y = 86,
            width = 42, height = 42,
            r = 38/255, g = 38/255, b = 38/255, a = 0.9,
            children = {
                icon = UI.Texture{
                    width = 102, height = 108,
                    x = 21, y = 21,
                    a = 0.9,
                    pivotX = 0.5, pivotY = 0.5,
                    scaleX = 0.25, scaleY = 0.25,
                    texture = getTexture("media/ui/icon_settings_ui.png")
                }
            }
        },
        containterGroup = UI.Node{

        },
        gridPanel = UI.Node{
            x = 38, y = 133,
            children = {
                background = UI.Texture{
                    width = 518, height = 578,
                    r = 38/255, g = 38/255, b = 38/255, a = 0.9
                },
                cellContainer = UI.Node{
                    x = 15, y = 15,
                    width = 488, height = 548,
                    isStencil = true,
                    children = {
                        cellBody = UI.Node{
                            onScroll = function(self, delta)
                                self.parent.parent.children.scrollBar:setScroll(delta)
                            end,
                            height = 1000, width = 488,
                            children = {}
                        }
                    }
                },
                scrollBar = UI.Node{
                    width = 488, height = 578,
                    x = 508,
                    children = {
                        back = UI.Texture{
                            width = 10, height = 578,
                            r = 0, g = 0, b = 0, a = 0.7
                        },
                        bar = UI.Texture{
                            width = 10, height = 60,
                            r = 200 / 255, g = 200 / 255, b = 200 / 255, a = 0.8,
                            init = function(self)
                                local cHeight = self.parent.parent.children.cellContainer.height
                                local bHeight = self.parent.parent.children.cellContainer.children.cellBody.height
                                if bHeight <= cHeight then
                                    self:setHeight(self.parent.height)
                                else
                                    self:setHeight(self.parent.height * (cHeight / bHeight))
                                end
                            end,
                            onLeftDrag = function(self, data, dx, dy)
                                self:setY(self.y + dy)

                            end
                        }
                    },
                    setScroll = function(self, delta)
                        self.children.bar:setY(delta * (self.height - self.children.bar.height))
                    end
                }
            },
            updateItems = function(self)
                local body = self.children.cellContainer.children.cellBody
                for k, v in pairs(body.children) do
                    body.javaObj:removeNode(v.javaObj)
                end

                local counter = 0
                local x = 0
                local y = 0
                for i = 1, 100 do
                    if math.fmod(counter, 7) == 0 and counter ~= 0 then
                        x = 0
                        y = y + 64 + 5
                    end
                    body.children["item_" .. i] = gridItem{
                        x = x, y = y
                    }
                    UI._addChild(body, body.children["item_" .. i])
                    x = x + 64 + 5
                    counter = counter + 1
                end
                body:setHeight(y + 64 + 5)
            end,
            init = function(self)
                self:updateItems()
            end
        },
        listPanel = UI.Node{

        },
        infoPanel = UI.Node{

        }
    }
}


UI.Inventory = UI.Node{
    children = {
        playerInventory = UI.playerInventory{},
        --outsideInventory = UI.outsideInventory{}
    }
}