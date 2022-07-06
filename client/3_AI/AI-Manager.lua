
-- IDEA: If zombies near companion while reloading or something particular, run to player if player is further out
-- Bug: companions are pursing a target without they returning to the player when out of range

-- ---------------------------------------------------------- --
-- Functions to Attempt-Clean / Make this file easier to read --
-- #CleanCode      		                                      --
-- ---------------------------------------------------------- --

--- Checks if TaskName the current task of the AiTmi
---@param AiTmi (table) Task Manager
---@param TaskName (string) Task name to be checked
---@return (boolean) returns true if the TaskName is the current task of AiTmi
function AiNPC_Task_Is(AiTmi,TaskName)
	return (AiTmi:getCurrentTask() == TaskName) 
end

function AiNPC_TaskIsNot(AiTmi,TaskName)			-- AiNPC_TaskIsNot(AiTmi,"TaskName")
	return (AiTmi:getCurrentTask() ~= TaskName) 
end

function AiNPC_Job_Is(NPC,JobName)				-- AiNPC_Job_Is(NPC,"JobName")
	return (NPC:getGroupRole() == JobName)
end
function AiNPC_Job_IsNot(NPC,JobName)			-- AiNPC_Job_IsNot(NPC, "JobName")
	return (NPC:getGroupRole() ~= JobName)
end

--TODO: move to SuperSurvivorsAiManagerUtilities.lua (or SuperSurvivor.lua)

--- Checks if AiTmi is doing any of the tasks
---@param AiTmi (table) Task Manager
---@param tasks (table) List of strings of the task names 
---@return (boolean) returns true if any task of tasks is the current task of AiTmi
local function AiNpc_Task_Is_AnyOf(AiTmi,tasks)
	for _,task in ipairs(tasks) do
		if(AiNPC_Task_Is(AiTmi,task)) then
			return true
		end
	end

	return false
end

local function AiNpc_IsTarget_Survivor(NPC)
	return (instanceof(NPC.LastEnemeySeen,"IsoZombie"))
end

local function AiNpc_IsTarget_Zombie(NPC)
	return (instanceof(NPC.LastEnemeySeen,"IsoPlayer"))
end

local function AiNpc_HaveTooManyInjuries(NPC)
	return NPC:isTooScaredToFight() and NPC:HasInjury()
end

local function AiNpc_IsInDanger(NPC)
	local hasWeapon = NPC:hasWeapon() 
	local enemyIsSurvivor = AiNpc_IsTarget_Survivor(NPC)
	local dangerCount = NPC:getDangerSeenCount()
	local isEnemyInRange = (NPC:isEnemyInRange(NPC.LastEnemeySeen))

	return (
		( hasWeapon and ( dangerCount >= 1 or isEnemyInRange ) )
		or
		( not hasWeapon and dangerCount == 1 and not enemyIsSurvivor )
	)
end

local function AiNPC_CanAttack(AiTmi,NPC) 
	local forbidenTasks = {"Attack","Threaten","First Aide"};

	local canAttack = not AiNpc_Task_Is_AnyOf(AiTmi,forbidenTasks)
	local isInTheSameRoom = NPC:isInSameRoom(NPC.LastEnemeySeen)

	local hasNotFellDown = not NPC:HasFellDown() 

	local isNotTooScaredToFight = not NPC:isTooScaredToFight()

	return 
		canAttack and 
		isInTheSameRoom and 
		hasNotFellDown and 
		AiNpc_IsInDanger(NPC) and 
		isNotTooScaredToFight
end

function AIManager(TaskMangerIn)
	
	local ASuperSurvivor = TaskMangerIn.parent	-- the previous variable, trying to convert to "NPC"
	local AiTmi = TaskMangerIn 					-- Used for AiNPC_TaskIsNot code cleanup/easier-to-read
	local NPC   = TaskMangerIn.parent			-- Used to Cleanup some of the function's long names

	if(ASuperSurvivor:needToFollow()) or (ASuperSurvivor:Get():getVehicle() ~= nil) then return TaskMangerIn end
	
	if (TaskMangerIn == nil) or (ASuperSurvivor == nil) then 
		return false 
	end
	
	local EnemyIsSurvivor = (instanceof(ASuperSurvivor.LastEnemeySeen,"IsoPlayer"))
	local EnemyIsZombie = (instanceof(ASuperSurvivor.LastEnemeySeen,"IsoZombie"))
	local EnemySuperSurvivor = nil
	local LastSuperSurvivor = nil
	local EnemyIsSurvivorHasGun = false
	local LastSurvivorHasGun = false
	if(EnemyIsSurvivor) then 
		local id = ASuperSurvivor.LastEnemeySeen:getModData().ID
		
		EnemySuperSurvivor = SSM:Get(id) 
		if(EnemySuperSurvivor) then
			EnemyIsSurvivorHasGun = EnemySuperSurvivor:hasGun()
		end
	end
	if(ASuperSurvivor.LastSurvivorSeen) then 
		local lsid = ASuperSurvivor.LastSurvivorSeen:getModData().ID
		
		LastSuperSurvivor = SSM:Get(lsid) 
		if(LastSuperSurvivor) then
			LastSurvivorHasGun = LastSuperSurvivor:hasGun()
		end
	end
	local HostileInNPCsRange = NPC:isEnemyInRange(NPC.LastEnemeySeen)
	local IHaveInjury = ASuperSurvivor:HasInjury()
	local weapon = ASuperSurvivor.player:getPrimaryHandItem()
	local IsInAction = ASuperSurvivor:isInAction()
	local HisGroup = ASuperSurvivor:getGroup()
	local IsInBase = ASuperSurvivor:isInBase()
	local CenterBaseSquare = nil
	local DistanceBetweenMainPlayer = getDistanceBetween(getSpecificPlayer(0),ASuperSurvivor:Get()) 
	local Distance_AnyEnemy = getDistanceBetween(ASuperSurvivor.LastEnemeySeen,ASuperSurvivor:Get())  -- idk if this works
	if(HisGroup) then CenterBaseSquare = HisGroup:getBaseCenter() end







	-- --------------------------------------- --
	-- Companion follower related code         --
	-- --------------------------------------- --
	if (ASuperSurvivor:getGroupRole() == "Companion") then 

		if 
		 ( 	-- Checks for NPC and main player is indoor/outdoor-like conditions
		    ( (DistanceBetweenMainPlayer > 8) and    (    getSpecificPlayer(0):isOutside() and     NPC:Get():isOutside() ) ) -- Both Outside
		 or ( (DistanceBetweenMainPlayer > 5) and    (not getSpecificPlayer(0):isOutside() and not NPC:Get():isOutside() ) ) -- Both Inside
		 or ( (DistanceBetweenMainPlayer > 5) and    (    getSpecificPlayer(0):isOutside() and not NPC:Get():isOutside() ) ) -- Player Outside / NPC Inside
		 or ( (DistanceBetweenMainPlayer > 5) and    (not getSpecificPlayer(0):isOutside() and     NPC:Get():isOutside() ) ) -- Player Inside / NPC Outside
		 or ( (DistanceBetweenMainPlayer > 8) ) -- For general purpose
		 ) 	
		then
		  if (DistanceBetweenMainPlayer > 10) then -- Double checker
				TaskMangerIn:clear()
				TaskMangerIn:AddToTop(FollowTask:new(ASuperSurvivor,getSpecificPlayer(0)))
				NPC:DebugSay("Companion Went FAR too far away, CLEARING TASKS - and returning companion!")
		  end
		  -- This will avoid clearing tasks if can help it, so the NPC can remember to do things like heal and reload
		  TaskMangerIn:AddToTop(FollowTask:new(ASuperSurvivor,getSpecificPlayer(0)))
		  NPC:DebugSay("Companion Went too far away, returning companion!")
		end
		
	end
		
		
		
	if (AiNPC_Job_Is(NPC,"Companion")) then
	
		-- ------------------------- --   				 
		-- reminder: NPC:NPCTask_DoAttack() already 
		-- checks 'if task ~= attack, then do attack' in it
		-- Adding it to here too just makes the companions freeze
		-- ------------------------- --
		-- Edit: I have trid so many other ways to do this. Any other way the companion just doesn't do anything.
		-- So it's staying like this for now
		-- Don't add 'and AiNPC_TaskIsNot(AiTmi,"First Aide")' because you want companions to still attack enemies while hurt
		-- ------------------------- --

		-- ----- Perception Buff --- --
		NPC:Companion_DoSixthSenseScan()

		-- ------------ --
		-- Pursue
		-- ------------ --
		if AiNPC_TaskIsNot(AiTmi,"First Aide") and AiNPC_TaskIsNot(AiTmi,"Pursue") and AiNPC_TaskIsNot(AiTmi,"Attack") and (DistanceBetweenMainPlayer < 10)  then
			if (EnemyIsSurvivor or EnemyIsZombie) then
				TaskMangerIn:AddToTop(PursueTask:new(ASuperSurvivor,ASuperSurvivor.LastEnemeySeen))
			end
		end
		-- ----------- --
		-- Attack
		-- ----------- --
		if (AiNPC_TaskIsNot(AiTmi,"First Aide")) then
			-- ----- Perception Buff --- --
			--	NPC:Companion_DoSixthSenseScan()
			-- ------------------------- --
			
			if (
					(TaskMangerIn:getCurrentTask() ~= "Attack") 
				and (TaskMangerIn:getCurrentTask() ~= "Threaten") 
				and (TaskMangerIn:getCurrentTask() ~= "First Aide") 
				and (ASuperSurvivor:isInSameRoom(ASuperSurvivor.LastEnemeySeen)) 
				) 
			and (
				   (ASuperSurvivor:hasWeapon() and 		   ((ASuperSurvivor:getDangerSeenCount() >= 1) or  (ASuperSurvivor:isEnemyInRange(ASuperSurvivor.LastEnemeySeen)))) 
				or (ASuperSurvivor:hasWeapon() == false and (ASuperSurvivor:getDangerSeenCount() == 1) and (not EnemyIsSurvivor))
				)
				
			--and ((not ASuperSurvivor:isTooScaredToFight() and (IHaveInjury == false)) -- This. I may want to change this to 'too many injuries' function
			
			and (not NPC:isTooScaredToFight())
		--	and (ASuperSurvivor:inFrontOfLockedDoor() == false) 
			then
				if(ASuperSurvivor.player ~= nil) 
				and (ASuperSurvivor.player:getModData().isRobber) 
				and (not ASuperSurvivor.player:getModData().hitByCharacter) 
				and EnemyIsSurvivor 
				and (not EnemySuperSurvivor.player:getModData().dealBreaker) 
				then 
					TaskMangerIn:AddToTop(ThreatenTask:new(ASuperSurvivor,EnemySuperSurvivor,"Scram"))
					ASuperSurvivor:DebugSay("Threaten/Attack Task condition triggered! Reference Number ATC_000_01")
				else 
					TaskMangerIn:AddToTop(AttackTask:new(ASuperSurvivor))
					ASuperSurvivor:DebugSay("Threaten/Attack Task condition triggered! Reference Number ATC_000_02")
				end
			end
		end
	
	

	
	-- --------------------------------- --
	-- 	Reload Gun	    			
	--  NPC:getDangerSeenCount() removed
	-- --------------------------------- --
		if (AiNPC_TaskIsNot(AiTmi,"First Aide")) then
		
			if(ASuperSurvivor:getNeedAmmo())
			and (ASuperSurvivor:hasAmmoForPrevGun()) 
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
		if (AiNPC_TaskIsNot(AiTmi,"First Aide")) then
			if(IsInAction == false) 
			and (ASuperSurvivor:getNeedAmmo() == false) 
			and ASuperSurvivor:usingGun() 
			
			and ((ASuperSurvivor:needToReload()) or (ASuperSurvivor:needToReadyGun(weapon))) 
			and (NPC:NPC_FleeWhileReadyingGun()) 
			then
				ASuperSurvivor:ReadyGun(weapon)		
				if (NPC:isSpeaking() == false) then NPC:DebugSay("Companion READY_Gun_0001") end
			end	
		end
		
		-- ----------------------------- --
		-- 	Equip Weapon                 -- 
		-- ----------------------------- --
		if(ASuperSurvivor:hasWeapon()) and (ASuperSurvivor:Get():getPrimaryHandItem() == nil) and (TaskMangerIn:getCurrentTask() ~= "Equip Weapon") and (AiNPC_TaskIsNot(AiTmi,"First Aide"))  then
				TaskMangerIn:AddToTop(EquipWeaponTask:new(ASuperSurvivor))
				ASuperSurvivor:DebugSay("Companion EQUIP_Gun_0001")
		end
		
		-- Careful setting up Flee to heal and 'healing', they will conflict very easily.
		-- -----------   --
		-- Flee to heal  --
		-- -----------   --
		if      (TaskMangerIn:getCurrentTask() ~= "Find Building")
			and (TaskMangerIn:getCurrentTask() ~= "First Aide") 
			and (TaskMangerIn:getCurrentTask() ~= "Flee") 
			and (IHaveInjury)
			and (ASuperSurvivor:getDangerSeenCount() > 1) 
			then
			--	TaskMangerIn:AddToTop(FindBuildingTask:new(ASuperSurvivor))	
				TaskMangerIn:AddToTop(FindUnlootedBuildingTask:new(ASuperSurvivor))	
				ASuperSurvivor:DebugSay("Companion HEALING_0001")
		end
		
		-- ----------- --
		-- Healing	   --
		-- ----------- --
		if (IHaveInjury) then
			if    (TaskMangerIn:getCurrentTask() ~= "First Aide") 
			  and (TaskMangerIn:getCurrentTask() ~= "Find Building") 
		--	  and (TaskMangerIn:getCurrentTask() ~= "Equip Weapon") 	-- New : Needs testing though
			  
			  and (TaskMangerIn:getCurrentTask() ~= "Flee") 
			  and (TaskMangerIn:getCurrentTask() ~= "Doctor") 
			  and (TaskMangerIn:getCurrentTask() ~= "Pursue") 
			
			  and (TaskMangerIn:getCurrentTask() ~= "Hold Still")  
			then
				TaskMangerIn:AddToTop(FirstAideTask:new(ASuperSurvivor)) -- If general healing
				NPC:DebugSay("Companion HealSelf_0001")
			end
		end	

	
	end

	-- --------------------------------------- --
	-- Companion follower related code | END   --
	-- --------------------------------------- --






























	-- --------------------------------------------------------------------- --
	-- ------------------- Non Companion Shared ---------------------------- --
	-- 	if(ASuperSurvivor:Get():getModData().isHostile) and (ASuperSurvivor:isSpeaking() == false) then ASuperSurvivor:Speak(getSpeech("GonnaGetYou")) end
	--	Removed. You want it? Add it back in the line above pursuetask		 --
	-- --------------------------------------------------------------------- --

	-- 'If enemy is in a fair range and Pursue_SC checks out, and the NPC's enemy is in Pursue Score's range'
	-- --------------------------------------- --
	-- Pursue Task 							   --
	-- --------------------------------------- --
	-- To make NPCs find their target that's very close by
	if not (AiNPC_Job_Is(NPC,"Companion"))  then
		if (ASuperSurvivor:Task_IsPursue_SC() == true) and (Distance_AnyEnemy <= 9) and (Distance_AnyEnemy < NPC:NPC_CheckPursueScore() )   then
			if ( NPC:NPC_FleeWhileReadyingGun()) then
				TaskMangerIn:AddToTop(PursueTask:new(ASuperSurvivor,ASuperSurvivor.LastEnemeySeen)) -- If all checks out, pursue target
			end
		end
	end	

	-- I haven't tampered with this one, it does OK for the most part. 
	-- Bug: If you shoot the gun and it has nothing in it, the NPC will still keep their hands up 
	-- ----------------------------- --
	-- 		Surrender Task	
	-- ----------------------------- --
	if(getSpecificPlayer(0) ~= nil) then
		local facingResult = getSpecificPlayer(0):getDotWithForwardDirection(ASuperSurvivor.player:getX(),ASuperSurvivor.player:getY())
		--ASuperSurvivor:Speak( tostring(facingResult) )
		if( (TaskMangerIn:getCurrentTask() ~= "Surender") 
			and (TaskMangerIn:getCurrentTask() ~= "Flee" )
			and (TaskMangerIn:getCurrentTask() ~= "Flee From Spot") 
			and (TaskMangerIn:getCurrentTask() ~= "Clean Inventory") 
			and (SSM:Get(0) ~= nil and SSM:Get(0):usingGun())
			and  getSpecificPlayer(0) 
			and getSpecificPlayer(0):CanSee(ASuperSurvivor.player) 
			and (not ASuperSurvivor:usingGun() or (not ASuperSurvivor:RealCanSee(getSpecificPlayer(0)) and DistanceBetweenMainPlayer<=3 )) 
			and getSpecificPlayer(0):isAiming() 
			and IsoPlayer.getCoopPVP() 
			and not ASuperSurvivor:isInGroup(getSpecificPlayer(0)) 
			and (facingResult > 0.95 ) 
			and (DistanceBetweenMainPlayer < 6)) 
			 then
				TaskMangerIn:clear()
				TaskMangerIn:AddToTop(SurenderTask:new(ASuperSurvivor, SSM:Get(0)))
				NPC:DebugSay("Surrender Task Triggered! Reference Number ST_0001")
			 return TaskMangerIn
		end
	end
	
	-- ----------------------------- --
	-- Attack / Threaten Target Task --
	-- ----------------------------- --
	--	if ((TaskMangerIn:getCurrentTask() ~= "Attack") and (TaskMangerIn:getCurrentTask() ~= "Threaten") and not ((TaskMangerIn:getCurrentTask() == "Surender") and EnemyIsSurvivor) and (TaskMangerIn:getCurrentTask() ~= "Doctor") and (ASuperSurvivor:isInSameRoom(ASuperSurvivor.LastEnemeySeen)) and (TaskMangerIn:getCurrentTask() ~= "Flee")) and ((ASuperSurvivor:hasWeapon() and ((ASuperSurvivor:getDangerSeenCount() >= 1) or (ASuperSurvivor:isEnemyInRange(ASuperSurvivor.LastEnemeySeen)))) or (ASuperSurvivor:hasWeapon() == false and (ASuperSurvivor:getDangerSeenCount() == 1) and (not EnemyIsSurvivor))) and (IHaveInjury == false) and (ASuperSurvivor:inFrontOfLockedDoor() == false)  then

	if not (AiNPC_Job_Is(NPC,"Companion"))  then
		if (			
				(TaskMangerIn:getCurrentTask() ~= "Attack") 
			and (TaskMangerIn:getCurrentTask() ~= "Threaten") 
			and not ((TaskMangerIn:getCurrentTask() == "Surender") and EnemyIsSurvivor) 
			and (TaskMangerIn:getCurrentTask() ~= "Doctor") 
			and (ASuperSurvivor:isInSameRoom(ASuperSurvivor.LastEnemeySeen)) 
			and (TaskMangerIn:getCurrentTask() ~= "Flee")
			and (TaskMangerIn:getCurrentTask() ~= "Flee From Spot") 
			and (NPC:NPC_CheckPursueScore() > 0) -- New: It maybe pursue, but it can be used for attack too, it's helping against door spam
			and ( Distance_AnyEnemy < NPC:NPC_CheckPursueScore() ) -- Don't want them chasing from across the map
			) 
		and (
			   (ASuperSurvivor:hasWeapon() and 		   ((ASuperSurvivor:getDangerSeenCount() >= 1) or (ASuperSurvivor:isEnemyInRange(ASuperSurvivor.LastEnemeySeen)))) 
			or (ASuperSurvivor:hasWeapon() == false and (ASuperSurvivor:getDangerSeenCount() == 1) and (not EnemyIsSurvivor))
			)
			
		and (not ASuperSurvivor:isTooScaredToFight() and (IHaveInjury == false)) -- This. I may want to change this to 'too many injuries' function
		
		and (not NPC:isTooScaredToFight())
		and (ASuperSurvivor:inFrontOfLockedDoor() == false) 
		 then
			if(ASuperSurvivor.player ~= nil) 
			and (ASuperSurvivor.player:getModData().isRobber) 
			and (not ASuperSurvivor.player:getModData().hitByCharacter) 
			and EnemyIsSurvivor 
			and (not EnemySuperSurvivor.player:getModData().dealBreaker) 
			 then 
				 TaskMangerIn:AddToTop(ThreatenTask:new(ASuperSurvivor,EnemySuperSurvivor,"Scram"))
				 ASuperSurvivor:DebugSay("Threaten/Attack Task condition triggered! Reference Number ATC_000_01")
			 else 
				 TaskMangerIn:AddToTop(AttackTask:new(ASuperSurvivor))
				 ASuperSurvivor:DebugSay("Threaten/Attack Task condition triggered! Reference Number ATC_000_02")
			 end
		end
	end
	
	-- ----------------------------- --
	-- New: To attempt players that are NOT trying to encounter a fight, 
	-- should be able to run away. maybe a dice roll for the future?
	-- ----------------------------- --
	if not (AiNPC_Job_Is(NPC,"Companion"))  then
		if (EnemyIsSurvivor) and (TaskMangerIn:getCurrentTask() == "Threaten") and (Distance_AnyEnemy > 10) then
			TaskMangerIn:AddToTop(WanderTask:new(ASuperSurvivor))
			TaskMangerIn:AddToTop(AttemptEntryIntoBuildingTask:new(ASuperSurvivor,nil))	
			TaskMangerIn:AddToTop(WanderTask:new(ASuperSurvivor))
			TaskMangerIn:AddToTop(FindBuildingTask:new(ASuperSurvivor))
		end	
	end
	
	-- ----------------------------- --
	-- find safe place if injured and enemies near		this needs updating
	-- ----------------------------- --
		--	if (TaskMangerIn:getCurrentTask() ~= "Find Building") and (TaskMangerIn:getCurrentTask() ~= "Flee") and (IHaveInjury) and (ASuperSurvivor:getDangerSeenCount() > 0) then
		if not (AiNPC_Job_Is(NPC,"Companion"))  then
			if (TaskMangerIn:getCurrentTask() ~= "Find Building")
			and (TaskMangerIn:getCurrentTask() ~= "First Aide") 
			and (TaskMangerIn:getCurrentTask() ~= "Flee") 
			and ((IHaveInjury) and (ASuperSurvivor:isTooScaredToFight())) 
			and (ASuperSurvivor:getDangerSeenCount() > 0) 
			then
				TaskMangerIn:AddToTop(FindBuildingTask:new(ASuperSurvivor))
				ASuperSurvivor:DebugSay("Find Safe place if Injured condition triggered! Reference Number FBTII_000_01")
			end
		end
	-- ----------------------------- --
	-- bandage injuries if no threat near by
	-- Companions have their own healing rule
	-- ----------------------------- --
	if not (AiNPC_Job_Is(NPC,"Companion")) then
		if (IHaveInjury) then
			if (TaskMangerIn:getCurrentTask() ~= "First Aide") 
			  and (TaskMangerIn:getCurrentTask() ~= "Flee") 
			  and (TaskMangerIn:getCurrentTask() ~= "Doctor") 
			  and (TaskMangerIn:getCurrentTask() ~= "Hold Still") 
			  and ((NPC:getSeenCount() >= 1) and (Distance_AnyEnemy <= 6)) -- This line doesn't make sense, what if the npc needs to heal outside of hostiles?
			then
				TaskMangerIn:AddToTop(FirstAideTask:new(ASuperSurvivor)) -- If general healing
				TaskMangerIn:AddToTop(FleeTask:new(ASuperSurvivor))
				NPC:NPC_ShouldRunOrWalk()
				
					if ((NPC:getSeenCount() >= 3) and (Distance_AnyEnemy <= 3)) then -- If EMERGENCY run away and heal
						NPC:NPC_ShouldRunOrWalk()
						TaskMangerIn:AddToTop(FirstAideTask:new(ASuperSurvivor))
						TaskMangerIn:AddToTop(FleeTask:new(ASuperSurvivor))
						TaskMangerIn:AddToTop(FleeFromHereTask:new(ASuperSurvivor,ASuperSurvivor:Get():getCurrentSquare()))
					end 
				 
				ASuperSurvivor:DebugSay("Bandage Injuries if no threat nearby triggered! Reference Number 000_000_02")
			end
		end	
	end

	-- ----------------------------- --
	-- flee from too many zombies
	-- ----------------------------- --
	if not (AiNPC_Job_Is(NPC,"Companion"))  then -- To ABSOLUTELY prevent these two jobs from listening to this task.
		if (TaskMangerIn:getCurrentTask() ~= "Flee") 
		and (TaskMangerIn:getCurrentTask() ~= "Surender") 
		and ((TaskMangerIn:getCurrentTask() ~= "Surender") and not EnemyIsSurvivor) 
		--and ((ASuperSurvivor:getDangerSeenCount() > 0) and (ASuperSurvivor:isTooScaredToFight()))
		--and ( ((NPC:getSeenCount() > 4) and (NPC:isEnemyInRange()) and (EnemyIsZombie)) or (ASuperSurvivor:isTooScaredToFight()) )
		and 
		( 
		   (not ASuperSurvivor:hasWeapon() and (ASuperSurvivor:usingGun() == false) and ((ASuperSurvivor:getDangerSeenCount() > 0) and (NPC:getSeenCount() >= 3)) ) -- If one enemy is VERY close & see 3 or more enemies
--		or ( ((ASuperSurvivor:needToReload()) or (ASuperSurvivor:needToReadyGun(weapon))) and ( (ASuperSurvivor:getDangerSeenCount() > 1) or ((NPC:getSeenCount() >= 2) and (Distance_AnyEnemy <= 3))) )  -- AH HA, gun running away for non-companions when the npc is trying to reload or ready gun
		or ( ((ASuperSurvivor:needToReload()) or (ASuperSurvivor:needToReadyGun(weapon))) and ( (ASuperSurvivor:getDangerSeenCount() > 1 and (Distance_AnyEnemy < 3) and (EnemyIsZombie)) 	 or 	((NPC:getSeenCount() >= 2) and (Distance_AnyEnemy <= 2) and (EnemyIsZombie)) ) )  -- AH HA, gun running away for non-companions when the npc is trying to reload or ready gun
		or ( ((ASuperSurvivor:needToReload()) or (ASuperSurvivor:needToReadyGun(weapon))) and ( (ASuperSurvivor:getDangerSeenCount() > 1 and (Distance_AnyEnemy <= 2) and (EnemyIsSurvivor)) or 	( (Distance_AnyEnemy <= 2) and (EnemyIsSurvivor)) ) )  							  -- AH HA, gun running away for non-companions when the npc is trying to reload or ready gun
		or (IHaveInjury and ASuperSurvivor:getDangerSeenCount() > 0) 
		or (EnemyIsSurvivorHasGun and ASuperSurvivor:hasGun() == false)
		or (ASuperSurvivor:isTooScaredToFight())
		 
		 -- To check for EnemyIsZombie, which will look there and go 'OH GOD, I can't fight THIS many zombies' 
		 -- Update: I may of already fixed this issue on the lines above... 
		 -- now that I understand that getDangerSeenCount means if something is like SUPER close to the npc, you can simulate 
		 -- the idea of 'there's an enemy basically on me and I see more in the distance, I don't think this is worth fighting'
		or (
				(   (NPC:getSeenCount() > 4) and (NPC:isEnemyInRange()) and (EnemyIsZombie) and (NPC:hasGun())		)
			or
				(   (NPC:getSeenCount() > 4) and (EnemyIsZombie) and (not NPC:hasGun()) 	)
			)									
		) 
		then
				
		if(TaskMangerIn:getCurrentTask() == "LootCategoryTask") then -- currently to dangerous to loot said building. so give up it
			TaskMangerIn:getTask():ForceFinish()
			ASuperSurvivor:DebugSay("Force Finish Task Triggered in the 'Flee from too many Zombies' condition! Reference Number LCT_000_01")
		end
			ASuperSurvivor:getTaskManager():clear()
			TaskMangerIn:AddToTop(FleeTask:new(ASuperSurvivor))
			TaskMangerIn:AddToTop(FleeFromHereTask:new(ASuperSurvivor,ASuperSurvivor:Get():getCurrentSquare()))
			NPC:NPC_ShouldRunOrWalk()
			NPC:NPC_EnforceWalkNearMainPlayer()
			ASuperSurvivor:DebugSay("Flee from too many zombies condition triggered! Reference Number LCT_000_02")
		end
	end
	
	
	-- ----------------------------- --
	-- If NPC is Starving or drhydrating, force leave group
	-- To do - Give player option to let this task happen or not too
	-- ----------------------------- --
	if (false) and (ASuperSurvivor:getAIMode() ~= "Random Solo") and ((ASuperSurvivor:isStarving()) or (ASuperSurvivor:isDyingOfThirst())) then  
		
		-- leave group and look for food if starving
		ASuperSurvivor:DebugSay("Left the building because starving or thirsty condition triggered! Reference Number 000_000_04")

		ASuperSurvivor:setAIMode("Random Solo") 
		
		if(ASuperSurvivor:getGroupID() ~= nil) then
			local group = SSGM:Get(ASuperSurvivor:getGroupID())
			group:removeMember(ASuperSurvivor:getID())
		end
		ASuperSurvivor:getTaskManager():clear()
		if (ASuperSurvivor:Get():getStats():getHunger() > 0.40) then ASuperSurvivor:Get():getStats():setHunger(0.40) end
		if (ASuperSurvivor:Get():getStats():getThirst() > 0.40) then ASuperSurvivor:Get():getStats():setThirst(0.40) end
		ASuperSurvivor:Speak(getText("ContextMenu_SD_LeaveGroupHungry"))
		
	elseif (TaskMangerIn:getCurrentTask() ~= "Enter New Building") and (TaskMangerIn:getCurrentTask() ~= "Clean Inventory") and (IsInAction == false) and (TaskMangerIn:getCurrentTask() ~= "Eat Food") and (TaskMangerIn:getCurrentTask() ~= "Find This") and (TaskMangerIn:getCurrentTask() ~= "First Aide")and (TaskMangerIn:getCurrentTask() ~= "Listen") and (((ASuperSurvivor:isHungry()) and (IsInBase)) or ASuperSurvivor:isVHungry() ) and (ASuperSurvivor:getDangerSeenCount() == 0) then

		if(not ASuperSurvivor:hasFood()) and (ASuperSurvivor:getNoFoodNearBy() == false) and ((getSpecificPlayer(0) == nil) or (not getSpecificPlayer(0):isAsleep())) then

			if(HisGroup) then 
				local area = HisGroup:getGroupAreaCenterSquare("FoodStorageArea")
				if(area) then 
					ASuperSurvivor:DebugSay("Hunber/Thirst-Like Conditions Met in AImanager - Reference Number DHFB_0002")
					ASuperSurvivor:walkTo(area) 
				end
			end	
			TaskMangerIn:AddToTop(FindThisTask:new(ASuperSurvivor, "Food", "Category", 1))
			ASuperSurvivor:DebugSay("Hunber/Thirst-Like Conditions Met in AImanager - Reference Number DHFB_0003")
			
		elseif (ASuperSurvivor:hasFood()) then
		
			ASuperSurvivor:DebugSay("Hunber/Thirst-Like Conditions Met in AImanager - Reference Number DHFB_0004")
			TaskMangerIn:AddToTop(EatFoodTask:new(ASuperSurvivor,ASuperSurvivor:getFood()))
			
		end
	end
	
	-- ----------------------------- --
	-- Find food / drink - like task --
	-- ----------------------------- --
	if  (TaskMangerIn:getCurrentTask() ~= "Enter New Building") and (IsInAction == false) and (TaskMangerIn:getCurrentTask() ~= "Eat Food") and (TaskMangerIn:getCurrentTask() ~= "Find This") and (TaskMangerIn:getCurrentTask() ~= "First Aide") and (((ASuperSurvivor:isThirsty()) and (IsInBase)) or ASuperSurvivor:isVThirsty() ) and (ASuperSurvivor:getDangerSeenCount() == 0) then
		if(ASuperSurvivor:getNoWaterNearBy() == false) and ((getSpecificPlayer(0) == nil) or (not getSpecificPlayer(0):isAsleep())) then
			if(HisGroup) then 
				local area = HisGroup:getGroupAreaCenterSquare("FoodStorageArea")
				if(area) then ASuperSurvivor:walkTo(area) end
			end
			TaskMangerIn:AddToTop(FindThisTask:new(ASuperSurvivor, "Water", "Category", 1))
			ASuperSurvivor:DebugSay("Not enter new building condition met! Condition number (to compare in ai manager file) 0004")
		end		
	end


	-- ----------------------------- --
	-- 			Listen to Task
	-- ----------------------------- --
	if(
		(ASuperSurvivor:Get():getModData().InitGreeting ~= nil)
		or (ASuperSurvivor:getAIMode() == "Random Solo")
	)
	and (TaskMangerIn:getCurrentTask() ~= "Listen")
	and (TaskMangerIn:getCurrentTask() ~= "Surender")
	and (TaskMangerIn:getCurrentTask() ~= "Flee From Spot")
	and (TaskMangerIn:getCurrentTask() ~= "Take Gift")
	and (ASuperSurvivor.LastSurvivorSeen ~= nil)
	--and (ASuperSurvivor.LastSurvivorSeen:isGhostMode() == false)
	and (ASuperSurvivor:getSpokeTo(ASuperSurvivor.LastSurvivorSeen:getModData().ID) == false)
	and (getDistanceBetween(ASuperSurvivor.LastSurvivorSeen,ASuperSurvivor:Get()) < 8)
	and (ASuperSurvivor:getDangerSeenCount()==0) and (TaskMangerIn:getCurrentTask() ~= "First Aide")
	and (ASuperSurvivor:Get():CanSee(ASuperSurvivor.LastSurvivorSeen)) 
	 then
		ASuperSurvivor:Speak(getText("ContextMenu_SD_HeyYou"))
		ASuperSurvivor:SpokeTo(ASuperSurvivor.LastSurvivorSeen:getModData().ID)
		ASuperSurvivor:DebugSay("Listen Task Condition Met! Reference Number 0005")
		TaskMangerIn:AddToTop(ListenTask:new(ASuperSurvivor,ASuperSurvivor.LastSurvivorSeen,true))
	 end


	-- ----------------------------- --
	-- 	Gun Readying / Reloading     -- 
	-- ----------------------------- --
	if not (AiNPC_Job_Is(NPC,"Companion"))  then
		if(ASuperSurvivor:getNeedAmmo())
		and (ASuperSurvivor:hasAmmoForPrevGun()) 
		and (IsInAction == false) 
		and (TaskMangerIn:getCurrentTask() ~= "Take Gift") 
		and (TaskMangerIn:getCurrentTask() ~= "Flee") 			-- New
		and (TaskMangerIn:getCurrentTask() ~= "Flee From Spot") -- New
		and (ASuperSurvivor:getDangerSeenCount()==0)  
		  then
			ASuperSurvivor:setNeedAmmo(false)
			-- Reminder: re-enable this
			ASuperSurvivor:reEquipGun()
			ASuperSurvivor:DebugSay("GetNeed ammo condition met in AiManager Triggered! Reference Number 006")
		  end
	end

	-- ----------------------------- --
	-- 	Equip Weapon Task            -- 
	-- ----------------------------- --
	if not (AiNPC_Job_Is(NPC,"Companion")) then
		if(ASuperSurvivor:hasWeapon()) and (ASuperSurvivor:Get():getPrimaryHandItem() == nil) and (TaskMangerIn:getCurrentTask() ~= "Equip Weapon")  then
				TaskMangerIn:AddToTop(EquipWeaponTask:new(ASuperSurvivor))
				ASuperSurvivor:DebugSay("Weapon related condition met in AI manager triggered! Reference number 007")
		end
	end

	-- ----------------------------- --
	-- 	Equip Weapon Task            -- 
	-- ----------------------------- --
	if not (AiNPC_Job_Is(NPC,"Companion"))  then
		if(IsInAction == false) and (ASuperSurvivor:getNeedAmmo() == false) and ASuperSurvivor:usingGun() and (ASuperSurvivor:getDangerSeenCount() == 0) and ((ASuperSurvivor:needToReload()) or (ASuperSurvivor:needToReadyGun(weapon))) and (NPC:NPC_FleeWhileReadyingGun()) then			
			--print(ASuperSurvivor:getName() .. " AI detected need to ready gun")
			ASuperSurvivor:ReadyGun(weapon)		
			if (NPC:isSpeaking() == false) then ASuperSurvivor:DebugSay("Weapon related condition met in AI manager triggered! Reference number 0008") end
		end	
	end
	
	-- ----------------------------- --
	-- 	Shift task quickly to attack -- 
	--  QuickFix for the stuck task  --
	-- ----------------------------- --
	--if not (AiNPC_Job_Is(NPC,"Companion"))  then
	--	if (NPC.LastEnemeySeen ~= nil) and ((NPC:isInSameRoom(NPC.LastEnemeySeen)) or (NPC:RealCanSee(NPC.LastEnemeySeen))) and (AiNPC_Task_Is(NPC,"Enter New Building")) then
	--		TaskMangerIn:AddToTop(AttackTask:new(ASuperSurvivor))
	--		NPC:DebugSay("Shifting from Enter New Building to Attack! Task! Reference Number ENB_T_PT_0001")
	--	end
	--end

	-- ---------------------------------------------------------- --
	-- ------ END -------- Shared AI ------ END ----------------- --
	-- ---------------------------------------------------------- --
	
	


	-- ---------------------------------------------------------- --
	-- ------------------- Base Tasks---------------------------- --
	-- ---------------------------------------------------------- --
	
	if(getSpecificPlayer(0) == nil) or (not getSpecificPlayer(0):isAsleep()) then
		SafeToGoOutAndWork = true
		local AutoWorkTaskTimeLimit = 300 
		
		
		if (NPC:getName() ~= nil) and (NPC:getAIMode() ~= nil) and (NPC:getCurrentTask() ~= nil) and (NPC:getGroupRole() ~= nil) and (NPC:getCurrentTask() ~= nil) and (IsInAction ~= nil) then
			print("basetasks " .. ASuperSurvivor:getName().." "..ASuperSurvivor:getAIMode() .. " " .. TaskMangerIn:getCurrentTask() .. " " .. ASuperSurvivor:getGroupRole() .. " " .. ASuperSurvivor:getCurrentTask() .. " " .. tostring(IsInAction))
			print("")
		end
		
		if(not SurvivorsFindWorkThemselves or not IsInBase) and (ASuperSurvivor:getGroupRole() == "Guard") and (ASuperSurvivor:getCurrentTask() == "None") and (not IsInAction) and (ZombRand(4)==0) then
				
			local randresult = ZombRand(10) + 1
			--print("Guard - random job result is:"..tostring(randresult))
			if(randresult == 1) then
			
				ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoRelax"))
				TaskMangerIn:AddToTop(WanderInBaseTask:new(ASuperSurvivor))
				ASuperSurvivor:DebugSay("Relax condition met in AI manager! Reference number 0009")
				
			else
			
				local area = HisGroup:getGroupArea("GuardArea")
				if(area) then 		
					ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoGuard"))
					TaskMangerIn:AddToTop(WanderInAreaTask:new(ASuperSurvivor,area)) 					
					TaskMangerIn:setTaskUpdateLimit(AutoWorkTaskTimeLimit)
					ASuperSurvivor:DebugSay("Guard area condition met in AI manager! Reference number 000-10")
				else
					print("area was nil")
					ASuperSurvivor:DebugSay("Guard condition met in AI manager! Reference number 000-11")
				end
			end
		
		elseif (ASuperSurvivor:getCurrentTask() == "None") and (IsInBase) and (not IsInAction) and (ZombRand(4)==0) then
			
			if(not SurvivorsFindWorkThemselves) and (ASuperSurvivor:getGroupRole() == "Doctor") then
				local randresult = ZombRand(10) + 1
				--print("Doctor - random job result is:"..tostring(randresult))
				if(randresult == 1) then
				
					ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoRelax"))
					TaskMangerIn:AddToTop(WanderInBaseTask:new(ASuperSurvivor))
					ASuperSurvivor:DebugSay("Wander In base condition met in AI manager! Reference number 000-12")
					
				else
			
					local medicalarea = HisGroup:getGroupArea("MedicalStorageArea")
					ASuperSurvivor:DebugSay("Wander in base condition met in AI manager! Reference number 000-13")
					
					local gotoSquare
					if(medicalarea) and (medicalarea[1] ~= 0) then gotoSquare = getCenterSquareFromArea(medicalarea[1],medicalarea[2],medicalarea[3],medicalarea[4],medicalarea[5]) end
					if(not gotoSquare) then gotoSquare = CenterBaseSquare end
					
					if(gotoSquare ) then ASuperSurvivor:walkTo(gotoSquare) end
					TaskMangerIn:AddToTop(DoctorTask:new(ASuperSurvivor))
					return TaskMangerIn
				end
			
				
			elseif(not SurvivorsFindWorkThemselves) and (ASuperSurvivor:getGroupRole() == "Farmer") then
				
				if(SurvivorsFindWorkThemselves) and (RainManager.isRaining() == false) then
					local randresult = ZombRand(10) + 1
					--print("random job result is:"..tostring(randresult))
					if(randresult == 1) then
					
						ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoRelax"))
						TaskMangerIn:AddToTop(WanderInBaseTask:new(ASuperSurvivor))
						TaskMangerIn:setTaskUpdateLimit(AutoWorkTaskTimeLimit)
						
					else
					
						local area = HisGroup:getGroupArea("FarmingArea")
						if(area) then 		
							ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoFarm"))
							TaskMangerIn:AddToTop(FarmingTask:new(ASuperSurvivor)) 					
							TaskMangerIn:setTaskUpdateLimit(AutoWorkTaskTimeLimit)					
						else
						--	print("farming area was nil")
						end
					end
				end
				
			-- ModderNote: From what I've observed, companion isn't used on anything else except to follow
			-- So exploiting that knowledge, I made the companion more of a 'class job priority' set of jobs at the top of the code.
			-- So if you are another modder that has the torch, that's looking to make Followers listen to you more, Follower = 'companion'
			elseif(ASuperSurvivor:getGroupRole() == "Companion") then -- Not new, this was here before

					TaskMangerIn:AddToTop(FollowTask:new(ASuperSurvivor,getSpecificPlayer(0))) 	

			elseif(SurvivorsFindWorkThemselves) then
				print("yes im a worker: "..tostring(ASuperSurvivor:Get():getBodyDamage():getWetness()))

				--if(RainManager.isRaining()) and (ASuperSurvivor:Get():getBodyDamage():getWetness() > 0.5) and (ASuperSurvivor:Get():isOutside()) and (TaskMangerIn.TaskUpdateLimit ~= 0) and (TaskMangerIn:getCurrentTask() ~= "Enter New Building") and (TaskMangerIn:getCurrentTask() ~= "Find Building") then
				--	ASuperSurvivor:Speak(getText("ContextMenu_SD_RainingGoInside"))
				--	TaskMangerIn:clear()
				--	TaskMangerIn:AddToTop(AttemptEntryIntoBuildingTask:new(ASuperSurvivor,nil))
				--	TaskMangerIn:AddToTop(FindBuildingTask:new(ASuperSurvivor))
				--end

				if (ASuperSurvivor:Get():getBodyDamage():getWetness() < 0.2) then
					--print(ASuperSurvivor:getName().."/" .. ASuperSurvivor:getGroupRole() .." yes i should look for work")
					if(SafeToGoOutAndWork) then
						TaskMangerIn:setTaskUpdateLimit(AutoWorkTaskTimeLimit)
						
						local forageSquare = HisGroup:getGroupAreaCenterSquare("ForageArea")
						local chopWoodSquare = HisGroup:getGroupAreaCenterSquare("ChopTreeArea")
						local farmingArea = HisGroup:getGroupArea("FarmingArea")
						local guardArea = HisGroup:getGroupArea("GuardArea")

						local jobScores = {}
						local job = "Relax"
						-- idle tasks
						jobScores["Relax"] = 0 + math.floor(ASuperSurvivor:Get():getStats():getBoredom() * 20.0)
						jobScores["Wash Self"] = 1

						-- maintenance
						jobScores["Clean Inventory"] = 2
						jobScores["Gather Wood"] = 2
						jobScores["Pile Corpses"] = 2

						-- skilled work
						jobScores["Chop Wood"] = 2 + math.min(ASuperSurvivor:Get():getPerkLevel(Perks.FromString("Axe")), 3)
						jobScores["Forage"] = 2 + math.min(ASuperSurvivor:Get():getPerkLevel(Perks.FromString("Foraging")), 3)

						-- deprioritize assigned tasks
						jobScores["Farming"] = 0 + math.min(ASuperSurvivor:Get():getPerkLevel(Perks.FromString("Farming")), 3)
						jobScores["Doctor"] = -2 + math.min(ASuperSurvivor:Get():getPerkLevel(Perks.FromString("Doctor")), 3) + math.min(ASuperSurvivor:Get():getPerkLevel(Perks.FromString("First Aid")), 3)
						jobScores["Guard"] = 2 + math.min(ASuperSurvivor:Get():getPerkLevel(Perks.FromString("Aiming")), 3)

						-- jobs requiring zoned areas
						if (forageSquare == nil) then jobScores["Forage"] = -10 end
						if (chopWoodSquare == nil) then jobScores["Chop Wood"] = -10 end
						if (farmingArea[1] == 0) then jobScores["Farming"] = -10 end
						if (guardArea[1] == 0) then jobScores["Guard"] = -10 end

						-- reduce scores for jobs already being worked on
						for key, value in pairs(jobScores) do
							if key == "Guard" then
								jobScores[key] = value - HisGroup:getTaskCount("Wander In Area")
							elseif key == "Doctor" then
								-- no point in more than one doctor at a time
								jobScores[key] = value - (HisGroup:getTaskCount(key) * 10)
							elseif key == "Farming" then
								-- no point in more than one farmer at a time
								jobScores[key] = value - (HisGroup:getTaskCount(key) * 10)
							elseif key == "Forage" then
								-- little point in more than one forager at a time
								jobScores[key] = value - (HisGroup:getTaskCount(key) * 2)
							else
								jobScores[key] = value - HisGroup:getTaskCount(key)
							end
						end

						-- rainy days
						if RainManager.isRaining() then
							jobScores["Wash Self"] = jobScores["Wash Self"] + 2 -- can wash in puddles
							jobScores["Farming"] = jobScores["Farming"] - 10 -- really no reason to do this
							jobScores["Gather Wood"] = jobScores["Gather Wood"] - 1
							jobScores["Pile Corpses"] = jobScores["Pile Corpses"] - 2
							jobScores["Chop Wood"] = jobScores["Chop Wood"] - 3
							jobScores["Forage"] = jobScores["Forage"] - 3
						end
						if ASuperSurvivor:Get():getBodyDamage():getWetness() > 0.5 then
							-- do indoor stuff to dry off
							jobScores["Relax"] = jobScores["Relax"] + 3
							jobScores["Clean Inventory"] = jobScores["Clean Inventory"] + 3
							jobScores["Wash Self"] = jobScores["Wash Self"] + 2
						end

						-- personal needs
						local filth = ASuperSurvivor:getFilth()
						if filth < 1 then jobScores["Wash Self"] = jobScores["Wash Self"] - 2
						elseif filth < 5 then jobScores["Wash Self"] = jobScores["Wash Self"] - 1
						elseif filth < 10 then jobScores["Wash Self"] = jobScores["Wash Self"] + 1
						elseif filth < 15 then jobScores["Wash Self"] = jobScores["Wash Self"] + 2
						else jobScores["Wash Self"] = jobScores["Wash Self"] + 3 end

						-- randomize
						for key, value in pairs(jobScores) do
							jobScores[key] = ZombRand(0, value)
						end

						-- priority assignments (post-randomize)
						if ASuperSurvivor:getGroupRole() == "Doctor" then
							jobScores["Doctor"] = jobScores["Doctor"] + 3
						elseif ASuperSurvivor:getGroupRole() == "Farmer" then
							jobScores["Farming"] = jobScores["Farming"] + 3
						elseif ASuperSurvivor:getGroupRole() == "Guard" then
							jobScores["Guard"] = jobScores["Guard"] + 3
						end

						-- find the best task
						for key, value in pairs(jobScores) do
							--print(key..":"..tostring(value))
							if value >= jobScores[job] then job = key end
						end

						ASuperSurvivor:Get():getStats():setBoredom(ASuperSurvivor:Get():getStats():getBoredom() + (ZombRand(5) / 100.0))
						if(job == "Relax") then
							ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoRelax"))
							ASuperSurvivor:Get():getStats():setBoredom(0.0)
							TaskMangerIn:AddToTop(WanderInBaseTask:new(ASuperSurvivor))

						elseif(job == "Gather Wood") then
							ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoGetWood"))
							local dropSquare = CenterBaseSquare
							local woodstoragearea = HisGroup:getGroupArea("WoodStorageArea")
							if(woodstoragearea[1] ~= 0) then dropSquare = getCenterSquareFromArea(woodstoragearea[1],woodstoragearea[2],woodstoragearea[3],woodstoragearea[4],woodstoragearea[5]) end
							TaskMangerIn:AddToTop(GatherWoodTask:new(ASuperSurvivor,dropSquare)) 
							TaskMangerIn:setTaskUpdateLimit(AutoWorkTaskTimeLimit)

						elseif(job == "Pile Corpses") then
							ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoPileCorpse"))
							local baseBounds = HisGroup:getBounds()
							local dropSquare = getCell():getGridSquare(baseBounds[1]-5,baseBounds[3]-5,0)
							local storagearea = HisGroup:getGroupArea("CorpseStorageArea")
							if(storagearea[1] ~= 0) then dropSquare = getCenterSquareFromArea(storagearea[1],storagearea[2],storagearea[3],storagearea[4],storagearea[5]) end
							if(dropSquare) then
								TaskMangerIn:AddToTop(PileCorpsesTask:new(ASuperSurvivor,dropSquare)) 
								TaskMangerIn:setTaskUpdateLimit(AutoWorkTaskTimeLimit)
							end

						elseif(job == "Forage") then
							local dropSquare = CenterBaseSquare
							local FoodStorageCenter = HisGroup:getGroupAreaCenterSquare("FoodStorageArea")
							if(FoodStorageCenter) then dropSquare = FoodStorageCenter end
							
							if(forageSquare ~= nil) then 				
								ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoForage"))
								ASuperSurvivor:walkTo(forageSquare)
								TaskMangerIn:AddToTop(CleanInvTask:new(ASuperSurvivor,dropSquare,false)) 
								TaskMangerIn:AddToTop(ForageTask:new(ASuperSurvivor)) 
								TaskMangerIn:setTaskUpdateLimit(AutoWorkTaskTimeLimit)
							else
							--	print("forageSquare was nil")
							end

						elseif(job == "Chop Wood") then
							if(chopWoodSquare) then 		
								ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoChopWood"))
								TaskMangerIn:AddToTop(ChopWoodTask:new(ASuperSurvivor)) 					
								TaskMangerIn:setTaskUpdateLimit(AutoWorkTaskTimeLimit)					
							else
							--	print("chopWoodArea was nil")
							end

						elseif(job == "Farming") then
							if(farmingArea) then 		
								ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoFarm"))
								TaskMangerIn:AddToTop(FarmingTask:new(ASuperSurvivor)) 					
								TaskMangerIn:setTaskUpdateLimit(AutoWorkTaskTimeLimit)					
							else
							--	print("farmingArea area was nil")
							end

						elseif(job == "Guard") then
							if(guardArea) then 		
								ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoGuard"))
								TaskMangerIn:AddToTop(WanderInAreaTask:new(ASuperSurvivor, guardArea)) 					
								TaskMangerIn:setTaskUpdateLimit(AutoWorkTaskTimeLimit)					
							else
							--	print("guardArea was nil")
							end
							
						elseif(job == "Doctor") then
							local medicalarea = HisGroup:getGroupArea("MedicalStorageArea")
							
							local gotoSquare
							if(medicalarea) and (medicalarea[1] ~= 0) then gotoSquare = getCenterSquareFromArea(medicalarea[1],medicalarea[2],medicalarea[3],medicalarea[4],medicalarea[5]) end
							if(not gotoSquare) then gotoSquare = CenterBaseSquare end
							
							if(gotoSquare ) then ASuperSurvivor:walkTo(gotoSquare) end
							TaskMangerIn:AddToTop(DoctorTask:new(ASuperSurvivor))					
							TaskMangerIn:setTaskUpdateLimit(AutoWorkTaskTimeLimit)

						elseif(job == "Clean Inventory") then
							ASuperSurvivor:Speak("Cleaning Inventory")
							local dropSquare = CenterBaseSquare
							local ToolStorageCenter = HisGroup:getGroupAreaCenterSquare("ToolStorageArea")
							if(ToolStorageCenter) then dropSquare = ToolStorageCenter end
							TaskMangerIn:AddToTop(CleanInvTask:new(ASuperSurvivor,dropSquare,false)) 
							
						elseif(job == "Wash Self") then
							ASuperSurvivor:Speak("Washing Self")
							TaskMangerIn:AddToTop(WashSelfTask:new(ASuperSurvivor)) 
							
						end
					else
						TaskMangerIn:AddToTop(WanderInBaseTask:new(ASuperSurvivor))
					end -- safeto go out end
				end -- allowed to go out work end
			end
		end
		
		-- Oop, found this. I could use this for followers to get back to main player
		if (ASuperSurvivor:getCurrentTask() == "None") and (IsInBase == false) and (not IsInAction) and (HisGroup~=nil) then
			local baseSq = CenterBaseSquare
			if(baseSq ~= nil) then 
				ASuperSurvivor:Speak(getText("ContextMenu_SD_IGoBackBase"))
				TaskMangerIn:AddToTop(ReturnToBaseTask:new(ASuperSurvivor)) 
				ASuperSurvivor:DebugSay("none task condition met in AI manager! Reference number Alt_000-A01")
			end
		end
	end	

	-- ----------------------------------------------------------- --
	-- ------ END -------- Base Tasks ------- END ---------------- --
	-- ----------------------------------------------------------- --

	-- TODO test: maybe add 'if not in attack / pursue / threaten , then do ' along with the 'none tasks'
	-- if(ASuperSurvivor.DebugMode) then print(ASuperSurvivor:getAIMode()) end
	
	if(ASuperSurvivor:getAIMode() == "Random Solo") and (TaskMangerIn:getCurrentTask() ~= "Listen") and (TaskMangerIn:getCurrentTask() ~= "Take Gift") then -- solo random survivor AI flow	

		if(TaskMangerIn:getCurrentTask() == "None") and (ASuperSurvivor.TargetBuilding ~= nil) and (not ASuperSurvivor:getBuildingExplored(ASuperSurvivor.TargetBuilding)) and (not ASuperSurvivor:isEnemyInRange(ASuperSurvivor.LastEnemeySeen)) then
			TaskMangerIn:AddToTop(AttemptEntryIntoBuildingTask:new(ASuperSurvivor, ASuperSurvivor.TargetBuilding))
			ASuperSurvivor:DebugSay("Attempt entry into building Task condition met in AI manager! Reference number B_0001")

--		V backup just in case
--		elseif(TaskMangerIn:getCurrentTask() == "None") then
		elseif(TaskMangerIn:getCurrentTask() == "None") and ((not EnemyIsSurvivor) or (not ASuperSurvivor:isEnemyInRange(ASuperSurvivor.LastEnemeySeen)) )then
			TaskMangerIn:AddToTop(FindUnlootedBuildingTask:new(ASuperSurvivor))
			ASuperSurvivor:DebugSay("Find Unlooted Building Task condition met in AI manager! Reference number B_0002")
		end
		
		if(ASuperSurvivor.TargetBuilding ~= nil) or (ASuperSurvivor:inUnLootedBuilding())then
			if ASuperSurvivor.TargetBuilding == nil then ASuperSurvivor.TargetBuilding = ASuperSurvivor:getBuilding() end
			if (not ASuperSurvivor:hasWeapon()) and (TaskMangerIn:getCurrentTask() ~= "Loot Category") and (ASuperSurvivor:getDangerSeenCount() <= 0) and (ASuperSurvivor:inUnLootedBuilding()) and (NPC:isTargetBuildingClaimed(ASuperSurvivor.TargetBuilding) == false) then
				ASuperSurvivor:DebugSay("Loot Task condition met in AI manager! Reference number B_0003")
				TaskMangerIn:AddToTop(LootCategoryTask:new(ASuperSurvivor,ASuperSurvivor.TargetBuilding,"Food",2))
				TaskMangerIn:AddToTop(EquipWeaponTask:new(ASuperSurvivor))
				TaskMangerIn:AddToTop(LootCategoryTask:new(ASuperSurvivor,ASuperSurvivor.TargetBuilding,"Weapon",2))
			elseif (ASuperSurvivor:hasRoomInBag()) and (TaskMangerIn:getCurrentTask() ~= "Loot Category") and (ASuperSurvivor:getDangerSeenCount() <= 0) and (ASuperSurvivor:inUnLootedBuilding()) and (NPC:isTargetBuildingClaimed(ASuperSurvivor.TargetBuilding) == false) then
				TaskMangerIn:AddToTop(LootCategoryTask:new(ASuperSurvivor,ASuperSurvivor.TargetBuilding,"Food",1))
				ASuperSurvivor:DebugSay(" Task condition met in AI manager! Reference number B_0004")
			end
		end
		if (SurvivorBases) and 
		    (IsInAction == false) and 									-- New. Hopefully to stop spam
			(ASuperSurvivor:getBaseBuilding() == nil) and 
			(ASuperSurvivor:getBuilding()) and 
			(TaskMangerIn:getCurrentTask() ~= "First Aide") and 
			(TaskMangerIn:getCurrentTask() ~= "Attack") and 
			(TaskMangerIn:getCurrentTask() ~= "Threaten") and			-- new
			(TaskMangerIn:getCurrentTask() ~= "Pursue") and				-- new
			(TaskMangerIn:getCurrentTask() ~= "Enter New Building") and -- new
			(TaskMangerIn:getCurrentTask() ~= "Barricade Building") and 
			(ASuperSurvivor:hasWeapon())  and 
			(ASuperSurvivor:getGroupRole() ~= "Companion") and			-- New
			(ASuperSurvivor:isInSameBuildingWithEnemyAlt() == false)  and -- That way npc doesn't stop what they're doing moment they look away from a hostile
			(ASuperSurvivor:hasFood()) 
		then
			ASuperSurvivor:DebugSay("Wander in building Task condition met in AI manager! Reference number C_0001")
			TaskMangerIn:clear()
			ASuperSurvivor:setBaseBuilding(ASuperSurvivor:getBuilding())
			TaskMangerIn:AddToTop(WanderInBuildingTask:new(ASuperSurvivor,ASuperSurvivor:getBuilding()))
			TaskMangerIn:AddToTop(LockDoorsTask:new(ASuperSurvivor,true))
			TaskMangerIn:AddToTop(BarricadeBuildingTask:new(ASuperSurvivor))
			ASuperSurvivor:Speak("This will be my base.")
			--print(ASuperSurvivor:getName() .. " making base")
			local GroupId = SSGM:GetGroupIdFromSquare(ASuperSurvivor:Get():getCurrentSquare())
			--ASuperSurvivor:Speak(tostring(GroupId))
			if(GroupId == -1) then -- if the base this npc is gonna stay in is not declared as another base then they set it as thier base.
			--	print("New base")
				local nGroup = SSGM:newGroup()					
				nGroup:addMember(ASuperSurvivor,"Leader")
				local def = ASuperSurvivor:getBuilding():getDef()
				local bounds = {def:getX()-1,(def:getX() + def:getW()+1 ), def:getY()-1,(def:getY() + def:getH()+1),0}
				nGroup:setBounds(bounds)
				--ASuperSurvivor:Speak(tostring(nGroup:getID()))
			elseif(GroupId ~= SSM:Get(0):getGroupID()) then
				local OwnerGroup = SSGM:Get(GroupId)
				local LeaderID = OwnerGroup:getLeader()
			--	print("Joining g:" .. GroupId .. " l:" .. LeaderID)
				if(LeaderID ~= 0) then
					OwnerGroup:addMember(ASuperSurvivor,"Worker")
					ASuperSurvivor:Speak("Please let me stay here")
					local LeaderObj = SSM:Get(LeaderID)
					if(LeaderObj) then
						LeaderObj:Speak("Welcome to our Group")
					--	print("Accepted by " .. LeaderObj:getName())
					end
				end
			end
			
		end
		
		
		if ((SurvivorBases) and (ASuperSurvivor:isStarving()) or (ASuperSurvivor:isDyingOfThirst())) and (ASuperSurvivor:getBaseBuilding() ~= nil) then  -- leave group and look for food if starving
			-- random survivor in base is starving - reset so he goes back out looking for food and re base there
			--print(ASuperSurvivor:getName() .. " leaving group because starving")

			ASuperSurvivor:setAIMode("Random Solo") 
			if(ASuperSurvivor:getGroupID() ~= nil) then
				local group = SSGM:Get(ASuperSurvivor:getGroupID())
				group:removeMember(ASuperSurvivor:getID())
			end
			ASuperSurvivor:getTaskManager():clear()
			ASuperSurvivor:Speak(getText("ContextMenu_SD_LeaveBCHungry"))
			ASuperSurvivor:resetAllTables()
			ASuperSurvivor:setBaseBuilding(nil)
			if (ASuperSurvivor:Get():getStats():getHunger() > 0.30) then ASuperSurvivor:Get():getStats():setHunger(0.30) end
			if (ASuperSurvivor:Get():getStats():getThirst() > 0.30) then ASuperSurvivor:Get():getStats():setThirst(0.30) end
			
		end
			
	
	
	end
	
	

	--if(ASuperSurvivor.DebugMode) then ASuperSurvivor:DebugSay(ASuperSurvivor:getName().." "..ASuperSurvivor:getAIMode() .. " AIManager3 " .. TaskMangerIn:getCurrentTask()) end
	
	
	return TaskMangerIn

end