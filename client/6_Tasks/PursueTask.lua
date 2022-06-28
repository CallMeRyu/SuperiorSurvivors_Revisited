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
	
--	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	
	return o

end

function PursueTask:OnComplete()
	if(self.SwitchBackToMele) then self.parent:reEquipMele() end
	
	--if (self.parent.LastEnemeySeen ~= nil) and (self.parent.player ~= nil) then
	--	local theDistance = getDistanceBetween(self.parent.LastEnemeySeen, self.parent.player)
	--	local minrange = self.parent:getMinWeaponRange()
	--	
	--	if (theDistance <= minrange) then
	--		self.parent:StopWalk()
	--		self.parent:DebugSay("Pursure done")
	--	end
	--end
end

function PursueTask:isComplete()	
	if (not self.Target) or self.Target:isDead() or (self.parent:HasInjury()) or self.parent:isEnemy( self.Target) == false then return true
	else 
		return self.Complete 
	end
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
	
	
	
	if(self.parent.player:CanSee(self.Target) == false) then
		
		
		local distancetoLastSpotSeen = getDistanceBetween(self.LastSquareSeen,self.parent.player)
		if(distancetoLastSpotSeen > 2.5) then
			
			self.parent:walkToDirect(self.LastSquareSeen)
			self.parent:NPC_ShouldRunOrWalk()
			self.parent:NPC_EnforceWalkNearMainPlayer()
			
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
		
		self.parent:NPC_ShouldRunOrWalk()
		self.parent:NPC_EnforceWalkNearMainPlayer()
	end
	
	
		
	
	
end
