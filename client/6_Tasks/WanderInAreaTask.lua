WanderInAreaTask = {}
WanderInAreaTask.__index = WanderInAreaTask

function WanderInAreaTask:new(superSurvivor, thisArea)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	if(superSurvivor == nil) then return nil end
	o.Complete = false
	o.Area = thisArea
	o.parent = superSurvivor
	o.Name = "Wander In Area"
	o.OnGoing = true
	
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	
	return o

end

function WanderInAreaTask:isComplete()
	return self.Complete
end

function WanderInAreaTask:isValid()
	if not self.parent or not self.Area then 
		self.Complete = true
		return false 
	else return true end
end

function WanderInAreaTask:update()

	
	if(not self:isValid()) then return false end
	
	if(self.parent:isInAction() == false) and (ZombRand(4) == 0) then
	
		local sq = getRandomAreaSquare(self.Area)
		if(sq ~= nil) then 
			self.parent:walkTo(sq); 
		else 
			print("error getting walk sq") 
		end
	
	end

end
