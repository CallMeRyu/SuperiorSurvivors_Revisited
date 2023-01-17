------------------------------------------
-- Clothing Actions Radial Menu
------------------------------------------
local SSRadialMenuUI = ISBaseObject:derive("SSRadialMenuUI")

activeMenu = nil

------------------------------------------
local SSRadialMenuCommand = ISBaseObject:derive("SSRadialMenuCommand")


function SSRadialMenuCommand:newSubmenu(menu, text, commands)
    local o = ISBaseObject.new(self)
    o.menu = menu
    o.player = menu.player

    o.text = text
	o.commands = commands
	menu:addSlice(text, getTexture('media/ui/ZoomOut.png'), self.fillSubMenu, o)
    return o
end


function SSRadialMenuCommand:fillSubMenu()
	self.menu:clear()
	for _,command in ipairs(self.commands) do
		if command.isSubmenu == nil then 
			command:fillMenu(self.menu)
		else 
			SSRadialMenuCommand:newSubmenu(self.menu, self.text .." "..command.name, command.commands)
		end
	end
	self.menu:displayCurrentRadial()
end

function SSRadialMenuCommand:new(menu, text, actionName, actionFunc, param1, param2)
    local o = ISBaseObject.new(self)
    o.menu = menu
    o.player = menu.player

    o.text = text
	o.ssplayer = param1
	o.param2 = param2
    o.actionName = actionName
    o.actionFunc = actionFunc

    return o
end

local convertTexttoPng = {
	["Call"]=getTexture('media/ui/emotes/comehere.png'),
	["Barr"]=getTexture('media/ui/LootableMaps/map_house.png'),
	["Chop"]=getTexture('media/ui/LootableMaps/map_axe.png'),
	["Medi"]=getTexture('media/ui/LootableMaps/map_medcross.png'),
	["Water"]=getTexture('media/ui/LootableMaps/map_waves.png'),
	["Food"]=getTexture('media/ui/LootableMaps/map_knifefork.png'),
	["Follow"]=getTexture('media/ui/emotes/back_green.png'),
}

local numberindex = 0
local numberTexture = {
	["1"]=getTexture('media/ui/ClockAssets/ClockDigitsMedium1.png'),
	["2"]=getTexture('media/ui/ClockAssets/ClockDigitsMedium2.png'),
	["3"]=getTexture('media/ui/ClockAssets/ClockDigitsMedium3.png'),
	["4"]=getTexture('media/ui/ClockAssets/ClockDigitsMedium4.png'),
	["5"]=getTexture('media/ui/ClockAssets/ClockDigitsMedium5.png'),
	["6"]=getTexture('media/ui/ClockAssets/ClockDigitsMedium6.png'),
	["7"]=getTexture('media/ui/ClockAssets/ClockDigitsMedium7.png'),
	["8"]=getTexture('media/ui/ClockAssets/ClockDigitsMedium8.png'),
	["9"]=getTexture('media/ui/ClockAssets/ClockDigitsMedium9.png'),	
}

local function getImage(self)

	local image = convertTexttoPng[string.sub(self.text,1,4)]
	if string.find(self.text, "Water") then
		image = convertTexttoPng["Water"]
	elseif string.find(self.text, "Food") then
		image = convertTexttoPng["Food"]
	elseif string.find(self.text, "Follow") then
		image = convertTexttoPng["Follow"]
	end
	
	if image == nil then 
		--image = getTexture('media/ui/LootableMaps/map_o.png')
		numberindex = numberindex + 1
		image = numberTexture[(numberindex%9)+1 .. ""]
	end
	return image
end

function SSRadialMenuCommand:fillMenu(menu)
	
	local image = getImage(self)
	
	menu:addSlice(self.text, image, self.invoke, self)
end


function SSRadialMenuCommand:invoke()
	--local SS = SSM:Get(self.ssplayer:getModData().ID)
	if 	self.actionName == "CallSurvivor" then
		CallSurvivor(nil,self.ssplayer);
		return
	end
	if 	self.actionName == "GiveOrder" then
		SurvivorOrder(nil, self.ssplayer, self.param2, nil)
		return
	end
	self.actionFunc(nil, self.ssplayer)
end

------------------------------------------
function SSRadialMenuUI:displayCurrentRadial()
    local menu = getPlayerRadialMenu(self.playerNum)
    menu:center()
    menu:addToUIManager()
    if JoypadState.players[self.playerNum+1] then
        menu:setHideWhenButtonReleased(Joypad.DPadUp)
        setJoypadFocus(self.playerNum, menu)
        self.player:setJoypadIgnoreAimUntilCentered(true)
    end
end

function SSRadialMenuUI:callAll()
	for _,ssplayer in ipairs(self.closestSSplayers) do
		CallSurvivor(nil,ssplayer);
	end
end

function SSRadialMenuUI:fillMenu()
    local menu = getPlayerRadialMenu(self.playerNum)
    menu:clear()
	menu.displayCurrentRadial= self.displayCurrentRadial

	if #self.closestSSplayers ~= 0 then
		self.hasCommands = true
	end
	
	menu:addSlice("Call All", getTexture('media/ui/ZoomIn.png'), self.callAll, self)
	
    local commands = {}
	
	local contextGetInfo = {}
	contextGetInfo = ISContextMenu.get(0, getMouseX(), getMouseY())
	local subContext = {}
	local suboptions = {}
    for _,ssplayer in ipairs(self.closestSSplayers) do
		local ssnome = ssplayer:getForname()
		--table.insert(commands, SSRadialMenuCommand:new(self, ssplayer:getForname(), ssplayer, "CallSurvivor"))
		
		--get updated context info
		survivorMenu(contextGetInfo,ssplayer)
		
		subContext = contextGetInfo:getSubInstance(1)
		suboptions = subContext.options
		
		for _, opt in ipairs(suboptions) do
			if opt.onSelect ~= nil then 
				table.insert(commands, SSRadialMenuCommand:new(menu, opt.name.. " " .. ssnome, nil, opt.onSelect, ssplayer, nil))
			elseif opt.subOption ~= nil then
				local subContextGiveOrder = contextGetInfo:getSubInstance(opt.subOption)
				local suboptionsGiveOrder = subContextGiveOrder.options
				local commandsGiveOrder = {}
				
				for _,optGO in ipairs(suboptionsGiveOrder) do
					table.insert(commandsGiveOrder, SSRadialMenuCommand:new(menu, optGO.name.. " " .. ssnome, "GiveOrder", optGO.onSelect, ssplayer, optGO.param2))
				end
				
				local submenuCommands = {["isSubmenu"] = true, ["name"]=opt.name, ["commands"] = commandsGiveOrder}
				table.insert(commands,  submenuCommands)
				--SSRadialMenuCommand:newSubmenu(menu, ssplayer:getForname() .. opt.name, commandsGiveOrder)
				commandsGiveOrder = {}
			end
			
		end
		
		SSRadialMenuCommand:newSubmenu(menu, ssplayer:getForname(), commands)
		commands = {}
    end
	contextGetInfo:setVisible(false)
	print(contextGetInfo)

   --for _,command in ipairs(commands) do
   --    command:fillMenu()
   --end
end
--[[
function SSRadialMenuUI:fillMenu()
    local menu = getPlayerRadialMenu(self.playerNum)
    menu:clear()

    local commands = {}
	if #self.closestSSplayers ~= 0 then
		self.hasCommands = true
	end
	
    for _,ssplayer in ipairs(self.closestSSplayers) do
		table.insert(commands, SSRadialMenuCommand:new(self, ssplayer:getForname(), ssplayer, "CallSurvivor"))	
    end

    for _,command in ipairs(commands) do
        command:fillMenu()
    end
end
]]
function SSRadialMenuUI:display()
    self:fillMenu()
    
    if not self.hasCommands then return end
	
	self:displayCurrentRadial()
--[[
    local menu = getPlayerRadialMenu(self.playerNum)
    menu:center()
    menu:addToUIManager()
    if JoypadState.players[self.playerNum+1] then
        menu:setHideWhenButtonReleased(Joypad.DPadUp)
        setJoypadFocus(self.playerNum, menu)
        self.player:setJoypadIgnoreAimUntilCentered(true)
    end
	]]
end

function SSRadialMenuUI:getClosestSSplayers(player)

	local patient = nil
	local range = 15;
	local Square, closestsoFarSquare;
	local minx=math.floor(player:getX() - range);
	local maxx=math.floor(player:getX() + range);
	local miny=math.floor(player:getY() - range);
	local maxy=math.floor(player:getY() + range);
	local closestsoFar = range;
	
	local closestPlayers = {}
	
	for x=minx, maxx do
		for y=miny, maxy do
			Square = getCell():getGridSquare(x,y,player:getZ())
			if(Square ~= nil) then
				local distance = getDistanceBetween(Square,player)
				local closeobjects = Square:getMovingObjects()
				for i=0, closeobjects:size()-1 do
					local obj = closeobjects:get(i)
					if (obj ~= nil) then 
						--and (self.parent.player:CanSee(obj))
						if (instanceof(obj,"IsoPlayer") and not obj:isLocalPlayer() and (obj:isDead() == false) and (obj:getModData().isHostile ~= true) and (distance < closestsoFar) ) then
							table.insert(closestPlayers, obj)
						end
					end
				end
			end
		end
	end
	
	return closestPlayers
	
end

function SSRadialMenuUI:new(player)
    local o = ISBaseObject.new(self)
    o.player = player
    o.playerNum = player:getPlayerNum()
	o.closestSSplayers = self:getClosestSSplayers(player)
    return o
end

local ticks = 0
local wasVisible = false

function SSRadialMenuUI.checkKey(key)
    if key ~= getCore():getKey("SSRadialMenu") then
        return false
    end

    if ModKey and ModKey.isKeyDown() then
        return false
    end

--[[
    if UIManager.getSpeedControls() and (UIManager.getSpeedControls():getCurrentGameSpeed() == 0) then
        return false
    end
]]
    local player = getSpecificPlayer(0)
    if not player or player:isDead() then
            return false
    end

    if player:isSeatedInVehicle() then
        return false
    end
    
    local queue = ISTimedActionQueue.queues[player]
    if queue and #queue.queue > 0 then
            return false
    end
    if getCell():getDrag(0) then
            return false
    end
    return true
end

------------------------------------------
--- For the DPad
function SSRadialMenuUI.showRadialMenu(player)
    if UIManager.getSpeedControls() and (UIManager.getSpeedControls():getCurrentGameSpeed() == 0) then
        return
    end

    if not player or player:isDead() then
            return
    end
    local queue = ISTimedActionQueue.queues[player]
    if queue and #queue.queue > 0 then
            return false
    end

    local menu = SSRadialMenuUI:new(player)
    --menu:fillMenu()
    menu:display()
    --activeMenu = menu
end

-- Only do this if SpiffUI doesn't
if not SpiffUI then
    ---- Show the Radial Menu on the Up DPad when there's not a car around
    local _ISDPadWheels_onDisplayUp = ISDPadWheels.onDisplayUp
    function ISDPadWheels.onDisplayUp(joypadData)
        local player = getSpecificPlayer(joypadData.player)
        if not player:getVehicle() and not ISVehicleMenu.getVehicleToInteractWith(player) then
            SSRadialMenuUI.showRadialMenu(player)
        else
            _ISDPadWheels_onDisplayUp(joypadData)
        end
    end
end
------------------------------------------

function SSRadialMenuUI.onKeyPress(key)
    if not SSRadialMenuUI.checkKey(key) then
        return
    end
    local radialMenu = getPlayerRadialMenu(0)
    if radialMenu:isReallyVisible() and getCore():getOptionRadialMenuKeyToggle() then
        wasVisible = true
        radialMenu:removeFromUIManager()
        setJoypadFocus(activeMenu.playerNum, nil)
        activeMenu = nil
        return
    end
    ticks = getTimestampMs()
    wasVisible = false
end

function SSRadialMenuUI.onKeyHold(key)
    if not SSRadialMenuUI.checkKey(key) then
        return
    end
    if wasVisible then
        return
    end

    local radialMenu = getPlayerRadialMenu(0)
    local delay = 500
    if (getTimestampMs() - ticks >= delay) and not radialMenu:isReallyVisible() then
        local menu = SSRadialMenuUI:new(getSpecificPlayer(0))
        --menu:fillMenu()
        menu:display()
        activeMenu = menu
    end

end

Events.OnGameStart.Add(function()
    Events.OnKeyStartPressed.Add(SSRadialMenuUI.onKeyPress)
    Events.OnKeyKeepPressed.Add(SSRadialMenuUI.onKeyHold)
end)

return SSRadialMenuUI