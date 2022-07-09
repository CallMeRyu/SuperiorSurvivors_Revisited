require "0_Utilities/SuperSurvivorSuitsList"
-- this file has the functions for survivor's suits

local enableDebugSuits = false

local function debugSuits(text)
	if enableDebugSuits then
		print(text)
	end
end

--- Gets a random outfit for a survivor
---@param SS any survivor that will wear the outfit
function getRandomSurvivorSuit(SS)
	debugSuits(" ----- getRandomSurvivorSuit -----")

	local roll = ZombRand(0,101)
	local tempTable = nil
	local randomize = false
	debugSuits("roll : " .. tostring(roll))

	if(roll == 1) then -- choose legendary suit
		debugSuits("Legendary suit:")
		tempTable = SurvivorRandomSuits["Legendary"]
	elseif(roll <= 5) then -- choose veryrare suit
		debugSuits("VeryRare suit:")
		tempTable = SurvivorRandomSuits["VeryRare"]
	elseif(roll <= 15) then -- choose rare suit
		debugSuits("Rare suit:")
		tempTable = SurvivorRandomSuits["Rare"]
	elseif(roll <= 25) then -- chose normal suit
		debugSuits("Normal suit:")
		tempTable = SurvivorRandomSuits["Normal"]
	elseif(roll <= 40) then -- chose uncommon suit
		debugSuits("Uncommon suit:")
		tempTable = SurvivorRandomSuits["Uncommon"]
	else -- chose common suit
		debugSuits("Common suit:")
		tempTable = SurvivorRandomSuits["Common"]
		randomize = false
	end

	local result = table.randFrom(tempTable)

	while (string.sub(result, -1) == "F" and not SS.player:isFemale()) or (string.sub(result, -1) == "M" and SS.player:isFemale()) do
		debugSuits("Wrong gender " .. result .. " (it's only 1993 and KY isn't woke yet)")
		result = table.randFrom(tempTable)
	end
	debugSuits("random key result is: "..tostring(result))

	local suitTable = tempTable[result]
	for i=1, #suitTable do
		if(suitTable[i] ~= nil) then
			debugSuits("WearThis: " .. tostring(suitTable[i]))
			SS:WearThis(suitTable[i])
		end
	end

	if randomize then
		for i=1, ZombRand(0, 3) do
			tempTable = SurvivorRandomSuits[table.randFrom(SurvivorRandomSuits)]
			local result = table.randFrom(tempTable)
			local suitTable = tempTable[result]
			item = suitTable[ZombRand(1, #suitTable)]
			debugSuits("WearThis randomize: " .. item)
			SS:WearThis(item)
		end
	end

	debugSuits(" ----- getRandomSurvivorSuit -----")
end

---@alias rarity
---| "Common"
---| "Uncommon"
---| "Normal"
---| "Rare"
---| "VeryRare"
---| "Legendary"

--- sets an outfit for a survivor given if table and outfit found 
---@param SS any
---@param tbl rarity table name to be searched
---@param name string outfit name
function setRandomSurvivorSuit(SS,tbl,name)

	local suitTable = SurvivorRandomSuits[tbl][name]
	if suitTable then
		for i=1,#suitTable do
			if(suitTable[i] ~= nil) then
				debugSuits("WearThis: " .. tostring(suitTable[i]))
				SS:WearThis(suitTable[i])
			end
		end
	end

end