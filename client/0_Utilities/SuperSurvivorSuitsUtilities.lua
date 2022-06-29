-- this file has methods related to survivor's suits

if not SurvivorRandomSuits then
	SurvivorRandomSuits = {}
	SurvivorRandomSuits["Common"] = {} -- 70%
	SurvivorRandomSuits["Normal"] = {}  -- 20%
	SurvivorRandomSuits["Rare"] = {}	-- 10%
end

if(isModEnabled("Brita_2")) then
	SurvivorRandomSuits["Rare"]["Army"] = {
    "Base.Hat_BeretArmy", -- HEAD
    "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Brita_2.Bag_Plate_Carrier", "Brita_2.Bag_D3M", -- BODY 
    "Base.Trousers_ArmyService", -- LEGS
    "Base.Shoes_ArmyBoots" --- FEET
  }
	SurvivorRandomSuits["Rare"]["ArmyCamo"] = {
    "Brita_2.Hat_FAST_Opscore", "Brita_2.Hat_Sordin", 
    "Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Brita_2.Bag_Plate_Carrier", "Brita_2.Bag_D3M", 
    "Base.Trousers_CamoDesert", 
    "Base.Shoes_ArmyBootsDesert"
  }
	SurvivorRandomSuits["Rare"]["MarinesCamo"] = {
    "Base.Hat_Army", "Brita_2.Hat_Helmet_Headset", 
    "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Vest_BulletArmy", "Brita_2.Bag_D3M", 
    "Base.Trousers_CamoGreen", 
    "Base.Shoes_ArmyBoots"
  }
else
	SurvivorRandomSuits["Rare"]["Army"] = {
    "Base.Hat_BeretArmy", 
    "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", 
    "Base.Trousers_ArmyService", 
    "Base.Shoes_ArmyBoots"
  }
	SurvivorRandomSuits["Rare"]["ArmyCamo"] = {
    "Base.Tshirt_CamoDesert", 
    "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", 
    "Base.Trousers_CamoDesert", 
    "Base.Shoes_ArmyBootsDesert"
  }
	SurvivorRandomSuits["Rare"]["MarinesCamo"] = {
    "Base.Hat_Army", 
    "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Bag_ALICEpack", "Base.Vest_BulletArmy", 
    "Base.Trousers_CamoGreen", 
    "Base.Shoes_ArmyBoots"
  }
end

if (isModEnabled("TWDRG")) then
	SurvivorRandomSuits["Rare"]["Sheriff1"] = {
    "TWDRG.Hat_Police_Sheriff", 
    "TWDRG.TShirt_Police_Sheriff", "TWDRG.Shirt_Police_Sheriff", "TWDRG.Jacket_Police_Sheriff", "TWDRG.Vest_BulletPolice_Sheriff", 
    "TWDRG.Trousers_Police_Sheriff", 
    "Base.Shoes_BlackBoots"
  }
end

SurvivorRandomSuits["Rare"]["Bride1F"] = {
  "Base.WeddingDress", "Base.Shirt_FormalWhite", 
  "Base.Socks_Long", "Base.Shoes_Black"
}
SurvivorRandomSuits["Rare"]["Groom1M"] = {
  "Base.Tie_BowTieFull", "Base.Gloves_WhiteTINT", "Base.WeddingJacket", "Base.Shirt_FormalWhite", 
  "Base.Trousers_Suit", 
  "Base.Socks_Long", "Shoes_Black"
}
SurvivorRandomSuits["Rare"]["Priest1"] = {
  "Base.Shirt_Priest", 
  "Base.Trousers_Suit", 
  "Base.Socks_Ankle", "Base.Shoes_Black"
}
SurvivorRandomSuits["Rare"]["ShopSpiffo1"] = {
  "Base.Tshirt_BusinessSpiffo", "Base.Apron_Spiffos",
  "Base.TrousersMesh_DenimLight", 
  "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"
}
SurvivorRandomSuits["Rare"]["Swimwear1F"] = {
  "Base.Bikini_Pattern01", 
  "Base.Shoes_FlipFlop"
}
SurvivorRandomSuits["Rare"]["Swimwear1M"] = {
  "Base.SwimTrunks_Blue", 
  "Base.Shoes_FlipFlop"
}
SurvivorRandomSuits["Rare"]["Nurse1"] = {
  "Base.Hat_SurgicalMask_Blue", 
  "Base.Tshirt_Scrubs", 
  "Base.Trousers_Scrubs", 
  "Base.Socks_Ankle", "Base.Shoes_Black"
}
SurvivorRandomSuits["Rare"]["Prepper1"] = {
  "Base.Hat_GasMask", 
  "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", 
  "Base.TrousersMesh_DenimLight", 
  "Base.Socks_Ankle", "Base.Shoes_Black"
}
SurvivorRandomSuits["Rare"]["Bandit1"] = {
  "Base.Hat_BalaclavaFull", 
  "Base.Jacket_Padded", "Base.Tshirt_Rock", 
  "Base.TrousersMesh_DenimLight", 
  "Base.Socks_Ankle", "Base.Shoes_Black"
}
SurvivorRandomSuits["Rare"]["Bandit2"] = {
  "Base.Hat_BalaclavaFull", 
  "Base.HoodieUP_WhiteTINT", "Tshirt_DefaultDECAL", 
  "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"
}
SurvivorRandomSuits["Rare"]["Bandit3"] = {
  "Base.Hat_BalaclavaFull", 
  "Base.Vest_Hunting_Camo", 
  "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"
}
SurvivorRandomSuits["Rare"]["Prisoner1"] = {
  "Base.Boilersuit_Prisoner", 
  "Base.Shoes_Black"
}
SurvivorRandomSuits["Rare"]["Fireman1"] = {
  "Base.Hat_Fireman", 
  "Base.Jacket_Fireman", 
  "Base.Trousers_Fireman", 
  "Base.Shoes_BlackBoots"
}
SurvivorRandomSuits["Rare"]["Police1"] = {
  "Base.Hat_Police", 
  "Shirt_PoliceBlue", "Base.Jacket_Police", 
  "Base.Trousers_Police", 
  "Base.Shoes_Black"
}
SurvivorRandomSuits["Rare"]["Deputy1"] = {
  "Base.Hat_Police_Grey", 
  "Shirt_PoliceGrey", "Base.Jacket_Police", 
  "Base.Trousers_PoliceGrey", 
  "Base.Shoes_Black"
}

SurvivorRandomSuits["Normal"]["Hunter1"] = {
  "Base.Hat_BonnieHat_CamoGreen", "Base.Vest_Hunting_Camo", 
  "Base.Trousers_CamoGreen", 
  "Base.Shoes_BlackBoots"
}
SurvivorRandomSuits["Normal"]["ShopGeneric1"] = {
  "Base.Tshirt_DefaultDECAL", "Base.Apron_Black", 
  "Base.TrousersMesh_DenimLight", 
  "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"
}
SurvivorRandomSuits["Normal"]["Athlete1"] = {
  "Base.Shorts_ShortSport", "Base.Tshirt_Sport", 
  "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"
}
SurvivorRandomSuits["Normal"]["Worker1"] = {
  "Base.Shirt_Workman", "Base.Vest_HighViz", 
  "Base.TrousersMesh_DenimLight", 
  "Base.Socks_Ankle", "Base.Shoes_Black"
}
SurvivorRandomSuits["Normal"]["Student1"] = {
  "Base.Tshirt_Sport",
  "Base.Shorts_ShortSport", 
  "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"
}
SurvivorRandomSuits["Normal"]["Student2"] = {
  "Base.Tshirt_DefaultDECAL", "Base.Jacket_Varsity", 
  "Base.TrousersMesh_DenimLight", 
  "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"
}
SurvivorRandomSuits["Normal"]["Office1M"] = {
  "Base.Tie_Full", "Base.Shirt_FormalWhite", 
  "Base.Trousers_Suit", 
  "Base.Socks_Ankle", "Base.Shoes_Black"
}
SurvivorRandomSuits["Normal"]["Office1F"] = {
  "Base.Shirt_FormalWhite", 
  "Base.Skirt_Normal", 
  "Base.Socks_Long", "Base.Shoes_Black"
}
SurvivorRandomSuits["Normal"]["Biker1"] = {
  "Base.Hat_Bandana", "Base.Glasses_Aviators", 
  "Base.Jacket_Black", "Base.Tshirt_Rock", 
  "Base.TrousersMesh_DenimLight", 
  "Base.Socks_Ankle", "Base.Shoes_Black"
}

SurvivorRandomSuits["Normal"]["Generic1F"] = {
  "Base.Dress_Normal", 
  "Base.Socks_Ankle", "Base.Shoes_Black"
}
SurvivorRandomSuits["Normal"]["Generic2F"] = {
  "Base.Hat_Beret", 
  "Base.Dress_Knees", 
  "Base.Socks_Long", "Base.Shoes_Black"
}
SurvivorRandomSuits["Normal"]["Generic3F"] = {
  "Base.Dress_Long", 
  "Base.Socks_Long", "Base.Shoes_Black"
}
SurvivorRandomSuits["Common"]["Generic4F"] = {
  "Base.Tshirt_DefaultTEXTURE",
  "Base.Skirt_Normal",  
  "Base.Socks_Long", "Base.Shoes_Black"
}
SurvivorRandomSuits["Common"]["Generic5F"] = {
  "Base.Hat_Beret",
  "Base.Tshirt_DefaultTEXTURE",
  "Base.Skirt_Knees",  
  "Base.Socks_Long", "Base.Shoes_Black"
}
SurvivorRandomSuits["Common"]["Generic6F"] = {
  "Base.Tshirt_DefaultTEXTURE", 
  "Base.Skirt_Long",
  "Base.Socks_Long", "Base.Shoes_Black"
}

SurvivorRandomSuits["Common"]["Generic1M"] = {
  "Base.HoodieDOWN_GreyTINT", "Base.Tshirt_Rock", "Base.TrousersMesh_DenimLight", 
  "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"
}
SurvivorRandomSuits["Common"]["Generic2M"] = {
  "Base.Glasses_Normal", 
  "Base.Tshirt_DefaultDECAL", "Base.Jumper_DiamondPatternTINT", 
  "Base.TrousersMesh_DenimLight", 
  "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"
}
SurvivorRandomSuits["Common"]["Generic3M"] = {
  "Base.Jumper_RoundNeck", "Base.Tshirt_Rock", 
  "Base.TrousersMesh_DenimLight", 
  "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"
}
SurvivorRandomSuits["Common"]["Generic4M"] = {
  "Base.Tshirt_DefaultDECAL", 
  "Base.TrousersMesh_DenimLight", 
  "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"
}
SurvivorRandomSuits["Common"]["Basic1"] = {
  "Base.Hat_BaseballCapBlue", "Base.Shirt_HawaiianRed", 
  "Base.TrousersMesh_DenimLight", 
  "Base.Shoes_Black"
}


function table.randFrom( t )
   local keys = {}
    for key, value in pairs(t) do
        keys[#keys+1] = key --Store keys in another table
    end
	local key = ZombRand(1, #keys)
    index = keys[key]
	--return t[index]
	return index
end

function getRandomSurvivorSuit(SS)

	local roll = ZombRand(1,100)
	local tempTable = nil
	local randomize = false

	if(roll <= 10) then -- choose rare suit
	--	print("Rare suit:")
		tempTable = SurvivorRandomSuits["Rare"]
	elseif(roll <= 20) then --  chose normal suit
	--	print("Normal suit:")
		tempTable = SurvivorRandomSuits["Normal"]
	else --chose common suit
	--	print("Common suit:")
		tempTable = SurvivorRandomSuits["Common"]
		randomize = true
	end

	--print(tostring(size(tempTable)).." total suits in category.")
    --for key, value in pairs(tempTable) do
	--	print(key)
	--end
	local result = table.randFrom(tempTable)

	while (string.sub(result, -1) == "F" and not SS.player:isFemale()) or (string.sub(result, -1) == "M" and SS.player:isFemale()) do
	--	print("Wrong gender " .. result .. " (it's only 1993 and KY isn't woke yet)")
		result = table.randFrom(tempTable)
	end
	-- print("random key result is: "..tostring(result))

	local suitTable = tempTable[result]
	for i=1, #suitTable do
		if(suitTable[i] ~= nil) then
		--	print("WearThis: " .. tostring(suitTable[i]))
			SS:WearThis(suitTable[i])
		end
	end

	if randomize then
		for i=1, ZombRand(0, 3) do
			tempTable = SurvivorRandomSuits[table.randFrom(SurvivorRandomSuits)]
			local result = table.randFrom(tempTable)
			local suitTable = tempTable[result]
			item = suitTable[ZombRand(1, #suitTable)]
		--	print("WearThis randomize: " .. item)
			SS:WearThis(item)
		end
	end

end

function setRandomSurvivorSuit(SS,tbl,name)

	local suitTable = SurvivorRandomSuits[tbl][name]
	if suitTable then
		for i=1,#suitTable do
			if(suitTable[i] ~= nil) then
			--	print("WearThis: " .. tostring(suitTable[i]))
				SS:WearThis(suitTable[i])
			end
		end
	end

end