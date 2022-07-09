-- this file has methods related to world context

local enableDebugContext = false

--- Prints a debug message when enableDebugContext is true
---@param text string
local function debugContext(text)
	if enableDebugContext then
		print(text)
	end
end

--- SQUARES ---

---@alias direction 
---| '"N"' # North
---| '"S"' # South
---| '"E"' # East
---| '"W"' # West

---Get an adjacent square based on a direction
---@param square any  
---@param dir direction
---@return any the adjacent square
function GetAdjSquare(square,dir)

	if(dir == 'N') then
		return getCell():getGridSquare(square:getX(),square:getY() - 1,square:getZ());
	elseif(dir == 'E') then
		return getCell():getGridSquare(square:getX() + 1,square:getY(),square:getZ());
	elseif(dir == 'S') then
		return getCell():getGridSquare(square:getX(),square:getY() + 1,square:getZ());
	else
		return getCell():getGridSquare(square:getX() - 1,square:getY(),square:getZ());
	end
end

--- gets all squares between 2 positions (don't use it with large distances)
---@param from any start square
---@param to any target square 
---@return table returns a table with the squares between the start and target squares (includes the target square)
function getSquaresBetween(from,to)
	
	local fromX = math.ceil(from:getX())
	local fromY = math.ceil(from:getY())
	
	local toX = math.ceil(to:getX())
	local toY = math.ceil(to:getY())

	local squares = {}
	local pos = 0
	local sqr = from
	
	debugContext("----- getSquaresBetween -----")
	debugContext("from x : " .. tostring(fromX) .. " from y : " .. tostring(fromY))
	debugContext("to x : " .. tostring(toX) .. " to y : " .. tostring(toY))

	repeat
		if fromY < toY then
			sqr = GetAdjSquare(sqr,"S")
			fromY = fromY + 1
		elseif fromY > toY then
			sqr = GetAdjSquare(sqr,"N")
			fromY = fromY - 1
		end
		
		if fromX < toX then
			sqr = GetAdjSquare(sqr,"E")
			fromX = fromX + 1
		elseif fromX > toX then
			sqr = GetAdjSquare(sqr,"W")
			fromX = fromX - 1
		end
		
		debugContext("getting square x : " .. tostring(fromX) .. " y : " .. tostring(fromY))
		
		if sqr ~= nil then		
			debugContext("saving square x : " .. tostring(fromX) .. " y : " .. tostring(fromY) .. " into position : " .. tostring(pos))
			squares[pos] = sqr
			pos = pos + 1
		end
	until fromX == toX and fromY == toY

	debugContext("total squares : " .. tostring(pos))
	debugContext("----- getSquaresBetween -----")
	return squares
end

function getOutsideSquare(square,building)

	if(not building) or (not square) then 
		return nil 
	end

	local windowsquare = getCell():getGridSquare(square:getX(),square:getY(),square:getZ());
	if windowsquare~= nil and windowsquare:isOutside() then 
		return windowsquare 
	end

	local N = GetAdjSquare(square,"N")
	local E = GetAdjSquare(square,"E")
	local S = GetAdjSquare(square,"S")
	local W = GetAdjSquare(square,"W")

	if N and N:isOutside() then 
		return N
	elseif E and E:isOutside() then 
		return E
	elseif S and S:isOutside() then 
		return S
	elseif W and W:isOutside() then 
		return W
	else 
		return square
	end

end

-- TODO: remove this function and use getFleeSquareAlt
--- gets a random square awyas from the 'attackGuy'
---@param fleeGuy any 
---@param attackGuy any 
---@return any returns a random square away from attackGuy
function getFleeSquare(fleeGuy,attackGuy)
	return getFleeSquareAlt(fleeGuy,attackGuy,7)
end

--- New Function where you can choose the distance
---@param fleeGuy any
---@param attackGuy any
---@param distanceToFlee number distance that the flee guy will search for
---@return any returns a random square in a distance away from attackGuy
function getFleeSquareAlt(fleeGuy,attackGuy,distanceToFlee)
	local distance = distanceToFlee
	local tempx = (fleeGuy:getX() - attackGuy:getX());
	local tempy = (fleeGuy:getY() - attackGuy:getY());

	if (tempx < 0) then 
		tempx = -distance;
	else 
		tempx = distance; 
	end
	if (tempy < 0) then 
		tempy = -distance
	else 
		tempy = distance
	end

	local fleex = fleeGuy:getX() + tempx + ZombRand(-5,5)
	local fleey = fleeGuy:getY() + tempy + ZombRand(-5,5)

	return fleeGuy:getCell():getGridSquare(fleex,fleey,fleeGuy:getZ());
end

--- gets a square torwards a direction in a fixed distance (15)
---@param moveguy any
---@param x number
---@param y number
---@param z number
function getTowardsSquare(moveguy,x,y,z)
	local distance = 15
	local tempx = (moveguy:getX() - x);
	local tempy = (moveguy:getY() - y);

	if (tempx > 0) and (tempx >= distance) then 
		tempx = -distance;
	elseif (tempx < -distance) then 
		tempx = distance
	else 
		tempx = -tempx 
	end

	if (tempy > 0) and (tempy >= distance) then 
		tempy = -distance
	elseif (tempy < -distance) then 
		tempy = distance;
	else 
		tempy = -tempy 
	end

	local movex = moveguy:getX()+tempx+ZombRand(-2,2)
	local movey = moveguy:getY()+tempy+ZombRand(-2,2)

	return moveguy:getCell():getGridSquare(movex,movey,moveguy:getZ());
end

--- END SQUARES ---

--- COORDINATES ---
--- gets the coordinate from a npc survivor
---@param id any if of the npc survivor
---@return any
function getCoordsFromID(id)

	debugContext("----- getCoordsFromID -----")
	debugContext("id : " .. id)
	for k,v in pairs(SurvivorMap) do

		for i=1,#v do

			if(v[i] == id) then 
				return k 
      end

		end

	end
	debugContext("no survivor found")
	debugContext("----- getCoordsFromID -----")

	return 0

end

--- gets the distance between 2 things (objects, zombies, npcs or players)
---@param z1 any instance one
---@param z2 any instance two
---@return number the distance between the 2 instances
function getDistanceBetween(z1,z2)
	if(z1 == nil) or (z2 == nil) then 
		return -1 
	end

	local z1x = z1:getX()
	local z1y = z1:getY()
	local z1z = z1:getZ()

	local z2x = z2:getX()
	local z2y = z2:getY()
	local z2z = z2:getZ()

	local dx = z1x - z2x
	local dy = z1y - z2y
	local dz = z1z - z2z

	return math.sqrt ( dx * dx + dy * dy + (dz * dz * 2) )

end

--- gets the distance between 2 coordinates
---@param Ax number 
---@param Ay number
---@param Bx number
---@param By number 
---@return number the distance between the 2 points
function getDistanceBetweenPoints(Ax,Ay,Bx,By)
	if(Ax == nil) or (Bx == nil) then 
		return -1 
	end

	local dx = Ax - Bx
	local dy = Ay - By

	return math.sqrt ( dx * dx + dy * dy )

end
--- END COORDINATES ---

--- AREAS ----

--- checks if the square is inside of the area 'area'
---@param sq any
---@param area table a table with 4 positions representing a square of points(number)
function isSquareInArea(sq,area)

	local x1 = area[1]
	local x2 = area[2]
	local y1 = area[3]
	local y2 = area[4]

	if(sq:getX() > x1) and (sq:getX() <= x2) and (sq:getY() > y1) and (sq:getY() <= y2) and (sq:getZ() == area[5]) then 
    return true
	else 
    return false 
  end

end

--- gets the center square of an area
---@param x1 number
---@param x2 number
---@param y1 number
---@param y2 number
---@param z  number 
---@return any the center square given the coordinates
function getCenterSquareFromArea(x1,x2,y1,y2,z)

	local xdiff = x2 - x1
	local ydiff = y2 - y1

	local result = getCell():getGridSquare(x1+math.floor(xdiff/2),y1+math.floor(ydiff/2),z)

	return result

end

--- gets a random square inside of an area
---@param area any 
function getRandomAreaSquare(area)

	local x1 = area[1]
	local x2 = area[2]
	local y1 = area[3]
	local y2 = area[4]
	--print(tostring(x1)..","..tostring(y1).." : " .. tostring(x2)..","..tostring(y2))
	if(x1 ~= nil) then
		local xrand = ZombRand(x1,x2)
		local yrand = ZombRand(y1,y2)

		local result = getCell():getGridSquare(xrand,yrand,area[5])

		return result
	end
end

--- END AREAS ----

--- OBJECTS ---

--- Searches and return all objects of a type inside of a building
---@param building any current building
---@param objectName string object name to be searched
---@return table returns a list with every object found inside the building
function getAllObjectsFromBuilding(building,objectName)
	local bdef = building:getDef()

	local bdefX = bdef:getX()
	local bdefY = bdef:getY()
	local bdefZ = bdef:getZ()

	local bdWidth = bdefX + bdef:getW() + 1
	local bdHeight = bdefY + bdef:getH() + 1

	local objects = {}
	local objectCount = 0

	debugContext(" ----- getAllObjectsFromBuilding ----- ")

	for 	x=bdefX-1, bdWidth  do
		for y=bdefY-1, bdHeight do
			local sq = getCell():getGridSquare(x,y,bdefZ)
			if(sq) then
				local Objs = sq:getObjects();
				for j=0, Objs:size()-1 do
					local object = Objs:get(j)
					if(instanceof(object,objectName)) then
						objects[objectCount] = object
						objectCount = objectCount + 1
						debugContext("found object x : " 	.. tostring(x) .. " y :" .. tostring(y))
						debugContext("object count : " 		.. tostring(objectCount))
					end
				end
			end
		end
	end
	debugContext(" ----- getAllObjectsFromBuilding ----- ")

	return objects
end

--- END OBJECTS ---

--- WINDOWS ----

--- gets a window square 
---@param cs any a square
---@return any the window object if found or nil
function getSquaresWindow(cs)

	if not cs then 
		return nil 
	end

	local objs = cs:getObjects()
	for i=1, objs:size() do
		local obj = objs:get(i)
		if (instanceof(obj,"IsoWindow")) then 
			return obj
		end
	end


	return nil
end

--- gets the nearest adjacent window square of 'cs'
---@param cs any a square
---@return any the adjacent square next to window if found or nil
function getSquaresNearWindow(cs)

	local directions = { "N", "E" , "S", "W" }

	for k, dir in ipairs(directions) do
		local square = GetAdjSquare(cs,dir)
		local res = getSquaresWindow(square)

		if cs and square and res then 
			return res
		end

	end

	return nil

end

--- get the closets window of a building, based on character's position
---@param building any building to be searched
---@param character any
---@return any return the closest window or nil if not found
function getCloseWindow(building,character)

	local WindowOut = nil
	local closestSoFar = 100
	local bdef = building:getDef()

	local bdefX = bdef:getX()
	local bdefY = bdef:getY()

	local bdWidth = bdefX + bdef:getW() + 1
	local bdHeight = bdefY + bdef:getH() + 1

	for x=	bdefX-1, bdWidth do
		for y=bdefY-1, bdHeight do

			local sq = getCell():getGridSquare(x,y,character:getZ())
			if(sq) then
				local Objs = sq:getObjects();-- TODO : use getSquaresWindow
				for j=0, Objs:size()-1 do
					local Object = Objs:get(j) 
					local distance = getDistanceBetween(Object,character)
					if(instanceof(Object,"IsoWindow"))
						and (not windowHasBarricade(Object,character))
						and (not Object:isLocked())
						and (not Object:isPermaLocked())
						and distance < closestSoFar then

							closestSoFar = distance
							WindowOut = Object

					end
				end
			end

		end
	end

	return WindowOut
end

--- checks if the window is barricated from both sides
---@param window any
---@param character any
function windowHasBarricade(window,character)

	local thisSide = window:getBarricadeForCharacter(character)
	local oppositeSide = window:getBarricadeOppositeCharacter(character)
	
	if(thisSide == nil) and (oppositeSide == nil) then 
		return false
	else 
		return true 
	end
	
end
--- END WINDOWS ----

--- DOORS ----

--- gets the inside square of a door
---@param door any 
---@param player any 
---@return any returns the inside square of a door or nil if not found
function getDoorsInsideSquare(door,player)

	if(player == nil) or not (instanceof(door,"IsoDoor")) then 
		return nil 
	end

	local sq1 = door:getOppositeSquare()
	local sq2 = door:getSquare()
	local sq3 = door:getOtherSideOfDoor(player)

	if(not sq1:isOutside()) then 
		return sq1
	elseif(not sq2:isOutside()) then 
		return sq2
	elseif(not sq3:isOutside()) then 
		return sq3
	else 
		return nil 
	end

end

--- gets the outside square of a door 
---@param door any 
---@param player any 
---@return any returns the inside outside of a door or nil if not found
function getDoorsOutsideSquare(door,player)

	if(player == nil) or not (instanceof(door,"IsoDoor")) then 
		return nil 
	end

	local sq1 = door:getOppositeSquare()
	local sq2 = door:getSquare()
	local sq3 = door:getOtherSideOfDoor(player)

	if(sq1 and sq1:isOutside()) then 
		return sq1
	elseif(sq2 and sq2:isOutside()) then 
		return sq2
	elseif(sq3 and sq3:isOutside()) then 
		return sq3
	else 
		return nil 
	end

end

--- gets the closest unlocked door
---@param building any
---@param character any
---@return any returns the closest exterior unlocked door or nil if not found
function getUnlockedDoor(building,character)

	local DoorOut = nil
	local closestSoFar = 100
	local bdef = building:getDef()

	for x=bdef:getX()-1,(bdef:getX() + bdef:getW() + 1) do
		for y=bdef:getY()-1,(bdef:getY() + bdef:getH() + 1) do

			local sq = getCell():getGridSquare(x,y,character:getZ())
			if(sq) then
				local Objs = sq:getObjects();
				for j=0, Objs:size()-1 do
					local Object = Objs:get(j)
					if(Object ~= nil) then
						local distance = getDistanceBetween(sq,character)
						if(instanceof(Object,"IsoDoor")) and (Object:isExteriorDoor(character)) and (distance < closestSoFar) then
							if(not Object:isLocked()) then
								closestSoFar = distance
								DoorOut = Object
							end
						end
					end
				end
			end

		end

	end
	return DoorOut
end

--- gets the closest door inside of a 'building' based on a 'character' position
---@param building any
---@param character any 
---@return any returns the closest exterior door or nil if not found 
function getDoor(building,character)
	
	local DoorOut = nil
	local closestSoFar = 100
	local bdef = building:getDef()

	for x=bdef:getX()-1,(bdef:getX() + bdef:getW() + 1) do
		for y=bdef:getY()-1,(bdef:getY() + bdef:getH() + 1) do

			local sq = getCell():getGridSquare(x,y,character:getZ())
			if(sq) then
				local Objs = sq:getObjects();
				for j=0, Objs:size()-1 do
					local Object = Objs:get(j)
					if(Object ~= nil) then
						local distance = getDistanceBetween(sq,character)
						if(instanceof(Object,"IsoDoor")) and (Object:isExteriorDoor(character)) and (distance < closestSoFar) then

							closestSoFar = distance
							DoorOut = Object

						end
					end
				end
			end
		end
	end

	return DoorOut
end

--- END DOORS ----

--- BUILDINGS ---

--- gets the amount of zombies inside and around a building
---@param building any
---@return integer returns the amount of zombies found in the building
function NumberOfZombiesInOrAroundBuilding(building)
	local count = 0
	local padding = 10
	local bdef = building:getDef()

	local bdefX = bdef:getX() 
	local bdefY = bdef:getY() 

	local bdWidth = bdefX + bdef:getW() + padding
	local bdHeight = bdefY + bdef:getH() + padding

	for x=	(bdefX - padding),bdWidth do
		for y=(bdefY - padding),bdHeight do

			local sq = getCell():getGridSquare(x,y,0)
			if(sq) then
				local Objs = sq:getMovingObjects();
				for j=0, Objs:size()-1 do
					local Object = Objs:get(j)
					if(Object ~= nil) and (instanceof(Object,"IsoZombie")) then
						count = count + 1
					end
				end
			end

		end

	end

	return count
end

--- gets a random square inside of a building
---@param building any
---@return any returns a random square inside of the building
function getRandomBuildingSquare(building)

	local bdef = building:getDef()
	local x = ZombRand(bdef:getX(), (bdef:getX() + bdef:getW()))
	local y = ZombRand(bdef:getY(), (bdef:getY() + bdef:getH()))

	local sq = getCell():getGridSquare(x,y,0)
	if(sq) then
		return sq
	end

	return nil
end

--- gets a random and free square inside of a building (it tries 100 of times until it finds so be careful using it)
---@param building any
---@return any returns a random square inside of the building
function getRandomFreeBuildingSquare(building)

	if(building == nil) then 
		return nil 
	end

	local bdef = building:getDef()

	for i=0,100 do

		local x = ZombRand(bdef:getX(), (bdef:getX() + bdef:getW()))
		local y = ZombRand(bdef:getY(), (bdef:getY() + bdef:getH()))

		local sq = getCell():getGridSquare(x,y,0)
		if(sq) and sq:isFree(false) and (sq:getRoom() ~= nil) and (sq:getRoom():getBuilding() == building) then
			return sq
		end
	end

	return nil
end
--- END BUILDINGS ---