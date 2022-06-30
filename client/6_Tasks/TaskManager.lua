TaskManager = {}
TaskManager.__index = TaskManager

function TaskManager:new(superSurvivor)

	local o = {}
	setmetatable(o, self)
	self.__index = self
	
	o.TaskUpdateCount = 0
	o.TaskUpdateLimit = 0
	o.parent = superSurvivor
	o.Tasks = {}
	o.TaskCount = 0
	o.Tasks[0] = nil
	o.CurrentTask = 0
	o.LastTask = 0
	o.LastLastTask = 0

	return o

end

function TaskManager:setTaskUpdateLimit(toValue)
	self.TaskUpdateLimit = toValue
	self.TaskUpdateCount = 0
end

function TaskManager:AddToTop(newTask)
	
	if(newTask == nil) then return false end
	
	self.LastLastTask = LastTask
	self.LastTask = self:getCurrentTask()
	self.CurrentTask = newTask.Name
	
	if(self.LastTask == self.CurrentTask) then 
		print("warning. "..self.parent:getName() .. " task loop? " .. self.CurrentTask) 
	end
	if(self.LastLastTaskt == self.CurrentTask) then 
		print("warning. "..self.parent:getName() .. " task alternating? " .. self.CurrentTask) 
	end
	
	self.TaskUpdateCount = 0
	for i=self.TaskCount,1,-1 do
		self.Tasks[i] = self.Tasks[i-1]
	end
	
	self.Tasks[0] = newTask
	
	self.TaskCount = self.TaskCount + 1
	
end

function TaskManager:AddToBottom(newTask)

	self.Tasks[self.TaskCount] = newTask 
	self.TaskCount = self.TaskCount + 1

end

function TaskManager:Display()	
	for i=1,self.TaskCount-1 do
		if (self.Tasks[i] ~= nil) then return print(self.Tasks[i].Name) end
	end
end

function TaskManager:clear()
	self.TaskCount = 0
	self.Tasks[0] = nil
end

function TaskManager:moveDown()

	
	--self.parent:DebugSay(self.Tasks[0].Name.." isComplete:"..tostring((self.Tasks[0]:isComplete() == true)))
	while ((not self.Tasks[0]) or (self.Tasks[0]:isComplete() == true)) do
	
		if(self.Tasks[0] ~= nil) and (self.Tasks[0].OnComplete ~= nil) then self.Tasks[0]:OnComplete() end
	
		if(self.TaskCount <= 1) then 
			self:clear()	
			break
		else		
			for i=1,self.TaskCount-1 do
				
				self.Tasks[i-1] = self.Tasks[i]		

			end		
			self.TaskCount = self.TaskCount - 1
		end
	end
		
	self.TaskUpdateCount = 0
	--self.TaskUpdateLimit = 0
	
	return false
end

function TaskManager:getCurrentTask()
	if (self.Tasks[0] ~= nil) and (self.Tasks[0].Name ~= nil) then return self.Tasks[0].Name
	else return "None" end
end

function TaskManager:getTask()
	if (self.Tasks[0] ~= nil) then return self.Tasks[0]
	else return nil end
end

function TaskManager:getThisTask(index)
	if (self.Tasks[index] ~= nil) then return self.Tasks[index]
	else return nil end
end

function TaskManager:getTaskFromName(thisName)

	for i=1,self.TaskCount-1 do
		if (self.Tasks[i] ~= nil) and (self.Tasks[i].Name == thisName) then return self.Tasks[i] end
	end
	return nil
end

function TaskManager:update()

	self = AIManager(self)
		
	local currentTask = self:getCurrentTask()
	--if(self.parent.Reducer % 180 == 0) then self.parent:DebugSay(currentTask..tostring(self.TaskCount) .. ": " .. tostring(self.TaskUpdateCount).."/"..tostring(self.TaskUpdateLimit)) end
		
	if (self.TaskUpdateLimit ~= 0) and (self.TaskUpdateLimit ~= nil) and (self.TaskUpdateCount > self.TaskUpdateLimit) then
		self.Tasks[0] = nil
		self:moveDown()
	elseif(self.Tasks[0] ~= nil) 
	and (self.Tasks[0] ~= false) 
	and (self.Tasks[0]:isComplete() == false) then 
		self.Tasks[0]:update()
		self.TaskUpdateCount = self.TaskUpdateCount + 1		
	else
		self:moveDown() 
		--self.parent:DebugSay("else")	
	end
	
		
	
end
