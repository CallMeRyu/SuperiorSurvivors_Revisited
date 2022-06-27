ReturnToBaseTask = {}
ReturnToBaseTask.__index = ReturnToBaseTask

function ReturnToBaseTask:new(superSurvivor)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	o.parent = superSurvivor
	o.Name = "Return To Base"
	o.OnGoing = false
	o.GroupID = superSurvivor:getGroupID()
	if(not o.GroupID) then
		superSurvivor:DebugSay("no group id")
		return nil 
	end
	o.Group = SSGM:Get(o.GroupID)
	o.BaseCoords = o.Group:getBaseCenterCoords()
	
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
		
	return o

end

function ReturnToBaseTask:isComplete()
	if(not self:isValid()) or self.parent:isInBase() or (self.BaseCoords == nil or self.BaseCoords[1] == nil or self.BaseCoords[2] == nil or self.BaseCoords[3] == nil) then return true
	else return false end
end

function ReturnToBaseTask:isValid()
	if (not self.parent) or (not self.parent:getGroupID()) then return false 
	else return true end
end

function ReturnToBaseTask:update()
	
	if(not self:isValid()) then return false end
	

	if(self.parent:isInAction() == false) then
		local baseSquare = getCell():getGridSquare(self.BaseCoords[1],self.BaseCoords[2],self.BaseCoords[3])
		if(baseSquare) then
			self.parent:walkTo(baseSquare)
		else
			local cs = self.parent:Get():getCurrentSquare()
			if(not cs) or (not cs:IsOnScreen()) then
				self.parent.player:setX(self.BaseCoords[1])
				self.parent.player:setY(self.BaseCoords[2])
				self.parent.player:setZ(self.BaseCoords[3])
				self.parent:SaveSurvivorOnMap()
			else
				self.parent:walkTowards(self.BaseCoords[1],self.BaseCoords[2],self.BaseCoords[3])
			end
		end
	
	end	

end
