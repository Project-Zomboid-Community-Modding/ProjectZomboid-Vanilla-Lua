--***********************************************************
--**                    THE INDIE STONE                    **
--***********************************************************

AcceptItemFunction = {}

-- The item.AcceptItemFunction script property for item containers
-- specifies the name of a Lua function that will be called to test
-- whether an item is allowed inside a container.  The function name
-- may contain "." characters. For example:
--     AcceptItemFunction = AcceptItemFunction.FirstAidKit,

-- Example: not used
function AcceptItemFunction.FirstAidKit(container, item)
	return item:getStringItemType() == "Medical"
end

-- -- Example: not used
-- function AcceptItemFunction.KeyRing(container, item)
-- 	return item:getCategory() == "Key"
-- end

function AcceptItemFunction.AmmoStrap_Bullets(container, item)
	return item:hasTag("Ammo") and not item:hasTag("ShotgunShell")
end

function AcceptItemFunction.AmmoStrap_Shells(container, item)
	return item:hasTag("ShotgunShell")
end

function AcceptItemFunction.KeyRing(container, item)
	return item:getCategory() == "Key" or item:hasTag("FitsKeyRing")
end

function AcceptItemFunction.HolsterShoulder(container, item)
	return item:hasTag("PistolMagazine") and container:getItems():size() < 2
end

function AcceptItemFunction.Wallet(container, item)
	return item:IsMap() or item:IsLiterature() or item:hasTag("FitsWallet");
end
