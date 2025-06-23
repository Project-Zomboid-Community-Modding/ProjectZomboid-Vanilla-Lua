require "PZAPI/ui/organisms/Window"
require "PZAPI/ui/molecules/TabPanel"
local UI = PZAPI.UI

local FishTooltip = UI.Texture{
    r=0, g=0, b=0, a=0.85,
    width = 316, height = 100,
    children = {
        text = UI.Text{
            x = 8, y = 8,
            height = 32,
            scaleX = 0.5, scaleY = 0.5,
            pivotY = 0, pivotX = 0,
            init = function(self)
                self.player = getPlayer()
                self.javaObj:setAutoWidth(300*2)
                self:setText(getText("IGUI_" .. self.parent.fish .. "_Description"))
                self.parent:setHeight(self.javaObj:getTextHeight())
            end,
            update = function(self)
                self:setText(getText("IGUI_" .. self.parent.fish .. "_Description"))
                self.parent:setHeight(self.javaObj:getTextHeight())
            end
        }
    }
}


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
    onHover = function(self, val)
        if self.player:getPerkLevel(Perks.Fishing) < 6 then
            return
        end
        if not self.player:getModData().fishing_catchedFish[self.fishType] then
            return
        end

        if val then
            local pos = self.javaObj:getLuaAbsolutePosition(8, 8)
            self.tooltip = FishTooltip{
                x = pos.x, y = pos.y
            }
            self.tooltip.fish = self.fishType
            self.tooltip:instantiate()
        else
            if self.tooltip then
                UIManager.RemoveElement(self.tooltip.javaObj)
                self.tooltip = nil
            end
        end
    end,
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

                                if self.player == nil then
                                    self.player = getPlayer()
                                end
                                local fishingLvl = self.player:getPerkLevel(Perks.Fishing)

                                if fishingLvl < 2 then
                                    self.children.textTime:setColor(0.8, 0.8, 0.8, 1)
                                    self.children.textTime:setText(getText("Sandbox_TimeOptions") .. ": " .. getText("Fluid_Unknown"))
                                elseif params.coeff > 1 then
                                    self.children.textTime:setColor(getCore():getGoodHighlitedColor():getR(), getCore():getGoodHighlitedColor():getG(), getCore():getGoodHighlitedColor():getB(), 1)
                                    self.children.textTime:setText(getText("Sandbox_TimeOptions") .. ": " .. getText("IGUI_health_Good"))
                                else
                                    self.children.textTime:setColor(1, 1, 1, 1)
                                    self.children.textTime:setText(getText("Sandbox_TimeOptions") .. ": " .. getText("Sandbox_Normal"))
                                end

                                params = Fishing.Utils.getTemperatureParams(self.player)
                                if fishingLvl < 4 then
                                    self.children.textTemperature:setColor(0.8, 0.8, 0.8, 1)
                                    self.children.textTemperature:setText(getText("IGUI_Temperature") .. ": " .. getText("Fluid_Unknown"))
                                elseif params.coeff == 1 then
                                    self.children.textTemperature:setColor(getCore():getGoodHighlitedColor():getR(), getCore():getGoodHighlitedColor():getG(), getCore():getGoodHighlitedColor():getB(), 1)
                                    self.children.textTemperature:setText(getText("IGUI_Temperature") .. ": " .. getText("IGUI_health_Good"))
                                elseif params.coeff == 0.75 then
                                    self.children.textTemperature:setColor(1, 1, 1, 1)
                                    self.children.textTemperature:setText(getText("IGUI_Temperature") .. ": " .. getText("Sandbox_Normal"))
                                elseif params.coeff == 0.5 then
                                    self.children.textTemperature:setColor(getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1)
                                    self.children.textTemperature:setText(getText("IGUI_Temperature") .. ": " .. getText("IGUI_Fishing_BadParam"))
                                else
                                    self.children.textTemperature:setColor(getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1)
                                    self.children.textTemperature:setText(getText("IGUI_Temperature") .. ": " .. getText("IGUI_Fishing_BadParam"))
                                end

                                params = Fishing.Utils.getWeatherParams()
                                if fishingLvl < 6 then
                                    self.children.textWeather:setColor(0.8, 0.8, 0.8, 1)
                                    self.children.textWeather:setText(getText("IGUI_ClimateControl_Weather") .. ": " .. getText("Fluid_Unknown"))
                                elseif params.isFog then
                                    self.children.textWeather:setColor(getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1)
                                    self.children.textWeather:setText(getText("IGUI_ClimateControl_Weather") .. ": " .. getText("IGUI_Fishing_BadParam"))
                                elseif params.isRain then
                                    self.children.textWeather:setColor(getCore():getGoodHighlitedColor():getR(), getCore():getGoodHighlitedColor():getG(), getCore():getGoodHighlitedColor():getB(), 1)
                                    self.children.textWeather:setText(getText("IGUI_ClimateControl_Weather") .. ": " .. getText("IGUI_health_Good"))
                                else
                                    self.children.textWeather:setColor(1, 1, 1, 1)
                                    self.children.textWeather:setText(getText("IGUI_ClimateControl_Weather") .. ": " .. getText("Sandbox_Normal"))
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

                                if fishingLvl < 8 then
                                    self.children.textWind:setColor(0.8, 0.8, 0.8, 1)
                                    self.children.textWind:setText(getText("IGUI_Fishing_Wind") .. ": " .. getText("Fluid_Unknown"))
                                elseif wind >= 0.5 then
                                    self.children.textWind:setColor(getCore():getBadHighlitedColor():getR(), getCore():getBadHighlitedColor():getG(), getCore():getBadHighlitedColor():getB(), 1)
                                    self.children.textWind:setText(getText("IGUI_Fishing_Wind") .. ": " .. getText("IGUI_Fishing_BadParam"))
                                else
                                    self.children.textWind:setColor(1, 1, 1, 1)
                                    self.children.textWind:setText(getText("IGUI_Fishing_Wind") .. ": " .. getText("Sandbox_Normal"))
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