require "PZAPI/ui/atoms/AtomExtensions"
local UI = PZAPI.UI
UI.instances = {}   -- For AtomUI instances refs

-- Util functions

--- Function for deep copy tables, values
UI._copyValue = function(obj, seen)
    if type(obj) ~= 'table' then return obj end
    if seen and seen[obj] then return seen[obj] end
    local s = seen or {}
    local res = setmetatable({}, getmetatable(obj))
    s[obj] = res
    for k, v in pairs(obj) do
        if k ~= "javaObj" then
            res[UI._copyValue(k, s)] = UI._copyValue(v, s)
        end
    end
    for i, v in ipairs(obj) do res[i] = UI._copyValue(v, s) end
    return res
end

--- Function for merge tables
UI._mergeTables = function(...)
    local res = {}
    for _, t in pairs({...}) do
        for key, value in pairs(t) do
            if key == "children" then
                if res[key] == nil then
                    res[key] = value
                else
                    res[key] = UI._mergeTables(res[key], value)
                end
            else
                res[key] = value
            end

        end
    end
    return res
end


function UI._setParentChildRelationship(ui)
    if ui.children == nil then return end
    for _, childui in pairs(ui.children) do
        childui.parent = ui
        UI._setParentChildRelationship(childui)
    end
end

function UI._initElement(ui)
    if ui.init ~= nil then
        ui:init()
    end

    if ui.children == nil then return end
    for _, childui in pairs(ui.children) do
        UI._initElement(childui)
    end
end

function UI._createAtomObjs(ui)
    ui.javaObj = ui._ATOM_UI_CLASS.new(ui)

    if ui.children == nil then return end
    for _, childui in pairs(ui.children) do
        UI._createAtomObjs(childui)
        ui.javaObj:addNode(childui.javaObj)
    end
end

function UI._internalInit(ui)
    ui.javaObj:init()

    if ui.children == nil then return end
    for _, childui in pairs(ui.children) do
        UI._internalInit(childui)
    end
end

function UI._initResize(ui)
    if ui.onResize ~= nil then
        ui:onResize()
    end

    if ui.children == nil then return end
    for _, childui in pairs(ui.children) do
        UI._initResize(childui)
    end
end

function UI._applyHooks(ui)
    for k, func in pairs(UI.Extensions.Hooks) do
        if ui[k] ~= nil then
            func(ui)
        end
    end

    if ui.children == nil then return end
    for _, childui in pairs(ui.children) do
        UI._applyHooks(childui)
    end
end

function UI._addChild(parent, child)
    UI._setParentChildRelationship(child)
    child.parent = parent
    UI._applyHooks(child)
    UI._createAtomObjs(child)
    parent.javaObj:addNode(child.javaObj)
    UI._internalInit(child)
    UI._initElement(child)
    UI._initResize(child)
end

--- Metatable for creating UI templates
UI._mt = {}

UI._mt.init = function()  end

--- Meta function for call tables as function
UI._mt.__call = function(self, _args)
    local res = setmetatable(UI._mergeTables(UI._copyValue(self), UI._copyValue(_args)), UI._mt)
    res.super = self
    return res
end

--- Instantiate function for new UI system element and add to UIManager
UI._mt.instantiate = function(self)
    UI._setParentChildRelationship(self)
    UI._applyHooks(self)
    UI._createAtomObjs(self)
    UI._internalInit(self)
    UI._initElement(self)
    UI._initResize(self)
    UIManager.AddUI(self.javaObj)
end