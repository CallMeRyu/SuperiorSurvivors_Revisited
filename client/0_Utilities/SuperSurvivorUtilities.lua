Orders = {
"Barricade",
"Chop Wood",
"Clean Up Inventory",
"Doctor",
"Explore",
"Follow",
"Farming",
"Forage",
"Gather Wood",
"Go Find Food",
"Go Find Water",
"Go Find Weapon",
"Guard",
"Hold Still",
"Lock Doors",
"Unlock Doors",
"Loot Room",
"Patrol",
"Stand Ground",
"Stop",
"Dismiss",
"Relax",
"Return To Base",
"Pile Corpses",

};

function getPresetColor(Color)

	if Color == "White" then return ImmutableColor.new(0.75,0.74,0.72)
	elseif Color == "Grey" then return mmutableColor.new(0.48,0.47,0.44)
	elseif Color == "Blond" then return ImmutableColor.new(0.82,0.82,0.39)
	elseif Color == "Sand" then return ImmutableColor.new(0.86,0.78,0.66)
	elseif Color == "Hazel" then return ImmutableColor.new(0.61,0.50,0.34)
	elseif Color == "Brown" then return ImmutableColor.new(0.62,0.42,0.17)
	elseif Color == "Red" then return ImmutableColor.new(0.58,0.25,0.25)
	elseif Color == "Pink" then return ImmutableColor.new(0.59,0.39,0.55)
	elseif Color == "Purple" then return ImmutableColor.new(0.47,0.43,0.59)
	elseif Color == "Blue" then return ImmutableColor.new(0.39,0.47,0.59)
	elseif Color == "Black" then return ImmutableColor.new(0.10,0.08,0.09)
	else return ImmutableColor.new(0.99,0.99,0.99)
	end

end

function getCoordsFromID(id)

	for k,v in pairs(SurvivorMap) do

		for i=1,#v do
			--print(tostring(k)..","..tostring(v[i]))
			if(v[i] == id) then return k end
		end

	end

	return 0

end

function getSpeech(key)
	if(not SurvivorSpeechTable[key]) then return "?" end
	local result = ZombRand(1,#SurvivorSpeechTable[key]);
	return tostring(SurvivorSpeechTable[key][result]);
 end

 function getAmmoBox(bullets)
	if(isModEnabled("ORGM")) then return bullets.."_Box" end

	if (bullets == "BB177") then return "BB177Box"
	elseif (bullets == "Bullets22") then return "Bullets22Box"
	elseif (bullets == "Bullets57") then return "Bullets57Box"
	elseif (bullets == "Bullets380") then return "Bullets380Box"
	elseif (bullets == "Bullets9mm") then return "Bullets9mmBox"
	elseif (bullets == "Bullets38") then return "Bullets38Box"
	elseif (bullets == "Bullets357") then return "Bullets357Box"
	elseif (bullets == "Bullets45") then return "Bullets45Box"
	elseif (bullets == "Bullets45LC") then return "Bullets45LCBox"
	elseif (bullets == "Bullets44") then return "Bullets44Box"
	elseif (bullets == "Bullets4570") then return "Bullets4570Box"

	elseif (bullets == "410gShotgunShells")then return "410gShotgunShellsBox"
	elseif (bullets == "20gShotgunShells") then return "20gShotgunShellsBox"
	elseif (bullets == "ShotgunShells") then return "ShotgunShellsBox"
	elseif (bullets == "10gShotgunShells") then return "10gShotgunShellsBox"
	elseif (bullets == "4gShotgunShells") then return "4gShotgunShellsBox"

	elseif (bullets == "223Bullets") then return "223Box"
	elseif (bullets == "556Bullets") then return "556Box"
	elseif (bullets == "762x39Bullets") then return "762x39Box"
	elseif (bullets == "308Bullets") then return "308Box"
	elseif (bullets == "762x51Bullets") then return "762x51Box"
	elseif (bullets == "762x54rBullets") then return "762x54rBox"
	elseif (bullets == "3006Bullets") then return "3006Box"
	elseif (bullets == "50BMGBullets") then return "50BMGBox"

	elseif (bullets == "Nails") then return "NailsBox" -- For Nailgun Mod
	end

	print("no ammo box found for bullets "..tostring(bullets))
	return ""
end

function getBoxCount(box)
	if (box == "BB177Box") then return 500
	elseif (box == "Bullets22Box") then return 100
	elseif (box == "Bullets57Box") then return 50
	elseif (box == "Bullets380Box") then return 50
	elseif (box == "Bullets9mmBox") then return 50
	elseif (box == "Bullets38Box") then return 50
	elseif (box == "Bullets357Box") then return 50
	elseif (box == "Bullets45Box") then return 50
	elseif (box == "Bullets45LCBox") then return 50
	elseif (box == "Bullets44Box") then return 50
	elseif (box == "Bullets4570Box") then return 20

	elseif (box == "410gShotgunShellsBox") then return 25
	elseif (box == "20gShotgunShellsBox") then return 25
	elseif (box == "ShotgunShellsBox") then return 25
	elseif (box == "10gShotgunShellsBox") then return 25
	elseif (box == "4gShotgunShellsBox") then return 10

	elseif (box == "223Box") then return 20
	elseif (box == "556Box") then return 20
	elseif (box == "762x39Box") then return 20
	elseif (box == "308Box") then return 20
	elseif (box == "762x51Box") then return 20
	elseif (box == "762x54rBox") then return 20
	elseif (box == "3006Box") then return 20
	elseif (box == "50BMGBox") then return 10
	elseif (box == "NailsBox") then return 100 -- For Nailgun Mod

	elseif (isModEnabled("ORGM")) then return 50

	else return 0
	end
end



SuperSurvivorsAmmoBoxes = {   -- for the loot stores that are spawned with preset spawns.
"Base.223Box",
"Base.308Box",
"Base.Bullets9mm",
"Base.Bullets9mm",
"Base.Bullets9mm",
"Base.ShotgunShellsBox",
"Base.ShotgunShellsBox",
"Base.ShotgunShellsBox",
}





SurvivorPerks = {
"Aiming",
"Axe",
"Combat",
"SmallBlade",
"LongBlade",
"SmallBlunt",
"Blunt",
"Maintenance",
"Spear",
"Doctor",
"Farming",
"Firearm",
"Reloading",
"Fitness",
"Lightfoot",
--"Melee",
"Nimble",
"PlantScavenging",
"Reloading",
"Sneak",
"Strength",
"Survivalist"}



function getAPerk()
    local result = ZombRand(size(SurvivorPerks)-1)+1;
    return SurvivorPerks[result];
end


function has_value (tab, val)
	if(tab ~= nil) and (val ~= nil) then
		--for index, value in ipairs (tab) do
		for k=1, #tab do
			local value = tab[k]
			if value == val then
				return true
			end
		end
	end
    return false
end

function getDistanceBetween(z1,z2)
	if(z1 == nil) or (z2 == nil) then return -1 end

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

function getDistanceBetweenPoints(Ax,Ay,Bx,By)
	if(Ax == nil) or (Bx == nil) then return -1 end


	local dx = Ax - Bx
	local dy = Ay - By

	return math.sqrt ( dx * dx + dy * dy )

end

function isSquareInArea(sq,area)

	local x1 = area[1]
	local x2 = area[2]
	local y1 = area[3]
	local y2 = area[4]

	if(sq:getX() > x1) and (sq:getX() <= x2) and (sq:getY() > y1) and (sq:getY() <= y2) and (sq:getZ() == area[5]) then return true
	else return false end

end

function getCenterSquareFromArea(x1,x2,y1,y2,z)

	local xdiff = x2 - x1
	local ydiff = y2 - y1

	local result = getCell():getGridSquare(x1+math.floor(xdiff/2),y1+math.floor(ydiff/2),z)

	return result

end

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

function getFleeSquare(fleeGuy,attackGuy)
	local distance = 7
	local tempx = (fleeGuy:getX() - attackGuy:getX());
	local tempy = (fleeGuy:getY() - attackGuy:getY());
	if (tempx < 0) then tempx = -distance;
	else tempx = distance; end
	if (tempy < 0) then tempy = -distance;
	else tempy = distance; end
	return fleeGuy:getCell():getGridSquare(fleeGuy:getX()+tempx+ZombRand(-5,5),fleeGuy:getY()+tempy+ZombRand(-5,5),fleeGuy:getZ());
end

function getTowardsSquare(moveguy,x,y,z)
	local distance = 15
	local tempx = (moveguy:getX() - x);
	local tempy = (moveguy:getY() - y);
	if (tempx > 0) and (tempx >= distance) then tempx = -distance;
	elseif (tempx < -distance) then tempx = distance;
	else tempx = -tempx end
	if (tempy > 0) and (tempy >= distance) then tempy = -distance;
	elseif (tempy < -distance) then tempy = distance;
	else tempy = -tempy end
	return moveguy:getCell():getGridSquare(moveguy:getX()+tempx+ZombRand(-2,2),moveguy:getY()+tempy+ZombRand(-2,2),moveguy:getZ());
end

function SurvivorTogglePVP()

	if(IsoPlayer.getCoopPVP() == true) then
		getSpecificPlayer(0):Say("PVP Disabled");
		IsoPlayer.setCoopPVP(false);
		getSpecificPlayer(0):getModData().PVP = false;
		PVPDefault = false;
		PVPButton:setImage(PVPTextureOff)
	elseif(IsoPlayer.getCoopPVP() == false) then

		IsoPlayer.setCoopPVP(true);
		if(ForcePVPOn ~= true) then
			getSpecificPlayer(0):getModData().PVP = true;
			PVPDefault = true;
			getSpecificPlayer(0):Say("PVP Enabled");
		else
			getSpecificPlayer(0):Say("PVP Forced On");
		end
		ForcePVPOn = false;
		PVPButton:setImage(PVPTextureOn)
	end
end

function getAmmoType(weapon,incModule)

	if(weapon == nil) or (weapon.getAmmoType == nil) then return nil end
	local out = '';
	local modulename ='Base';
	local wepType = weapon:getType();

	out = weapon:getAmmoType()

	if(out == nil) then
		local s = weapon:getMagazineType();
		i, j = string.find(s, "Clip")
		out = s:sub( i )
	end

	if(out == nil) then
		print("no bullets found for weapon: " .. wepType)
		return nil
	end

	out = out:sub( 6 )
	--[[
	print("weapong type: "..wepType);
	local wepdata = ReloadUtil:getWeaponData(wepType);
	if(not wepdata or not wepdata.ammoType) then
		--if(wepdata) then print("no weapon data for:"..tostring(weapon:getType()) .. "["..tostring(wepdata.ammoType).."]");
		--else print("no weapon data for:"..tostring(weapon:getType())); end
		return nil
	end
	local clipdata = ReloadUtil:getClipData(wepdata.ammoType);

	if(clipdata) then
		if(clipdata.ammoType) then
			--print("ifif"..tostring(clipdata.ammoType));
			out = tostring(clipdata.ammoType);
			modulename = clipdata.moduleName;
		else
			--print("if-else"..tostring(wepdata.ammoType));
			out = tostring(wepdata.ammoType);
			modulename = wepdata.moduleName;
		end
	elseif(wepdata.ammoType) then
		--print("else"..tostring(wepdata.ammoType));
		out = tostring(wepdata.ammoType);
		modulename = wepdata.moduleName;
	else
		--print("else?");
	end
	--]]


	--if(incModule) then out = modulename .. "." .. out; end
	return out;

end

function getAmmoBullets(weapon,incModule)

	if(weapon == nil) then return nil end

	if (instanceof(weapon,"HandWeapon")) and (weapon:isAimedFirearm()) then
		local bullets = {}

		if(isModEnabled("ORGM")) then
		  local ammoTbl = ORGM.AlternateAmmoTable[getAmmoType(weapon,false)]
		  if (ammoTbl) then
		   --for _, name in ipairs(ammoTbl) do
		   for k=1, #ammoTbl do
			local name = ammoTbl[k]
			if(incModule) then table.insert(bullets,"ORGM."..name)
			else table.insert(bullets,name) end
		   end
		  end

		  return bullets
		end



		if(incModule) then
			table.insert(bullets,getAmmoType(weapon,incModule))
		else
			table.insert(bullets,getAmmoType(weapon,incModule))
		end

		return bullets;
	end

	return nil
end

function getSquaresWindow(cs)

	if not cs then return nil end

	local objs = cs:getObjects()
	for i=1, objs:size() do
		if (instanceof(objs:get(i),"IsoWindow")) then return objs:get(i) end
	end


	return nil
end

function getSquaresNearWindow(cs)

	local osquare = GetAdjSquare(cs,"N")
	if cs and osquare and getSquaresWindow(osquare) then return getSquaresWindow(osquare) end

	osquare = GetAdjSquare(cs,"E")
	if cs and osquare and getSquaresWindow(osquare) then return getSquaresWindow(osquare) end

	osquare = GetAdjSquare(cs,"S")
	if cs and osquare and getSquaresWindow(osquare) then return getSquaresWindow(osquare) end

	osquare = GetAdjSquare(cs,"W")
	if cs and osquare and getSquaresWindow(osquare) then return getSquaresWindow(osquare) end

	return nil

end


function getDoorsInsideSquare(door,player)

	if(player == nil) or not (instanceof(door,"IsoDoor")) then return nil end
	local sq1 = door:getOppositeSquare()
	local sq2 = door:getSquare()
	local sq3 = door:getOtherSideOfDoor(player)

	if(not sq1:isOutside()) then return sq1
	elseif(not sq2:isOutside()) then return sq2
	elseif(not sq3:isOutside()) then return sq3
	else return nil end

end
function getDoorsOutsideSquare(door,player)

	if(player == nil) or not (instanceof(door,"IsoDoor")) then return nil end
	local sq1 = door:getOppositeSquare()
	local sq2 = door:getSquare()
	local sq3 = door:getOtherSideOfDoor(player)

	if(sq1 and sq1:isOutside()) then return sq1
	elseif(sq2 and sq2:isOutside()) then return sq2
	elseif(sq3 and sq3:isOutside()) then return sq3
	else return nil end

end

function makeToolTip(option,name,desc)
	local toolTip = ISToolTip:new();
        toolTip:initialise();
        toolTip:setVisible(false);
        -- add it to our current option
        option.toolTip = toolTip;
        toolTip:setName(name);
        toolTip.description = desc .. " <LINE> ";
        --toolTip:setTexture("crafted_01_16");

		--toolTip.description = toolTip.description .. " <LINE> <RGB:1,0,0> More Desc" ;
		--option.notAvailable = true;
       return toolTip;
end

function getMouseSquare()
	local sw = (128 / getCore():getZoom(0));
	local sh = (64 / getCore():getZoom(0));

	local mapx = getSpecificPlayer(0):getX();
	local mapy = getSpecificPlayer(0):getY();
	local mousex = ( (getMouseX() - (getCore():getScreenWidth() / 2)) ) ;
	local mousey = ( (getMouseY() - (getCore():getScreenHeight() / 2)) ) ;

	local sx = mapx + (mousex / (sw/2) + mousey / (sh/2)) /2;
	local sy = mapy + (mousey / (sh/2) -(mousex / (sw/2))) /2;

	local sq = getCell():getGridSquare(sx,sy,getSpecificPlayer(0):getZ());
	return sq;
end

function getMouseSquareY()
	local sw = (128 / getCore():getZoom(0));
	local sh = (64 / getCore():getZoom(0));

	local mapx = getSpecificPlayer(0):getX();
	local mapy = getSpecificPlayer(0):getY();
	local mousex = ( (getMouseX() - (getCore():getScreenWidth() / 2)) ) ;
	local mousey = ( (getMouseY() - (getCore():getScreenHeight() / 2)) ) ;

	local sy = mapy + (mousey / (sh/2) -(mousex / (sw/2))) /2;

	return sy
end

function getMouseSquareX()
	local sw = (128 / getCore():getZoom(0));
	local sh = (64 / getCore():getZoom(0));

	local mapx = getSpecificPlayer(0):getX();
	local mapy = getSpecificPlayer(0):getY();
	local mousex = ( (getMouseX() - (getCore():getScreenWidth() / 2)) ) ;
	local mousey = ( (getMouseY() - (getCore():getScreenHeight() / 2)) ) ;

	local sx = mapx + (mousex / (sw/2) + mousey / (sh/2)) /2;

	return sx
end

function windowHasBarricade(window,character)

local thisSide = window:getBarricadeForCharacter(character)
local oppositeSide = window:getBarricadeOppositeCharacter(character)

if(thisSide == nil) and (oppositeSide == nil) then return false
else return true end

end


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

function NumberOfZombiesInOrAroundBuilding(building)

	local count = 0
	local padding = 10
	local bdef = building:getDef()
	for x=(bdef:getX() - padding),(bdef:getX() + bdef:getW() + padding) do
		for y=(bdef:getY() - padding),(bdef:getY() + bdef:getH() + padding) do

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


function getOutsideSquare(square,building)


	if(not building) or (not square) then return nil end

	local windowsquare = getCell():getGridSquare(square:getX(),square:getY(),square:getZ());
	if windowsquare~= nil and windowsquare:isOutside() then return windowsquare end

	local N = GetAdjSquare(square,"N")
	local E = GetAdjSquare(square,"E")
	local S = GetAdjSquare(square,"S")
	local W = GetAdjSquare(square,"W")

	if N and N:isOutside() then return N
	elseif E and E:isOutside() then return E
	elseif S and S:isOutside() then return S
	elseif W and W:isOutside() then return W
	else return square
	end



end

function getCloseWindow(building,character)

	local WindowOut = nil
	local closestSoFar = 100
	local bdef = building:getDef()
	for x=bdef:getX()-1,(bdef:getX() + bdef:getW() + 1) do
		for y=bdef:getY()-1,(bdef:getY() + bdef:getH() + 1) do

			local sq = getCell():getGridSquare(x,y,character:getZ())
			if(sq) then
				local Objs = sq:getObjects();
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

function getRandomFreeBuildingSquare(building)

	if(building == nil) then return nil end
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




function AbsoluteValue(value)
	if(value >= 0) then return value;
	else return (value * -1);
	end
end

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

function getSideSquare(square,supersurvivor)

		local player = supersurvivor.player
		local nsquare,nnsquare;
		nsquare = GetAdjSquare(square,'N');
		if(nsquare ~= nil) then
			if ((supersurvivor:getWalkToAttempt(nsquare) == 0 and (nsquare:isFree(false)) and (nsquare:isBlockedTo(player:getCurrentSquare()) == false)) or (supersurvivor:getWalkToAttempt(nsquare) ~= 0)) and (nsquare:isOutside() == false) then return nsquare end

			nnsquare = GetAdjSquare(nsquare,'E');
			if (nnsquare ~= nil) and ((supersurvivor:getWalkToAttempt(nnsquare) == 0 and (nnsquare:isFree(false)) and (nnsquare:isBlockedTo(player:getCurrentSquare()) == false)) or (supersurvivor:getWalkToAttempt(nnsquare) ~= 0)) and (nnsquare:isOutside() == false) then return nnsquare end

			nnsquare = GetAdjSquare(nsquare,'W');
			if (nnsquare ~= nil) and ((supersurvivor:getWalkToAttempt(nnsquare) == 0 and (nnsquare:isFree(false)) and (nnsquare:isBlockedTo(player:getCurrentSquare()) == false)) or (supersurvivor:getWalkToAttempt(nnsquare) ~= 0)) and (nnsquare:isOutside() == false) then return nnsquare end

			nnsquare = GetAdjSquare(nsquare,'N');
			if (nnsquare ~= nil) and ((supersurvivor:getWalkToAttempt(nnsquare) == 0 and (nnsquare:isFree(false)) and (nnsquare:isBlockedTo(player:getCurrentSquare()) == false)) or (supersurvivor:getWalkToAttempt(nnsquare) ~= 0)) and (nnsquare:isOutside() == false) then return nnsquare end

		end
		nsquare = GetAdjSquare(square,'E');
		if(nsquare) then
			if ((supersurvivor:getWalkToAttempt(nsquare) == 0 and (nsquare:isFree(false)) and (nsquare:isBlockedTo(player:getCurrentSquare()) == false)) or (supersurvivor:getWalkToAttempt(nsquare) ~= 0)) and (nsquare:isOutside() == false) then return nsquare end

			nnsquare = GetAdjSquare(nsquare,'E');
			if (nnsquare ~= nil) and ((supersurvivor:getWalkToAttempt(nnsquare) == 0 and (nnsquare:isFree(false)) and (nnsquare:isBlockedTo(player:getCurrentSquare()) == false)) or (supersurvivor:getWalkToAttempt(nnsquare) ~= 0)) and (nnsquare:isOutside() == false) then return nnsquare end

		end
		nsquare = GetAdjSquare(square,'S');
		if(nsquare) then
			if ((supersurvivor:getWalkToAttempt(nsquare) == 0 and (nsquare:isFree(false)) and (nsquare:isBlockedTo(player:getCurrentSquare()) == false)) or (supersurvivor:getWalkToAttempt(nsquare) ~= 0)) and (nsquare:isOutside() == false) then return nsquare end

			nnsquare = GetAdjSquare(nsquare,'E');
			if (nnsquare ~= nil) and ((supersurvivor:getWalkToAttempt(nnsquare) == 0 and (nnsquare:isFree(false)) and (nnsquare:isBlockedTo(player:getCurrentSquare()) == false)) or (supersurvivor:getWalkToAttempt(nnsquare) ~= 0)) and (nnsquare:isOutside() == false) then return nnsquare end

			nnsquare = GetAdjSquare(nsquare,'W');
			if (nnsquare ~= nil) and ((supersurvivor:getWalkToAttempt(nnsquare) == 0 and (nnsquare:isFree(false)) and (nnsquare:isBlockedTo(player:getCurrentSquare()) == false)) or (supersurvivor:getWalkToAttempt(nnsquare) ~= 0)) and (nnsquare:isOutside() == false) then return nnsquare end

			nnsquare = GetAdjSquare(nsquare,'S');
			if (nnsquare ~= nil) and ((supersurvivor:getWalkToAttempt(nnsquare) == 0 and (nnsquare:isFree(false)) and (nnsquare:isBlockedTo(player:getCurrentSquare()) == false)) or (supersurvivor:getWalkToAttempt(nnsquare) ~= 0)) and (nnsquare:isOutside() == false) then return nnsquare end


		end
		nsquare = GetAdjSquare(square,'W');
		if(nsquare) then
			if ((supersurvivor:getWalkToAttempt(nsquare) == 0 and (nsquare:isFree(false)) and (nsquare:isBlockedTo(player:getCurrentSquare()) == false)) or (supersurvivor:getWalkToAttempt(nsquare) ~= 0)) and (nsquare:isOutside() == false) then return nsquare end

			nnsquare = GetAdjSquare(nsquare,'W');
			if (nnsquare ~= nil) and ((supersurvivor:getWalkToAttempt(nnsquare) == 0 and (nnsquare:isFree(false)) and (nnsquare:isBlockedTo(player:getCurrentSquare()) == false)) or (supersurvivor:getWalkToAttempt(nnsquare) ~= 0)) and (nnsquare:isOutside() == false) then return nnsquare end

		end


	return square;
end

function doesFileExist( fileName )
	local fileTable = {}
	local readFile = getModFileReader("SuperiorSubparSurvivors",getWorld():getWorld()..getFileSeparator()..fileName, false)

	if(readFile) then return true
	else return false end
end

function table.load( fileName )
	local fileTable = {}
	local readFile = getModFileReader("SuperiorSubparSurvivors",getWorld():getWorld()..getFileSeparator()..fileName..".lua", true)
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

function table.save(  tbl,fileName )

	local destFile = getWorld():getWorld()..getFileSeparator()..fileName..".lua"
	--print("table.saving:".. destFile)
	local writeFile = getModFileWriter("SuperiorSubparSurvivors", destFile, true, false)
	for i = 1,#tbl do
		writeFile:write(tbl[i].."\r\n");
		--print(tbl[i])
	end
	writeFile:close();
end





function kvtableload( fileName )

	local fileTable = {}
	local readFile = getModFileReader("SuperiorSubparSurvivors",getWorld():getWorld()..getFileSeparator()..fileName , true)

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
	local writeFile = getModFileWriter("SuperiorSubparSurvivors", destFile, true, false)
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

function MyFindAndReturnCategory(thisItemContainer, thisCategory, survivor)

	if(thisCategory == "Food") then return FindAndReturnBestFood(thisItemContainer, survivor)
	elseif(thisCategory == "Water") then return FindAndReturnWater(thisItemContainer)
	elseif(thisCategory == "Weapon") then return FindAndReturnWeapon(thisItemContainer)
	else return thisItemContainer:FindAndReturnCategory(thisCategory) end

end

function FindAndReturnWeapon(thisItemContainer) -- exlude crap weapons
	if(not thisItemContainer) then return nil end
	local items = thisItemContainer:getItems()

	if(items ~= nil) and (items:size() > 0) then
		for i=1, items:size()-1 do
			local item = items:get(i)
			if(item ~= nil) and (item:getCategory() == "Weapon") and (item:getMaxDamage() > 0.1) then
				--print("FindAndReturnWeapon " .. item:getDisplayName() .. " - " .. tostring(item:getMaxDamage()))
				return item
			end
		end
	end
	return nil
end

function FindAndReturnBestWeapon(thisItemContainer) -- exlude crap weapons
	if(not thisItemContainer) then return nil end
	local items = thisItemContainer:getItems()
	local bestItem = nil

	if(items ~= nil) and (items:size() > 0) then
		for i=1, items:size()-1 do
			local item = items:get(i)
			if(item ~= nil) and (item:getCategory() == "Weapon") and (item:getMaxDamage() > 0.1) and (bestItem == nil or bestItem:getMaxDamage() < item:getMaxDamage()) then bestItem = item end
		end
	end
	if (bestItem ~= nil) then
		--print("FindAndReturnBestWeapon " .. tostring(bestItem:getDisplayName()) .. " - " .. tostring(bestItem:getMaxDamage()))
	end
	return bestItem
end

FoodsToExlude = {"Bleach", "Cigarettes", "HCCigar", "Antibiotics", "Teabag2", "Salt", "Pepper", "EggCarton"}
function FindAndReturnFood(thisItemContainer)
	if(not thisItemContainer) then return nil end
	local items = thisItemContainer:getItems()

	if(items ~= nil) and (items:size() > 0) then
		for i=1, items:size()-1 do
			local item = items:get(i)
			if(item ~= nil) and (item:getCategory() == "Food") and not (item:getPoisonPower() > 1) and (not has_value(FoodsToExlude,item:getType())) then return item end
		end
	end
	return nil
end

function GetFoodScore(item)
	--print("Analyze " .. item:getDisplayName())
	local Score = 1.0

	if(item:getUnhappyChange() > 0) then
		Score = Score - math.floor(item:getUnhappyChange() / (item:getHungerChange() * -10.0))
		--print("-unhappy "..Score..","..tostring(item:getUnhappyChange())..","..tostring(0 - item:getHungerChange()))
	elseif(item:getUnhappyChange() < 0) then
		Score = Score + 1
		--print("-happy")
	end

	if(item:getBoredomChange() > 0) then
		Score = Score - math.floor(item:getBoredomChange() / (item:getHungerChange() * -10.0) / 2.0)
		--print("-bored")
	elseif(item:getBoredomChange() < 0) then
		Score = Score + 1
		--print("-unbored")
	end

	if(item:isFresh()) then
		Score = Score + 2
		--print("-fresh")
	elseif(item:IsRotten()) then
		Score = Score - 10
		--print("-rotten")
	end

	if(item:isAlcoholic()) then
		Score = Score - 5
		--print("-alcoholic")
	end
	if(item:isSpice()) then
		Score = Score - 5
		--print("-spice")
	end

	if(item:isbDangerousUncooked()) and not (item:isCooked()) then
		Score = Score - 10
		--print("-dont eat it mary, its raw")
	end
	--if(item:isBurnt()) then Score = Score - 1 end

	local FoodType = item:getFoodType()
	if (FoodType == "NoExplicit") or (FoodType == nil) or (tostring(FoodType) == "nil") then
		--print("-notype")
		-- save the canned food
		if string.match(item:getDisplayName(), "Open") then Score = Score + 3
		elseif string.match(item:getDisplayName(), "Canned") then Score = Score - 5
		elseif (item:getDisplayName() == "Dog Food") then Score = Score - 10
		elseif (item:getHungerChange()) == nil or (item:getHungerChange() == 0) then Score = -9999 end -- unidentified, probably canned from a mod

		if(item:isCooked()) then Score = Score + 5 end
	elseif (FoodType == "Fruits") or (FoodType == "Vegetables") then
		--print("-produce")
		Score = Score + 1
	elseif (FoodType == "Pasta") or (FoodType == "Rice") then
		--print("-drygoods")
		Score = Score - 2
	elseif ((FoodType == "Egg") or (FoodType == "Meat")) or item:isIsCookable() then
		--print("-meat")
		if (item:isCooked()) then
			Score = Score + 2
		end
	elseif (FoodType == "Coffee") then
		--print("-coffee")
		Score = Score - 5
	else
		--print("Unknown food type " .. FoodType)
	end

	return Score
end

function FindAndReturnBestFoodOnFloor(sq, survivor)
	if(not sq) then return nil end
	local BestFood = nil
	local BestScore = 1

	if (survivor == nil) or (survivor:isStarving()) then
		-- if starving, willing to eat anything
		BestScore = -999
	elseif (survivor:isVHungry()) then
		-- not too picky, eat stale food
		BestScore = -10
	end

	items = sq:getWorldObjects()
	--print("Checking " .. tostring(items:size()) .. " world objects.")
	for j=0, items:size()-1 do
		if(items:get(j):getItem()) then
			local item = items:get(j):getItem()
			if(item ~= nil) and (item:getCategory() == "Food") and not (item:getPoisonPower() > 1) and (not has_value(FoodsToExlude, item:getType())) then
				local Score = GetFoodScore(item)

				--ContainerItemsScore[i] = Score
				--print("BestFood Floor " .. item:getDisplayName() .. ": " .. tostring(Score))
				if Score > BestScore then
					BestFood = item
					BestScore = Score
				end
			end
		end
	end
	return BestFood
end

function FindAndReturnBestFood(thisItemContainer, survivor)
	if(not thisItemContainer) then return nil end
	local items = thisItemContainer:getItems()
	local ID = -1
	local BestFood = nil
	--local ContainerItemsScore = {}
	local BestScore = 1

	if (survivor == nil) or (survivor:isStarving()) then
		-- if starving, willing to eat anything
		BestScore = -999
	elseif (survivor:isVHungry()) then
		-- not too picky, eat stale food
		BestScore = -10
	end

	if(items ~= nil) and (items:size() > 0) then
		for i=1, items:size()-1 do
			local item = items:get(i)
			if(item ~= nil) and (item:getCategory() == "Food") and not (item:getPoisonPower() > 1) and (not has_value(FoodsToExlude, item:getType())) then
				local Score = GetFoodScore(item)

				--ContainerItemsScore[i] = Score
				--print("BestFood " .. item:getDisplayName() .. ": " .. tostring(Score))
				if Score > BestScore then
					BestFood = item
					BestScore = Score
				end
			end
		end

		-- loop done sort top down
		--local highestSoFar = 0
		--for k,v in pairs(ContainerItemsScore) do
		--	if(v > highestSoFar) then
		--		ID = k
		--		highestSoFar = v
		--	end
		--end
		--if(ID ~= -1) then BestFood = items:get(ID) end

	end

	if (BestFood ~= nil) then
		--print("BestFood Winner " .. tostring(BestFood:getDisplayName()) .. ": " .. tostring(BestScore))
	end
	return BestFood
end

function FindAndReturnWater(thisItemContainer) -- exlude bleach
	if(not thisItemContainer) then return nil end
	local items = thisItemContainer:getItems()

	if(items ~= nil) and (items:size() > 0) then
		for i=1, items:size()-1 do
			local item = items:get(i)
			if(item ~= nil) and isItemWater(item) then return item end
		end
	end
	return nil
end

function myIsCategory(item,category)

	if(category == "Water") and (isItemWater(item)) then return true
	elseif(category == "Weapon") and (item:getCategory() == category) and (item:getMaxDamage() > 0.1) then return true
	else return (item:getCategory() == category) end

end

function isItemWater(item)
	return ((item:isWaterSource()) and (item:getType() ~= "Bleach"))
end




if not SurvivorRandomSuits then
	SurvivorRandomSuits = {}
	SurvivorRandomSuits["Common"] = {} -- 70%
	SurvivorRandomSuits["Normal"] = {}  -- 20%
	SurvivorRandomSuits["Rare"] = {}	-- 10%
--Edits
	if (isModEnabled("STR")) then
		SurvivorRandomSuits["RareRW"] = {} -- Rosewood
		SurvivorRandomSuits["RareRS"] = {} -- Riverside
		SurvivorRandomSuits["RareMD"] = {} -- Muldraugh
		SurvivorRandomSuits["RareWP"] = {} -- WestPoint
		SurvivorRandomSuits["RareLV"] = {} -- Louisville
		SurvivorRandomSuits["RareJCPD"] = {} -- JeffersonCountyPD
		SurvivorRandomSuits["RareJCSD"] = {} -- JeffersonCountySD
		SurvivorRandomSuits["RareMC"] = {} -- MeadeCounty
	end
	if (isModEnabled("RavenCreekPDClothes")) then
		SurvivorRandomSuits["RareRCR"] = {} -- RavenCreek
	end
end
--Edits End

if(isModEnabled("Brita_2")) then
	SurvivorRandomSuits["Rare"]["Army"] = {"Base.Hat_BeretArmy", "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Brita_2.Bag_Plate_Carrier", "Brita_2.Bag_D3M", "Base.Trousers_ArmyService", "Base.Shoes_ArmyBoots"}
	SurvivorRandomSuits["Rare"]["ArmyCamo"] = {"Brita_2.Hat_FAST_Opscore", "Brita_2.Hat_Sordin", "Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Brita_2.Bag_Plate_Carrier", "Brita_2.Bag_D3M", "Base.Trousers_CamoDesert", "Base.Shoes_ArmyBootsDesert"}
	SurvivorRandomSuits["Rare"]["MarinesCamo"] = {"Base.Hat_Army", "Brita_2.Hat_Helmet_Headset", "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Vest_BulletArmy", "Brita_2.Bag_D3M", "Base.Trousers_CamoGreen", "Base.Shoes_ArmyBoots"}
else
	SurvivorRandomSuits["Rare"]["Army"] = {"Base.Hat_BeretArmy", "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", "Base.Trousers_ArmyService", "Base.Shoes_ArmyBoots"}
	SurvivorRandomSuits["Rare"]["ArmyCamo"] = {"Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", "Base.Trousers_CamoDesert", "Base.Shoes_ArmyBootsDesert"}
	SurvivorRandomSuits["Rare"]["MarinesCamo"] = {"Base.Hat_Army", "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Bag_ALICEpack", "Base.Vest_BulletArmy", "Base.Trousers_CamoGreen", "Base.Shoes_ArmyBoots"}
end

if (isModEnabled("TWDRG")) then
	SurvivorRandomSuits["Rare"]["Sheriff1"] = {"TWDRG.Hat_Police_Sheriff", "TWDRG.TShirt_Police_Sheriff", "TWDRG.Shirt_Police_Sheriff", "TWDRG.Trousers_Police_Sheriff", "TWDRG.Jacket_Police_Sheriff", "TWDRG.Vest_BulletPolice_Sheriff", "Base.Shoes_BlackBoots"}
end

--Edits
--SmallTownResponders Stuff, Very Confusing
if(isModEnabled("STR")) then
--Rosewood
	SurvivorRandomSuits["RareRW"]["Army"] = {"Base.Hat_BeretArmy", "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", "Base.Trousers_ArmyService", "Base.Shoes_ArmyBoots"}
	SurvivorRandomSuits["RareRW"]["ArmyCamo"] = {"Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", "Base.Trousers_CamoDesert", "Base.Shoes_ArmyBootsDesert"}
	SurvivorRandomSuits["RareRW"]["MarinesCamo"] = {"Base.Hat_Army", "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Bag_ALICEpack", "Base.Vest_BulletArmy", "Base.Trousers_CamoGreen", "Base.Shoes_ArmyBoots"}

	SurvivorRandomSuits["RareRW"]["Bride1F"] = {"Base.WeddingDress", "Base.Shirt_FormalWhite", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRW"]["Groom1M"] = {"Base.Tie_BowTieFull", "Base.Gloves_WhiteTINT", "Base.WeddingJacket", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Socks_Long", "Shoes_Black"}
	SurvivorRandomSuits["RareRW"]["Priest1"] = {"Base.Shirt_Priest", "Base.Trousers_Suit", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRW"]["ShopSpiffo1"] = {"Base.Tshirt_BusinessSpiffo", "Base.Apron_Spiffos", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["RareRW"]["Swimwear1F"] = {"Base.Bikini_Pattern01", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareRW"]["Swimwear1M"] = {"Base.SwimTrunks_Blue", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareRW"]["Nurse1"] = {"Base.Hat_SurgicalMask_Blue", "Base.Tshirt_Scrubs", "Base.Trousers_Scrubs", "Base.Socks_Ankle", "Base.Shoes_Black"}
	--EMS
    SurvivorRandomSuits["RareRW"]["MeadeCountyEMS1"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "STR.Jacket_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["MeadeCountyEMS2"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["MeadeCountyEMS3"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["MeadeCountyEMS4"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "STR.Jacket_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["MeadeCountyEMS5"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["MeadeCountyEMS6"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}

	SurvivorRandomSuits["RareRW"]["Prepper1"] = {"Base.Hat_GasMask", "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRW"]["Bandit1"] = {"Base.Hat_BalaclavaFull", "Base.Jacket_Padded", "Base.TrousersMesh_DenimLight", "Base.Tshirt_Rock", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRW"]["Bandit2"] = {"Base.Hat_BalaclavaFull", "Base.HoodieUP_WhiteTINT", "Base.TrousersMesh_DenimLight", "Tshirt_DefaultDECAL", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRW"]["Bandit3"] = {"Base.Hat_BalaclavaFull", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}
	--Prisoners
    SurvivorRandomSuits["RareRW"]["MeadeCountyPrisoner1"] = {"STR.Boilersuit_MeadeGenPopPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["MeadeCountyPrisoner2"] = {"STR.Boilersuit_MeadeLowRiskPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["MeadeCountyPrisoner3"] = {"STR.Boilersuit_MeadeMaxPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
	--Rangers
    SurvivorRandomSuits["RareRW"]["FederalRanger1"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "STR.Jacket_Federal_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["FederalRanger2"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["FederalRanger3"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareRW"]["StateLawRanger1"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "STR.Jacket_State_LawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["StateLawRanger2"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["StateLawRanger3"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareRW"]["StateRanger1"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "STR.Jacket_State_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["StateRanger2"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["StateRanger3"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
	--Rosewood Black
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullB1"] = {"STR.Hat_Fireman_Rosewood_Black", "STR.TShirt_Profession_FiremanBlue_Rosewood", "STR.Trousers_Fireman_Rosewood_Black", "STR.Jacket_Fireman_Rosewood_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullB2"] = {"STR.Hat_Fireman_Rosewood_Black", "STR.TShirt_Profession_FiremanRed_Rosewood", "STR.Trousers_Fireman_Rosewood_Black", "STR.Jacket_Fireman_Rosewood_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullB3"] = {"STR.Hat_Fireman_Rosewood_Black", "STR.TShirt_Profession_FiremanRed_Rosewood02", "STR.Trousers_Fireman_Rosewood_Black", "STR.Jacket_Fireman_Rosewood_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullB4"] = {"STR.Hat_Fireman_Rosewood_Black", "STR.TShirt_Profession_FiremanWhite_Rosewood", "STR.Trousers_Fireman_Rosewood_Black", "STR.Jacket_Fireman_Rosewood_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullB5"] = {"STR.Hat_Fireman_Rosewood_Red", "STR.TShirt_Profession_FiremanBlue_Rosewood", "STR.Trousers_Fireman_Rosewood_Black", "STR.Jacket_Fireman_Rosewood_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullB6"] = {"STR.Hat_Fireman_Rosewood_Red", "STR.TShirt_Profession_FiremanRed_Rosewood", "STR.Trousers_Fireman_Rosewood_Black", "STR.Jacket_Fireman_Rosewood_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullB7"] = {"STR.Hat_Fireman_Rosewood_Red", "STR.TShirt_Profession_FiremanRed_Rosewood02", "STR.Trousers_Fireman_Rosewood_Black", "STR.Jacket_Fireman_Rosewood_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullB8"] = {"STR.Hat_Fireman_Rosewood_Red", "STR.TShirt_Profession_FiremanWhite_Rosewood", "STR.Trousers_Fireman_Rosewood_Black", "STR.Jacket_Fireman_Rosewood_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullB9"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanBlue_Rosewood", "STR.Trousers_Fireman_Rosewood_Black", "STR.Jacket_Fireman_Rosewood_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullB10"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanRed_Rosewood", "STR.Trousers_Fireman_Rosewood_Black", "STR.Jacket_Fireman_Rosewood_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullB11"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanRed_Rosewood02", "STR.Trousers_Fireman_Rosewood_Black", "STR.Jacket_Fireman_Rosewood_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullB12"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanWhite_Rosewood", "STR.Trousers_Fireman_Rosewood_Black", "STR.Jacket_Fireman_Rosewood_Black", "Base.Shoes_BlackBoots"}
	--Rosewood Khaki
	SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullK1"] = {"STR.Hat_Fireman_Rosewood_Black", "STR.TShirt_Profession_FiremanBlue_Rosewood", "STR.Trousers_Fireman_Rosewood_Khaki", "STR.Jacket_Fireman_Rosewood_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullK2"] = {"STR.Hat_Fireman_Rosewood_Black", "STR.TShirt_Profession_FiremanRed_Rosewood", "STR.Trousers_Fireman_Rosewood_Khaki", "STR.Jacket_Fireman_Rosewood_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullK3"] = {"STR.Hat_Fireman_Rosewood_Black", "STR.TShirt_Profession_FiremanRed_Rosewood02", "STR.Trousers_Fireman_Rosewood_Khaki", "STR.Jacket_Fireman_Rosewood_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullK4"] = {"STR.Hat_Fireman_Rosewood_Black", "STR.TShirt_Profession_FiremanWhite_Rosewood", "STR.Trousers_Fireman_Rosewood_Khaki", "STR.Jacket_Fireman_Rosewood_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullK5"] = {"STR.Hat_Fireman_Rosewood_Red", "STR.TShirt_Profession_FiremanBlue_Rosewood", "STR.Trousers_Fireman_Rosewood_Khaki", "STR.Jacket_Fireman_Rosewood_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullK6"] = {"STR.Hat_Fireman_Rosewood_Red", "STR.TShirt_Profession_FiremanRed_Rosewood", "STR.Trousers_Fireman_Rosewood_Khaki", "STR.Jacket_Fireman_Rosewood_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullK7"] = {"STR.Hat_Fireman_Rosewood_Red", "STR.TShirt_Profession_FiremanRed_Rosewood02", "STR.Trousers_Fireman_Rosewood_Khaki", "STR.Jacket_Fireman_Rosewood_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullK8"] = {"STR.Hat_Fireman_Rosewood_Red", "STR.TShirt_Profession_FiremanWhite_Rosewood", "STR.Trousers_Fireman_Rosewood_Khaki", "STR.Jacket_Fireman_Rosewood_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullK9"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanBlue_Rosewood", "STR.Trousers_Fireman_Rosewood_Khaki", "STR.Jacket_Fireman_Rosewood_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullK10"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanRed_Rosewood", "STR.Trousers_Fireman_Rosewood_Khaki", "STR.Jacket_Fireman_Rosewood_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullK11"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanRed_Rosewood02", "STR.Trousers_Fireman_Rosewood_Khaki", "STR.Jacket_Fireman_Rosewood_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRW"]["RosewoodFiremanFullK12"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanWhite_Rosewood", "STR.Trousers_Fireman_Rosewood_Khaki", "STR.Jacket_Fireman_Rosewood_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRW"]["RosewoodSD1"] = {"STR.Hat_Police_Rosewood", "STR.TShirt_Police_Rosewood", "STR.Shirt_Police_Rosewood", "STR.Trousers_Police_Rosewood", "STR.Jacket_Police_Rosewood", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRW"]["RosewoodSD2"] = {"STR.Hat_Police_Rosewood", "STR.TShirt_Police_Rosewood", "STR.Shirt_Police_Rosewood", "STR.Trousers_Police_Rosewood", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRW"]["RosewoodSD3"] = {"STR.Hat_Police_Rosewood", "STR.TShirt_Police_Rosewood", "STR.Trousers_Police_Rosewood", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}

    SurvivorRandomSuits["RareRW"]["KentuckyStatePatrol1"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRW"]["KentuckyStatePatrol2"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRW"]["KentuckyStatePatrol3"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRW"]["KentuckyStatePatrol4"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRW"]["KentuckyStatePatrol5"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRW"]["KentuckyStatePatrol6"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
	--USPS
    SurvivorRandomSuits["RareRW"]["USPS1"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRW"]["USPS2"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRW"]["USPS3"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRW"]["USPS4"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRW"]["USPS5"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRW"]["USPS6"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}

    SurvivorRandomSuits["RareRW"]["Judge1"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRW"]["Judge2"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Brown"}
--Riverside
	SurvivorRandomSuits["RareRS"]["Army"] = {"Base.Hat_BeretArmy", "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", "Base.Trousers_ArmyService", "Base.Shoes_ArmyBoots"}
	SurvivorRandomSuits["RareRS"]["ArmyCamo"] = {"Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", "Base.Trousers_CamoDesert", "Base.Shoes_ArmyBootsDesert"}
	SurvivorRandomSuits["RareRS"]["MarinesCamo"] = {"Base.Hat_Army", "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Bag_ALICEpack", "Base.Vest_BulletArmy", "Base.Trousers_CamoGreen", "Base.Shoes_ArmyBoots"}

	SurvivorRandomSuits["RareRS"]["Bride1F"] = {"Base.WeddingDress", "Base.Shirt_FormalWhite", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRS"]["Groom1M"] = {"Base.Tie_BowTieFull", "Base.Gloves_WhiteTINT", "Base.WeddingJacket", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Socks_Long", "Shoes_Black"}
	SurvivorRandomSuits["RareRS"]["Priest1"] = {"Base.Shirt_Priest", "Base.Trousers_Suit", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRS"]["ShopSpiffo1"] = {"Base.Tshirt_BusinessSpiffo", "Base.Apron_Spiffos", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["RareRS"]["Swimwear1F"] = {"Base.Bikini_Pattern01", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareRS"]["Swimwear1M"] = {"Base.SwimTrunks_Blue", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareRS"]["Nurse1"] = {"Base.Hat_SurgicalMask_Blue", "Base.Tshirt_Scrubs", "Base.Trousers_Scrubs", "Base.Socks_Ankle", "Base.Shoes_Black"}
	--EMS
    SurvivorRandomSuits["RareRS"]["MeadeCountyEMS1"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "STR.Jacket_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyEMS2"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyEMS3"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyEMS4"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "STR.Jacket_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyEMS5"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyEMS6"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}

	SurvivorRandomSuits["RareRS"]["Prepper1"] = {"Base.Hat_GasMask", "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRS"]["Bandit1"] = {"Base.Hat_BalaclavaFull", "Base.Jacket_Padded", "Base.TrousersMesh_DenimLight", "Base.Tshirt_Rock", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRS"]["Bandit2"] = {"Base.Hat_BalaclavaFull", "Base.HoodieUP_WhiteTINT", "Base.TrousersMesh_DenimLight", "Tshirt_DefaultDECAL", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRS"]["Bandit3"] = {"Base.Hat_BalaclavaFull", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}
	--Prisoners
    SurvivorRandomSuits["RareRS"]["MeadeCountyPrisoner1"] = {"STR.Boilersuit_MeadeGenPopPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyPrisoner2"] = {"STR.Boilersuit_MeadeLowRiskPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyPrisoner3"] = {"STR.Boilersuit_MeadeMaxPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
	--Rangers
    SurvivorRandomSuits["RareRS"]["FederalRanger1"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "STR.Jacket_Federal_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["FederalRanger2"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["FederalRanger3"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareRS"]["StateLawRanger1"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "STR.Jacket_State_LawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["StateLawRanger2"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["StateLawRanger3"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareRS"]["StateRanger1"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "STR.Jacket_State_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["StateRanger2"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["StateRanger3"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
	--Meade County Black
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullB1"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullB2"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullB3"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullB4"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullB5"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullB6"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullB7"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullB8"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullB9"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullB10"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullB11"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullB12"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
	--Meade County Khaki
	SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullK1"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullK2"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullK3"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullK4"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullK5"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullK6"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullK7"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullK8"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullK9"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullK10"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullK11"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRS"]["MeadeCountyFiremanFullK12"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRS"]["RiversidePD1"] = {"STR.Hat_Police_Riverside", "STR.TShirt_Police_Riverside", "STR.Shirt_Police_Riverside", "STR.Trousers_Police_Riverside", "STR.Jacket_Police_Riverside", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRS"]["RiversidePD2"] = {"STR.Hat_Police_Riverside", "STR.TShirt_Police_Riverside", "STR.Shirt_Police_Riverside", "STR.Trousers_Police_Riverside", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRS"]["RiversidePD3"] = {"STR.Hat_Police_Riverside", "STR.TShirt_Police_Riverside", "STR.Trousers_Police_Riverside", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}

    SurvivorRandomSuits["RareRS"]["KentuckyStatePatrol1"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRS"]["KentuckyStatePatrol2"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRS"]["KentuckyStatePatrol3"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRS"]["KentuckyStatePatrol4"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRS"]["KentuckyStatePatrol5"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRS"]["KentuckyStatePatrol6"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
	--USPS
    SurvivorRandomSuits["RareRS"]["USPS1"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRS"]["USPS2"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRS"]["USPS3"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRS"]["USPS4"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRS"]["USPS5"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRS"]["USPS6"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}

    SurvivorRandomSuits["RareRS"]["Judge1"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRS"]["Judge2"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Brown"}
--Muldraugh
	SurvivorRandomSuits["RareMD"]["Army"] = {"Base.Hat_BeretArmy", "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", "Base.Trousers_ArmyService", "Base.Shoes_ArmyBoots"}
	SurvivorRandomSuits["RareMD"]["ArmyCamo"] = {"Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", "Base.Trousers_CamoDesert", "Base.Shoes_ArmyBootsDesert"}
	SurvivorRandomSuits["RareMD"]["MarinesCamo"] = {"Base.Hat_Army", "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Bag_ALICEpack", "Base.Vest_BulletArmy", "Base.Trousers_CamoGreen", "Base.Shoes_ArmyBoots"}

	SurvivorRandomSuits["RareMD"]["Bride1F"] = {"Base.WeddingDress", "Base.Shirt_FormalWhite", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareMD"]["Groom1M"] = {"Base.Tie_BowTieFull", "Base.Gloves_WhiteTINT", "Base.WeddingJacket", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Socks_Long", "Shoes_Black"}
	SurvivorRandomSuits["RareMD"]["Priest1"] = {"Base.Shirt_Priest", "Base.Trousers_Suit", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareMD"]["ShopSpiffo1"] = {"Base.Tshirt_BusinessSpiffo", "Base.Apron_Spiffos", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["RareMD"]["Swimwear1F"] = {"Base.Bikini_Pattern01", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareMD"]["Swimwear1M"] = {"Base.SwimTrunks_Blue", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareMD"]["Nurse1"] = {"Base.Hat_SurgicalMask_Blue", "Base.Tshirt_Scrubs", "Base.Trousers_Scrubs", "Base.Socks_Ankle", "Base.Shoes_Black"}
	--EMS
    SurvivorRandomSuits["RareMD"]["MeadeCountyEMS1"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "STR.Jacket_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyEMS2"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyEMS3"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyEMS4"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "STR.Jacket_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyEMS5"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyEMS6"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}

	SurvivorRandomSuits["RareMD"]["Prepper1"] = {"Base.Hat_GasMask", "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareMD"]["Bandit1"] = {"Base.Hat_BalaclavaFull", "Base.Jacket_Padded", "Base.TrousersMesh_DenimLight", "Base.Tshirt_Rock", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareMD"]["Bandit2"] = {"Base.Hat_BalaclavaFull", "Base.HoodieUP_WhiteTINT", "Base.TrousersMesh_DenimLight", "Tshirt_DefaultDECAL", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareMD"]["Bandit3"] = {"Base.Hat_BalaclavaFull", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}
	--Prisoners
    SurvivorRandomSuits["RareMD"]["MeadeCountyPrisoner1"] = {"STR.Boilersuit_MeadeGenPopPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyPrisoner2"] = {"STR.Boilersuit_MeadeLowRiskPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyPrisoner3"] = {"STR.Boilersuit_MeadeMaxPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
	--Rangers
    SurvivorRandomSuits["RareMD"]["FederalRanger1"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "STR.Jacket_Federal_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["FederalRanger2"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["FederalRanger3"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareMD"]["StateLawRanger1"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "STR.Jacket_State_LawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["StateLawRanger2"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["StateLawRanger3"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareMD"]["StateRanger1"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "STR.Jacket_State_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["StateRanger2"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["StateRanger3"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
	--Meade County Black
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullB1"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullB2"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullB3"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullB4"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullB5"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullB6"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullB7"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullB8"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullB9"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullB10"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullB11"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullB12"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
	--Meade County Khaki
	SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullK1"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullK2"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullK3"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullK4"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullK5"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullK6"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullK7"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullK8"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullK9"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullK10"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullK11"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMD"]["MeadeCountyFiremanFullK12"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareMD"]["MuldraughPD1"] = {"STR.Hat_Police_Muldraugh", "STR.TShirt_Police_Muldraugh", "STR.Shirt_Police_Muldraugh", "STR.Trousers_Police_Muldraugh", "STR.Jacket_Police_Muldraugh", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMD"]["MuldraughPD2"] = {"STR.Hat_Police_Muldraugh", "STR.TShirt_Police_Muldraugh", "STR.Shirt_Police_Muldraugh", "STR.Trousers_Police_Muldraugh", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMD"]["MuldraughPD3"] = {"STR.Hat_Police_Muldraugh", "STR.TShirt_Police_Muldraugh", "STR.Trousers_Police_Muldraugh", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}

    SurvivorRandomSuits["RareMD"]["KentuckyStatePatrol1"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMD"]["KentuckyStatePatrol2"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMD"]["KentuckyStatePatrol3"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMD"]["KentuckyStatePatrol4"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMD"]["KentuckyStatePatrol5"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMD"]["KentuckyStatePatrol6"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
	--USPS
    SurvivorRandomSuits["RareMD"]["USPS1"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareMD"]["USPS2"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareMD"]["USPS3"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareMD"]["USPS4"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareMD"]["USPS5"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareMD"]["USPS6"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}

    SurvivorRandomSuits["RareMD"]["Judge1"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMD"]["Judge2"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Brown"}
--WestPoint
	SurvivorRandomSuits["RareWP"]["Army"] = {"Base.Hat_BeretArmy", "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", "Base.Trousers_ArmyService", "Base.Shoes_ArmyBoots"}
	SurvivorRandomSuits["RareWP"]["ArmyCamo"] = {"Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", "Base.Trousers_CamoDesert", "Base.Shoes_ArmyBootsDesert"}
	SurvivorRandomSuits["RareWP"]["MarinesCamo"] = {"Base.Hat_Army", "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Bag_ALICEpack", "Base.Vest_BulletArmy", "Base.Trousers_CamoGreen", "Base.Shoes_ArmyBoots"}

	SurvivorRandomSuits["RareWP"]["Bride1F"] = {"Base.WeddingDress", "Base.Shirt_FormalWhite", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareWP"]["Groom1M"] = {"Base.Tie_BowTieFull", "Base.Gloves_WhiteTINT", "Base.WeddingJacket", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Socks_Long", "Shoes_Black"}
	SurvivorRandomSuits["RareWP"]["Priest1"] = {"Base.Shirt_Priest", "Base.Trousers_Suit", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareWP"]["ShopSpiffo1"] = {"Base.Tshirt_BusinessSpiffo", "Base.Apron_Spiffos", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["RareWP"]["Swimwear1F"] = {"Base.Bikini_Pattern01", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareWP"]["Swimwear1M"] = {"Base.SwimTrunks_Blue", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareWP"]["Nurse1"] = {"Base.Hat_SurgicalMask_Blue", "Base.Tshirt_Scrubs", "Base.Trousers_Scrubs", "Base.Socks_Ankle", "Base.Shoes_Black"}
	--EMS
    SurvivorRandomSuits["RareWP"]["MeadeCountyEMS1"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "STR.Jacket_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyEMS2"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyEMS3"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyEMS4"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "STR.Jacket_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyEMS5"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyEMS6"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}

	SurvivorRandomSuits["RareWP"]["Prepper1"] = {"Base.Hat_GasMask", "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareWP"]["Bandit1"] = {"Base.Hat_BalaclavaFull", "Base.Jacket_Padded", "Base.TrousersMesh_DenimLight", "Base.Tshirt_Rock", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareWP"]["Bandit2"] = {"Base.Hat_BalaclavaFull", "Base.HoodieUP_WhiteTINT", "Base.TrousersMesh_DenimLight", "Tshirt_DefaultDECAL", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareWP"]["Bandit3"] = {"Base.Hat_BalaclavaFull", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}
	--Prisoners
    SurvivorRandomSuits["RareWP"]["MeadeCountyPrisoner1"] = {"STR.Boilersuit_MeadeGenPopPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyPrisoner2"] = {"STR.Boilersuit_MeadeLowRiskPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyPrisoner3"] = {"STR.Boilersuit_MeadeMaxPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
	--Rangers
    SurvivorRandomSuits["RareWP"]["FederalRanger1"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "STR.Jacket_Federal_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["FederalRanger2"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["FederalRanger3"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareWP"]["StateLawRanger1"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "STR.Jacket_State_LawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["StateLawRanger2"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["StateLawRanger3"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareWP"]["StateRanger1"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "STR.Jacket_State_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["StateRanger2"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["StateRanger3"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
	--Meade County Black
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullB1"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullB2"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullB3"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullB4"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullB5"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullB6"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullB7"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullB8"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullB9"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullB10"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullB11"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullB12"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
	--Meade County Khaki
	SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullK1"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullK2"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullK3"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullK4"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullK5"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullK6"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullK7"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullK8"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullK9"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullK10"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullK11"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareWP"]["MeadeCountyFiremanFullK12"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareWP"]["WestPointPD1"] = {"STR.Hat_Police_WestPoint", "STR.TShirt_Police_WestPoint", "STR.Shirt_Police_WestPoint", "STR.Trousers_Police_WestPoint", "STR.Jacket_Police_WestPoint", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareWP"]["WestPointPD2"] = {"STR.Hat_Police_WestPoint", "STR.TShirt_Police_WestPoint", "STR.Shirt_Police_WestPoint", "STR.Trousers_Police_WestPoint", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareWP"]["WestPointPD3"] = {"STR.Hat_Police_WestPoint", "STR.TShirt_Police_WestPoint", "STR.Trousers_Police_WestPoint", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}

    SurvivorRandomSuits["RareWP"]["KentuckyStatePatrol1"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareWP"]["KentuckyStatePatrol2"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareWP"]["KentuckyStatePatrol3"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareWP"]["KentuckyStatePatrol4"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareWP"]["KentuckyStatePatrol5"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareWP"]["KentuckyStatePatrol6"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
	--USPS
    SurvivorRandomSuits["RareWP"]["USPS1"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareWP"]["USPS2"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareWP"]["USPS3"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareWP"]["USPS4"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareWP"]["USPS5"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareWP"]["USPS6"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}

    SurvivorRandomSuits["RareWP"]["Judge1"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareWP"]["Judge2"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Brown"}
--Louisville
	SurvivorRandomSuits["RareLV"]["Army"] = {"Base.Hat_BeretArmy", "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", "Base.Trousers_ArmyService", "Base.Shoes_ArmyBoots"}
	SurvivorRandomSuits["RareLV"]["ArmyCamo"] = {"Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", "Base.Trousers_CamoDesert", "Base.Shoes_ArmyBootsDesert"}
	SurvivorRandomSuits["RareLV"]["MarinesCamo"] = {"Base.Hat_Army", "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Bag_ALICEpack", "Base.Vest_BulletArmy", "Base.Trousers_CamoGreen", "Base.Shoes_ArmyBoots"}

	SurvivorRandomSuits["RareLV"]["Bride1F"] = {"Base.WeddingDress", "Base.Shirt_FormalWhite", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareLV"]["Groom1M"] = {"Base.Tie_BowTieFull", "Base.Gloves_WhiteTINT", "Base.WeddingJacket", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Socks_Long", "Shoes_Black"}
	SurvivorRandomSuits["RareLV"]["Priest1"] = {"Base.Shirt_Priest", "Base.Trousers_Suit", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareLV"]["ShopSpiffo1"] = {"Base.Tshirt_BusinessSpiffo", "Base.Apron_Spiffos", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["RareLV"]["Swimwear1F"] = {"Base.Bikini_Pattern01", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareLV"]["Swimwear1M"] = {"Base.SwimTrunks_Blue", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareLV"]["Nurse1"] = {"Base.Hat_SurgicalMask_Blue", "Base.Tshirt_Scrubs", "Base.Trousers_Scrubs", "Base.Socks_Ankle", "Base.Shoes_Black"}
	--EMS
    SurvivorRandomSuits["RareLV"]["LouisvilleEMS1"] = {"STR.Hat_BaseballCap_EMS_Louisville", "STR.TShirt_EMS_Louisville", "STR.Shirt_EMS_Louisville", "STR.Trousers_EMS_Louisville", "STR.Jacket_EMS_Louisville", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareLV"]["LouisvilleEMS2"] = {"STR.Hat_BaseballCap_EMS_Louisville", "STR.TShirt_EMS_Louisville", "STR.Shirt_EMS_Louisville", "STR.Trousers_EMS_Louisville", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareLV"]["LouisvilleEMS3"] = {"STR.Hat_BaseballCap_EMS_Louisville", "STR.TShirt_EMS_Louisville", "STR.Trousers_EMS_Louisville", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareLV"]["LouisvilleEMS4"] = {"STR.Hat_BaseballCap_EMS_Louisville_Reverse", "STR.TShirt_EMS_Louisville", "STR.Shirt_EMS_Louisville", "STR.Trousers_EMS_Louisville", "STR.Jacket_EMS_Louisville", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareLV"]["LouisvilleEMS5"] = {"STR.Hat_BaseballCap_EMS_Louisville_Reverse", "STR.TShirt_EMS_Louisville", "STR.Shirt_EMS_Louisville", "STR.Trousers_EMS_Louisville", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareLV"]["LouisvilleEMS6"] = {"STR.Hat_BaseballCap_EMS_Louisville_Reverse", "STR.TShirt_EMS_Louisville", "STR.Trousers_EMS_Louisville", "Base.Shoes_Black"}

	SurvivorRandomSuits["RareLV"]["Prepper1"] = {"Base.Hat_GasMask", "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareLV"]["Bandit1"] = {"Base.Hat_BalaclavaFull", "Base.Jacket_Padded", "Base.TrousersMesh_DenimLight", "Base.Tshirt_Rock", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareLV"]["Bandit2"] = {"Base.Hat_BalaclavaFull", "Base.HoodieUP_WhiteTINT", "Base.TrousersMesh_DenimLight", "Tshirt_DefaultDECAL", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareLV"]["Bandit3"] = {"Base.Hat_BalaclavaFull", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}
	--Prisoners
    SurvivorRandomSuits["RareLV"]["JeffersonCountyPrisoner1"] = {"STR.Boilersuit_JeffersonPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
	--Rangers
    SurvivorRandomSuits["RareLV"]["FederalRanger1"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "STR.Jacket_Federal_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareLV"]["FederalRanger2"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareLV"]["FederalRanger3"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareLV"]["StateLawRanger1"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "STR.Jacket_State_LawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareLV"]["StateLawRanger2"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareLV"]["StateLawRanger3"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareLV"]["StateRanger1"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "STR.Jacket_State_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareLV"]["StateRanger2"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareLV"]["StateRanger3"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
	--Louisville Black
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullB1"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullB2"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullB3"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullB4"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullB5"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullB6"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullB7"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullB8"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullB9"] = {"STR.Hat_Fireman_Louisville_Yellow", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullB10"] = {"STR.Hat_Fireman_Louisville_Yellow", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullB11"] = {"STR.Hat_Fireman_Louisville_Yellow", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullB12"] = {"STR.Hat_Fireman_Louisville_Yellow", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
	--Louisville Khaki
	SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullK1"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullK2"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullK3"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullK4"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullK5"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullK6"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullK7"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullK8"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullK9"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullK10"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullK11"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareLV"]["LouisvilleFiremanFullK12"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareLV"]["LouisvillePD1"] = {"STR.Hat_Police_Louisville", "STR.TShirt_Police_Louisville", "STR.Shirt_Police_Louisville", "STR.Trousers_Police_Louisville", "STR.Jacket_Police_Louisville", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareLV"]["LouisvillePD2"] = {"STR.Hat_Police_Louisville", "STR.TShirt_Police_Louisville", "STR.Shirt_Police_Louisville", "STR.Trousers_Police_Louisville", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareLV"]["LouisvillePD3"] = {"STR.Hat_Police_Louisville", "STR.TShirt_Police_Louisville", "STR.Trousers_Police_Louisville", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}

    SurvivorRandomSuits["RareLV"]["KentuckyStatePatrol1"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareLV"]["KentuckyStatePatrol2"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareLV"]["KentuckyStatePatrol3"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareLV"]["KentuckyStatePatrol4"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareLV"]["KentuckyStatePatrol5"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareLV"]["KentuckyStatePatrol6"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
	--USPS
    SurvivorRandomSuits["RareLV"]["USPS1"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareLV"]["USPS2"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareLV"]["USPS3"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareLV"]["USPS4"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareLV"]["USPS5"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareLV"]["USPS6"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}

    SurvivorRandomSuits["RareLV"]["Judge1"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareLV"]["Judge2"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Brown"}
--JeffersonCountyPD
	SurvivorRandomSuits["RareJCPD"]["Army"] = {"Base.Hat_BeretArmy", "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", "Base.Trousers_ArmyService", "Base.Shoes_ArmyBoots"}
	SurvivorRandomSuits["RareJCPD"]["ArmyCamo"] = {"Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", "Base.Trousers_CamoDesert", "Base.Shoes_ArmyBootsDesert"}
	SurvivorRandomSuits["RareJCPD"]["MarinesCamo"] = {"Base.Hat_Army", "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Bag_ALICEpack", "Base.Vest_BulletArmy", "Base.Trousers_CamoGreen", "Base.Shoes_ArmyBoots"}

	SurvivorRandomSuits["RareJCPD"]["Bride1F"] = {"Base.WeddingDress", "Base.Shirt_FormalWhite", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareJCPD"]["Groom1M"] = {"Base.Tie_BowTieFull", "Base.Gloves_WhiteTINT", "Base.WeddingJacket", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Socks_Long", "Shoes_Black"}
	SurvivorRandomSuits["RareJCPD"]["Priest1"] = {"Base.Shirt_Priest", "Base.Trousers_Suit", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareJCPD"]["ShopSpiffo1"] = {"Base.Tshirt_BusinessSpiffo", "Base.Apron_Spiffos", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["RareJCPD"]["Swimwear1F"] = {"Base.Bikini_Pattern01", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareJCPD"]["Swimwear1M"] = {"Base.SwimTrunks_Blue", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareJCPD"]["Nurse1"] = {"Base.Hat_SurgicalMask_Blue", "Base.Tshirt_Scrubs", "Base.Trousers_Scrubs", "Base.Socks_Ankle", "Base.Shoes_Black"}
	--EMS
    SurvivorRandomSuits["RareJCPD"]["JeffersonCountyEMS1"] = {"STR.Hat_BaseballCap_EMS_Jefferson", "STR.TShirt_EMS_Jefferson", "STR.Shirt_EMS_Jefferson", "STR.Trousers_EMS_Jefferson", "STR.Jacket_EMS_Jefferson", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCPD"]["JeffersonCountyEMS2"] = {"STR.Hat_BaseballCap_EMS_Jefferson", "STR.TShirt_EMS_Jefferson", "STR.Shirt_EMS_Jefferson", "STR.Trousers_EMS_Jefferson", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCPD"]["JeffersonCountyEMS3"] = {"STR.Hat_BaseballCap_EMS_Jefferson", "STR.TShirt_EMS_Jefferson", "STR.Trousers_EMS_Jefferson", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCPD"]["JeffersonCountyEMS4"] = {"STR.Hat_BaseballCap_EMS_Jefferson_Reverse", "STR.TShirt_EMS_Jefferson", "STR.Shirt_EMS_Jefferson", "STR.Trousers_EMS_Jefferson", "STR.Jacket_EMS_Jefferson", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCPD"]["JeffersonCountyEMS5"] = {"STR.Hat_BaseballCap_EMS_Jefferson_Reverse", "STR.TShirt_EMS_Jefferson", "STR.Shirt_EMS_Jefferson", "STR.Trousers_EMS_Jefferson", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCPD"]["JeffersonCountyEMS6"] = {"STR.Hat_BaseballCap_EMS_Jefferson_Reverse", "STR.TShirt_EMS_Jefferson", "STR.Trousers_EMS_Jefferson", "Base.Shoes_Black"}

	SurvivorRandomSuits["RareJCPD"]["Prepper1"] = {"Base.Hat_GasMask", "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareJCPD"]["Bandit1"] = {"Base.Hat_BalaclavaFull", "Base.Jacket_Padded", "Base.TrousersMesh_DenimLight", "Base.Tshirt_Rock", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareJCPD"]["Bandit2"] = {"Base.Hat_BalaclavaFull", "Base.HoodieUP_WhiteTINT", "Base.TrousersMesh_DenimLight", "Tshirt_DefaultDECAL", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareJCPD"]["Bandit3"] = {"Base.Hat_BalaclavaFull", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}
	--Prisoners
    SurvivorRandomSuits["RareJCPD"]["JeffersonCountyPrisoner1"] = {"STR.Boilersuit_JeffersonPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
	--Rangers
    SurvivorRandomSuits["RareJCPD"]["FederalRanger1"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "STR.Jacket_Federal_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCPD"]["FederalRanger2"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCPD"]["FederalRanger3"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareJCPD"]["StateLawRanger1"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "STR.Jacket_State_LawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCPD"]["StateLawRanger2"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCPD"]["StateLawRanger3"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareJCPD"]["StateRanger1"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "STR.Jacket_State_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCPD"]["StateRanger2"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCPD"]["StateRanger3"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
	--Louisville Black
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullB1"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullB2"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullB3"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullB4"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullB5"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullB6"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullB7"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullB8"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullB9"] = {"STR.Hat_Fireman_Louisville_Yellow", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullB10"] = {"STR.Hat_Fireman_Louisville_Yellow", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullB11"] = {"STR.Hat_Fireman_Louisville_Yellow", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullB12"] = {"STR.Hat_Fireman_Louisville_Yellow", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
	--Louisville Khaki
	SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullK1"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullK2"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullK3"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullK4"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullK5"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullK6"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullK7"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullK8"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullK9"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullK10"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullK11"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCPD"]["LouisvilleFiremanFullK12"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareJCPD"]["JeffersonPD1"] = {"STR.Hat_Police_JeffersonPD", "STR.TShirt_Police_JeffersonPD", "STR.Shirt_Police_JeffersonPD", "STR.Trousers_Police_JeffersonPD", "STR.Jacket_Police_JeffersonPD", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCPD"]["JeffersonPD2"] = {"STR.Hat_Police_JeffersonPD", "STR.TShirt_Police_JeffersonPD", "STR.Shirt_Police_JeffersonPD", "STR.Trousers_Police_JeffersonPD", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCPD"]["JeffersonPD3"] = {"STR.Hat_Police_JeffersonPD", "STR.TShirt_Police_JeffersonPD", "STR.Trousers_Police_JeffersonPD", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}

    SurvivorRandomSuits["RareJCPD"]["KentuckyStatePatrol1"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCPD"]["KentuckyStatePatrol2"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCPD"]["KentuckyStatePatrol3"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCPD"]["KentuckyStatePatrol4"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCPD"]["KentuckyStatePatrol5"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCPD"]["KentuckyStatePatrol6"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
	--USPS
    SurvivorRandomSuits["RareJCPD"]["USPS1"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareJCPD"]["USPS2"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareJCPD"]["USPS3"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareJCPD"]["USPS4"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareJCPD"]["USPS5"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareJCPD"]["USPS6"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}

    SurvivorRandomSuits["RareJCPD"]["Judge1"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCPD"]["Judge2"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Brown"}
--JeffersonCountySD
	SurvivorRandomSuits["RareJCSD"]["Army"] = {"Base.Hat_BeretArmy", "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", "Base.Trousers_ArmyService", "Base.Shoes_ArmyBoots"}
	SurvivorRandomSuits["RareJCSD"]["ArmyCamo"] = {"Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", "Base.Trousers_CamoDesert", "Base.Shoes_ArmyBootsDesert"}
	SurvivorRandomSuits["RareJCSD"]["MarinesCamo"] = {"Base.Hat_Army", "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Bag_ALICEpack", "Base.Vest_BulletArmy", "Base.Trousers_CamoGreen", "Base.Shoes_ArmyBoots"}

	SurvivorRandomSuits["RareJCSD"]["Bride1F"] = {"Base.WeddingDress", "Base.Shirt_FormalWhite", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareJCSD"]["Groom1M"] = {"Base.Tie_BowTieFull", "Base.Gloves_WhiteTINT", "Base.WeddingJacket", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Socks_Long", "Shoes_Black"}
	SurvivorRandomSuits["RareJCSD"]["Priest1"] = {"Base.Shirt_Priest", "Base.Trousers_Suit", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareJCSD"]["ShopSpiffo1"] = {"Base.Tshirt_BusinessSpiffo", "Base.Apron_Spiffos", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["RareJCSD"]["Swimwear1F"] = {"Base.Bikini_Pattern01", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareJCSD"]["Swimwear1M"] = {"Base.SwimTrunks_Blue", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareJCSD"]["Nurse1"] = {"Base.Hat_SurgicalMask_Blue", "Base.Tshirt_Scrubs", "Base.Trousers_Scrubs", "Base.Socks_Ankle", "Base.Shoes_Black"}
	--EMS
    SurvivorRandomSuits["RareJCSD"]["JeffersonCountyEMS1"] = {"STR.Hat_BaseballCap_EMS_Jefferson", "STR.TShirt_EMS_Jefferson", "STR.Shirt_EMS_Jefferson", "STR.Trousers_EMS_Jefferson", "STR.Jacket_EMS_Jefferson", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCSD"]["JeffersonCountyEMS2"] = {"STR.Hat_BaseballCap_EMS_Jefferson", "STR.TShirt_EMS_Jefferson", "STR.Shirt_EMS_Jefferson", "STR.Trousers_EMS_Jefferson", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCSD"]["JeffersonCountyEMS3"] = {"STR.Hat_BaseballCap_EMS_Jefferson", "STR.TShirt_EMS_Jefferson", "STR.Trousers_EMS_Jefferson", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCSD"]["JeffersonCountyEMS4"] = {"STR.Hat_BaseballCap_EMS_Jefferson_Reverse", "STR.TShirt_EMS_Jefferson", "STR.Shirt_EMS_Jefferson", "STR.Trousers_EMS_Jefferson", "STR.Jacket_EMS_Jefferson", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCSD"]["JeffersonCountyEMS5"] = {"STR.Hat_BaseballCap_EMS_Jefferson_Reverse", "STR.TShirt_EMS_Jefferson", "STR.Shirt_EMS_Jefferson", "STR.Trousers_EMS_Jefferson", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCSD"]["JeffersonCountyEMS6"] = {"STR.Hat_BaseballCap_EMS_Jefferson_Reverse", "STR.TShirt_EMS_Jefferson", "STR.Trousers_EMS_Jefferson", "Base.Shoes_Black"}

	SurvivorRandomSuits["RareJCSD"]["Prepper1"] = {"Base.Hat_GasMask", "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareJCSD"]["Bandit1"] = {"Base.Hat_BalaclavaFull", "Base.Jacket_Padded", "Base.TrousersMesh_DenimLight", "Base.Tshirt_Rock", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareJCSD"]["Bandit2"] = {"Base.Hat_BalaclavaFull", "Base.HoodieUP_WhiteTINT", "Base.TrousersMesh_DenimLight", "Tshirt_DefaultDECAL", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareJCSD"]["Bandit3"] = {"Base.Hat_BalaclavaFull", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}
	--Prisoners
    SurvivorRandomSuits["RareJCSD"]["JeffersonCountyPrisoner1"] = {"STR.Boilersuit_JeffersonPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
	--Rangers
    SurvivorRandomSuits["RareJCSD"]["FederalRanger1"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "STR.Jacket_Federal_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCSD"]["FederalRanger2"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCSD"]["FederalRanger3"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareJCSD"]["StateLawRanger1"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "STR.Jacket_State_LawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCSD"]["StateLawRanger2"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCSD"]["StateLawRanger3"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareJCSD"]["StateRanger1"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "STR.Jacket_State_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCSD"]["StateRanger2"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCSD"]["StateRanger3"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
	--Louisville Black
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullB1"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullB2"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullB3"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullB4"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullB5"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullB6"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullB7"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullB8"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullB9"] = {"STR.Hat_Fireman_Louisville_Yellow", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullB10"] = {"STR.Hat_Fireman_Louisville_Yellow", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullB11"] = {"STR.Hat_Fireman_Louisville_Yellow", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullB12"] = {"STR.Hat_Fireman_Louisville_Yellow", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Black", "STR.Jacket_Fireman_Louisville_Black", "Base.Shoes_BlackBoots"}
	--Louisville Khaki
	SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullK1"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullK2"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullK3"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullK4"] = {"STR.Hat_Fireman_Louisville_Black", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullK5"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullK6"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullK7"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullK8"] = {"STR.Hat_Fireman_Louisville_Red", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullK9"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanBlue_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullK10"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanRed_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullK11"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanRed_Louisville02", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareJCSD"]["LouisvilleFiremanFullK12"] = {"STR.Hat_Fireman_Rosewood_Yellow", "STR.TShirt_Profession_FiremanWhite_Louisville", "STR.Trousers_Fireman_Louisville_Khaki", "STR.Jacket_Fireman_Louisville_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareJCSD"]["JeffersonSD1"] = {"STR.Hat_Police_JeffersonSD", "STR.TShirt_Police_JeffersonSD", "STR.Shirt_Police_JeffersonSD", "STR.Trousers_Police_JeffersonSD", "STR.Jacket_Police_JeffersonSD", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCSD"]["JeffersonSD2"] = {"STR.Hat_Police_JeffersonSD", "STR.TShirt_Police_JeffersonSD", "STR.Shirt_Police_JeffersonSD", "STR.Trousers_Police_JeffersonSD", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCSD"]["JeffersonSD3"] = {"STR.Hat_Police_JeffersonSD", "STR.TShirt_Police_JeffersonSD", "STR.Trousers_Police_JeffersonSD", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}

    SurvivorRandomSuits["RareJCSD"]["KentuckyStatePatrol1"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCSD"]["KentuckyStatePatrol2"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCSD"]["KentuckyStatePatrol3"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCSD"]["KentuckyStatePatrol4"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCSD"]["KentuckyStatePatrol5"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareJCSD"]["KentuckyStatePatrol6"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
	--USPS
    SurvivorRandomSuits["RareJCSD"]["USPS1"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareJCSD"]["USPS2"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareJCSD"]["USPS3"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareJCSD"]["USPS4"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareJCSD"]["USPS5"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareJCSD"]["USPS6"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}

    SurvivorRandomSuits["RareJCSD"]["Judge1"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareJCSD"]["Judge2"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Brown"}
--MeadeCounty
	SurvivorRandomSuits["RareMC"]["Army"] = {"Base.Hat_BeretArmy", "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", "Base.Trousers_ArmyService", "Base.Shoes_ArmyBoots"}
	SurvivorRandomSuits["RareMC"]["ArmyCamo"] = {"Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", "Base.Trousers_CamoDesert", "Base.Shoes_ArmyBootsDesert"}
	SurvivorRandomSuits["RareMC"]["MarinesCamo"] = {"Base.Hat_Army", "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Bag_ALICEpack", "Base.Vest_BulletArmy", "Base.Trousers_CamoGreen", "Base.Shoes_ArmyBoots"}

	SurvivorRandomSuits["RareMC"]["Bride1F"] = {"Base.WeddingDress", "Base.Shirt_FormalWhite", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareMC"]["Groom1M"] = {"Base.Tie_BowTieFull", "Base.Gloves_WhiteTINT", "Base.WeddingJacket", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Socks_Long", "Shoes_Black"}
	SurvivorRandomSuits["RareMC"]["Priest1"] = {"Base.Shirt_Priest", "Base.Trousers_Suit", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareMC"]["ShopSpiffo1"] = {"Base.Tshirt_BusinessSpiffo", "Base.Apron_Spiffos", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["RareMC"]["Swimwear1F"] = {"Base.Bikini_Pattern01", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareMC"]["Swimwear1M"] = {"Base.SwimTrunks_Blue", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareMC"]["Nurse1"] = {"Base.Hat_SurgicalMask_Blue", "Base.Tshirt_Scrubs", "Base.Trousers_Scrubs", "Base.Socks_Ankle", "Base.Shoes_Black"}
	--EMS
    SurvivorRandomSuits["RareMC"]["MeadeCountyEMS1"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "STR.Jacket_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyEMS2"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyEMS3"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyEMS4"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "STR.Jacket_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyEMS5"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyEMS6"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}

	SurvivorRandomSuits["RareMC"]["Prepper1"] = {"Base.Hat_GasMask", "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareMC"]["Bandit1"] = {"Base.Hat_BalaclavaFull", "Base.Jacket_Padded", "Base.TrousersMesh_DenimLight", "Base.Tshirt_Rock", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareMC"]["Bandit2"] = {"Base.Hat_BalaclavaFull", "Base.HoodieUP_WhiteTINT", "Base.TrousersMesh_DenimLight", "Tshirt_DefaultDECAL", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareMC"]["Bandit3"] = {"Base.Hat_BalaclavaFull", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}
	--Prisoners
    SurvivorRandomSuits["RareMC"]["MeadeCountyPrisoner1"] = {"STR.Boilersuit_MeadeGenPopPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyPrisoner2"] = {"STR.Boilersuit_MeadeLowRiskPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyPrisoner3"] = {"STR.Boilersuit_MeadeMaxPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
	--Rangers
    SurvivorRandomSuits["RareMC"]["FederalRanger1"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "STR.Jacket_Federal_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["FederalRanger2"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["FederalRanger3"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareMC"]["StateLawRanger1"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "STR.Jacket_State_LawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["StateLawRanger2"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["StateLawRanger3"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareMC"]["StateRanger1"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "STR.Jacket_State_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["StateRanger2"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["StateRanger3"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
	--Meade County Black
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullB1"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullB2"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullB3"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullB4"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullB5"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullB6"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullB7"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullB8"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullB9"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullB10"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullB11"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullB12"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
	--Meade County Khaki
	SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullK1"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullK2"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullK3"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullK4"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullK5"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullK6"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullK7"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullK8"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullK9"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullK10"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullK11"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareMC"]["MeadeCountyFiremanFullK12"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareMC"]["MeadeCountySO1"] = {"STR.Hat_Police_Meade", "STR.TShirt_Police_Meade", "STR.Shirt_Police_Meade", "STR.Trousers_Police_Meade", "STR.Jacket_Police_Meade", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMC"]["MeadeCountySO2"] = {"STR.Hat_Police_Meade", "STR.TShirt_Police_Meade", "STR.Shirt_Police_Meade", "STR.Trousers_Police_Meade", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMC"]["MeadeCountySO3"] = {"STR.Hat_Police_Meade", "STR.TShirt_Police_Meade", "STR.Trousers_Police_Meade", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}

    SurvivorRandomSuits["RareMC"]["KentuckyStatePatrol1"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMC"]["KentuckyStatePatrol2"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMC"]["KentuckyStatePatrol3"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Summer", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMC"]["KentuckyStatePatrol4"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "STR.Jacket_PoliceKSP", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMC"]["KentuckyStatePatrol5"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Shirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareMC"]["KentuckyStatePatrol6"] = {"STR.Hat_PoliceKSP", "STR.TShirt_PoliceKSP", "STR.Trousers_PoliceKSP_Winter", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
	--USPS
    SurvivorRandomSuits["RareMC"]["USPS1"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareMC"]["USPS2"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareMC"]["USPS3"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareMC"]["USPS4"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareMC"]["USPS5"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareMC"]["USPS6"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}

    SurvivorRandomSuits["RareMC"]["Judge1"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareMC"]["Judge2"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Brown"}
end
--RavenCreek Stuff, Very Confusing
if(isModEnabled("RavenCreekPDClothes")) and not (isModEnabled("STR")) then
--RavenCreek
	SurvivorRandomSuits["RareRCR"]["Army"] = {"Base.Hat_BeretArmy", "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", "Base.Trousers_ArmyService", "Base.Shoes_ArmyBoots"}
	SurvivorRandomSuits["RareRCR"]["ArmyCamo"] = {"Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", "Base.Trousers_CamoDesert", "Base.Shoes_ArmyBootsDesert"}
	SurvivorRandomSuits["RareRCR"]["MarinesCamo"] = {"Base.Hat_Army", "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Bag_ALICEpack", "Base.Vest_BulletArmy", "Base.Trousers_CamoGreen", "Base.Shoes_ArmyBoots"}

	SurvivorRandomSuits["RareRCR"]["Bride1F"] = {"Base.WeddingDress", "Base.Shirt_FormalWhite", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Groom1M"] = {"Base.Tie_BowTieFull", "Base.Gloves_WhiteTINT", "Base.WeddingJacket", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Socks_Long", "Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Priest1"] = {"Base.Shirt_Priest", "Base.Trousers_Suit", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["ShopSpiffo1"] = {"Base.Tshirt_BusinessSpiffo", "Base.Apron_Spiffos", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["RareRCR"]["Swimwear1F"] = {"Base.Bikini_Pattern01", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareRCR"]["Swimwear1M"] = {"Base.SwimTrunks_Blue", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareRCR"]["Nurse1"] = {"Base.Hat_SurgicalMask_Blue", "Base.Tshirt_Scrubs", "Base.Trousers_Scrubs", "Base.Socks_Ankle", "Base.Shoes_Black"}

	SurvivorRandomSuits["RareRCR"]["Prepper1"] = {"Base.Hat_GasMask", "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Bandit1"] = {"Base.Hat_BalaclavaFull", "Base.Jacket_Padded", "Base.TrousersMesh_DenimLight", "Base.Tshirt_Rock", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Bandit2"] = {"Base.Hat_BalaclavaFull", "Base.HoodieUP_WhiteTINT", "Base.TrousersMesh_DenimLight", "Tshirt_DefaultDECAL", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Bandit3"] = {"Base.Hat_BalaclavaFull", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRCR"]["RavenCreekPD1"] = {"RavenCreekPDClothes.Hat_Police_RavenCreek", "RavenCreekPDClothes.TShirt_Police_RavenCreek", "RavenCreekPDClothes.Shirt_Police_RavenCreek", "RavenCreekPDClothes.Trousers_Police_RavenCreek", "RavenCreekPDClothes.Jacket_Police_RavenCreek", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["RavenCreekPD2"] = {"RavenCreekPDClothes.Hat_Police_RavenCreek", "RavenCreekPDClothes.TShirt_Police_RavenCreek", "RavenCreekPDClothes.Shirt_Police_RavenCreek", "RavenCreekPDClothes.Trousers_Police_RavenCreek", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["RavenCreekPD3"] = {"RavenCreekPDClothes.Hat_Police_RavenCreek", "RavenCreekPDClothes.TShirt_Police_RavenCreek", "RavenCreekPDClothes.Trousers_Police_RavenCreek", "Base.Shoes_Black"}

	SurvivorRandomSuits["RareRCR"]["Prisoner1"] = {"Base.Boilersuit_Prisoner", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Fireman1"] = {"Base.Hat_Fireman", "Base.Jacket_Fireman", "Base.Trousers_Fireman", "Base.Shoes_BlackBoots"}
end

if(isModEnabled("RavenCreekPDClothes")) and (isModEnabled("STR")) then
--RavenCreek
	SurvivorRandomSuits["RareRCR"]["Army"] = {"Base.Hat_BeretArmy", "Base.Tshirt_ArmyGreen", "Base.Jacket_CoatArmy", "Base.Bag_ALICEpack", "Base.Trousers_ArmyService", "Base.Shoes_ArmyBoots"}
	SurvivorRandomSuits["RareRCR"]["ArmyCamo"] = {"Base.Tshirt_CamoDesert", "Base.Shirt_CamoDesert", "Base.Jacket_ArmyCamoDesert", "Base.Bag_ALICEpack", "Base.Trousers_CamoDesert", "Base.Shoes_ArmyBootsDesert"}
	SurvivorRandomSuits["RareRCR"]["MarinesCamo"] = {"Base.Hat_Army", "Base.Tshirt_CamoGreen", "Base.Shirt_CamoGreen", "Base.Jacket_ArmyCamoGreen", "Base.Bag_ALICEpack", "Base.Vest_BulletArmy", "Base.Trousers_CamoGreen", "Base.Shoes_ArmyBoots"}

	SurvivorRandomSuits["RareRCR"]["Bride1F"] = {"Base.WeddingDress", "Base.Shirt_FormalWhite", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Groom1M"] = {"Base.Tie_BowTieFull", "Base.Gloves_WhiteTINT", "Base.WeddingJacket", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Socks_Long", "Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Priest1"] = {"Base.Shirt_Priest", "Base.Trousers_Suit", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["ShopSpiffo1"] = {"Base.Tshirt_BusinessSpiffo", "Base.Apron_Spiffos", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["RareRCR"]["Swimwear1F"] = {"Base.Bikini_Pattern01", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareRCR"]["Swimwear1M"] = {"Base.SwimTrunks_Blue", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["RareRCR"]["Nurse1"] = {"Base.Hat_SurgicalMask_Blue", "Base.Tshirt_Scrubs", "Base.Trousers_Scrubs", "Base.Socks_Ankle", "Base.Shoes_Black"}

	SurvivorRandomSuits["RareRCR"]["Prepper1"] = {"Base.Hat_GasMask", "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Bandit1"] = {"Base.Hat_BalaclavaFull", "Base.Jacket_Padded", "Base.TrousersMesh_DenimLight", "Base.Tshirt_Rock", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Bandit2"] = {"Base.Hat_BalaclavaFull", "Base.HoodieUP_WhiteTINT", "Base.TrousersMesh_DenimLight", "Tshirt_DefaultDECAL", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Bandit3"] = {"Base.Hat_BalaclavaFull", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRCR"]["RavenCreekPD1"] = {"RavenCreekPDClothes.Hat_Police_RavenCreek", "RavenCreekPDClothes.TShirt_Police_RavenCreek", "RavenCreekPDClothes.Shirt_Police_RavenCreek", "RavenCreekPDClothes.Trousers_Police_RavenCreek", "RavenCreekPDClothes.Jacket_Police_RavenCreek", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRCR"]["RavenCreekPD2"] = {"RavenCreekPDClothes.Hat_Police_RavenCreek", "RavenCreekPDClothes.TShirt_Police_RavenCreek", "RavenCreekPDClothes.Shirt_Police_RavenCreek", "RavenCreekPDClothes.Trousers_Police_RavenCreek", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}
    SurvivorRandomSuits["RareRCR"]["RavenCreekPD3"] = {"RavenCreekPDClothes.Hat_Police_RavenCreek", "RavenCreekPDClothes.TShirt_Police_RavenCreek", "RavenCreekPDClothes.Trousers_Police_RavenCreek", "Base.Shoes_Black", "STR.Belt_PoliceDuty", "STR.Chest_Walkie"}

	--EMS
    SurvivorRandomSuits["RareRCR"]["MeadeCountyEMS1"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "STR.Jacket_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyEMS2"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyEMS3"] = {"STR.Hat_BaseballCap_EMS_Meade", "STR.TShirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyEMS4"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "STR.Jacket_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyEMS5"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Shirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyEMS6"] = {"STR.Hat_BaseballCap_EMS_Meade_Reverse", "STR.TShirt_EMS_Meade", "STR.Trousers_EMS_Meade", "Base.Shoes_Black"}

	SurvivorRandomSuits["RareRCR"]["Prepper1"] = {"Base.Hat_GasMask", "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Bandit1"] = {"Base.Hat_BalaclavaFull", "Base.Jacket_Padded", "Base.TrousersMesh_DenimLight", "Base.Tshirt_Rock", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Bandit2"] = {"Base.Hat_BalaclavaFull", "Base.HoodieUP_WhiteTINT", "Base.TrousersMesh_DenimLight", "Tshirt_DefaultDECAL", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["RareRCR"]["Bandit3"] = {"Base.Hat_BalaclavaFull", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}
	--Prisoners
    SurvivorRandomSuits["RareRCR"]["MeadeCountyPrisoner1"] = {"STR.Boilersuit_MeadeGenPopPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyPrisoner2"] = {"STR.Boilersuit_MeadeLowRiskPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyPrisoner3"] = {"STR.Boilersuit_MeadeMaxPrisoner", "Base.Socks_Long", "Base.Shoes_Black"}
	--Rangers
    SurvivorRandomSuits["RareRCR"]["FederalRanger1"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "STR.Jacket_Federal_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["FederalRanger2"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Shirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["FederalRanger3"] = {"STR.Hat_FederalRanger", "STR.TShirt_Federal_Ranger", "STR.Trousers_FederalRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareRCR"]["StateLawRanger1"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "STR.Jacket_State_LawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["StateLawRanger2"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Shirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["StateLawRanger3"] = {"STR.Hat_StateLawRanger", "STR.TShirt_State_LawRanger", "STR.Trousers_StateLawRanger", "Base.Shoes_Black"}

    SurvivorRandomSuits["RareRCR"]["StateRanger1"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "STR.Jacket_State_Ranger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["StateRanger2"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Shirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["StateRanger3"] = {"STR.Hat_StateRanger", "STR.TShirt_State_Ranger", "STR.Trousers_StateRanger", "Base.Shoes_Black"}
	--Meade County Black
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullB1"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullB2"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullB3"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullB4"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullB5"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullB6"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullB7"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullB8"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullB9"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullB10"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullB11"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullB12"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Black", "STR.Jacket_Fireman_Meade_Black", "Base.Shoes_BlackBoots"}
	--Meade County Khaki
	SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullK1"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullK2"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullK3"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullK4"] = {"STR.Hat_Fireman_Meade_Black", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullK5"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullK6"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullK7"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullK8"] = {"STR.Hat_Fireman_Meade_Red", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}

    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullK9"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanBlue_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullK10"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullK11"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanRed_Meade02", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
    SurvivorRandomSuits["RareRCR"]["MeadeCountyFiremanFullK12"] = {"STR.Hat_Fireman_Meade_Yellow", "STR.TShirt_Profession_FiremanWhite_Meade", "STR.Trousers_Fireman_Meade_Khaki", "STR.Jacket_Fireman_Meade_Khaki", "Base.Shoes_BlackBoots"}
	--USPS
    SurvivorRandomSuits["RareRCR"]["USPS1"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRCR"]["USPS2"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRCR"]["USPS3"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Trousers_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRCR"]["USPS4"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "STR.Jacket_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRCR"]["USPS5"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}
    SurvivorRandomSuits["RareRCR"]["USPS6"] = {"STR.Hat_BaseballCap_USPS", "STR.TShirt_USPS", "STR.Shorts_USPS", "Base.Shoes_Black", "STR.Bag_Satchel_USPS"}

    SurvivorRandomSuits["RareRCR"]["Judge1"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Black"}
    SurvivorRandomSuits["RareRCR"]["Judge2"] = {"STR.Judge_Robe", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Shoes_Brown"}
end
--Vanilla Survivors Outfits
	SurvivorRandomSuits["Rare"]["Bride1F"] = {"Base.WeddingDress", "Base.Shirt_FormalWhite", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["Rare"]["Groom1M"] = {"Base.Tie_BowTieFull", "Base.Gloves_WhiteTINT", "Base.WeddingJacket", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Socks_Long", "Shoes_Black"}
	SurvivorRandomSuits["Rare"]["Priest1"] = {"Base.Shirt_Priest", "Base.Trousers_Suit", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["Rare"]["ShopSpiffo1"] = {"Base.Tshirt_BusinessSpiffo", "Base.Apron_Spiffos", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["Rare"]["Swimwear1F"] = {"Base.Bikini_Pattern01", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["Rare"]["Swimwear1M"] = {"Base.SwimTrunks_Blue", "Base.Shoes_FlipFlop"}
	SurvivorRandomSuits["Rare"]["Nurse1"] = {"Base.Hat_SurgicalMask_Blue", "Base.Tshirt_Scrubs", "Base.Trousers_Scrubs", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["Rare"]["Prepper1"] = {"Base.Hat_GasMask", "Base.HoodieUP_GreenTINT", "Base.Vest_BulletCivilian", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["Rare"]["Bandit1"] = {"Base.Hat_BalaclavaFull", "Base.Jacket_Padded", "Base.TrousersMesh_DenimLight", "Base.Tshirt_Rock", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["Rare"]["Bandit2"] = {"Base.Hat_BalaclavaFull", "Base.HoodieUP_WhiteTINT", "Base.TrousersMesh_DenimLight", "Tshirt_DefaultDECAL", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["Rare"]["Bandit3"] = {"Base.Hat_BalaclavaFull", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}
	SurvivorRandomSuits["Rare"]["Prisoner1"] = {"Base.Boilersuit_Prisoner", "Base.Shoes_Black"}
	SurvivorRandomSuits["Rare"]["Fireman1"] = {"Base.Hat_Fireman", "Base.Jacket_Fireman", "Base.Trousers_Fireman", "Base.Shoes_BlackBoots"}

	SurvivorRandomSuits["Rare"]["Police1"] = {"Base.Hat_Police", "Shirt_PoliceBlue", "Base.Jacket_Police", "Base.Trousers_Police", "Base.Shoes_Black"}
	SurvivorRandomSuits["Rare"]["Deputy1"] = {"Base.Hat_Police_Grey", "Shirt_PoliceGrey", "Base.Jacket_Police", "Base.Trousers_PoliceGrey", "Base.Shoes_Black"}

	SurvivorRandomSuits["Normal"]["Hunter1"] = {"Base.Hat_BonnieHat_CamoGreen", "Base.Vest_Hunting_Camo", "Base.Trousers_CamoGreen", "Base.Shoes_BlackBoots"}
	SurvivorRandomSuits["Normal"]["ShopGeneric1"] = {"Base.Tshirt_DefaultDECAL", "Base.Apron_Black", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["Normal"]["Athlete1"] = {"Base.Shorts_ShortSport", "Base.Tshirt_Sport", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["Normal"]["Worker1"] = {"Base.Shirt_Workman", "Base.Vest_HighViz", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["Normal"]["Student1"] = {"Base.Shorts_ShortSport", "Base.Tshirt_Sport", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["Normal"]["Student2"] = {"Base.Tshirt_DefaultDECAL", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT", "Base.Jacket_Varsity"}
	SurvivorRandomSuits["Normal"]["Office1M"] = {"Base.Tie_Full", "Base.Shirt_FormalWhite", "Base.Trousers_Suit", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["Normal"]["Office1F"] = {"Base.Shirt_FormalWhite", "Base.Skirt_Normal", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["Normal"]["Biker1"] = {"Base.Hat_Bandana", "Base.Glasses_Aviators", "Base.Jacket_Black", "Base.Tshirt_Rock", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["Normal"]["Generic1F"] = {"Base.Dress_Normal", "Base.Socks_Ankle", "Base.Shoes_Black"}
	SurvivorRandomSuits["Normal"]["Generic2F"] = {"Base.Hat_Beret", "Base.Dress_Knees", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["Normal"]["Generic3F"] = {"Base.Dress_Long", "Base.Socks_Long", "Base.Shoes_Black"}

	SurvivorRandomSuits["Common"]["Generic4F"] = {"Base.Skirt_Normal", "Base.Tshirt_DefaultTEXTURE", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["Common"]["Generic5F"] = {"Base.Skirt_Knees", "Base.Tshirt_DefaultTEXTURE", "Base.Socks_Long", "Base.Shoes_Black", "Base.Hat_Beret"}
	SurvivorRandomSuits["Common"]["Generic6F"] = {"Base.Skirt_Long", "Base.Tshirt_DefaultTEXTURE", "Base.Socks_Long", "Base.Shoes_Black"}
	SurvivorRandomSuits["Common"]["Generic1M"] = {"Base.HoodieDOWN_GreyTINT", "Base.Tshirt_Rock", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["Common"]["Generic2M"] = {"Base.Tshirt_DefaultDECAL", "Base.Jumper_DiamondPatternTINT", "Base.Glasses_Normal", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["Common"]["Generic3M"] = {"Base.Jumper_RoundNeck", "Base.Tshirt_Rock", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["Common"]["Generic4M"] = {"Base.Tshirt_DefaultDECAL", "Base.TrousersMesh_DenimLight", "Base.Socks_Ankle", "Base.Shoes_TrainerTINT"}
	SurvivorRandomSuits["Common"]["Basic1"] = {"Base.Hat_BaseballCapBlue", "Base.Shirt_HawaiianRed", "Base.TrousersMesh_DenimLight", "Base.Shoes_Black"}


local clothingTable1 = {}
local clothingTable2 = {}
local clothingTable3 = {}
local clothingTable4 = {}
local clothingTable5 = {}
local clothingTable6 = {}
local clothingTable7 = {}
local clothingTable8 = {}
local clothingTable9 = {}
local clothingTable10 = {}

local clothingTable1m = {}
local clothingTable2m = {}
local clothingTable3m = {}
local clothingTable4m = {}
local clothingTable5m = {}
local clothingTable6m = {}
local clothingTable7m = {}
local clothingTable8m = {}
local clothingTable9m = {}
local clothingTable10m = {}

local clothingTable1f = {}
local clothingTable2f = {}
local clothingTable3f = {}
local clothingTable4f = {}
local clothingTable5f = {}
local clothingTable6f = {}
local clothingTable7f = {}
local clothingTable8f = {}
local clothingTable9f = {}
local clothingTable10f = {}

local function SS_StringToTable1(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable1, w)
	end
end
local function SS_StringToTable2(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable2, w)
	end
end
local function SS_StringToTable3(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable3, w)
	end
end
local function SS_StringToTable4(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable4, w)
	end
end
local function SS_StringToTable5(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable5, w)
	end
end
local function SS_StringToTable6(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable6, w)
	end
end
local function SS_StringToTable7(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable7, w)
	end
end
local function SS_StringToTable8(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable8, w)
	end
end
local function SS_StringToTable9(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable9, w)
	end
end
local function SS_StringToTable10(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable10, w)
	end
end

local function SS_StringToTable1m(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable1m, w)
	end
end
local function SS_StringToTable2m(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable2m, w)
	end
end
local function SS_StringToTable3m(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable3m, w)
	end
end
local function SS_StringToTable4m(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable4m, w)
	end
end
local function SS_StringToTable5m(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable5m, w)
	end
end
local function SS_StringToTable6m(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable6m, w)
	end
end
local function SS_StringToTable7m(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable7m, w)
	end
end
local function SS_StringToTable8m(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable8m, w)
	end
end
local function SS_StringToTable9m(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable9m, w)
	end
end
local function SS_StringToTable10m(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable10m, w)
	end
end

local function SS_StringToTable1f(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable1f, w)
	end
end
local function SS_StringToTable2f(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable2f, w)
	end
end
local function SS_StringToTable3f(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable3f, w)
	end
end
local function SS_StringToTable4f(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable4f, w)
	end
end
local function SS_StringToTable5f(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable5f, w)
	end
end
local function SS_StringToTable6f(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable6f, w)
	end
end
local function SS_StringToTable7f(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable7f, w)
	end
end
local function SS_StringToTable8f(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable8f, w)
	end
end
local function SS_StringToTable9f(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable9f, w)
	end
end
local function SS_StringToTable10f(string)
	for w in (string .. ";"):gmatch("([^;]*);") do
		table.insert(clothingTable10f, w)
	end
end

local function SS_CustomSetup()

	local sbVars1 = SandboxVars.SuperiorSubparSurvivors.custom1
	local sbVars2 = SandboxVars.SuperiorSubparSurvivors.custom2
	local sbVars3 = SandboxVars.SuperiorSubparSurvivors.custom3
	local sbVars4 = SandboxVars.SuperiorSubparSurvivors.custom4
	local sbVars5 = SandboxVars.SuperiorSubparSurvivors.custom5
	local sbVars6 = SandboxVars.SuperiorSubparSurvivors.custom6
	local sbVars7 = SandboxVars.SuperiorSubparSurvivors.custom7
	local sbVars8 = SandboxVars.SuperiorSubparSurvivors.custom8
	local sbVars9 = SandboxVars.SuperiorSubparSurvivors.custom9
	local sbVars10 = SandboxVars.SuperiorSubparSurvivors.custom10

	local sbVars1m = SandboxVars.SuperiorSubparSurvivors.custom1m
	local sbVars2m = SandboxVars.SuperiorSubparSurvivors.custom2m
	local sbVars3m = SandboxVars.SuperiorSubparSurvivors.custom3m
	local sbVars4m = SandboxVars.SuperiorSubparSurvivors.custom4m
	local sbVars5m = SandboxVars.SuperiorSubparSurvivors.custom5m
	local sbVars6m = SandboxVars.SuperiorSubparSurvivors.custom6m
	local sbVars7m = SandboxVars.SuperiorSubparSurvivors.custom7m
	local sbVars8m = SandboxVars.SuperiorSubparSurvivors.custom8m
	local sbVars9m = SandboxVars.SuperiorSubparSurvivors.custom9m
	local sbVars10m = SandboxVars.SuperiorSubparSurvivors.custom10m

	local sbVars1f = SandboxVars.SuperiorSubparSurvivors.custom1f
	local sbVars2f = SandboxVars.SuperiorSubparSurvivors.custom2f
	local sbVars3f = SandboxVars.SuperiorSubparSurvivors.custom3f
	local sbVars4f = SandboxVars.SuperiorSubparSurvivors.custom4f
	local sbVars5f = SandboxVars.SuperiorSubparSurvivors.custom5f
	local sbVars6f = SandboxVars.SuperiorSubparSurvivors.custom6f
	local sbVars7f = SandboxVars.SuperiorSubparSurvivors.custom7f
	local sbVars8f = SandboxVars.SuperiorSubparSurvivors.custom8f
	local sbVars9f = SandboxVars.SuperiorSubparSurvivors.custom9f
	local sbVars10f = SandboxVars.SuperiorSubparSurvivors.custom10f

	SS_StringToTable1(sbVars1)
	SS_StringToTable2(sbVars2)
	SS_StringToTable3(sbVars3)
	SS_StringToTable4(sbVars4)
	SS_StringToTable5(sbVars5)
	SS_StringToTable6(sbVars6)
	SS_StringToTable7(sbVars7)
	SS_StringToTable8(sbVars8)
	SS_StringToTable9(sbVars9)
	SS_StringToTable10(sbVars10)

	SS_StringToTable1m(sbVars1m)
	SS_StringToTable2m(sbVars2m)
	SS_StringToTable3m(sbVars3m)
	SS_StringToTable4m(sbVars4m)
	SS_StringToTable5m(sbVars5m)
	SS_StringToTable6m(sbVars6m)
	SS_StringToTable7m(sbVars7m)
	SS_StringToTable8m(sbVars8m)
	SS_StringToTable9m(sbVars9m)
	SS_StringToTable10m(sbVars10m)

	SS_StringToTable1f(sbVars1f)
	SS_StringToTable2f(sbVars2f)
	SS_StringToTable3f(sbVars3f)
	SS_StringToTable4f(sbVars4f)
	SS_StringToTable5f(sbVars5f)
	SS_StringToTable6f(sbVars6f)
	SS_StringToTable7f(sbVars7f)
	SS_StringToTable8f(sbVars8f)
	SS_StringToTable9f(sbVars9f)
	SS_StringToTable10f(sbVars10f)

	if sbVars1:contains(".") then
		SurvivorRandomSuits["Common"]["Custom1"] = clothingTable1
	end
	if sbVars2:contains(".") then
		SurvivorRandomSuits["Common"]["Custom2"] = clothingTable2
	end
	if sbVars3:contains(".") then
		SurvivorRandomSuits["Common"]["Custom3"] = clothingTable3
	end
	if sbVars4:contains(".") then
		SurvivorRandomSuits["Common"]["Custom4"] = clothingTable4
	end
	if sbVars5:contains(".") then
		SurvivorRandomSuits["Common"]["Custom5"] = clothingTable5
	end
	if sbVars6:contains(".") then
		SurvivorRandomSuits["Common"]["Custom6"] = clothingTable6
	end
	if sbVars7:contains(".") then
		SurvivorRandomSuits["Common"]["Custom7"] = clothingTable7
	end
	if sbVars8:contains(".") then
		SurvivorRandomSuits["Common"]["Custom8"] = clothingTable8
	end
	if sbVars9:contains(".") then
		SurvivorRandomSuits["Common"]["Custom9"] = clothingTable9
	end
	if sbVars10:contains(".") then
		SurvivorRandomSuits["Common"]["Custom10"] = clothingTable10
	end

	if sbVars1m:contains(".") then
		SurvivorRandomSuits["Common"]["Custom1M"] = clothingTable1m
	end
	if sbVars2m:contains(".") then
		SurvivorRandomSuits["Common"]["Custom2M"] = clothingTable2m
	end
	if sbVars3m:contains(".") then
		SurvivorRandomSuits["Common"]["Custom3M"] = clothingTable3m
	end
	if sbVars4m:contains(".") then
		SurvivorRandomSuits["Common"]["Custom4M"] = clothingTable4m
	end
	if sbVars5m:contains(".") then
		SurvivorRandomSuits["Common"]["Custom5M"] = clothingTable5m
	end
	if sbVars6m:contains(".") then
		SurvivorRandomSuits["Common"]["Custom6M"] = clothingTable6m
	end
	if sbVars7m:contains(".") then
		SurvivorRandomSuits["Common"]["Custom7M"] = clothingTable7m
	end
	if sbVars8m:contains(".") then
		SurvivorRandomSuits["Common"]["Custom8M"] = clothingTable8m
	end
	if sbVars9m:contains(".") then
		SurvivorRandomSuits["Common"]["Custom9M"] = clothingTable9m
	end
	if sbVars10m:contains(".") then
		SurvivorRandomSuits["Common"]["Custom10M"] = clothingTable10m
	end

	if sbVars1f:contains(".") then
		SurvivorRandomSuits["Common"]["Custom1F"] = clothingTable1f
	end
	if sbVars2f:contains(".") then
		SurvivorRandomSuits["Common"]["Custom2F"] = clothingTable2f
	end
	if sbVars3f:contains(".") then
		SurvivorRandomSuits["Common"]["Custom3F"] = clothingTable3f
	end
	if sbVars4f:contains(".") then
		SurvivorRandomSuits["Common"]["Custom4F"] = clothingTable4f
	end
	if sbVars5f:contains(".") then
		SurvivorRandomSuits["Common"]["Custom5F"] = clothingTable5f
	end
	if sbVars6f:contains(".") then
		SurvivorRandomSuits["Common"]["Custom6F"] = clothingTable6f
	end
	if sbVars7f:contains(".") then
		SurvivorRandomSuits["Common"]["Custom7F"] = clothingTable7f
	end
	if sbVars8f:contains(".") then
		SurvivorRandomSuits["Common"]["Custom8F"] = clothingTable8f
	end
	if sbVars9f:contains(".") then
		SurvivorRandomSuits["Common"]["Custom9F"] = clothingTable9f
	end
	if sbVars10f:contains(".") then
		SurvivorRandomSuits["Common"]["Custom10F"] = clothingTable10f
	end
end

Events.OnNewGame.Add(SS_CustomSetup)
--Edits End



function table.randFrom( t )
   local keys = {}
    for key, value in pairs(t) do
        keys[#keys+1] = key --Store keys in another table
    end
	local key = ZombRand(1, #keys)
    index = keys[key]
	--return t[index]
	return index
end

function getRandomSurvivorSuit(SS)

	local roll = ZombRand(1,100)
	local tempTable = nil
	local randomize = false

--Edits
	if (isModEnabled("STR")) then
		-- Coord Stuff
		-- 1 is Xmin
		-- 2 is XMax
		-- 3 is YMin
		-- 4 is YMax
		-- Rosewood
		local Rosewood = {};
		Rosewood[1] = 7865;
		Rosewood[2] = 9350;
		Rosewood[3] = 11250;
		Rosewood[4] = 13500;
		-- Riverside
		local Riverside = {};
		Riverside[1] = 3400;
		Riverside[2] = 7500;
		Riverside[3] = 5150;
		Riverside[4] = 6800;
		-- Muldraugh
		local Muldraugh = {};
		Muldraugh[1] = 9800;
		Muldraugh[2] = 11300;
		Muldraugh[3] = 8800;
		Muldraugh[4] = 11150;
		-- WestPoint
		local WestPoint = {};
		WestPoint[1] = 10700;
		WestPoint[2] = 12200;
		WestPoint[3] = 6500;
		WestPoint[4] = 7300;
		-- JeffersonCountySD1
		local JCSD1 = {};
		JCSD1[1] = 12891;
		JCSD1[2] = 14800;
		JCSD1[3] = 2200;
		JCSD1[4] = 2690;
		-- JeffersonCountySD2
		local JCSD2 = {};
		JCSD2[1] = 13771;
		JCSD2[2] = 14800;
		JCSD2[3] = 2691;
		JCSD2[4] = 3440;
		-- JeffersonCountySD3
		local JCSD3 = {};
		JCSD3[1] = 13041;
		JCSD3[2] = 14800;
		JCSD3[3] = 3441;
		JCSD3[4] = 7460;
		-- JeffersonCountyPD1
		local JCPD1 = {};
		JCPD1[1] = 12901;
		JCPD1[2] = 13770;
		JCPD1[3] = 2691;
		JCPD1[4] = 3440;
		-- JeffersonCountyPD2
		local JCPD2 = {};
		JCPD2[1] = 12901;
		JCPD2[2] = 13040;
		JCPD2[3] = 2691;
		JCPD2[4] = 3865;
		-- LouisvillePD1
		local LPD1 = {};
		LPD1[1] = 11900;
		LPD1[2] = 12900;
		LPD1[3] = 900;
		LPD1[4] = 2190;
		-- LouisvillePD2
		local LPD2 = {};
		LPD2[1] = 11900;
		LPD2[2] = 12900;
		LPD2[3] = 2191;
		LPD2[4] = 2690;
		-- LouisvillePD3
		local LPD3 = {};
		LPD3[1] = 11900;
		LPD3[2] = 12660;
		LPD3[3] = 2691;
		LPD3[4] = 3890;
		-- RavenCreek
		local RCR = {};
		RCR[1] = 3000;
		RCR[2] = 5500;
		RCR[3] = 11001;
		RCR[4] = 13500;

		--Assign Tables Based On Coordinate Ranges
		if (SS:getX() >= Rosewood[1]) and (SS:getX() <= Rosewood[2]) and (SS:getY() >= Rosewood[3]) and (SS:getY() <= Rosewood[4]) then
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareRW"]
			elseif(roll <= 20) then --  choose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --choose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		elseif (SS:getX() >= Riverside[1]) and (SS:getX() <= Riverside[2]) and (SS:getY() >= Riverside[3]) and (SS:getY() <= Riverside[4]) then
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareRS"]
			elseif(roll <= 20) then --  choose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --choose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		elseif (SS:getX() >= Muldraugh[1]) and (SS:getX() <= Muldraugh[2]) and (SS:getY() >= Muldraugh[3]) and (SS:getY() <= Muldraugh[4]) then
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareMD"]
			elseif(roll <= 20) then --  choose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --choose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		elseif (SS:getX() >= WestPoint[1]) and (SS:getX() <= WestPoint[2]) and (SS:getY() >= WestPoint[3]) and (SS:getY() <= WestPoint[4]) then
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareWP"]
			elseif(roll <= 20) then --  choose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --choose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		elseif (SS:getX() >= LPD1[1]) and (SS:getX() <= LPD1[2]) and (SS:getY() >= LPD1[3]) and (SS:getY() <= LPD1[4]) then
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareLV"]
			elseif(roll <= 20) then --  choose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --choose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		elseif (SS:getX() >= LPD2[1]) and (SS:getX() <= LPD2[2]) and (SS:getY() >= LPD2[3]) and (SS:getY() <= LPD2[4]) then
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareLV"]
			elseif(roll <= 20) then --  choose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --choose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		elseif (SS:getX() >= LPD3[1]) and (SS:getX() <= LPD3[2]) and (SS:getY() >= LPD3[3]) and (SS:getY() <= LPD3[4]) then
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareLV"]
			elseif(roll <= 20) then --  choose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --choose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		elseif (SS:getX() >= JCPD1[1]) and (SS:getX() <= JCPD1[2]) and (SS:getY() >= JCPD1[3]) and (SS:getY() <= JCPD1[4]) then
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareJCPD"]
			elseif(roll <= 20) then --  choose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --choose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		elseif (SS:getX() >= JCPD2[1]) and (SS:getX() <= JCPD2[2]) and (SS:getY() >= JCPD2[3]) and (SS:getY() <= JCPD2[4]) then
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareJCPD"]
			elseif(roll <= 20) then --  choose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --choose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		elseif (SS:getX() >= JCSD1[1]) and (SS:getX() <= JCSD1[2]) and (SS:getY() >= JCSD1[3]) and (SS:getY() <= JCSD1[4]) then
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareJCSD"]
			elseif(roll <= 20) then --  choose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --choose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		elseif (SS:getX() >= JCSD2[1]) and (SS:getX() <= JCSD2[2]) and (SS:getY() >= JCSD2[3]) and (SS:getY() <= JCSD2[4]) then
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareJCSD"]
			elseif(roll <= 20) then --  choose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --choose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		elseif (SS:getX() >= JCSD3[1]) and (SS:getX() <= JCSD3[2]) and (SS:getY() >= JCSD3[3]) and (SS:getY() <= JCSD3[4]) then
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareJCSD"]
			elseif(roll <= 20) then --  choose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --choose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		elseif (SS:getX() >= RCR[1]) and (SS:getX() <= RCR[2]) and (SS:getY() >= RCR[3]) and (SS:getY() <= RCR[4]) then
			if(isModEnabled("RavenCreekPDClothes")) then
				if(roll <= 10) then -- choose rare suit
					print("Rare suit:")
					tempTable = SurvivorRandomSuits["RareRCR"]
				elseif(roll <= 20) then --  choose normal suit
					print("Normal suit:")
					tempTable = SurvivorRandomSuits["Normal"]
				else --choose common suit
					print("Common suit:")
					tempTable = SurvivorRandomSuits["Common"]
					randomize = false
				end
			end
		else
			if(roll <= 10) then -- choose rare suit
				print("Rare suit:")
				tempTable = SurvivorRandomSuits["RareMC"]
			elseif(roll <= 20) then --  chose normal suit
				print("Normal suit:")
				tempTable = SurvivorRandomSuits["Normal"]
			else --chose common suit
				print("Common suit:")
				tempTable = SurvivorRandomSuits["Common"]
				randomize = false
			end
		end
	end

	if not (isModEnabled("STR")) then

		if(roll <= 10) then -- choose rare suit
			print("Rare suit:")
			tempTable = SurvivorRandomSuits["Rare"]
		elseif(roll <= 20) then --  choose normal suit
			print("Normal suit:")
			tempTable = SurvivorRandomSuits["Normal"]
		else --choose common suit
			print("Common suit:")
			tempTable = SurvivorRandomSuits["Common"]
			randomize = true
		end
	end
--Edits End

	--print(tostring(size(tempTable)).." total suits in category.")
    --for key, value in pairs(tempTable) do
	--	print(key)
	--end
	local result = table.randFrom(tempTable)

	while (string.sub(result, -1) == "F" and not SS.player:isFemale()) or (string.sub(result, -1) == "M" and SS.player:isFemale()) do
		print("Wrong gender " .. result .. " (it's only 1993 and KY isn't woke yet)")
		result = table.randFrom(tempTable)
	end
	print("random key result is: "..tostring(result))

	local suitTable = tempTable[result]
	for i=1, #suitTable do
		if(suitTable[i] ~= nil) then
			print("WearThis: " .. tostring(suitTable[i]))
			SS:WearThis(suitTable[i])
		end
	end

	if randomize then
		for i=1, ZombRand(0, 3) do
			tempTable = SurvivorRandomSuits[table.randFrom(SurvivorRandomSuits)]
			local result = table.randFrom(tempTable)
			local suitTable = tempTable[result]
			item = suitTable[ZombRand(1, #suitTable)]
			print("WearThis randomize: " .. item)
			SS:WearThis(item)
		end
	end

end

function setRandomSurvivorSuit(SS,tbl,name)

	local suitTable = SurvivorRandomSuits[tbl][name]
	if suitTable then
		for i=1,#suitTable do
			if(suitTable[i] ~= nil) then
				print("WearThis: " .. tostring(suitTable[i]))
				SS:WearThis(suitTable[i])
			end
		end
	end

end

function print_r ( t )
    local print_r_cache={}
    local function sub_print_r(t,indent)
        if (print_r_cache[tostring(t)]) then
            print(indent.."*"..tostring(t))
        else
            print_r_cache[tostring(t)]=true
            if (type(t)=="table") then
                for pos,val in pairs(t) do
                    if (type(val)=="table") then
                        print(indent.."["..pos.."] => "..tostring(t).." {")
                        sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                        print(indent..string.rep(" ",string.len(pos)+6).."}")
                    elseif (type(val)=="string") then
                        print(indent.."["..pos..'] => "'..val..'"')
                    else
                        print(indent.."["..pos.."] => "..tostring(val))
                    end
                end
            else
                print(indent..tostring(t))
            end
        end
    end
    if (type(t)=="table") then
        print(tostring(t).." {")
        sub_print_r(t,"  ")
        print("}")
    else
        sub_print_r(t,"  ")
    end
    print()
end

-- Creates a spiral around a point to get squares in order of proximity for searching nearby
SpiralSearch = {}
--SpiralSearch.__index = SpiralSearch

function SpiralSearch:new(x, y, range)
	local o = {}
	setmetatable(o, self)
	--self.__index = self

	o.x = math.floor(x)
	o.y = math.floor(y)

	o.ix = 0
	o.iy = 0
	o.deltax = 0
	o.deltay = -1
	o.width = range * 2
	o.height = range * 2

	return o
end

function SpiralSearch:forMax()
	return math.max(self.width, self.height) ^ 2
end

function SpiralSearch:getX()
	return self.x + self.ix
end

function SpiralSearch:getY()
	return self.y + self.iy
end

function SpiralSearch:next()
	if (self.ix == self.iy
	or (self.ix < 0 and self.ix == 0-self.iy)
	or (self.ix > 0 and self.ix == 1-self.iy)) then
		-- change direction
		local dx = 0-self.deltay
		local dy = self.deltax
		self.deltax = dx
		self.deltay = dy
	end

	self.ix = self.ix + self.deltax;
	self.iy = self.iy + self.deltay;
end