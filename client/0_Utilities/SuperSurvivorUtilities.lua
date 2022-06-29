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
	"Survivalist"
}


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

function AbsoluteValue(value)
	if(value >= 0) then 
		return value;
	else 
		return (value * -1);
	end
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

function print_r ( t )
   -- local print_r_cache={}
   -- local function sub_print_r(t,indent)
   --     if (print_r_cache[tostring(t)]) then
   --     --    print(indent.."*"..tostring(t))
   --     else
   --         print_r_cache[tostring(t)]=true
   --         if (type(t)=="table") then
   --             for pos,val in pairs(t) do
   --                 if (type(val)=="table") then
   --                     print(indent.."["..pos.."] => "..tostring(t).." {")
   --                     sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
   --                     print(indent..string.rep(" ",string.len(pos)+6).."}")
   --                 elseif (type(val)=="string") then
   --                     print(indent.."["..pos..'] => "'..val..'"')
   --                 else
   --                     print(indent.."["..pos.."] => "..tostring(val))
   --                 end
   --             end
   --         else
   --             print(indent..tostring(t))
   --         end
   --     end
   -- end
   -- if (type(t)=="table") then
   --     print(tostring(t).." {")
   --     sub_print_r(t,"  ")
   --     print("}")
   -- else
   --     sub_print_r(t,"  ")
   -- end
   -- print()
end
