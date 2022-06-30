require "0_Utilities/SuperSurvivorSuitsList"

-- this file has the functions for survivor's suits

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
		print("Rare suit:")
		tempTable = SurvivorRandomSuits["Rare"]
	elseif(roll <= 20) then --  chose normal suit
		print("Normal suit:")
		tempTable = SurvivorRandomSuits["Normal"]
	else --chose common suit
		print("Common suit:")
		tempTable = SurvivorRandomSuits["Common"]
		randomize = false
	end

	--print(tostring(size(tempTable)).." total suits in category.")
    --for key, value in pairs(tempTable) do
	--	print(key)
	--end
	local result = table.randFrom(tempTable)

	while (string.sub(result, -1) == "F" and not SS.player:isFemale()) or (string.sub(result, -1) == "M" and SS.player:isFemale()) do
		print("Wrong gender " .. result .. " (it's only 1993 and KY isn't woke yet)")
		result = table.randFrom(tempTable)
	end
	print("random key result is: "..tostring(result))

	local suitTable = tempTable[result]
	for i=1, #suitTable do
		if(suitTable[i] ~= nil) then
			print("WearThis: " .. tostring(suitTable[i]))
			SS:WearThis(suitTable[i])
		end
	end

	if randomize then
		for i=1, ZombRand(0, 3) do
			tempTable = SurvivorRandomSuits[table.randFrom(SurvivorRandomSuits)]
			local result = table.randFrom(tempTable)
			local suitTable = tempTable[result]
			item = suitTable[ZombRand(1, #suitTable)]
			print("WearThis randomize: " .. item)
			SS:WearThis(item)
		end
	end

end

function setRandomSurvivorSuit(SS,tbl,name)

	local suitTable = SurvivorRandomSuits[tbl][name]
	if suitTable then
		for i=1,#suitTable do
			if(suitTable[i] ~= nil) then
				print("WearThis: " .. tostring(suitTable[i]))
				SS:WearThis(suitTable[i])
			end
		end
	end

end