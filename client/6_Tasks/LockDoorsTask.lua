LockDoorsTask = {}
LockDoorsTask.__index = LockDoorsTask

function LockDoorsTask:new(superSurvivor, lock)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.Lock = lock
	o.parent = superSurvivor
	o.Name = "Lock Doors"
	o.OnGoing = true
	o.TargetBuilding = nil
	o.TargetSquare = nil
	o.PreviousSquare = nil
	o.Complete = false
	
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
		
	return o

end

function LockDoorsTask:isComplete()
	return self.Complete
end

function LockDoorsTask:isValid()
	if not self.parent then return false 
	else return true end
end

function LockDoorsTask:update()
	
--	if(self.parent.DebugMode) then print(self:getName().."LockDoorsTask update") end
	if(not self:isValid()) then return false end
	
	if(self.parent:isInAction() == false) then
		
		local door;
			local building = self.parent:getBuilding();
			if(building ~= nil) then 
				
				door = getUnlockedDoor(building,self.parent.player)
				if(not door) then 
					self.parent:DebugSay("door NOT found") 
					self.Complete = true
					return false
				else 
					self.parent:DebugSay("door found") 
				end
				
			else 
				self.parent:DebugSay("building nil") 
				self.Complete = true
				return false						
			end
			
			
			local distance = getDistanceBetween(self.parent.player, getDoorsInsideSquare(door));
			if(distance > 2) or (self.parent.player:getZ() ~= door:getZ()) then
				self.parent:DebugSay("walking to door")
				self.parent:walkToDirect(getDoorsInsideSquare(door))				
			else
				if(door:IsOpen()) then
					door:ToggleDoor(self.parent.player)
				else
					self.parent:DebugSay("locking door")				
					self.parent.player:getEmitter():playSound("LockDoor", false);
					door:setIsLocked(true)
				end
				
			end
		
		
	end
end

