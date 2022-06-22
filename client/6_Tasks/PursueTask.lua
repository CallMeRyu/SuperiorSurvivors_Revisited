PursueTask = {}
PursueTask.__index = PursueTask

function PursueTask:new(superSurvivor, target)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	if(target ~= nil) then o.Target = target
	else o.Target = self.LastEnemeySeen end 
	
	o.SwitchBackToMele = false
	o.Complete = false
	o.parent = superSurvivor
	o.Name = "Pursue"
	o.OnGoing = false
	o.LastSquareSeen = o.Target:getCurrentSquare()
	local ID = o.Target:getModData().ID
	o.TargetSS = SSM:Get(ID)
	if(not o.TargetSS) then 
		o.Complete = true
		return nil 
	end
	if(o.TargetSS:getBuilding()~= nil) then o.parent.TargetBuilding = o.TargetSS:getBuilding() end
	
	if(superSurvivor.LastGunUsed ~= nil) and (superSurvivor:Get():getPrimaryHandItem() ~= superSurvivor.LastGunUsed) then
		o.SwitchBackToMele = true
		o.parent:reEquipGun()
	end
	
	return o

end

function PursueTask:OnComplete()
	if(self.SwitchBackToMele) then self.parent:reEquipMele() end
end

function PursueTask:isComplete()
	if (not self.Target) or self.Target:isDead() or (self.parent:HasInjury()) or self.parent:isEnemy( self.Target) == false then return true
	else return self.Complete end
end

function PursueTask:isValid()
	if (not self.parent) or (not self.Target) then return false 
	else return true end
end

function PursueTask:update()

	if(not self:isValid()) or (self:isComplete()) then return false end
	
	if self.parent:hasGun() then 					-- Despite the name, it means 'has gun in the npc's hand'
		if (self.parent:needToReadyGun(weapon)) then
			self.parent:ReadyGun(weapon)
			return false
		end
	end
	
	self.parent:NPC_ManageLockedDoors() -- To be sure the NPC doesn't get stuck in front of doors
	
	if(self.parent.player:CanSee(self.Target) == false) then
		
		
		local distancetoLastSpotSeen = getDistanceBetween(self.LastSquareSeen,self.parent.player)
		if(distancetoLastSpotSeen > 2.5) then
			
			self.parent:walkToDirect(self.LastSquareSeen)
			
			if(ZombRand(4) == 0) and (self.parent:isSpeaking() == false) then
				self.parent:Speak(getSpeech("SawHimThere"))
			end
			
		else
			
		--	self.parent:setRunning(false)
			self.Complete = true
			self.parent:Speak(getText("ContextMenu_SD_WhereHeGo"))
		end
		
	else
		local theDistance = getDistanceBetween(self.Target, self.parent.player)
		
		self.LastSquareSeen = self.Target:getCurrentSquare()
		
		if(self.TargetSS) and (self.TargetSS:getBuilding()~= nil) then 
			self.parent.TargetBuilding = self.TargetSS:getBuilding() 
		end
		self.parent:walkToDirect(self.Target:getCurrentSquare())
	end
	
	
		
	
	
end
