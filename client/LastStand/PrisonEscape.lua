PrisonEscape = {}

PrisonEscape.Add = function()
	addChallenge(PrisonEscape);
end

PrisonEscape.OnGameStart = function()
    getCore():setZombieGroupSound(false);

--    AddNoiseToken(getPlayer():getCurrentSquare(), 9000);
--    addSound(getPlayer(), getPlayer():getX(), getPlayer():getY(), getPlayer():getZ(), 800, 800);

    local modal = ISModalRichText:new(getCore():getScreenWidth()/2 - 100, getCore():getScreenHeight()/2 - 50, 300, 100, getText("Challenge_PrisonEscapeInfoBox"), false, nil, nil, 0);
    modal:initialise();
    modal:addToUIManager();
    if JoypadState.players[1] then
        JoypadState.players[1].focus = modal
    end

    getGameTime():setTimeOfDay(8.7);

    getPlayer():setDir(IsoDirections.E);

end

PrisonEscape.OnInitWorld = function()
	SandboxVars.Zombies = 3;
--	SandboxVars.Distribution = 1;
--	SandboxVars.DayLength = 3;
--	SandboxVars.StartMonth = 7;
	SandboxVars.StartTime = 9;
	SandboxVars.WaterShutModifier = 14;
	SandboxVars.ElecShutModifier = 14;
	SandboxVars.FoodLoot = 5;
	SandboxVars.WeaponLoot = 5;
	SandboxVars.OtherLoot = 5;
--	SandboxVars.Temperature = 3;
--	SandboxVars.Rain = 3;
	SandboxVars.ErosionSpeed = 2
--	SandboxVars.XpMultiplier = "1.0";
--	SandboxVars.Farming = 3;
--	SandboxVars.NatureAbundance = 5;
--	SandboxVars.PlantResilience = 3;
--	SandboxVars.PlantAbundance = 3;
	SandboxVars.Alarm = 4;
	SandboxVars.LockedHouses = 6;
--	SandboxVars.FoodRotSpeed = 3;
--	SandboxVars.FridgeFactor = 3;
--	SandboxVars.LootRespawn = 1;
--	SandboxVars.StatsDecrease = 3;
--	SandboxVars.StarterKit = false;
--	SandboxVars.TimeSinceApo = 1;
-- SandboxVars.DecayingCorpseHealthImpact = 1
    SandboxVars.MultiHitZombies = false;

	SandboxVars.ZombieConfig.PopulationMultiplier = 2.0

	Events.OnGameStart.Add(PrisonEscape.OnGameStart);
--    Events.OnPlayerUpdate.Add(PrisonEscape.OnPlayerUpdate);
end


--PrisonEscape.OnPlayerUpdate = function()
--end


PrisonEscape.RemovePlayer = function(p)

end

PrisonEscape.AddPlayer = function(p)

end

PrisonEscape.Render = function()
end

PrisonEscape.OnNewGame = function()
    if getCore():getGameMode() == PrisonEscape.gameMode then
        addZombiesInOutfit(7685,11935,1, 1,"Inmate", nil)
    	addZombiesInOutfit(7680,11940,1, 1,"Inmate", nil)
    	addZombiesInOutfit(7644,11866,0, 8,"Inmate", nil)
    	addZombiesInOutfit(7688,11833,0, 2,"Inmate", nil)
    	addZombiesInOutfit(7681,11854,0, 1,"Inmate", nil)
    	addZombiesInOutfit(7695,11854,0, 2,"Inmate", nil)
    	addZombiesInOutfit(7695,11839,0, 1,"Inmate", nil)
    	addZombiesInOutfit(7680,11810,0, 3,"Inmate", nil)
		addZombiesInOutfit(7683,11895,0, 1,"Inmate", nil)
		addZombiesInOutfit(7693,11907,0, 1,"Inmate", nil)
    	addZombiesInOutfit(7690,11793,0, 1,"InmateEscaped", nil)
    	addZombiesInOutfit(7602,11857,0, 2,"InmateEscaped", nil)
    	addZombiesInOutfit(7686,11878,0, 1,"InmateEscaped", nil)
    	addZombiesInOutfit(7639,11851,0, 2,"Chef", nil)
    end
end

PrisonEscape.id = "PrisonEscape";
PrisonEscape.image = "media/lua/client/LastStand/PrisonEscape.png";
PrisonEscape.gameMode = "Prison Escape";
PrisonEscape.world = "Muldraugh, KY";
PrisonEscape.xcell = 25;
PrisonEscape.ycell = 39;
PrisonEscape.x = 180;
PrisonEscape.y = 235;
PrisonEscape.z = 1;

 Events.OnChallengeQuery.Add(PrisonEscape.Add)
 Events.OnNewGame.Add(PrisonEscape.OnNewGame)

