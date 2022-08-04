FollowTask = {}
FollowTask.__index = FollowTask

function FollowTask:new(superSurvivor, FollowMeplayer)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	if(FollowMeplayer == nil) then
		if(superSurvivor.player:getModData().FollowCharID ~= nil) then
			local SS = SSM:Get(superSurvivor.player:getModData().FollowCharID)
			if(SS ~= nil) then o.FollowChar = SS:Get()
			else return false end
		end
	else
		o.FollowChar = FollowMeplayer
		superSurvivor.player:getModData().FollowCharID = FollowMeplayer:getModData().ID -- save last follow obj id to mod data so can be reused on load
	end
	
	o.followSS = SSM:Get(o.FollowChar:getModData().ID)
	o.group = o.followSS:getGroup()
	o.InBaseAtStart = superSurvivor:isInBase()
	o.parent = superSurvivor
	o.Name = "Follow"
	o.OnGoing = true
	o.LastDistance = 0
	o.Complete = false
	o.MySeat = -1
	o.FollowDistanceOffset = 0
	
	if(o.group~=nil) then
		--o.FollowDistanceOffset = ((o.group:getFollowCount()-1) * 3)
		o.FollowDistanceOffset = 0
		print(superSurvivor:getName()..": setting distance offset to " .. tostring(o.FollowDistanceOffset))
	end
	
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	return o

end

function FollowTask:isComplete()
	
	return self.Complete
end

function FollowTask:isValid()
	if not self.parent or not self.FollowChar then return false 
	else return true end
end

function FollowTask:needToFollow()
	local distance = getDistanceBetween(self.parent.player,self.FollowChar)
	if self.parent == nil or self.FollowChar == nil or self.FollowChar:getCurrentSquare() == nil then return false end
		if (distance > GFollowDistance+self.FollowDistanceOffset) or (self.parent:getBuilding() ~= self.FollowChar:getCurrentSquare():getBuilding()) or self.parent:Get():getVehicle() or (self.FollowChar:getVehicle() ~= self.parent:Get():getVehicle() ) then 
	--	if (distance > GFollowDistance - (Option_FollowDistance / self.FollowDistanceOffset ) ) or (self.parent:getBuilding() ~= self.FollowChar:getCurrentSquare():getBuilding()) or self.parent:Get():getVehicle() or (self.FollowChar:getVehicle() ~= self.parent:Get():getVehicle() ) then 
		self.parent:NPC_ERW_AroundMainPlayer(Option_FollowDistance) -- ERW stands for 'EnforceRunWalk'
		return true
		else return false end
end


function FollowTask:update()
	
	if(not self:isValid()) then return false end
	
	local distance = getDistanceBetween(self.parent.player,self.FollowChar)
	--if(distance > self.LastDistance) then self.parent:StopWalk() end
	
	self.parent:setSneaking(self.FollowChar:isSneaking()) -- sneaking if perosn you follow is
	--print(self.parent:getName()..": isInAction = "..tostring(self.parent:isInAction()))

	-- they keep talking
	if(ZombRand(70) == 0) then 
		self.parent:Speak(getSpeech("IdleChatter"))  
	end
	
		if(true) then -- self.parent:isInAction() == false) then -- for some reason this is true when they doing nothing sometimes...
		
		if(self.InBaseAtStart == true) and ( not self.parent:isInBase()) then 
			if(ZombRand(2)==0) then 
				self.parent:Speak(getDialogue("WeLooting")) 
			end
			self.InBaseAtStart = false 
		end
		if(not self.InBaseAtStart) and (self.parent:isInBase()) and (self.parent:Get():getVehicle() == nil) then 
			self.Complete = true 
			self.parent:Speak(getActionText("WeBackToBase"))
		end
		
		-- Option_FollowDistance is replacing the "+5" that it normally defaults to, to the in game settings
		-- U7 - Moving that variable to the NPC_ERW_AroundMainPlayer function.
--		if (distance > (GFollowDistance+self.FollowDistanceOffset+5)) or (self.FollowChar:getVehicle() ~= self.parent:Get():getVehicle()) then 
		if (distance < (GFollowDistance+self.FollowDistanceOffset + (Option_FollowDistance / 5 ) )) or (self.FollowChar:getVehicle() ~= self.parent:Get():getVehicle()) then 
			self.parent:setRunning(false)
			self.parent:NPC_EnforceWalkNearMainPlayer() -- New
		else 
			if (distance - (Option_FollowDistance / self.FollowDistanceOffset ) >= (GFollowDistance+self.FollowDistanceOffset )) then
				self.parent:setRunning(true)
			end
		end
	
	
	
			local ropeSquare = nil
		if (self.FollowChar:getZ() > self.parent.player:getZ()) and (self.parent:isInSameBuilding(self.FollowChar) == false) then
			ropeSquare = self.parent:findNearestSheetRopeSquare(false)
			if(ropeSquare) then
				--luautils.walkAdj(self.parent.player, ropeSquare)
				ISTimedActionQueue.add(ISWalkToTimedAction:new(self.parent.player, ropeSquare))
				ISTimedActionQueue.add(ISClimbSheetRopeAction:new(self.parent.player, false))
				self.parent:Wait(4)
								
			else
				--self.parent:Speak("no rope square")
			end
		elseif (self.FollowChar:getZ() < self.parent.player:getZ()) and (self.parent:isInSameBuilding(self.FollowChar) == false) then
			ropeSquare = self.parent:findNearestSheetRopeSquare(true)
			if(ropeSquare) then
				--self.parent:Speak("here i am")
				local window = getSquaresNearWindow(ropeSquare)
				if(window) then
					self.parent:DebugSay("FollowTask is about to trigger a StopWalk! Path A")
					self.parent:StopWalk()
					local indoorSquare = window:getIndoorSquare()
					ISTimedActionQueue.add(ISWalkToTimedAction:new(self.parent.player, indoorSquare))
					ISTimedActionQueue.add(ISClimbThroughWindow:new(self.parent.player, window, 20))
					--ISTimedActionQueue.add(ISClimbSheetRopeAction:new(self.parent.player, true))
					self.parent:Wait(4)
				end
				
			else
				--self.parent:Speak("no rope square")
			end		
		end
		
		if not ropeSquare then
			--print(self.parent:getName()..tostring(self.FollowChar:getVehicle() ~= nil) .. " and " .. tostring(self.parent:Get():getVehicle() == nil))
			if (distance > (GFollowDistance+self.FollowDistanceOffset)) and (self.parent:Get():getVehicle() == nil) then
				
				local gotosquare = self.FollowChar:getCurrentSquare()
				if(gotosquare ~= nil) then
					if(gotosquare:getRoom() ~= nil) and (gotosquare:getRoom():getBuilding() ~= nil) then self.parent.TargetBuilding = gotosquare:getRoom():getBuilding()
					else self.parent.TargetBuilding = nil end
					self.parent:walkTo(gotosquare) 	
					--self.parent.player:getPathFindBehavior2():pathToCharacter(self.FollowChar)
					--self.parent.player:Say("walkTo")
				end
			elseif (self.FollowChar:getVehicle() ~= nil) and (self.parent:Get():getVehicle() == nil) then
				print(self.parent:getName().." get in car")
				local car = self.FollowChar:getVehicle()
				self.MySeat = -1
				local doorseat = -1
				local lastgoodDoor = nil
				local tempDoor = nil
				local numOfSeats = car:getScript():getPassengerCount()
				print(self.parent:getName().."number of seats: " .. tostring(numOfSeats))
				 for seat = numOfSeats-1, 1, -1  do
					tempDoor = car:getPassengerDoor(seat)
					if(tempDoor ~= nil) then
						lastgoodDoor = tempDoor 
						if (car:isSeatOccupied(seat) == false) then doorseat = seat end
					end
					if(self.MySeat == -1) and (car:isSeatOccupied(seat) == false) then
						self.MySeat = seat 
						print(self.parent:getName().."my seat is " .. tostring(seat))						
					end
					if(doorseat ~= -1) and (self.MySeat ~= -1) then break end
				end
				print("door seat is " .. tostring(doorseat))
				print(self.parent:getName()..tostring(self.MySeat)..","..tostring(lastgoodDoor))
				if(self.MySeat ~= -1) then 
				
					local doorsquare
					
					doorsquare = lastgoodDoor
					
					if(doorsquare ~= nil) then
						self.parent:DebugSay("FollowTask is about to trigger a StopWalk! Path B")
						self.parent:StopWalk()
						print(self.parent:getName()..": adding enter vehicle timed actions and waiting")
						ISTimedActionQueue.add(ISWalkToTimedAction:new(self.parent:Get(),doorsquare))						
						ISTimedActionQueue.add(ISEnterVehicle:new(self.parent:Get(), self.FollowChar:getVehicle(), doorseat))
						ISTimedActionQueue.add(ISSwitchVehicleSeat:new(self.parent:Get(), self.MySeat))
						self.parent:Wait(4)
						
					end
					
				end
			elseif (self.FollowChar:getVehicle() ~= nil) and (self.parent:Get():getVehicle() ~= nil) then
				--print(self.parent:getName().." switch seat")
				--ISTimedActionQueue.add(ISSwitchVehicleSeat:new(self.parent:Get(), self.MySeat))
			elseif (self.FollowChar:getVehicle() == nil) and (self.parent:Get():getVehicle() ~= nil) then
				print(self.parent:getName().." exit vehicle")
				self.MySeat = -1
				ISTimedActionQueue.add(ISExitVehicle:new(self.parent:Get()))
				self.parent:Wait(1)
			else
				--self.parent:Speak("ELSE")
			end
		
		end
		
		
		
	else
		--self.parent.player:Say("waiting for non-action "..tostring(self.parent.player:getCharacterActions())..","..tostring(self.parent.player:getModData().bWalking))
	end
	
	self.LastDistance = distance

end
