DoctorTask = {}
DoctorTask.__index = DoctorTask

function DoctorTask:new(superSurvivor)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.parent = superSurvivor
	o.Patient = nil
	o.Name = "Doctor"
	o.OnGoing = false
	o.Complete = false
	o.ReturnSquare = superSurvivor:Get():getCurrentSquare()
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
		
	return o

end

function DoctorTask:isComplete()
	return self.Complete
end

function DoctorTask:isValid()
	if (not self.parent) then return false 
	else return true end
end

function DoctorTask:FindPatient()

	local player = self.parent.player
	local patient = nil
	local range = 15;
	local Square, closestsoFarSquare;
	local minx=math.floor(player:getX() - range);
	local maxx=math.floor(player:getX() + range);
	local miny=math.floor(player:getY() - range);
	local maxy=math.floor(player:getY() + range);
	local closestsoFar = range;
	
	for x=minx, maxx do
		for y=miny, maxy do
			Square = getCell():getGridSquare(x,y,player:getZ())
			if(Square ~= nil) then
				local distance = getDistanceBetween(Square,player)
				local closeobjects = Square:getMovingObjects()
				for i=0, closeobjects:size()-1 do
					local obj = closeobjects:get(i)
					if (obj ~= nil) then 
						if (instanceof(obj,"IsoPlayer") and (self.parent.player:CanSee(obj)) and (obj:isDead() == false) and (obj:getModData().isHostile ~= true) and RequiresTreatment(obj) and (distance < closestsoFar) ) then
							patient = obj
						end
					end
				end
			end
		end
	end
	
	return patient

end

function DoctorTask:update()
	
	if(not self:isValid()) then return false end
	if(not self.parent:isInAction() == false) then return false end
	
	if(self.Patient ~= nil) then 
		
		if(self.Patient:isDead()) then
			self.parent:Speak(getDialogue("RIPSurvivor"))
			self.Patient = nil
			return false
		end
	
		local distance = getDistanceBetween(self.Patient,self.parent:Get())
	
		if(distance < 2.0) then 
			
			local bodyparts = self.Patient:getBodyDamage():getBodyParts() 
			local foundbodypartneedingtreatment = false
			for i=0, bodyparts:size()-1 do
				local bp = bodyparts:get(i)
				local treatment = DoctorDetermineTreatement(bp)
				
				
				if treatment ~= "None" and (self.Patient ~= nil) then
					local doctor = self.parent:Get()
					
					local alcohol = doctor:getInventory():FindAndReturn("AlcoholWipes")
					if(alcohol == nil) then alcohol = doctor:getInventory():AddItem("Base.AlcoholWipes") end
					local bandage = doctor:getInventory():FindAndReturn("Bandage")
					if(bandage == nil) then bandage = doctor:getInventory():AddItem("Base.Bandage") end
					local rippedsheets = doctor:getInventory():FindAndReturn("RippedSheets")
					if(rippedsheets == nil) then rippedsheets = doctor:getInventory():AddItem("Base.RippedSheets") end
								
					foundbodypartneedingtreatment = true	
					self.parent:DebugSay("DoctorTask is about to trigger a StopWalk! ")
					self.parent:StopWalk()
					if treatment == "Splint" then 
						self.parent:RoleplaySpeak(getActionText("DoctorSplint"))
						ISTimedActionQueue.add(ISSplint:new(doctor, self.Patient, rippedsheets, doctor:getInventory():AddItem("Base.Plank"), bp, true))
					elseif treatment == "Bandage Removal" then 
						self.parent:RoleplaySpeak(getActionText("DoctorBandageRemove"))
						ISTimedActionQueue.add(ISApplyBandage:new(doctor, self.Patient, bandage, bp, false))
					elseif treatment == "Stich" then 
						self.parent:RoleplaySpeak(getActionText("DoctorStitches"))
						ISTimedActionQueue.add(ISStitch:new(doctor, self.Patient, doctor:getInventory():AddItem("Base.SutureNeedle"), bp, true))
					elseif treatment == "Remove Glass" then 
						self.parent:RoleplaySpeak(getActionText("DoctorGlass"))
						ISTimedActionQueue.add(ISRemoveGlass:new(doctor, self.Patient, bp))
					elseif treatment == "Remove Bullet" then 
						self.parent:RoleplaySpeak(getActionText("DoctorBullet"))
						ISTimedActionQueue.add(ISRemoveBullet:new(doctor, self.Patient, bp))
					elseif treatment == "Bandage" then 						
						ISTimedActionQueue.add(ISDisinfect:new(doctor, self.Patient, alcohol, bp))
						self.parent:RoleplaySpeak(getActionText("DoctorBandage"))
						ISTimedActionQueue.add(ISApplyBandage:new(doctor, self.Patient, bandage, bp, true))
					
					end
				
				end
			end
			
			if(foundbodypartneedingtreatment == false) then
				self.parent:Speak(getActionText("SD_DoctorDone"))
				self.parent:Get():StopAllActionQueue()
				if(self.Patient ~= nil) then 
					local ID = self.Patient:getModData().ID
					if(ID ~= nil) then
						local SS = SSM:Get(ID)
						local TM = SS:getTaskManager()
						local Task = TM:getTask()
						if Task ~= nil and Task.Name == "Hold Still" then Task:setComplete() end
					end
					self.Patient = nil 	
				end
			end
			
		else
			self.parent:Speak(getActionText("SD_HoldStill"))
			self.parent:walkTo(self.Patient:getCurrentSquare())
		end
	else 
		self.Patient = self:FindPatient()
		
		if(self.Patient == nil) and (self.parent:Get():getCurrentSquare() ~= self.ReturnSquare) then
			self.parent:walkToDirect(self.ReturnSquare)
		elseif (self.Patient ~= nil) and (self.Patient ~= self.parent:Get()) then
			local ID = self.Patient:getModData().ID
			if(ID ~= nil) and (ID ~= 0) then
				local SS = SSM:Get(ID)
				local TM = SS:getTaskManager()
				local Task = TM:AddToTop(HoldStillTask:new(SS,false))		
			end
		end
	end
			
	
end

