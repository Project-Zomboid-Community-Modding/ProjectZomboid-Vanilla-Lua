require "ISUI/ISPanelJoypad"
require "ISUI/ISRichTextPanel"
require "ISUI/ISButton"

TutorialMessage = ISPanelJoypad:derive("TutorialMessage");


--************************************************************************--
--** ISDemoPopup:initialise
--**
--************************************************************************--

function TutorialMessage:initialise()
    ISPanelJoypad.initialise(self);
end

--************************************************************************--
--** ISDemoPopup:instantiate
--**
--************************************************************************--
function TutorialMessage:createChildren()

    -- CREATE TUTORIAL PANEL
    local panel = ISRichTextPanel:new(15, 0, self.width-30, self.height);
    panel:initialise();

    self:addChild(panel);
    --panel:paginate();
    self.richtext = panel;
    self.richtext.text = self.message;
    self.richtext:paginate();
    self.richtext.backgroundColor.a = 0;

    self:updateSize()
end

function TutorialMessage:updateSize()
    local text = self.richtext.text -- get a copy of the text for temporary modifying

    -- remove all following patterns to prevent incorrect text padding
    text = text:gsub(" <", "<")
    text = text:gsub("> ", ">")
    text = text:gsub("<CENTRE>", "")
    text = text:gsub("<SIZE:medium>", "")
    text = text:gsub("<SIZE:small>", "")
    --note, <SIZE:large> is intentionally left in to add a little extra padding for long strings
    text = text:gsub("<IMAGECENTRE:media/ui/controller/", "")
    text = text:gsub("<IMAGE:media/ui/", "")
    text = text:gsub(",28,28>", "")
    text = text:gsub(",32,32>", "")

    -- insert line breaks where appropriate for width wrapping accuracy.
    text = text:gsub("<JOYPAD:", "\n")
    text = text:gsub("<LINE>", "\n")
    text = text:gsub(" ", "\n")
    text = text:gsub(",", ",\n")

    --the following lines are for easier reading in the console, and can be commented out if text output to the console is disabled
    text = text:gsub("\n\n", "\n") --remove blank lines for easier reading
    text = text:gsub("\n\n", "\n") --remove blank lines for easier reading

    self.richtext:setWidth(math.max(self.richtext:getWidth(), getTextManager():MeasureStringX(UIFont.Medium, text)+80))
    self.richtext:setHeight(self.richtext:getHeight())
    self:setWidth(self.richtext:getWidth());
    self:setHeight(self.richtext:getHeight()+10);
    --print(text)
end


function TutorialMessage:setInfo(item)

end

function TutorialMessage:onMouseWheel(del)
    return false;
end

--************************************************************************--
--** ISDemoPopup:update
--**
--************************************************************************--
function TutorialMessage:update()
    if self.test ~= nil then
        if(self.test()) then
            TutorialMessage.instance = nil;
            self:removeFromUIManager();
            self.test = nil;
            self.target:onClose(self);
        end

    end
end
function TutorialMessage:render()

    if self.message ~= self.richtext.text then
        self.message = self.richtext.text
        self:updateSize()
    end

    self.richtext:setHeight(self.richtext:getHeight())
    self:setWidth(self.richtext:getWidth()+80);
    self:setHeight(self.richtext:getHeight()+10);


    self:drawTextureScaled(TutorialMessage.spiffo, self.width - 43, -60, 256/2, 364/2, 1, 1, 1, 1);
    --self.richtext:drawRectBorder(self.richtext.x, self.richtext.y, self.richtext.width, self.richtext.height, 1, 0.2, 0.4, 1)
    if JoypadState.players[1] and self.clickToSkip and getJoypadFocus(0) ~= self and not Tutorial1.disableMsgFocus then
        setJoypadFocus(0, self)
    end

end

--function TutorialMessage:onMouseDown(x, y)
--    if self.clickToSkip then
--        TutorialMessage.instance = nil;
--        self:removeFromUIManager();
--        self.target:onClose(self);
--    end
--
--end
--function TutorialMessage:onMouseDownOutside(x, y)
--    if self.clickToSkip then
--        TutorialMessage.instance = nil;
--        self:removeFromUIManager();
--        self.target:onClose(self);
--    end
--end

function TutorialMessage:onGainJoypadFocus(joypadData)
    ISPanelJoypad.onGainJoypadFocus(self, joypadData);
end

function TutorialMessage:onJoypadDown(button)
    if TutorialMessage.instance and TutorialMessage.instance.clickToSkip and button == Joypad.AButton then
        local instance = TutorialMessage.instance;
        TutorialMessage.instance = nil;
        instance:removeFromUIManager();
        instance.target:onClose(instance);
        setJoypadFocus(0, nil)
    end
end

TutorialMessage.onKeyPressed = function(key)
    if TutorialMessage.instance and key == Keyboard.KEY_SPACE and TutorialMessage.instance.clickToSkip then
        local instance = TutorialMessage.instance;
        TutorialMessage.instance = nil;
        instance:removeFromUIManager();
        instance.target:onClose(instance);
--        getPlayer():setAuthorizeMeleeAction(true);
    end
end

TutorialMessage.getInstance = function(x, y, w, h, message, clickToSkip, target, test)
    if TutorialMessage.instance ~= nil then
        return TutorialMessage.instance;
    end;
    x = x - (w / 2);
    y = y - (h/2);
    if TutorialMessage.instance ~= nil then
        TutorialMessage.instance:removeFromUIManager();
        TutorialMessage.instance:setX(x);
        TutorialMessage.instance:setY(y);
        TutorialMessage.instance:setWidth(w);
        TutorialMessage.instance:setHeight(h);
        TutorialMessage.instance.message = message;
        TutorialMessage.instance.clickToSkip = clickToSkip;
        TutorialMessage.instance:alwaysOnTop();
        TutorialMessage.instance:setAlwaysOnTop(true);
    else
        TutorialMessage.instance = TutorialMessage:new(x, y, w, h, clickToSkip, message);
        TutorialMessage.instance:initialise();
        TutorialMessage.instance:addToUIManager();
        TutorialMessage.instance:setAlwaysOnTop(true);
    end
--    getPlayer():setAuthorizeMeleeAction(false);
    TutorialMessage.instance.target = target;
    TutorialMessage.instance.test = test;
    -- SurvivalGuideManager.instance.panel:setVisible(false);
    return TutorialMessage.instance;
end

--************************************************************************--
--** ISDemoPopup:new
--**
--************************************************************************--
function TutorialMessage:new (x, y, width, height, clickToSkip, message)
    local o = {}
    --o.data = {}
    o = ISPanelJoypad:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self
    o.x = x;
    if clickToSkip then
        if JoypadState.players[1] then
            message = message .. " <LINE> <LINE> <IMAGECENTRE:media/ui/controller/" .. (getCore():getOptionControllerButtonStyle() == 1 and "XBOX" or "PS4") .."_A.png>";
        else
            message = message .. " <LINE> <LINE> <SIZE:large> (" .. getText("IGUI_PressSpaceContinue") .. ")";
        end
    end
    o.message = message;
    o.clickToSkip = clickToSkip;
        
    TutorialMessage.spiffo = getTexture("media/ui/survivorspiffo.png");
    o.y = y;
    o.borderColor = {r=1, g=1, b=1, a=0.7};
    o.backgroundColor = {r=0, g=0, b=0, a=0.8};
    o.width = width;
    o.height = height;
    o.anchorLeft = true;
    o.anchorRight = false;
    o.anchorTop = true;
    o.anchorBottom = false;
    o.timer = 0;
    o.clicktoSkip = false;
    return o
end

Events.OnKeyPressed.Add(TutorialMessage.onKeyPressed);
