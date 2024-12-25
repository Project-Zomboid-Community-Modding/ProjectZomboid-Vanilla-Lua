--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

require "ISUI/ISPanel"

--************************************************************************--
--** ISUIElementJoypad
--************************************************************************--

--[[
    -= Wrapping =-
    By default the class acts as any other UI class, can be subclassed etc.

    The class can also be wrapped around an existing UI element.
    For example ISButton which does not inherit from ISUIElementJoypad.
    When creating an instance of the ISButton the use:

    local button = ISUIElementJoypad.Wrap(ISButton, IsButtonParam1, IsButtonParam2, etc);

    This creates the ISButton internally.
    The order of the resulting table's meta __index becomes:
    - attempt to rawget on ISUIElementJoypad
    - attempt to get on ISButton

    -= Functionality =-
    Implements the methods for joypad and joypad focus events (such as 'onJoypadDown').
    By default these methods try to callback registered functions for these events.
    When inheriting from ISUIElementJoypad they can be overridden.

    When a ISUIElementJoypad has focus it can focus the next or previous element in a UI hierarchy with:
    ISUIElementJoypad:focusPreviousJoypadElement()
    ISUIElementJoypad:focusNextJoypadElement()
    By default this is done with joypad 'left' and 'right' buttons.

    To traverse focus on objects in a hierarchy the elements to traverse through
    all have to implement or wrap ISUIElementJoypad.
    For example:
    - Window
      - Panel
        - ButtonA
        - ButtonB
        - ButtonC
    Assuming the windows gets focus first, the focus can then move to Panel, next ButtonA etc.
    If for example Panel requires no focus and acts merely as a bucket it can be set to do so with:
    ISUIElementJoypad:setBucket(_bool)

    By default the children of an ISUIElementJoypad are ordered by the order they were added.
    The order can be customized with:
    ISUIElementJoypad:setZOrder(_z)
    When done creating the UI elements
    ISUIElementJoypad:orderJoypadChildren(_recursive)
    will apply the order indexing.

    -= Events =-
    For various joypad events callback methods can be registered.
    A default event callback target can be set with:
    ISUIElementJoypad:setDefaultEventTarget(_target)
    This target will be used for all events unless an event has its own target defined.
    Event callbacks can be registered with:
    ISUIElementJoypad:setEventCallback(_name, _func, _target)
    Where target is optional.

    The getPrompt events can have a text defined instead of a callback.
    ISUIElementJoypad:setEventPromptText(_name, _text)
--]]

local function createEventTable(_isPrompt)
    return {
        isEventHandler = true,
        isPrompt = _isPrompt,
        func = false,
        target = false,
        -- The prompts can either have a callback function, or text-to-return defined
        -- Function takes priority over text if both are assigned.
        prompt = nil,
    }
end

local function callbackFunc(_self, _event, ...)
    if _self and _self.__joypad and _event and _event.func then
        local target = _event.target or _self.__joypad.funcTarget;
        if target then
            return _event.func(target, _self, ...);
        else
            print("ISUIElementJoypad ->Event function set but has no target.")
        end
    end
end

local function hasCallbackFunc(_self, _event)
    if _self and _self.__joypad and _event and _event.func then
        return true;
    end
    return false;
end

local function inheritingClassCall(_self, _name, ...)
    if _self.__Class then
        local var = _self.__Class[_name];
        if var and type(var)=="function" then
            return _self.__Class[_name](_self, ...);
        end
    end
end

local function compareZOrder(a,b)
    if a.__joypad and not b.__joypad then
        return true;
    elseif a.__joypad and b.__joypad then
        return a.__joypad.zOrder < b.__joypad.zOrder;
    end
    return false;
end

local table_insert = table.insert;
local table_remove = table.remove;

local function createJoypadTable(o)
    o.__joypad = {
        data = false,
        autoFocusFirstAvail = true,
        moveInterval = ISUIElementJoypad.defaultJoypadMoveInterval,
        isMoveMode = false,
        children = {},
        isElement = true,
        index = 0,
        zOrder = 0, --used by parent to optionally sort children
        funcTarget = false, --default function target
        onGetIsMoveMode = createEventTable(),
        onJoypadDown = createEventTable(),
        onAButton = createEventTable(),
        onBButton = createEventTable(),
        onXButton = createEventTable(),
        onYButton = createEventTable(),
        onLBumper = createEventTable(),
        onRBumper = createEventTable(),
        onJoypadMove = createEventTable(),
        onValidPrompt = createEventTable(),
        onJoypadDirUp = createEventTable(),
        onJoypadDirDown = createEventTable(),
        onJoypadDirLeft = createEventTable(),
        onJoypadDirRight = createEventTable(),

        onLoseJoypadFocus = createEventTable(),
        onGainJoypadFocus = createEventTable(),

        onGetAPrompt = createEventTable(true),
        onGetBPrompt = createEventTable(true),
        onGetXPrompt = createEventTable(true),
        onGetYPrompt = createEventTable(true),
        onGetLBPrompt = createEventTable(true),
        onGetRBPrompt = createEventTable(true),
    };
end

ISUIElementJoypad = ISPanel:derive("ISUIElementJoypad");
ISUIElementJoypad.defaultJoypadMoveInterval = 20;

function ISUIElementJoypad:inheritingClassCall(_functionName, ...)
    return inheritingClassCall(_functionName, ...)
end

--[[
function ISUIElementJoypad.Wrap(_Class, ...)
    local o = _Class:new(...)

    local Class = _Class;
    setmetatable(o, {
        __index = function (table, key)
            local result = rawget(ISUIElementJoypad, key);
            if result then
                return result;
            elseif Class then
                return Class[key];
            end
            return nil;
        end
    });

    if o.__Class then
        print("ISUIElementJoypad ->Class already wrapped.");
        return;
    end
    o.__Class = _Class;

    -- adding Joypad table.
    createJoypadTable(o);
    return o;
end
--]]

function ISUIElementJoypad.Wrap(_Class, ...)
    local o = ISUIElementJoypad.Inject(nil, _Class, ...);
    return o;
end

function ISUIElementJoypad.Inject(_NewClass, _Class, ...)
    local o = _Class:new(...)

    local NewClass = _NewClass;
    local Class = _Class;
    setmetatable(o, {
        __index = function (table, key)
            local result;
            if NewClass then
                result = rawget(NewClass, key);
                if result then
                    return result;
                end
            end
            result = rawget(ISUIElementJoypad, key);
            if result then
                return result;
            elseif Class then
                return Class[key];
            end
            return nil;
        end,
        --__metatable = false,
    });

    if o.__Class then
        print("Class already wrapped.");
        return;
    end
    o.__Class = _Class;

    -- adding Joypad table.
    createJoypadTable(o);
    return o;
end

function ISUIElementJoypad:new(x, y, width, height)
    local o = ISPanel:new(x, y, width, height);
    setmetatable(o, self)
    self.__index = self;

    o.__Class = ISPanel;
    createJoypadTable(o);

    return o;
end

function ISUIElementJoypad:setPlayerNum(_num)
    self.playerNum = _num;
end

function ISUIElementJoypad:setBucket(_bool)
    self.__joypad.isElement = not _bool;
end

function ISUIElementJoypad:setZOrder(_z)
    self.__joypad.zOrder = _z;
end

function ISUIElementJoypad:orderJoypadChildren(_recursive)
    table.sort(self.__joypad.children, compareZOrder);
    if _recursive then
        for _,element in ipairs(self.__joypad.children) do
            if element.__joypad then
                element:orderJoypadChildren(_recursive);
            end
        end
    end
end

--[[
    Set default target table for events in __joypad table.
--]]
function ISUIElementJoypad:setDefaultEventTarget(_target)
    self.__joypad.funcTarget = _target;
end

--[[
    Set and event in __joypad table.
    _name = name of event, for example "onJoypadDown"
    _func = callback function
    _target = target table (optional), if not supplied then default event target is attempted.
--]]
function ISUIElementJoypad:setEventCallback(_name, _func, _target)
    if self.__joypad[_name] and self.__joypad[_name].isEventHandler then
        self.__joypad[_name].func = _func;
        self.__joypad[_name].target = _target;
    else
        print("ISUIElementJoypad ->"..tostring(_name).." is not a valid event.");
    end
end

function ISUIElementJoypad:setEventPromptText(_name, _text)
    if self.__joypad[_name] and self.__joypad[_name].isPrompt then
        self.__joypad[_name].prompt = _text;
    else
        print("ISUIElementJoypad ->"..tostring(_name).." is not a valid prompt event.");
    end
end

function ISUIElementJoypad:addChild(otherElement)
    inheritingClassCall(self,"addChild", otherElement);

    if self.__joypad and otherElement.__joypad then
        table_insert(self.__joypad.children, otherElement);
    end
end

function ISUIElementJoypad:removeChild(otherElement)
    inheritingClassCall(self,"removeChild", otherElement);

    if self.__joypad and otherElement.__joypad then
        for index=#self.__joypad.children,1,-1 do
            if self.__joypad.children[index] == otherElement then
                table_remove(self.__joypad.children, index);
                break;
            end
        end
    end
end

function ISUIElementJoypad:clearChildren()
    inheritingClassCall(self,"clearChildren");

    self.__joypad.children = {};
end

function ISUIElementJoypad:onLoseJoypadFocus(joypadData)
    self.__joypad.data = nil;

    callbackFunc(self, self.__joypad.onLoseJoypadFocus, joypadData)

    --self.joyfocus = nil;
    --self.drawJoypadFocus = false;
end

function ISUIElementJoypad:onGainJoypadFocus(joypadData)
    self.__joypad.data = joypadData;

    callbackFunc(self, self.__joypad.onGainJoypadFocus, joypadData)

    print("Gained focus: "..tostring(self.name))

    if self.__joypad.autoFocusFirstAvail and (not self.__joypad.isElement) then
        self:focusNextJoypadElement(joypadData)
    end
    --self.joyfocus = joypadData;
    --self.drawJoypadFocus = false;
end

function ISUIElementJoypad:hasJoypadFocus()
    return self.__joypad.data and self.__joypad.data.focus and self.__joypad.data.focus==self;
end

function ISUIElementJoypad:focusFirstJoypadElement(joypadData)
    self.__joypad.index=0;
    if self.__joypad.isElement then
        setJoypadFocus(joypadData.player, self);
    else
        self:focusNextJoypadElement(joypadData);
    end
end

function ISUIElementJoypad:focusNextJoypadElement(joypadData)
    if (not joypadData) and self.__joypad.data then
        joypadData = self.__joypad.data;
    end
    if not joypadData then
        print("ISUIElementJoypad ->Has no joypad focus");
        return;
    end

    if self.__joypad.index<0 then
        self.__joypad.index = 0;
    end

    if self.__joypad.index==0 then
        if self.__joypad.isElement and joypadData.focus~=self then
            setJoypadFocus(joypadData.player, self);
            return true;
        end
    end

    self.__joypad.index = self.__joypad.index + 1;
    while self.__joypad.index <= #self.__joypad.children do
        local element = self.__joypad.children[self.__joypad.index];
        if element.__joypad and element:focusNextJoypadElement(joypadData) then
            return true;
        end
        self.__joypad.index = self.__joypad.index + 1;
    end
    self.__joypad.index = #self.__joypad.children + 1;

    if self.parent and self.parent.__joypad then
        -- if last element then try to go back to parent to see if it can select a next.
        return self.parent:focusNextJoypadElement(joypadData);
    end
    return false;
end

function ISUIElementJoypad:focusPreviousJoypadElement(joypadData)
    if (not joypadData) and self.__joypad.data then
        joypadData = self.__joypad.data;
    end
    if not joypadData then
        print("ISUIElementJoypad ->Has no joypad focus");
        return;
    end

    if self.__joypad.index>#self.__joypad.children+1 then
        self.__joypad.index = #self.__joypad.children+1;
    end

    self.__joypad.index = self.__joypad.index-1;
    while self.__joypad.index>=1 do
        local element = self.__joypad.children[self.__joypad.index];
        if element.__joypad and element:focusPreviousJoypadElement(joypadData) then
            return true;
        end
        self.__joypad.index = self.__joypad.index-1;
    end
    if self.__joypad.index==0 then
        if self.__joypad.isElement and joypadData.focus~=self then
            setJoypadFocus(joypadData.player, self);
            return true;
        end
    end
    self.__joypad.index = -1;

    if self.parent and self.parent.__joypad then
        -- if last element then try to go back to parent to see if it can select a previous.
        return self.parent:focusPreviousJoypadElement(joypadData);
    end
    return false;
end

function ISUIElementJoypad:onJoypadDown(button)
    if button == Joypad.AButton and hasCallbackFunc(self, self.__joypad.onAButton) then
        callbackFunc(self, self.__joypad.onAButton, button)
        return;
    elseif button == Joypad.BButton and hasCallbackFunc(self, self.__joypad.onBButton) then
        callbackFunc(self, self.__joypad.onBButton, button)
        return;
    elseif button == Joypad.YButton and hasCallbackFunc(self, self.__joypad.onYButton) then
        callbackFunc(self, self.__joypad.onYButton, button)
        return;
    elseif button == Joypad.XButton and hasCallbackFunc(self, self.__joypad.onXButton) then
        callbackFunc(self, self.__joypad.onXButton, button)
        return;
    elseif button == Joypad.LBumper and hasCallbackFunc(self, self.__joypad.onLBumper) then
        callbackFunc(self, self.__joypad.onLBumper, button)
        return;
    elseif button == Joypad.RBumper and hasCallbackFunc(self, self.__joypad.onRBumper) then
        callbackFunc(self, self.__joypad.onRBumper, button)
        return;
    end

    callbackFunc(self, self.__joypad.onJoypadDown, button)
end

local function handlePromptReturn(_self, _event)
    if hasCallbackFunc(_self, _event) then
        return callbackFunc(_self, _event)
    end
    return _event.prompt;
end

function ISUIElementJoypad:getAPrompt()
    return handlePromptReturn(self, self.__joypad.onGetAPrompt);
end

function ISUIElementJoypad:getBPrompt()
    return handlePromptReturn(self, self.__joypad.onGetBPrompt);
end

function ISUIElementJoypad:getXPrompt()
    return handlePromptReturn(self, self.__joypad.onGetXPrompt);
end

function ISUIElementJoypad:getYPrompt()
    return handlePromptReturn(self, self.__joypad.onGetYPrompt);
end

function ISUIElementJoypad:getLBPrompt()
    return handlePromptReturn(self, self.__joypad.onGetLBPrompt);
end

function ISUIElementJoypad:getRBPrompt()
    return handlePromptReturn(self, self.__joypad.onGetRBPrompt);
end

function ISUIElementJoypad:unfocusRecursive(_focus, _playerNum)
    if _focus==self then
        setJoypadFocus(_playerNum, nil);
    end
    for _,element in ipairs(self.__joypad.children) do
        if element.__joypad then
            element:unfocusRecursive(_focus, _playerNum);
        end
    end
end

function ISUIElementJoypad:setFocusJoypadSelf(_bool)
    if _bool then
        self:focusJoypadSelf()
    else
        self:unfocusJoypadSelf()
    end
end

function ISUIElementJoypad:unfocusJoypadSelf()
    if self.playerNum then
        setJoypadFocus(self.playerNum, nil);
    else
        print("ISUIElementJoypad ->Cannot unfocus, no 'playerNum' defined.")
    end
end

function ISUIElementJoypad:focusJoypadSelf()
    if self.playerNum then
        setJoypadFocus(self.playerNum, self);
    else
        print("ISUIElementJoypad ->Cannot focus, no 'playerNum' defined.")
    end
end

function ISUIElementJoypad:isValidPrompt()
    if hasCallbackFunc(self, self.__joypad.onValidPrompt) then
        return callbackFunc(self, self.__joypad.onValidPrompt);
    end
    return true;
end

local function handleJoypadDir(_self, _dirX, _dirY, _evenDir)
    local isMoveMode = false;
    if hasCallbackFunc(_self, _self.__joypad.onGetIsMoveMode) then
        isMoveMode = callbackFunc(_self, _self.__joypad.onGetIsMoveMode);
    else
        isMoveMode = _self.__joypad.isMoveMode;
    end

    if isMoveMode then
        if hasCallbackFunc(_self, _self.__joypad.onJoypadMove) then
            callbackFunc(_self, _self.__joypad.onJoypadMove, _dirX, _dirY, _self.__joypad.moveInterval);
            return;
        end
    else
        if hasCallbackFunc(_self, _evenDir) then
            callbackFunc(_self, _evenDir);
            return;
        end
    end

    if _self.__joypad.data then
        if _dirX==-1 or _dirY==-1 then
            _self:focusPreviousJoypadElement();
        else
            _self:focusNextJoypadElement();
        end
    end
end

function ISUIElementJoypad:onJoypadDirUp()
    handleJoypadDir(self, 0, -1, self.__joypad.onJoypadDirUp);
end

function ISUIElementJoypad:onJoypadDirDown()
    handleJoypadDir(self, 0, 1, self.__joypad.onJoypadDirDown);
end

function ISUIElementJoypad:onJoypadDirLeft()
    handleJoypadDir(self, -1, 0, self.__joypad.onJoypadDirLeft);
end

function ISUIElementJoypad:onJoypadDirRight()
    handleJoypadDir(self, 1, 0, self.__joypad.onJoypadDirRight);
end