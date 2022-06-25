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
end

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

	if(roll <= 10) then -- choose rare suit
		print("Rare suit:")
		tempTable = SurvivorRandomSuits["Rare"]
	elseif(roll <= 20) then --  chose normal suit
		print("Normal suit:")
		tempTable = SurvivorRandomSuits["Normal"]
	else --chose common suit
		print("Common suit:")
		tempTable = SurvivorRandomSuits["Common"]
		randomize = true
	end

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