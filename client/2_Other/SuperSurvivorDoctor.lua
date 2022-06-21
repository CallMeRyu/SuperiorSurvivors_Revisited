function DoctorNeedsCleanBandage(bp)

	if(bp:HasInjury()) and (bp:bandaged() == true) and (bp:getBandageLife() <= 0 ) then return true end
	return false
end

function DoctorNeedsBandage(bp)

	if (bp:bandaged() == false) and ((bp:HasInjury()) or (bp:stitched())) then 
		if(tostring(bp) == "ForeArm_R") then getSpecificPlayer(0):Say("needs bandage") end
		return true 
	end
	if(tostring(bp) == "ForeArm_R") then getSpecificPlayer(0):Say("NOT needs bandage") end
	return false
end

function DoctorNeedsBulletRemoval(bp)

	if(bp:HasInjury()) and (bp:haveBullet()) then return true end
	return false
end

function DoctorNeedsGlassRemoval(bp)

	if(bp:HasInjury()) and (bp:haveGlass()) then return true end
	return false
end

function DoctorNeedsStiches(bp)

	if(bp:HasInjury()) and (bp:isDeepWounded()) and (bp:stitched() == false) then return true end
	return false
end

function DoctorNeedsSplint(bp)

	if(bp:HasInjury()) and (bp:isSplint() == false) and (bp:getFractureTime() > 0) then return true end
	return false
end


function DoctorDetermineTreatement(bp)
	
	if not instanceof(bp,"BodyPart") then 
		print("error non body part given to DoctorDetermineTreatement")
		return "?" 
	end

	if (DoctorNeedsSplint(bp)) then return "Splint"
	elseif (DoctorNeedsStiches(bp)) and (bp:bandaged()) then return "Bandage Removal"
	elseif (DoctorNeedsStiches(bp)) and (not bp:bandaged()) then return "Stich"
	elseif (DoctorNeedsGlassRemoval(bp)) and (bp:bandaged()) then return "Bandage Removal"
	elseif (DoctorNeedsGlassRemoval(bp)) and (not bp:bandaged()) then return "Remove Glass"
	elseif (DoctorNeedsBulletRemoval(bp)) and (bp:bandaged()) then return "Bandage Removal"
	elseif (DoctorNeedsBulletRemoval(bp)) and (not bp:bandaged()) then return "Remove Bullet"
	elseif (DoctorNeedsBandage(bp)) then return "Bandage"
	elseif (DoctorNeedsCleanBandage(bp)) then return "Bandage Removal"
	else return "None" end

end

function RequiresTreatment(player)

	local bodyparts = player:getBodyDamage():getBodyParts()
	
	for i=0, bodyparts:size()-1 do
		local bp = bodyparts:get(i)
		if DoctorDetermineTreatement(bp) ~= "None" then return true end		
	end
	
	return false
end