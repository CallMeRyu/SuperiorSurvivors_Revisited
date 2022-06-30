LootCategoryTask = {}
LootCategoryTask.__index = LootCategoryTask

function LootCategoryTask:new(superSurvivor, building , category, thisQuantity)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	if(superSurvivor == nil) then return false end
	
	o.FoundCount = 0
	if(thisQuantity > 0) then o.Quantity = thisQuantity -- 0 for no limit basically
	else o.Quantity = 9999 end
	o.parent = superSurvivor
	o.Name = "Loot Category"
	o.OnGoing = false
	o.Category = category
	
	if(not superSurvivor.player:getCurrentSquare()) then
		o.Complete = true
		return nil 
	end
	
	o.Building = building
	o.parent:MarkBuildingExplored(o.Building)
	o.PlayerBag = superSurvivor.player:getInventory()
	o.Container = nil
	o.Complete = false
	o.Floor = 0
	
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	
	return o

end

function LootCategoryTask:ForceFinish()
	self.parent:BuildingLooted()
	--self.parent:MarkBuildingExplored(self.Building)
	self.parent.TargetBuilding = nil
	self.Complete = true
	self.parent:resetContainerSquaresLooted()
	if (self.Category == "Weapon") then
		local weapon = FindAndReturnBestWeapon(self.PlayerBag)
		if(weapon == nil) then 
			return
		end

		local current = self.parent:Get():getPrimaryHandItem()
		if(current == nil) then 
			return
		end

		if(current:getMaxDamage() >= weapon:getMaxDamage())then 
			return
		end
		
		self.parent:Get():setPrimaryHandItem(weapon)
	end
	
end

function LootCategoryTask:isComplete()
	if(self.Complete) then 
		
		self:ForceFinish()
		
	end
	return self.Complete
end

function LootCategoryTask:isValid()
	return true 
end

function LootCategoryTask:update()

	if(not self:isValid()) or self.parent:isTooScaredToFight() then
		self.parent:DebugSay("too scared")
		self.Complete = true
		return false 
	end
	if(self.parent:isInAction()) then
		return false 
	end
	
		self.parent:DebugSay("loot update")
		
		if(self.Category == nil) then self.Category = "Food" end 
		local loopcount
		
		self.PlayerBag = self.parent:getBag()
		
		if(not self.Building) then 
			self.parent:DebugSay("no building")

			self.Complete = true
			self.parent:Speak(getText("ContextMenu_SD_NotInBuilding"))
		
		elseif(not self.parent:hasRoomInBag()) then
			self.parent:DebugSay("no room in bag")
			
			self.Container = nil
			self.Complete = true
			self.parent:Speak(getText("ContextMenu_SD_CantCarryMore"))
		else
			loopcount = 0
			
			
			if(self.Container == nil) or ((instanceof(self.Container,"ItemContainer")) and (self.parent:getContainerSquareLooted(self.Container:getSourceGrid(),self.Category) == 0))  then 
						
					self.Container = nil
					local ID = self.parent:getID()
					local stoploop = false
					local bdef = self.Building:getDef()	
					local closestSoFar = 999
					
					for z=2,0,-1 do
						for x=bdef:getX()-2,(bdef:getX() + bdef:getW())+2 do
						if(stoploop) then break end
							for y=bdef:getY()-2,(bdef:getY() + bdef:getH())+2 do
							
							if(stoploop) then break end	
							loopcount = loopcount + 1
							local sq = getCell():getGridSquare(x,y,z)
								if(sq ~= nil) and (not sq:isOutside()) then
									--sq:AddWorldInventoryItem("Base.Nails",0.5,0.5,0)
									--self.parent:Explore(sq)								
									local items = sq:getObjects()
									for j=0, items:size()-1 do
										if(items:get(j):getContainer() ~= nil) then
											local container = items:get(j):getContainer()
											local tempDistance = getDistanceBetween(sq,self.parent.player)
											if(sq:getZ() ~= self.parent.player:getZ()) then tempDistance = tempDistance + 13 end
											if(self.parent:getWalkToAttempt(sq) <= 8) and  (tempDistance<closestSoFar) and (self.parent:getContainerSquareLooted(sq,self.Category) == 0) then
												self.Container = container
												closestSoFar = tempDistance
												self.Floor = z
												
											end	
										end
									end	
									if(self.Container == nil) then
										items = sq:getWorldObjects()
										for j=0, items:size()-1 do
											if(items:get(j):getItem()) then
												local container = items:get(j):getItem()
												if(container ~= nil and container:getCategory() == self.Category) then
													self.Container = container
													stoploop = true
													self.Floor = z
													break
												end
											end
										end	
									end
								end
								
							end						
						end
					end
				
			end
			
			if(self.Container == nil) then
				
				self.parent:DebugSay("container nil")
				--if (self.parent ~= nil) then self.parent:Wait(10) end
				self.Complete = true
				
			elseif(instanceof(self.Container,"ItemContainer")) then
			
				local distance = getDistanceBetween(self.Container:getSourceGrid(),self.parent.player)
				if(distance > 2.1) or (self.parent.player:getZ() ~= self.Floor) then 
					self.parent:DebugSay("too far")
					
					local trySquare = self.Container:getSourceGrid()

					if trySquare ~= nil and trySquare:getRoom() ~= nil then
						self.TargetBuilding = trySquare:getRoom():getBuilding()
						self.parent:DebugSay("reset target: " .. tostring(self.TargetBuilding))
					end
					self.parent:walkTo(trySquare)
					self.parent:WalkToAttempt(trySquare)
					if(self.Container:getSourceGrid()) and (self.parent:getWalkToAttempt(self.Container:getSourceGrid()) > 8) then
						self.parent:DebugSay("blocked " .. tostring(self.parent:getWalkToAttempt(self.Container:getSourceGrid())))
						self.Container = nil
						--if (self.parent ~= nil) then self.parent:Wait(10) end
						self.Complete = true
					end -- cant get to it 9blocked)
				
				else
					self.parent:DebugSay("else")
					local item = MyFindAndReturnCategory(self.Container, self.Category, self.parent)
					if(item ~= nil) then
							self.FoundCount = self.FoundCount + 1
							self.parent:RoleplaySpeak(getText("ContextMenu_SD_TakesFromCont_Before") .. item:getDisplayName() .. getText("ContextMenu_SD_TakesFromCont_After"))
						if(self.parent:hasRoomInBagFor(item)) then
							self.parent:DebugSay("LootCategoryTask is about to trigger a StopWalk! Path B ")
							self.parent:StopWalk()
							ISTimedActionQueue.add(ISInventoryTransferAction:new (self.parent.player, item, self.Container, self.PlayerBag, nil))
						else
							self.parent.player:getInventory():AddItem(item)
							self.Container:DoRemoveItem(item)
						end
					else
						self.parent:DebugSay("ContainerSquareLooted")
						self.parent:ContainerSquareLooted(self.Container:getSourceGrid(),self.Category)
						self.Container = nil
					end
				end
				
			elseif(instanceof(self.Container,"InventoryItem")) then
				if (self.Container:getWorldItem() == nil) then
					self.parent:DebugSay("container has no world item")	
					self.Container = nil
					return false
				end
				local distance = getDistanceBetween(self.Container:getWorldItem():getSquare(),self.parent.player)
				if(distance > 2.0) or (self.parent.player:getZ() ~= self.Floor) then 
					if(self.parent.player:getPath2() == nil) then 
						self.parent.player:StopAllActionQueue()
						local sq = self.Container:getWorldItem():getSquare()
						self.parent:walkTo(sq)		
						if (sq:getRoom() ~= nil) then
							self.TargetBuilding = sq:getRoom():getBuilding()	
							self.parent:DebugSay("walk to: " .. tostring(self.TargetBuilding))	
						end
					else 
						self.parent:DebugSay("??")	
					end
				else
				
					local item = self.Container					
					self.FoundCount = self.FoundCount + 1
										
					self.parent:RoleplaySpeak(getText("ContextMenu_SD_TakesFromGround_Before") .. item:getDisplayName() .. getText("ContextMenu_SD_TakesFromGround_After"))
					local srcContainer = item:getContainer()
					if instanceof(srcContainer,"ItemContainer") then
						--ISTimedActionQueue.add(ISInventoryTransferAction:new (self.parent.player, item, srcContainer, self.PlayerBag, nil))
						self.PlayerBag:AddItem(item)
						item:getWorldItem():removeFromSquare()
						item:setWorldItem(nil)
						self.Container = nil
						
						if(item ~= nil) then
		
							local ssquare = getSourceSquareOfItem(item,self.parent.player)
							--print(tostring(ssquare))
							if(ssquare ~= nil) then
								local OwnerGroupId = SSGM:GetGroupIdFromSquare(ssquare)
								local TakerGroupId = self.parent.player:getModData().Group
								if(OwnerGroupId ~= -1) and (TakerGroupId ~= OwnerGroupId) then
									print("ga stealing detected!")
									SSGM:Get(OwnerGroupId):stealingDetected(self.parent.player)
								end
							end		
							
							
						end
						
					end
					
					
				end
			else
				self.parent:DebugSay("?")
			end
			
		end
	if self.FoundCount >= self.Quantity then self.Complete = true end
end
