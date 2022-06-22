FindBuildingTask = {}
FindBuildingTask.__index = FindBuildingTask

function FindBuildingTask:new(superSurvivor)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.parent = superSurvivor
	o.Name = "Find Building"
	o.OnGoing = true
	o.TargetBuilding = nil
	o.TargetSquare = nil
	o.PreviousSquare = nil
	o.Complete = false
	
	return o

end
function FindBuildingTask:OnComplete()
	self.parent:setSneaking(false)
end
function FindBuildingTask:isComplete()
	return self.Complete 
end

function FindBuildingTask:isValid()
	if not self.parent then return false 
	else return true end
end

function FindBuildingTask:update()
	
	if(not self:isValid()) then return false end
	if(self.parent:getSeenCount() == 0) then self.parent:setSneaking(true) end
	
	if(self.parent:isInAction() == false) then
		
		if(self.TargetSquare == nil) then
		
			local range = 45
			local Square, closestsoFarSquare
			local minx=math.floor(self.parent.player:getX() - range)
			local maxx=math.floor(self.parent.player:getX() + range)
			local miny=math.floor(self.parent.player:getY() - range)
			local maxy=math.floor(self.parent.player:getY() + range)
			local closestsoFar = range
			
			for x=minx, maxx do
				for y=miny, maxy do
					Square = getCell():getGridSquare(x,y,0)
					if(Square ~= nil) and (Square:isOutside() == false) and (Square:getRoom() ~= nil) and (self.parent:getExplore(Square) < 2) then
						local distance = getDistanceBetween(Square,self.parent.player)
						if(distance < closestsoFar) then
							closestsoFar = distance
							self.TargetSquare = Square
							self.TargetBuilding = Square:getRoom():getBuilding()
						end						
					end
				end
			end
			
		end
		
		if self.TargetSquare then -- wander
			
			self.parent.TargetBuilding = self.TargetBuilding
			self.parent:walkTo(self.TargetSquare)
		
		end
		self.Complete = true
	end
end

