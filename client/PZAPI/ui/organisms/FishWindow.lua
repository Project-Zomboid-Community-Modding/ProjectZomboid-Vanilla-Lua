require "PZAPI/ui/organisms/Window"
require "PZAPI/ui/molecules/TabPanel"
local UI = PZAPI.UI

local fishItemUI = UI.Node{
    children = {
        icon = UI.Texture{
            width = 16, height = 16
        },
        text = UI.Text{
            x = 30,
            scaleX = 0.4, scaleY = 0.4,
            text = ""
        }
    },
    update = function(self)
        if self.player:getModData().fishing_catchedFish[self.fishType] then
            self.children.text:setText(self.children.text.fishText)
            local scriptItem = getScriptManager():FindItem(self.fishType)
            if scriptItem ~= nil then
                local icon = scriptItem:getIcon()
                if scriptItem:getIconsForTexture() and not scriptItem:getIconsForTexture():isEmpty() then
                    icon = scriptItem:getIconsForTexture():get(0)
                end
                if icon then
                    self.children.icon:setTexture(getTexture("media/textures/Item_" .. icon .. ".png"))
                end
            end
        end
    end,
    init = function(self)
        self.children.text.fishText = getItemNameFromFullType(self.fishType)
        self.children.text:setText("---")
        self.children.icon:setTexture(getTexture("media/inventory/Question_On.png"))

        self.player = getPlayer()
        if self.player:getModData().fishing_catchedFish == nil then
            self.player:getModData().fishing_catchedFish = {}
        end
        if self.player:getModData().fishing_catchedFish[self.fishType] then
            self.children.text:setText(self.children.text.fishText)
            local scriptItem = getScriptManager():FindItem(self.fishType)
            if scriptItem ~= nil then
                local icon = scriptItem:getIcon()
                if scriptItem:getIconsForTexture() and not scriptItem:getIconsForTexture():isEmpty() then
                    icon = scriptItem:getIconsForTexture():get(0)
                end
                if icon then
                    self.children.icon:setTexture(getTexture("media/textures/Item_" .. icon .. ".png"))
                end
            end
        end
    end
}

UI.FishWindow = UI.Window{
    width = 400, height = 400,
    isPin = false,
    children = {
        bar = UI.Window.children.bar{
            children = {
                name = UI.Text{
                    text = "Fishing Panel",
                    pivotX = 0.5, pivotY = 0.5,
                    scaleX = 0.36, scaleY = 0.36,
                    anchorLeft = 0, anchorRight = 0, anchorTop = 0, anchorDown = 0
                }
            }
        },
        body = UI.Window.children.body{
            children = {
                tabPanel = UI.TabPanel{
                    tabs = {"info", "guide"},
                    children = {
                        info = UI.Texture{
                            name = "Info",
                            r=0, g=0, b=0, a=0.7,
                            children = {
                                line = UI.Texture{
                                    y = 52,
                                    width = 400, height = 1,
                                    r=0.4, g=0.4, b=0.4, a=1
                                },
                                textTime = UI.Text{
                                    x = 30, y = 17,
                                    scaleX = 0.4, scaleY = 0.4,
                                    pivotY = 0.5,
                                    text = ""
                                },
                                textTemperature = UI.Text{
                                    x = 30, y = 34,
                                    scaleX = 0.4, scaleY = 0.4,
                                    pivotY = 0.5,
                                    text = ""
                                },
                                textWeather = UI.Text{
                                    x = 240, y = 17,
                                    scaleX = 0.4, scaleY = 0.4,
                                    pivotY = 0.5,
                                    text = ""
                                },
                                textWind = UI.Text{
                                    x = 240, y = 34,
                                    scaleX = 0.4, scaleY = 0.4,
                                    pivotY = 0.5,
                                    text = ""
                                }
                            },
                            update = function(self)
                                local params = Fishing.Utils.getTimeParams()

                                if params.coeff > 1 then
                                    self.children.textTime:setText("Time: " .. "Good")
                                else
                                    self.children.textTime:setText("Time: " .. "Normal")
                                end

                                if self.player == nil then
                                    self.player = getPlayer()
                                end
                                params = Fishing.Utils.getTemperatureParams(self.player)
                                if params.coeff == 1 then
                                    self.children.textTemperature:setText("Temperature: " .. "Good")
                                elseif params.coeff == 0.75 then
                                    self.children.textTemperature:setText("Temperature: " .. "Normal")
                                elseif params.coeff == 0.5 then
                                    self.children.textTemperature:setText("Temperature: " .. "Bad")
                                else
                                    self.children.textTemperature:setText("Temperature: " .. "Bad")
                                end

                                params = Fishing.Utils.getWeatherParams()
                                if params.isFog then
                                    self.children.textWeather:setText("Weather: Bad")
                                elseif params.isRain then
                                    self.children.textWeather:setText("Weather: Good")
                                else
                                    self.children.textWeather:setText("Weather: Normal")
                                end

                                local wind = getClimateManager():getWindPower()
                                local windStr = "";
                                if wind>0.65 then
                                    windStr = "Extremely windy, ";
                                elseif wind>0.45 then
                                    windStr = "Very strong wind, ";
                                elseif wind>0.3 then
                                    windStr = "Very windy, ";
                                elseif wind>0.2 then
                                    windStr = "Windy, ";
                                elseif wind>0.1 then
                                    windStr = "Slightly windy, ";
                                else
                                    windStr = "Minor breezes, ";
                                end

                                if wind >= 0.5 then
                                    --self.textWind:setColor(1, 0.5, 0, 1)
                                    --self.textWind:setText("Wind: " .. "Bad, ".. windStr .. ClimateManager.getWindAngleString(getClimateManager():getWindAngleIntensity()))
                                    self.children.textWind:setText("Wind: " .. "Bad")
                                else
                                    --self.textWind:setColor(1, 1, 1, 1)
                                    self.children.textWind:setText("Wind: " .. "Normal")
                                end
                            end,
                            init = function(self)
                                local yy = 60
                                local xx = 30

                                local fishNum = #Fishing.fishes
                                local hFishNum = math.floor(fishNum / 2)
                                local winHeight = self.parent.parent.height
                                local freeHeight = winHeight - 60 - 50
                                local fishHeight = (hFishNum + 1) * 25
                                if fishHeight > freeHeight then
                                    winHeight = winHeight + (fishHeight - freeHeight) + 25
                                    self.parent.parent.parent:setHeight(winHeight)
                                end

                                local counter = 0
                                for _, fishConfig in ipairs(Fishing.fishes) do
                                    counter = counter + 1
                                    self.children[fishConfig.itemType] = fishItemUI{
                                        x = xx, y = yy,
                                        fishType = fishConfig.itemType
                                    }
                                    UI._addChild(self, self.children[fishConfig.itemType])
                                    yy = yy + 25
                                    if counter == hFishNum + 1 then
                                        xx = 220
                                        yy = 60
                                    end
                                end
                            end
                        },
                        guide = UI.Texture{
                            name = "Guide",
                            r=0, g=0, b=0, a=0.7,
                            children = {
                                text = UI.Text{
                                    x = 10, y = 10,
                                    scaleX = 0.5, scaleY = 0.5,
                                    text = getText("Tooltip_FishingTip")
                                },
                                image = UI.Texture{
                                    texture = getTexture("media/ui/ScaleTensionN.png"),
                                    width = 120, height = 120,
                                    x = 10, y = 210
                                },
                                image2 = UI.Texture{
                                    texture = getTexture("media/ui/PointTensionN.png"),
                                    width = 120, height = 120,
                                    x = 10, y = 210
                                },
                            }
                        }
                    }
                }
            }
        }
    },
    init = function(self)
        local orig = 1080
        local current = getCore():getScreenHeight()
        local scale = current / orig
        self:setScaleX(scale)
        self:setScaleY(scale)
        self:setX(getCore():getScreenWidth() - 20 - 400 * self.scaleX)
        self:setY(getCore():getScreenHeight()/2)
    end
}

UI.FishWindow.children.bar.children.settingsButton.x = 25
UI.FishWindow.children.bar.children.infoButton = nil
UI.FishWindow.children.bottomBar.children.resizeButton = nil
UI.FishWindow.children.bar.children.closeButton.onLeftClick = function(self)
    getSoundManager():playUISound(self.sounds.activate)
    self.parent.parent:setVisible(false)
end