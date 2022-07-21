ForageTask = {}
ForageTask.__index = ForageTask

function ForageTask:new(superSurvivor)

	local o = {}
	setmetatable(o, self)
	self.__index = self

	o.parent = superSurvivor
	o.group = superSurvivor:getGroup()
	o.Name = "Forage"
	o.OnGoing = false
	o.Complete = false
	o.ForagedCount = 0
	
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	
	return o

end

function ForageTask:isComplete()
	return self.Complete
end

function ForageTask:isValid()
	if not self.parent then return false 
	else return true end
end

function ForageTask:update()
	
	if(not self:isValid()) then return false end
	
	if(self.parent:isInAction() == false) then
		
		local player = self.parent:Get()
		if(player:getModData().Toggle == nil) then player:getModData().Toggle = false end
			
			if(player:getModData().Toggle) then
				if(player:getCurrentSquare():getZoneType() == "Forest") or (player:getCurrentSquare():getZoneType() == "DeepForest") then
					local options = {};
					options["Insects"] = true;
					options["Mushrooms"] = true;
					options["Berries"] = true;
					options["MedicinalPlants"] = true;
					options["ForestGoods"] = true;
					ISTimedActionQueue.add(ISNPCScavengeAction:new(player, player:getCurrentSquare():getZone(), options));
					self.parent:RoleplaySpeak(getActionText("Foraging"));					
				else
					self.parent:Speak(getActionText("NoForagingHere").."(" .. tostring(player:getCurrentSquare():getZoneType()) .. ")");
					if(self.group ~= nil) then
						local forage = self.group:getGroupAreaCenterSquare("ForageArea")
						if(forage ~= nil) then 				
							self.parent:walkTo(forage)
						end
					end
				end
				self.ForagedCount = self.ForagedCount + 1
			else
			
				local tempx = player:getX() + ZombRand(-2,2);      
				local tempy = player:getY() + ZombRand(-2,2);
				local sq = getCell():getGridSquare(tempx,tempy,player:getZ());
				if(sq ~= nil) then 
					player:StopAllActionQueue();
					self.parent:walkTo(sq); 
				end	
			end
			
			player:getModData().Toggle = not player:getModData().Toggle;
			if(self.ForagedCount > 25) then 
				self.parent:Speak(getSpeech("Tired"))
				self.Complete = true
			end
		
	end

end
