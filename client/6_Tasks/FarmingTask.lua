FarmingTask = {}
FarmingTask.__index = FarmingTask

function FarmingTask:new(superSurvivor, BringHere)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	o.BringHereSquare = BringHere
	o.parent = superSurvivor
	o.group = superSurvivor:getGroup()
	o.Name = "Farming"
	o.FarmingTaskType = ""
	o.JustHarvested = false
	o.NothingToDoCount = 0
	
	o.Plant = nil
	o.TargetSquare = nil
	o.Complete = false
	
	o.Seeds = {"farming.BroccoliSeed","farming.CabbageSeed","farming.CarrotSeed","farming.PotatoSeed","farming.TomatoSeed","farming.RedRadishSeed"}
	
	
	
	return o

end

function FarmingTask:getShovel()

	local phi = self.parent:Get():getPrimaryHandItem()
	if (not phi) or (phi:getType() ~= "HandShovel") then
		local trowel = self.parent:getBag():FindAndReturn("HandShovel")
		if not trowel then trowel = self.parent:getBag():AddItem("farming.HandShovel") end
		self.parent:Get():setPrimaryHandItem(trowel)
		return trowel
	end
	return phi
end

function FarmingTask:getWater()

	local WaterBottleFull = self.parent:Get():getInventory():FindAndReturn("WaterBottleFull")
	if WaterBottleFull and (math.floor(WaterBottleFull:getUsedDelta() / WaterBottleFull:getUseDelta()) == 0) then
		self.parent:Get():getInventory():Remove(WaterBottleFull)
	end
	if not WaterBottleFull then WaterBottleFull = self.parent:Get():getInventory():AddItem("Base.WaterBottleFull") end
	
	return WaterBottleFull
	
end

function FarmingTask:getSomeSeeds()

	local typeofseedindex = ZombRand(1,#self.Seeds)
	local typeofseed = self.Seeds[typeofseedindex]
	--self.parent:Speak("seed type chosen is:" .. tostring(typeofseed))
	local seeds = {}

	for i=1,12 do
		seeds[i] = self.parent:Get():getInventory():AddItem(typeofseed)
	end
	return seeds
	
end

function FarmingTask:isComplete()
	return self.Complete
end

function FarmingTask:isValid()
	if not self.parent then return false 
	else return true end
end

function FarmingTask:getPlant(sq)

	local plant
	if(CFarmingSystem ~= nil) then
		plant = CFarmingSystem.instance:getLuaObjectOnSquare(sq) 
		--print("CFarmingSystem used")
	else 
		plant = basicFarming.getCurrentPlanting(sq)
		--print("basic farming used")		
	end
	if plant then return plant
	else return nil end

end

function FarmingTask:getNumberOf(thisType)

	if(thisType == "Plants") then
	
		local area = self.group:getGroupArea("FarmingArea")
		local count = 0
		for x=area[1], area[2] do
			for y=area[3], area[4] do
				local sq = getCell():getGridSquare(x,y,area[5])
				if (sq) then
					local plant = self:getPlant(sq)
					if(plant) and (plant.state ~= "plow") then count = count + 1 end
				end
			end
		end
	
	elseif(thisType == "Plows") then
	
		local area = self.group:getGroupArea("FarmingArea")
		local count = 0
		for x=area[1], area[2] do
			for y=area[3], area[4] do
				local sq = getCell():getGridSquare(x,y,area[5])
				if (sq) then
					local plant = self:getPlant(sq)
					if(plant) and (plant.state == "plow") then count = count + 1 end
				end
			end
		end
	else -- either
		
		local area = self.group:getGroupArea("FarmingArea")
		local count = 0
		for x=area[1], area[2] do
			for y=area[3], area[4] do
				local sq = getCell():getGridSquare(x,y,area[5])
				if (sq) then
					local plant = self:getPlant(sq)
					if(plant) then count = count + 1 end
				end
			end
		end
	end

end

function FarmingTask:getASquareToPlow()

	local area = self.group:getGroupArea("FarmingArea")

	for x=area[1], area[2] do
		for y=area[3], area[4] do
			local sq = getCell():getGridSquare(x,y,area[5])
			if (sq) and (sq:isFree(false)) and (x % 2 == 0) and (y % 2 ~= 0) then
				local plant = self:getPlant(sq)
				print(tostring(plant))
				if(plant == nil) then return sq end
			end
		end
	end
	
	return nil

end

function FarmingTask:getAPlantThatNeeds(needs)
	

	
	local area = self.group:getGroupArea("FarmingArea")

	if needs == "Watering" then
	
		for x=area[1], area[2] do
			for y=area[3], area[4] do
				local sq = getCell():getGridSquare(x,y,area[5])
				if (sq) then
					local plant = self:getPlant(sq)
					if(plant) 
						and (plant.state == "seeded")
						and (plant.waterNeeded > 0)
						and (plant.waterLvl < 100)
						and (plant.typeOfSeed ~= "Carrots")
						and (plant.typeOfSeed ~= "RedRadish")
					then 
						return plant 
					end
				end
			end
		end
		
	elseif (needs == "Harvesting") and (self.parent:getGroupRole() == "Farmer") then -- only harvest if specifically commanded
	
		for x=area[1], area[2] do
			for y=area[3], area[4] do
				local sq = getCell():getGridSquare(x,y,area[5])
				if (sq) then
					local plant = self:getPlant(sq)
					if(plant) and (plant:canHarvest()) then return plant end
				end
			end
		end
		
	elseif needs == "Plowing" then
	
		for x=area[1], area[2] do
			for y=area[3], area[4] do
				local sq = getCell():getGridSquare(x,y,area[5])
				if (sq) then
					local plant = self:getPlant(sq)
					if(plant) and (plant:isAlive() == false) then 
						print("returning "..tostring(plant))
						return plant 
					end
				end
			end
		end
		
	elseif (needs == "Planting") and (self.parent:getGroupRole() == "Farmer") then
	
		for x=area[1], area[2] do
			for y=area[3], area[4] do
				local sq = getCell():getGridSquare(x,y,area[5])
				if (sq) then
					local plant = self:getPlant(sq)
					
					if(plant) and (plant.typeOfSeed == "none") then return plant end
				end
			end
		end
		
	end
	
	return nil

end

function FarmingTask:AreWeThereYet(plant)

	local distance = getDistanceBetween(plant,self.parent.player)
	if(distance > 2.0) then
		self.parent:walkTo(plant)
		return false
	else
		return true
	end

end

function FarmingTask:ClearVars()

	self.Plant = nil
	self.TargetSquare = nil
	self.FarmingTaskType = ""
	self.NothingToDoCount = 0

end

function FarmingTask:update()

	if(not self:isValid()) then return false end
	if(not self.group) then self.group = self.parent:getGroup() end
	
	
	if(self.group:getGroupAreaCenterSquare("FarmingArea") == nil) then
		self.parent:Speak(getText("ContextMenu_speech_NoFarmingArea"))
		self.Complete = true
		return nil
	end
	
	
	if(self.parent:isInAction() == false) then
	
		if(self.JustHarvested) then -- go store crops
			--self.parent:Speak("going to harvested goods")
			local storagecontainer = self.group:getGroupAreaContainer("FoodStorageArea")
			local dest 
			if(storagecontainer) then
				print("Harvest - Found food storage container")
				dest = storagecontainer
			else
				dest = self.group:getGroupAreaCenterSquare("FoodStorageArea")
				if dest ~= nil then
					print("Harvest - Found center square")
				end
			end
			if(not dest) then
				dest = self.parent.player:getCurrentSquare()
				print("Harvest - Drop at current")
			end
			self.JustHarvested = false
			--self.parent:Speak("is a container?"..tostring(dest.getContainer ~= nil))
			self.parent:getTaskManager():AddToTop(CleanInvTask:new(self.parent,dest,false))
			return true
		end
	
				
		if (self.Plant == nil) then 
			self.Plant = self:getAPlantThatNeeds("Watering") 
			self.FarmingTaskType = "Watering"
		end
		if (self.Plant ~= nil) and (self.FarmingTaskType == "Watering") then
			if(self:AreWeThereYet(self.Plant:getSquare())) then
				
				local item = self:getWater()
				if(item and item:isWaterSource()) then
					local plantType = self.Plant.typeOfSeed
					print("water " .. plantType)
					if(self.parent:isSpeaking() == false) then 
						self.parent:RoleplaySpeak(getText("ContextMenu_speech_FarmingActionWatering")) 
					end
					self.parent:StopWalk()
					ISTimedActionQueue.add(ISWaterPlantAction:new(self.parent:Get(), item, 1, self.Plant:getSquare(), 20))
					self:ClearVars()
				else
					--self.parent:Speak("no water")
				end
			end
			return true
		end
		
		if (self.Plant == nil) then 
			self.Plant = self:getAPlantThatNeeds("Harvesting") 
			self.FarmingTaskType = "Harvesting"
		end
		if (self.Plant ~= nil) and (self.FarmingTaskType == "Harvesting") then
			if(self:AreWeThereYet(self.Plant:getSquare())) then
				local plantType = self.Plant.typeOfSeed
				self.parent:RoleplaySpeak(getText("ContextMenu_speech_FarmingActionHarvesting"))
				self.JustHarvested = true
				self.parent:StopWalk()
				print("harvest " .. plantType)
				ISTimedActionQueue.add(ISHarvestPlantAction:new(self.parent:Get(), self.Plant, 50))
				-- then replow
				print("plow")		
				self.TargetSquare = self.Plant:getSquare()
				ISTimedActionQueue.add(ISPlowAction:new (self.parent:Get(), self.TargetSquare, self:getShovel(), 50))
				-- TODO: then replant same plant
				print("plant")
				local typeOfSeed = "PotatoSeed"
				if plantType == "Broccoli" then typeOfSeed = "BroccoliSeed"
				elseif plantType == "Tomato" then typeOfSeed = "TomatoSeed"
				elseif plantType == "Potatoes" then typeOfSeed = "PotatoSeed"
				elseif plantType == "RedRadish" then typeOfSeed = "RedRadishSeed"
				else typeOfSeed = plantType:gsub('s', 'Seed') end
				print("planting " .. typeOfSeed)
				local seeds = {}
				for i=1,12 do
					seeds[i] = self.parent:Get():getInventory():AddItem("farming." .. typeOfSeed)
				end
				ISTimedActionQueue.add(ISSeedAction:new(self.parent:Get(), seeds, #seeds, plantType, self.Plant, 200))
				self:ClearVars()
			end
			return true
		end
		
		if (self.Plant == nil) then 
			self.Plant = self:getAPlantThatNeeds("Plowing") 
			self.FarmingTaskType = "Plowing"
		end
		if (self.Plant ~= nil) and (self.FarmingTaskType == "Plowing") then			
			self.TargetSquare = self.Plant:getSquare()
			if(self:AreWeThereYet(self.Plant:getSquare())) then
				--self.parent:Speak("plowing square")
				self.parent:StopWalk()
				ISTimedActionQueue.add(ISPlowAction:new (self.parent:Get(), self.TargetSquare, self:getShovel(), 150))
				self:ClearVars()
			end
			return true
		end
		
		if (self.Plant == nil) then 
			self.Plant = self:getAPlantThatNeeds("Planting") 
			self.FarmingTaskType = "Planting"
		end
		if (self.Plant ~= nil) and (self.FarmingTaskType == "Planting") then
			if(self:AreWeThereYet(self.Plant:getSquare())) then
				self.parent:RoleplaySpeak(getText("ContextMenu_speech_FarmingActionPlanting"))
				local seeds = self:getSomeSeeds()
				 --print(""..nil)
				if(seeds) and (#seeds > 0) then
					local plantType = tostring(seeds[1]:getType())
					if(plantType == "TomatoSeed") then plantType = "Tomato"
					elseif(plantType == "BroccoliSeed") then plantType = "Broccoli"
					elseif(plantType == "PotatoSeed") then plantType = "Potatoes"
					elseif(plantType == "RedRadishSeed") then plantType = "RedRadish"
					else plantType = plantType:gsub('Seed', 's') end
					self.parent:StopWalk()
					ISTimedActionQueue.add(ISSeedAction:new(self.parent:Get(), seeds, #seeds, plantType, self.Plant, 200))
					self:ClearVars()
				end
			end
			return true
		end
		
		-- if (not self.TargetSquare) then 
		-- 	self.TargetSquare = self:getASquareToPlow() 
		-- 	self.FarmingTaskType = "Plowing"
		-- end
		-- if(self.TargetSquare) and (self.FarmingTaskType == "Plowing") then
		
		-- 	--self.parent:Speak("should plowing new square")
		-- 	if(self:AreWeThereYet(self.TargetSquare)) then
		-- 		--self.parent:Speak("plowing new square")
		-- 		self.parent:StopWalk()
		-- 		ISTimedActionQueue.add(ISPlowAction:new (self.parent:Get(), self.TargetSquare, self:getShovel(), 150))
		-- 		self:ClearVars()				
		-- 	end
		-- 	return true
		-- end
		
		--self.parent:Speak("there was nothing to do: "..tostring(self.FarmingTaskType)..","..tostring(self.TargetSquare == nil)..","..tostring(self.Plant == nil))
		
		self.Plant = nil
		self.TargetSquare = nil
		self.FarmingTaskType = ""
		self.NothingToDoCount = self.NothingToDoCount + 1
		
		if(self.NothingToDoCount > 5) then
			self:ClearVars()
			--self.parent:Speak(getText("ContextMenu_SD_IGoRelax") .. " (farmer)")
			--local TaskMangerIn = self.parent:getTaskManager()
			--TaskMangerIn:setTaskUpdateLimit(300)
			--TaskMangerIn:AddToTop(WanderInBaseTask:new(self.parent))			
			self.Complete = true
			return nil
		end
		
	else 
		--self.parent:Speak("waiting for non action");
	end

end