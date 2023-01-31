--
-- Created by IntelliJ IDEA.
-- User: RJ
-- Date: 20/02/14
-- Time: 11:29
-- To change this template use File | Settings | File Templates.
--
ISSafetyUI = ISPanel:derive("ISSafetyUI");

function ISSafetyUI:initialise()
    ISPanel.initialise(self);
end

function ISSafetyUI:createChildren()
    self.radialIcon = ISRadialProgressBar:new(0, 0, self.width, self.height, nil);
    self.radialIcon:setVisible(false);
    self:addChild(self.radialIcon);
end

ISSafetyUI.initUI = function()
    if not isClient() then return end
    if getServerOptions():getBoolean("SafetySystem") then
        Events.OnKeyPressed.Add(ISSafetyUI.onKeyPressed);
    end
end

function ISSafetyUI:prerender()

    local safetyEnabled = getServerOptions():getBoolean("SafetySystem");
    local toggleTimeMax = getServerOptions():getInteger("SafetyToggleTimer");
    local cooldownTimerMax = getServerOptions():getInteger("SafetyCooldownTimer");
    local isNonPvpZone = NonPvpZone.getNonPvpZone(self.character:getX(), self.character:getY())

    self.radialIcon:setVisible(false);
    self.drawLock = false

    if safetyEnabled then

        if self.safety:getToggle() > 0 or self.safety:getCooldown() > 0 then

            local x = self:getWidth() + 12;
            local y = -3;
            self.drawLock = true

            if self.safety:getToggle() > 0 then

                self.radialIcon:setVisible(true);
                self.radialIcon:setValue(self.safety:getToggle() / toggleTimeMax);

                if self.safety:isEnabled() then
                    self.radialIcon:setTexture(self.offTexture);
                    self:drawTexture(self.onLockedTexture,0,0,1,self.backdropAlpha,self.backdropAlpha,self.backdropAlpha);
                else
                    self.radialIcon:setTexture(self.onTexture);
                    self:drawTexture(self.offLockedTexture,0,0,1,self.backdropAlpha,self.backdropAlpha,self.backdropAlpha);
                end

                self:drawText(tostring(math.ceil(self.safety:getToggle())), x, y, 1,1,1,1, UIFont.Small);

            elseif self.safety:getCooldown() > 0 then

                self.radialIcon:setVisible(true);
                self.radialIcon:setValue(1 - self.safety:getCooldown() / cooldownTimerMax);

                if self.safety:isEnabled() then
                    self.radialIcon:setTexture(self.onTexture);
                    self:drawTexture(self.onTexture,0,0,1,self.backdropAlpha,self.backdropAlpha,self.backdropAlpha);
                else
                    self.radialIcon:setTexture(self.offTexture);
                    self:drawTexture(self.offTexture,0,0,1,self.backdropAlpha,self.backdropAlpha,self.backdropAlpha);
                end

                self:drawText(tostring(math.ceil(self.safety:getCooldown())), x, y, 1,1,1,1, UIFont.Small);

            end

        elseif not isNonPvpZone then
            if self.safety:isEnabled() then
                self:drawTexture(self.onTexture,0,0,1,1,1,1);
            else
                self:drawTexture(self.offTexture,0,0,1,1,1,1);
            end
        end

    end

    if isNonPvpZone then

        self:drawTexture(self.disableTexture, 0,0,1,1,1,1);
        self.radialIcon:setVisible(false);

        if self:isMouseOver() then
            self:drawText(getText("IGUI_PvpZone_NonPvpZone"), self.width + 10, self.height/2, 1, 0, 0, 1, self.Small);
        end
    end

end

function ISSafetyUI:render()
    if self.drawLock then
        self:drawTexture(self.lockTexture, 0,0,1,1,1,1);
    end
end

ISSafetyUI.onKeyPressed = function(key)
    if key == getCore():getKey("Toggle Safety") then
        if getPlayerSafetyUI(0) then
            getPlayerSafetyUI(0):toggleSafety()
        end
    end
end

function ISSafetyUI:toggleSafety()
    if self.character:getSafety():isToggleAllowed() then
        self.character:getSafety():toggleSafety();
        ISLogSystem.logAction(self);
    end
end

function ISSafetyUI:onMouseUp(x, y)
    self:toggleSafety()
end

function ISSafetyUI:getExtraLogData()
    return {
        (self.character:getSafety():isCurrent() and "Safety On") or "Safety Off",
    };
end

function ISSafetyUI:new(x, y, playerNum)
    local onTexture = getTexture("media/ui/pvpicon_off.png"); --getTexture("media/ui/SafetyON.png");
    local o = ISPanel:new(x, y, onTexture:getWidth(), onTexture:getHeight());
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    o.y = y;
    o.borderColor = {r=0, g=0, b=0, a=0};
    o.backgroundColor = {r=0, g=0, b=0, a=0};
    o.width = onTexture:getWidth();
    o.height = onTexture:getHeight();
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    --    o.pvpText = "Disabled";
    o.offTexture = getTexture("media/ui/pvpicon_on.png"); --getTexture("media/ui/SafetyOFF.png");
    o.pendingTexture = getTexture("media/ui/SafetyPEND.png"); --getTexture("media/ui/SafetyPEND.png");
    o.disableTexture = getTexture("media/ui/pvpicon_off.png"); --getTexture("media/ui/SafetyDISABLE.png");
    o.onTexture = onTexture;
    o.offLockedTexture = getTexture("media/ui/pvpicon_on.png"); --getTexture("media/ui/safetyOffLocked.png");
    o.onLockedTexture = getTexture("media/ui/pvpicon_off.png"); --getTexture("media/ui/safetyOnLocked.png");
    o.lockTexture = getTexture("media/ui/pvpicon_clock.png");
    o.noBackground = true;
    o.playerNum = playerNum;
    o.character = getSpecificPlayer(playerNum);
    o.safety = o.character:getSafety()

    o.backdropAlpha = 0.5; -- alpha of the backdrop transition too state
    o.toggleTimer = 0;
    o.cooldownTimer = 0;

    return o
end

Events.OnGameStart.Add(ISSafetyUI.initUI);

if not isClient() then
    Events.OnKeyPressed.Add(
        function(key)
            if key == getCore():getKey("Toggle Safety") then
                IsoPlayer.setCoopPVP(not IsoPlayer.getCoopPVP())
            end
        end
    )
end
