
require "TimedActions/ISBaseTimedAction"

ISSurenderAction = ISBaseTimedAction:derive("ISSurenderAction");

function ISSurenderAction:isValid()
	return true
end

function ISSurenderAction:update()
    if self.character then
      
		--print("surender update")
		self.character:getModData().surender = true
      self.character:faceThisObjectAlt(self.enemy)
    self.character:setMetabolicTarget(Metabolics.LightDomestic);
    end
end

function ISSurenderAction:start()
	self:setActionAnim("HandsUp")
	self:setOverrideHandModels(nil, nil)
end

function ISSurenderAction:stop()
	self.character:getModData().surender = nil
    ISBaseTimedAction.stop(self);
end

function ISSurenderAction:perform()
	self.character:getModData().surender = nil
	ISBaseTimedAction.perform(self);
end

function ISSurenderAction:new(character,enemy)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character;
	o.stopOnWalk = true;
	o.stopOnRun = true;
	o.forceProgressBar = true;
	o.enemy = enemy

	o.mul = 2;
	o.maxTime = 300;

	return o;
end
