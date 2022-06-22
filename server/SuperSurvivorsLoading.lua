require "Items/SuburbsDistributions"

if(not SSurvivors) then SSurvivors = {} end


SSurvivors.isModEnabled = function(modname)

	local actmods = getActivatedMods();
	for i=0, actmods:size()-1, 1 do
		if actmods:get(i) == modname then
			return true;
		end
	end
	return false;
end



SSurvivors.getSprites = function()
	getTexture("Item_grave.png");	
	getTexture("Item_gravecross.png");	
	print ("Survivor Mod Sprites Loaded");
end


Events.OnGameBoot.Add(SSurvivors.getSprites);