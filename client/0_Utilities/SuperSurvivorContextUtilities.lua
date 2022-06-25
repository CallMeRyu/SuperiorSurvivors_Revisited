-- this file only has methods related to world context

-- gets the coordinate from a npc survivor
function getCoordsFromID(id)

	for k,v in pairs(SurvivorMap) do

		for i=1,#v do
			--print(tostring(k)..","..tostring(v[i]))
			if(v[i] == id) then 
        return k 
      end
		end

	end

	return 0

end

-- gets the distance between 2 instances (zombies, npcs or players)
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

-- gets the distance between 2 coordinates
function getDistanceBetweenPoints(Ax,Ay,Bx,By)
	if(Ax == nil) or (Bx == nil) then 
		return -1 
	end

	local dx = Ax - Bx
	local dy = Ay - By

	return math.sqrt ( dx * dx + dy * dy )

end

--- checks if the square is inside of the area 'area'
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

-- gets the center square of an area
function getCenterSquareFromArea(x1,x2,y1,y2,z)

	local xdiff = x2 - x1
	local ydiff = y2 - y1

	local result = getCell():getGridSquare(x1+math.floor(xdiff/2),y1+math.floor(ydiff/2),z)

	return result

end

-- gets the center square inside of an area
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

-- gets a random square awyas from the 'attackGuy' inside a distance of 7
function getFleeSquare(fleeGuy,attackGuy)
	local distance = 7
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

function getTowardsSquare(moveguy,x,y,z)
	local distance = 15
	local tempx = (moveguy:getX() - x);
	local tempy = (moveguy:getY() - y);

	if (tempx > 0) and (tempx >= distance) then 
    tempx = -distance;
	elseif (tempx < -distance) then 
    tempx = distance
	else tempx = -tempx end
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

-- gets a window square 
function getSquaresWindow(cs)

	if not cs then 
		return nil 
	end

	local objs = cs:getObjects()
	for i=1, objs:size() do
		if (instanceof(objs:get(i),"IsoWindow")) then 
			return objs:get(i) 
		end
	end


	return nil
end

-- gets the nearest adjacent window square of 'cs'
function getSquaresNearWindow(cs)

	local osquare = GetAdjSquare(cs,"N")
	if cs and osquare and getSquaresWindow(osquare) then 
		return getSquaresWindow(osquare) 
	end

	osquare = GetAdjSquare(cs,"E")
	if cs and osquare and getSquaresWindow(osquare) then 
		return getSquaresWindow(osquare) 
	end

	osquare = GetAdjSquare(cs,"S")
	if cs and osquare and getSquaresWindow(osquare) then 
		return getSquaresWindow(osquare) 
	end

	osquare = GetAdjSquare(cs,"W")
	if cs and osquare and getSquaresWindow(osquare) then 
		return getSquaresWindow(osquare) 
	end

	return nil

end

-- gets the inside square of a door
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

-- gets the outside square of a door 
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