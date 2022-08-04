FindThisTask = {}
FindThisTask.__index = FindThisTask

function FindThisTask:new(superSurvivor, itemType, CategoryOrType, thisQuantity)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	if(superSurvivor == nil) then return nil end
	
	o.FoundCount = 0
	if(thisQuantity ~= nil) then o.Quantity = thisQuantity 
	else o.Quantity = 1 end
	o.parent = superSurvivor
	o.Name = "Find This"
	o.OnGoing = false
	o.COT = CategoryOrType
	o.itemtype = itemType
	
	if( itemType == "Water") then o.BagToPutIn = superSurvivor:Get():getInventory()
	else o.BagToPutIn = superSurvivor:getBag() end
	
	if(not superSurvivor.player:getCurrentSquare()) then
		o.Complete = true
		return nil 
	end
	o.TargetItem = nil
	o.Complete = false
	o.WasSuccessful = false
	
	superSurvivor:RoleplaySpeak(getActionText("LookForItem_Before")..itemType..getActionText("LookForItem_After"))
	return o

end

function FindThisTask:isComplete()
	if(self.Complete) then
		if (self.ItemType == "Weapon") then
			local weapon = FindAndReturnBestWeapon(self.BagToPutIn)
			if(weapon ~= nil) and (self.parent:Get():getPrimaryHandItem() == nil or self.parent:Get():getPrimaryHandItem():getMaxDamage() < weapon:getMaxDamage()) then
				self.parent:Get():setPrimaryHandItem(weapon)
			end
		end
		--if(self.parent:isHungry()) and (self.parent:hasFood()) then
		--	self.parent:getTaskManager():AddToTop(EatFoodTask:new(self.parent,self.parent:getFood()))
		--end
	end
	return self.Complete
end

function FindThisTask:isValid()
	return true 
end

function FindThisTask:getWasSuccessful()
	return self.WasSuccessful
end

function FindThisTask:update()

	if(getSpecificPlayer(0):isAsleep()) then return false end
	if(not self:isValid()) or self.parent:getDangerSeenCount() > 0 then
		--self.parent:Speak("completing")
		self.Complete = true
		return false 
	end
	
	if(self.parent:isInAction()) then
		--self.parent:Speak("waiting for non action")
		return false 
	end
	
	
	if(self.TargetItem == nil) then 
		--print("going to FindThisNearBy:"..self.itemtype)
		self.TargetItem = self.parent:FindThisNearBy(self.itemtype,self.COT)

		-- handle different axe types
		if(self.TargetItem == nil) and (self.itemtype=="Axe") then
			--print("look for WoodAxe")
			self.parent.GoFindThisCounter = 0
			self.TargetItem = self.parent:FindThisNearBy("WoodAxe",self.COT)
		end
		if(self.TargetItem == nil) and (self.itemtype=="Axe") then
			--print("look for AxeStone")
			self.parent.GoFindThisCounter = 0
			self.TargetItem = self.parent:FindThisNearBy("AxeStone",self.COT)
		end
		if(self.TargetItem == nil) and (self.itemtype=="Axe") then
			--print("look for HandAxe")
			self.parent.GoFindThisCounter = 0
			self.TargetItem = self.parent:FindThisNearBy("HandAxe",self.COT)
		end
		--print("done FindThisNearBy:"..tostring(self.TargetItem))
	end
	
	if(self.TargetItem == nil) then
		self.Complete = true

		if(self.WasSuccessful == false) then 
			self.parent:RoleplaySpeak(getActionText("NoFindItem_Before")..self.itemtype..getActionText("NoFindItem_After")) 
		end

		if self.itemtype == "Food" then 
			self.parent:setNoFoodNearBy(true)
		elseif self.itemtype == "Water" then 
			self.parent:setNoWaterNearBy(true) 
		end
		
		return false
	end
	
	
	local distance, targetSquare
	if(instanceof(self.TargetItem,"InventoryItem")) and (self.TargetItem:getWorldItem() ~= nil) then 
		targetSquare = self.TargetItem:getWorldItem():getSquare() 
	elseif(instanceof(self.TargetItem,"IsoObject")) and (self.TargetItem:getSquare() ~= nil) then 
		targetSquare = self.TargetItem:getSquare() 
	elseif(instanceof(self.TargetItem,"InventoryItem")) and (self.TargetItem:getContainer() ~= nil) then 
		targetSquare = self.TargetItem:getContainer():getSourceGrid() 
	end
	
	if(not targetSquare) then
		print("error cannot locate location of returned item")
		--self.Complete = true
		self.TargetItem = nil
		return false
	else
		--self.parent:Speak("here i am")
		distance = getDistanceBetween(targetSquare,self.parent:Get())
		
		if(distance > 2.0) or (targetSquare:getZ() ~= self.parent:Get():getZ()) then 
			self.parent:walkTo(targetSquare)
		else
			if (instanceof(self.TargetItem,"InventoryItem")) and (self.parent:getBag():hasRoomFor(self.parent:Get(),self.TargetItem) == false) then
				self.parent:getTaskManager():AddToTop(CleanInvTask:new(self.parent,self.parent:Get():getCurrentSquare(),false))
			elseif (instanceof(self.TargetItem,"IsoWorldInventoryObject")) and (self.parent:getBag():hasRoomFor(self.parent:Get(),self.TargetItem:getItem()) == false) then
				self.parent:getTaskManager():AddToTop(CleanInvTask:new(self.parent,self.parent:Get():getCurrentSquare(),false))
			end
			
			if(instanceof(self.TargetItem,"IsoObject")) then
				self.parent:DrinkFromObject(self.TargetItem)
				self.Complete = true 
				self.WasSuccessful = true
			else
				if(self.BagToPutIn:contains(self.TargetItem) == false) then
					if(self.TargetItem:getWorldItem() ~= nil) then
						
						if(self.TargetItem:getWorldItem():getSquare() ~= nil) and (self.TargetItem:getWorldItem():getSquare():getModData().Group ~= nil) and (self.TargetItem:getWorldItem():getSquare():getModData().Group ~= self.parent:getGroupID()) then
							SSGM:Get(self.TargetItem:getWorldItem():getSquare():getModData().Group):stealingDetected(self.parent.player)
						end
						
						local squareTargetison = self.TargetItem:getWorldItem():getSquare()
						self.BagToPutIn:AddItem(self.TargetItem)
						squareTargetison:removeWorldObject(self.TargetItem:getWorldItem())
						if(self.TargetItem:getWorldItem() ~= nil) then self.TargetItem:getWorldItem():removeFromSquare() end
						self.TargetItem:setWorldItem(nil)
						self.parent:RoleplaySpeak(getActionText("TakesFromGround_Before") .. self.TargetItem:getDisplayName() .. getActionText("TakesFromGround_After"))
						self.FoundCount = self.FoundCount + 1
						
						if(self.Quantity > 1) then
							local itemsOncurrentSquare = squareTargetison:getWorldObjects() -- take more of same type if piled on same square without scanning cell 
							for i=1, itemsOncurrentSquare:size()-1 do
								local tempWitem = itemsOncurrentSquare:get(i)
								if(tempWitem ~= nil) then
									local tempitem = tempWitem:getItem()
									if(tempitem ~= nil) then
										if (tempitem:getType() == self.itemtype) or (tempitem:getCategory() == self.itemtype) then
											self.BagToPutIn:AddItem(tempitem)
											squareTargetison:removeWorldObject(tempitem:getWorldItem())
											if(self.TargetItem:getWorldItem() ~= nil) then tempitem:getWorldItem():removeFromSquare() end
											tempitem:setWorldItem(nil)
											self.parent:RoleplaySpeak(getActionText("TakesFromGround_Before") .. tempitem:getDisplayName() .. getActionText("TakesFromGround_After") )
											self.FoundCount = self.FoundCount + 1
											if(self.FoundCount >= self.Quantity) then 
												--self.parent:Speak("breaking:" .. tostring(self.Quantity)..","..tostring(self.FoundCount))
												self.Complete = true 
												self.WasSuccessful = true	
												return true
											end
										end
									end
								end
							end
						end
						
					else
						self.parent:DebugSay("FindThisTask is about to trigger a StopWalk! ")
						self.parent:StopWalk()
						ISTimedActionQueue.add(ISInventoryTransferAction:new(self.parent.player, self.TargetItem, self.TargetItem:getContainer(), self.BagToPutIn, 20))
						self.parent:RoleplaySpeak(getActionText("TakesFromCont_Before") .. self.TargetItem:getDisplayName() .. getActionText("TakesFromCont_After"))
						self.FoundCount = self.FoundCount + 1
					end
				else
					self.FoundCount = self.FoundCount + 1
					self.TargetItem = nil
					
				end
			end
		end
		
	end
	
	if self.FoundCount >= self.Quantity then 
		self.Complete = true 
		self.WasSuccessful = true
	end
		
	
end
