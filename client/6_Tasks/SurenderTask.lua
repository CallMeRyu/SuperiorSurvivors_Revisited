SurenderTask = {}
SurenderTask.__index = SurenderTask

function SurenderTask:new(superSurvivor, enemy)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	superSurvivor:DebugSay("SurenderTask is about to trigger a StopWalk! ")
	superSurvivor:StopWalk()
	o.parent = superSurvivor
	o.Name = "Surender"
	o.OnGoing = true
	o.AlreadyDroppedGoods = false
	o.enemy = enemy
	o.DangerTicks = 0
	o.NowSafeTicks = 0
	o.TaskTicks = 0
	return o

end

function SurenderTask:isComplete()
	--return true
	--if(instanceof(enemy,"IsoPlayer")) then return true end
	if (self.TaskTicks < 3) then return false end  -- want the surender animation to at least start and get hands up even if conditions are not met before finishing
	
	local facingResult = self.enemy.player:getDotWithForwardDirection(self.parent.player:getX(),self.parent.player:getY())
	
	local result = (not (self.enemy.player:isAiming() 
	and (self.enemy:usingGun() or (not ASuperSurvivor:RealCanSee(self.enemy) and getDistanceBetween(self.enemy,self.parent.player) <=3 ) )
	and self.enemy.player:CanSee(self.parent.player) and facingResult > 0.95 and (self.parent:isEnemy(self.enemy.player) or ((not self.parent:isInGroup(self.enemy.player)) and self.enemy.player:isLocalPlayer() and IsoPlayer.getCoopPVP()))
	and getDistanceBetween(self.parent.player,self.enemy.player) < 6 ) 
	and (self.NowSafeTicks < 5) )
	print("SurenderTask:isComplete:"..tostring(result))
	return result
end

function SurenderTask:isValid()
	if not self.parent then return false 
	else return true end
end

function SurenderTask:update()
	
	self.TaskTicks = self.TaskTicks + 1
	if(not self:isValid()) then return false end
	
		if((self.enemy.player:isAiming() and self.enemy:usingGun() and (self.parent:isEnemy(self.enemy.player) or (self.enemy.player:isLocalPlayer() and IsoPlayer.getCoopPVP())) and getDistanceBetween(self.parent.player,self.enemy.player) < 6 )) then
			self.DangerTicks = self.DangerTicks + 1
			self.NowSafeTicks = 0
		else
			self.NowSafeTicks = self.NowSafeTicks + 1
			self.DangerTicks = 0
		end
		
		if(self.parent:isInAction() == false) then
			local TA = ISSurenderAction:new(self.parent.player,self.parent.enemy)
			ISTimedActionQueue.add(TA)
			--self.parent.player:SetVariable("LootPosition", "Mid")
		end

end
