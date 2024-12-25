require "ISUI/ISCollapsableWindow"

ISVehicleAnimalUI = ISCollapsableWindow:derive("ISVehicleAnimalUI")
ISVehicleAnimalUI.ui = nil;

function ISVehicleAnimalUI:initialise()
    ISCollapsableWindow.initialise(self);
end

function ISVehicleAnimalUI:createChildren()
    ISCollapsableWindow.createChildren(self)

    self.progressBar = ISProgressBar:new (17, 40, 166, self.btnHeight, "", UIFont.NewSmall);
    self.progressBar:setVisible(true);
    self:addChild(self.progressBar);

    self.addBtn = ISButton:new(self.progressBar.x + self.progressBar:getWidth() + 10,40, self.btnWidth,self.btnHeight, getText("ContextMenu_AddAnimal"), self, ISVehicleAnimalUI.onAddAnimal);
    self.addBtn:initialise();
    self.addBtn:instantiate();
    self.addBtn.borderColor = {r=1, g=1, b=1, a=0.8};
    self:addChild(self.addBtn);

	local titleBarHeight = self:titleBarHeight()

    self.scrollPanel = ISPanelJoypad:new(10, titleBarHeight + 45, self:getWidth() - 10, self:getHeight() - 60 - titleBarHeight)
    self.scrollPanel:initialise()
    self.scrollPanel:instantiate()
    self.scrollPanel:setAnchorLeft(false);
    self.scrollPanel:setAnchorRight(true);
    self.scrollPanel:setAnchorTop(true);
    self.scrollPanel:setAnchorBottom(true);
    self.scrollPanel:setScrollChildren(true)
    self.scrollPanel:noBackground()
    self.scrollPanel:addScrollBars()
    self.scrollPanel.vscroll.doRepaintStencil = true
    self.scrollPanel.vehicle = self.vehicle;
    self.scrollPanel.animals = {};
    self:addChild(self.scrollPanel);

    for i=0, self.vehicle:getAnimals():size()-1 do
        table.insert(self.scrollPanel.animals, self.vehicle:getAnimals():get(i));
    end

    self.scrollPanel.reset = ISVehicleAnimalUI.reset;
    self.scrollPanel.prerender = ISVehicleAnimalUI.prerenderScrollPanel;
    self.scrollPanel.onRightMouseUp = ISVehicleAnimalUI.onRightMouseUpScrollPanel;

    self.scrollPanel.render = function(self)
        self:setStencilRect(0, 10, self:getWidth(), self:getHeight() - 20)
        ISPanelJoypad.render(self)
        self:clearStencilRect()
    end
    self.scrollPanel.onMouseWheel = function(self, del)
        if self:getScrollHeight() > 0 then
            self:setYScroll(self:getYScroll() - (del * 40))
            return true
        end
        return false
    end

    self:create();
end

function ISVehicleAnimalUI:checkCanAddAnimal()
    self.addBtn.enable = false;

    local doorOpen = true;
    local trunkDoor = self.vehicle:getPartById("TrunkDoor") or self.vehicle:getPartById("DoorRear") or self.vehicle:getPartById("TrunkDoorOpened")
    if trunkDoor and trunkDoor:getDoor() then
        if not trunkDoor:getDoor():isOpen() then doorOpen = false end
    end

    local haveAnimals = false;

    if instanceof(self.character:getPrimaryHandItem(), "AnimalInventoryItem") then
        haveAnimals = true;
    end
    if self.character:getPrimaryHandItem() and self.character:getPrimaryHandItem():getType() == "CorpseAnimal" and not self.character:getPrimaryHandItem():getDeadBodyObject():isAnimalSkeleton() then
        haveAnimals = true;
    end
    for x=self.vehicle:getSquare():getX() - 6, self.vehicle:getSquare():getX()+5 do
        for y=self.vehicle:getSquare():getY() - 6, self.vehicle:getSquare():getY()+5 do
            local sq = getSquare(x, y, self.vehicle:getSquare():getZ());
            if sq then
                local animals = sq:getAnimals();
                if not animals:isEmpty() then
                    haveAnimals = true;
                    break;
                end
                local deadbodies = sq:getDeadBodys();
                for i=0, deadbodies:size()-1 do
                    local body = deadbodies:get(i);
                    if body:isAnimal() and not body:isAnimalSkeleton() and body:getSquare() then
                        haveAnimals = true;
                        break;
                    end
                end
            end
        end
        if haveAnimals then
            break;
        end
    end

    if haveAnimals and doorOpen then
        self.addBtn.enable = true;
    end
end

function ISVehicleAnimalUI:onAddAnimal()
    local context = ISContextMenu.get(0, self.addBtn:getAbsoluteX() + 10, self.addBtn:getAbsoluteY() + 10)

    ISVehicleMenu.doAnimalSubMenu(context, self.character, self.vehicle);
end

function ISVehicleAnimalUI:onRightMouseUpScrollPanel(x, y)
    local clickedAnimal;
    for i, avatar in ipairs(self.avatars) do
        if avatar.animal and x > avatar.x and x < avatar.x + avatar.width and y > avatar.y and y < avatar.y + avatar.height then
            clickedAnimal = avatar.animal;
        end
    end
    if clickedAnimal then
        local context = ISContextMenu.get(self.parent.playerNum, x + self:getAbsoluteX(), y + self:getAbsoluteY())
        context:addOption(getText("ContextMenu_AnimalInfo"), clickedAnimal, AnimalContextMenu.onAnimalInfo, self.parent.character);

        if not clickedAnimal:isDead() and clickedAnimal:getStats():getThirst() >= 0.1 then
            AnimalContextMenu.doWaterAnimalMenu(context, clickedAnimal, self.parent.character);
        end
        if not clickedAnimal:isDead() and  clickedAnimal:getStats():getHunger() >= 0.1 then
            AnimalContextMenu.doFeedFromHandMenu(self.parent.character, clickedAnimal, context);
        end
        if AnimalContextMenu.cheat and not clickedAnimal:isDead() then
            context:addDebugOption("Kill", clickedAnimal, ISVehicleAnimalUI.onKillAnimalDebug, self.parent.character);
        end
    end
    return false
end

function ISVehicleAnimalUI.onKillAnimalDebug(animal, player)
    animal:setHealth(0)
end

function ISVehicleAnimalUI:prerenderScrollPanel()
    ISPanelJoypad.prerender(self)

    local xoffset = 10;
    local yoffset = 40;
    local index = 0;
    --self:drawText(getText("IGUI_Animal_TrailerAvailability") .. round(self.vehicle:getCurrentTotalAnimalSize(), 1) .. "/" .. self.vehicle:getAnimalTrailerSize(), 20, 12, 1,1,1,1, UIFont.NewSmall);
    for i, avatar in ipairs(self.avatars) do
        avatar:setX(xoffset);
        avatar:setY(yoffset + self:getYScroll());

--        self.removeBtns[i]:setX((avatar.width / 2) - (self.parent.btnWidth / 2) + xoffset);
        self.removeBtns[i]:setX(avatar:getX());
        self.removeBtns[i]:setY(avatar.y + avatar.height + 5);

--        self.grabBtns[i]:setX((avatar.width / 2) - (self.parent.btnWidth / 2) + xoffset);
        self.grabBtns[i]:setX(avatar:getX() + avatar:getWidth() - self.parent.btnWidth - 2);
        self.grabBtns[i]:setY(avatar.y + avatar.height + 5);

        self.infoBtns[i]:setX(avatar:getX() + avatar:getWidth() - self.parent.btnWidth - 2);
        self.infoBtns[i]:setY(avatar.y + avatar.height - self.parent.btnHeight - 2);

        xoffset = xoffset + avatar.width + 10;

        if avatar.animal then
            --            self:drawRectBorder(avatar.x, avatar.y, avatar.width, avatar.height, 1, 0.3, 0.3, 0.3);
            local x,y,w,h = avatar.x, avatar.y, avatar.width, avatar.height
            self:drawRectBorder(x - 2, y - 2, w + 4, h + 4, 1, 0.3, 0.3, 0.3);
            self:drawTextureScaled(self.avatarBackgroundTexture, x, y, w, h, 1, 0.4, 0.4, 0.4);
            local avatarDef = AnimalAvatarDefinition[avatar.animal:getAnimalType()];
            if avatarDef then
                avatar:setZoom(avatarDef.trailerZoom * avatar.animal:getData():getSize());
                avatar:setXOffset(avatarDef.trailerXoffset * avatar.animal:getData():getSize());
                avatar:setYOffset(avatarDef.trailerYoffset * avatar.animal:getData():getSize());
                avatar:setDirection(avatarDef.trailerDir);
                if avatar.animal:isDead() then
                    avatar:setVariable("TrailerAnimation", "dead")
                else
                    avatar:setVariable("TrailerAnimation", "idle1")
                end
                --                print("def values", avatar.animal:getCustomName(),  "zoom: ", avatarDef.trailerZoom, "xoffset", avatarDef.trailerXoffset, "yoffset", avatarDef.trailerYoffset)
                --                print("final values", avatar.animal:getCustomName(),  "zoom: ", avatarDef.trailerZoom * avatar.animal:getData():getSize(), "xoffset", avatarDef.trailerXoffset * avatar.animal:getData():getSize(), "yoffset", avatarDef.trailerYoffset * avatar.animal:getData():getSize())
            end

            if avatar.animal:getCustomName() then
                local text = avatar.animal:getCustomName();
                if avatar.animal:isDead() then
                    text = getText("IGUI_Item_AnimalCorpse", avatar.animal:getCustomName())
                end
                self:drawTextCentre(text, avatar.x + avatar.width / 2, avatar.y + 10, 1,1,1,1, UIFont.NewSmall);
            end

            if not avatar.animal:canBePicked(self.parent.character) then
                self.grabBtns[i].enable = false;
                self.grabBtns[i].tooltip = getText("Tooltip_Animal_TooHeavy");
            else
                self.grabBtns[i].enable = true;
                self.grabBtns[i].tooltip = nil;
            end
        else
            avatar:setVisible(false);
            self.removeBtns[i]:setVisible(false);
            self.grabBtns[i]:setVisible(false);
            self.infoBtns[i]:setVisible(false);
        end

        index = index + 1;
        if index >= 4 then
            yoffset = yoffset + avatar.height + 10 + self.parent.btnHeight;
            xoffset = 10;
            index = 0;
        end
    end

    self:setScrollHeight(yoffset + 20 + self.parent.avatarHeight)
end

function ISVehicleAnimalUI:update()
    if self.scrollPanel ~= nil then
        if self.animalCount ~= self.vehicle:getAnimals():size() then
            self:reset(self.scrollPanel);
            self.animalCount = self.vehicle:getAnimals():size();
        end
    end
end

function ISVehicleAnimalUI:prerender()
    ISCollapsableWindow.prerender(self)

--    if not AnimalContextMenu.cheat then
        if not self.vehicle or not self.vehicle:getCurrentSquare() or not self.character or not self.character:getCurrentSquare() or self.vehicle:getCurrentSquare():DistToProper(self.character) > 4 then
            self:close();
        end
--    end
end

--
function ISVehicleAnimalUI:render()
    ISCollapsableWindow.render(self)

    self:drawText(getText("IGUI_Animal_TrailerAvailability"), self.progressBar.x, self.progressBar.y - 15, 1,1,1,1, UIFont.NewSmall);

    self.progressBar:setText(round(self.vehicle:getAnimalTrailerSize() - self.vehicle:getCurrentTotalAnimalSize(), 1) .. "");
    self.progressBar.progress = self.vehicle:getCurrentTotalAnimalSize() / self.vehicle:getAnimalTrailerSize();

    self:setInfo(getText("IGUI_AnimalTrailer_Info"));

    self:checkCanAddAnimal();
end

function ISVehicleAnimalUI:create(reset)
    self.scrollPanel.avatars = {};
    self.scrollPanel.removeBtns = {};
    self.scrollPanel.grabBtns = {};
    self.scrollPanel.infoBtns = {};

    for i, animal in ipairs(self.scrollPanel.animals) do
        local addAvatar = false;

        local avatar = self.scrollPanel.avatars[i];
        if not avatar then
            addAvatar = true;
            avatar = ISVehicleAnimal3DModel:new(0, 0, self.avatarWidth, self.avatarHeight)
        end
        avatar:setVisible(true)
        self.scrollPanel:addChild(avatar)
        avatar:setX(100)
        avatar:setY(100)
        if animal then
            avatar:setAnimSetName(animal:GetAnimSetName())
            avatar:setCharacter(animal)
            avatar:setDirection(IsoDirections.S)
            avatar.animal = animal;
        else
            avatar:setVisible(false)
        end

        if addAvatar then
            table.insert(self.scrollPanel.avatars, avatar);
        end

        local addBtnRemove = false;
        local addBtnGrab = false;
        local addBtnInfo = false;
        local removeBtn = self.scrollPanel.removeBtns[i];
        local grabBtn = self.scrollPanel.grabBtns[i];
        local infoBtn = self.scrollPanel.infoBtns[i];
        if not removeBtn then
            addBtnRemove = true;
            removeBtn = ISButton:new(0,0, self.btnWidth,self.btnHeight, getText("IGUI_TicketUI_RemoveTicket"), self, ISVehicleAnimalUI.onRemoveAnimal);
            removeBtn.animal = animal;
            removeBtn.panel = self.scrollPanel;
            removeBtn.player = self.character;
            removeBtn:initialise();
            removeBtn:instantiate();
            removeBtn.borderColor = {r=1, g=1, b=1, a=0.8};
            removeBtn:setVisible(animal ~= nil);
            self.scrollPanel:addChild(removeBtn);
        end
        if not grabBtn then
            addBtnGrab = true;
            grabBtn = ISButton:new(0,0, self.btnWidth,self.btnHeight, getText("ContextMenu_Grab"), self, ISVehicleAnimalUI.onGrabAnimal);
            grabBtn.animal = animal;
            grabBtn.panel = self.scrollPanel;
            grabBtn.player = self.character;
            grabBtn:initialise();
            grabBtn:instantiate();
            grabBtn.borderColor = {r=1, g=1, b=1, a=0.8};
            grabBtn:setVisible(animal ~= nil);
            self.scrollPanel:addChild(grabBtn);
        end
        if not infoBtn then
            addBtnInfo = true;
            infoBtn = ISButton:new(0,0, self.btnWidth,self.btnHeight, getText("ContextMenu_Info"), self, ISVehicleAnimalUI.onAnimalInfo);
            infoBtn.animal = animal;
            infoBtn.panel = self.scrollPanel;
            infoBtn.player = self.character;
            infoBtn:initialise();
            infoBtn:instantiate();
            infoBtn.borderColor = {r=1, g=1, b=1, a=0.8};
            infoBtn:setVisible(animal ~= nil);
            self.scrollPanel:addChild(infoBtn);
        end

        if addBtnRemove then
            table.insert(self.scrollPanel.removeBtns, removeBtn);
        end
        if addBtnGrab then
            table.insert(self.scrollPanel.grabBtns, grabBtn);
        end
        if addBtnInfo then
            table.insert(self.scrollPanel.infoBtns, infoBtn);
        end
    end

    -- custom size
    if #self.scrollPanel.animals < 20 then
        local row = math.floor(#self.scrollPanel.animals / 4) + 1;
        self:setHeight((row * (self.avatarHeight + self.btnHeight + 40)) + 100)
    end
end

function ISVehicleAnimalUI:onAnimalInfo(button, x, y)
    local vec = self.vehicle:getAreaCenter("AnimalEntry");
    local sq = getSquare(vec:getX(), vec:getY(), self.vehicle:getZ());
    if luautils.walkAdj(button.player, sq) then
        ISTimedActionQueue.add(ISOpenAnimalInfo:new(button.player, button.animal));
    end
end

function ISVehicleAnimalUI:onRemoveAnimal(button, x, y)
    local vec = self.vehicle:getAreaCenter("AnimalEntry");
    local sq = getSquare(vec:getX(), vec:getY(), self.vehicle:getZ());
    if luautils.walkAdj(button.player, sq) then
        ISTimedActionQueue.add(ISRemoveAnimalFromTrailer:new(button.player, self.vehicle, button.animal, false));
    end
end

function ISVehicleAnimalUI:onGrabAnimal(button, x, y)
    local vec = self.vehicle:getAreaCenter("AnimalEntry");
    local sq = getSquare(vec:getX(), vec:getY(), self.vehicle:getZ());
    if luautils.walkAdj(button.player, sq) then
        ISTimedActionQueue.add(ISRemoveAnimalFromTrailer:new(button.player, self.vehicle, button.animal, true));
    end
end

function ISVehicleAnimalUI:reset(panel)
    panel.animals = {};
    for i=0, panel.vehicle:getAnimals():size()-1 do
        table.insert(panel.animals, panel.vehicle:getAnimals():get(i));
    end

    for i, avatar in ipairs(panel.avatars) do
        avatar:setCharacter(nil);
        avatar:setVisible(false);
        avatar.animal = nil;
        --        avatar:removeFromUIManager(); -- TODO RJ this somehow doesn't work, didn't want to spend too much time on it, so i went to an ugly/not optimized way, meh.
        panel.removeBtns[i]:setVisible(false);
        panel.removeBtns[i]:removeFromUIManager();
        panel.grabBtns[i]:setVisible(false);
        panel.grabBtns[i]:removeFromUIManager();
        panel.infoBtns[i]:setVisible(false);
        panel.infoBtns[i]:removeFromUIManager();
    end

    panel.avatars = {};
    panel.removeBtns = {};
    panel.grabBtns = {};
    panel.infoBtns = {};

    panel.parent:create(true);
end

function ISVehicleAnimalUI:close()
    self:setVisible(false);
    self:removeFromUIManager()
    ISVehicleAnimalUI.ui = nil;
end

function ISVehicleAnimalUI:new(vehicle, player)
    local avatarWidth = 160;
    local avatarHeight = 200;
    local btnHeight = 25;
    local o = ISCollapsableWindow:new(100, 10, (avatarWidth * 4) + 100, avatarHeight * 4 + (3*(btnHeight+10)) + 40)
    o.avatarWidth = avatarWidth;
    o.avatarHeight = avatarHeight;
    o.btnHeight = btnHeight;
    o.btnWidth = 60;
    setmetatable(o, self)
    self.__index = self
    o.character = player
    o.playerNum = player:getPlayerNum()
    o.vehicle = vehicle;
    o.animalCount = o.vehicle:getAnimals():size();
    o.borderColor = {r=0.4, g=0.4, b=0.4, a=1};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.btnBorder = {r=1, g=1, b=1, a=0.7};
    o:setResizable(true)
    o:setWantKeyEvents(true)
    ISVehicleAnimalUI.ui = o;
    local carName = vehicle:getScript():getCarModelName() or vehicle:getScript():getName()
    local name = getText("IGUI_VehicleName" .. carName);
    o:setTitle(name);
    o.avatarBackgroundTexture = getTexture("media/ui/avatarBackgroundWhite.png")
    return o
end

ISVehicleAnimal3DModel = ISUI3DModel:derive("ISVehicleAnimal3DModel")

function ISVehicleAnimal3DModel:instantiate()
    ISUI3DModel.instantiate(self)
    self:setIsometric(false)
    --    self.javaObject:setConsumeMouseEvents(false)
end

function ISVehicleAnimal3DModel:onMouseDown(x, y)
    return false
end

function ISVehicleAnimal3DModel:onMouseMove(dx, dy)
    return false
end

function ISVehicleAnimal3DModel:onMouseMoveOutside(dx, dy)
    return false
end

function ISVehicleAnimal3DModel:onMouseUp(x, y)
    return false
end

function ISVehicleAnimal3DModel:onMouseUpOutside(x, y)
    return false
end

function ISVehicleAnimal3DModel:onRightMouseUp(x, y)
    return false
end

function ISVehicleAnimal3DModel:new(x, y, width, height)
    local o = ISUI3DModel.new(self, x, y, width, height)
    return o
end

function ISVehicleAnimalUI:isKeyConsumed(key)
    return key == Keyboard.KEY_ESCAPE
end

function ISVehicleAnimalUI:onKeyRelease(key)
    if key == Keyboard.KEY_ESCAPE then
        self:close()
        return
    end
end
