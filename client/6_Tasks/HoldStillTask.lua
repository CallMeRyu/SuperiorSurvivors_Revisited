HoldStillTask = {}
HoldStillTask.__index = HoldStillTask

function HoldStillTask:new(superSurvivor, playerInitiated)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.wasplayerInitiated = playerInitiated
	o.Aite = TalkToMe
	o.parent = superSurvivor
	o.Name = "Hold Still"
	o.OnGoing = true
	o.Ticks = 0
	o.Spoke = false
	o.Complete = false
	o.parent:DebugSay("HoldStillTask is about to trigger a StopWalk! ")
	o.parent:StopWalk()
	o.parent:setWalkingPermitted(false)
	o.playerMoved = false
	superSurvivor:Speak("!?")
	if(playerInitiated) then o.playerSquare = getSpecificPlayer(0):getCurrentSquare() end
	
	return o

end

function HoldStillTask:isComplete()
	if self.Complete or (self.parent:getDangerSeenCount() > 0) then
		self.parent:setWalkingPermitted(true)
		return true
	else
		return false
	end
end

function HoldStillTask:isValid()
	if not self.parent then return false 
	else return true end
end

function HoldStillTask:setComplete()
	self.Complete = true
end

function HoldStillTask:update()
	
	if(not self:isValid()) or (self.parent:getDangerSeenCount() > 0) or ((self.wasplayerInitiated == true) and (self.playerMoved == true))  then 
		self.Complete = true
		return false 
	end
	
	self.Ticks = self.Ticks + 1
	if (self.wasplayerInitiated and (self.playerSquare ~= nil)) then
	
		local tsquare = getSpecificPlayer(0):getCurrentSquare()
		if(tsquare ~= self.playerSquare) then self.playerMoved = true end
		
	end
	
	if(self.parent:isInAction()) then
		self.parent:DebugSay("HoldStillTask is about to trigger a StopWalk! Path B")
		self.parent:StopWalk()	
	
	end

end
