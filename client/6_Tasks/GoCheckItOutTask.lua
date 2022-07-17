GoCheckItOutTask = {}
GoCheckItOutTask.__index = GoCheckItOutTask

function GoCheckItOutTask:new(superSurvivor, spot)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.parent = superSurvivor
	o.Name = "Check out spot"
	o.Spot = spot
	o.SeenSpot = false
	o.Ticks = 0
	o.Complete = false
	o.parent:Speak(getDialogue("WhatWasThatSound")) 
	
	return o

end

function GoCheckItOutTask:isComplete()
	if(self.Complete) then
		
	end
	return self.Complete
end

function GoCheckItOutTask:isValid()
	if not self.parent or self.Spot == nil then return false 
	else return true end
end

function GoCheckItOutTask:update()
	
	if(not self:isValid()) then 
		self.Complete = true
		return false 
	end
	
	if(self.parent:isInAction() == false) then
	
		
		local distance = getDistanceBetween(self.parent:Get(), self.Spot)
			
		if( distance <= 2.0 ) then
			self.Complete = true			
		else
			self.parent:WalkToPoint(self.Spot:getX(),self.Spot:getY(),self.Spot:getZ())
		end
	
		self.Ticks = self.Ticks + 1
		if(self.Ticks > 15) then self.Complete = true end
	end

end
