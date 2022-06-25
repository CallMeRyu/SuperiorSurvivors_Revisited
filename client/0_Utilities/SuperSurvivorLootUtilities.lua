--this file has methods related to looting

--- CATEGORIES ---

-- finds the best item inside of a 'container' based on the 'category'
function MyFindAndReturnCategory(container, category, survivor)

	if(category == "Food") then 
    return FindAndReturnBestFood(container, survivor)
	elseif(category == "Water") then 
    return FindAndReturnWater(container)
	elseif(category == "Weapon") then 
    return FindAndReturnWeapon(container)
	else 
    return container:FindAndReturnCategory(category) 
  end

end

-- checks if the 'item' belongs to the 'category'
function myIsCategory(item,category)

	if(category == "Water") and (isItemWater(item)) then 
    return true
	elseif(category == "Weapon") and (item:getCategory() == category) and (item:getMaxDamage() > 0.1) then 
    return true
	else 
    return (item:getCategory() == category) 
  end

end

--- END CATEGORIES ---

--- WEAPONS ---
-- gets a weapon inside of a 'container'
function FindAndReturnWeapon(container) -- exlude crap weapons
	if(not container) then 
    return nil 
  end
	local items = container:getItems()

	if(items ~= nil) and (items:size() > 0) then
		for i=1, items:size()-1 do
			local item = items:get(i)
			if(item ~= nil) and (item:getCategory() == "Weapon") and (item:getMaxDamage() > 0.1) then
				--print("FindAndReturnWeapon " .. item:getDisplayName() .. " - " .. tostring(item:getMaxDamage()))
				return item
			end
		end
	end
	return nil
end

-- gets the best weapon inside of a 'container'
function FindAndReturnBestWeapon(container) -- exlude crap weapons
	if(not container) then 
    return nil 
  end
	local items = container:getItems()
	local bestItem = nil

	if(items ~= nil) and (items:size() > 0) then
		for i=1, items:size()-1 do
			local item = items:get(i)
			if(item ~= nil) and (item:getCategory() == "Weapon") and (item:getMaxDamage() > 0.1) and (bestItem == nil or bestItem:getMaxDamage() < item:getMaxDamage()) then 
        bestItem = item 
      end
		end
	end
	if (bestItem ~= nil) then
		--print("FindAndReturnBestWeapon " .. tostring(bestItem:getDisplayName()) .. " - " .. tostring(bestItem:getMaxDamage()))
	end
	return bestItem
end
--- END WEAPONS ---

FoodsToExlude = {"Bleach", "Cigarettes", "HCCigar", "Antibiotics", "Teabag2", "Salt", "Pepper", "EggCarton"}
-- gets any kind of food that is not in 'FoodsToExlude' and not poisoned
function FindAndReturnFood(thisItemContainer)
	if(not thisItemContainer) then 
    return nil 
  end
	local items = thisItemContainer:getItems()

	if(items ~= nil) and (items:size() > 0) then
		for i=1, items:size()-1 do
			local item = items:get(i)
			if(item ~= nil) and (item:getCategory() == "Food") and not (item:getPoisonPower() > 1) and (not has_value(FoodsToExlude,item:getType())) then 
        return item 
      end
		end
	end
	return nil
end

-- gets the score of the food based on status changes 
function GetFoodScore(item)-- TODO: improve food searching
	--print("Analyze " .. item:getDisplayName())
	local Score = 1.0

	if(item:getUnhappyChange() > 0) then
		Score = Score - math.floor(item:getUnhappyChange() / (item:getHungerChange() * -10.0))
		--print("-unhappy "..Score..","..tostring(item:getUnhappyChange())..","..tostring(0 - item:getHungerChange()))
	elseif(item:getUnhappyChange() < 0) then
		Score = Score + 1
		--print("-happy")
	end

	if(item:getBoredomChange() > 0) then
		Score = Score - math.floor(item:getBoredomChange() / (item:getHungerChange() * -10.0) / 2.0)
		--print("-bored")
	elseif(item:getBoredomChange() < 0) then
		Score = Score + 1
		--print("-unbored")
	end

	if(item:isFresh()) then
		Score = Score + 2
		--print("-fresh")
	elseif(item:IsRotten()) then
		Score = Score - 10
		--print("-rotten")
	end

	if(item:isAlcoholic()) then
		Score = Score - 5
		--print("-alcoholic")
	end
	if(item:isSpice()) then
		Score = Score - 5
		--print("-spice")
	end

	if(item:isbDangerousUncooked()) and not (item:isCooked()) then
		Score = Score - 10
		--print("-dont eat it mary, its raw")
	end
	--if(item:isBurnt()) then Score = Score - 1 end

	local FoodType = item:getFoodType()
	if (FoodType == "NoExplicit") or (FoodType == nil) or (tostring(FoodType) == "nil") then
		--print("-notype")
		-- save the canned food
		if string.match(item:getDisplayName(), "Open") then 
      Score = Score + 3
		elseif string.match(item:getDisplayName(), "Canned") then 
      Score = Score - 5
		elseif (item:getDisplayName() == "Dog Food") then 
      Score = Score - 10
		elseif (item:getHungerChange()) == nil or (item:getHungerChange() == 0) then 
      Score = -9999 
    end -- unidentified, probably canned from a mod

	  if(item:isCooked()) then 
      Score = Score + 5 
    end

  elseif (FoodType == "Fruits") or (FoodType == "Vegetables") then
    --print("-produce")
    Score = Score + 1
  elseif (FoodType == "Pasta") or (FoodType == "Rice") then
    --print("-drygoods")
    Score = Score - 2
  elseif ((FoodType == "Egg") or (FoodType == "Meat")) or item:isIsCookable() then
    --print("-meat")
    if (item:isCooked()) then
      Score = Score + 2
    end
  elseif (FoodType == "Coffee") then
    --print("-coffee")
    Score = Score - 5
  else
    --print("Unknown food type " .. FoodType)
  end

	return Score
end

-- gets the best food in the current square of the 'survivor'
function FindAndReturnBestFoodOnFloor(sq, survivor)
	if(not sq) then 
    return nil 
  end
	local BestFood = nil
	local BestScore = 1

	if (survivor == nil) or (survivor:isStarving()) then
		-- if starving, willing to eat anything
		BestScore = -999
	elseif (survivor:isVHungry()) then
		-- not too picky, eat stale food
		BestScore = -10
	end

	items = sq:getWorldObjects()
	--print("Checking " .. tostring(items:size()) .. " world objects.")
	for j=0, items:size()-1 do
		if(items:get(j):getItem()) then
			local item = items:get(j):getItem()
			if(item ~= nil) and (item:getCategory() == "Food") and not (item:getPoisonPower() > 1) and (not has_value(FoodsToExlude, item:getType())) then
				local Score = GetFoodScore(item)

				--ContainerItemsScore[i] = Score
				--print("BestFood Floor " .. item:getDisplayName() .. ": " .. tostring(Score))
				if Score > BestScore then
					BestFood = item
					BestScore = Score
				end
			end
		end
	end
	return BestFood
end

-- gets the best food in a container next to the 'survivor'
function FindAndReturnBestFood(thisItemContainer, survivor)
	if(not thisItemContainer) then 
    return nil 
  end
  
	local items = thisItemContainer:getItems()
	local ID = -1
	local BestFood = nil
	--local ContainerItemsScore = {}
	local BestScore = 1

	if (survivor == nil) or (survivor:isStarving()) then
		-- if starving, willing to eat anything
		BestScore = -999
	elseif (survivor:isVHungry()) then
		-- not too picky, eat stale food
		BestScore = -10
	end

	if(items ~= nil) and (items:size() > 0) then
		for i=1, items:size()-1 do
			local item = items:get(i)
			if(item ~= nil) and (item:getCategory() == "Food") and not (item:getPoisonPower() > 1) and (not has_value(FoodsToExlude, item:getType())) then
				local Score = GetFoodScore(item)

				--ContainerItemsScore[i] = Score
				--print("BestFood " .. item:getDisplayName() .. ": " .. tostring(Score))
				if Score > BestScore then
					BestFood = item
					BestScore = Score
				end
			end
		end

		-- loop done sort top down
		--local highestSoFar = 0
		--for k,v in pairs(ContainerItemsScore) do
		--	if(v > highestSoFar) then
		--		ID = k
		--		highestSoFar = v
		--	end
		--end
		--if(ID ~= -1) then BestFood = items:get(ID) end

	end

	if (BestFood ~= nil) then
		--print("BestFood Winner " .. tostring(BestFood:getDisplayName()) .. ": " .. tostring(BestScore))
	end
	return BestFood
end

--- WATER ---

-- gets any water inside of 'container'
function FindAndReturnWater(container) -- exlude bleach
	if(not container) then 
    return nil 
  end

	local items = container:getItems()

	if(items ~= nil) and (items:size() > 0) then
		for i=1, items:size()-1 do
			local item = items:get(i)
			if(item ~= nil) and isItemWater(item) then 
        return item 
      end
		end
	end

	return nil
end

-- checks if 'item' is a water source
function isItemWater(item)
	return ((item:isWaterSource()) and (item:getType() ~= "Bleach"))
end

--- END WATER ---
