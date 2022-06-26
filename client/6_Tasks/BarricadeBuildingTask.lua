BarricadeBuildingTask = {}
BarricadeBuildingTask.__index = BarricadeBuildingTask

function BarricadeBuildingTask:new(superSurvivor)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.parent = superSurvivor
	o.Name = "Barricade Building"
	o.OnGoing = true
	o.TargetBuilding = nil
	o.TargetSquare = nil
	o.Window = nil
	o.PreviousSquare = nil
	o.Complete = false
	o.PrevWeapon1 = o.parent.player:getPrimaryHandItem()
	o.PrevWeapon2 = o.parent.player:getSecondaryHandItem()
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	
	local inv = o.parent.player:getInventory()
	local temp = inv:FindAndReturn("Hammer")
	if(temp) then 
		o.Hammer = temp
	else
		o.Hammer = inv:AddItem("Base.Hammer")
	end
	
	temp = inv:FindAndReturn("Plank")
	if(temp) then 
		o.Plank = temp
	else
		o.Plank = inv:AddItem("Base.Plank")
	end
	
	if inv:getItemCount("Base.Nails", true) < 2 then
		inv:AddItem(instanceItem("Base.Nails"))
		inv:AddItem(instanceItem("Base.Nails"))	
	end
	
	superSurvivor:DebugSay("starting task barricading buidling")
	return o

end

function BarricadeBuildingTask:OnComplete()

	self.parent.player:setPrimaryHandItem(self.PrevWeapon1)
	self.parent.player:setSecondaryHandItem(self.PrevWeapon2)

end

function BarricadeBuildingTask:isComplete()
	if(self.Complete) then
		self.parent.player:setPrimaryHandItem(self.PrevWeapon1)
		self.parent.player:setSecondaryHandItem(self.PrevWeapon2)
	end
	return self.Complete
end

function BarricadeBuildingTask:isValid()
	if not self.parent then return false 
	else return true end
end

function BarricadeBuildingTask:update()
	
	if(not self:isValid()) then return false end
	
	if(self.parent:isInAction() == false) then
		
		
			local building = self.parent:getBuilding();
			if(building ~= nil) then 
				
				if(self.Window == nil) then self.Window = self.parent:getUnBarricadedWindow(building) end
				if(not self.Window) then 
					--print("window NOT found") 
					self.Complete = true
					return false
				else 
					--print("window found") 
				end
				
			else 
				print("building nil") 
				self.Complete = true
				return false						
			end
			
			local barricade = self.Window:getBarricadeForCharacter(self.parent.player)
			local distance = getDistanceBetween(self.parent.player, self.Window:getIndoorSquare());
			if(distance > 2) or (self.parent.player:getZ() ~= self.Window:getZ()) then
				--print("walking to window")
				local attempts = self.parent:getWalkToAttempt(self.Window:getIndoorSquare())
				self.parent:DebugSay("barricade window x" .. tostring(attempts))
				--self.parent:walkToDirect(self.Window:getIndoorSquare())	
				self.parent:walkTo(self.Window:getIndoorSquare())	

				if(attempts > 8) then 
					self.Complete = true
					return false
				end
			elseif barricade == nil or (barricade:canAddPlank()) then
				--print("barricading window")
				self.parent.player:setPrimaryHandItem(self.Hammer)
				self.parent.player:setSecondaryHandItem(self.Plank)
				if not self.parent.player:getInventory():contains("Nails", true) then self.parent.player:getInventory():AddItem("Base.Nails") end
									
				self.parent:DebugSay("BarricadeBuildingTask is about to trigger a StopWalk! ")
				self.parent:StopWalk()
				ISTimedActionQueue.add(ISBarricadeAction:new(self.parent.player, self.Window, false, false, 100));
		
				
				self.Window = nil
			else
				self.Window = nil
			end
		
	else
		--print("waiting for non action")
	end
end

