FollowRouteTask = {}
FollowRouteTask.__index = FollowRouteTask

function FollowRouteTask:new(superSurvivor, RouteID)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	
	o.Name = "Follow Route"
	o.OnGoing = false
	o.TheRouteID = RouteID
	o.parent = superSurvivor
	
	if(RouteID ~= nil) and (RouteID ~= 0) then
		print("route id "..tostring(RouteID).." set to moddata")
		o.parent:setRouteID(RouteID)
	elseif(o.parent:getRouteID() ~= 0) then
		RouteID = o.parent:getRouteID()
	end
	print("route id :"..tostring(o.parent:getRouteID()))
	o.TheRoute = SurvivorRoutes[RouteID]
	if(o.TheRoute == nil) then 
		print("could not find a route in params or moddata")
		return nil 
	end
	
	local ssX = superSurvivor:Get():getX()
	local ssY = superSurvivor:Get():getY()
	local tempDistance = 0
	local closestSoFar = 9999999
	local tempPoint
	
	for p=1, #o.TheRoute do
		tempPoint = o.TheRoute[p]
		tempDistance = getDistanceBetweenPoints(ssX,ssY,tempPoint["x"],tempPoint["y"])
		if(tempDistance < closestSoFar) then
			o.CurrentRoutePoint = p
			closestSoFar = tempDistance
		end
	end	
	
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	
	return o

end

function FollowRouteTask:isComplete()
	if(not self:isValid()) or (self.CurrentRoutePoint > #self.TheRoute) then return true
	else return false end
end

function FollowRouteTask:isValid()
	if (not self.parent) or (not self.TheRoute) then return false 
	else return true end
end

function FollowRouteTask:update()
	
	if(not self:isValid()) then return false end
	

	if(self.parent:isInAction() == false) then
		local currentPoint = self.TheRoute[self.CurrentRoutePoint]
		local baseSquare = getCell():getGridSquare(currentPoint["x"],currentPoint["y"],currentPoint["z"])
		if(baseSquare) then
			
			if (getDistanceBetween(self.parent:Get(),baseSquare) < 3) then
				self.CurrentRoutePoint = self.CurrentRoutePoint + 1
			else 
				self.parent:walkToDirect(baseSquare)
			end
			
		else
		
			self.parent:walkTowards(currentPoint["x"],currentPoint["y"],currentPoint["z"])
			
		end
	
	end	

end
