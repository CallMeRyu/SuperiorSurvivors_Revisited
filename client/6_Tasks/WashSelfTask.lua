WashSelfTask = {}
WashSelfTask.__index = WashSelfTask

function WashSelfTask:new(superSurvivor)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	if(superSurvivor == nil) then return nil end
	o.parent = superSurvivor
	o.Name = "Wash Self"
	o.OnGoing = false
	
	if(not superSurvivor.player:getCurrentSquare()) then
		o.Complete = true
		return nil 
	end
	o.TargetItem = nil
	o.Complete = false
	o.WasSuccessful = false
	
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	superSurvivor:RoleplaySpeak(getActionText("LookForItem_Before").."Wash Water"..getActionText("LookForItem_After"))
	return o

end

function WashSelfTask:isComplete()
	return self.Complete
end

function WashSelfTask:isValid()
	return true 
end

function WashSelfTask:getWasSuccessful()
	return self.WasSuccessful
end

function WashSelfTask:update()

	if(getSpecificPlayer(0):isAsleep()) then return false end
	if(not self:isValid()) or self.parent:getDangerSeenCount() > 0 then
		--self.parent:Speak("completing")
		self.Complete = true
		return false 
	end
	
	if(self.parent:isInAction()) then
		--self.parent:Speak("waiting for non action")
		return false 
	end
	
	
	if(self.TargetItem == nil) then 
		--print("going to WashSelfNearBy:"..self.itemtype)
		self.TargetItem = self.parent:FindThisNearBy("WashWater", "Category")
	end
	
	if(self.TargetItem == nil) then
		self.Complete = true
		if(self.WasSuccessful == false) then 
			self.parent:RoleplaySpeak(getActionText("NoFindItem_Before").."Wash Water"..getActionText("NoFindItem_After")) 
		end
		return false
	end
	
	
	local distance, targetSquare
	if(instanceof(self.TargetItem,"InventoryItem")) and (self.TargetItem:getWorldItem() ~= nil) then 
		targetSquare = self.TargetItem:getWorldItem():getSquare() 
	elseif(instanceof(self.TargetItem,"IsoObject")) and (self.TargetItem:getSquare() ~= nil) then 
		targetSquare = self.TargetItem:getSquare() 
	elseif(instanceof(self.TargetItem,"InventoryItem")) and (self.TargetItem:getContainer() ~= nil) then 
		targetSquare = self.TargetItem:getContainer():getSourceGrid() 
	end
	
	if(not targetSquare) then
		print("error cannot locate location of returned item")
		--self.Complete = true
		self.TargetItem = nil
		self.Complete = true
		return false
	else
		--self.parent:Speak("here i am")
		distance = getDistanceBetween(targetSquare,self.parent:Get())
		
		if(distance > 2.0) then 
			self.parent:walkTo(targetSquare)
		else
            -- Copied most of this from Aiteron's NPC mod
			local inv = self.parent.player:getInventory()
            
            local waterRemaining = self.TargetItem:getWaterAmount()
            local soapList = {}

			local items = inv:getItems() ;
			if(items) then
				for i=1, items:size()-1 do
                    local item = items:get(i)
                    if string.match(item:getDisplayName(), "Soap") or string.match(item:getDisplayName(), "Cleaning") then
                        table.insert(soapList, item)
                    end
                end
            end

            ISTimedActionQueue.add(ISWashYourself:new(self.parent.player, self.TargetItem, soapList))

            local soapRemaining = ISWashClothing.GetSoapRemaining(soapList)
            waterRemaining = self.TargetItem:getWaterAmount()
            
			if(items) then
				for i=1, items:size()-1 do
                    local item = items:get(i)
                    local bloodAmount = 0
                    local dirtAmount = 0
                    if instanceof(item, "Clothing") then
                        if BloodClothingType.getCoveredParts(item:getBloodClothingType()) then
                            local coveredParts = BloodClothingType.getCoveredParts(item:getBloodClothingType())
                            for j=0, coveredParts:size()-1 do
                                local thisPart = coveredParts:get(j)
                                bloodAmount = bloodAmount + item:getBlood(thisPart)
                            end
                        end
                        if item:getDirtyness() > 0 then
                            dirtAmount = dirtAmount + item:getDirtyness()
                        end
                    elseif instanceof(item, "Weapon") then
                        bloodAmount = bloodAmount + item:getBloodLevel()
                    end

                    if (bloodAmount > 0 or dirtAmount > 0) then
                        if waterRemaining > ISWashClothing.GetRequiredWater(item) then
                            waterRemaining = waterRemaining - ISWashClothing.GetRequiredWater(item)

                            local noSoap = true
                            if soapRemaining > ISWashClothing.GetRequiredSoap(item) then
                                soapRemaining = soapRemaining - ISWashClothing.GetRequiredSoap(item)
                                noSoap = false
                            end
                            ISTimedActionQueue.add(ISWashClothing:new(self.parent.player, self.TargetItem, soapList, item, bloodAmount, dirtAmount, noSoap))
                        end
                    end
                end
            end
            self.Complete = true 
            self.WasSuccessful = true
		end
		
	end		
	
end
