PileCorpsesTask = {}
PileCorpsesTask.__index = PileCorpsesTask

function PileCorpsesTask:new(superSurvivor, BringHere)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	o.BringHereSquare = BringHere
	o.parent = superSurvivor
	o.group = superSurvivor:getGroup()
	o.Name = "Pile Corpses"
	
	o.Target = nil
	o.TargetSquare = nil
	o.Complete = false
	
	
	return o

end

function PileCorpsesTask:isComplete()
	return self.Complete
end

function PileCorpsesTask:isValid()
	if not self.parent then return false 
	else return true end
end

function PileCorpsesTask:update()

	if(not self:isValid()) then return false end
	
	if(self.parent:isInAction() == false) then
	
		local player = self.parent.player
			
			if((player:getInventory():FindAndReturn("CorpseMale") ~= nil) or (player:getInventory():FindAndReturn("CorpseFemale") ~= nil)) then
			
				local distanceToPoint = getDistanceBetween(self.BringHereSquare,player)
				
				if(distanceToPoint > 2.0) then
					self.parent:walkToDirect(self.BringHereSquare)
				else
					local Corpse = player:getInventory():FindAndReturn("CorpseMale")
					if not Corpse then Corpse = player:getInventory():FindAndReturn("CorpseFemale") end
					
					--self.BringHereSquare:AddWorldInventoryItem(Corpse,(ZombRand(10)/100),(ZombRand(10)/100),0)
					--self.parent.player:getInventory():DoRemoveItem(Corpse) 
					self.parent:StopWalk()
					--print(self:getName().."stopping walking4")
					ISTimedActionQueue.add(ISDropItemAction:new(self.parent:Get(),Corpse,30))
					self.parent:Get():setPrimaryHandItem(nil)
					self.parent:Get():setSecondaryHandItem(nil)
					self.Target = nil
				end
			
			
			
			elseif(self.Target == nil ) then
				
				local range = 45;
				local Square, closestsoFarSquare;
				local minx=math.floor(player:getX() - range);
				local maxx=math.floor(player:getX() + range);
				local miny=math.floor(player:getY() - range);
				local maxy=math.floor(player:getY() + range);
				local z = 0
				
				if(self.group ~= nil) then				
					local area = self.group:getGroupArea("TakeCorpseArea")
					if(area[1] ~= 0) then
						minx=area[1]
						maxx=area[2]
						miny=area[3]
						maxy=area[4]
						z = area[5]
					end
				end
				
				local closestsoFar = range+1;
				local gamehours = getGameTime():getWorldAgeHours();
				for x=minx, maxx do
					for y=miny, maxy do
						Square = getCell():getGridSquare(x,y,z);
						local distance = getDistanceBetween(Square,player);
						if(Square ~= nil) and (distance < closestsoFar) and (getDistanceBetween(self.BringHereSquare,Square)>2) and (Square:getDeadBody()) then
							
							self.Target = Square:getDeadBody()	
							self.TargetSquare = Square
							closestsoFar = distance;							
							
						end
					end
				end
				
				if(self.Target ~= nil) then
					player:StopAllActionQueue();
					self.Target:getModData().isClaimed = gamehours;
					--ISTimedActionQueue.add(ISWalkToTimedAction:new(player, self.TargetSquare:getN()));
					self.parent:walkTo(self.TargetSquare);
				
				else 
					self.Complete = true
				end
				
			elseif(self.Target ~= nil ) then
			
				if( self.TargetSquare:getDeadBody() and (getDistanceBetween(self.TargetSquare , player) > 2.0) )then
					
					self.parent:walkTo(self.TargetSquare);
				elseif self.TargetSquare:getDeadBody() then
					
					--print(getText("ContextMenu_SD_PickUpCorpse"));
					ISTimedActionQueue.add(ISGrabCorpseAction:new(self.parent:Get(),self.TargetSquare:getDeadBody(),30))
					
					
					self.parent:RoleplaySpeak(getText("ContextMenu_SD_PickUpCorpse"))
				else
					self.Target = nil
				end
				
			end
			
			
			
			
			
			
		
		
	else 
		--self.parent:Speak("waiting for non action");
	end

end
