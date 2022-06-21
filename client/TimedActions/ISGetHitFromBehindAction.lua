
require "TimedActions/ISBaseTimedAction"

ISGetHitFromBehindAction = ISBaseTimedAction:derive("ISGetHitFromBehindAction");

function ISGetHitFromBehindAction:isValid()
	return true
end

function ISGetHitFromBehindAction:update()
    if self.character then
      
		self.character:getModData().felldown = true
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
    end
end

function ISGetHitFromBehindAction:start()
	
	self:setActionAnim("staggerforward")
	self:setOverrideHandModels(nil, nil)
end

function ISGetHitFromBehindAction:stop()
	self.character:getModData().felldown = nil
    ISBaseTimedAction.stop(self);
end

function ISGetHitFromBehindAction:perform()
	self.character:getModData().felldown = nil
	ISBaseTimedAction.perform(self);
end

function ISGetHitFromBehindAction:new(character,enemy)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.stopOnWalk = false;
	o.stopOnRun = false;
	o.forceProgressBar = false;
	o.enemy = enemy

	o.mul = 2;
	o.maxTime = 70;

	return o;
end
