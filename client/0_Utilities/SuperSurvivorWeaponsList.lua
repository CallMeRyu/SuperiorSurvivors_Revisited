require "0_Utilities/SuperSurvivorWeaponsRegistry"

-- TO DO Add Comments

--weapon tables:
MeleWeapons = {
"Base.Hammer","Base.BallPeenHammer","Base.WoodenMallet","Base.Wrench","Base.PipeWrench",
"Base.Shovel","Base.Shovel2","Base.Rake",
"Base.Plank","Base.Plank","Base.Plank","Base.Plank","Base.PlankNail","Base.PlankNail","Base.PlankNail","Base.MetalPipe","Base.MetalBar",
"Base.BaseballBat","Base.BaseballBat","Base.BaseballBat","Base.BaseballBatNails",
"Base.Golfclub","Base.TennisRacket","Base.BadmintonRacket","Base.Poolcue","Base.HockeyStick","Base.LaCrosseStick","Base.IcePick",
"Base.Pan","Base.Saucepan","Base.GridlePan","Base.RollingPin",
-- "Base.GuitarAcoustic","Base.GuitarElectricBlack","Base.GuitarElectricBassBlue","Base.Flute",		-- Far too slow animations

-- "Base.GardenFork","Base.WoodenLance",
-- "Base.SpearCrafted","Base.SpearCrafted","Base.SpearKnife","Base.SpearScissors","Base.SpearScrewdriver","Base.SpearHuntingKnife",		-- Spears freeze animation

"Base.Axe","Base.HandAxe","Base.WoodAxe","Base.Pickaxe","Base.AxeStone","Base.HandScythe",
-- "Base.Stake",
"Base.KitchenKnife","Base.HuntingKnife","Base.Machete" --, "Base.Katana"
}; -- RollingPin acts as a torch, setting target on fire
-- Removed from list 
-- "Base.Sledgehammer","Base.SnowShovel","Base.LeafRake","Base.Plunger","Base.Crowbar","Base.Crowbar","Base.Crowbar","Base.Crowbar","Base.Crowbar","Base.FishingRod","Base.Spoon","Base.Fork","Base.Screwdriver","Base.Scalpel"





if isModEnabled("ChainSaw") then
table.insert(MeleWeapons,"ChainSaw.ChainSaw");
end

if isModEnabled("Hydrocraft") then
table.insert(MeleWeapons,"Hydrocraft.HCAluminiumbat");                          
table.insert(MeleWeapons,"Hydrocraft.HCBaseballbatbarbedwire");
table.insert(MeleWeapons,"Hydrocraft.HCHatchetiron");
table.insert(MeleWeapons,"Hydrocraft.HCKnifeiron");
table.insert(MeleWeapons,"Hydrocraft.HCKatana");
table.insert(MeleWeapons,"Hydrocraft.HCMachete");
table.insert(MeleWeapons,"Hydrocraft.HCMonkeywrench");
table.insert(MeleWeapons,"Hydrocraft.HCKnifesteel");
table.insert(MeleWeapons,"Hydrocraft.HCHatchetsteel");
table.insert(MeleWeapons,"Hydrocraft.HCSurvivalaxe");
table.insert(MeleWeapons,"Hydrocraft.HCWrench");
table.insert(MeleWeapons,"Hydrocraft.HCRake");
end

if isModEnabled("Brita") then
	table.insert(MeleWeapons,"Brita.RamboKnife");
	table.insert(MeleWeapons,"Brita.BGMachete");
	table.insert(MeleWeapons,"Brita.DingDong");
	table.insert(MeleWeapons,"Brita.Tactical_Axe");
	table.insert(MeleWeapons,"Brita.Tactical_Sickle");
end

RangeWeapons = {"Base.Pistol2","Base.Revolver_Short","Base.Revolver","Base.Pistol","Base.Revolver_Long","Base.VarmintRifle","Base.HuntingRifle","Base.Pistol","Base.Shotgun","Base.ShotgunSawnoff","Base.Pistol","Base.Shotgun"};

if isModEnabled("ORGM") then -- add some rare auto orgm guns
table.insert(RangeWeapons,"ORGM.Mac11")
table.insert(RangeWeapons,"ORGM.Glock17")
table.insert(RangeWeapons,"ORGM.Ber93R")
table.insert(RangeWeapons,"ORGM.M16")
end

-- Weapons (firearms) compatibility with Brita's Weapon Pack
-- Weapons chosen based on criteria;
-- 1. Existence of production models, not just a few prototypes
-- 2. Has a clearly identifiable production and service history
-- 3. Can be reasonably believed that an American would have access to, or have the knowledge on how to attain upon social collapse
-- 4. Highly reliable in an apocalyptic setting. Also fun to use.
-- ** Thank you EpiKality for this and other Brita's compatibility code!

if isModEnabled("Brita") then
	table.insert(RangeWeapons,"Brita.Mosin");
	table.insert(RangeWeapons,"Brita.MosinObrez");
	table.insert(RangeWeapons,"Brita.KS23");
	table.insert(RangeWeapons,"Brita.KS23_S");
	table.insert(RangeWeapons,"Brita.ADAR");
	table.insert(RangeWeapons,"Brita.M85_Stock");
	table.insert(RangeWeapons,"Brita.AK47");
	table.insert(RangeWeapons,"Brita.AKM");
	table.insert(RangeWeapons,"Brita.AKMS_Stock");
	table.insert(RangeWeapons,"Brita.AK103");
	table.insert(RangeWeapons,"Brita.MD65_Stock");
	table.insert(RangeWeapons,"Brita.Vz58");
	table.insert(RangeWeapons,"Brita.Vz58_Stock");
	table.insert(RangeWeapons,"Brita.Vz58_Mini_Stock");
	table.insert(RangeWeapons,"Brita.SVD");
	table.insert(RangeWeapons,"Brita.SVDK");
	table.insert(RangeWeapons,"Brita.WA2000");
	table.insert(RangeWeapons,"Brita.PKM");
	table.insert(RangeWeapons,"Brita.VSS");
	table.insert(RangeWeapons,"Brita.ASVAL");
	table.insert(RangeWeapons,"Brita.DAO12");
	table.insert(RangeWeapons,"Brita.SUB2000");
	table.insert(RangeWeapons,"Brita.UZI");
	table.insert(RangeWeapons,"Brita.UZI_Wood");
	table.insert(RangeWeapons,"Brita.UZI_Micro");
	table.insert(RangeWeapons,"Brita.M1Carbine");
	table.insert(RangeWeapons,"Brita.M2Carbine");
	table.insert(RangeWeapons,"Brita.M1");
	table.insert(RangeWeapons,"Brita.Thompson");
	table.insert(RangeWeapons,"Brita.Thompson_1928");
	table.insert(RangeWeapons,"Brita.BAR");
	table.insert(RangeWeapons,"Brita.BAR_Monitor");
	table.insert(RangeWeapons,"Brita.Commando");
	table.insert(RangeWeapons,"Brita.M1903");
	table.insert(RangeWeapons,"Brita.Colt1911");
	table.insert(RangeWeapons,"Brita.Colt_Kimber");
	table.insert(RangeWeapons,"Brita.Colt_Commander");
	table.insert(RangeWeapons,"Brita.AMT1911");
	table.insert(RangeWeapons,"Brita.AMT1911_Long");
	table.insert(RangeWeapons,"Brita.M1911_Carbine");
	table.insert(RangeWeapons,"Brita.Colt_Service38");
	table.insert(RangeWeapons,"Brita.Colt_Service45");
	table.insert(RangeWeapons,"Brita.Colt_Navy_1851");
	table.insert(RangeWeapons,"Brita.M1887");
	table.insert(RangeWeapons,"Brita.M1887_Sawed");
	table.insert(RangeWeapons,"Brita.M29_44");
	table.insert(RangeWeapons,"Brita.Automag");
	table.insert(RangeWeapons,"Brita.DEagle");
	table.insert(RangeWeapons,"Brita.G18");
	table.insert(RangeWeapons,"Brita.G21");
	table.insert(RangeWeapons,"Brita.G34");
	table.insert(RangeWeapons,"Brita.B93R");
	table.insert(RangeWeapons,"Brita.M9");
	table.insert(RangeWeapons,"Brita.M9A3");
	table.insert(RangeWeapons,"Brita.MP9");
	table.insert(RangeWeapons,"Brita.P226");
	table.insert(RangeWeapons,"Brita.FN_57");
	table.insert(RangeWeapons,"Brita.FN_57_MK2");
	table.insert(RangeWeapons,"Brita.CZ75");
	table.insert(RangeWeapons,"Brita.CZ97B");
	table.insert(RangeWeapons,"Brita.Shorty");
	table.insert(RangeWeapons,"Brita.M1014_Stock");
	table.insert(RangeWeapons,"Brita.M1014");
	table.insert(RangeWeapons,"Brita.M1208");
	table.insert(RangeWeapons,"Brita.M1212");
	table.insert(RangeWeapons,"Brita.M1216");
	table.insert(RangeWeapons,"Brita.AA12");
	table.insert(RangeWeapons,"Brita.SPAS12_Fixed");
	table.insert(RangeWeapons,"Brita.SPAS12_Stock");
	table.insert(RangeWeapons,"Brita.M870");
	table.insert(RangeWeapons,"Brita.M870_Wingmaster");
	table.insert(RangeWeapons,"Brita.M870_Police");
	table.insert(RangeWeapons,"Brita.M870_MCS");
	table.insert(RangeWeapons,"Brita.M870_Express");
	table.insert(RangeWeapons,"Brita.M870_Breaching");
	table.insert(RangeWeapons,"Brita.M870_CQB");
	table.insert(RangeWeapons,"Brita.MAC10_Stock");
	table.insert(RangeWeapons,"Brita.MP5_Fixed");
	table.insert(RangeWeapons,"Brita.MP5_Stock");
	table.insert(RangeWeapons,"Brita.MP5SD6_Fixed");
	table.insert(RangeWeapons,"Brita.MP5SD6_Stock");
	table.insert(RangeWeapons,"Brita.EVO_Stock");
	table.insert(RangeWeapons,"Brita.KRISS_Stock");
	table.insert(RangeWeapons,"Brita.FN_P90");
	table.insert(RangeWeapons,"Brita.FN_PS90");
	table.insert(RangeWeapons,"Brita.UMP9");
	table.insert(RangeWeapons,"Brita.UMP45");
	table.insert(RangeWeapons,"Brita.CAR15SMG");
	table.insert(RangeWeapons,"Brita.CAR15_Survival");
	table.insert(RangeWeapons,"Brita.M635");
	table.insert(RangeWeapons,"Brita.M635S");
	table.insert(RangeWeapons,"Brita.M635SD");
	table.insert(RangeWeapons,"Brita.MINI14");
	table.insert(RangeWeapons,"Brita.MINI14_T");
	table.insert(RangeWeapons,"Brita.SCARL");
	table.insert(RangeWeapons,"Brita.SCARSC_Stock");
	table.insert(RangeWeapons,"Brita.SCARH");
	table.insert(RangeWeapons,"Brita.SCAR20");
	table.insert(RangeWeapons,"Brita.FAL");
	table.insert(RangeWeapons,"Brita.FAL_PARA_Stock");
	table.insert(RangeWeapons,"Brita.G33");
	table.insert(RangeWeapons,"Brita.G3");
	table.insert(RangeWeapons,"Brita.G28");
	table.insert(RangeWeapons,"Brita.M14");
	table.insert(RangeWeapons,"Brita.M14EBR");
	table.insert(RangeWeapons,"Brita.MK18");
	table.insert(RangeWeapons,"Brita.M723");
	table.insert(RangeWeapons,"Brita.XM117");
	table.insert(RangeWeapons,"Brita.LVOA-C");
	table.insert(RangeWeapons,"Brita.H416");
	table.insert(RangeWeapons,"Brita.FN_FNC");
	table.insert(RangeWeapons,"Brita.FAMAS");
	table.insert(RangeWeapons,"Brita.FAMAS_G2");
	table.insert(RangeWeapons,"Brita.AUG9");
	table.insert(RangeWeapons,"Brita.AUG");
	table.insert(RangeWeapons,"Brita.M4");
	table.insert(RangeWeapons,"Brita.M4A1");
	table.insert(RangeWeapons,"Brita.ColtM16");
	table.insert(RangeWeapons,"Brita.M16Tape");
	table.insert(RangeWeapons,"Brita.M16A1");
	table.insert(RangeWeapons,"Brita.M16A2");
	table.insert(RangeWeapons,"Brita.M16A3");
	table.insert(RangeWeapons,"Brita.M40");
	table.insert(RangeWeapons,"Brita.M40A1");
	table.insert(RangeWeapons,"Brita.M40A2");
	table.insert(RangeWeapons,"Brita.M40A3");
	table.insert(RangeWeapons,"Brita.M249");
	table.insert(RangeWeapons,"Brita.M249E3");
	table.insert(RangeWeapons,"Brita.M240");
	table.insert(RangeWeapons,"Brita.G21LMG");
	table.insert(RangeWeapons,"Brita.XM8");
	table.insert(RangeWeapons,"Brita.XM8LMG");
	table.insert(RangeWeapons,"Brita.EX41_HE");
	table.insert(RangeWeapons,"Brita.Federal_HE");
	table.insert(RangeWeapons,"Brita.M32_HE");
end