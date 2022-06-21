AttackTask = {}
AttackTask.__index = AttackTask

function AttackTask:new(superSurvivor)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.parent = superSurvivor
	o.Name = "Attack"
	o.OnGoing = false
	--o.parent:Speak("starting attack")
	
	return o

end

function AttackTask:isComplete()
	--self.parent.player:Say( tostring(self.parent:needToFollow()) ..",".. tostring(self.parent:getDangerSeenCount() > 0) ..",".. tostring(self.parent.LastEnemeySeen) ..",".. tostring(not self.parent.LastEnemeySeen:isDead()) ..",".. tostring(self.parent:HasInjury() == false) )
	if(not self.parent:needToFollow()) and ((self.parent:getDangerSeenCount() > 0) or (self.parent:isEnemyInRange(self.parent.LastEnemeySeen) and self.parent:hasWeapon())) and (self.parent.LastEnemeySeen) and not self.parent.LastEnemeySeen:isDead() and (self.parent:HasInjury() == false) then 
		return false
	else 
		self.parent:DebugSay("Is complete for AttackTask is Returning TRUE" )
		self.parent:StopWalk()
		return true 
	end
end

function AttackTask:isValid()
	if (not self.parent) or (not self.parent.LastEnemeySeen) or (not self.parent:isInSameRoom(self.parent.LastEnemeySeen)) or (self.parent.LastEnemeySeen:isDead()) then 
			return false 
		else 
			self.parent:DebugSay("Is Valid for AttackTask is Returning TRUE" )
			return true 
	end
end

function AttackTask:update()

	-- Controls the Range of how far / close the NPC should be
	if self.parent:hasGun() then 								-- Despite the name, it means 'has gun in the npc's hand'
		self.parent:NPC_MovementManagement_Guns() 				-- To move around, it checks for in attack range too
	else
		self.parent:NPC_MovementManagement() 					-- For melee movement management
	end
	
	if(not self:isValid()) or (self:isComplete()) then return false end
	
	local theDistance = getDistanceBetween(self.parent.LastEnemeySeen, self.parent.player)
	local minrange = self.parent:getMinWeaponRange()
	local NPC_AttackRange = self.parent:isEnemyInRange(self.parent.LastEnemeySeen)
	
	-- Controls if the NPC is litreally running or walking state.
	self.parent:NPC_ShouldRunOrWalk()

	if (NPC_AttackRange) or (theDistance <= minrange) or (theDistance < 0.65) then
			local weapon = self.parent.player:getPrimaryHandItem()

			if(not weapon or (not self.parent:usingGun()) or ISReloadWeaponAction.canShoot(weapon))  then			

				if (self.parent:hasGun()) then 						-- Gun related conditions
					if (not self.parent:needToReadyGun(weapon)) then
						if (self.parent:Is_AtkTicksZero()) then
							self.parent:Attack(self.parent.LastEnemeySeen) 
						else
							self.parent:AtkTicks_Countdown()
						end
					else
						self.parent:ReadyGun(weapon)
					end
					
				else 												-- Melee related conditions
					if (self.parent:Is_AtkTicksZero()) then
						self.parent:NPC_Attack(self.parent.LastEnemeySeen)
					else
						self.parent:AtkTicks_Countdown()
					end
				end	
				
			elseif(self.parent:usingGun()) then
				if(self.parent:ReadyGun(weapon) == false) then 
					self.parent:reEquipMele() 
				end
			end	
		
	elseif(self.parent:isWalkingPermitted()) then
	
		self.parent:NPC_ManageLockedDoors() -- To prevent getting stuck in doors
		--self.parent:NPC_MovementManagement() -- To move around 
		
	else
		self.parent:DebugSay("ATTACK TASK - something is wrong")
	end
	return true
	
end
