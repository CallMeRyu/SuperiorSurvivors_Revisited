EatFoodTask = {}
EatFoodTask.__index = EatFoodTask

function EatFoodTask:new(superSurvivor, food)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.parent = superSurvivor
	o.Name = "Eat Food"
	o.Complete = false
	
	if(food ~= nil) then o.TheFood = food
	elseif(superSurvivor:getFood() ~= nil) then o.TheFood = superSurvivor:getFood() 
	else o.Complete=true end
	o.Ticks = 0
	o.EatingStarted = false
	o.OnGoing = false
	o.eatthisMuch = 1.00
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	
	return o

end

function EatFoodTask:isComplete()
	return self.Complete
end
function EatFoodTask:ForbiddenFoods()
	if(self.TheFood) and (self.TheFood:getType() == "Bleach") or (self.TheFood:getType() == "Cigarettes") then
		return true
	else
		return false
	end
end
function EatFoodTask:isValid()
	if not self.parent or self.TheFood == nil then return false 
	else return true end
end

function EatFoodTask:isCanned(thisFood)
	if not thisFood then return false end
	local dtype = thisFood:getType() .. thisFood:getDisplayName() 
	
	if string.match(dtype, "Canned") then return true
	elseif (thisFood:getDisplayName() == "Dog Food") then return true
	else return false end
end

function EatFoodTask:openCanned(thisFood)
	local exceptions = {TinnedBeans = "OpenBeans"}

	if not self:isCanned(thisFood) then return nil end
	local dtype = thisFood:getFullType() .. "Open"
	local openCan = self.parent:Get():getInventory():AddItem(dtype)
	if (openCan ~= nil) then return openCan
	else 
		print("food type\"".. dtype .. "\" Not found")
		return self.parent:Get():getInventory():AddItem("Base.OpenBeans") 
	end
end

function EatFoodTask:update()
	
	if(not self:isValid()) then 
		self.Complete = true
		return false 
	end
	
	if(self:ForbiddenFoods()) then
		self.parent.player:getInventory():Remove(self.TheFood)
		self.TheFood = nil
		self.Complete = true
		return false
	end
	
	if(self.parent:isInAction() == false) then
				
		if(self.EatingStarted == false) and (not self.parent.player:getInventory():contains(self.TheFood)) then
			self.parent:RoleplaySpeak(getActionText("Takes_Before") .. self.TheFood:getDisplayName() .. getActionText("Takes_After"))
			
			self.TheFood = self.parent:ensureInInv(self.TheFood)
			
		elseif(self.EatingStarted == false) and (self.parent.player:getInventory():contains(self.TheFood)) then
			
			local HungerChange = self.TheFood:getHungerChange()
			
			if(HungerChange == 0) and (self:isCanned(self.TheFood)) then
				local openCan = self:openCanned(self.TheFood)
				if(openCan ~= nil) then
					self.parent:RoleplaySpeak(getActionText("Opens_Before")..tostring(self.TheFood:getDisplayName())..getActionText("Opens_After"))
					self.parent.player:getInventory():Remove(self.TheFood)
					self.parent.player:getInventory():DoRemoveItem(self.TheFood)
					self.TheFood = openCan
					HungerChange = self.TheFood:getHungerChange()
				end
			end
			
			if (HungerChange == nil) then HungerChange = 0 end
			local hunger = self.parent.player:getStats():getHunger()
			self.eatthisMuch = 0.25
			if (((HungerChange * 0.25) + hunger) < 0.15)  then self.eatthisMuch = 0.25
			elseif (((HungerChange * 0.50) + hunger) < 0.15) then self.eatthisMuch  = 0.50
			elseif (((HungerChange * 0.75) + hunger) < 0.15) then self.eatthisMuch = 0.75
			else self.eatthisMuch = 1.00 end	
			--print(self.parent:getName() .. " eat " .. tostring(hunger)..","..tostring(HungerChange)..","..tostring(self.eatthisMuch))
		
			self.parent:RoleplaySpeak(getActionText("EatFood_Before") .. self.TheFood:getDisplayName() .. getActionText("EatFood_After"));
			self.parent:DebugSay("EatFoodTask is about to trigger a StopWalk! ")
			self.parent:StopWalk()
			ISTimedActionQueue.add(ISEatFoodAction:new(self.parent.player,self.TheFood,self.eatthisMuch))
			--self.parent.player:getStats():setHunger(self.parent.player:getStats():getHunger() + self.TheFood:getHungChange());
			--self.parent.player:getInventory():Remove(self.TheFood)	
			self.EatingStarted = true
		else
			self.Complete = true
		end
	
	end
	
	if(self.Ticks == nil)	 then self.Ticks = 0 end   -- hack job fix to overcome characters freezing and not performing timed actions
	self.Ticks = self.Ticks + 1
	if(self.Ticks == 10) then
		local playerObj = self.parent:Get()
		if(playerObj.setAnimVariable ~= nil) then
			playerObj:setAnimVariable("FoodType", "can");
			playerObj:setOverrideHandModels(nil, nil);
		end
	--print("startomg force performing stuck first aide task")
	elseif(self.Ticks > 20) then
		--percentage = self.percentage * percentage;
		--self.character:Eat(self.TheFood,self.eatthisMuch)
		self.Complete = true
		self.parent:StopWalk()
		self.Ticks = 0
	end

end
