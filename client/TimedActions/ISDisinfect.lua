--***********************************************************
--**                    ROBERT JOHNSON                     **
--***********************************************************

require "TimedActions/ISBaseTimedAction"

ISDisinfect = ISBaseTimedAction:derive("ISDisinfect");

function ISDisinfect:isValid()
	if ISHealthPanel.DidPatientMove(self.character, self.otherPlayer, self.bandagedPlayerX, self.bandagedPlayerY) then
		return false
	end
	return self.character:getInventory():contains(self.alcohol)
end

function ISDisinfect:waitToStart()
    if self.character == self.otherPlayer then
        return false
    end
    self.character:faceThisObject(self.otherPlayer)
    return self.character:shouldBeTurning()
end

function ISDisinfect:update()
    if self.character ~= self.otherPlayer then
        self.character:faceThisObject(self.otherPlayer)
    end
    local jobType = getActionText("Disinfect")
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, self, jobType, { disinfect = true })

    self.character:setMetabolicTarget(Metabolics.LightDomestic);
end

function ISDisinfect:start()
	if self.character == self.otherPlayer then
		self:setActionAnim(CharacterActionAnims.Bandage);
		
		local result --= ISHealthPanel.getBandageType(self.bodyPart)
		if self.bodyPart:getType() == BodyPartType.Head or self.bodyPart:getType() == BodyPartType.Neck then
			result = "Head";
		end
		if self.bodyPart:getType() == BodyPartType.Torso_Lower or self.bodyPart:getType() == BodyPartType.Groin then
			result = "LowerBody";
		end
		if self.bodyPart:getType() == BodyPartType.Torso_Upper then
			result = "UpperBody";
		end
		if self.bodyPart:getType() == BodyPartType.Hand_L or self.bodyPart:getType() == BodyPartType.ForeArm_L or self.bodyPart:getType() == BodyPartType.UpperArm_L then
			result = "LeftArm";
		end
		if self.bodyPart:getType() == BodyPartType.Hand_R or self.bodyPart:getType() == BodyPartType.ForeArm_R or self.bodyPart:getType() == BodyPartType.UpperArm_R then
			result = "RightArm";
		end
		if self.bodyPart:getType() == BodyPartType.UpperLeg_L or self.bodyPart:getType() == BodyPartType.LowerLeg_L or self.bodyPart:getType() == BodyPartType.Foot_L then
			result = "LeftLeg";
		end
		if self.bodyPart:getType() == BodyPartType.UpperLeg_R or self.bodyPart:getType() == BodyPartType.LowerLeg_R or self.bodyPart:getType() == BodyPartType.Foot_R then
			result = "RightLeg";
		end
		if(result == nil) then result = "UpperBody" end
		
		self:setAnimVariable("BandageType", result);
	else
		self:setActionAnim("Loot")
		self.character:SetVariable("LootPosition", "Mid")
	end
	self:setOverrideHandModels(nil, nil);
end

function ISDisinfect:stop()
    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
    ISBaseTimedAction.stop(self);
end

function ISDisinfect:perform()
    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
    self.bodyPart:setAlcoholLevel(self.bodyPart:getAlcoholLevel() + self.alcohol:getAlcoholPower());
    local addPain = (self.alcohol:getAlcoholPower() * 13) - (self.doctorLevel / 2)
    if self.doctor:getAccessLevel() ~= "None" then
        self.bodyPart:setAdditionalPain(self.bodyPart:getAdditionalPain() + addPain);
    end
    if(instanceof(self.alcohol, "Food")) then
        self.alcohol:setThirstChange(self.alcohol:getThirstChange() + 0.1);
        if(self.alcohol:getBaseHunger() < 0) then
            self.alcohol:setHungChange(self.alcohol:getHungChange() + 0.1);
        end

        if self.alcohol:getThirstChange() > -0.01 or self.alcohol:getHungerChange() > -0.01 then
            self.alcohol:Use();
        end
    elseif (instanceof(self.alcohol, "DrainableComboItem")) then
        self.alcohol:Use();
    end

    if isClient() then
        sendDisinfect(self.otherPlayer:getOnlineID(), self.bodyPart:getIndex(), self.alcohol:getAlcoholPower());
        if self.doctor:getAccessLevel() ~= "None" then
            sendAdditionalPain(self.otherPlayer:getOnlineID(), self.bodyPart:getIndex(), addPain);
        end
    end

    ISHealthPanel.setBodyPartActionForPlayer(self.otherPlayer, self.bodyPart, nil, nil, nil)
end

function ISDisinfect:new(doctor, otherPlayer, alcohol, bodyPart)
	local o = {}
	setmetatable(o, self)
	self.__index = self;
	o.character = doctor;
    o.doctor = doctor;
    o.otherPlayer = otherPlayer;
    o.doctorLevel = doctor:getPerkLevel(Perks.Doctor);
	o.alcohol = alcohol;
	o.bodyPart = bodyPart;
	o.stopOnWalk = bodyPart:getIndex() > BodyPartType.ToIndex(BodyPartType.Groin);
	o.stopOnRun = true;
    o.bandagedPlayerX = otherPlayer:getX();
    o.bandagedPlayerY = otherPlayer:getY();
    o.maxTime = 120 - (o.doctorLevel * 4);
    if doctor:isTimedActionInstant() then
        o.maxTime = 1;
    end
    if doctor:getAccessLevel() ~= "None" then
        o.doctorLevel = 10;
    end
	return o;
end
