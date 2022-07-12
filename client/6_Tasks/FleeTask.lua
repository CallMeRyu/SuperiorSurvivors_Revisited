FleeTask = {}
FleeTask.__index = FleeTask

function FleeTask:new(superSurvivor)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	superSurvivor:setRunning(true)
	o.parent = superSurvivor
	o.Name = "Flee"
	o.OnGoing = false
	if o.parent.TargetBuilding ~= nil then o.parent:MarkAttemptedBuildingExplored(o.parent.TargetBuilding) end -- otherwise he just keeps running back to the building though the threat likely lingers there

	return o
	
end

function FleeTask:isComplete()
	if (self.parent:getDangerSeenCount() == 0) or self.parent:needToFollow() then 
		self.parent:StopWalk()
		--print(self:getName().."stopping walking7")
		self.parent:setRunning(false)
		return true	
	else return false end
end

function FleeTask:isValid()
	if not self.parent or self:isComplete() or not self.parent.LastEnemeySeen then return false 
	else return true end
end

function FleeTask:update()
	
	self.parent:setRunning(true)
	
	if(not self:isValid()) then return false end
	self.parent:setSneaking(false)
	
	
	self.parent:walkTo(getFleeSquare(self.parent.player,self.parent.LastEnemeySeen))
	
	
end
