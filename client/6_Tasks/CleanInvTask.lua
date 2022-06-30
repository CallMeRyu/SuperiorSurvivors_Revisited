CleanInvTask = {}
CleanInvTask.__index = CleanInvTask

function CleanInvTask:new(superSurvivor, DropSquare, incldHandItems)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	superSurvivor:DebugSay("CleanInvTask is about to trigger a StopWalk! ")
	superSurvivor:StopWalk()
	if(incldHandItems == nil) then incldHandItems=false end	
	if(instanceof(DropSquare,"IsoPlayer")) then o.TheDropSquare = DropSquare:getCurrentSquare()
	elseif(instanceof(DropSquare,"IsoObject")) then 
		o.TheDropContainer = DropSquare
		o.TheDropSquare = DropSquare:getSquare()
	else o.TheDropSquare = DropSquare end
	o.parent = superSurvivor
	o.Name = "Clean Inventory"
	o.OnGoing = false
	o.incldHandItems = incldHandItems;
	o.Complete = false
	
	return o

end

function CleanInvTask:isComplete()
	if(self.Complete == true) then
		triggerEvent("OnClothingUpdated", self.parent.player)
	end
	return self.Complete
	
end

function CleanInvTask:isValid()
	if not self.parent or (not self.TheDropSquare and not self.TheDropContainer) then return false 
	else return true end
end

function CleanInvTask:Talked()
	self.TicksSinceLastExchange = 0
end

function CleanInvTask:update()
	
	if(not self:isValid()) then 
		self.Complete = true 
		return false 
	end
	
	if (self.parent:isInAction() == false) then
		
		local distance = getDistanceBetween(self.parent.player,self.TheDropSquare)
		if (distance > 2.0) then
			self.parent:walkTo(self.TheDropSquare) 	
		else		
			
			if(self.incldHandItems) then
				self.parent.player:setPrimaryHandItem(nil)
				self.parent.player:setSecondaryHandItem(nil)
				self.parent.player:setClothingItem_Back(nil)
			end
			
			local droppedSomething = false
			local armorModEnabled = (isModEnabled("ArmorMod"))
			local square = self.parent:getFacingSquare()
			local inv = self.parent.player:getInventory()
			local bag = self.parent:getBag()
			local pweapon = self.parent.player:getPrimaryHandItem()
			if(pweapon == nil) then pweapon = 0 end
			local sweapon = self.parent.player:getSecondaryHandItem()
			if(sweapon == nil) then sweapon = 0 end
			
			-- exlude ammo types and ammo box types
			self.parent:DebugSay("CleanInvTask is about to trigger a StopWalk! (Path B) ")
			self.parent:StopWalk()
			local items = inv:getItems() ;
			if(items) then
				for i=1, items:size()-1 do
				local item = items:get(i)
					if(item ~= nil) then
						--print("drop " .. tostring(item:getDisplayName()) .. " " .. tostring(item:isEquipped()) .. " " .. tostring(self.parent.player:isEquipped(item)) .. tostring(item:getBodyLocation()))
						if (item:isBroken()) or (
							(not self.parent.player:isEquipped(item))
							and (not item:isEquipped())
							and (
								self.incldHandItems
								or (
									(item ~= self.parent.LastGunUsed)
									and (item ~= self.parent.LastMeleUsed)
									and (self.parent:isAmmoForMe(item:getType()) == false)
									and (item ~= pweapon)
									and (item ~= sweapon)))
						) then   --and (isItemWater(item) == false) and (item:getCategory() ~= "Food")
							--self.parent.player:Say("Here i am 1")
							local container
							if (self.TheDropContainer ~= nil) then
								if (self.TheDropContainer:getContainer() ~= nil) then container = self.TheDropContainer:getContainer()
								else container = self.TheDropContainer end
							end
							if (container == nil) then
								-- try to find a container with similar items
								local spiral = SpiralSearch:new(self.parent.player:getX(), self.parent.player:getY(), 2)
								local x, y, sq, items

								for i = spiral:forMax(), 0, -1 do
									x = spiral:getX()
									y = spiral:getY()

									sq = getCell():getGridSquare(x, y, self.parent.player:getZ())
									if(sq ~= nil) then
										items = sq:getObjects()
										-- check containers in square
										for j=0, items:size()-1 do
											if(items:get(j):getContainer() ~= nil) then
												local c = items:get(j):getContainer()
												if (c ~= nil) and (c:HasType(item:getCat())) then
													--print("found container for " .. tostring(item:getType()))
													container = c
												end
											end
										end
									end

									if (container ~= nil) then
										break
									end

									spiral:next()
								end
							end

							if ((container ~= nil) and (container:hasRoomFor(self.parent.player,item)) ) then
								--self.parent.player:Say("using ISInventoryTransferAction")
								ISTimedActionQueue.add(ISInventoryTransferAction:new(self.parent.player, item, inv, container, nil))
							else -- its a grid square
								ISTimedActionQueue.add(ISDropItemAction:new (self.parent.player, item, 30))
								--self.parent.player:Say("not using ISInventoryTransferAction")
								--square:AddWorldInventoryItem(item, (ZombRand(1,9)/10) , (ZombRand(1,9)/10), 0.0);
								--inv:DoRemoveItem(item);
							end
								
							
							if item:getBodyLocation() ~= "" and self.parent.player:isEquipped(item) then
								self.parent.player:removeFromHands(nil);
								--self.parent.player:setWornItem(item:canBeEquipped(), nil);
								self.parent.player:setWornItem(item:getBodyLocation(), nil);
							end
							
							triggerEvent("OnClothingUpdated", self.parent.player)
							
							--self.parent.player:Say("Here i am 4")
							droppedSomething = true
							break
						end
					end
				end
				--getPlayerData(self.player:getPlayerNum()).playerInventory:refreshBackpacks();
				self.parent.player:initSpritePartsEmpty();
			end
			if(inv ~= bag) then 
				local items = bag:getItems() ;
				if(items) then
					for i=1, items:size()-1 do
					local item = items:get(i)
						if(item ~= nil) then
							if (item:isBroken()) or (
								(not item:isEquipped())
								and (armorModEnabled == false or (ArmorisArmorEquipped(self.parent.player,item) == false))
								and (item ~= pweapon)
								and (item ~= self.parent.LastGunUsed)
								and (item ~= self.parent.LastMeleUsed)
								and (self.parent:isAmmoForMe(item:getType()) == false)
								and (item ~= sweapon)  --[[and (isItemWater(item) == false) and (item:getCategory() ~= "Food")]]
							) then
								--print("drop bag " .. tostring(item:getDisplayName()) .. " " .. tostring(item:isEquipped()) .. " " .. tostring(self.parent.player:isEquipped(item)))
								if(self.TheDropContainer ~= nil) and (self.TheDropContainer.getContainer ~= nil) and (self.TheDropContainer:getContainer():hasRoomFor(self.parent.player,item)) then
									local container = self.TheDropContainer:getContainer()
									--self.parent.player:Say("Here i am 2")
									ISTimedActionQueue.add(ISInventoryTransferAction:new(self.parent.player, item, bag, container, nil))
								else	
									--self.parent.player:Say("Here i am 3")
									square:AddWorldInventoryItem(item, (ZombRand(1,9)/10) , (ZombRand(1,9)/10), 0.0);
									bag:DoRemoveItem(item);
								end
								droppedSomething = true
								break
							end
						end
					end
				end
			end
			
			if(droppedSomething ~= true) then
				self.Complete = true
			end
			
		end
		
		
		
	end

end
