SuperSurvivorGroup = {}
SuperSurvivorGroup.__index = SuperSurvivorGroup

function SuperSurvivorGroup:new(GID)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	o.ROE = 3
	o.YouBeenWarned = {}
	o.ID = GID
	o.Leader = -1
	o.Members = {}
	o.Bounds = {0,0,0,0,0}
	
	o.GroupAreas = {}
	o.GroupAreas["ChopTreeArea"] = {0,0,0,0,0}
	o.GroupAreas["TakeCorpseArea"] = {0,0,0,0,0}
	o.GroupAreas["TakeWoodArea"] = {0,0,0,0,0}
	o.GroupAreas["FarmingArea"] = {0,0,0,0,0}
	o.GroupAreas["ForageArea"] = {0,0,0,0,0}
	
	o.GroupAreas["CorpseStorageArea"] = {0,0,0,0,0}
	o.GroupAreas["FoodStorageArea"] = {0,0,0,0,0}
	o.GroupAreas["WoodStorageArea"] = {0,0,0,0,0}
	o.GroupAreas["ToolStorageArea"] = {0,0,0,0,0}
	o.GroupAreas["WeaponStorageArea"] = {0,0,0,0,0}
	o.GroupAreas["MedicalStorageArea"] = {0,0,0,0,0}
	o.GroupAreas["GuardArea"] = {0,0,0,0,0}
	
	return o

end

function SuperSurvivorGroup:setROE(tothis)
	self.ROE = tothis
end

function SuperSurvivorGroup:getFollowCount()
	local count = 0
	local members = self:getMembers()
	for i=1,#members do
		if(members[i] ~= nil) and (members[i].getCurrentTask ~= nil) then
			--print("SS current task: " .. members[i]:getCurrentTask())
			if(members[i]:getCurrentTask() == "Follow") then count = count + 1 end
		end
	end
	return count
end

function SuperSurvivorGroup:isEnemy(SS,character)

	-- zombie is enemy to anyone
	if character:isZombie() then return true 
	elseif (SS:isInGroup(character)) then return false
	elseif (SS.player:getModData().isHostile ~= true and character:getModData().surender == true) then return false -- so other npcs dont attack anyone surendering
	elseif (SS.player:getModData().hitByCharacter == true) and (character:getModData().semiHostile == true) then return true 
	elseif (character:getModData().isHostile ~= SS.player:getModData().isHostile) then 
		--print(tostring(character:getForname()).."("..tostring(character:getModData().Group)..") is enemy to "..SS:getName().."("..tostring(self:getGroupID()))
		return true
	elseif(self.ROE == 4) then
		return true
	else
		return false
	end 

end

function SuperSurvivorGroup:UseWeaponType(thisType)

	local members = self:getMembers()
	for i=1,#members do
		if(thisType == "gun") and (members[i].reEquipGun ~= nil) then members[i]:reEquipGun()
		elseif(members[i].reEquipMele ~= nil) then members[i]:reEquipMele() end
	end
end

function SuperSurvivorGroup:getGroupArea(thisArea)
	return self.GroupAreas[thisArea]
end

function SuperSurvivorGroup:getGroupAreaCenterSquare(thisArea)
	local area = self.GroupAreas[thisArea]
	if(area[1] ~= 0) then return getCenterSquareFromArea(area[1],area[2],area[3],area[4],area[5]) 
	else return nil end
end
function SuperSurvivorGroup:getGroupAreaContainer(thisArea)
	local area = self.GroupAreas[thisArea]
	if(area[1] ~= 0) then 
	
		for x=area[1],area[2] do
			for y=area[3],area[4] do
				local sq = getCell():getGridSquare(x,y,area[5])
				if(sq) then
					local objs = sq:getObjects()
					for j=0, objs:size()-1 do
						if(objs:get(j):getContainer() ~= nil) then return objs:get(j) end					
					end
				end
			
			end
		end
	
	else return nil end
end

function SuperSurvivorGroup:setGroupArea(thisArea,x1,x2,y1,y2,z)
	self.GroupAreas[thisArea][1] = x1
	self.GroupAreas[thisArea][2] = x2
	self.GroupAreas[thisArea][3] = y1
	self.GroupAreas[thisArea][4] = y2
	self.GroupAreas[thisArea][5] = z
end

function SuperSurvivorGroup:getBounds()
	return self.Bounds
end
function SuperSurvivorGroup:setBounds(Boundaries)
	self.Bounds = Boundaries
end
function SuperSurvivorGroup:IsInBounds(thisplayer)
	if(self.Bounds[4]) then
		if(thisplayer:getZ() == self.Bounds[5]) and (thisplayer:getX() > self.Bounds[1]) and (thisplayer:getX() <= self.Bounds[2]) and (thisplayer:getY() > self.Bounds[3]) and (thisplayer:getY() <= self.Bounds[4]) then
			return true
		else 
			return false
		end
	end
	return false
end
function SuperSurvivorGroup:getBaseCenter()
	if(self.Bounds[4]) then
		
		local xdiff = (self.Bounds[2] - self.Bounds[1])
		local ydiff = (self.Bounds[4] - self.Bounds[3])
		local z = 0
		if(self.Bounds[5]) then z = self.Bounds[5] end
		local centerSquare = getCell():getGridSquare(self.Bounds[1]+(xdiff/2),self.Bounds[3]+(ydiff/2),z)
		
		return centerSquare
		
	end
	return nil
end
function SuperSurvivorGroup:getBaseCenterCoords()
	if(self.Bounds[4]) then
		
		local xdiff = (self.Bounds[2] - self.Bounds[1])
		local ydiff = (self.Bounds[4] - self.Bounds[3])
		
		local x = self.Bounds[1]+(xdiff/2)
		local y = self.Bounds[3]+(ydiff/2)
		local z = self.Bounds[5]
		local out = {x,y,z}
		return out
		
	end
	return nil
end
function SuperSurvivorGroup:getRandomBaseSquare()
	if(self.Bounds[4]) then
		
		local xrand = ZombRand(math.floor(self.Bounds[1]) , math.floor(self.Bounds[2]))
		local yrand = ZombRand(math.floor(self.Bounds[3]) , math.floor(self.Bounds[4]))
		
		local centerSquare = getCell():getGridSquare(xrand,yrand,self.Bounds[5])
		
		return centerSquare
		
		
	end
	return nil
end


function SuperSurvivorGroup:WarnPlayer(ID)
	self.YouBeenWarned[ID] = true
end
function SuperSurvivorGroup:getWarnPlayer(ID)
	if not self.YouBeenWarned[ID] then return false
	else return true end
end

function SuperSurvivorGroup:setLeader(newLeader)

	if self.Leader ~= -1 then
		local SS = SSM:Get(self.Leader)
		if(SS) then SS:setGroupRole(getText("ContextMenu_Job_Worker")) end -- old leader gets demoted to worker if exists
	end
	self.Leader = newLeader
	SSM:Get(self.Leader):setGroupRole(getText("ContextMenu_Job_Leader"))
	
end
function SuperSurvivorGroup:getLeader()
	return self.Leader 
end
function SuperSurvivorGroup:hasLeader()
	if self.Leader ~= -1 then
		local SS = SSM:Get(self.Leader)
		if(SS) and SS:getGroupRole() == getText("ContextMenu_Job_Leader") then return true end
	end
	return false
end
function SuperSurvivorGroup:getID()
	return self.ID
end
function SuperSurvivorGroup:getClosestIdleMember(ofThisRole,referencePoint)	
	local closestSoFar = 999
	local closestID = -1
	local distance = 0
	for i=1,#self.Members do	
		local workingID = self.Members[i]
		if(workingID ~= nil) then
			distance = getDistanceBetween(SSM:Get(workingID):Get(),referencePoint)
			if(SSM:Get(workingID):isInAction()==false) and (distance ~= 0) and (distance < closestSoFar) and ( (SSM:Get(workingID):getGroupRole() == ofThisRole) or (ofThisRole == "Any") or (ofThisRole == nil) ) then
				closestID = workingID
				closestSoFar = distance
			end	
		end
	end
	if(closestID ~= -1) then return SSM:Get(closestID)
	else return nil end
end
function SuperSurvivorGroup:getClosestMember(ofThisRole,referencePoint)	
	local closestSoFar = 999
	local closestID = -1
	local distance = 0
	for i=1,#self.Members do
		local workingID = self.Members[i]
		
		if(workingID ~= nil) then
			local workingSS = SSM:Get(workingID)
			if(workingSS ~= nil) then
				
				distance = getDistanceBetween(workingSS:Get(),referencePoint)	
				--print(tostring(self.Members[i])..","..tostring(distance))				
				if(distance ~= 0) and (distance < closestSoFar) and ((ofThisRole == nil) or (SSM:Get(self.Members[i]):getGroupRole() == ofThisRole) or (ofThisRole == "Any")) then
					closestID = self.Members[i]
					closestSoFar = distance
				end
			end
		end
	end
	if(closestID ~= -1) then return SSM:Get(closestID)
	else return nil end
end
function SuperSurvivorGroup:getMember(ofThisRole,closest)	
	for i=1,#self.Members do	
		local workingID = self.Members[i]
		if( (workingID ~= nil) and (SSM:Get(workingID):getGroupRole() == ofThisRole) or (ofThisRole == "Any") or (ofThisRole == nil) ) then
			return SSM:Get(workingID) 
		end		
	end
	return nil
end
function SuperSurvivorGroup:getMembers()	
	local TableOut = {}
	for i=1,#self.Members do	
		local workingID = self.Members[i]
		if( (workingID ~= nil) ) and (SSM:Get(workingID) ~= nil) then
			table.insert(TableOut, SSM:Get(workingID))
		elseif ( (workingID ~= nil) ) then
			table.insert(TableOut, tonumber(workingID))
		end		
	end
	return TableOut
end
function SuperSurvivorGroup:getMembersInRange(referencePoint,range,isListening)	
	local TableOut = {}
	for i=1,#self.Members do	
		local workingID = self.Members[i]
		
		if( (workingID ~= nil) ) and (SSM:Get(workingID) ~= nil) then
			local distance = getDistanceBetween(SSM:Get(workingID):Get(),referencePoint)
			if(distance <= range) and ((not isListening) or (SSM:Get(workingID):getCurrentTask() == "Listen") ) then
				table.insert(TableOut, SSM:Get(workingID))		
			end
		end		
	end
	return TableOut
end

function SuperSurvivorGroup:AllSpokeTo()

	local members = self:getMembers()
	for x=1, #members do
		for y=1, #members do
			members[x]:SpokeTo(members[y]:getID())
		end
	end

end

function SuperSurvivorGroup:getIdleMember(ofThisRole,closest)	
	for i=1,#self.Members do
		local workingID = self.Members[i]
		if (workingID ~= nil) and (SSM:Get(workingID):isInAction()==false) and ( (SSM:Get(workingID):getGroupRole() == ofThisRole) or (ofThisRole == "Any") or (ofThisRole == nil) ) then
			return SSM:Get(workingID) 
		end		
	end
	return nil
end

function SuperSurvivorGroup:getMembersThisCloseCount(range,referencePoint)	
	local count = 0
	for i=1,#self.Members do
		local workingID = self.Members[i]		
		if (workingID ~= nil) and (SSM:Get(workingID) ) then
			local distance = getDistanceBetween(referencePoint,SSM:Get(workingID):Get())
			if(distance <= range) then count = count + 1 end
		end		
	end
	return count
end

function SuperSurvivorGroup:PVPAlert(attacker)	
	local count = 0
	for i=1,#self.Members do
		local workingID = self.Members[i]		
		local ss = SSM:Get(workingID)
		if(ss) then 
			local member = SSM:Get(workingID):Get()
			if (workingID ~= nil) and ( member ) and (member:CanSee(attacker)) then
				member:getModData().hitByCharacter = true
			end		
		end
	end
	return count
end

function SuperSurvivorGroup:getMemberCount()
	return #self.Members
end

function SuperSurvivorGroup:isMember(survivor)
	return has_value(self.Members, survivor:getID())
end

function SuperSurvivorGroup:addMember(newSurvivor, Role)
	
	if(newSurvivor == nil) or (newSurvivor:getID() == nil) then
		print("cant add survivor to group because id is nil")
		return false
	end
	
	local currentGroup = newSurvivor:getGroup()
	if(currentGroup) then
		currentGroup:removeMember(newSurvivor:getID())
		print("removed " .. newSurvivor:getName() .. " from current group")
	else
		--print("no current group")
	end
	
	
	
	--if(newSurvivor:getGroupID() == self.ID) then return false end
	if(Role == nil) then Role = "Worker" end
	if(newSurvivor ~= nil) and (not has_value(self.Members, newSurvivor:getID())) then 	
		print("adding new survivor "..tostring(newSurvivor:getName()).." to group "..tostring(self.ID) .. " role:" .. tostring(Role))
		table.insert(self.Members, newSurvivor:getID())
		
		newSurvivor:setGroupRole(Role)
		newSurvivor:setGroupID(self.ID)
		
		if(Role == getText("ContextMenu_Job_Leader")) then 			
			self:setLeader(newSurvivor:getID()) 
		end
		return self.Members[#self.Members]
	elseif(newSurvivor ~= nil) then
		newSurvivor:setGroupID(self.ID)
		return nil
	end
	
end
function SuperSurvivorGroup:checkMember(newSurvivorID)
	
	if(newSurvivorID ~= nil) and (not has_value(self.Members,newSurvivorID)) then 	
		print("adding checked survivor"..newSurvivorID.." to group"..tostring(self.ID))
		table.insert(self.Members,newSurvivorID)		
	end
	
end

function SuperSurvivorGroup:removeMember(ID)
	local member = SSM:Get(ID)
	if(member) then member:setGroupID(nil) end
	
	if(has_value(self.Members,ID)) then
		
		local index
		for i=1,#self.Members do
			if(ID == self.Members[i]) then 
				table.remove(self.Members,i) 
			end
		end
		print("remove success")
		self:Print()
	else
		print("remove failed")
	end
	
end

function SuperSurvivorGroup:stealingDetected(thief)
	
	print("inside stealing detected!")
	for i=1,#self.Members do	
		local workingID = self.Members[i]
		local workingSS = SSM:Get(workingID)
		if (workingID ~= nil) and (thief ~= nil) and (thief:getModData().ID ~= nil) and (workingSS ~= nil) and (workingSS:getGroupID() == self.ID) then
			
			if (self:getWarnPlayer(thief:getModData().ID)) and SSM:Get(workingID):Get():CanSee(thief) then
				SSM:Get(workingID):Speak(getText("ContextMenu_SD_IAttackFoodThief"))
				thief:getModData().semiHostile = true
				SSM:Get(workingID):Get():getModData().hitByCharacter = true
			elseif (not self:getWarnPlayer(thief:getModData().ID)) and SSM:Get(workingID):Get():CanSee(thief) then		
				SSM:Get(workingID):Speak(getText("ContextMenu_SD_IWarnFoodThief"))
				self:WarnPlayer(thief:getModData().ID)
			end	
			
		end
	end
	
end

function SuperSurvivorGroup:getTaskCount(task)
	local count = 0
	for i=1, #self.Members do
		local SS = SSM:Get(self.Members[i])
		if (SS ~= nil and SS:getCurrentTask() == task) then count = count + 1 end
	end

	return count
end

function SuperSurvivorGroup:Print()

	print("GroupID: "..tostring(self.ID))
	print(getText("ContextMenu_Job_Leader")..": "..tostring(self.Leader))
	print("MemberCount: "..tostring(#self.Members))
	print("Members: ")
	for i=1, #self.Members do
		print("Member "..tostring(self.Members[i]))
	end

end

function SuperSurvivorGroup:Save()

	local tabletoSave = {}
	tabletoSave[1] = #self.Members
	tabletoSave[2] = self.Leader
	table.save(tabletoSave,"SurvivorGroup"..tostring(self.ID).."metaData")
	table.save(self.Members,"SurvivorGroup"..tostring(self.ID))
	table.save(self.Bounds,"SurvivorGroup"..tostring(self.ID).."Bounds")
	
	tabletoSave = {}
	--print("starting save")
	table.sort(self.GroupAreas)
	for k,v in pairs(self.GroupAreas) do
		--print("key "..tostring(k))
		local area = self.GroupAreas[k]
		for i=1,#area do
			table.insert(tabletoSave,area[i])
			--print("inserting "..tostring(area[i]))
		end
	
	end
	
	table.save(tabletoSave,"SurvivorGroup"..tostring(self.ID).."Areas")

end

function SuperSurvivorGroup:Load()
	
	local tabletoSave = table.load("SurvivorGroup"..tostring(self.ID).."metaData")
	if(tabletoSave) then 
		local temp = tonumber(tabletoSave[1])
		self.Leader = tonumber(tabletoSave[2])
	end
	
	self.Members = table.load("SurvivorGroup"..tostring(self.ID))
	if self.Members then 
		for i=1,#self.Members do
			if(self.Members[i] ~= nil) then 
				self.Members[i] = tonumber(self.Members[i]) 
				print (tostring(self.Members[i]).. " is a member of group: "..tostring(self.ID))
			end
		end
	else self.Members = {} end
	
	self.Bounds = table.load("SurvivorGroup"..tostring(self.ID).."Bounds")
	if(self.Bounds) then 
		for i=1,#self.Bounds do
			if(self.Bounds[i] ~= nil) then 
				self.Bounds[i] = tonumber(self.Bounds[i]) 
				--print (tostring(tabletoSave[2]).. " is a member")
			end
		end
	else self.Bounds = {0,0,0,0,0}
	end
	
	
	local AreasTable = table.load("SurvivorGroup"..tostring(self.ID).."Areas")
	
	if(AreasTable) then
		print("starting load")
		table.sort(self.GroupAreas)	
		local gcount = 1
		for k,v in pairs(self.GroupAreas) do
			--print("key "..tostring(k))
			if not AreasTable[gcount] then break end
			for i=1, 5 do
				self.GroupAreas[k][i] = tonumber(AreasTable[gcount])			
				--print("loading "..tostring(AreasTable[gcount]))
				gcount = gcount + 1
			end
		
		end
	else print("no areas file found for this group")
	end

	
	--print ("DONE loading group#"..tostring(self.ID))
end






