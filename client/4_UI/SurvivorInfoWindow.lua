require "ISUI/ISLayoutManager"

SurvivorInfoWindow = ISCollapsableWindow:derive("SurvivorInfoWindow");

function CallButtonPressed()
	local GID = SSM:Get(0):getGroupID()
	local members = SSGM:Get(GID):getMembers()
	local selected = tonumber(myGroupWindow:getSelected())
	local member = members[selected]
	if(member) then 
		getSpecificPlayer(0):Say(getText("ContextMenu_SD_CallName_Before") .. member:getName()..getText("ContextMenu_SD_CallName_After"))
		member:getTaskManager():AddToTop(ListenTask:new(member,getSpecificPlayer(0),false)) 
	end
end

function SurvivorInfoWindow:initialise()
	ISCollapsableWindow.initialise(self);
end

function SurvivorInfoWindow:new(x, y, width, height)
	local o = {};
	o = ISCollapsableWindow:new(x, y, width, height);
	setmetatable(o, self);
	self.__index = self;
	o.title = getText("ContextMenu_SD_SurvivorInfo");
	o.pin = false;
	o:noBackground();
	return o;
end

function SurvivorInfoWindow:setText(newText)
	self.HomeWindow.text = newText;
	self.HomeWindow:paginate();
end


function SurvivorInfoWindow:createChildren()

	local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
	self.HomeWindow = ISRichTextPanel:new(0, FONT_HGT_SMALL + 1, FONT_HGT_SMALL * 6 + 200, FONT_HGT_SMALL * 10 + 500);
	self.HomeWindow:initialise();
	self.HomeWindow.autosetheight = false
	self.HomeWindow:ignoreHeightChange()
	self:addChild(self.HomeWindow)
	
	self.MyCallButton = ISButton:new(FONT_HGT_SMALL * 7 + 30, FONT_HGT_SMALL + 13, 60, 25, getText("ContextMenu_SD_CallOver"), self, CallButtonPressed);		
	
	self.MyCallButton:setEnable(true);
	self.MyCallButton:initialise();
	--MyCallButton.textureColor.r = 255;
	self.MyCallButton:addToUIManager();
	self:addChild(self.MyCallButton)
	
	self.MyCallButton:setVisible(true);
	
	
	
	ISCollapsableWindow.createChildren(self);
end

function SurvivorInfoWindow:Load(ASuperSurvivor)
	
	local newText = getText("ContextMenu_SD_SurvivorInfoName_Before") .. ASuperSurvivor:getName() .. getText("ContextMenu_SD_SurvivorInfoName_After") .. "\n"
	local player = ASuperSurvivor:Get()
	newText = newText .. "(" .. tostring(ASuperSurvivor:getGroupRole()) .. "/" .. ASuperSurvivor:getCurrentTask() .. ")" .. "\n\n"
	
	for i=1, size(SurvivorPerks) do 
		player:getModData().PerkCount = i;
		level = player:getPerkLevel(Perks.FromString(SurvivorPerks[i]));
		if (level ~= nil) and (SurvivorPerks[i] ~= nil) and (level > 0) then 
			local display_perk = PerkFactory.getPerkName(Perks.FromString(SurvivorPerks[i]))
			--if( string.match(SurvivorPerks[i], "Blade") ) or ( SurvivorPerks[i] == "Axe" ) then
			--	display_perk = getText("IGUI_perks_Blade") .. " " .. display_perk
			--elseif( string.match(SurvivorPerks[i], "Blunt") ) then
			--	display_perk = getText("IGUI_perks_Blunt") .. " " .. display_perk
			--else
			
			--end
			--display_perk = display_perk .. " ("..SurvivorPerks[i]..")"
			if display_perk == nil then
				display_perk = tostring(SurvivorPerks[i]) .. "?"
			end
			
			newText = newText .. getText("ContextMenu_SD_Level") .. " " .. tostring(level) .. " " .. display_perk .. "\n" ----getText("IGUI_perks_"..SurvivorPerks[i]) .. "\n" 
		end						
	end
	
	newText = newText .. "\n"
	
	newText = newText .. getText("Tooltip_food_Hunger")..": " .. tostring(math.floor((player:getStats():getHunger()*100)))  .. "\n"
	newText = newText .. getText("Tooltip_food_Thirst")..": " .. tostring(math.floor((player:getStats():getThirst()*100)))  .. "\n"
	newText = newText .. "Morale: " .. tostring(math.floor(player:getStats():getMorale()*100))  .. "\n"
	newText = newText .. "Sanity: " .. tostring(math.floor(player:getStats():getSanity()*100))  .. "\n"
	newText = newText .. getText("Tooltip_food_Boredom")..": " .. tostring(math.floor(player:getStats():getBoredom()*100))  .. "\n"
	newText = newText .. "IdleBoredom: " .. tostring(math.floor(player:getStats():getIdleboredom()*100))  .. "\n"
	newText = newText .. getText("Tooltip_food_Unhappiness")..": " .. tostring(math.floor(player:getBodyDamage():getUnhappynessLevel()*100))  .. "\n"
	newText = newText .. getText("Tooltip_Wetness")..": " .. tostring(math.floor(player:getBodyDamage():getWetness()*100))  .. "\n"
	newText = newText .. getText("Tooltip_clothing_dirty")..": " .. tostring(math.floor(ASuperSurvivor:getFilth()*100))  .. "\n"
	

	newText = newText .. "\n"
	local melewepName = getText("ContextMenu_SD_Nothing")
	local gunwepName = getText("ContextMenu_SD_Nothing")
	if(ASuperSurvivor.LastMeleUsed ~= nil) then melewepName = ASuperSurvivor.LastMeleUsed:getDisplayName() end
	if(ASuperSurvivor.LastGunUsed ~= nil) then gunwepName = ASuperSurvivor.LastGunUsed:getDisplayName() end
	local phi
	if(player:getPrimaryHandItem() ~= nil) then phi = player:getPrimaryHandItem():getDisplayName()
	else phi = getText("ContextMenu_SD_Nothing") end
	
	newText = newText .. getText("ContextMenu_SD_PrimaryHandItem")..": " .. tostring(phi)  .. "\n"
	newText = newText .. getText("ContextMenu_SD_MeleWeapon")..": " .. tostring(melewepName)  .. "\n"
	newText = newText .. getText("ContextMenu_SD_GunWeapon")..": " .. tostring(gunwepName)  .. "\n"
	newText = newText .. getText("ContextMenu_SD_CurrentTask")..": " .. tostring(ASuperSurvivor:getCurrentTask())  .. "\n"
	newText = newText .. "\n"
	newText = newText .. getText("ContextMenu_SD_AmmoCount")..": " .. tostring(ASuperSurvivor.player:getModData().ammoCount) .. "\n"
	newText = newText .. getText("ContextMenu_SD_AmmoType")..": " .. tostring(ASuperSurvivor.player:getModData().ammotype) .. "\n"
	newText = newText .. getText("ContextMenu_SD_AmmoBoxType")..": " .. tostring(ASuperSurvivor.player:getModData().ammoBoxtype) .. "\n"
	
	newText = newText .. "\n"
	
	if(isModEnabled("ArmorMod")) then
		local ID = ASuperSurvivor:getID()
		
		if(MyHeadArmor[ID] ) then newText = newText .. getText("ContextMenu_SD_HeadArmor")..": " .. tostring(MyHeadArmor[ID]:getDisplayName())  .. "\n" end
		if(MyBodyArmor[ID] ) then newText = newText .. getText("ContextMenu_SD_BodyArmor")..": " .. tostring(MyBodyArmor[ID]:getDisplayName())  .. "\n" end
		if(MyArmArmor[ID] ) then newText = newText .. getText("ContextMenu_SD_ArmArmor")..": " .. tostring(MyArmArmor[ID]:getDisplayName())  .. "\n" end
		if(MyHandArmor[ID] ) then newText = newText .. getText("ContextMenu_SD_HandArmor")..": " .. tostring(MyHandArmor[ID]:getDisplayName())  .. "\n" end
		if(MyShieldArmor[ID] ) then newText = newText .. getText("ContextMenu_SD_ShieldArmor")..": " .. tostring(MyShieldArmor[ID]:getDisplayName())  .. "\n" end
		if(MyLegArmor[ID] ) then newText = newText .. getText("ContextMenu_SD_LegArmor")..": " .. tostring(MyLegArmor[ID]:getDisplayName())  .. "\n" end
		if(MyFeetArmor[ID] ) then newText = newText .. getText("ContextMenu_SD_FeetArmor")..": " .. tostring(MyFeetArmor[ID]:getDisplayName())  .. "\n" end
		 
		
		newText = newText .. "\n"		
	end
	
	newText = newText .. getText("ContextMenu_SD_SurvivorID")..": " .. tostring(ASuperSurvivor:getID())  .. "\n"
	newText = newText .. getText("ContextMenu_SD_GroupID")..": " .. tostring(ASuperSurvivor:getGroupID())  .. "\n"
	newText = newText .. getText("ContextMenu_SD_GroupRole")..": " .. tostring(ASuperSurvivor:getGroupRole())  .. "\n"
	newText = newText .. "AI mode: " .. tostring(ASuperSurvivor:getAIMode())  .. "\n"
	
	self:setText(newText)
	
	
	
end

function SurvivorInfoWindowCreate()
	local FONT_HGT_SMALL = getTextManager():getFontHeight(UIFont.Small)
	mySurvivorInfoWindow = SurvivorInfoWindow:new(300, 270, FONT_HGT_SMALL * 6 + 175, FONT_HGT_SMALL * 10 + 500)
	mySurvivorInfoWindow:addToUIManager();
	mySurvivorInfoWindow:setVisible(false);
	mySurvivorInfoWindow.pin = true;
	mySurvivorInfoWindow.resizable = true
	
	-- build compatibility check---
	local player = getSpecificPlayer(0)
	if(player.setSceneCulled == nil) then -- this function only exists in build 41
		local text = "\n\n\nWARNING!! WARNING!! ERROR!!\n\nSUBPAR SURVIVORS MOD INCOMPATIBLE WITH THIS BUILD! \n\n";
		text = text .. "Please see the TIS forum or Discord to get help changng over to build 41."
		mySurvivorInfoWindow:setVisible(true);
		mySurvivorInfoWindow:setText(text);
	end
	
end

Events.OnGameStart.Add(SurvivorInfoWindowCreate);