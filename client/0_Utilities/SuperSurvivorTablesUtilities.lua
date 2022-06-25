-- this file only has methods related to deal with files

local modid =  "SuperiorSubparSurvivors"

function doesFileExist( fileName )
	local fileTable = {}
	local readFile = getModFileReader(modid,getWorld():getWorld()..getFileSeparator()..fileName, false)

	if(readFile) then return true
	else return false end
end

function table.load( fileName )
	local fileTable = {}
	local readFile = getModFileReader(modid,getWorld():getWorld()..getFileSeparator()..fileName..".lua", true)
	if(readFile) then
		local scanLine = readFile:readLine()
		while scanLine do
			fileTable[#fileTable+1] = scanLine
			scanLine = readFile:readLine()
			if not scanLine then break end
		end
		readFile:close()
		return fileTable
	end
	return nil
end

function size(a)
 local i = 1
    while a[i] do
      i = i + 1
    end
	return i;
end

function table.save( tbl,fileName )

	local destFile = getWorld():getWorld()..getFileSeparator()..fileName..".lua"
	--print("table.saving:".. destFile)
	local writeFile = getModFileWriter(modid, destFile, true, false)
	for i = 1,#tbl do
		writeFile:write(tbl[i].."\r\n");
		--print(tbl[i])
	end
	writeFile:close();
end



function kvtableload( fileName )

	local fileTable = {}
	local readFile = getModFileReader(modid,getWorld():getWorld()..getFileSeparator()..fileName , true)

	if( not readFile ) then return {} end

	local scanLine = readFile:readLine()
	while scanLine do

		local values = {}
		for input in scanLine:gmatch("%S+") do table.insert(values,input) end
		print(fileName..": loading line: "..values[1] .. " " .. values[2])

		fileTable[values[1]] = values[2];

		scanLine = readFile:readLine()
		if not scanLine then break end
	end
	readFile:close()
	return fileTable
end


function kvtablesave( fileTable, fileName )


	if(not fileTable) then return false end

	local destFile = getWorld():getWorld()..getFileSeparator()..fileName
	local writeFile = getModFileWriter(modid, destFile, true, false)
	--print("saving fileTable:".. tostring(fileTable))
	for index,value in pairs(fileTable) do

		writeFile:write(tostring(index) .. " " .. tostring(value) .. "\r\n");
		--print("saving: " .. tostring(index) .. " " .. tostring(value[i]))
	end
	writeFile:close();


end



function getSaveDir()
	return Core.getMyDocumentFolder()..getFileSeparator().."Saves"..getFileSeparator().. getWorld():getGameMode() .. getFileSeparator() .. getWorld():getWorld().. getFileSeparator();
end