require "TimedActions/ISBaseTimedAction"
require "ISUI/ISLayoutManager"
--require "ISUI/ISPanel"
--require "ISUI/PlayerStats/ISPlayerStatsUI"

ISUnequipClothingAction = ISBaseTimedAction:derive("ISUnequipClothingAction");

function ISUnequipClothingAction:isValid()
    return self.character:getInventory():contains(self.item)
end

function ISUnequipClothingAction:update()
    if (not self:isValid()) then
        return false
    end

    self:perform()
end

function ISUnequipClothingAction:getWasSuccessful()
    return true
end

function ISUnequipClothingAction:start()
    
end

function ISUnequipClothingAction:isComplete()
    return self.Complete
end

function ISUnequipClothingAction:stop()
    ISBaseTimedAction.stop(self);
end

function ISUnequipClothingAction:perform()
    self.character:setWornItem(self.item:getBodyLocation(), nil)
    ISTimedActionQueue.add(ISDropItemAction:new(self.character,self.item,1))
    self.Complete = true
    return nil
end

function ISUnequipClothingAction:new(character, item, time)
    local o = {}
    setmetatable(o, self)
    self._index = self
    o.character = character
    o.item = item
    o.stopOnWalk = false
    o.stopOnRun = false
    o.maxTime = time
    o.Name = "Drop Clothing"
    o.Complete = false
    if o.character:isTimedActionInstant() then o.maxTime = 1; end
    return o
end

function SuperSurvivor:UnequipClothes()
    local SS = self

    local inventory = self.player:getInventory()

    local allOfType = inventory:getItems()

    if allOfType and allOfType:size() > 0 then
		SS:DebugSay("SuperbUndressing UnequipClothes is about to trigger a StopWalk!")
        SS:StopWalk()

        for i = 1, allOfType:size() do
            local item = allOfType:get(i - 1)
            local type = item:getType()

            if item:IsClothing() then
                if item:isEquipped() and (not (item:getTexture():getName() == "Question_On")) then
                    SS:getTaskManager():AddToTop(ISUnequipClothingAction:new(self.player, item, 30))
                    SS:Speak(getActionText("UndressingClothes"))
                end
            end
        end
    end

    self.player:initSpritePartsEmpty();
    triggerEvent("OnClothingUpdated", self.player)

end


local function functionThatConnectsThisModToSuperbSurvivorsTaskManagerLogic(o)
    
    local SS = SSM:Get(o:getModData().ID)
    SS:UnequipClothes()

end


function SuperbUndressedSurvivorsLogic(context, o)
    local id = o:getModData().ID
    local SS = SSM:Get(id)

    if (id ~= 0) and (SS:getGroupID() == SSM:Get(0):getGroupID()) and SS:getGroupID() ~= nil then
        local selectOption = context:addOption(SS:getName() .. getContextMenuText("AddClothing"), worldobjects, nil)
        local clothingmenu = context:getNew(context);
        clothingmenu:addOption(getContextMenuText("RemoveClothing"), nil, function() functionThatConnectsThisModToSuperbSurvivorsTaskManagerLogic(o) end, o, nil)
        context:addSubMenu(selectOption, clothingmenu);  --Add ">"
    end
end

function clickHandler(square, context)
    if(square ~= nil) then
		for i=0,square:getMovingObjects():size()-1 do
			local o = square:getMovingObjects():get(i)
			if(instanceof(o, "IsoPlayer")) then
				SuperbUndressedSurvivorsLogic(context, o)
			end			
		end		
	end
end

function teste(player, context, worldobjects, test)
    if player ~= 0 then 
        return
    end

    local square = getMouseSquare(player)

    clickHandler(square, context)

    if(square ~= nil) then
		local osquare = square:getN();
		if(osquare ~= nil) then
            clickHandler(osquare:getE(),context);
            clickHandler(osquare:getW(),context);
            clickHandler(osquare,context);
		end
		osquare = square:getS();
		if(osquare ~= nil) then
            clickHandler(osquare:getE(),context);
            clickHandler(osquare:getW(),context);
            clickHandler(osquare,context);
		end
		osquare = square:getE();
		if(osquare ~= nil) then
            clickHandler(osquare,context);
		end
		osquare = square:getW();
		if(osquare ~= nil) then
            clickHandler(osquare,context);
		end
	end
end

Events.OnFillWorldObjectContextMenu.Add(teste)