FleeFromHereTask = {}
FleeFromHereTask.__index = FleeFromHereTask

function FleeFromHereTask:new(superSurvivor,fleeFromHere)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	superSurvivor:setRunning(true)
	o.parent = superSurvivor
	o.Name = "Flee From Spot"
	o.OnGoing = false
	o.fleeFromHere = fleeFromHere
	if o.parent.TargetBuilding ~= nil then o.parent:MarkAttemptedBuildingExplored(o.parent.TargetBuilding) end -- otherwise he just keeps running back to the building though the threat likely lingers there
	
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	
		return o

end

function FleeFromHereTask:isComplete()
	if getDistanceBetween(self.parent.player, self.fleeFromHere) > Option_Panic_Distance then -- Option_Panic_Distance replaced what was previously valued '30'
		self.parent:StopWalk()		
		self.parent:setRunning(false)
		return true	
	else return false end
end

function FleeFromHereTask:isValid()
	if not self.parent or self:isComplete() then return false 
	else return true end
end

function FleeFromHereTask:update()
	
	if(not self:isValid()) then return false end
	self.parent:setSneaking(false)
	self.parent:setRunning(true)
	
	self.parent:walkTo(getFleeSquare(self.parent.player,self.fleeFromHere))
	self.parent:NPC_EnforceWalkNearMainPlayer()

end
