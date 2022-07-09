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

---@alias color
---| "White" 
---| "Grey" 
---| "Blond" 
---| "Sand" 
---| "Hazel" 
---| "Brown" 
---| "Red" 	
---| "Pink" 
---| "Purple"
---| "Blue" 
---| "Black" 

--- gets a preset color value
---@param color color
function getPresetColor(color)

	if color 			== "White" 	then return ImmutableColor.new(0.75,0.74,0.72)
	elseif color 	== "Grey" 	then return mmutableColor.new(0.48,0.47,0.44)
	elseif color 	== "Blond" 	then return ImmutableColor.new(0.82,0.82,0.39)
	elseif color 	== "Sand" 	then return ImmutableColor.new(0.86,0.78,0.66)
	elseif color 	== "Hazel" 	then return ImmutableColor.new(0.61,0.50,0.34)
	elseif color 	== "Brown" 	then return ImmutableColor.new(0.62,0.42,0.17)
	elseif color 	== "Red" 		then return ImmutableColor.new(0.58,0.25,0.25)
	elseif color 	== "Pink" 	then return ImmutableColor.new(0.59,0.39,0.55)
	elseif color 	== "Purple" then return ImmutableColor.new(0.47,0.43,0.59)
	elseif color 	== "Blue" 	then return ImmutableColor.new(0.39,0.47,0.59)
	elseif color 	== "Black" 	then return ImmutableColor.new(0.10,0.08,0.09)
	else return ImmutableColor.new(0.99,0.99,0.99)
	end

end

--- gets a speech text
---@param key string key of the speech
---@return string a survivor speech
function getSpeech(key)
	if(not SurvivorSpeechTable[key]) then 
		return "?" 
	end
	
	local result = ZombRand(1,#SurvivorSpeechTable[key]);
	return tostring(SurvivorSpeechTable[key][result]);
end

---@alias	gender
---| "GirlNames"
---| "BoyNames"

--- gets a survivor name
---@param key gender key of the name
---@return string a random survivor name
function getName(key)
	if(not SurvivorNameTable[key]) then 
		return "?" 
	end
	
	local result = ZombRand(1,#SurvivorNameTable[key]);
	return tostring(SurvivorNameTable[key][result]);
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

--- Gets a random perk
---@return string a random perk name
function getAPerk()
  local result = ZombRand(size(SurvivorPerks)-1)+1;
  return SurvivorPerks[result];
end

--- gets the size of a table
---@param a table
---@return integer returns the size of the table
function size(a)
	local i = 1
	 	while a[i] do
			i = i + 1
	 	end
 	return i;
end

--- checks if the table contains a value
---@param tab table table to be searched
---@param val any value to be searched
---@return boolean returns true if the value exists in the table
function has_value (tab, val)
	if(tab ~= nil) and (val ~= nil) then

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

--- gets the square where the mouse is empty
---@return any returns the a square
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

--- gets the world Y position of the mouse
---@return number returns the Y position
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

--- gets the world X position of the mouse
---@return number returns the X position
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
