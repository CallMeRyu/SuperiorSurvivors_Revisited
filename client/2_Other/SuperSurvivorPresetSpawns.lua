function isModEnabled(modname)

	local actmods = getActivatedMods();
	for i=0, actmods:size()-1, 1 do
		if actmods:get(i) == modname then
			return true;
		end
	end
	return false;
end


function getWeapon(kind)

	if(isModEnabled("ORGM")) then
		if kind == "Base.Shotgun" then return "ORGM.Rem870" end
		if kind == "Base.HuntingRifle" then return "ORGM.Garand" end
		if kind == "Base.VarmintRifle" then return "ORGM.AR15" end
		if kind == "Base.Pistol" then return "ORGM.Ber92" end
		return kind;
	end
	return kind;
end

if( not PresetSpawns ) then PresetSpawns = {} end
-- set ChanceToSpawn from 1 to 100, nil assumes 100

--ROSEWOOD 
--PresetSpawns[#PresetSpawns+1] = {Suit = "Fireman", Greeting = "Howdy. You can call me Tex. Been waiting for the military or some such, but you\'ll do my friend. Welcome!",PerkName = "Axe",PerkLevel = 5,isFemale=false,  Name = "Fire Fighter", X = 8143, Y = 11736, Z = 1 , Weapon = "Base.Axe", Orders = "Standing Ground", isHostile = false};
PresetSpawns[#PresetSpawns+1] = {Suit = "Inmate", nil,  Name = "Prisoner", X = 7684, Y = 11925, Z = 0 , Weapon = "Base.LeadPipe", Orders = "Wander", isHostile = true};
--PresetSpawns[#PresetSpawns+1] = {Suit = "Formal", Greeting = "Thank God! Please help me!",  Name = "Librarian", X = 8335, Y = 11615, Z = 0 , Weapon = "Base.BaseballBat", Orders = "Standing Ground", isHostile = false};
--PresetSpawns[#PresetSpawns+1] = {Greeting = "I\'ve been to eight county fairs and a goat rodeo, but I\'ve never seen anything like that. Thanks for the rescue. Now I gotta find Rick",PerkName = "Aiming",PerkLevel = 10, isFemale=false, NoParty = true,   Name = "Abraham", X = 8211, Y = 11805, Z = 0 , Weapon = getWeapon("Base.HuntingRifle"), Orders = "Guard", isHostile = false};
--PresetSpawns[#PresetSpawns+1] = {Greeting = "Thank you for saving me. So you\'re aware, I\'m on record as stating that I\'m not combat ready or even for that matter combat inclined",PerkName = "Blunt",PerkLevel = 3, isFemale=false, NoParty = true,   Name = "Eugene", X = 8231, Y = 11816, Z = 0 , Weapon = "Base.Plank", Orders = "Guard", isHostile = false}; 
--ROSEWOOD END

CannedFoods = {"TinnedBeans","CannedBolognese","CannedCarrots2","CannedChili","CannedCorn","CannedCornedBeef","CannedMushroomSoup","CannedPeas","CannedPotato2","CannedSardines","TinnedSoup","CannedTomato2"}
PerishableFoods = {"Strawberrie","Broccoli","Cabbage","Carrots","Potato","RedRadish","Tomato","Bread","PeanutButterSandwich","Pie"}

--- floor item spawns for hilltop camp---
--PresetSpawns[#PresetSpawns+1] = {X = 11730, Y = 7935, Z = 0 , itemType="RandomCannedFood", count = 2, isItemSpawn = true}
--PresetSpawns[#PresetSpawns+1] = {X = 11714, Y = 7926, Z = 0 , itemType="RandomCannedFood", count = 30, isItemSpawn = true,GroupID=HillTopGroupID}
--PresetSpawns[#PresetSpawns+1] = {X = 11716, Y = 7926, Z = 0 , itemType="RandomCannedFood", count = 30, isItemSpawn = true,GroupID=HillTopGroupID}
--PresetSpawns[#PresetSpawns+1] = {X = 11726, Y = 7941, Z = 0 , itemType="Base.WaterPot", count = 2, isItemSpawn = true}
--PresetSpawns[#PresetSpawns+1] = {X = 11728, Y = 7940, Z = 0 , itemType="Base.Log", count = 4, isItemSpawn = true}


SurvivorCount = 1;

			
SurvivorRoutes = {

	WPToHilltop = {
		{x=11589,y=7076,z=0},
		{x=11699,y=7166,z=0},
		{x=11648,y=7212,z=0},
		{x=11649,y=7906,z=0},
		{x=11686,y=7932,z=0},
		{x=11731,y=7939,z=0},
	},
	
	MuldToHilltop = {
		{x=10647,y=9295,z=0},
		{x=10692,y=9154,z=0},
		{x=10820,y=9142,z=0},
		{x=10964,y=9068,z=0},
		{x=10962,y=8764,z=0},
		{x=11635,y=8753,z=0},
		{x=11648,y=7948,z=0},
		{x=11731,y=7939,z=0},
	},
	
	TrainTracksToValleyStation = {
		{x=12181,y=6821,z=0},
		{x=12296,y=6775,z=0},
		{x=12298,y=6609,z=0},
		{x=12576,y=6606,z=0},
		{x=12621,y=6564,z=0},
		{x=12620,y=5863,z=0},
		{x=12735,y=5772,z=0},
	},

}

HairColors = {}
HairColors ["white"] = ImmutableColor.new(0.75,0.74,0.72)
HairColors ["grey"] = ImmutableColor.new(0.48,0.47,0.44)
HairColors ["blond"] = ImmutableColor.new(0.82,0.82,0.39)
HairColors ["sand"] = ImmutableColor.new(0.86,0.78,0.66)
HairColors ["hazel"] = ImmutableColor.new(0.61,0.50,0.34)
HairColors ["brown"] = ImmutableColor.new(0.62,0.42,0.17)
HairColors ["red"] = ImmutableColor.new(0.58,0.25,0.25)
HairColors ["pink"] = ImmutableColor.new(0.59,0.39,0.55)
HairColors ["purple"] = ImmutableColor.new(0.47,0.43,0.59)
HairColors ["blue"] = ImmutableColor.new(0.39,0.47,0.59)
HairColors ["black"] = ImmutableColor.new(0.10,0.08,0.09)


function SuperSurvivorPresetSpawn(square)
	
	if(RPresetSpawns ~= nil) then
		
		if(NoPreSetSpawn) then return false end
		
		local x = square:getX();
		local y = square:getY();
		local z = square:getZ();

		local i = x..y..z;
		
		if(RPresetSpawns[i]) and square:getModData().SurvivorSquareLoaded == nil and (RPresetSpawns[i].ChanceToSpawn == nil or ZombRand(1,100) > RPresetSpawns[i].ChanceToSpawn) then
			
			square:getModData().SurvivorSquareLoaded = true

			
			if(RPresetSpawns[i].isItemSpawn ~= nil) and (RPresetSpawns[i].itemType ~= nil) then
			
				local item = RPresetSpawns[i].itemType
				local count = RPresetSpawns[i].count
				if not count then count = 1 end
				local dropItem = item
				for i=0, count-1 do
					if(item == "RandomCannedFood") then dropItem = "Base."..tostring(CannedFoods[ZombRand(#CannedFoods)+1])
					else dropItem = item end
					square:AddWorldInventoryItem(dropItem, (ZombRand(99)/100), (ZombRand(99)/100),0)
				end
				if(RPresetSpawns[i].GroupID) then square:getModData().Group = RPresetSpawns[i].GroupID end-- who it belongs to
			
			else			
				
				if RPresetSpawns[i].isFemale ~= nil then isFemale = RPresetSpawns[i].isFemale end
				local SuperSurvivor = SSM:spawnSurvivor(isFemale,square)
				if(SuperSurvivor == nil) then return false end
				
				local Buddy = SuperSurvivor.player
				
				if(RPresetSpawns[i].AIMode ~= nil) then SuperSurvivor:setAIMode(RPresetSpawns[i].AIMode) end
							
				SuperSurvivor.player:setZ(RPresetSpawns[i].Z);
				
				local tempTM = SuperSurvivor:getTaskManager()
				tempTM:clear()
				
				if(RPresetSpawns[i].Orders ~= nil) and (RPresetSpawns[i].Orders == "Guard") then				
					tempTM:AddToTop(GuardTask:new(SuperSurvivor,SuperSurvivor.player:getCurrentSquare()))
					--SuperSurvivor:setBravePoints(5)
					SuperSurvivor:setAIMode("Guard")
				end
				
				if(RPresetSpawns[i].Orders ~= nil) and (RPresetSpawns[i].Orders == "Doctor") then				
					tempTM:AddToTop(DoctorTask:new(SuperSurvivor))
					SuperSurvivor:setAIMode("Doctor")
				end
				
				if(RPresetSpawns[i].Orders ~= nil) and (RPresetSpawns[i].Orders == "Farming") then				
					tempTM:AddToTop(FarmingTask:new(SuperSurvivor))
					SuperSurvivor:setAIMode("Farmer")
				end
				
				if(RPresetSpawns[i].Orders ~= nil) and (RPresetSpawns[i].Orders == "Wander") or (RPresetSpawns[i].Orders == "Explore")then				
					tempTM:AddToTop(WanderTask:new(SuperSurvivor))
					SuperSurvivor:setAIMode("Wander")
				end
				
				if(RPresetSpawns[i].Orders ~= nil) and (RPresetSpawns[i].Orders == "FollowRoute") then	
					local routeID = RPresetSpawns[i].RouteID 
					tempTM:AddToTop(FollowRouteTask:new(SuperSurvivor,routeID))
					SuperSurvivor:setAIMode("FollowRoute")
				end
				
				if(RPresetSpawns[i].Orders ~= nil) and (RPresetSpawns[i].Orders == "Standing Ground") then
					SuperSurvivor:setWalkingPermitted(false)
					--SuperSurvivor:setBravePoints(5)
					SuperSurvivor:setAIMode("Stand Ground")
				end
				
				if(RPresetSpawns[i].Patrolling ~= nil) then
					local patrolSquare = getCell():getGridSquare(x + RPresetSpawns[i].PX,y + RPresetSpawns[i].PY,RPresetSpawns[i].Z)				
					SuperSurvivor.player:getModData().PX = x + RPresetSpawns[i].PX
					SuperSurvivor.player:getModData().PY = y + RPresetSpawns[i].PY
					SuperSurvivor.player:getModData().PZ = RPresetSpawns[i].Z
					tempTM:AddToTop(PatrolTask:new(SuperSurvivor,SuperSurvivor.player:getCurrentSquare(),patrolSquare))
					--SuperSurvivor:setBravePoints(5)			
					SuperSurvivor:setAIMode("Patrol")		
				end
				
				if(RPresetSpawns[i].GroupID ~= nil) then
					
					local Role = RPresetSpawns[i].Role
					if not Role then Role = "Worker" end
					local tempGroup = SSGM:Get(RPresetSpawns[i].GroupID)
					if(tempGroup:getLeader() == -1) then
						tempGroup:addMember(SuperSurvivor,"Leader")
					else 
						tempGroup:addMember(SuperSurvivor,Role)
					end
											
				end
				
				if(RPresetSpawns[i].NoParty ~= nil) then 
					SuperSurvivor.player:getModData().NoParty = true;
				end
				
				if(IsDamageBroken and RPresetSpawns[i].isHostile == true) then SuperSurvivor:setHostile(true) end
				SuperSurvivor.player:getModData().seenZombie = true;
				
				if(RPresetSpawns[i].Suit ~= nil) then
					SuperSurvivor:SuitUp(RPresetSpawns[i].Suit)
				end
					
				if(RPresetSpawns[i].Weapon ~= nil) then
					SuperSurvivor:giveWeapon(RPresetSpawns[i].Weapon,true);
				end
				if(RPresetSpawns[i].ShowName ~= nil) then
					SuperSurvivor.player:getModData().ShowName = true;
				end
				if(RPresetSpawns[i].Greeting) then
					SuperSurvivor.player:getModData().Greeting = RPresetSpawns[i].Greeting;
				end
				if(RPresetSpawns[i].InitGreeting) then
					SuperSurvivor.player:getModData().InitGreeting = RPresetSpawns[i].InitGreeting;
				end
				--if RPresetSpawns[i].Name:match(" ") then
					--SuperSurvivor:setName(RPresetSpawns[i].Name)
				--else
					if SuperSurvivor.player:isFemale() then
						nameToSet = getName("GirlNames")	
					else
						nameToSet = getName("BoyNames")			
					end		
					--SuperSurvivor:setName(RPresetSpawns[i].Name .. " " .. nameToSet)
					SuperSurvivor:setName(nameToSet)
				--end
				
				if(RPresetSpawns[i].PerkLevel ~= nil and RPresetSpawns[i].PerkName ~= nil) then
					local perk  = Perks.FromString(RPresetSpawns[i].PerkName);
					local level 
					if perk and (tostring(perk) ~= "MAX") then
						if(RPresetSpawns[i].PerkLevel == nil) then level = ZombRand(3,9)
						else level = RPresetSpawns[i].PerkLevel end
						local count = 0;
						--print("leveling perk: "..tostring(perk))
						while(count < level) do
							SuperSurvivor.player:LevelPerk(perk);
							count = count + 1;
						end
					end
				end
				

			--	Arsenal[26]'s changes -- start
			--	NOTE : This previously started at line #455, didn't work since NPC not spawned yet.
			--	NOTE : I've always started additional PresetSpawn parameters way down here without issues.
			--	==============================
			--	= 0 - 4  Lightest to Darkest
			--	==============================
				if(RPresetSpawns[i].Skin ~= nil) then
					SuperSurvivor:Get():getHumanVisual():setSkinTextureIndex(RPresetSpawns[i].Skin)
				end
				
			--	================================================
			--	= UNISEX - Hat, Bald, Ponytail
			--	= FEMALE - Spike, OverEye, Bob, Demi, Kate, Long, Long2, Back
			--	= MALE - CrewCut, Picard, Baldspot, Recede
			--	= MALE - Messy, Short, Mullet, Metal, Fabian
			--	================================================
				if(RPresetSpawns[i].Hair ~= nil) then
					SuperSurvivor:Get():getHumanVisual():setHairModel(RPresetSpawns[i].Hair)
				end
			--	================================================
			--	= MALE - None, Chops, Moustache, Goatee, BeardOnly, Full, Long, LongScruffy
			--	================================================
				if(RPresetSpawns[i].Beard ~= nil) then
					SuperSurvivor:Get():getHumanVisual():setBeardModel(RPresetSpawns[i].Beard)
				end

			--	================================================
			--	= COLOR - White, Grey, Blond, Sand, Brown, Red, Pink, Purple, Blue, Black
			--	================================================
				if(RPresetSpawns[i].Color ~= nil) then
					SuperSurvivor:Get():getHumanVisual():setHairColor(getPresetColor(RPresetSpawns[i].Color))
				end
			--	Arsenal[26]'s changes -- end
				
				
				RPresetSpawns[i] = nil;
			end
			
			
			
			return true			
			
		end
	
	end
	return false
end