AttemptEntryIntoBuildingTask = {}
AttemptEntryIntoBuildingTask.__index = AttemptEntryIntoBuildingTask

function AttemptEntryIntoBuildingTask:new(superSurvivor,building)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.parent = superSurvivor
	o.Name = "Enter New Building"
	o.OnGoing = false
	o.Window = nil
	o.TryWindow = false
	o.Door = nil
	o.TargetSquare = nil
	o.PreviousSquare = nil
	o.ClimbThroughWindowAttempts = 0
	o.WanderDirection = nil
	o.TicksSinceReversedDir = 0
	o.ReEquipGunOnFinish = false
	o.BreakInAttempts = 0
	o.Toggle = false
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	
	if(building) then o.parent.TargetBuilding = building end
	
	return o

end

function AttemptEntryIntoBuildingTask:OnComplete()
	
	if(self.ReEquipGunOnFinish) then 
		self.parent:reEquipGun() 
		self.parent:setSneaking(false)
	end
	
end

function AttemptEntryIntoBuildingTask:isComplete()
	if(self.parent:inUnLootedBuilding()) or (self.parent.TargetBuilding == nil) or (self.parent:isInBuilding(self.parent.TargetBuilding)) then 
		self.parent:MarkBuildingExplored(self.parent:getBuilding())
		return true
	else return false end
end

function AttemptEntryIntoBuildingTask:isValid()
	if not self.parent or not self.parent.TargetBuilding then return false 
	else return true end
end

function AttemptEntryIntoBuildingTask:giveUpOnBuilding()

	if (self.parent.TargetBuilding ~= nil) then
--		print("giving up on building "..tostring(self.parent.TargetBuilding.ID))
		self.parent:MarkAttemptedBuildingExplored(self.parent.TargetBuilding)
		self.parent.TargetBuilding = nil
		self.TargetSquare = nil
		self.TryWindow = false
	end

end

-- self.parent:getBuildingExplored(self.parent:getBuilding())
function AttemptEntryIntoBuildingTask:update()
	local debugOutput = self.parent.DebugMode

	if(not self:isValid()) then return false end

	-- Idea: try 'wait()' function to test. Confirmed: The NPC will stand still when testing in the other files
	--if (self.parent:inFrontOfLockedDoor()) then
	--	self.parent.TicksSinceSquareChanged = self.parent.TicksSinceSquareChanged + 1
	--	self.parent:Speak("Damnit, the door is blocked off!")--TODO: add localization
	--	self.parent:MarkBuildingExplored(self.parent:getBuilding())
	--	self.TargetSquare = nil
	--	self.parent:walkToDirect(outsidesquare)
	--	self.parent:walkTo(outsidesquare)
	--	self:giveUpOnBuilding() 
	--	self.TryWindow = true
	--else
	--	self.parent.TicksSinceSquareChanged = 0
	--end
	----	if (self.parent:inFrontOfBarricadedWindowAlt()) and (self.Door ~= nil) then 
	--if (self.parent:inFrontOfBarricadedWindowAlt()) then 
	----	self.parent:Speak("This window is blocked off!")
	----	self.parent:MarkBuildingExplored(self.parent:getBuilding())
	------	self.TargetSquare = nil
	----	self.parent:walkToDirect(outsidesquare)
	----	self.parent:walkTo(outsidesquare)
	------	self:giveUpOnBuilding() 
	--end

	--if (self.parent.TicksSinceSquareChanged > 10) and ((self.parent:inFrontOfBarricadedWindowAlt()) or (self.parent:inFrontOfLockedDoor())) then
	--	self:giveUpOnBuilding()
	--	return false
	--end

	-- Let the rest of the code do whatever, but make it where if the window is at least barricaded, 
	-- then make it where the npc actually gives up raiding. Otherwise, the npc will break window like normal. 
	-- But now ^ that code above manages most of the work. 
	
	if(self.parent:getSeenCount() == 0) then self.parent:setSneaking(true) end
	
	if(self.parent:getDangerSeenCount() > 1) or (self.ClimbThroughWindowAttempts > 4) then 
--		print("gave up on building because: (self.ClimbThroughWindowAttempts > 12) or seen zombie close:"..tostring(self.ClimbThroughWindowAttempts))
		self:giveUpOnBuilding() 
	end
	
	if(self.parent:isInAction() == false) then
		
		if(self.TargetSquare == nil) then self.TargetSquare = getRandomFreeBuildingSquare(self.parent.TargetBuilding) end
		
		if(self.TargetSquare ~= nil) then
		
			local door = self.parent:inFrontOfDoor()
			
			if self.TryWindow == false and (door ~= nil) and (door:isLocked() or door:isLockedByKey() or door:isBarricaded()) and (not door:isDestroyed())  then
				--if (not self.parent:isTargetBuildingClaimed(self.parent.TargetBuilding)) then
				--	-- little pig, little pig
				--	door:setIsLocked(false)
				--	door:setLockedByKey(false)
				--else
					self.TryWindow = true
					self.Door = door
				--end
			end
			
			if(self.parent:inFrontOfWindow()) then
				self.TryWindow = true
			end
		
			
			if not self.TryWindow and not self.TryBreakDoor then
				self.parent:DebugSay("Find Unlooted Building Task - trying to get to square inside x" .. tostring(attempts))
				if(self.parent:getWalkToAttempt(self.TargetSquare) < 6) then -- was 10
				if(debugOutput) then self.parent:Speak(tostring(self.parent:getWalkToAttempt(self.TargetSquare))) end
					self.parent:walkToDirect(self.TargetSquare) -- If this doesn't work, use the other
					self.parent:walkTo(self.TargetSquare)
					self.parent:DebugSay("Trying Door!")
				else
					self.TryWindow = true
				end
				
			elseif self.TryWindow then
				if(self.Window == nil) then
				-- If the line below this marked out line doesn't work? change them.
				--	self.Window = getCloseWindow(self.parent.TargetBuilding,self.parent.player)
				--	Update: So far it works. If you want to make NPCs not break the window barricades, use the Alt line
				--	self.Window = self.parent:getUnBarricadedWindowAlt(self.parent.TargetBuilding)
					self.Window = self.parent:getUnBarricadedWindow(self.parent.TargetBuilding)
					self.parent:DebugSay("Trying Window!")
				end
				
				if(not self.Window) then
					
					if(self.parent.LastMeleUsed ~= nil) then
						self.TryWindow = nil
						self.TryBreakDoor = true
						if(self.parent.LastMeleUsed ~= self.parent.player:getPrimaryHandItem()) then self.ReEquipGunOnFinish = true end
						self.parent:reEquipMele()
						return false
					else
						self:giveUpOnBuilding()
						--print("gave up on building because: no window found to try in enter through")
						-- self.parent.player:Say("gave up on building because: no window found to try in enter through")
					end
					
				else
						
					local distanceToWindow = getDistanceBetween(self.Window,self.parent.player)
					
					if distanceToWindow > 1.0 then
						local outsidesquare = getOutsideSquare(self.Window, self.parent.TargetBuilding)
						if(outsidesquare == nil) or (self.parent:getWalkToAttempt(outsidesquare) > 10) then 
							
							self.TryWindow = nil
							self.TryBreakDoor = true
							if(self.parent.LastMeleUsed ~= self.parent.player:getPrimaryHandItem()) then self.ReEquipGunOnFinish = true end
							self.parent:reEquipMele()
							return false
							
						end
						self.parent:walkToDirect(outsidesquare)
					else
						self.parent.player:faceThisObject(self.Window)
						if(self.Window:isSmashed() == false) and (self.Window:IsOpen() == false) then	
							if(self.parent:isInBase()) then 
								self.Window:ToggleWindow(self.parent.player)
							else
								self.parent:DebugSay("AttemptEntryIntoBuildingTask is about to trigger a StopWalk! (Path A) ")
								self.parent:StopWalk()
								ISTimedActionQueue.add(ISSmashWindow:new(self.parent.player, self.Window, 20))
							end
							self.parent:Wait(3)
						else
							if (self.Window:isSmashed()) and (self.Window:isGlassRemoved() == false) and self.parent:hasWeapon() then
								self.parent:DebugSay("AttemptEntryIntoBuildingTask is about to trigger a StopWalk! (Path B) ")
								self.parent:StopWalk()
								ISTimedActionQueue.add(ISRemoveBrokenGlass:new(self.parent.player, self.Window, 20))
								
								self.parent:Wait(1)
							else 
								if(self.Window:getZ() < 2) and ((self.Window:IsOpen() == true) or (self.Window:isGlassRemoved() or (not self.parent:hasWeapon())) ) then
									self.parent:Wait(3)
									self.parent.player:setBlockMovement(false)
									self.parent.player:climbThroughWindow(self.Window)
									self.parent.player:setBlockMovement(true)
									--ISTimedActionQueue.add(ISClimbThroughWindow:new(self.parent.player, self.Window, 0))
									--ISTimedActionQueue.add(ISClimbThroughWindow:new(self.parent.player, self.Window, 0))
									--self.parent.player:hopFence(self.parent.player:getLastdir() , false)
									--self.parent.player:Say("climbing through")
									self.ClimbThroughWindowAttempts = self.ClimbThroughWindowAttempts + 1
								end
							end
						end
					end
					
				end
				
			elseif self.TryBreakDoor then
--				--if(debugOutput) then print( self.parent:getName() .. " " .."on try break down door") end
				local doorSquare = getDoorsOutsideSquare(self.Door,self.parent.player)
				
				if(doorSquare == nil) then 
					self:giveUpOnBuilding()
--				--	print("give up on building because no door")
				end
				
				local distanceToDoor = getDistanceBetween(self.parent.player,doorSquare)
				
				if (distanceToDoor > 1.0) then 
					self.parent:walkToDirect(self.Door)
--					if(debugOutput) then print( self.parent:getName() .. " " .."walking to door") end
				else
					
					if(self.BreakInAttempts > 10) then
						if(debugOutput) then print( self.parent:getName() .. " " .."here i am23") end
						self:giveUpOnBuilding()
--						print("gave up on building because: could not seem to break down door")
					
					else
--						if(debugOutput) then print( self.parent:getName() .. " " .."here i am4") end
						if(self.Door) then self.parent.player:faceThisObject(self.Door) end
						local isInBuilding = (self.parent:getBuilding() == self.TargetBuilding)
						if (self.Door) then --(not isInBuilding) then
	--						if(debugOutput) then print( self.parent:getName() .. " " .."here i am") end
							if(not self.Toggle) or (self.Door == nil) then self.parent:walkTo(self.TargetSquare)
							else self.parent.player:AttemptAttack() end
							
							self.Toggle = not self.Toggle
							self.BreakInAttempts = self.BreakInAttempts + 1
							
						elseif(self.Door == nil) then
--							if(debugOutput) then print( self.parent:getName() .. " " .."in building, complete") end
							return true
						end
					end
					
					
				end
			
			end
	
		else
			self:giveUpOnBuilding()
		end
		
	end
end