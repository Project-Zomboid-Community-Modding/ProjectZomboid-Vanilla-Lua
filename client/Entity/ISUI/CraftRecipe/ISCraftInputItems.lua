--***********************************************************
--**                    THE INDIE STONE                    **
--**				  Author: turbotutone				   **
--***********************************************************

--[[
    TODO : Probably deprecated
--]]

local sortItemNodes = function (a, b)
    -- sort alphabetically.
    return a.name < b.name
end

ISCraftInputItems = ISBaseObject:derive("ISCraftInputItems");

function ISCraftInputItems:updateContainers()
    self.containers = ISInventoryPaneContextMenu.getContainers(self.player);
    if not self.allItems then
        self.allItems = ArrayList.new();
    else
        self.allItems:clear();
    end
    self.allItems = CraftRecipeManager.getAllItemsFromContainers(self.containers, self.allItems);

    self:triggerEvent(ISCraftInputItems.updateContainers, self);
    self:rebuildItemNodes();
end

function ISCraftInputItems:onRecipeChanged()
    self.recipe = self.recipeData:getRecipe();
    self:rebuildItemNodes();
end

function ISCraftInputItems:rebuildItemNodes()
    if self.nodes and #self.nodes>0 then
        self.oldNodes = {};
        for _,node in ipairs(self.nodes) do
            self.oldNodes[node.scriptItem] = node;
            --print("adding old node for: "..tostring(node.name))
        end
    end

    self.nodes = {};

    if (not self.allItems) or (not self.recipe) then
        return;
    end

    for i=0,self.allItems:size()-1 do
        local item = self.allItems:get(i);

        local input = CraftRecipeManager.getValidInputScriptForItem(self.recipe, item);

        if input then
            local node = nil;
            for k,v in ipairs(self.nodes) do
                if v.scriptItem==item:getScriptItem() then
                    node = v;
                    break;
                end
            end

            if not node then
                node = ISCraftInputItemNode:new(self.recipe, item:getScriptItem());
                node.isToolLeft = input:hasFlag(InputFlag.ToolLeft);
                node.isToolRight = input:hasFlag(InputFlag.ToolRight);
                node.isTool = node.isToolLeft or node.isToolRight;

                local oldNode = self.oldNodes and self.oldNodes[node.scriptItem];
                if oldNode then
                    --print("transferring expanded")
                    node.expanded = oldNode.expanded;
                end

                table.insert(self.nodes, node);
            end

            table.insert(node.items, item);
        end

    end

    table.sort(self.nodes, sortItemNodes);

    print("TRIGGER EVENT: ISCraftInputItems.rebuildItemNodes")
    --the function object is used as identifier for the event, subscribers add listeners for 'ISCraftInputItems.rebuildItemNodes'
    self:triggerEvent(ISCraftInputItems.rebuildItemNodes, self);
end

function ISCraftInputItems:getAllItems()
    return self.allItems;
end

-- TODO note: deprecated
function ISCraftInputItems:new(_player, _recipeData)
    local o = ISBaseObject:new();
    setmetatable(o, self);
    self.__index = self;

    o.player = _player;
    o.recipeData = _recipeData;
    o.recipe = _recipeData:getRecipe();
    o.allItems = ArrayList.new();

    return o;
end

--[[
    ISCraftInputItemNode
--]]

ISCraftInputItemNode = ISBaseObject:derive("ISCraftInputItemNode");

function ISCraftInputItemNode:new(_recipe, _scriptItem)
    local o = {} ISBaseObject:new();
    setmetatable(o, self);
    self.__index = self;

    o.recipe = _recipe;
    o.scriptItem = _scriptItem;
    o.name = o.scriptItem:getScriptObjectFullType();
    --o.isHeaderNode = _isHeaderNode;
    o.textCol = Colors.White;
    o.width = 1;
    o.expanded = false;
    o.items = {};
    return o
end

function ISCraftInputItemNode:reset()
    --self.items = {};
    --self.expanded = false;
end

