-- this file only has methods related to deal with files

local modid = "SuperiorSubparSurvivors"

--- DEBUG ---

local enableDebugTable = false

local function debugMethodName(text)
	if enableDebugTable then
		print(" -----" .. text .. "----- ")
	end
end

--- this method is for only concat strings when debug is enabled 
---@param action string any action that the method is doing
---@param value string the target of the action 
local function debugMethodAction(action,value)
	if enableDebugTable then 
		print(action .. " : " .. value)
	end
end

local function debugTable(text)
	if enableDebugTable then
		print(text)
	end
end

--- DEBUG ---

--- gets the full path of a .lua of a save file
---@param fileName string any Name
---@return string
local function getFileFullPath(fileName)
	return getWorld():getWorld()..getFileSeparator()..fileName
end

--- Checks if a file of a savegame exists
---@param fileName string file to be searched
---@return boolean returns true if the current file exists
function doesFileExist( fileName )
	local fileTable = {}
	local readFile = getModFileReader(modid, getFileFullPath(fileName), false)

	if(readFile) then 
		return true
	else 
		return false 
	end
end

--- gets a random item from a table
---@param t table a table
---@return any an random item of t table
function table.randFrom( t )
	local keys = {}

	for key, value in pairs(t) do
		keys[#keys+1] = key --Store keys in another table
	end

	local key = ZombRand(1, #keys)
	return keys[key]
end

--- loads a table from a .lua file
---@param fileName string the filename that the table will be loaded
---@return table a table with all data from filename or nil if not found
function table.load( fileName )
	debugMethodName("table.load")
	debugMethodAction("loading file", fileName)

	local fileTable = {}
	local readFile = getModFileReader(modid,getFileFullPath(fileName .. ".lua"), true)

	if(readFile) then
		local scanLine = readFile:readLine()
		
		while scanLine do
			debugMethodAction("reading line", tostring(#fileTable+1))

			fileTable[#fileTable+1] = scanLine
			scanLine = readFile:readLine()

			if not scanLine then 
				debugTable("end of the file")
				break 
			end
		end

		debugMethodAction("closing file", fileName)
		readFile:close()

		debugMethodName("table.load")
		return fileTable
	end

	debugMethodName("table.load")
	return nil
end

--- saves a table into a .lua file
---@param tbl table a table with data
---@param fileName string the name of the file to be created
function table.save( tbl,fileName )

	debugMethodName("table.save")
	debugMethodAction("saving file", fileName)
	
	local writeFile = getModFileWriter(modid, getFileFullPath(fileName .. ".lua"), true, false)
	
	for i = 1,#tbl do
		debugMethodAction("writing line", tostring(#tbl))
		writeFile:write(tbl[i].."\r\n");
	end
	
	debugMethodAction("closing file", fileName)
	writeFile:close();

	debugMethodName("table.save")
end

--- loads a table from a file
---@param fileName string the filename that the table will be loaded
---@return table a table with all data from filename or nil if not found
function kvtableload( fileName )

	debugMethodName("kvtableload")
	debugMethodAction("loading file", fileName)

	local fileTable = {}
	local readFile = getModFileReader(modid,getFileFullPath(fileName) , true)

	if( not readFile ) then 
		return {} 
	end

	local scanLine = readFile:readLine()
	while scanLine do
		debugMethodAction("reading line", tostring(#fileTable+1))

		local values = {}

		for input in scanLine:gmatch("%S+") do 
			table.insert(values,input) 
		end

		fileTable[values[1]] = values[2]

		scanLine = readFile:readLine()
		if not scanLine then 
			debugTable("end of the file")
			break 
		end
	end
	
	debugMethodAction("closing file", fileName)
	readFile:close()

	debugMethodName("kvtableload")
	return fileTable
end

--- saves a table into a file
---@param tbl table a table with data
---@param fileName string the name of the file to be created
function kvtablesave( fileTable, fileName )

	debugMethodName("kvtablesave")
	debugMethodAction("saving file", fileName)

	if(not fileTable) then 
		debugTable("table is empty")
		return false 
	end

	local writeFile = getModFileWriter(modid, getFileFullPath(fileName), true, false)
	
	for index,value in pairs(fileTable) do

		writeFile:write(tostring(index) .. " " .. tostring(value) .. "\r\n");
		debugMethodAction("writing line", tostring(index))

	end

	debugMethodAction("closing file", fileName)
	writeFile:close();

	debugMethodName("kvtablesave")
end


function getSaveDir()
	return Core.getMyDocumentFolder()..getFileSeparator().."Saves"..getFileSeparator().. getWorld():getGameMode() .. getFileSeparator() .. getWorld():getWorld().. getFileSeparator();
end