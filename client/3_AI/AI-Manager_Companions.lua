-- This isn't fully ready yet.
-- And it's not being called anywhere, yet.
-- But I do however want to get it ready for conversion, when it's time.
-- TMI stands for 'TaskMangerIn'


function AIManager_Companion(TMI)
	
	if (TMI.parent:getGroupRole() ~= "Companion") then return TMI end -- Get out of here non-companions 
	
	local NPC = TMI.parent							-- Used to Cleanup some of the function's long names

	local function NPC_Task_Is(TaskName)			-- AiNPC_Task_Is(AiTmi,"TaskName")
		return (TMI:getCurrentTask() == TaskName) 
	end
	local function NPC_TaskIsNot(TaskName)			-- NPC_TaskIsNot("TaskName")
		return (TMI:getCurrentTask() ~= TaskName) 
	end
	
	local function NPC_Job_Is(JobName)				-- AiNPC_Job_Is(NPC,"JobName")
		return (NPC:getGroupRole() == JobName)
	end
	local function NPC_Job_IsNot(JobName)			-- AiNPC_Job_IsNot(NPC, "JobName")
		return (NPC:getGroupRole() ~= JobName)
	end

	
	
	if(NPC:needToFollow()) or (NPC:Get():getVehicle() ~= nil) then return TMI end
	
	if (TMI == nil) or (NPC == nil) then 
		return false 
	end

	local EnemyIsSurvivor = (instanceof(NPC.LastEnemeySeen,"IsoPlayer"))
	local EnemyIsZombie   = (instanceof(NPC.LastEnemeySeen,"IsoZombie"))
	local EnemySuperSurvivor = nil
	if(EnemyIsSurvivor) then 
		local id = NPC.LastEnemeySeen:getModData().ID
		EnemySuperSurvivor = SSM:Get(id) 
	end
	local IHaveInjury 	= NPC:HasInjury()
	local weapon 		= NPC.player:getPrimaryHandItem()
	local IsInAction 	= NPC:isInAction()
	local DistanceBetweenMainPlayer = getDistanceBetween(getSpecificPlayer(0),NPC:Get()) 

	-- --------------------------------------- --
	-- Companion (Follower Job) related code   --
	-- --------------------------------------- --
	if (NPC:getGroupRole() == "Companion") then 
	
	
		-- Keep the follower near the player
		if ( (DistanceBetweenMainPlayer > 8) and    (    getSpecificPlayer(0):isOutside() and     NPC:Get():isOutside() ) ) -- Both Outside
		or ( (DistanceBetweenMainPlayer > 5) and    (not getSpecificPlayer(0):isOutside() and not NPC:Get():isOutside() ) ) -- Both Inside
		or ( (DistanceBetweenMainPlayer > 5) and    (    getSpecificPlayer(0):isOutside() and not NPC:Get():isOutside() ) ) -- Player Outside / NPC Inside
		or ( (DistanceBetweenMainPlayer > 5) and    (not getSpecificPlayer(0):isOutside() and     NPC:Get():isOutside() ) ) -- Player Inside / NPC Outside
		 then 
			if (DistanceBetweenMainPlayer > 10) then -- Double checker
				TMI:clear()
				TMI:AddToTop(FollowTask:new(NPC,getSpecificPlayer(0)))
				NPC:DebugSay("Companion Went FAR too far away, CLEARING TASKS - and returning companion!")
			end
		    -- This will avoid clearing tasks if can help it, so the NPC can remember to do things like heal and reload
		    TMI:AddToTop(FollowTask:new(NPC,getSpecificPlayer(0)))
		    NPC:DebugSay("Companion Went too far away, returning companion!")
		 end

	
		-- ------------------------- --   				 
		-- reminder: NPC:NPCTask_DoAttack() already 
		-- checks 'if task ~= attack, then do attack' in it
		-- Adding it to here too just makes the companions freeze
		-- ------------------------- --
		-- Edit: I have trid so many other ways to do this. Any other way the companion just doesn't do anything.
		-- So it's staying like this for now
		-- Don't add 'and NPC_TaskIsNot("First Aide")' because you want companions to still attack enemies while hurt
		-- ------------------------- --


		-- ------------ --
		-- Pursue
		-- ------------ --
		if NPC_TaskIsNot("First Aide") and NPC_TaskIsNot("Pursue") and NPC_TaskIsNot("Attack") then
		
				-- ----- Perception Buff --- --
				NPC:Companion_DoSixthSenseScan()
		
			if (EnemyIsSurvivor or EnemyIsZombie) then
				TMI:AddToTop(PursueTask:new(NPC,NPC.LastEnemeySeen))
			end
		end
		-- ----------- --
		-- Attack
		-- ----------- --
		if (NPC_TaskIsNot("First Aide")) then
			-- ----- Perception Buff --- --
			--	NPC:Companion_DoSixthSenseScan()
			-- ------------------------- --
			
			if (
					(TMI:getCurrentTask() ~= "Attack") 
				and (TMI:getCurrentTask() ~= "Threaten") 
				and (TMI:getCurrentTask() ~= "First Aide") 
				and (NPC:isInSameRoom(NPC.LastEnemeySeen)) 
				) 
			and (
				   (NPC:hasWeapon() and 		   ((NPC:getDangerSeenCount() >= 1) or  (NPC:isEnemyInRange(NPC.LastEnemeySeen)))) 
				or (NPC:hasWeapon() == false and (NPC:getDangerSeenCount() == 1) and (not EnemyIsSurvivor))
				)
				
			--and ((not NPC:isTooScaredToFight() and (IHaveInjury == false)) -- This. I may want to change this to 'too many injuries' function
			
			and (not NPC:isTooScaredToFight())
		--	and (NPC:inFrontOfLockedDoor() == false) 
			then
				if(NPC.player ~= nil) 
				and (NPC.player:getModData().isRobber) 
				and (not NPC.player:getModData().hitByCharacter) 
				and EnemyIsSurvivor 
				and (not EnemySuperSurvivor.player:getModData().dealBreaker) 
				then 
					TMI:AddToTop(ThreatenTask:new(NPC,EnemySuperSurvivor,"Scram"))
					NPC:DebugSay("Threaten/Attack Task condition triggered! Reference Number ATC_000_01")
				else 
					TMI:AddToTop(AttackTask:new(NPC))
					NPC:DebugSay("Threaten/Attack Task condition triggered! Reference Number ATC_000_02")
				end
			end
		end
	
	

	
	-- --------------------------------- --
	-- 	Reload Gun	    			
	--  NPC:getDangerSeenCount() removed
	-- --------------------------------- --
		if (NPC_TaskIsNot("First Aide")) then
		
			if(NPC:getNeedAmmo())
			and (NPC:hasAmmoForPrevGun()) 
			and (IsInAction == false)
			then
				NPC:setNeedAmmo(false)
				NPC:reEquipGun()
				NPC:DebugSay("Companion RELOAD_Gun_0001")
			end
			
		end
		
		-- --------------------------------- --
		-- 	Ready Weapon	    			
		--  NPC:getDangerSeenCount() removed
		-- --------------------------------- --
		if (NPC_TaskIsNot("First Aide")) then
			if(IsInAction == false) 
			and (NPC:getNeedAmmo() == false) 
			and NPC:usingGun() 
			
			and ((NPC:needToReload()) or (NPC:needToReadyGun(weapon))) 
			and (NPC:NPC_FleeWhileReadyingGun()) 
			then
				NPC:ReadyGun(weapon)		
				if (NPC:isSpeaking() == false) then NPC:DebugSay("Companion READY_Gun_0001") end
			end	
			end
		
		-- ----------------------------- --
		-- 	Equip Weapon                 -- 
		-- ----------------------------- --
		if(NPC:hasWeapon()) and (NPC:Get():getPrimaryHandItem() == nil) and (TMI:getCurrentTask() ~= "Equip Weapon") and (NPC_TaskIsNot("First Aide"))  then
				TMI:AddToTop(EquipWeaponTask:new(NPC))
				NPC:DebugSay("Companion EQUIP_Gun_0001")
		end
		
		-- Careful setting up Flee to heal and 'healing', they will conflict very easily.
		-- This may need also a check for if not too far from player
		-- -----------   --
		-- Flee to heal  --
		-- -----------   --
		if      (TMI:getCurrentTask() ~= "Find Building")
			and (TMI:getCurrentTask() ~= "First Aide") 
			and (TMI:getCurrentTask() ~= "Flee") 
			and (IHaveInjury)
			and (NPC:getDangerSeenCount() > 1) 
			then
			--	TMI:AddToTop(FindBuildingTask:new(NPC))	
				TMI:AddToTop(FindUnlootedBuildingTask:new(NPC))	
				NPC:DebugSay("Companion HEALING_0001")
		end
		
		-- ----------- --
		-- Healing	   --
		-- ----------- --
		if (IHaveInjury) then
			if    (TMI:getCurrentTask() ~= "First Aide") 
			  and (TMI:getCurrentTask() ~= "Find Building") 
		--	  and (TMI:getCurrentTask() ~= "Equip Weapon") 	-- New : Needs testing though
			  
			  and (TMI:getCurrentTask() ~= "Flee") 
			  and (TMI:getCurrentTask() ~= "Doctor") 
			  and (TMI:getCurrentTask() ~= "Pursue") 
			
			  and (TMI:getCurrentTask() ~= "Hold Still")  
			then
				TMI:AddToTop(FirstAideTask:new(NPC)) -- If general healing
				NPC:DebugSay("Companion HealSelf_0001")
			end
		end	
		
	end
	
	-- At the end you MUST return the function's 'argument' at the end of an AI-Manager file, in this case, TMI
	return TMI
	
	-- --------------------------------------- --
	-- Companion follower related code | END   --
	-- --------------------------------------- --
end