-- thanks and some credit to Fenris_Wolf from ORGM mod for creating this hotkeys file!  I just tweaked it to use my own key bindings! and added support for settings too ~Nolan

function SuperSurvivorGetOption(option)
	
	if(SuperSurvivorOptions[option] ~= nil) then return tonumber(SuperSurvivorOptions[option])
	else return 1 end

end
function SuperSurvivorGetOptionValue(option)
	
	local num = SuperSurvivorGetOption(option)
	print(option .." : " .. tostring(num))

	if(option == "WifeSpawn") then return (num ~= 1)
	elseif(option == "LockNLoad") then return (num ~= 1)
	elseif(option == "SpawnRate") and (num == 1) then return 0
	elseif(option == "SpawnRate") and (num == 2) then return 64000
	elseif(option == "SpawnRate") and (num == 3) then return 32000
	elseif(option == "SpawnRate") and (num == 4) then return 26000
	elseif(option == "SpawnRate") and (num == 5) then return 20000
	elseif(option == "SpawnRate") and (num == 6) then return 16000
	elseif(option == "SpawnRate") and (num == 7) then return 12000
	elseif(option == "SpawnRate") and (num == 8) then return 8000
	elseif(option == "SpawnRate") and (num == 9) then return 4000
	elseif(option == "SpawnRate") and (num == 10) then return 2500
	elseif(option == "SpawnRate") and (num == 11) then return 1000
	elseif(option == "SpawnRate") and (num == 12) then return 400
	
	--elseif(option == "GunSpawnRate") and (num == 1) then return 0	-- For now marked out for testing. Does well? Remove this line if you want.
	--elseif(option == "GunSpawnRate") and (num == 2) then return 1	-- For now marked out for testing. Does well? Remove this line if you want.
	--elseif(option == "GunSpawnRate") and (num == 3) then return 2	-- For now marked out for testing. Does well? Remove this line if you want.
	--elseif(option == "GunSpawnRate") then return (num * 5) - 15	-- For now marked out for testing. Does well? Remove this line if you want.
	
	elseif(option == "WepSpawnRate") then return (num - 1) 			-- then return (num * 5) - 5	-- Marked out old instead of removing it to test
	elseif(option == "GunSpawnRate") then return (num - 1) 			-- then return (num * 5) - 5	-- Marked out old instead of removing it to test
	
	elseif(option == "HostileSpawnRate") then return (num - 1) 		-- then return (num * 5) - 5
	elseif(option == "MaxHostileSpawnRate") then return (num - 1) 	-- then return (num * 5) - 5
	
	elseif(option == "InfinitAmmo") then return (num ~= 1)
	elseif(option == "NoPreSetSpawn") then return (num ~= 1)
	elseif(option == "SafeBase") then return (num ~= 1)
	elseif(option == "SurvivorBases") then return (num ~= 1)
	
	elseif(option == "DebugOptions") then return (num ~= 1)
	elseif(option == "DebugOption_DebugSay") then return (num - 1)
	elseif(option == "DebugOption_DebugSay_Distance") then return (num - 1)
	
	elseif(option == "FindWork") then return (num ~= 1)
	elseif(option == "SurvivorHunger") then return (num ~= 1)
	elseif(option == "SurvivorFriendliness") then return (10 - ((num-1)*2)) -- 1 = 10, 2 = 8, 3 = 6
	
	elseif(option == "RaidersAtLeastHours") and (num == 21) then return 24
	elseif(option == "RaidersAtLeastHours") and (num == 22) then return 1
	elseif(option == "RaidersAtLeastHours") and (num == 23) then return 0
	elseif(option == "RaidersAtLeastHours") then return ((num * 5) * 24)
	
	elseif(option == "RaidersAfterHours") and (num == 2) then return 24
	elseif(option == "RaidersAfterHours") and (num >= 22) then return 9999999
	elseif(option == "RaidersAfterHours") then return (((num-2) * 5) * 24)
	
	elseif(option == "RaidersChance") then return ((num + 2) * 24 * 14)  -- (6 * 24 * 14)
	
	elseif(option == "Option_FollowDistance") then return (num+2)
	elseif(option == "Option_Perception_Bonus") then return (num)
	
	elseif(option == "Option_ForcePVP") and (num == 1) then return 0
	elseif(option == "Option_ForcePVP") and (num == 2) then return 1

	elseif(option == "RoleplayMessage") and (num == 1) then return 0
	elseif(option == "RoleplayMessage") and (num == 2) then return 1
	
	
	
	elseif(option == "Option_Display_Survivor_Names") then return (num)
	elseif(option == "Option_Display_Hostile_Color") then return (num)
	
	elseif(option == "Bravery") and (num == 1) then return 1
	elseif(option == "Bravery") and (num == 2) then return 2
	elseif(option == "Bravery") and (num == 3) then return 3
	elseif(option == "Bravery") and (num == 4) then return 50
	elseif(option == "AltSpawn") and (num == 1) then return 1 -- If false
	elseif(option == "AltSpawn") and (num == 2) then return 2 -- If true
	elseif(option == "AltSpawn") and (num == 3) then return 3 -- If true
	elseif(option == "AltSpawn") and (num == 4) then return 4 -- If true
	elseif(option == "AltSpawn") and (num == 5) then return 5 -- If true
	elseif(option == "AltSpawn") and (num == 6) then return 6 -- If true
	elseif(option == "AltSpawn") and (num == 7) then return 7 -- If true
	
	elseif(option == "AltSpawnPercent") then return (num - 1) -- % chance. in this case, 'num - 1' will make it goto 0 for what 'option 1' is. 

	elseif(option == "AltSpawnAmount") and (num == 1) then return 1 
	elseif(option == "AltSpawnAmount") and (num == 2) then return 2
	elseif(option == "AltSpawnAmount") and (num == 3) then return 3
	elseif(option == "AltSpawnAmount") and (num == 4) then return 4
	elseif(option == "AltSpawnAmount") and (num == 5) then return 5
	elseif(option == "AltSpawnAmount") and (num == 6) then return 6



	else return num end
	

end
function SuperSurvivorSetOption(option,ToValue)

	SuperSurvivorOptions[option] = ToValue
	SaveSurvivorOptions()

end

 function SaveSurvivorOptions()
	--local destFile = "SurvivorOptions.lua"
	local writeFile = getFileWriter("SurvivorOptions.lua", true, false)

	for index,value in pairs(SuperSurvivorOptions) do
	
		writeFile:write(tostring(index) .. " " .. tostring(value) .. "\r\n");
	
	end
	writeFile:close();
end

function LoadSurvivorOptions( )
	
	if(doesOptionsFileExist() == false) then 
		print("could not load survivor options file")
		return nil 
	end

	local fileTable = {}
	local readFile = getFileReader("SurvivorOptions.lua", false)
	local scanLine = readFile:readLine()
	while scanLine do
	
		local values = {}
		for input in scanLine:gmatch("%S+") do table.insert(values,input) end
		--print("loading line: "..values[1] .. " " .. values[2])
		if(fileTable[values[1]] == nil) then fileTable[values[1]] = {} end
			fileTable[values[1]]=tonumber(values[2])
		scanLine = readFile:readLine()
		if not scanLine then break end
	end
	readFile:close()
	print("Loaded survivor options file")
	return fileTable
end

function doesOptionsFileExist(  )
	local fileTable = {}
	local readFile = getFileReader("SurvivorOptions.lua", false)
	
	if(readFile) then return true
	else return false end
end


	SuperSurvivorOptions = LoadSurvivorOptions()
	if(not SuperSurvivorOptions) then SuperSurvivorOptions = {} end
	if(not SuperSurvivorOptions["SpawnRate"]) then SuperSurvivorOptions["SpawnRate"] = 7 end
	if(not SuperSurvivorOptions["WifeSpawn"]) then SuperSurvivorOptions["WifeSpawn"] = 1 end
	if(not SuperSurvivorOptions["LockNLoad"]) then SuperSurvivorOptions["LockNLoad"] = 1 end
	if(not SuperSurvivorOptions["GunSpawnRate"]) then SuperSurvivorOptions["GunSpawnRate"] = 1 end
	if(not SuperSurvivorOptions["WepSpawnRate"]) then SuperSurvivorOptions["WepSpawnRate"] = 99 end
	if(not SuperSurvivorOptions["HostileSpawnRate"]) then SuperSurvivorOptions["HostileSpawnRate"] = 1 end
	if(not SuperSurvivorOptions["MaxHostileSpawnRate"]) then SuperSurvivorOptions["MaxHostileSpawnRate"] = 17 end
	if(not SuperSurvivorOptions["InfinitAmmo"]) then SuperSurvivorOptions["InfinitAmmo"] = 2 end
	if(not SuperSurvivorOptions["NoPreSetSpawn"]) then SuperSurvivorOptions["NoPreSetSpawn"] = 2 end
	if(not SuperSurvivorOptions["SafeBase"]) then SuperSurvivorOptions["SafeBase"] = 2 end
	if(not SuperSurvivorOptions["SurvivorBases"]) then SuperSurvivorOptions["SurvivorBases"] = 2 end
	if(not SuperSurvivorOptions["FindWork"]) then SuperSurvivorOptions["FindWork"] = 2 end
	if(not SuperSurvivorOptions["SurvivorHunger"]) then SuperSurvivorOptions["SurvivorHunger"] = 2 end
	if(not SuperSurvivorOptions["SurvivorFriendliness"]) then SuperSurvivorOptions["SurvivorFriendliness"] = 3 end

	if(not SuperSurvivorOptions["Option_WarningMSG"]) then SuperSurvivorOptions["Option_WarningMSG"] = 2 end
	

	if(not SuperSurvivorOptions["Option_Perception_Bonus"]) then SuperSurvivorOptions["Option_Perception_Bonus"] = 2 end
	
	if(not SuperSurvivorOptions["RaidersAtLeastHours"]) then SuperSurvivorOptions["RaidersAtLeastHours"] = 13 end
	if(not SuperSurvivorOptions["RaidersAfterHours"]) then SuperSurvivorOptions["RaidersAfterHours"] = 7 end
	if(SuperSurvivorOptions["RaidersAfterHours"] > 22) then SuperSurvivorOptions["RaidersAfterHours"] = 22 end -- fix legacy bad value
	if(not SuperSurvivorOptions["RaidersChance"]) then SuperSurvivorOptions["RaidersChance"] = 3 end
	if(not SuperSurvivorOptions["Option_FollowDistance"]) then SuperSurvivorOptions["Option_FollowDistance"] = 5 end
	if(not SuperSurvivorOptions["Option_ForcePVP"]) then SuperSurvivorOptions["Option_ForcePVP"] = 0 end
	
	if(not SuperSurvivorOptions["Option_Panic_Distance"]) then SuperSurvivorOptions["Option_Panic_Distance"] = 21 end
	
	if(not SuperSurvivorOptions["Option_Display_Survivor_Names"]) then SuperSurvivorOptions["Option_Display_Survivor_Names"] = 2 end
	if(not SuperSurvivorOptions["Option_Display_Hostile_Color"]) then SuperSurvivorOptions["Option_Display_Hostile_Color"] = 2 end
	
	if(not SuperSurvivorOptions["Bravery"]) then SuperSurvivorOptions["Bravery"] = 4 end
	
	if(not SuperSurvivorOptions["AltSpawn"]) then SuperSurvivorOptions["AltSpawn"] = 2 end
	if(not SuperSurvivorOptions["AltSpawnPercent"]) then SuperSurvivorOptions["AltSpawnPercent"] = 10 end
	if(not SuperSurvivorOptions["AltSpawnAmount"]) then SuperSurvivorOptions["AltSpawnAmount"] = 1 end
	if(not SuperSurvivorOptions["SSHotkey1"]) then SuperSurvivorOptions["SSHotkey1"] = 6 end
	if(not SuperSurvivorOptions["SSHotkey2"]) then SuperSurvivorOptions["SSHotkey2"] = 10 end
	if(not SuperSurvivorOptions["SSHotkey3"]) then SuperSurvivorOptions["SSHotkey3"] = 27 end
	if(not SuperSurvivorOptions["SSHotkey4"]) then SuperSurvivorOptions["SSHotkey4"] = 42 end
	

local GameOption = ISBaseObject:derive("GameOption")

function GameOption:new(name, control, arg1, arg2)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.name = name
	o.control = control
	o.arg1 = arg1
	o.arg2 = arg2
	if control.isCombobox then
		control.onChange = self.onChangeComboBox
		control.target = o
	end
	if control.isTickBox then
		control.changeOptionMethod = self.onChangeTickBox
		control.changeOptionTarget = o
	end
	if control.isSlider then
		control.targetFunc = self.onChangeVolumeControl
		control.target = o
	end
	return o
end

function GameOption:toUI()
	print('ERROR: option "'..self.name..'" missing toUI()')
end

function GameOption:apply()
	print('ERROR: option "'..self.name..'" missing apply()')
end

function GameOption:onChangeComboBox(box)
	self.gameOptions:onChange(self)
	if self.onChange then
		self:onChange(box)
	end
end

function GameOption:onChangeTickBox(index, selected)
	self.gameOptions:onChange(self)
	if self.onChange then
		self:onChange(index, selected)
	end
end

function GameOption:onChangeVolumeControl(control, volume)
	self.gameOptions:onChange(self)
	if self.onChange then
		self:onChange(control, volume)
	end
end

-- -- -- -- --

--[[
hotkey options
]]
SSHotKeyOptions = {}
for i=1,#Orders do
	SSHotKeyOptions[i] = getContextMenuText("SS_OrderAll") .. " " .. OrderDisplayName[Orders[i]]
end
for i=1,#Orders do
	table.insert(SSHotKeyOptions,OrderDisplayName[Orders[i]])
end

-- We need to use the global keyBinding table, this stores all our binding values
local index = nil -- index will be the position we want to insert into the table
for i,b in ipairs(keyBinding) do
	-- we need to find the index of the item we want to insert after
	-- in this case its "Equip/Unequip Stab weapon"
	if b.value == "Shout" then
		index = i -- found the index, set it and break from the loop
		break
	end
end

if index then
    -- we got a index, first lets insert our new entries
  	table.insert(keyBinding, index+1, {value = "Call Closest Group Member", key = 20})
  	table.insert(keyBinding, index+2, {value = "Call Closest Non-Group Member", key = 21})
  	table.insert(keyBinding, index+3, {value = "Ask Closest Group Member to Follow", key = 34})
  	table.insert(keyBinding, index+4, {value = "Toggle Group Window", key = 22})
  	table.insert(keyBinding, index+5, {value = "Spawn Wild Survivor", key = 7})
  	table.insert(keyBinding, index+6, {value = "Lower Follow Distance", key = 74})
  	table.insert(keyBinding, index+7, {value = "Raise Follow Distance", key = 78})
   
  	table.insert(keyBinding, index+8, {value = "SSHotkey_1", key = 200})
  	table.insert(keyBinding, index+9, {value = "SSHotkey_2", key = 208})
  	table.insert(keyBinding, index+10, {value = "SSHotkey_3", key = 203})
  	table.insert(keyBinding, index+11, {value = "SSHotkey_4", key = 205})

-- ----------------------- --
-- Options Menu controller --
-- ----------------------- --
--TODO: separate UI into sections (spawn , raiders , hotkeys)
	function MainOptions:addCustomCombo(id,splitpoint, y, comboWidth,label ,options, description)
		local spawnrateCombo = self:addCombo(splitpoint, y, comboWidth, 20,label, options, 1)
		if description then
			spawnrateCombo:setToolTipMap({defaultTooltip = description});
		end
		
		gameOption = GameOption:new(id, spawnrateCombo)
		function gameOption.toUI(self)
			local box = self.control
			box.selected = SuperSurvivorGetOption(id)
		end
		function gameOption.apply(self)
			local box = self.control
			if box.options[box.selected] then
				SuperSurvivorSetOption(id,box.selected)
				print("setting " .. id ..  " option")
			else
				print("error could not set " .. id ..  " option")
			end
		end
		function gameOption:onChange(box)
			print("option changed to ".. tostring(box.selected))
		end
		
		self.gameOptions:add(gameOption)
	end	


	-- ---------------------------------------- --
	-- Context options to clean up code further --
	-- You can use these functions to return    --
	-- Basic answers to. 						--
	-- HashTagLetsKeepCodeClean					--
	-- ---------------------------------------- --
	
	function NPC_Options_OffOn() -- Because Order of position Matters of if 'Off' and 'On' is first in the options in question
		return { getOptionText("Off"), getOptionText("On") }
	end
	function NPC_Options_ZeroToOneHundred()
		return 	{ "0%","1%","2%","3%","4%","5%","6%","7%","8%","9%","10%","11%","12%","13%","14%","15%","16%","17%","18%","19%","20%","21%","22%","23%","24%","25%","26%","27%","28%","29%","30%","31%","32%","33%","34%","35%","36%","37%","38%","39%","40%","41%","42%","43%","44%","45%","46%","47%","48%","49%","50%","51%","52%","53%","54%","55%","56%","57%","58%","59%","60%","61%","62%","63%","64%","65%","66%","67%","68%","69%","70%","71%","72%","73%","74%","75%","76%","77%","78%","79%","80%","81%","82%","83%","84%","85%","86%","87%","88%","89%","90%","91%","92%","93%","94%","95%","96%","97%","98%","99%","100%"}
	end
	function NPC_Options_ZeroToOneHundredAbsolute()
		return 	{ "0","1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100"}
	end

    -- store the original MainOptions:create() method in a variable
    local oldCreate = MainOptions.create

    -- overwrite it
    function MainOptions:create()
        oldCreate(self)
        for _, keyTextElement in pairs(MainOptions.keyText) do repeat
            -- if keyTextElement is nil or doesn't have a ISLabel, break out of the 
            -- "repeat ... until true"  loop, and continue with the "for .. do ... end" 
            -- loop
            if not keyTextElement or not keyTextElement.txt then break end
            local label = keyTextElement.txt -- our ISLabel item is stored in keyTextElement.txt
            -- We need to do a few things here to prep the new entries.
            -- 1) We wont have a proper translation, and the translation will be set to
            --    "UI_optionscreen_binding_Equip/Unequip Pistol", which will look funny on the 
            --    options screen, so we need to fix
            -- 2) the new translation doesn't properly adjust the x position and width, so we need to 
            --    manually adjust these
            
            if label.name == "Call Closest Group Member" then
                label:setTranslation(getOptionText("CallClosestGroupMember"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "Call Closest Non-Group Member" then 
                label:setTranslation(getOptionText("CallClosestNonGroupMember"))
                label:setX(label.x)
                label:setWidth(label.width)
             elseif label.name == "Ask Closest Group Member to Follow" then 
                label:setTranslation(getOptionText("AskClosestGroupMembertoFollow"))
                label:setX(label.x)
                label:setWidth(label.width)
             elseif label.name == "Spawn Wild Survivor" then 
                label:setTranslation(getOptionText("SpawnWildSurvivor"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "Toggle Group Window" then  
                label:setTranslation(getOptionText("ToggleGroupWindow"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "Lower Follow Distance" then  
                label:setTranslation(getOptionText("LowerFollowDistance"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "Raise Follow Distance" then  
                label:setTranslation(getOptionText("RaiseFollowDistance"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "SSHotkey_1" then  
                label:setTranslation(getOptionText("SShotkey1"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "SSHotkey_2" then  
                label:setTranslation(getOptionText("SShotkey2"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "SSHotkey_3" then  
                label:setTranslation(getOptionText("SShotkey3"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "SSHotkey_4" then  
                label:setTranslation(getOptionText("SShotkey4"))
                label:setX(label.x)
                label:setWidth(label.width)
            end
		   
        until true end
		
		
		
		----- Survivor options in Game Options -----
		local spacing = 3
		local spacing2x = 20
		local spacing4x = 30
	
		self:addPage(getOptionText("Title").." 0.17.3")
		self.addY = 0
		
		local label
		local y = 5
		local comboWidth = 300
		local splitpoint = self:getWidth() / 3;
		-------------------------------------------


	y = y + spacing2x


		local options = 
		{
			getOptionText("Off"),
			getOptionText("UltraLow"),
			getOptionText("ExtremelyLow"), 
			getOptionText("VeryLow"), 
			getOptionText("Low"), 
			getOptionText("SlightlyLower"), 
			getOptionText("Normal"), 
			getOptionText("SlightlyHigher"), 
			getOptionText("High"),
			getOptionText("VeryHigh"),
			getOptionText("ExtremelyHigh"),
			getOptionText("UltraHigh")
		}
		self:addCustomCombo('SpawnRate',splitpoint,y,comboWidth,getOptionText("SurvivorSpawnRate"),options,getOptionText("SurvivorSpawnRateDesc"))


	y = y + spacing4x


		local options = 
		{
			getOptionText("AltSpawnOff"), 
			getOptionText("UpTo1"),getOptionText("UpTo2"),
			getOptionText("UpTo3"),getOptionText("UpTo4"),
			getOptionText("UpTo5"),getOptionText("UpTo6")
		}
		self:addCustomCombo('AltSpawn',splitpoint,y,comboWidth,getOptionText("AltSpawn"),options,getOptionText("AltSpawnDesc"))

		local options = NPC_Options_ZeroToOneHundred()
		self:addCustomCombo('AltSpawnPercent',splitpoint,y,comboWidth,getOptionText("AltSpawnPercent"),options,getOptionText("AltSpawnPercentDesc"))
		
		local options = 
		{
			getOptionText("AltSpawnAmount_1"),
			getOptionText("AltSpawnAmount_2"),
			getOptionText("AltSpawnAmount_3"),
			getOptionText("AltSpawnAmount_4"),
			getOptionText("AltSpawnAmount_5"),
			getOptionText("AltSpawnAmount_6")
		}
		self:addCustomCombo('AltSpawnAmount',splitpoint,y,comboWidth,getOptionText("AltSpawnAmount"),options,getOptionText("AltSpawnAmountDesc"))


	y = y + spacing4x


		local options = 
		{
			getOptionText("Every5Days"), 	getOptionText("Every10Days"), getOptionText("Every15Days"), getOptionText("Every20Days"), 
			getOptionText("Every25Days"), getOptionText("Every30Days"), getOptionText("Every35Days"), getOptionText("Every40Days"), 
			getOptionText("Every45Days"), getOptionText("Every50Days"), getOptionText("Every55Days"), getOptionText("Every60Days"), 
			getOptionText("Every65Days"), getOptionText("Every70Days"), getOptionText("Every75Days"), getOptionText("Every80Days"), 
			getOptionText("Every85Days"), getOptionText("Every90Days"), getOptionText("Every95Days"), getOptionText("Every100Days"),
			getOptionText("EveryDay"), 		getOptionText("EveryHour"), 	getOptionText("Every10Minutes")
		}
		self:addCustomCombo('RaidersAtLeastHours',splitpoint,y,comboWidth,getOptionText("RaidersGuaranteed"),options,getOptionText("RaidersGuaranteedDesc"))

		local options = 
		{
			getOptionText("StartImmediately"),	getOptionText("AfterDay1"), 
			getOptionText("AfterDay5"), 				getOptionText("AfterDay10"), 
			getOptionText("AfterDay15"), 				getOptionText("AfterDay20"), 
			getOptionText("AfterDay25"), 				getOptionText("AfterDay30"), 
			getOptionText("AfterDay35"), 				getOptionText("AfterDay40"), 
			getOptionText("AfterDay45"), 				getOptionText("AfterDay50"), 
			getOptionText("AfterDay55"), 				getOptionText("AfterDay60"),
			getOptionText("AfterDay65"), 				getOptionText("AfterDay70"), 
			getOptionText("AfterDay75"), 				getOptionText("AfterDay80"), 
			getOptionText("AfterDay85"), 				getOptionText("AfterDay90"), 
			getOptionText("AfterDay95"),				getOptionText("Never")
		}
		self:addCustomCombo('RaidersAfterHours',splitpoint,y,comboWidth,getOptionText("RaidersAfterHours"),options,getOptionText("RaidersAfterHoursDesc"))
		
		local options = 
		{
			getOptionText("VeryHigh"), getOptionText("High"),
			getOptionText("Normal"),
			getOptionText("Low"),getOptionText("VeryLow")
		}
		self:addCustomCombo('RaidersChance',splitpoint,y,comboWidth,getOptionText("RaidersChance"),options,getOptionText("RaidersChanceDesc"))


	y = y + spacing4x


		local options = NPC_Options_ZeroToOneHundred()
		self:addCustomCombo('WepSpawnRate',splitpoint,y,comboWidth,getOptionText("WepSpawnRate"),options,getOptionText("WepSpawnRateDesc"))

		local options = NPC_Options_ZeroToOneHundred()
		self:addCustomCombo('GunSpawnRate',splitpoint,y,comboWidth,getOptionText("ChancetoSpawnWithGun"),options,getOptionText("ChancetoSpawnWithGunDesc"))


	y = y + spacing4x


		local options = {getOptionText("Off"),getOptionText("On")}
		self:addCustomCombo('ForcePVP',splitpoint,y,comboWidth,getOptionText("PVPInfoBar"),options,getOptionText("PVPInfoBarDesc"))
		
		local options = NPC_Options_ZeroToOneHundred()
		self:addCustomCombo('HostileSpawnRate',splitpoint,y,comboWidth,getOptionText("ChancetobeHostile"),options,getOptionText("ChancetobeHostileDesc"))
		
		
		local options = NPC_Options_ZeroToOneHundred() -- Hostile Over Time Odds
		self:addCustomCombo('MaxHostileSpawnRate',splitpoint,y,comboWidth,getOptionText("MaxHostileSpawnRate"),options,getOptionText("MaxHostileSpawnRateDesc"))


	y = y + spacing4x


		local options = NPC_Options_OffOn()
		self:addCustomCombo('Display_Survivor_Names',splitpoint,y,comboWidth,getOptionText("Display_Survivor_Names"),options,getOptionText("Display_Survivor_NamesDesc"))
		
		local options = NPC_Options_OffOn()
		self:addCustomCombo('Display_Hostile_Color',splitpoint,y,comboWidth,getOptionText("Display_Hostile_Color"),options,getOptionText("Display_Hostile_ColorDesc"))
			
		local options = NPC_Options_OffOn()
		self:addCustomCombo('RoleplayMessage',splitpoint,y,comboWidth,getOptionText("RoleplayMessage"),options,getOptionText("RoleplayMessageDesc"))


	y = y + spacing4x


		local options = NPC_Options_OffOn()
		self:addCustomCombo('WifeSpawn',splitpoint,y,comboWidth,getOptionText("WifeSpawn"),options,getOptionText("WifeSpawnDesc"))

		local options = NPC_Options_OffOn()
		self:addCustomCombo('LockNLoad',splitpoint,y,comboWidth,getOptionText("LockNLoad"),options,getOptionText("LockNLoadDesc"))


	y = y + spacing4x


		local options = {"3","4","5","6","7","8","9","10"}
		self:addCustomCombo('FollowDistance',splitpoint,y,comboWidth,getOptionText("FollowGlobalRange"),options,getOptionText("FollowGlobalRangeDesc"))
			
		local options = NPC_Options_OffOn()
		self:addCustomCombo('Perception_Bonus',splitpoint,y,comboWidth,getOptionText("PerceptionBonus"),options,getOptionText("PerceptionBonusDesc"))
		
		local options = NPC_Options_ZeroToOneHundredAbsolute()
		self:addCustomCombo('Panic_Distance',splitpoint,y,comboWidth,getOptionText("Panic_Distance"),options,getOptionText("Panic_DistanceDesc"))


	y = y + spacing4x


		local options = 
		{
			getOptionText("DesperateforHumanContact"), getOptionText("VeryFriendly"), 
			getOptionText("Friendly"), getOptionText("Normal"), 
			getOptionText("Mean"), getOptionText("VeryMean")
		}
		self:addCustomCombo('SurvivorFriendliness',splitpoint,y,comboWidth,getOptionText("SurvivorFriendliness"),options,getOptionText("SurvivorFriendlinessDesc"))
			
		local options = 
		{
			getOptionText("Cowardly"), getOptionText("Normal"),
			getOptionText("Brave"), getOptionText("VeryBrave")
		}
		self:addCustomCombo('Bravery',splitpoint,y,comboWidth,getOptionText("SurvivorBravery"),options,getOptionText("SurvivorBraveryDesc"))

		local options = NPC_Options_OffOn()
		self:addCustomCombo('NoPreSetSpawn',splitpoint,y,comboWidth,getOptionText("NoPreSetSpawn"),options,getOptionText("NoPreSetSpawnDesc"))


	y = y + spacing4x


		local options = NPC_Options_OffOn()
		self:addCustomCombo('InfinitAmmo',splitpoint,y,comboWidth,getOptionText("InfinitAmmo"),options,getOptionText("InfinitAmmoDesc"))
		
		local options = NPC_Options_OffOn()
		self:addCustomCombo('FindWork',splitpoint,y,comboWidth,getOptionText("FindWork"),options,getOptionText("FindWorkDesc"))
		
		local options = NPC_Options_OffOn()
		self:addCustomCombo('SurvivorHunger',splitpoint,y,comboWidth,getOptionText("SurvivorHunger"),options,getOptionText("SurvivorHungerDesc"))
		
		local options = NPC_Options_OffOn()
		self:addCustomCombo('SafeBase',splitpoint,y,comboWidth,getOptionText("SafeBase"),options,getOptionText("SafeBaseDesc"))
		
		local options = NPC_Options_OffOn()
		self:addCustomCombo('SurvivorBases',splitpoint,y,comboWidth,getOptionText("SurvivorBases"),options,getOptionText("SurvivorBasesDesc"))		


	y = y + spacing4x


		local options = SSHotKeyOptions
		self:addCustomCombo('Hotkey1',splitpoint,y,comboWidth,getOptionText("hotkey1"),options,getOptionText("hotkeyDesc"))					
	
		local options = SSHotKeyOptions
		self:addCustomCombo('SSHotkey2',splitpoint,y,comboWidth,getOptionText("hotkey2"),options,getOptionText("hotkeyDesc"))					
	
		local options = SSHotKeyOptions
		self:addCustomCombo('Hotkey3',splitpoint,y,comboWidth,getOptionText("hotkey3"),options,getOptionText("hotkeyDesc"))					

		local options = SSHotKeyOptions
		self:addCustomCombo('Hotkey4',splitpoint,y,comboWidth,getOptionText("hotkey4"),options,getOptionText("hotkeyDesc"))		
		

	y = y + spacing4x


		local options = NPC_Options_OffOn()
		self:addCustomCombo('DebugOptions',splitpoint,y,comboWidth,getOptionText("DebugOptions"),options,getOptionText("DebugOptionsDesc"))		
	
		local options = NPC_Options_OffOn()
		self:addCustomCombo('DebugSay',splitpoint,y,comboWidth,getOptionText("DebugSay"),options,getOptionText("DebugSayDesc"))		

		local options = NPC_Options_ZeroToOneHundredAbsolute()
		self:addCustomCombo('DebugSay_Distance',splitpoint,y,comboWidth,getOptionText("DebugSay_Distance"),options,getOptionText("DebugSay_DistanceDesc"))		

		local options = NPC_Options_OffOn()
		self:addCustomCombo('WarningMSG',splitpoint,y,comboWidth,getOptionText("WarningMSG"),options,getOptionText("WarningMSGDesc"))		



		-- Controls the rest of the menu, don't put options under this line you're reading --
		 self.addY = self.addY+MainOptions.translatorPane:getHeight()+22;

		self.mainPanel:setScrollHeight(y + self.addY + 20)
    end
end