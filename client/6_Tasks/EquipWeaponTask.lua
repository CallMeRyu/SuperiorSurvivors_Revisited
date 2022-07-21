EquipWeaponTask = {}
EquipWeaponTask.__index = EquipWeaponTask

function EquipWeaponTask:new(superSurvivor)

	local o = {}
	setmetatable(o, self)
	self.__index = self
		
	o.parent = superSurvivor
	o.Name = "Equip Weapon"

	o.OnGoing = true
	o.Complete = false
	o.parent:DebugSay(tostring(o.parent:getCurrentTask()).." Started!" )
	
	return o

end

function EquipWeaponTask:isComplete()
	return self.Complete
end

function EquipWeaponTask:isValid()
	if not self.parent then return false 
	else return true end
end

function EquipWeaponTask:update()
	
	if(not self:isValid()) then return false end
	
	if(self.parent:isInAction() == false) then
		
		local bag = self.parent:getBag()
		local weapon = bag:getBestWeapon()
		if(weapon) and (weapon:getMaxDamage() > 0.1) then 
			self.parent:RoleplaySpeak(getActionText("EquipsArmor_Before")..weapon:getDisplayName()..getActionText("EquipsArmor_After"))
			self.parent.player:setPrimaryHandItem(weapon)
		end
		
		self.Complete = true
	
	end

end
