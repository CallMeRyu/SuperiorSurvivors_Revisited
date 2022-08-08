local chance = 0
local NPC = nil
local EnemyIsSurvivor = false
local EnemyIsZombie = false
local EnemySuperSurvivor = nil
local LastSuperSurvivor = nil
local EnemyIsSurvivorHasGun = false
local LastSurvivorHasGun = false
local HostileInNPCsRange = false
local IHaveInjury = false
local weapon = false
local IsInAction = false
local HisGroup = false
local IsInBase = false
local CenterBaseSquare = nil
local DistanceBetweenMainPlayer = 0
local Distance_AnyEnemy = 0

function AiNPC_Task_Is(task_manager, task_name)
	return task_manager:getCurrentTask() == task_name
end

function AiNPC_TaskIsNot(task_manager, task_name)
	return task_manager:getCurrentTask() ~= task_name
end

function AiNPC_Job_Is(NPC, job_name)
	return NPC:getGroupRole() == job_name
end

function AiNPC_Job_IsNot(NPC, job_name)
	return NPC:getGroupRole() ~= job_name
end

local function AiNpc_Task_Is_AnyOf(task_manager, tasks)
	for _, task in ipairs(tasks) do
		if AiNPC_Task_Is(task_manager, task) then
			return true
		end
	end
	return false
end

local function AiNpc_IsTarget_Survivor(NPC)
	return instanceof(NPC.LastEnemeySeen, "IsoZombie")
end

local function AiNpc_IsTarget_Zombie(NPC)
	return instanceof(NPC.LastEnemeySeen, "IsoPlayer")
end

local function AiNpc_HaveTooManyInjuries(NPC)
	return NPC:isTooScaredToFight() and NPC:HasInjury()
end

local function AiNpc_IsInDanger(NPC)
	local hasWeapon = NPC:hasWeapon() 
	local enemyIsSurvivor = AiNpc_IsTarget_Survivor(NPC)
	local dangerCount = NPC:getDangerSeenCount()
	local isEnemyInRange = NPC:isEnemyInRange(NPC.LastEnemeySeen)
	return (hasWeapon and (dangerCount >= 1 or isEnemyInRange)) or (not hasWeapon and dangerCount == 1 and not enemyIsSurvivor)
end

local function AiNPC_CanAttack(task_manager,NPC) 
	local forbidenTasks = {"Attack","Threaten","First Aide"};
	local canAttack = not AiNpc_Task_Is_AnyOf(task_manager,forbidenTasks)
	local isInTheSameRoom = NPC:isInSameRoom(NPC.LastEnemeySeen)
	local hasNotFellDown = not NPC:HasFellDown()
	local isNotTooScaredToFight = not NPC:isTooScaredToFight()
	return canAttack and isInTheSameRoom and hasNotFellDown and AiNpc_IsInDanger(NPC) and isNotTooScaredToFight
end

--****************************************************
-- Base tasks (not edited)
--****************************************************
-- 1 sub task composed of 3 tasks,
-- task 1: composed of 1 task,
-- task 2: fuck this,
-- like 10 important tasks.
--local tick_base_tasks = 0
local function base_tasks(task_manager)

	--tick_base_tasks = tick_base_tasks+1
	--if tick_base_tasks == 11 then tick_base_tasks = 0 end
	--
	--if tick_base_tasks == 1 then task_1() end
	--if tick_base_tasks == 2 then task_2() end
	--if tick_base_tasks == 3 then task_3() end
	--if tick_base_tasks == 4 then task_4() end
	--if tick_base_tasks == 5 then task_5() end
	--if tick_base_tasks == 6 then task_6() end
	--if tick_base_tasks == 7 then task_7() end
	--if tick_base_tasks == 8 then task_8() end
	--if tick_base_tasks == 9 then task_9() end
	--if tick_base_tasks == 10 then task_10() end

	if(getSpecificPlayer(0) == nil) or (not getSpecificPlayer(0):isAsleep()) then
		SafeToGoOutAndWork = true
		local AutoWorkTaskTimeLimit = 300

		-- -------
		-- Guard
		-- -------
		if (NPC:getGroupRole() == "Guard") then
			-- if getGroupArea 'getGroupArea = does this area exist'

			if ( task_manager:getCurrentTask() ~= "Attack" and task_manager:getCurrentTask() ~= "Threaten" and task_manager:getCurrentTask() ~= "Pursue" and task_manager:getCurrentTask() ~= "Flee" and task_manager:getCurrentTask() ~= "First Aide" and task_manager:getCurrentTask() ~= "Find This" and task_manager:getCurrentTask() ~= "Eat Food" and task_manager:getCurrentTask() ~= "Follow" and (IsInAction == false) ) then

				if(HisGroup:getGroupAreaCenterSquare("GuardArea") ~= nil) and (HisGroup:getGroupArea("GuardArea")) then
					if (getDistanceBetween(HisGroup:getGroupAreaCenterSquare("GuardArea"), NPC:Get():getCurrentSquare()) > 10) then
						task_manager:clear()
						task_manager:AddToTop(GuardTask:new(NPC,getRandomAreaSquare(HisGroup:getGroupArea("GuardArea"))))
						NPC:DebugSay("GuardTask Cond_000_Cleared")
					else
						NPC:DebugSay("GuardTask Cond_000_failed_clear")
					end
				end

				if (getDistanceBetween(HisGroup:getGroupAreaCenterSquare("GuardArea"), NPC:Get():getCurrentSquare()) <= 10) then
					if(HisGroup:getGroupAreaCenterSquare("GuardArea") ~= nil) and (HisGroup:getGroupArea("GuardArea")) then
						task_manager:AddToTop(GuardTask:new(NPC,getRandomAreaSquare(HisGroup:getGroupArea("GuardArea"))))
						NPC:DebugSay("GuardTask Cond_0001")
					end
				end

				if(HisGroup:getGroupAreaCenterSquare("GuardArea") == nil) and (CenterBaseSquare ~= nil) and not (IsInBase) then
					task_manager:AddToTop(WanderInBaseTask:new(NPC))
					if (NPC:isSpeaking() == false) then	NPC:DebugSay("GuardTask Cond_0003") end

				elseif (HisGroup:getGroupAreaCenterSquare("GuardArea") == nil) and (CenterBaseSquare == nil) and not (IsInBase) then
					task_manager:AddToTop(GuardTask:new(NPC, HisGroup:getRandomBaseSquare() ))
					NPC:DebugSay("GuardTask Cond_0004 - Uh boss? There's no guard area OR base areas that you have set.")
				end

			else
				if  task_manager:getCurrentTask() == "Flee" then NPC:NPC_ShouldRunOrWalk() end
				if (NPC:isSpeaking() == false) then	NPC:DebugSay("GuardTask Cond_0005") end
			end

		end


		--if (NPC:getName() ~= nil) and (NPC:getAIMode() ~= nil) and (NPC:getCurrentTask() ~= nil) and (NPC:getGroupRole() ~= nil) and (NPC:getCurrentTask() ~= nil) and (IsInAction ~= nil) then
		----	print("basetasks " .. NPC:getName().." "..NPC:getAIMode() .. " " .. task_manager:getCurrentTask() .. " " .. NPC:getGroupRole() .. " " .. NPC:getCurrentTask() .. " " .. tostring(IsInAction))
		----	print("")
		--end

		if(not SurvivorsFindWorkThemselves or not IsInBase) and (NPC:getGroupRole() == "Guard") and (NPC:getCurrentTask() == "None") and (not IsInAction) and (ZombRand(4)==0) then

			--	local randresult = ZombRand(10) + 1
			--	--print("Guard - random job result is:"..tostring(randresult))
			--	if(randresult == 1) then
			--
			--		NPC:Speak(getActionText("IGoRelax"))
			--		task_manager:AddToTop(WanderInBaseTask:new(NPC))
			--		NPC:DebugSay("Relax condition met in AI manager! Reference number 0009")
			--
			--	else
			--
			--		local area = HisGroup:getGroupArea("GuardArea")
			--		if(area) then
			--			NPC:Speak(getActionText("IGoGuard"))
			--			task_manager:AddToTop(WanderInAreaTask:new(NPC,area))
			--			task_manager:setTaskUpdateLimit(AutoWorkTaskTimeLimit)
			--			NPC:DebugSay("Guard area condition met in AI manager! Reference number 000-10")
			--		else
			--		--	print("Guard condition area was nil")
			--			NPC:DebugSay("Guard condition met in AI manager! Reference number 000-11")
			--		end
			--	end

		elseif (NPC:getCurrentTask() == "None") and (IsInBase) and (not IsInAction) and (ZombRand(4)==0) then

			if(not SurvivorsFindWorkThemselves) and (NPC:getGroupRole() == "Doctor") then
				local randresult = ZombRand(10) + 1
				--print("Doctor - random job result is:"..tostring(randresult))
				if(randresult == 1) then

					NPC:Speak(getActionText("IGoRelax"))
					task_manager:AddToTop(WanderInBaseTask:new(NPC))
					NPC:DebugSay("Wander In base condition met in AI manager! Reference number 000-12")

				else

					local medicalarea = HisGroup:getGroupArea("MedicalStorageArea")
					NPC:DebugSay("Wander in base condition met in AI manager! Reference number 000-13")

					local gotoSquare
					if(medicalarea) and (medicalarea[1] ~= 0) then gotoSquare = getCenterSquareFromArea(medicalarea[1],medicalarea[2],medicalarea[3],medicalarea[4],medicalarea[5]) end
					if(not gotoSquare) then gotoSquare = CenterBaseSquare end

					if(gotoSquare ) then NPC:walkTo(gotoSquare) end
					task_manager:AddToTop(DoctorTask:new(NPC))
					return task_manager
				end


			elseif(not SurvivorsFindWorkThemselves) and (NPC:getGroupRole() == "Farmer") then

				if(SurvivorsFindWorkThemselves) and (RainManager.isRaining() == false) then
					local randresult = ZombRand(10) + 1
					--print("random job result is:"..tostring(randresult))
					if(randresult == 1) then

						NPC:Speak(getActionText("IGoRelax"))
						task_manager:AddToTop(WanderInBaseTask:new(NPC))
						task_manager:setTaskUpdateLimit(AutoWorkTaskTimeLimit)

					else

						local area = HisGroup:getGroupArea("FarmingArea")
						if(area) then
							NPC:Speak(getActionText("IGoFarm"))
							task_manager:AddToTop(FarmingTask:new(NPC))
							task_manager:setTaskUpdateLimit(AutoWorkTaskTimeLimit)
						else
							--	print("farming area was nil")
						end
					end
				end

				-- ModderNote: From what I've observed, companion isn't used on anything else except to follow
				-- So exploiting that knowledge, I made the companion more of a 'class job priority' set of jobs at the top of the code.
				-- So if you are another modder that has the torch, that's looking to make Followers listen to you more, Follower = 'companion'
			elseif(NPC:getGroupRole() == "Companion") then -- Not new, this was here before

				task_manager:AddToTop(FollowTask:new(NPC,getSpecificPlayer(0)))

			elseif(SurvivorsFindWorkThemselves) and not (AiNPC_Job_Is(NPC,"Guard")) and not (AiNPC_Job_Is(NPC,"Doctor")) and not (AiNPC_Job_Is(NPC,"Farming")) then
				--	print("yes im a worker: "..tostring(NPC:Get():getBodyDamage():getWetness()))

				--if(RainManager.isRaining()) and (NPC:Get():getBodyDamage():getWetness() > 0.5) and (NPC:Get():isOutside()) and (task_manager.TaskUpdateLimit ~= 0) and (task_manager:getCurrentTask() ~= "Enter New Building") and (task_manager:getCurrentTask() ~= "Find Building") then
				--	NPC:Speak(getActionText("RainingGoInside"))
				--	task_manager:clear()
				--	task_manager:AddToTop(AttemptEntryIntoBuildingTask:new(NPC,nil))
				--	task_manager:AddToTop(FindBuildingTask:new(NPC))
				--end

				if (NPC:Get():getBodyDamage():getWetness() < 0.2) then
					--print(NPC:getName().."/" .. NPC:getGroupRole() .." yes i should look for work")
					if(SafeToGoOutAndWork) then
						task_manager:setTaskUpdateLimit(AutoWorkTaskTimeLimit)

						local forageSquare = HisGroup:getGroupAreaCenterSquare("ForageArea")
						local chopWoodSquare = HisGroup:getGroupAreaCenterSquare("ChopTreeArea")
						local farmingArea = HisGroup:getGroupArea("FarmingArea")
						local guardArea = HisGroup:getGroupArea("GuardArea")

						local jobScores = {}
						local job = "Relax"
						-- idle tasks
						jobScores["Relax"] = 0 + math.floor(NPC:Get():getStats():getBoredom() * 20.0)
						jobScores["Wash Self"] = 1

						-- maintenance
						jobScores["Clean Inventory"] = 2
						jobScores["Gather Wood"] = 2
						jobScores["Pile Corpses"] = 2

						-- skilled work
						jobScores["Chop Wood"] = 2 + math.min(NPC:Get():getPerkLevel(Perks.FromString("Axe")), 3)
						jobScores["Forage"] = 2 + math.min(NPC:Get():getPerkLevel(Perks.FromString("Foraging")), 3)

						-- deprioritize assigned tasks
						jobScores["Farming"] = 0 + math.min(NPC:Get():getPerkLevel(Perks.FromString("Farming")), 3)
						jobScores["Doctor"] = -2 + math.min(NPC:Get():getPerkLevel(Perks.FromString("Doctor")), 3) + math.min(NPC:Get():getPerkLevel(Perks.FromString("First Aid")), 3)
						jobScores["Guard"] = 2 + math.min(NPC:Get():getPerkLevel(Perks.FromString("Aiming")), 3)

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
						if NPC:Get():getBodyDamage():getWetness() > 0.5 then
							-- do indoor stuff to dry off
							jobScores["Relax"] = jobScores["Relax"] + 3
							jobScores["Clean Inventory"] = jobScores["Clean Inventory"] + 3
							jobScores["Wash Self"] = jobScores["Wash Self"] + 2
						end

						-- personal needs
						local filth = NPC:getFilth()
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
						--if NPC:getGroupRole() == "Doctor" then
						--	jobScores["Doctor"] = jobScores["Doctor"] + 3
						--elseif NPC:getGroupRole() == "Farmer" then
						--	jobScores["Farming"] = jobScores["Farming"] + 3
						--elseif NPC:getGroupRole() == "Guard" then
						--	jobScores["Guard"] = jobScores["Guard"] + 3
						--end

						-- find the best task
						for key, value in pairs(jobScores) do
							--print(key..":"..tostring(value))
							if value >= jobScores[job] then job = key end
						end

						NPC:Get():getStats():setBoredom(NPC:Get():getStats():getBoredom() + (ZombRand(5) / 100.0))
						if(job == "Relax") then
							NPC:Speak(getActionText("IGoRelax"))
							NPC:Get():getStats():setBoredom(0.0)
							task_manager:AddToTop(WanderInBaseTask:new(NPC))

						elseif(job == "Gather Wood") then
							NPC:Speak(getActionText("IGoGetWood"))
							local dropSquare = CenterBaseSquare
							local woodstoragearea = HisGroup:getGroupArea("WoodStorageArea")
							if(woodstoragearea[1] ~= 0) then dropSquare = getCenterSquareFromArea(woodstoragearea[1],woodstoragearea[2],woodstoragearea[3],woodstoragearea[4],woodstoragearea[5]) end
							task_manager:AddToTop(GatherWoodTask:new(NPC,dropSquare))
							task_manager:setTaskUpdateLimit(AutoWorkTaskTimeLimit)

						elseif(job == "Pile Corpses") then
							NPC:Speak(getActionText("IGoPileCorpse"))
							local baseBounds = HisGroup:getBounds()
							local dropSquare = getCell():getGridSquare(baseBounds[1]-5,baseBounds[3]-5,0)
							local storagearea = HisGroup:getGroupArea("CorpseStorageArea")
							if(storagearea[1] ~= 0) then dropSquare = getCenterSquareFromArea(storagearea[1],storagearea[2],storagearea[3],storagearea[4],storagearea[5]) end
							if(dropSquare) then
								task_manager:AddToTop(PileCorpsesTask:new(NPC,dropSquare))
								task_manager:setTaskUpdateLimit(AutoWorkTaskTimeLimit)
							end

						elseif(job == "Forage") then
							local dropSquare = CenterBaseSquare
							local FoodStorageCenter = HisGroup:getGroupAreaCenterSquare("FoodStorageArea")
							if(FoodStorageCenter) then dropSquare = FoodStorageCenter end

							if(forageSquare ~= nil) then
								NPC:Speak(getActionText("IGoForage"))
								NPC:walkTo(forageSquare)
								task_manager:AddToTop(CleanInvTask:new(NPC,dropSquare,false))
								task_manager:AddToTop(ForageTask:new(NPC))
								task_manager:setTaskUpdateLimit(AutoWorkTaskTimeLimit)
							else
								--	print("forageSquare was nil")
							end

						elseif(job == "Chop Wood") then
							if(chopWoodSquare) then
								NPC:Speak(getActionText("IGoChopWood"))
								task_manager:AddToTop(ChopWoodTask:new(NPC))
								task_manager:setTaskUpdateLimit(AutoWorkTaskTimeLimit)
							else
								--	print("chopWoodArea was nil")
							end

						elseif(job == "Farming") then
							if(farmingArea) then
								NPC:Speak(getActionText("IGoFarm"))
								task_manager:AddToTop(FarmingTask:new(NPC))
								task_manager:setTaskUpdateLimit(AutoWorkTaskTimeLimit)
							else
								--	print("farmingArea area was nil")
							end

						elseif(job == "Guard") then
							if(guardArea) then
								NPC:Speak(getActionText("IGoGuard"))
								task_manager:AddToTop(WanderInAreaTask:new(NPC, guardArea))
								task_manager:setTaskUpdateLimit(AutoWorkTaskTimeLimit)
							else
								--	print("guardArea was nil")
							end

						elseif(job == "Doctor") then
							local medicalarea = HisGroup:getGroupArea("MedicalStorageArea")

							local gotoSquare
							if(medicalarea) and (medicalarea[1] ~= 0) then gotoSquare = getCenterSquareFromArea(medicalarea[1],medicalarea[2],medicalarea[3],medicalarea[4],medicalarea[5]) end
							if(not gotoSquare) then gotoSquare = CenterBaseSquare end

							if(gotoSquare ) then NPC:walkTo(gotoSquare) end
							task_manager:AddToTop(DoctorTask:new(NPC))
							task_manager:setTaskUpdateLimit(AutoWorkTaskTimeLimit)

						elseif(job == "Clean Inventory") then
							NPC:Speak("Cleaning Inventory")
							local dropSquare = CenterBaseSquare
							local ToolStorageCenter = HisGroup:getGroupAreaCenterSquare("ToolStorageArea")
							if(ToolStorageCenter) then dropSquare = ToolStorageCenter end
							task_manager:AddToTop(CleanInvTask:new(NPC,dropSquare,false))

						elseif(job == "Wash Self") then
							NPC:Speak("Washing Self")
							task_manager:AddToTop(WashSelfTask:new(NPC))

						end
					else
						task_manager:AddToTop(WanderInBaseTask:new(NPC))
					end -- safeto go out end
				end -- allowed to go out work end
			end
		end

		-- Oop, found this. I could use this for followers to get back to main player
		if (NPC:getCurrentTask() == "None") and (IsInBase == false) and (not IsInAction) and (HisGroup~=nil) then
			local baseSq = CenterBaseSquare
			if(baseSq ~= nil) then
				NPC:Speak(getActionText("IGoBackBase"))
				task_manager:AddToTop(ReturnToBaseTask:new(NPC))
				NPC:DebugSay("none task condition met in AI manager! Reference number Alt_000-A01")
			end
		end
	end
end

--****************************************************
-- Random solo task (not edited)
--****************************************************
-- 1 sub task composed of 4 tasks.
local tick_random_solo_task = 0
local function random_solo_task(task_manager)

	tick_random_solo_task = tick_random_solo_task+1
	if tick_random_solo_task == 5 then tick_random_solo_task = 0 end

	-- TODO test: maybe add 'if not in attack / pursue / threaten , then do ' along with the 'none tasks'
	-- if(NPC.DebugMode) then print(NPC:getAIMode()) end
	if(NPC:getAIMode() == "Random Solo") and (task_manager:getCurrentTask() ~= "Listen") and (task_manager:getCurrentTask() ~= "Take Gift") then -- solo random survivor AI flow

		local function task_1()
			if(task_manager:getCurrentTask() == "None") and (NPC.TargetBuilding ~= nil) and (not NPC:getBuildingExplored(NPC.TargetBuilding)) and (not NPC:isEnemyInRange(NPC.LastEnemeySeen)) then
				task_manager:AddToTop(AttemptEntryIntoBuildingTask:new(NPC, NPC.TargetBuilding))
				NPC:DebugSay("Attempt entry into building Task condition met in AI manager! Reference number B_0001")

				--		V backup just in case
				--		elseif(task_manager:getCurrentTask() == "None") then
			elseif(task_manager:getCurrentTask() == "None") and ((not EnemyIsSurvivor) or (not NPC:isEnemyInRange(NPC.LastEnemeySeen)) )then
				task_manager:AddToTop(FindUnlootedBuildingTask:new(NPC))
				NPC:DebugSay("Find Unlooted Building Task condition met in AI manager! Reference number B_0002")
			end
		end

		local function task_2()
			if(NPC.TargetBuilding ~= nil) or (NPC:inUnLootedBuilding())then
				if NPC.TargetBuilding == nil then NPC.TargetBuilding = NPC:getBuilding() end
				if (not NPC:hasWeapon()) and (task_manager:getCurrentTask() ~= "Loot Category") and (NPC:getDangerSeenCount() <= 0) and (NPC:inUnLootedBuilding()) and (NPC:isTargetBuildingClaimed(NPC.TargetBuilding) == false) then
					NPC:DebugSay("Loot Task condition met in AI manager! Reference number B_0003")
					task_manager:AddToTop(LootCategoryTask:new(NPC,NPC.TargetBuilding,"Food",2))
					task_manager:AddToTop(EquipWeaponTask:new(NPC))
					task_manager:AddToTop(LootCategoryTask:new(NPC,NPC.TargetBuilding,"Weapon",2))
				elseif (NPC:hasRoomInBag()) and (task_manager:getCurrentTask() ~= "Loot Category") and (NPC:getDangerSeenCount() <= 0) and (NPC:inUnLootedBuilding()) and (NPC:isTargetBuildingClaimed(NPC.TargetBuilding) == false) then
					task_manager:AddToTop(LootCategoryTask:new(NPC,NPC.TargetBuilding,"Food",1))
					NPC:DebugSay(" Task condition met in AI manager! Reference number B_0004")
				end
			end
		end

		local function task_3()
			if (SurvivorBases) and
					(IsInAction == false) and 									-- New. Hopefully to stop spam
					(NPC:getBaseBuilding() == nil) and
					(NPC:getBuilding()) and
					(task_manager:getCurrentTask() ~= "First Aide") and
					(task_manager:getCurrentTask() ~= "Attack") and
					(task_manager:getCurrentTask() ~= "Threaten") and			-- new
					(task_manager:getCurrentTask() ~= "Pursue") and				-- new
					(task_manager:getCurrentTask() ~= "Enter New Building") and -- new
					(task_manager:getCurrentTask() ~= "Barricade Building") and
					(NPC:hasWeapon())  and
					(NPC:getGroupRole() ~= "Companion") and			-- New
					(NPC:isInSameBuildingWithEnemyAlt() == false)  and -- That way npc doesn't stop what they're doing moment they look away from a hostile
					(NPC:hasFood())
			then
				NPC:DebugSay("Wander in building Task condition met in AI manager! Reference number C_0001")
				task_manager:clear()
				NPC:setBaseBuilding(NPC:getBuilding())
				task_manager:AddToTop(WanderInBuildingTask:new(NPC,NPC:getBuilding()))
				task_manager:AddToTop(LockDoorsTask:new(NPC,true))
				task_manager:AddToTop(BarricadeBuildingTask:new(NPC))
				NPC:Speak("This will be my base.")
				--print(NPC:getName() .. " making base")
				local GroupId = SSGM:GetGroupIdFromSquare(NPC:Get():getCurrentSquare())
				--NPC:Speak(tostring(GroupId))
				if(GroupId == -1) then -- if the base this npc is gonna stay in is not declared as another base then they set it as thier base.
					--	print("New base")
					local nGroup = SSGM:newGroup()
					nGroup:addMember(NPC,"Leader")
					local def = NPC:getBuilding():getDef()
					local bounds = {def:getX()-1,(def:getX() + def:getW()+1 ), def:getY()-1,(def:getY() + def:getH()+1),0}
					nGroup:setBounds(bounds)
					--NPC:Speak(tostring(nGroup:getID()))
				elseif(GroupId ~= SSM:Get(0):getGroupID()) then
					local OwnerGroup = SSGM:Get(GroupId)
					local LeaderID = OwnerGroup:getLeader()
					--	print("Joining g:" .. GroupId .. " l:" .. LeaderID)
					if(LeaderID ~= 0) then
						OwnerGroup:addMember(NPC,"Worker")
						NPC:Speak("Please let me stay here")
						local LeaderObj = SSM:Get(LeaderID)
						if(LeaderObj) then
							LeaderObj:Speak("Welcome to our Group")
							--	print("Accepted by " .. LeaderObj:getName())
						end
					end
				end
			end
		end

		local function task_4()
			if ((SurvivorBases) and (NPC:isStarving()) or (NPC:isDyingOfThirst())) and (NPC:getBaseBuilding() ~= nil) then  -- leave group and look for food if starving
				-- random survivor in base is starving - reset so he goes back out looking for food and re base there
				--print(NPC:getName() .. " leaving group because starving")

				NPC:setAIMode("Random Solo")
				if(NPC:getGroupID() ~= nil) then
					local group = SSGM:Get(NPC:getGroupID())
					group:removeMember(NPC:getID())
				end
				NPC:getTaskManager():clear()
				NPC:Speak(getActionText("LeaveBCHungry"))
				NPC:resetAllTables()
				NPC:setBaseBuilding(nil)
				if (NPC:Get():getStats():getHunger() > 0.30) then NPC:Get():getStats():setHunger(0.30) end
				if (NPC:Get():getStats():getThirst() > 0.30) then NPC:Get():getStats():setThirst(0.30) end
			end
		end

		if tick_random_solo_task == 1 then task_1() end
		if tick_random_solo_task == 2 then task_2() end
		if tick_random_solo_task == 3 then task_3() end
		if tick_random_solo_task == 4 then task_4() end

	end
end

--****************************************************
-- Companion weapon tasks (not edited)
--****************************************************
-- 3 sub tasks.
local tick_companion_weapon_task = 0
local function companion_weapon_tasks(task_manager)

	tick_companion_weapon_task = tick_companion_weapon_task+1
	if tick_companion_weapon_task == 4 then tick_companion_weapon_task = 0 end

	-- ----------------------------- --
	-- 	Gun Readying / Reloading     --
	-- ----------------------------- --
	local function task_1()
		if not (AiNPC_Job_Is(NPC,"Companion"))  then
			if(NPC:getNeedAmmo())
					and (NPC:hasAmmoForPrevGun())
					and (IsInAction == false)
					and (task_manager:getCurrentTask() ~= "Take Gift")
					and (task_manager:getCurrentTask() ~= "Flee") 			-- New
					and (task_manager:getCurrentTask() ~= "Flee From Spot") -- New
					and (NPC:getDangerSeenCount()==0)
			then
				NPC:setNeedAmmo(false)
				-- Reminder: re-enable this
				NPC:reEquipGun()
				NPC:DebugSay("GetNeed ammo condition met in AiManager Triggered! Reference Number 006")
			end
		end
	end

	-- ----------------------------- --
	-- 	Equip Weapon Task            --
	-- ----------------------------- --
	local function task_2()
		if not (AiNPC_Job_Is(NPC,"Companion"))then
			if(NPC:hasWeapon()) and (NPC:Get():getPrimaryHandItem() == nil) and (task_manager:getCurrentTask() ~= "Equip Weapon")  then
				task_manager:AddToTop(EquipWeaponTask:new(NPC))
				NPC:DebugSay("Weapon related condition met in AI manager triggered! Reference number 007")
			end
		end
	end

	-- ----------------------------- --
	-- 	Equip Weapon Task            --
	-- ----------------------------- --
	local function task_3()
		if not (AiNPC_Job_Is(NPC,"Companion"))  then
			if(IsInAction == false) and (NPC:getNeedAmmo() == false) and NPC:usingGun() and (NPC:getDangerSeenCount() == 0) and ((NPC:needToReload()) or (NPC:needToReadyGun(weapon))) and (NPC:NPC_FleeWhileReadyingGun()) then
				--print(NPC:getName() .. " AI detected need to ready gun")
				NPC:ReadyGun(weapon)
				if (NPC:isSpeaking() == false) then NPC:DebugSay("Weapon related condition met in AI manager triggered! Reference number 0008") end
			end
		end
	end

	if tick_companion_weapon_task == 1 then task_1() end
	if tick_companion_weapon_task == 2 then task_2() end
	if tick_companion_weapon_task == 3 then task_3() end

end

--****************************************************
-- Listen to task (not edited)
--****************************************************
-- 1 sub task.
local function listen_to_task(task_manager)
	-- ----------------------------- --
	-- 			Listen to Task
	-- ----------------------------- --
	if ((NPC:Get():getModData().InitGreeting ~= nil) or (NPC:getAIMode() == "Random Solo"))
			and (task_manager:getCurrentTask() ~= "Listen")
			and (task_manager:getCurrentTask() ~= "Surender")
			and (task_manager:getCurrentTask() ~= "Flee From Spot")
			and (task_manager:getCurrentTask() ~= "Take Gift")
			and (NPC.LastSurvivorSeen ~= nil)
			--and (NPC.LastSurvivorSeen:isGhostMode() == false)
			and (NPC:getSpokeTo(NPC.LastSurvivorSeen:getModData().ID) == false)
			and (getDistanceBetween(NPC.LastSurvivorSeen,NPC:Get()) < 8)
			and (NPC:getDangerSeenCount()==0) and (task_manager:getCurrentTask() ~= "First Aide")
			and (NPC:Get():CanSee(NPC.LastSurvivorSeen)) then
		NPC:Speak(getDialogue("HeyYou"))
		NPC:SpokeTo(NPC.LastSurvivorSeen:getModData().ID)
		NPC:DebugSay("Listen Task Condition Met! Reference Number 0005")
		task_manager:AddToTop(ListenTask:new(NPC,NPC.LastSurvivorSeen,true))
	end
end

--****************************************************
-- Food drink task (not edited)
--****************************************************
-- 1 sub task.
local function food_drink_task(task_manager)
	-- ----------------------------- --
	-- Find food / drink - like task --
	-- ----------------------------- --
	if  (task_manager:getCurrentTask() ~= "Enter New Building") and (IsInAction == false) and (task_manager:getCurrentTask() ~= "Eat Food") and (task_manager:getCurrentTask() ~= "Find This") and (task_manager:getCurrentTask() ~= "First Aide") and (((NPC:isThirsty()) and (IsInBase)) or NPC:isVThirsty() ) and (NPC:getDangerSeenCount() == 0) then
		if(NPC:getNoWaterNearBy() == false) and ((getSpecificPlayer(0) == nil) or (not getSpecificPlayer(0):isAsleep())) then
			if(HisGroup) then
				local area = HisGroup:getGroupAreaCenterSquare("FoodStorageArea")
				if(area) then NPC:walkTo(area) end
				NPC:Speak("I'm going to get some food before I die of hunger.")
			end
			task_manager:AddToTop(FindThisTask:new(NPC, "Water", "Category", 1))
			NPC:DebugSay("Not enter new building condition met! Condition number (to compare in ai manager file) 0004")
		end
	end
end

--****************************************************
-- Force group leave task (not edited)
--****************************************************
-- 1 sub task.
local function force_leave_group_task(task_manager)
	-- ----------------------------- --
	-- If NPC is Starving or drhydrating, force leave group
	-- To do - Give player option to let this task happen or not too
	-- ----------------------------- --
	if (false) and (NPC:getAIMode() ~= "Random Solo") and ((NPC:isStarving()) or (NPC:isDyingOfThirst())) then
		-- leave group and look for food if starving
		NPC:DebugSay("Left the building because starving or thirsty condition triggered! Reference Number 000_000_04")
		NPC:setAIMode("Random Solo")
		if(NPC:getGroupID() ~= nil) then
			local group = SSGM:Get(NPC:getGroupID())
			group:removeMember(NPC:getID())
		end
		NPC:getTaskManager():clear()
		if (NPC:Get():getStats():getHunger() > 0.40) then NPC:Get():getStats():setHunger(0.40) end
		if (NPC:Get():getStats():getThirst() > 0.40) then NPC:Get():getStats():setThirst(0.40) end
		NPC:Speak(getDialogue("LeaveGroupHungry"))
	elseif (task_manager:getCurrentTask() ~= "Enter New Building") and (task_manager:getCurrentTask() ~= "Clean Inventory") and (IsInAction == false) and (task_manager:getCurrentTask() ~= "Eat Food") and (task_manager:getCurrentTask() ~= "Find This") and (task_manager:getCurrentTask() ~= "First Aide")and (task_manager:getCurrentTask() ~= "Listen") and (((NPC:isHungry()) and (IsInBase)) or NPC:isVHungry() ) and (NPC:getDangerSeenCount() == 0) then
		if(not NPC:hasFood()) and (NPC:getNoFoodNearBy() == false) and ((getSpecificPlayer(0) == nil) or (not getSpecificPlayer(0):isAsleep())) then
			if(HisGroup) then
				local area = HisGroup:getGroupAreaCenterSquare("FoodStorageArea")
				if(area) then
					NPC:DebugSay("Hunber/Thirst-Like Conditions Met in AImanager - Reference Number DHFB_0002")
					NPC:walkTo(area)
				end
			end
			task_manager:AddToTop(FindThisTask:new(NPC, "Food", "Category", 1))
			NPC:DebugSay("Hunber/Thirst-Like Conditions Met in AImanager - Reference Number DHFB_0003")
		elseif (NPC:hasFood()) then
			NPC:DebugSay("Hunber/Thirst-Like Conditions Met in AImanager - Reference Number DHFB_0004")
			task_manager:AddToTop(EatFoodTask:new(NPC,NPC:getFood()))
		end
	end
end

--****************************************************
-- Surrender task (not edited)
--****************************************************
-- 6 sub tasks.
local tick_surrender_task = 0
local function companion_tasks(task_manager)

	tick_surrender_task = tick_surrender_task+1
	if tick_surrender_task == 7 then tick_surrender_task = 0 end

	-- ----------------------------- --
	-- Attack / Threaten Target Task --
	-- ----------------------------- --
	--	if ((task_manager:getCurrentTask() ~= "Attack") and (task_manager:getCurrentTask() ~= "Threaten") and not ((task_manager:getCurrentTask() == "Surender") and EnemyIsSurvivor) and (task_manager:getCurrentTask() ~= "Doctor") and (NPC:isInSameRoom(NPC.LastEnemeySeen)) and (task_manager:getCurrentTask() ~= "Flee")) and ((NPC:hasWeapon() and ((NPC:getDangerSeenCount() >= 1) or (NPC:isEnemyInRange(NPC.LastEnemeySeen)))) or (NPC:hasWeapon() == false and (NPC:getDangerSeenCount() == 1) and (not EnemyIsSurvivor))) and (IHaveInjury == false) and (NPC:inFrontOfLockedDoor() == false)  then
	local function task_1()
		if not (AiNPC_Job_Is(NPC,"Companion"))  then
			if (
					(task_manager:getCurrentTask() ~= "Attack")
							and (task_manager:getCurrentTask() ~= "Threaten")
							and not ((task_manager:getCurrentTask() == "Surender") and EnemyIsSurvivor)
							and (task_manager:getCurrentTask() ~= "Doctor")
							and (NPC:isInSameRoom(NPC.LastEnemeySeen))
							and (task_manager:getCurrentTask() ~= "Flee")
							and (task_manager:getCurrentTask() ~= "Flee From Spot")
					--and (NPC:NPC_CheckPursueScore() > 0) -- New: It maybe pursue, but it can be used for attack too, it's helping against door spam
					--and ( Distance_AnyEnemy < NPC:NPC_CheckPursueScore() ) -- Don't want them chasing from across the map
			)
					and (
					(NPC:hasWeapon() and 		   ((NPC:getDangerSeenCount() >= 1) or (NPC:isEnemyInRange(NPC.LastEnemeySeen))))
							or (NPC:hasWeapon() == false and (NPC:getDangerSeenCount() == 1) and (not EnemyIsSurvivor))
			)

					and (not NPC:isTooScaredToFight() and (IHaveInjury == false)) -- This. I may want to change this to 'too many injuries' function

					and (not NPC:isTooScaredToFight())
					and (NPC:inFrontOfLockedDoor() == false)
			then
				if(NPC.player ~= nil)
						and (NPC.player:getModData().isRobber)
						and (not NPC.player:getModData().hitByCharacter)
						and EnemyIsSurvivor
						and (not EnemySuperSurvivor.player:getModData().dealBreaker)
				then
					task_manager:AddToTop(ThreatenTask:new(NPC,EnemySuperSurvivor,"Scram"))
					NPC:DebugSay("Threaten/Attack Task condition triggered! Reference Number ATC_000_01")
				else
					task_manager:AddToTop(AttackTask:new(NPC))
					NPC:DebugSay("Threaten/Attack Task condition triggered! Reference Number ATC_000_02")
				end
			end
		end
	end

	-- ----------------------------- --
	-- New: To attempt players that are NOT trying to encounter a fight,
	-- should be able to run away. maybe a dice roll for the future?
	-- ----------------------------- --
	local function task_2()
		if not (AiNPC_Job_Is(NPC,"Companion"))  then
			if (EnemyIsSurvivor) and ((task_manager:getCurrentTask() == "Threaten") and (Distance_AnyEnemy > 10)) and (task_manager:getCurrentTask() ~= "Flee") then
				task_manager:AddToTop(WanderTask:new(NPC))
				task_manager:AddToTop(AttemptEntryIntoBuildingTask:new(NPC,nil))
				task_manager:AddToTop(WanderTask:new(NPC))
				task_manager:AddToTop(FindBuildingTask:new(NPC))
			end
		end
	end

	-- ----------------------------- --
	-- find safe place if injured and enemies near		this needs updating
	-- ----------------------------- --
	--	if (task_manager:getCurrentTask() ~= "Find Building") and (task_manager:getCurrentTask() ~= "Flee") and (IHaveInjury) and (NPC:getDangerSeenCount() > 0) then
	local function task_3()
		if not (AiNPC_Job_Is(NPC,"Companion")) then
			if (task_manager:getCurrentTask() ~= "Find Building")
					and (task_manager:getCurrentTask() ~= "First Aide")
					and (task_manager:getCurrentTask() ~= "Flee")
					and ((IHaveInjury) and (NPC:isTooScaredToFight()))
					and (NPC:getDangerSeenCount() > 0)
			then
				task_manager:AddToTop(FindBuildingTask:new(NPC))
				NPC:DebugSay("Find Safe place if Injured condition triggered! Reference Number FBTII_000_01")
			end
		end
	end

	-- ----------------------------- --
	-- bandage injuries if no threat near by
	-- Companions have their own healing rule
	-- ----------------------------- --
	local function task_4()
		if not (AiNPC_Job_Is(NPC,"Companion"))  then
			if (IHaveInjury) then
				if (task_manager:getCurrentTask() ~= "First Aide")
						and (task_manager:getCurrentTask() ~= "Flee")
						and (task_manager:getCurrentTask() ~= "Doctor")
						and (task_manager:getCurrentTask() ~= "Hold Still")
						and ((NPC:getSeenCount() >= 1) and (Distance_AnyEnemy <= 6)) -- This line doesn't make sense, what if the npc needs to heal outside of hostiles?
				then
					task_manager:AddToTop(FirstAideTask:new(NPC)) -- If general healing
					task_manager:AddToTop(FleeTask:new(NPC))
					if (ZombRand(3)==0) then
						NPC:NPC_ShouldRunOrWalk()
					end
					if ((NPC:getSeenCount() >= 3) and (Distance_AnyEnemy <= 3)) then -- If EMERGENCY run away and heal
						task_manager:AddToTop(FirstAideTask:new(NPC))
						task_manager:AddToTop(FleeTask:new(NPC))
						task_manager:AddToTop(FleeFromHereTask:new(NPC,NPC:Get():getCurrentSquare()))
					end
					NPC:DebugSay("Bandage Injuries if no threat nearby triggered! Reference Number 000_000_02")
				end
			end
		end
	end

	-- ----------------------------- --
	-- flee from too many zombies
	-- ----------------------------- --
	local function task_5()
		if not (AiNPC_Job_Is(NPC,"Companion"))  then -- To ABSOLUTELY prevent these two jobs from listening to this task.
			if (task_manager:getCurrentTask() ~= "Flee")
					and (task_manager:getCurrentTask() ~= "Flee From Spot")
					and (task_manager:getCurrentTask() ~= "Surender")
					and ((task_manager:getCurrentTask() ~= "Surender") and not EnemyIsSurvivor)
					and
					(
							( ((NPC:needToReload()) or (NPC:needToReadyGun(weapon))) and ( (NPC:getDangerSeenCount() > 1 and (Distance_AnyEnemy  < 3) and (EnemyIsZombie)) 	or 	((NPC:getSeenCount() >= 2) and (Distance_AnyEnemy <= 2) and (EnemyIsZombie)) ) )  -- AH HA, gun running away for non-companions when the npc is trying to reload or ready gun
									or ( ((NPC:needToReload()) or (NPC:needToReadyGun(weapon))) and ( (NPC:getDangerSeenCount() > 1 and (Distance_AnyEnemy <= 2) and (EnemyIsSurvivor)) or 	( (Distance_AnyEnemy <= 2) and (EnemyIsSurvivor)) ) )  							  -- AH HA, gun running away for non-companions when the npc is trying to reload or ready gun
									-- To check for EnemyIsZombie, which will look there and go 'OH GOD, I can't fight THIS many zombies'
									-- Update: I may of already fixed this issue on the lines above...
									-- now that I understand that getDangerSeenCount means if something is like SUPER close to the npc, you can simulate
									-- the idea of 'there's an enemy basically on me and I see more in the distance, I don't think this is worth fighting'
									or (
									(NPC.EnemiesOnMe > 3 and NPC:getDangerSeenCount() > 3 and NPC:getSeenCount() > 3)

											or (not NPC:hasWeapon() and (NPC:getDangerSeenCount() > 0) )

											or (IHaveInjury and NPC:getDangerSeenCount() > 0)

											or (EnemyIsSurvivorHasGun and NPC:hasGun() == false)

											or (NPC:isTooScaredToFight())

							)
					)
			then
				if(task_manager:getCurrentTask() == "LootCategoryTask") then -- currently to dangerous to loot said building. so give up it
					task_manager:getTask():ForceFinish()
				end
				NPC:getTaskManager():clear()
				task_manager:AddToTop(FleeTask:new(NPC))

				if not (AiNPC_Job_Is(NPC,"Guard")) and not (AiNPC_Job_Is(NPC,"Doctor")) then
					task_manager:AddToTop(FleeFromHereTask:new(NPC,NPC:Get():getCurrentSquare()))
					NPC:DebugSay("Flee from too many zombies condition triggered! Reference Number LCT_000_02_REG")
				else
					NPC:DebugSay("Flee from too many zombies condition triggered! Reference Number LCT_000_02_ALT")
				end
			end
		end
	end

	local function task_6()
		if (task_manager:getCurrentTask() ~= "Flee") and (task_manager:getCurrentTask() ~= "Surender") and ((task_manager:getCurrentTask() ~= "Surender") and not EnemyIsSurvivor)
				and (( (NPC.EnemiesOnMe > 1) and (NPC.dangerSeenCount >= 3) and (NPC:hasWeapon()) and (not NPC:usingGun()) ) 	-- Melee
				or ( (NPC.EnemiesOnMe > 1) and (NPC.dangerSeenCount >= 3) and (NPC:hasWeapon()) and (NPC:usingGun()) ) 	-- Gun general
				or ( (NPC.EnemiesOnMe > 0) and ((NPC:needToReload()) or (NPC:needToReadyGun(weapon))) )
				or ( IHaveInjury and NPC.dangerSeenCount > 0 )
				or ( NPC.dangerSeenCount >= 5)
		)
		then
			task_manager:AddToTop(FleeTask:new(NPC))
			NPC:DebugSay("Companion FLEEINGTASK_0001")
		end
	end

	if tick_surrender_task == 1 then task_1() end
	if tick_surrender_task == 2 then task_2() end
	if tick_surrender_task == 3 then task_3() end
	if tick_surrender_task == 4 then task_4() end
	if tick_surrender_task == 5 then task_5() end
	if tick_surrender_task == 6 then task_6() end

end

--****************************************************
-- Surrender task
--****************************************************
-- 1 sub task.
local function surrender_task(task_manager)
	-- I haven't tampered with this one, it does OK for the most part.
	-- Bug: If you shoot the gun and it has nothing in it, the NPC will still keep their hands up
	-- ----------------------------- --
	-- 		Surrender Task
	-- ----------------------------- --
	if getSpecificPlayer(0) ~= nil then
		local facingResult = getSpecificPlayer(0):getDotWithForwardDirection(NPC.player:getX(), NPC.player:getY())
		--NPC:Speak( tostring(facingResult) )
		local surrender_logic_1 = task_manager:getCurrentTask() ~= "Surender"
		local surrender_logic_2 = task_manager:getCurrentTask() ~= "Flee"
		local surrender_logic_3 = task_manager:getCurrentTask() ~= "Flee From Spot"
		local surrender_logic_4 = task_manager:getCurrentTask() ~= "Clean Inventory"
		local surrender_logic_5 = SSM:Get(0) ~= nil and SSM:Get(0):usingGun()
		local surrender_logic_6 = getSpecificPlayer(0)
		local surrender_logic_7 = getSpecificPlayer(0):CanSee(NPC.player)
		local surrender_logic_8 = not NPC:usingGun() or (not NPC:RealCanSee(getSpecificPlayer(0)) and DistanceBetweenMainPlayer <= 3)
		local surrender_logic_9 = getSpecificPlayer(0):isAiming()
		local surrender_logic_10 = IsoPlayer.getCoopPVP()
		local surrender_logic_11 = not NPC:isInGroup(getSpecificPlayer(0))
		if surrender_logic_1 and surrender_logic_2 and surrender_logic_3 and surrender_logic_4 and surrender_logic_5 and surrender_logic_6 and surrender_logic_7 and surrender_logic_8 and surrender_logic_9 and surrender_logic_10 and surrender_logic_11 and facingResult > 0.95 and DistanceBetweenMainPlayer < 6 then
			task_manager:clear()
			task_manager:AddToTop(SurenderTask:new(NPC, SSM:Get(0)))
			NPC:DebugSay("Surrender Task Triggered! Reference Number ST_0001")
			return task_manager
		end
	end
end

--****************************************************
-- Pursue task
--****************************************************
-- 1 sub task.
local function pursue_task(task_manager)
	-------------------------------
	-- Pursue task
	-------------------------------
	-- 'If enemy is in a fair range and Pursue_SC checks out, and the NPC's enemy is in Pursue Score's range'
	-- To make NPCs find their target that's very close by
	if not AiNPC_Job_Is(NPC,"Companion") then
		if NPC:Task_IsPursue_SC() == true and Distance_AnyEnemy <= 9 and Distance_AnyEnemy < NPC:NPC_CheckPursueScore() then
			if NPC:NPC_FleeWhileReadyingGun() then
				task_manager:AddToTop(PursueTask:new(NPC,NPC.LastEnemeySeen)) -- If all checks out, pursue target
			end
		end
	end
end

--****************************************************
-- Companion follower task
--****************************************************
-- 2 sub tasks.
--local tick_companion_follower_task = 0
local function companion_follower_task(task_manager)

	--tick_companion_follower_task = tick_companion_follower_task+1
	--if tick_companion_follower_task == 3 then tick_companion_follower_task = 0 end

	-------------------------------
	-- Companion follower related code
	-------------------------------
	local function task_1()
		local companion_logic_1 = (DistanceBetweenMainPlayer > 5) and (getSpecificPlayer(0):isOutside() and not NPC:Get():isOutside())
		local companion_logic_2 = (DistanceBetweenMainPlayer > 5) and (not getSpecificPlayer(0):isOutside() and NPC:Get():isOutside())
		if (NPC:getGroupRole() == "Companion") then
			if companion_logic_1 or companion_logic_2 or DistanceBetweenMainPlayer > 12 then
				NPC.LastEnemeySeen = nil
				task_manager:clear()
				task_manager:AddToTop(FollowTask:new(NPC, getSpecificPlayer(0)))
				NPC:needToFollow()
				NPC:DebugSay("Companion Went FAR too far away, CLEARING TASKS - and returning companion!")
			end
		end
	end

	local function task_2()
		if AiNPC_Job_Is(NPC,"Companion") and DistanceBetweenMainPlayer <= 12 then
			-- ------------------------- --
			-- reminder: NPC:NPCTask_DoAttack() already
			-- checks 'if task ~= attack, then do attack' in it
			-- Adding it to here too just makes the companions freeze
			-- ------------------------- --
			-- Edit: I have trid so many other ways to do this. Any other way the companion just doesn't do anything.
			-- So it's staying like this for now
			-- Don't add 'and AiNPC_TaskIsNot(task_manager,"First Aide")' because you want companions to still attack enemies while hurt
			-- ------------------------- --
			-- Perception buff.
			NPC:Companion_DoSixthSenseScan()
			-------------------------------
			-- Pursue
			-------------------------------
			local pursue_logic_1 = AiNPC_TaskIsNot(task_manager,"First Aide")
			local pursue_logic_2 = AiNPC_TaskIsNot(task_manager,"Pursue")
			local pursue_logic_3 = AiNPC_TaskIsNot(task_manager,"Attack")
			local pursue_logic_4 = AiNPC_TaskIsNot(task_manager,"Flee")
			local pursue_logic_5 = NPC.LastEnemeySeen ~= nil and Distance_AnyEnemy < NPC:NPC_CheckPursueScore()
			if pursue_logic_1 and pursue_logic_2 and pursue_logic_3 and pursue_logic_4 and pursue_logic_5 then
				if EnemyIsSurvivor or EnemyIsZombie then
					task_manager:AddToTop(PursueTask:new(NPC, NPC.LastEnemeySeen))
				end
			end
			-------------------------------
			-- Attack
			-------------------------------
			-- Perception buff.
			-- NPC:Companion_DoSixthSenseScan()
			local attack_logic_1 = task_manager:getCurrentTask() ~= "Attack" and task_manager:getCurrentTask() ~= "Threaten" and task_manager:getCurrentTask() ~= "First Aide" and task_manager:getCurrentTask() ~= "Flee"
			local attack_logic_2 = NPC:hasWeapon() and (NPC:getDangerSeenCount() >= 1 or NPC:isEnemyInRange(NPC.LastEnemeySeen))
			local attack_logic_3 = NPC:hasWeapon() == false and NPC:getDangerSeenCount() == 1 and not EnemyIsSurvivor
			local attack_logic_4 = NPC.player ~= nil and NPC.player:getModData().isRobber and not NPC.player:getModData().hitByCharacter and EnemyIsSurvivor and not EnemySuperSurvivor.player:getModData().dealBreaker
			if attack_logic_1 and (attack_logic_2 or attack_logic_3) and not NPC:isTooScaredToFight() then
				if attack_logic_4 then
					task_manager:AddToTop(ThreatenTask:new(NPC,EnemySuperSurvivor,"Scram"))
					NPC:DebugSay("Threaten/Attack Task condition triggered! Reference Number ATC_000_01")
				else
					task_manager:AddToTop(AttackTask:new(NPC))
					NPC:DebugSay("Threaten/Attack Task condition triggered! Reference Number ATC_000_02")
				end
			end
			-------------------------------
			-- Reload weapon
			-- NPC:getDangerSeenCount() removed
			-------------------------------
			if NPC:getNeedAmmo() and NPC:hasAmmoForPrevGun() then
				NPC:setNeedAmmo(false)
				NPC:reEquipGun()
				NPC:DebugSay("Companion RELOAD_Gun_0001")
			end
			-------------------------------
			-- Ready weapon
			-- NPC:getDangerSeenCount() removed
			-------------------------------
			if (NPC:needToReload() or NPC:needToReadyGun(weapon)) and NPC:hasAmmoForPrevGun() and NPC:usingGun() and NPC:getNeedAmmo() then
				NPC:ReadyGun(weapon)
				if NPC:isSpeaking() == false then NPC:DebugSay("Companion READY_Gun_0001") end
			end
			-------------------------------
			-- Equip weapon
			-------------------------------
			if NPC:hasWeapon() and NPC:Get():getPrimaryHandItem() == nil and task_manager:getCurrentTask() ~= "Equip Weapon" then
				task_manager:AddToTop(EquipWeaponTask:new(NPC))
				NPC:DebugSay("Companion EQUIP_Gun_0001")
			end
			-------------------------------
			-- Flee to heal
			-------------------------------
			-- Careful setting up Flee to heal and 'healing', they will conflict very easily.
			local flee_to_heal_logic_1 = NPC.EnemiesOnMe > 1 and NPC.dangerSeenCount >= 3 and NPC:hasWeapon() and not NPC:usingGun()
			local flee_to_heal_logic_2 = NPC.EnemiesOnMe > 1 and NPC.dangerSeenCount >= 3 and NPC:hasWeapon() and NPC:usingGun()
			local flee_to_heal_logic_3 = NPC.EnemiesOnMe > 0 and NPC:needToReload() or NPC:needToReadyGun(weapon)
			if task_manager:getCurrentTask() ~= "Flee" and (flee_to_heal_logic_1 or flee_to_heal_logic_2 or flee_to_heal_logic_3 or (IHaveInjury and NPC.dangerSeenCount > 0) or NPC.dangerSeenCount >= 5) then
				task_manager:AddToTop(FleeTask:new(NPC))
				NPC:DebugSay("Companion FLEEINGTASK_0001")
			end
			-------------------------------
			-- Healing
			-------------------------------
			if IHaveInjury and NPC.dangerSeenCount <= 0 then
				if task_manager:getCurrentTask() ~= "First Aide" then
					task_manager:AddToTop(FirstAideTask:new(NPC))
					NPC:DebugSay("Companion HealSelf_0001")
				end
			end
		end
	end

	--if tick_companion_follower_task == 1 then task_1() end
	--if tick_companion_follower_task == 2 then task_2() end

	task_1()
	task_2()

end

local tick_count = 0
--local tick_switch = true
function AIManager(task_manager)

	-- Tick spread = 31,
	-- all tasks are spread across 31
	-- ticks as opposed to 1 tick.
	--if not tick_switch then tick_switch = not tick_switch; return task_manager end
	tick_count = tick_count+1
	if tick_count == 32 then tick_count = 0 end

	--t0 = getTimeInMillis()

	NPC = task_manager.parent
	if NPC:needToFollow() or NPC:Get():getVehicle() ~= nil then return task_manager end
	if task_manager == nil or NPC == nil then return false end

	EnemyIsSurvivor = instanceof(NPC.LastEnemeySeen, "IsoPlayer")
	EnemyIsZombie = instanceof(NPC.LastEnemeySeen, "IsoZombie")
	EnemySuperSurvivor = nil
	LastSuperSurvivor = nil
	EnemyIsSurvivorHasGun = false
	LastSurvivorHasGun = false

	if EnemyIsSurvivor then
		local id = NPC.LastEnemeySeen:getModData().ID
		EnemySuperSurvivor = SSM:Get(id)
		if EnemySuperSurvivor then
			EnemyIsSurvivorHasGun = EnemySuperSurvivor:hasGun()
		end
	end

	if NPC.LastSurvivorSeen then
		local lsid = NPC.LastSurvivorSeen:getModData().ID
		LastSuperSurvivor = SSM:Get(lsid)
		if LastSuperSurvivor then
			LastSurvivorHasGun = LastSuperSurvivor:hasGun()
		end
	end

	HostileInNPCsRange = NPC:isEnemyInRange(NPC.LastEnemeySeen)
	IHaveInjury = NPC:HasInjury()
	weapon = NPC.player:getPrimaryHandItem()
	IsInAction = NPC:isInAction()
	HisGroup = NPC:getGroup()
	IsInBase = NPC:isInBase()
	CenterBaseSquare = nil
	DistanceBetweenMainPlayer = getDistanceBetween(getSpecificPlayer(0), NPC:Get())
	Distance_AnyEnemy = getDistanceBetween(NPC.LastEnemeySeen, NPC:Get())  -- idk if this works
	if HisGroup then CenterBaseSquare = HisGroup:getBaseCenter() end

	NPC:Companion_DoSixthSenseScan()

	--chance = ZombRand(0, 100)/100

	-- Companion follower task.
	-- 2 sub tasks.
	--if tick_count == 1 or tick_count == 2 then companion_follower_task(task_manager) end
	companion_follower_task(task_manager)

	-- Pursue task.
	-- 1 sub task.
	if tick_count == 3 then pursue_task(task_manager) end

	-- Surrender task.
	-- 1 sub task.
	if tick_count == 4 then surrender_task(task_manager) end

	-- Companion tasks.
	-- 6 sub tasks.
	-- ticks 5 to 10.
	if tick_count >= 5 and tick_count <= 10 then companion_tasks(task_manager) end

	-- Force leave group task.
	-- 1 sub task
	if tick_count == 11 then force_leave_group_task(task_manager) end

	-- Food / drink task.
	-- 1 sub task.
	if tick_count == 12 then food_drink_task(task_manager) end

	-- Listen to task.
	-- 1 sub task.
	if tick_count == 13 then listen_to_task(task_manager) end

	-- Companion weapon tasks.
	-- 3 sub tasks.
	-- itck 14 to 16.
	if tick_count >= 14 and tick_count <= 16 then companion_weapon_tasks(task_manager) end

	-- Base tasks.
	-- ~10 sub tasks.
	-- ticks 17 to 27.
	if tick_count >= 17 and tick_count <= 27 then base_tasks(task_manager) end

	-- Random solo tasks.
	-- 4 sub tasks.
	-- ticks 28 to 31
	if tick_count >= 28 and tick_count <= 31 then random_solo_task(task_manager) end

	--if(NPC.DebugMode) then NPC:DebugSay(NPC:getName().." "..NPC:getAIMode() .. " AIManager3 " .. task_manager:getCurrentTask()) end

	--print(string.format("%d %.20f", tick_count, getTimeInMillis()-t0))
	--print("chance: "..tostring(chance))
	return task_manager
end