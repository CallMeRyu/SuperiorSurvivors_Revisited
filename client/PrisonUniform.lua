PrisonUniform = {}

-- Coord's for the prison boundary is {7586, 11762} to {7782, 11979}
local boundaryLowerX = 7586;
local boundaryUpperX = 7782;
local boundaryLowerY = 11762;
local boundaryUpperY = 11979;


PrisonUniform.IsPrisonSpawn = function()
	-- returns true if the player spawned within the Rosewood Prison, and false otherwise
	local pl = getPlayer();
	local x = pl:getX();
	local y = pl:getY();
	
	-- check if the player's X coords are within the prison boundary 
	if x > boundaryLowerX and x < boundaryUpperX then
		-- if they are, check the Y against the prison boundary
		if y > boundaryLowerY and y < boundaryUpperY then
			return true
		else
			return false
		end
	else
		return false
	end
end

PrisonUniform.OnStart = function()
	local pl = getPlayer();

	-- if it's a fresh spawn, and the spawn was within the prison boundary
	if pl:getHoursSurvived() == 0 and PrisonUniform.IsPrisonSpawn() then	
		PrisonUniform.CharacterCreate();
	end
end

PrisonUniform.CharacterCreate = function()
	local pl = getPlayer();
	-- delete the player's starting inventory and clothing
	pl:clearWornItems();
	pl:getInventory():clear();
	--get the player's profession
	local prof = pl:getDescriptor():getProfession()
	if prof == "policeofficer" or prof == "securityguard" then
		PrisonUniform.GivePrisonGuardGear();
	elseif prof == "nurse" or prof == "doctor" then
		PrisonUniform.GiveMedicalGear();
	elseif prof == "chef" then
		PrisonUniform.GiveCookingGear();
	elseif prof == "fireofficer" or prof == "parkranger" or prof == "lumberjack" then
		PrisonUniform.GiveAxeGear();
	else
		PrisonUniform.GivePrisonerGear();
	end
end

-- Loadout Functions

PrisonUniform.GivePrisonGuardGear = function()
	local pl = getPlayer();
	local inv = pl:getInventory();
	PrisonUniform.GiveKeyRing();
	PrisonUniform.GiveBuildingKey("Prison Key");
	local clothes = {"Base.Shirt_PrisonGuard","Base.Trousers_PrisonGuard","Base.Socks_Ankle","Base.Shoes_BlackBoots", "Base.Belt2"}
	for i , item in pairs(clothes) do
		clothes = inv:AddItem(item);
		pl:setWornItem(clothes:getBodyLocation(), clothes);
	end
end

PrisonUniform.GiveMedicalGear = function()
	local pl = getPlayer();
	local inv = pl:getInventory();
	PrisonUniform.GiveKeyRing();
	PrisonUniform.GiveBuildingKey("Prison Key");
	local clothes = {"Base.Tshirt_Scrubs","Base.Trousers_Scrubs","Base.Socks_Ankle","Base.Shoes_BlueTrainers", "Base.Belt2", "Base.Hat_SurgicalMask_Green"}
	for i , item in pairs(clothes) do
		clothes = inv:AddItem(item);
		pl:setWornItem(clothes:getBodyLocation(), clothes);
	end
end

PrisonUniform.GiveCookingGear = function()
	local pl = getPlayer();
	local inv = pl:getInventory();
	PrisonUniform.GiveKeyRing();
	PrisonUniform.GiveBuildingKey("Prison Key");
	local clothes = {"Base.Shirt_FormalWhite","Base.Trousers_Chef","Base.Socks_Ankle","Base.Shoes_TrainerTINT", "Base.Belt2", "Base.Hat_ChefHat", "Base.Apron_Black"}
	for i , item in pairs(clothes) do
		clothes = inv:AddItem(item);
		pl:setWornItem(clothes:getBodyLocation(), clothes);
	end
end

PrisonUniform.GiveAxeGear = function()
	local pl = getPlayer();
	local inv = pl:getInventory();
	getPlayer():getInventory():AddItem("Base.WoodAxe");
	local clothes = {"Base.Boilersuit_Prisoner","Base.Shoes_Slippers","Base.Socks_Ankle","Base.Tshirt_DefaultTEXTURE", "Base.Belt2"}
	for i , item in pairs(clothes) do
		clothes = inv:AddItem(item);
		pl:setWornItem(clothes:getBodyLocation(), clothes);
	end
end

PrisonUniform.GivePrisonerGear = function()
	local pl = getPlayer();
	local inv = pl:getInventory();
	getPlayer():getInventory():AddItem("Base.Pop2");
	addZombiesInOutfit(7684,11932,1, 1,"Inmate", nil)
--PrisonUniform.GiveKeyRing();
--PrisonUniform.GiveBuildingKey("Stolen Prison Key");
	local clothes = {"Base.Boilersuit_Prisoner","Base.Shoes_Slippers","Base.Socks_Ankle","Base.Tshirt_DefaultTEXTURE", "Base.Belt2"}
	for i , item in pairs(clothes) do
		clothes = inv:AddItem(item);
		pl:setWornItem(clothes:getBodyLocation(), clothes);
	end
end

PrisonUniform.GiveKeyRing = function()
	-- gets the player's inventory and full name, adds a keyring and renames it to include the player's name
	local pl = getPlayer();
	local inv = pl:getInventory();
	local keyRing = inv:AddItem("Base.KeyRing");
	local playerName = pl:getFullName();
	keyRing:setName(playerName .. getText("Challenge_PrisonKeyRing"));
end

PrisonUniform.GiveBuildingKey = function(keyName)
	local pl = getPlayer();
	local inv = pl:getInventory();
	local playerName = pl:getFullName();
	-- get the player's keyring item
	local keyRing = inv:FindAndReturn("Base.KeyRing");
	-- get the BuildingDef object the player is currently standing in
	local buildingDef = pl:getCurrentBuildingDef();
	-- get the id number of the key that'll unlock the building's doors
	local keyIdNumber = buildingDef:getKeyId();
	-- add a basic key to the player's keyring
	local key = keyRing:getInventory():AddItem("Base.Key1");
	-- give the key the required id number to unlock this building's doors
	key:setKeyId(keyIdNumber);
	-- rename the key
	if(keyName ~= nil) then
		key:setName(keyName);
	end
end

-- this code runs whenever a player is created (on spawn or respawn)
Events.OnCreatePlayer.Add(PrisonUniform.OnStart)



