--this file has methods related to looting

--- DEBUG ---
local enableDebugLoot = false

local function debugLoot(text)
	if enableDebugLoot then
		print(text)
	end
end

local function debugMethodName(methodName)
	if enableDebugLoot then
		print(" ----- " ..  methodName .. " ----- ")
	end
end

local function debugItemsFound(count)
	if enableDebugLoot then
		print(tostring(count) .. " items found")
	end
end

local function debugItemNotFound(category)
	if enableDebugLoot then
		print(category .. " not found")
	end
end

local function debugEmptyContainer()
	if enableDebugLoot then
		print("container is empty")
	end
end

local function debugItem(category,itemName, value)
	if enableDebugLoot then
		print(category .. " : " .. tostring(itemName) .. " - " .. tostring(value))
	end
end

local function debugFoodScore(bullet ,change ,score)
	if enableDebugLoot then
		print("\t" .. bullet .. " " .. change .. " score : " .. tostring(score))
	end
end
--- END DEBUG ---

--- CATEGORIES ---

---@alias itemCategory
---| "Food"
---| "Water"
---| "Weapon"

--- finds the item inside of a 'container' based on the 'category'
---@param container any the container that the item will be searched
---@param category itemCategory the type of item that the item will be searched
---@param survivor any survivor searching for item (only in food searching)
---@return any returns the item insde of the container with the selected category or nil if not found
function FindItemByCategory(container, category, survivor)

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

--- checks if the 'item' belongs to the 'category'
---@param item any
---@param category itemCategory category to be checked
---@return boolean returns true if the item belongs to the category
function hasCategory(item,category)

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
--- gets a weapon inside of a 'container'
---@param container any container to be searched
---@return any returns the first weapon inside the container or nil if not found
function FindAndReturnWeapon(container)
	if(not container) then 
    return nil 
  end

	debugMethodName("FindAndReturnWeapon")
	local items = container:getItems()
	
	if(items ~= nil) and (items:size() > 0) then

		local count = items:size()
		debugItemsFound(count)

		for i=1, count-1 do
			local item = items:get(i)
			if(item ~= nil) and (item:getCategory() == "Weapon") and (item:getMaxDamage() > 0.1) then
				debugItem("weapon",item:getDisplayName(),item:getMaxDamage())
				return item
			end
		end
	else
		debugEmptyContainer()
	end
	
	debugItemNotFound("weapon")
	debugMethodName("FindAndReturnWeapon")

	return nil
end

--- gets the best weapon inside of a 'container'
---@param container any container to be searched
---@return any returns the best weapon inside the container or nil if not found
function FindAndReturnBestWeapon(container)
	
	if(container == nil) then 
    return nil 
  end

	debugMethodName("FindAndReturnBestWeapon")

	local items = container:getItems()
	local bestItem = nil

	if(items ~= nil) and (items:size() > 0) then
		local itemSize = items:size()
		debugItemsFound(itemSize)

		for i=1, itemSize-1 do
			local item = items:get(i)
			if(item ~= nil) and (item:getCategory() == "Weapon") then
				if (item:getMaxDamage() > 0.1) and (bestItem == nil or bestItem:getMaxDamage() < item:getMaxDamage()) then 

					bestItem = item 
					debugItem("best weapon",bestItem:getDisplayName(),bestItem:getMaxDamage())

				end
			end
		end

	else
		debugEmptyContainer()
	end

	if (bestItem ~= nil) then
		debugItem("best weapon",bestItem:getDisplayName(),bestItem:getMaxDamage())
	else
		debugItemNotFound("weapon")
	end

	debugMethodName("FindAndReturnBestWeapon")

	return bestItem
end
--- END WEAPONS ---

--- FOODS ---

local FoodsToExlude = {"Bleach", "Cigarettes", "HCCigar", "Antibiotics", "Teabag2", "Salt", "Pepper", "EggCarton"}

--- gets any kind of food that is not in 'FoodsToExlude' and not poisoned
---@param thisItemContainer any 
---@return any returns the first found food inside the container
function FindAndReturnFood(thisItemContainer)
	if(not thisItemContainer) then 
    return nil 
  end

	debugMethodName("FindAndReturnFood")
	local items = thisItemContainer:getItems()

	if(items ~= nil) and (items:size() > 0) then
		local count = items:size()
		debugItemsFound(count)

		for i=1, count-1 do
			local item = items:get(i)
			if(item ~= nil) and (item:getCategory() == "Food") then			
				if not( item:getPoisonPower() > 1 ) and not (has_value(FoodsToExlude,item:getType())) then 
					debugItem("food",item:getDisplayName(),"")
					return item 
				end
			end
		end
	else
		debugEmptyContainer()
	end

	debugItemNotFound()
	debugMethodName("FindAndReturnFood")

	return nil
end

--- gets the score of the food based on status changes 
---@param item any any food item
---@return number returns the score of the food
function GetFoodScore(item)-- TODO: improve food searching (and the logging)
	debugMethodName("GetFoodScore")
	debugLoot("food : " .. item:getDisplayName())
	debugLoot("hunger change : " .. item:getHungerChange())

	local score = 1.0

	if(item:getUnhappyChange() > 0) then
		score = score - math.floor(item:getUnhappyChange() / (item:getHungerChange() * -10.0))
		debugFoodScore("-", "unhappy", score)
	elseif(item:getUnhappyChange() < 0) then
		score = score + 1
		debugFoodScore("+", "happy", score)
	end

	if(item:getBoredomChange() > 0) then
		score = score - math.floor(item:getBoredomChange() / (item:getHungerChange() * -10.0) / 2.0)
		debugFoodScore("-", "bored", score)
	elseif(item:getBoredomChange() < 0) then
		score = score + 1
		debugFoodScore("+", "unbored", score)
	end

	if(item:isFresh()) then
		score = score + 2
		debugFoodScore("+", "fresh", score)
	elseif(item:IsRotten()) then
		score = score - 10
		debugFoodScore("-", "rotten", score)
	end

	if(item:isAlcoholic()) then
		score = score - 5
		debugFoodScore("-", "alcoholic", score)
	end
	if(item:isSpice()) then
		score = score - 5
		debugFoodScore("-", "spice", score)
	end

	if(item:isbDangerousUncooked()) and not (item:isCooked()) then
		score = score - 10
		debugFoodScore("-", "raw", score)
	end
	--if(item:isBurnt()) then Score = Score - 1 end

	local foodType = item:getFoodType()
	if (foodType == "NoExplicit") or (foodType == nil) then
		-- save the canned food
		if string.match(item:getDisplayName(), "Open") then 
      score = score + 3
			debugFoodScore("-", "open canned", score)
		elseif string.match(item:getDisplayName(), "Canned") then 
      score = score - 5
			debugFoodScore("-", "canned", score)
		elseif (item:getDisplayName() == "Dog Food") then 
      score = score - 10
			debugFoodScore("-", "dog food", score)
		elseif (item:getHungerChange()) == nil or (item:getHungerChange() == 0) then 
      score = -9999 
			debugFoodScore("-", "unknown", score)
    end -- unidentified, probably canned from a mod

	  if(item:isCooked()) then 
      score = score + 5 
			debugFoodScore("+", "cooked", score)
    end

  elseif (foodType == "Fruits") or (foodType == "Vegetables") then
    score = score + 1
		debugFoodScore("+", "produce", score)
  elseif (foodType == "Pasta") or (foodType == "Rice") then
    score = score - 2
		debugFoodScore("+", "dry goods", score)
  elseif ((foodType == "Egg") or (foodType == "Meat")) or item:isIsCookable() then
		debugFoodScore("+", "meat ", score)
    if (item:isCooked()) then
      score = score + 2
			debugFoodScore("+", "cooked", score)
		end
  elseif (foodType == "Coffee") then
    score = score - 5
		debugFoodScore("-", "coffee", score)
  else
		debugFoodScore("-", "unknown", score)
  end

	debugMethodName("GetFoodScore")
	return score
end

--- gets the best food in the current square of the 'survivor'
---@param sq any
---@param survivor any 
---@return any returns the best food on the ground based on a score system
function FindAndReturnBestFoodOnFloor(sq, survivor)
	if(not sq) then 
    return nil 
  end
	local bestFood = nil
	local bestScore = 1
	debugMethodName("FindAndReturnBestFoodOnFloor")

	if (survivor == nil) or (survivor:isStarving()) then
		-- if starving, willing to eat anything
		bestScore = -999
	elseif (survivor:isVHungry()) then
		-- not too picky, eat stale food
		bestScore = -10
	end

	local items = sq:getWorldObjects()
	local count = items:size()

	if count > 0 then
		debugItemsFound(count)

		for j=0, count-1 do
			local item =items:get(j):getItem()
			if (item ~= nil) and (item:getCategory() == "Food") and not (item:getPoisonPower() > 1) and (not has_value(FoodsToExlude, item:getType())) then
				local Score = GetFoodScore(item)

				if Score > bestScore then
					bestFood = item
					bestScore = Score
					debugItem("best food", bestFood:getDisplayName(), tostring(bestScore))
				end

			end
		end

	else
		debugEmptyContainer()
	end

	debugMethodName("FindAndReturnBestFoodOnFloor")

	return bestFood
end

--- gets the best food in a container next to the 'survivor'
---@param thisItemContainer any
---@param survivor any 
---@return any returns the best food based on a score system
function FindAndReturnBestFood(thisItemContainer, survivor)
	if(not thisItemContainer) then 
    return nil 
  end
  
	local items = thisItemContainer:getItems()
	local ID = -1

	local bestFood = nil
	local bestScore = 1

	if (survivor == nil) or (survivor:isStarving()) then
		bestScore = -999
	elseif (survivor:isVHungry()) then
		bestScore = -10
	end
	
	debugMethodName("FindAndReturnBestFood")

	if(items ~= nil) and (items:size() > 0) then
		local count = items:size()
		debugItemsFound(count)
		for i=1, count-1 do
			local item = items:get(i)
			if(item ~= nil) and (item:getCategory() == "Food") and not (item:getPoisonPower() > 1) and (not has_value(FoodsToExlude, item:getType())) then
				local Score = GetFoodScore(item)

				--ContainerItemsScore[i] = Score
				if Score > bestScore then
					bestFood = item
					bestScore = Score
					debugItem("best food", bestFood:getDisplayName(), bestScore)
				end
			end
		end
	else
		debugEmptyContainer()
	end

	debugMethodName("FindAndReturnBestFood")

	return bestFood
end

--- END FOOD ---

--- WATER ---

--- gets any water inside of 'container'
---@param container any 
---@return any returns the first water found
function FindAndReturnWater(container) 
	if(not container) then 
    return nil 
  end

	local items = container:getItems()
	debugMethodName("FindAndReturnBestFood")

	if(items ~= nil) and (items:size() > 0) then
		local count = items:size()
		debugItemsFound(count)
		for i=1, count-1 do
			local item = items:get(i)
			if(item ~= nil) and isItemWater(item) then 
				debugLoot("water found")
        return item 
      end
		end
	else
		debugEmptyContainer()
	end

	debugItemNotFound("water")
	debugMethodName("FindAndReturnBestFood")
	return nil
end

--- checks if 'item' is a water source
---@param item any 
---@return boolean return true if the current it is a water source (and is not Bleach)
function isItemWater(item)
	return ((item:isWaterSource()) and (item:getType() ~= "Bleach"))
end

--- END WATER ---
