FirstAideTask = {}
FirstAideTask.__index = FirstAideTask

function FirstAideTask:new(superSurvivor)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.parent = superSurvivor
	o.Name = "First Aide"
	o.OnGoing = false
	o.parent:StopWalk()
	o.myTimedAction = nil
	o.Ticks = 0
	o.WorkingBP = nil
	o.WorkingItem = nil
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	return o

end

function FirstAideTask:isComplete()
	if self.parent:HasInjury() then
		return false 
	else return true end 
end

function FirstAideTask:isValid()
	if (not self.parent) or (not self.parent:HasInjury()) then 
	print(self.parent:getName()..": First aide task not valid")
	return false 
	else return true end
end

function FirstAideTask:update()
	
	if(not self:isValid()) then return false end
	if(not self.parent:isInAction() == false) then 
		print("is in action")
		return false 
	end
	
	local bodyparts = self.parent.player:getBodyDamage():getBodyParts()
	
	for i=0, bodyparts:size()-1 do
		local bp = bodyparts:get(i)
		if(bp:HasInjury()) and (bp:bandaged() == false) then
			self.WorkingBP = bp
			self.parent:RoleplaySpeak(getActionText("BandageBP_Before") .. tostring(BodyPartType.getDisplayName(bp:getType())).. getActionText("BandageBP_After"))
			local item 			
			item = self.parent.player:getInventory():getItemFromType("RippedSheets")
			if(item == nil) then item = self.parent.player:getInventory():AddItem("Base.RippedSheets") end
			self.WorkingItem = item;
			--print(self.parent:getName()..": adding apply bandage TA")
			self.parent:DebugSay("FirstAideTask is about to trigger a StopWalk! Path B")
			self.parent:StopWalk()
			self.myTimedAction = ISApplyBandage:new(self.parent.player, self.parent.player, item, bp, true)
			if(not self.myTimedAction) then print("failed to create timed action apply bandage") end
			ISTimedActionQueue.add(self.myTimedAction)
			self.parent:Wait(3)
			break
		end
		
	end
	
	if(self.Ticks == nil)	 then self.Ticks = 0 end -- hack job fix to overcome characters freezing and not performing timed actions
	self.Ticks = self.Ticks + 1
	if(self.Ticks == 10) then
		local playerObj = self.parent:Get()
		if(playerObj.setAnimVariable ~= nil) then
			playerObj:setAnimVariable("BandageType", "UpperBody")
			playerObj:setOverrideHandModels(nil, nil);
		end
	--print("startomg force performing stuck first aide task")
	elseif(self.Ticks > 20) then
		--o.myTimedAction:perform()
		 self.parent:Get():getBodyDamage():SetBandaged(self.WorkingBP:getIndex(), true, 50, self.WorkingItem:isAlcoholic(), self.WorkingItem:getModule() .. "." .. self.WorkingItem:getType());
        self.parent:Get():getInventory():Remove(self.item)        
		--print("force performing stuck first aide task")
		self.Ticks = 0
	end
end

