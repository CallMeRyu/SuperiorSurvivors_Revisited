
require "TimedActions/ISBaseTimedAction"

ISGetHitFromFrontAction = ISBaseTimedAction:derive("ISGetHitFromFrontAction");

function ISGetHitFromFrontAction:isValid()
	return true
end

function ISGetHitFromFrontAction:update()
    if self.character then
      
		self.character:getModData().felldown = true
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
    end
end

function ISGetHitFromFrontAction:start()

	self:setActionAnim("staggerbackward")
	self:setOverrideHandModels(nil, nil)
end

function ISGetHitFromFrontAction:stop()

	self.character:getModData().surender = nil
    ISBaseTimedAction.stop(self);
end

function ISGetHitFromFrontAction:perform()

	self.character:getModData().felldown = nil
	
	ISBaseTimedAction.perform(self);
end

function ISGetHitFromFrontAction:new(character,enemy)
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
