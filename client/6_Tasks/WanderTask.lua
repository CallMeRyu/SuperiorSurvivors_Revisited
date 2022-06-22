WanderTask = {}
WanderTask.__index = WanderTask

function WanderTask:new(superSurvivor)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.parent = superSurvivor
	o.Name = "Wander"
	o.OnGoing = true
	
	return o

end

function WanderTask:isComplete()
	return false
end

function WanderTask:isValid()
	if not self.parent then return false 
	else return true end
end

function WanderTask:update()
	
	if(not self:isValid()) then return false end
	
	if(self.parent:isInAction() == false) then
		--print("walking survivor:"..tostring(self.parent:getID()));
		local sq = getCell():getGridSquare(self.parent.player:getX() + ZombRand(-10,10),self.parent.player:getY() + ZombRand(-10,10),self.parent.player:getZ());
		if(sq ~= nil) then self.parent:walkTo(sq); 
		else print("error getting walk sq") end
	
	end

end
