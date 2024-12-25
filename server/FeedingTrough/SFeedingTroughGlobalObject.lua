--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

if isClient() then return end

require "Map/SGlobalObject"

SFeedingTroughGlobalObject = SGlobalObject:derive("SFeedingTroughGlobalObject")

function SFeedingTroughGlobalObject:new(luaSystem, globalObject)
	local o = SGlobalObject.new(self, luaSystem, globalObject)
	return o;
end

function SFeedingTroughGlobalObject:initNew()
--	print("init new")
	self.feedAmount = {};
	self.linkedX = 0;
	self.linkedY = 0;
	self.maxFeed = 0;
	self.maxWater = 0;
	self.water = 0;
end

function SGlobalObject:OnModDataChangeItself(isoObject)
	self:stateToIsoObject(isoObject)
end

function SFeedingTroughGlobalObject:OnIsoObjectChangedItself(isoObject)
	self:stateFromIsoObject(isoObject)
end

function SFeedingTroughGlobalObject:getObject()
	return self:getIsoObject()
end

function SFeedingTroughGlobalObject:stateFromIsoObject(isoObject)
	self.linkedX = isoObject:getLinkedX();
	self.linkedY = isoObject:getLinkedY();
	self.feedAmount = {};
	self.maxFeed = isoObject:getMaxFeed();
	self.maxWater = isoObject:getMaxWater();
	self.water = isoObject:getWater();

--	print("state", self.linkedX, isoObject:getSprite():getName())
--	self.feedAmount = isoObject:getFeedAmount()
--	print("state from isoobject")
	local list = isoObject:getAllFeedingTypes();
	for i=0, list:size() - 1 do
		local type = list:get(i);
--		print("feed amount from java object", type, isoObject:getFeedAmount(type))
		self.feedAmount[type] = isoObject:getFeedAmount(type);
	end
end

function SFeedingTroughGlobalObject:stateToIsoObject(isoObject)
	for type,amount in pairs(self.feedAmount) do
--		print("feed amount from lua object",type, amount)
		isoObject:setFeedAmount(type, amount);
	end
--	isoObject:setFeedAmount(self.feedAmount or 0)
	isoObject:setLinkedX(self.linkedX or 0)
	isoObject:setLinkedY(self.linkedY or 0)
	self.water = self.water or 0
	isoObject:setWater(self.water or 0)
	if self.maxFeed ~= isoObject:getMaxFeed() or self.maxWater ~= isoObject:getMaxWater() then
		self.maxFeed = isoObject:getMaxFeed()
		self.maxWater = isoObject:getMaxWater()
		self:updateOnClient()
	end
--	isoObject:setMaxWater(self.maxWater or 0)
--	isoObject:setMaxFeed(self.maxFeed or 0)
end

function SFeedingTroughGlobalObject:addWater(amount)
	if self.water + amount > self.maxWater then
		amount = self.water - self.maxWater;
	end
	local isoObject = self:getIsoObject()
	self.water = self.water + amount;
	if isoObject then
		self:stateToIsoObject(isoObject)
	end
	self:updateOnClient()
end

function SFeedingTroughGlobalObject:emptyWater()
	local isoObject = self:getIsoObject()
	self.water = 0;
	if isoObject then
		self:stateToIsoObject(isoObject)
	end
	self:updateOnClient()
end

function SFeedingTroughGlobalObject:addObject(def, north, slave)
	if self:getObject() then return end
	local square = self:getSquare()
	local sq2 = nil
	if not square then return end
    local x, y, z = self:getSquare2PosReverse(square, north)
	local sprite = def.spriteNorth1;
    if not north then
        sprite = def.sprite1;
    end

	if slave then
		sq2 = getSquare(x, y, z);
		sprite = def.spriteNorth2;
        if not north then
            sprite = def.sprite2;
        end
	end

	--print("chosen sprite: ", sprite, north)
	local trough = IsoFeedingTrough.new(square, sprite, sq2)
    trough:setName("FeedingTrough")

    trough:setMaxWater(def.maxWater)
    trough:setDef(def);
    trough:setNorth(north);
	trough:setSpecialTooltip(true);
    square:AddSpecialObject(trough)
end

function SFeedingTroughGlobalObject:getSquare2Pos(square, north)
	local x = square:getX()
	local y = square:getY()
	local z = square:getZ()
	if north then
		x = x - 1
	else
		y = y - 1
	end
	return x, y, z
end

function SFeedingTroughGlobalObject:getSquare2PosReverse(square, north)
	local x = square:getX()
	local y = square:getY()
	local z = square:getZ()
	if north then
		x = x + 1
	else
		y = y + 1
	end
	return x, y, z
end

function SFeedingTroughGlobalObject:addFeed(type, feedAmount)
--	self.feedAmount = feedAmount

	if not self.feedAmount[type] then
		self.feedAmount[type] = 0;
	end
	local isoObject = self:getIsoObject()
	local currentFeedAmount = 0;
	for i,amount in pairs(self.feedAmount) do
		currentFeedAmount = currentFeedAmount + amount;
	end
--	print("add feed check", self.feedAmount, self.feedAmount[type], type, feedAmount, self.maxFeed, currentFeedAmount)
	if currentFeedAmount + feedAmount > self.maxFeed then
		feedAmount = self.maxFeed - currentFeedAmount;
	end
--	print("gonna add ", feedAmount, "total will be", self.feedAmount[type] + feedAmount)
	self.feedAmount[type] = self.feedAmount[type] + feedAmount;
	--	print("add feed", type, self.feedAmount[type])
	if isoObject then
		self:stateToIsoObject(isoObject)
	end
	self:updateOnClient()
end

