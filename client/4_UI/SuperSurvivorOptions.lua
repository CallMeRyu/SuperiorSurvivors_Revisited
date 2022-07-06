-- thanks and some credit to Fenris_Wolf from ORGM mod for creating this hotkeys file!  I just tweaked it to use my own key bindings! and added support for settings too ~Nolan


function SuperSurvivorGetOption(option)
	
	if(SuperSurvivorOptions[option] ~= nil) then return tonumber(SuperSurvivorOptions[option])
	else return 1 end

end
function SuperSurvivorGetOptionValue(option)
	
	local num = SuperSurvivorGetOption(option)
	print("num:"..tostring(num))
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
	if(not SuperSurvivorOptions["SurvivorFriendliness"]) then SuperSurvivorOptions["SurvivorFriendliness"] = 4 end
	
	if(not SuperSurvivorOptions["Option_Perception_Bonus"]) then SuperSurvivorOptions["Option_Perception_Bonus"] = 2 end
	
	if(not SuperSurvivorOptions["RaidersAtLeastHours"]) then SuperSurvivorOptions["RaidersAtLeastHours"] = 13 end
	if(not SuperSurvivorOptions["RaidersAfterHours"]) then SuperSurvivorOptions["RaidersAfterHours"] = 7 end
	if(SuperSurvivorOptions["RaidersAfterHours"] > 22) then SuperSurvivorOptions["RaidersAfterHours"] = 22 end -- fix legacy bad value
	if(not SuperSurvivorOptions["RaidersChance"]) then SuperSurvivorOptions["RaidersChance"] = 3 end
	if(not SuperSurvivorOptions["Option_FollowDistance"]) then SuperSurvivorOptions["Option_FollowDistance"] = 5 end
	if(not SuperSurvivorOptions["Option_ForcePVP"]) then SuperSurvivorOptions["Option_ForcePVP"] = 0 end
	
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
	SSHotKeyOptions[i] = getText("ContextMenu_SD_OrderAll") .. " " .. OrderDisplayName[Orders[i]]
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
		return { getText("ContextMenu_SD_Off"), getText("ContextMenu_SD_On") }
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
                label:setTranslation(getText("ContextMenu_SOption_CallClosestGroupMember"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "Call Closest Non-Group Member" then 
                label:setTranslation(getText("ContextMenu_SOption_CallClosestNonGroupMember"))
                label:setX(label.x)
                label:setWidth(label.width)
             elseif label.name == "Ask Closest Group Member to Follow" then 
                label:setTranslation(getText("ContextMenu_SOption_AskClosestGroupMembertoFollow"))
                label:setX(label.x)
                label:setWidth(label.width)
             elseif label.name == "Spawn Wild Survivor" then 
                label:setTranslation(getText("ContextMenu_SOption_SpawnWildSurvivor"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "Toggle Group Window" then  
                label:setTranslation(getText("ContextMenu_SOption_ToggleGroupWindow"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "Lower Follow Distance" then  
                label:setTranslation(getText("ContextMenu_SOption_LowerFollowDistance"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "Raise Follow Distance" then  
                label:setTranslation(getText("ContextMenu_SOption_RaiseFollowDistance"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "SSHotkey_1" then  
                label:setTranslation(getText("ContextMenu_SShotkey1"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "SSHotkey_2" then  
                label:setTranslation(getText("ContextMenu_SShotkey2"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "SSHotkey_3" then  
                label:setTranslation(getText("ContextMenu_SShotkey3"))
                label:setX(label.x)
                label:setWidth(label.width)
            elseif label.name == "SSHotkey_4" then  
                label:setTranslation(getText("ContextMenu_SShotkey4"))
                label:setX(label.x)
                label:setWidth(label.width)
            end
		   
        until true end
		
		
		
		----- Survivor options in Game Options -----
		local spacing = 3
		local spacing2x = 20
		local spacing4x = 30
	
		self:addPage(getText("ContextMenu_Title"))
		self.addY = 0
		
		local label
		local y = 5
		local comboWidth = 300
		local splitpoint = self:getWidth() / 3;
		-------------------------------------------


	y = y + spacing2x


		local options = 
		{
			getText("ContextMenu_SD_Off"),
			getText("ContextMenu_SD_UltraLow"),
			getText("ContextMenu_SD_ExtremelyLow"), 
			getText("ContextMenu_SD_VeryLow"), 
			getText("ContextMenu_SD_Low"), 
			getText("ContextMenu_SD_SlightlyLower"), 
			getText("ContextMenu_SD_Normal"), 
			getText("ContextMenu_SD_SlightlyHigher"), 
			getText("ContextMenu_SD_High"),
			getText("ContextMenu_SD_VeryHigh"),
			getText("ContextMenu_SD_ExtremelyHigh"),
			getText("ContextMenu_SD_UltraHigh")
		}
		self:addCustomCombo('SpawnRate',splitpoint,y,comboWidth,getText("ContextMenu_SOption_SurvivorSpawnRate"),options,getText("ContextMenu_SOption_SurvivorSpawnRateDesc"))


	y = y + spacing4x


		local options = 
		{
			getText("ContextMenu_SD_AltSpawnOff"), 
			getText("ContextMenu_SD_UpTo1"),getText("ContextMenu_SD_UpTo2"),
			getText("ContextMenu_SD_UpTo3"),getText("ContextMenu_SD_UpTo4"),
			getText("ContextMenu_SD_UpTo5"),getText("ContextMenu_SD_UpTo6")
		}
		self:addCustomCombo('AltSpawn',splitpoint,y,comboWidth,getText("ContextMenu_SOption_AltSpawn"),options,getText("ContextMenu_SOption_AltSpawnDesc"))

		local options = NPC_Options_ZeroToOneHundred()
		self:addCustomCombo('AltSpawnPercent',splitpoint,y,comboWidth,getText("ContextMenu_SOption_AltSpawnPercent"),options,getText("ContextMenu_SOption_AltSpawnPercentDesc"))
		
		local options = 
		{
			getText("ContextMenu_AltSpawnAmount_1"),
			getText("ContextMenu_AltSpawnAmount_2"),
			getText("ContextMenu_AltSpawnAmount_3"),
			getText("ContextMenu_AltSpawnAmount_4"),
			getText("ContextMenu_AltSpawnAmount_5"),
			getText("ContextMenu_AltSpawnAmount_6")
		}
		self:addCustomCombo('AltSpawnAmount',splitpoint,y,comboWidth,getText("ContextMenu_Option_AltSpawnAmount"),options,getText("ContextMenu_Context_AltSpawnAmountDesc"))


	y = y + spacing4x


		local options = 
		{
			getText("ContextMenu_SD_Every5Days"), getText("ContextMenu_SD_Every10Days"), getText("ContextMenu_SD_Every15Days"), getText("ContextMenu_SD_Every20Days"), 
			getText("ContextMenu_SD_Every25Days"), getText("ContextMenu_SD_Every30Days"), getText("ContextMenu_SD_Every35Days"), getText("ContextMenu_SD_Every40Days"), 
			getText("ContextMenu_SD_Every45Days"), getText("ContextMenu_SD_Every50Days"), getText("ContextMenu_SD_Every55Days"), getText("ContextMenu_SD_Every60Days"), 
			getText("ContextMenu_SD_Every65Days"), getText("ContextMenu_SD_Every70Days"), getText("ContextMenu_SD_Every75Days"), getText("ContextMenu_SD_Every80Days"), 
			getText("ContextMenu_SD_Every85Days"), getText("ContextMenu_SD_Every90Days"), getText("ContextMenu_SD_Every95Days"), getText("ContextMenu_SD_Every100Days"),
			getText("ContextMenu_SD_EveryDay"), getText("ContextMenu_SD_EveryHour"), getText("ContextMenu_SD_Every10Minutes")
		}
		self:addCustomCombo('RaidersAtLeastHours',splitpoint,y,comboWidth,getText("ContextMenu_SOption_RaidersGuaranteed"),options,getText("ContextMenu_SOption_RaidersGuaranteedDesc"))

		local options = 
		{
			getText("ContextMenu_SD_StartImmediately"),	getText("ContextMenu_SD_AfterDay1"), 
			getText("ContextMenu_SD_AfterDay5"), 				getText("ContextMenu_SD_AfterDay10"), 
			getText("ContextMenu_SD_AfterDay15"), 			getText("ContextMenu_SD_AfterDay20"), 
			getText("ContextMenu_SD_AfterDay25"), 			getText("ContextMenu_SD_AfterDay30"), 
			getText("ContextMenu_SD_AfterDay35"), 			getText("ContextMenu_SD_AfterDay40"), 
			getText("ContextMenu_SD_AfterDay45"), 			getText("ContextMenu_SD_AfterDay50"), 
			getText("ContextMenu_SD_AfterDay55"), 			getText("ContextMenu_SD_AfterDay60"),
			getText("ContextMenu_SD_AfterDay65"), 			getText("ContextMenu_SD_AfterDay70"), 
			getText("ContextMenu_SD_AfterDay75"), 			getText("ContextMenu_SD_AfterDay80"), 
			getText("ContextMenu_SD_AfterDay85"), 			getText("ContextMenu_SD_AfterDay90"), 
			getText("ContextMenu_SD_AfterDay95"),				getText("ContextMenu_SD_Never")
		}
		self:addCustomCombo('RaidersAfterHours',splitpoint,y,comboWidth,getText("ContextMenu_SOption_RaidersAfterHours"),options,getText("ContextMenu_SOption_RaidersAfterHoursDesc"))
		
		local options = 
		{
			getText("ContextMenu_SD_VeryHigh"), getText("ContextMenu_SD_High"),
			getText("ContextMenu_SD_Normal"),
			getText("ContextMenu_SD_Low"),getText("ContextMenu_SD_VeryLow")
		}
		self:addCustomCombo('RaidersChance',splitpoint,y,comboWidth,getText("ContextMenu_SOption_RaidersChance"),options,getText("ContextMenu_SOption_RaidersChanceDesc"))


	y = y + spacing4x


		local options = NPC_Options_ZeroToOneHundred()
		self:addCustomCombo('WepSpawnRate',splitpoint,y,comboWidth,getText("ContextMenu_SOption_WepSpawnRate"),options,getText("ContextMenu_SOption_WepSpawnRateDesc"))

		local options = NPC_Options_ZeroToOneHundred()
		self:addCustomCombo('GunSpawnRate',splitpoint,y,comboWidth,getText("ContextMenu_SOption_ChancetoSpawnWithGun"),options,getText("ContextMenu_SOption_ChancetoSpawnWithGunDesc"))


	y = y + spacing4x


		local options = {getText("ContextMenu_SD_PVPOff"),getText("ContextMenu_SD_PVPOn")}
		self:addCustomCombo('Option_ForcePVP',splitpoint,y,comboWidth,getText("ContextMenu_SD_PVPInfoBar"),options,getText("ContextMenu_SD_PVPInfoBarDesc"))
		
		local options = NPC_Options_ZeroToOneHundred()
		self:addCustomCombo('HostileSpawnRate',splitpoint,y,comboWidth,getText("ContextMenu_SOption_ChancetobeHostile"),options,getText("ContextMenu_SOption_ChancetobeHostileDesc"))
		
		
		local options = NPC_Options_ZeroToOneHundred() -- Hostile Over Time Odds
		self:addCustomCombo('MaxHostileSpawnRate',splitpoint,y,comboWidth,getText("ContextMenu_SOption_MaxHostileSpawnRate"),options,getText("ContextMenu_SOption_MaxHostileSpawnRateDesc"))


	y = y + spacing4x


		local options = NPC_Options_OffOn()
		self:addCustomCombo('Option_Display_Survivor_Names',splitpoint,y,comboWidth,getText("ContextMenu_Option_Display_Survivor_Names"),options,getText("ContextMenu_Option_Display_Survivor_NamesDesc"))
		
		local options = NPC_Options_OffOn()
		self:addCustomCombo('Option_Display_Hostile_Color',splitpoint,y,comboWidth,getText("ContextMenu_Option_Display_Hostile_Color"),options,getText("ContextMenu_Option_Display_Hostile_ColorDesc"))
			
		local options = NPC_Options_OffOn()
		self:addCustomCombo('RoleplayMessage',splitpoint,y,comboWidth,getText("ContextMenu_SOption_RoleplayMessage"),options,getText("ContextMenu_SOption_RoleplayMessageDesc"))


	y = y + spacing4x


		local options = NPC_Options_OffOn()
		self:addCustomCombo('WifeSpawn',splitpoint,y,comboWidth,getText("ContextMenu_SOption_WifeSpawn"),options,getText("ContextMenu_SOption_WifeSpawnDesc"))

		local options = NPC_Options_OffOn()
		self:addCustomCombo('LockNLoad',splitpoint,y,comboWidth,getText("ContextMenu_SOption_LockNLoad"),options,getText("ContextMenu_SOption_LockNLoadDesc"))


	y = y + spacing4x


		local options = {"3","4","5","6","7","8","9","10"}
		self:addCustomCombo('Option_FollowDistance',splitpoint,y,comboWidth,getText("ContextMenu_SOption_FollowGlobalRange"),options,getText("ContextMenu_SOption_FollowGlobalRangeDesc"))
			
		local options = NPC_Options_OffOn()
		self:addCustomCombo('Option_Perception_Bonus',splitpoint,y,comboWidth,getText("ContextMenu_SOption_PerceptionBonus"),options,getText("ContextMenu_SOption_PerceptionBonusDesc"))


	y = y + spacing4x


		local options = 
		{
			getText("ContextMenu_SD_DesperateforHumanContact"), getText("ContextMenu_SD_VeryFriendly"), 
			getText("ContextMenu_SD_Friendly"), getText("ContextMenu_SD_Normal"), 
			getText("ContextMenu_SD_Mean"), getText("ContextMenu_SD_VeryMean")
		}
		self:addCustomCombo('SurvivorFriendliness',splitpoint,y,comboWidth,getText("ContextMenu_SOption_SurvivorFriendliness"),options,getText("ContextMenu_SOption_SurvivorFriendlinessDesc"))
			
		local options = 
		{
			getText("ContextMenu_SD_Cowardly"), getText("ContextMenu_SD_Normal"),
			getText("ContextMenu_SD_Brave"), getText("ContextMenu_SD_VeryBrave")
		}
		self:addCustomCombo('Bravery',splitpoint,y,comboWidth,getText("ContextMenu_SOption_SurvivorBravery"),options,getText("ContextMenu_SOption_SurvivorBraveryDesc"))

		local options = NPC_Options_OffOn()
		self:addCustomCombo('NoPreSetSpawn',splitpoint,y,comboWidth,getText("ContextMenu_SD_NoPreSetSpawn"),options,getText("ContextMenu_SD_NoPreSetSpawnDesc"))


	y = y + spacing4x


		local options = NPC_Options_OffOn()
		self:addCustomCombo('InfinitAmmo',splitpoint,y,comboWidth,getText("ContextMenu_SOption_InfinitAmmo"),options,getText("ContextMenu_SOption_InfinitAmmoDesc"))
		
		local options = NPC_Options_OffOn()
		self:addCustomCombo('FindWork',splitpoint,y,comboWidth,getText("ContextMenu_SOption_FindWork"),options,getText("ContextMenu_SOption_FindWorkDesc"))
		
		local options = NPC_Options_OffOn()
		self:addCustomCombo('SurvivorHunger',splitpoint,y,comboWidth,getText("ContextMenu_SOption_SurvivorHunger"),options,getText("ContextMenu_SOption_SurvivorHungerDesc"))
		
		local options = NPC_Options_OffOn()
		self:addCustomCombo('SafeBase',splitpoint,y,comboWidth,getText("ContextMenu_SOption_SafeBase"),options,getText("ContextMenu_SOption_SafeBaseDesc"))
		
		local options = NPC_Options_OffOn()
		self:addCustomCombo('SurvivorBases',splitpoint,y,comboWidth,getText("ContextMenu_SOption_SurvivorBases"),options,getText("ContextMenu_SOption_SurvivorBasesDesc"))		


	y = y + spacing4x


		local options = SSHotKeyOptions
		self:addCustomCombo('SSHotkey1',splitpoint,y,comboWidth,getText("ContextMenu_SShotkey1"),options,getText("ContextMenu_SShotkeyDesc"))					
	
		local options = SSHotKeyOptions
		self:addCustomCombo('SSHotkey2',splitpoint,y,comboWidth,getText("ContextMenu_SShotkey2"),options,getText("ContextMenu_SShotkeyDesc"))					
	
		local options = SSHotKeyOptions
		self:addCustomCombo('SSHotkey3',splitpoint,y,comboWidth,getText("ContextMenu_SShotkey3"),options,getText("ContextMenu_SShotkeyDesc"))					

		local options = SSHotKeyOptions
		self:addCustomCombo('SSHotkey4',splitpoint,y,comboWidth,getText("ContextMenu_SShotkey4"),options,getText("ContextMenu_SShotkeyDesc"))		
		

	y = y + spacing4x


		local options = NPC_Options_OffOn()
		self:addCustomCombo('DebugOptions',splitpoint,y,comboWidth,getText("ContextMenu_SOption_DebugOptions"),options,getText("ContextMenu_SOption_DebugOptionsDesc"))		
	
		local options = NPC_Options_OffOn()
		self:addCustomCombo('DebugOption_DebugSay',splitpoint,y,comboWidth,getText("ContextMenu_SDebugOption_DebugSay"),options,getText("ContextMenu_SDebugOption_DebugSayDesc"))		

		local options = NPC_Options_ZeroToOneHundredAbsolute()
		self:addCustomCombo('DebugOption_DebugSay_Distance',splitpoint,y,comboWidth,getText("ContextMenu_SDebugOption_DebugSay_Distance"),options,getText("ContextMenu_SDebugOption_DebugSay_DistanceDesc"))		




		-- Controls the rest of the menu, don't put options under this line you're reading --
		 self.addY = self.addY+MainOptions.translatorPane:getHeight()+22;

		self.mainPanel:setScrollHeight(y + self.addY + 20)
    end
end