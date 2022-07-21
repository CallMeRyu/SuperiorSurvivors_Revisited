require "ISUI/ISLayoutManager"
local ThePVPButton = ISButton:derive("ThePVPButton");


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

function SurvivorTogglePVP()
	
	if(IsoPlayer.getCoopPVP() == true) then
		getSpecificPlayer(0):Say(getContextMenuText("PVPDisabled"));
		IsoPlayer.setCoopPVP(false);		
		getSpecificPlayer(0):getModData().PVP = false;
		PVPDefault = false;
		PVPButton:setImage(PVPTextureOff)
	elseif(IsoPlayer.getCoopPVP() == false) then
		
		IsoPlayer.setCoopPVP(true);	
		if(ForcePVPOn ~= true) then
			getSpecificPlayer(0):getModData().PVP = true;
			PVPDefault = true;
			getSpecificPlayer(0):Say(getContextMenuText("PVPEnabled"));
		else
			getSpecificPlayer(0):Say(getContextMenuText("PVPForced"));
		end
		ForcePVPOn = false;
		PVPButton:setImage(PVPTextureOn)
	end
end

function SurvivorsCreatePVPButton()
	PVPTextureOn = getTexture("media/textures/PVPOn.png");
	PVPTextureOff = getTexture("media/textures/PVPOff.png");
	
	if(not PVPTextureOff) then print("could not load media/textures/PVPOff.png"); 
	else print("Succesfully load media/textures/PVPOff.png"); end
		
	PVPButton = ThePVPButton:new(getCore():getScreenWidth() - 100, getCore():getScreenHeight() - 50, 25, 25, "", nil, SurvivorTogglePVP);
	PVPButton:setImage(PVPTextureOff);	
	PVPButton:setVisible(true);
	PVPButton:setEnable(true);
	--PVPButton.textureColor.r = 255;
	PVPButton:addToUIManager();
	
end


