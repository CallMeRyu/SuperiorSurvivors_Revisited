GatherWoodTask = {}
GatherWoodTask.__index = GatherWoodTask

function GatherWoodTask:new(superSurvivor, BringHere)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	o.BringHereSquare = BringHere
	o.parent = superSurvivor
	o.Name = "Gather Wood"
	o.group = superSurvivor:getGroup()
	o.WoodStorageArea = nil
	if(o.group) then o.WoodStorageArea = o.group:getGroupArea("WoodStorageArea") end
	o.Target = nil
	o.CarryingToPoint = false
	o.Complete = false
	
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	
	return o

end

function GatherWoodTask:isComplete()
	return self.Complete
end

function GatherWoodTask:isValid()
	if not self.parent or not self.BringHereSquare then return false 
	else return true end
end

function GatherWoodTask:update()

	if(not self:isValid()) then return false end
	
	if(self.parent:isInAction() == false) then
	
		local player = self.parent.player
			
			if((player:getInventory():FindAndReturn("Log") ~= nil) or (player:getInventory():FindAndReturn("Plank") ~= nil)) then
			
				local distanceToPoint = getDistanceBetween(self.BringHereSquare,player)
				
				if(distanceToPoint > 2.0) then
					self.parent:walkTo(self.BringHereSquare)
				else
					local Wood = player:getInventory():FindAndReturn("Log")
					if not Wood then Wood = player:getInventory():FindAndReturn("Plank") end
					
					self.BringHereSquare:AddWorldInventoryItem(Wood,(ZombRand(10)/100),(ZombRand(10)/100),0)
					self.parent.player:getInventory():DoRemoveItem(Wood) 
					self.Target = nil
				end
			
			
			
			elseif(self.Target == nil ) then
				
				local range = 25;
				local Square, closestsoFarSquare;
				local minx=math.floor(player:getX() - range);
				local maxx=math.floor(player:getX() + range);
				local miny=math.floor(player:getY() - range);
				local maxy=math.floor(player:getY() + range);
				
				if(self.group ~= nil) then				
					local area = self.group:getGroupArea("TakeWoodArea")
					if(area[1] ~= 0) then
						range = 100
						minx=area[1]
						maxx=area[2]
						miny=area[3]
						maxy=area[4]
					end
				end
				
				local closestsoFar = range;
				local gamehours = getGameTime():getWorldAgeHours();
				for x=minx, maxx do
					for y=miny, maxy do
						Square = getCell():getGridSquare(x,y,0);
						if(Square ~= nil) and (self.BringHereSquare ~= Square) and (self.WoodStorageArea ~= nil) and (isSquareInArea(Square,self.WoodStorageArea) == false) then
							local distance = getDistanceBetween(Square,player);
							local closeobjects = Square:getWorldObjects();
							for i=0, closeobjects:size()-1 do
								if (closeobjects:get(i):getItem()) and ((closeobjects:get(i):getItem():getType() == "Log") or (closeobjects:get(i):getItem():getType() == "Plank")) and ((closeobjects:get(i):getModData().isClaimed == nil) or (gamehours > (closeobjects:get(i):getModData().isClaimed + 0.05))) and (distance<closestsoFar) then
									self.Target = closeobjects:get(i);	
									closestsoFar = distance;
								end
							end
						end
					end
				end
				
				if(self.Target ~= nil) and (self.Target:getSquare() ~= nil) then
					player:StopAllActionQueue();
					self.Target:getModData().isClaimed = gamehours;
					--ISTimedActionQueue.add(ISWalkToTimedAction:new(player, self.Target:getSquare():getN()));
					self.parent:walkTo(self.Target:getSquare());
				else
					self.parent:Speak(getActionText("NoWoodHere"));
					self.Complete = true
				end
				
			elseif(self.Target ~= nil ) then
			
				if( (self.Target ~= nil) and instanceof(self.Target,"IsoWorldInventoryObject") and (self.Target:getSquare()~=nil) and	(getDistanceBetween(self.Target , player) > 2.0) )then
					--ISTimedActionQueue.add(ISWalkToTimedAction:new(player, self.Target:getSquare():getN() ));
					--self.parent:Speak("walking")
					self.parent:walkTo(self.Target:getSquare());
				elseif(self.Target ~= nil) and instanceof(self.Target,"IsoWorldInventoryObject") and (self.Target:getSquare()~=nil) then
					--self.parent:Speak("pick up")
					self.Target = self.parent.player:getInventory():AddItem(self.Target:getItem())
					if(self.Target:getWorldItem()) then 
						self.Target:getWorldItem():getSquare():removeWorldObject(self.Target:getWorldItem()) 
					end
					if(self.Target:getWorldItem()) then 
						self.Target:getWorldItem():removeFromSquare() 
					end
					self.Target:setWorldItem(nil)
					self.parent:RoleplaySpeak(getActionText("TakesItemFromGround_Before") .. self.Target:getDisplayName() .. getActionText("TakesItemFromGround_After"))
					self.CarryingToPoint = true
				else
					self.Target = nil
				end
				
			end
			
			
			
			
			
			
		
		
	else 
		--self.parent:Speak("waiting for non action");
	end

end
