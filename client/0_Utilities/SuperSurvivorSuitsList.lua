require "0_Utilities/SuperSurvivorSuitsRegistry"

-- this file has the survivor's suits

SurvivorRandomSuits["Legendary"]["Bathrobe1"] = {
  "Base.Hat_ShowerCap",
  "Base.LongCoat_Bathrobe", 
  "Base.Shoes_Slippers"
}

if(isModEnabled("Brita_2")) then
	SurvivorRandomSuits["VeryRare"]["Army"] = {
    "Base.Hat_BeretArmy", -- HEAD
    "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Brita_2.Bag_Plate_Carrier", "Brita_2.Bag_D3M", -- BODY 
    "Base.Trousers_ArmyService", -- LEGS
    "Base.Shoes_ArmyBoots" --- FEET
  }
	SurvivorRandomSuits["VeryRare"]["ArmyCamo"] = {
    "Brita_2.Hat_FAST_Opscore", "Brita_2.Hat_Sordin", 
    "Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Brita_2.Bag_Plate_Carrier", "Brita_2.Bag_D3M", 
    "Base.Trousers_CamoDesert", 
    "Base.Shoes_ArmyBootsDesert"
  }
	SurvivorRandomSuits["VeryRare"]["MarinesCamo"] = {
    "Base.Hat_Army", "Brita_2.Hat_Helmet_Headset", 
    "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Vest_BulletArmy", "Brita_2.Bag_D3M", 
    "Base.Trousers_CamoGreen", 
    "Base.Shoes_ArmyBoots"
  }
else
	SurvivorRandomSuits["VeryRare"]["Army"] = {
    "Base.Hat_BeretArmy", 
    "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", 
    "Base.Trousers_ArmyService", 
    "Base.Shoes_ArmyBoots"
  }
	SurvivorRandomSuits["VeryRare"]["ArmyCamo"] = {
    "Base.Tshirt_CamoDesert", 
    "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", 
    "Base.Trousers_CamoDesert", 
    "Base.Shoes_ArmyBootsDesert"
  }
	SurvivorRandomSuits["VeryRare"]["MarinesCamo"] = {
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
SurvivorRandomSuits["Uncommon"]["Office1M"] = {
  "Base.Tie_Full", "Base.Shirt_FormalWhite", 
  "Base.Trousers_Suit", 
  "Base.Socks_Ankle", "Base.Shoes_Black"
}
SurvivorRandomSuits["Uncommon"]["Office1F"] = {
  "Base.Shirt_FormalWhite", 
  "Base.Skirt_Normal", 
  "Base.Socks_Long", "Base.Shoes_Black"
}
SurvivorRandomSuits["Uncommon"]["Biker1"] = {
  "Base.Hat_Bandana", "Base.Glasses_Aviators", 
  "Base.Jacket_Black", "Base.Tshirt_Rock", 
  "Base.TrousersMesh_DenimLight", 
  "Base.Socks_Ankle", "Base.Shoes_Black"
}

SurvivorRandomSuits["Uncommon"]["Generic1F"] = {
  "Base.Dress_Normal", 
  "Base.Socks_Ankle", "Base.Shoes_Black"
}
SurvivorRandomSuits["Uncommon"]["Generic2F"] = {
  "Base.Hat_Beret", 
  "Base.Dress_Knees", 
  "Base.Socks_Long", "Base.Shoes_Black"
}
SurvivorRandomSuits["Uncommon"]["Generic3F"] = {
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

-- Presets, for use with the new Preset Spawns feature.
SurvivorRandomSuits["Preset"]["Preset_Army"] = {
  "Base.Hat_BeretArmy", 
  "Base.Tshirt_ArmyGreen",
  "Base.Jacket_CoatArmy",
  "Base.Trousers_ArmyService",
  "Base.Shoes_ArmyBoots",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Gangster"] = {
  "Base.Hat_BaseballCapGreen_Reverse",
  "Base.Trousers_JeanBaggy",
  "Base.Shoes_RedTrainers",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Survivalist"] = {
  "Base.Ghillie_Top", 
  "Base.Ghillie_Trousers",
  "Base.Shoes_BlackBoots",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Hunter"] = {
  "Base.Hat_BonnieHat_CamoGreen", 
  "Base.Vest_Hunting_Camo",
  "Base.Trousers_CamoGreen",
  "Base.Shoes_BlackBoots",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_MarinesCamo"] = {
  "Base.Hat_Army", 
  "Base.Tshirt_CamoGreen",
  "Base.Shirt_CamoGreen",
  "Base.Jacket_ArmyCamoGreen",
  "Base.Vest_BulletArmy",
  "Base.Trousers_CamoGreen",
  "Base.Shoes_ArmyBoots",
  "Base.Bag_ALICEpack",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_ArmyCamo"] = {
  "Base.Tshirt_CamoDesert", 
  "Base.Shoes_Slippers",
  "Base.Socks_Ankle",
  "Base.Shirt_CamoDesert",
  "Base.Jacket_ArmyCamoDesert",
  "Base.Trousers_CamoDesert",
  "Base.Shoes_ArmyBootsDesert",
  "Base.Bag_ALICEpack",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Chef"] = {
  "Base.Hat_ChefHat", 
  "Base.Jacket_Chef",
  "Base.Trousers_Chef",
  "Base.Shoes_Black",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Fireman"] = {
  "Base.Hat_Fireman", 
  "Base.Jacket_Fireman",
  "Base.Trousers_Fireman",
  "Base.Shoes_BlackBoots",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Doctor"] = {
  "Base.Hat_SurgicalCap_Blue", 
  "Base.JacketLong_Doctor",
  "Base.Trousers_Scrubs",
  "Base.Shoes_Black",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Police"] = {
  "Base.Hat_Police_Grey", 
  "Base.Jacket_Police",
  "Base.Trousers_PoliceGrey",
  "Base.Shoes_BlackBoots",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Farmer"] = {
  "Base.Boilersuit", 
  "Base.Dungarees",
  "Base.Shoes_BlackBoots",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Guard"] = {
  "Base.Shirt_PrisonGuard", 
  "Base.Trousers_PrisonGuard",
  "Base.Shoes_BlackBoots",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Formal"] = {
  "Base.Shirt_FormalWhite", 
  "Base.Trousers_WhiteTEXTURE",
  "Base.Shoes_Black",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Spiffo"] = {
  "Base.SpiffoSuit", 
  "Base.Hat_Spiffo",
  "Base.SpiffoTail",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Santa"] = {
  "Base.Hat_SantaHat", 
  "Base.JacketLong_Santa",
  "Base.Trousers_Santa",
  "Base.Shoes_BlackBoots",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Hazmat"] = {
  "Base.Shoes_BlackBoots", 
  "Base.HazmatSuit",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Leader"] = {
  "Base.Vest_BulletPolice", 
  "Base.Shirt_Lumberjack",
  "Base.Trousers_DefaultTEXTURE",
  "Base.Shoes_Black",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Worker"] = {
  "Base.Hat_HardHatYellow", 
  "Base.Shirt_Workman",
  "Base.Trousers_DefaultTEXTURE",
  "Base.Shoes_BlackBoots",
  "Base.Belt2"
}
SurvivorRandomSuits["Preset"]["Preset_Inmate"] = {
  "Base.Boilersuit_Prisoner", 
  "Base.Shoes_Slippers",
  "Base.Socks_Ankle",
  "Base.Tshirt_DefaultTEXTURE",
  "Base.Belt2"
}