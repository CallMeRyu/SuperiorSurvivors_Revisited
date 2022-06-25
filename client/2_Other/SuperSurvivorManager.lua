SuperSurvivorManager = {}
SuperSurvivorManager.__index = SuperSurvivorManager

function SuperSurvivorManager:new()

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.SuperSurvivors = {}
	o.SurvivorCount = 3
	o.MainPlayer = 0
	
	return o

end

function SuperSurvivorManager:getRealPlayerID()
	return self.MainPlayer
end

function SuperSurvivorManager:init()
	self.SuperSurvivors[0] = SuperSurvivor:newSet(getSpecificPlayer(0))
	self.SuperSurvivors[0]:setID(0)
end
function SuperSurvivorManager:setPlayer(player,ID)
	self.SuperSurvivors[ID] = SuperSurvivor:newSet(player)
	self.SuperSurvivors[0]:setID(ID)
	self.SuperSurvivors[0]:setName("Player " .. tostring(ID))
	
	return self.SuperSurvivors[ID] ;
end

function SuperSurvivorManager:switchPlayer(newID)
	
	self.SuperSurvivors[newID].player:setBlockMovement(false)
	self.SuperSurvivors[newID].player:setNPC(false)
		
	self.SuperSurvivors[self.MainPlayer].player:setBlockMovement(true)
	self.SuperSurvivors[self.MainPlayer].player:setNPC(true)
		
	IsoPlayer.setInstance(self.SuperSurvivors[newID].player)
	IsoPlayer.setLocalPlayer(0,self.SuperSurvivors[newID].player)
	
	self.MainPlayer = newID
	
	getSpecificPlayer(0):initSpritePartsEmpty();
	getPlayerData(0).playerInventory:refreshBackpacks();
	
end

function SuperSurvivorManager:LoadSurvivor(ID, square)

	if( not checkSaveFileExists("Survivor"..tostring(ID))) then return false end
	
	if(ID ~= nil) and (square ~= nil) then -- 
		
		if(self.SuperSurvivors[ID] ~= nil) and (self.SuperSurvivors[ID].player ~= nil) then		
			if(self.SuperSurvivors[ID]:isInCell()) then
				return false
			else		
				self.SuperSurvivors[ID]:delete()
			end
		end
		print("loading survivor ".. tostring(ID) .." on " .. tostring(square:getX()) .. "," .. tostring(square:getY()))
		
				
			self.SuperSurvivors[ID] = SuperSurvivor:newLoad(ID,square)
			if(self.SuperSurvivors[ID]:Get():getPrimaryHandItem() == nil) and (self.SuperSurvivors[ID]:getWeapon() ~= nil) then self.SuperSurvivors[ID]:Get():setPrimaryHandItem(self.SuperSurvivors[ID]:getWeapon()) end
			self.SuperSurvivors[ID]:refreshName()
		
		
		
		if(self.SuperSurvivors[ID]:Get():getModData().isHostile == true) then self.SuperSurvivors[ID]:setHostile(true) end
		
		if(self.SurvivorCount == nil) then self.SurvivorCount = 1 end
		--print(tostring(ID))
		--print(tostring(self.SurvivorCount))
		
		if(ID > self.SurvivorCount) then self.SurvivorCount = ID end
		self.SuperSurvivors[ID].player:getModData().LastSquareSaveX = nil
		self.SuperSurvivors[ID]:SaveSurvivor()
		
		
		local melewep = self.SuperSurvivors[ID].player:getModData().meleWeapon
		local gunwep = self.SuperSurvivors[ID].player:getModData().gunWeapon
		if(melewep ~= nil) then 
			self.SuperSurvivors[ID].LastMeleUsed = self.SuperSurvivors[ID].player:getInventory():FindAndReturn(melewep)
			if not self.SuperSurvivors[ID].LastMeleUsed then self.SuperSurvivors[ID].LastMeleUsed = self.SuperSurvivors[ID]:getBag():FindAndReturn(melewep) end
		end		
		if(gunwep ~= nil) then 
			self.SuperSurvivors[ID].LastGunUsed = self.SuperSurvivors[ID].player:getInventory():FindAndReturn(gunwep)
			if not self.SuperSurvivors[ID].LastGunUsed then self.SuperSurvivors[ID].LastGunUsed = self.SuperSurvivors[ID]:getBag():FindAndReturn(gunwep) end
		end
		
		
		if(self.SuperSurvivors[ID]:getAIMode() == "FollowRoute") then
		
			self.SuperSurvivors[ID]:getTaskManager():AddToTop(FollowRouteTask:new(self.SuperSurvivors[ID],0))
			
		elseif(self.SuperSurvivors[ID]:getAIMode() == "Follow") then 
		
			self.SuperSurvivors[ID]:getTaskManager():AddToTop(FollowTask:new(self.SuperSurvivors[ID],nil))
		
		elseif(self.SuperSurvivors[ID]:getAIMode() == "Guard") then 
		
			if self.SuperSurvivors[ID]:getGroup() ~= nil then
				local area = self.SuperSurvivors[ID]:getGroup():getGroupArea("GuardArea")
				if(area) then 		
					self.SuperSurvivors[ID]:getTaskManager():AddToTop(WanderInAreaTask:new(self.SuperSurvivors[ID],area)) 					
					self.SuperSurvivors[ID]:getTaskManager():setTaskUpdateLimit(10)					
				else
					self.SuperSurvivors[ID]:getTaskManager():AddToTop(GuardTask:new(self.SuperSurvivors[ID],self.SuperSurvivors[ID].player:getCurrentSquare()))
				end
			end
			
		elseif(self.SuperSurvivors[ID]:getAIMode() == "Patrol") then 
		
			self.SuperSurvivors[ID]:getTaskManager():AddToTop(PatrolTask:new(self.SuperSurvivors[ID], nil, nil)) 
			
		elseif(self.SuperSurvivors[ID]:getAIMode() == "Wander") then 
		
			self.SuperSurvivors[ID]:getTaskManager():AddToTop(WanderTask:new(self.SuperSurvivors[ID])) 
			
		elseif(self.SuperSurvivors[ID]:getAIMode() == "Stand Ground") then 
		
			self.SuperSurvivors[ID]:getTaskManager():AddToTop(GuardTask:new(self.SuperSurvivors[ID],self.SuperSurvivors[ID].player:getCurrentSquare())) 			
			self.SuperSurvivors[ID]:setWalkingPermitted(false) 
		
		
		elseif(self.SuperSurvivors[ID]:getAIMode() == "Doctor") then 
		
			self.SuperSurvivors[ID]:getTaskManager():AddToTop(DoctorTask:new(self.SuperSurvivors[ID])) 
			
		end
		
			
		local phi = self.SuperSurvivors[ID]:Get():getPrimaryHandItem() -- to trigger onEquipPrimary
		self.SuperSurvivors[ID]:Get():setPrimaryHandItem(nil)
		self.SuperSurvivors[ID]:Get():setPrimaryHandItem(phi)
		
	end
	
end

function SuperSurvivorManager:spawnSurvivor(isFemale,square)
	if(square ~= nil) then
		local newSurvivor = SuperSurvivor:new(isFemale,square)
		
		if(newSurvivor ~= nil) then 
			self.SuperSurvivors[self.SurvivorCount+1] = newSurvivor
			self.SurvivorCount = self.SurvivorCount + 1;
			self.SuperSurvivors[self.SurvivorCount]:setID(self.SurvivorCount)
			return self.SuperSurvivors[self.SurvivorCount]
		else
			return nil
		end
	end

end

function SuperSurvivorManager:Get(thisID)
	if(not self.SuperSurvivors[thisID]) then
		--print("super survivor #"..tostring(thisID).." was not found")
		return nil
	else
		--print("super survivor #"..tostring(thisID).." is " .. self.SuperSurvivors[thisID]:getName())
		return self.SuperSurvivors[thisID]
	end
end

function SuperSurvivorManager:OnDeath(ID)
	
	self.SuperSurvivors[ID] = nil

end

function SuperSurvivorManager:update()
	
	for i=1, self.SurvivorCount+1 do
		if (self.SuperSurvivors[i] ~= nil and self.MainPlayer ~= i) then
			if (self.SuperSurvivors[i].TargetSquare ~= nil and self.SuperSurvivors[i].TargetSquare:getZ() ~= self.SuperSurvivors[i].player:getZ() and getGameSpeed() > 1) then
				print("DANGER ZONE")
				self.SuperSurvivors[i].TargetSquare = nil
				self.SuperSurvivors[i]:DebugSay("SuperSurvivorManager Update() is about to trigger a StopWalk!")
				self.SuperSurvivors[i]:StopWalk()
				self.SuperSurvivors[i]:Wait(10)
				--self.SuperSurvivors[i]:getTaskManager():AddToTop(WanderTask:new(self.SuperSurvivors[i]))
			end
		end
	
		if(self.SuperSurvivors[i] ~= nil) and (self.MainPlayer ~= i) and (self.SuperSurvivors[i]:updateTime()) and (not self.SuperSurvivors[i].player:isAsleep()) and (self.SuperSurvivors[i]:isInCell()) then 
			self.SuperSurvivors[i]:update() 
		--	if(self.SuperSurvivors[i].DebugMode) then print(self.SuperSurvivors[i]:getName() .. " update()") end
		end
	end

end
function SuperSurvivorManager:AsleepHealAll()
	
	for i=1, self.SurvivorCount+1 do	
		if(self.SuperSurvivors[i] ~= nil) and (self.MainPlayer ~= i) and (self.SuperSurvivors[i].player) then 
			self.SuperSurvivors[i].player:getBodyDamage():AddGeneralHealth(10)
		end
	end

end
function SuperSurvivorManager:PublicExecution(SSW,SSV)
	local maxdistance = 20
	
	for i=1, self.SurvivorCount+1 do
		if(self.SuperSurvivors[i] ~= nil) and (self.SuperSurvivors[i]:isInCell()) then 
			local distance = getDistanceBetween(self.SuperSurvivors[i]:Get(),getSpecificPlayer(0))
			if(distance < maxdistance) and (self.SuperSurvivors[i]:Get():CanSee(SSV:Get())) then
				
				if(not self.SuperSurvivors[i]:isInGroup(SSW:Get()) and not self.SuperSurvivors[i]:isInGroup(SSV:Get())) then
					
					if(self.SuperSurvivors[i]:usingGun()) and (ZombRand(2)==1) then
						--chance to attack with gun if see someone near by get executed
						print(self.SuperSurvivors[i]:getName() .. " attacking the murderer with gun")
						self.SuperSurvivors[i]:Get():getModData().hitByCharacter = true
						
					else
						-- flee from the crazy murderer
						print(self.SuperSurvivors[i]:getName() .. " fleeing from the crazy murderer")
						--print("FLEEFROM1 " .. self.SuperSurvivors[i]:getName())
						self.SuperSurvivors[i]:getTaskManager():AddToTop(FleeFromHereTask:new(self.SuperSurvivors[i],SSW:Get():getCurrentSquare()))
					end
					self.SuperSurvivors[i]:SpokeTo(SSW:Get():getModData().ID)
					self.SuperSurvivors[i]:SpokeTo(SSV:Get():getModData().ID)
					
				end
				
			end
		end
	end
	

end

function SuperSurvivorManager:GunShotHandle(SSW)
	local maxdistance = 20
	local weapon = getSpecificPlayer(0):getPrimaryHandItem()
	if not weapon then return false end
	
	local range = weapon:getSoundRadius();
	for i=1, self.SurvivorCount+1 do
		if(self.SuperSurvivors[i] ~= nil) and (self.SuperSurvivors[i]:isInCell()) then 
			local distance = getDistanceBetween(self.SuperSurvivors[i]:Get(),getSpecificPlayer(0))
			
				
				
				if(self.SuperSurvivors[i].player:getModData().surender) and (distance < maxdistance) and self.SuperSurvivors[i]:Get():CanSee(SSW:Get()) and self.SuperSurvivors[i].player:CanSee(getSpecificPlayer(0)) then
					-- flee from the crazy murderer
					print(self.SuperSurvivors[i]:getName() .. " fleeing from the crazy murderer")
					--print("FLEEFROM2 " .. self.SuperSurvivors[i]:GetName())
					self.SuperSurvivors[i]:getTaskManager():AddToTop(FleeFromHereTask:new(self.SuperSurvivors[i],SSW:Get():getCurrentSquare()))
					self.SuperSurvivors[i]:SpokeTo(SSW:Get():getModData().ID)
				end
				
				if(self.SuperSurvivors[i].player:getModData().isHostile or self.SuperSurvivors[i]:getCurrentTask() == "Guard" or self.SuperSurvivors[i]:getCurrentTask() == "Patrol") and self.SuperSurvivors[i]:getTaskManager():getCurrentTask() ~= "Surender" and not self.SuperSurvivors[i].player:isDead() and not self.SuperSurvivors[i]:RealCanSee(getSpecificPlayer(0)) and (getDistanceBetween(getSpecificPlayer(0),self.SuperSurvivors[i].player) <= range) then
					print(self.SuperSurvivors[i]:getName().. " adding go check it out task")
					self.SuperSurvivors[i]:getTaskManager():AddToTop(GoCheckItOutTask:new(self.SuperSurvivors[i],getSpecificPlayer(0):getCurrentSquare()))
				end
				
				
			
		end
	end
	

end

function SuperSurvivorManager:GetClosest()
	local closestSoFar = 20
	local closestID = 0
	for i=1, self.SurvivorCount+1 do
		if(self.SuperSurvivors[i] ~= nil) and (self.SuperSurvivors[i]:isInCell()) then 
			local distance = getDistanceBetween(self.SuperSurvivors[i]:Get(),getSpecificPlayer(0))
			if(distance < closestSoFar) then
				closestID = i
				closestSoFar = distance
			end
		end
	end
	
	if(closestID ~= 0) then return self.SuperSurvivors[closestID]
	else return nil end

end

function SuperSurvivorManager:GetClosestNonParty()
	local closestSoFar = 20
	local closestID = 0
	for i=1, self.SurvivorCount+1 do
		if(self.SuperSurvivors[i] ~= nil) and (self.SuperSurvivors[i]:isInCell()) then 
			local distance = getDistanceBetween(self.SuperSurvivors[i]:Get(),getSpecificPlayer(0))
			if(distance < closestSoFar) and (self.SuperSurvivors[i]:getGroupID() == nil) then
				closestID = i
				closestSoFar = distance
			end
		end
	end
	
	if(closestID ~= 0) then return self.SuperSurvivors[closestID]
	else return nil end

end

function SuperSurvivorManager:SaveAll()
	
	for i=1, self.SurvivorCount+1 do
		if(self.SuperSurvivors[i] ~= nil) and (self.SuperSurvivors[i]:isInCell()) then 			
			self.SuperSurvivors[i]:SaveSurvivor()
		end
	end

end

SSM = SuperSurvivorManager:new()





function loadSurvivorMap( )
	local tempTable = {}
	tempTable = table.load("SurvivorManagerInfo")
	if (tempTable) and (tempTable[1]) then 
		SSM.SurvivorCount = tonumber(tempTable[1])
		print("set SurvivorCount:"..tostring(tempTable[1]) .. " from SurvivorManagerInfo file");
	else 
		print("SurvivorManagerInfo was not found. this save file could be corrupt");
	end
	
	SurvivorLocX = kvtableload("SurvivorLocX")
	SurvivorLocY = kvtableload("SurvivorLocY")
	SurvivorLocZ = kvtableload("SurvivorLocZ")
	
	
	local fileTable = {}
	
	for k,v in pairs(SurvivorLocX) do   --- trying new way of saving & loading survivor map
	
		local key = SurvivorLocX[k] .. SurvivorLocY[k] .. SurvivorLocZ[k]
		
		if(not fileTable[key]) then fileTable[key] = {} end
		print("survivor loc: "..tostring(fileTable[key])..", "..tostring(k))
		table.insert(fileTable[key], tonumber(k))	
	
	end
	
	return fileTable
	--[[
	local readFile = getModFileReader("SubparSurvivors",getWorld():getWorld()..getFileSeparator().."SurvivorMap.lua", true)
	local scanLine = readFile:readLine()
	while scanLine do
	
		local values = {}
		for input in scanLine:gmatch("%S+") do table.insert(values,input) end
		--print("loading line: "..values[1] .. " " .. values[2])
		if(fileTable[ values[1] ] == nil) then fileTable[ values[1] ] = {} end
			table.insert(fileTable[ values[1] ], tonumber(values[2]))
		scanLine = readFile:readLine()
		if not scanLine then break end
	end
	readFile:close()
	return fileTable ]]
end


function saveSurvivorMap(  )
	
	
	local tempTable = {}
	tempTable[1] = SSM.SurvivorCount
	table.save(tempTable,"SurvivorManagerInfo")
	
	--[[
	if(not SurvivorMap) then return false end
	local destFile = getWorld():getWorld()..getFileSeparator().."SurvivorMap.lua"
	local writeFile = getModFileWriter("SubparSurvivors", destFile, true, false)
	--print("saving SurvivorMap:".. tostring(SurvivorMap))
	for index,value in pairs(SurvivorMap) do
		
		for i = 1,#value do
			writeFile:write(tostring(index) .. " " .. tostring(value[i]) .. "\r\n");
			--print("saving: " .. tostring(index) .. " " .. tostring(value[i]))
		end
	end
	writeFile:close();
	]]
	kvtablesave(SurvivorLocX,"SurvivorLocX")
	kvtablesave(SurvivorLocY,"SurvivorLocY")
	kvtablesave(SurvivorLocZ,"SurvivorLocZ")
end





