LMSConditions = {}
LMSConditions.MoodleTable = {}
LMSConditions.LowerMoodleTable = {}
LMSConditions.TimeOfRegister = nil

LMSConditions.SlightlyBored = {
"",
""
}
LMSConditions.Bored = {
"",
"",
"",
""
}
LMSConditions.VeryBored = {
"",
"",
"",
""
}
LMSConditions.ExtremelyBored = {
"",
"",
"",
""
}
LMSConditions.SlightlyStressed = {
""
}
LMSConditions.Stressed = {
""
}
LMSConditions.VeryStressed = {
""
}
LMSConditions.ExtremelyStressed = {
""
}
LMSConditions.SlightlyPanicked = SurvivorSpeechTable["Panic"]
LMSConditions.Panicked = SurvivorSpeechTable["Scared"]
LMSConditions.VeryPanicked = SurvivorSpeechTable["Scared"]
LMSConditions.ExtremelyPanicked = SurvivorSpeechTable["Scream"]
LMSConditions.Zombie = {
"",
""
}
LMSConditions.SlightlyPainful = SurvivorSpeechTable["Hurt"]
LMSConditions.Painful = SurvivorSpeechTable["Injured"]
LMSConditions.VeryPainful = SurvivorSpeechTable["Injured"]
LMSConditions.ExtremelyPainful = SurvivorSpeechTable["BadInjured"]
LMSConditions.Campfire = {
"*sings* Irene goodnight, Irene goodnight. Goodnight, Irene, goodnight, Irene, I'll see you in my dreams...",
"*sings* Val-der-ri, val-der-ra Val-der-ra, val-der-ha ha ha ha ha ha Val-der-ri, val-der-ra...",
"*sings* One bright day in the middle of the night, Two dead boys got up to fight, Back to back the faced each other", 
"Drew their swords and shot each other. A deaf police man heard the noise, So he came and shot those two dead boys.", 
"If you don\'t believe this lie is true, Ask the blind man he saw too.",
"*sings* Swing low, sweet chariot, Comin' for to carry me home; Swing low, sweet chariot, Comin' for to carry me home."
}
LMSConditions.LMSMoodles = {
"Endurance",
"Tired",
"Hungry",
"Panic",
"Sick",
"Bored",
"Unhappy",
"Bleeding",
"Wet",
"HasACold",
"Angry",
"Stress",
"Thirst",
"Injured",
"Pain",
"HeavyLoad",
"Drunk",
"Zombie",
"Hyperthermia",
"Hypothermia",
"FoodEaten"
}

function LMSConditions.checkIfLoaded() -- prevent player from re-saying a condition
	getPlayer():getMoodles():Update() -- makes sure that the Moodles system is properly loaded
	LMSConditions.retrieveMoodles() -- retrieves moodles
	Events.OnPlayerUpdate.Add(LMSConditions.checkForConditions) -- preps conditions checker
end


function LMSConditions.retrieveMoodles()
	for i = 1,#LMSConditions.LMSMoodles do
		loadstring("LMSConditions.MoodleTable["..i.."] = getPlayer():getMoodles():getMoodleLevel(MoodleType."..LMSConditions.LMSMoodles[i]..")")() -- uses loadstring to have MoodleType call the table with the same name as LMSMoodles.
	end
end


function LMSConditions.checkIfAttacking(player,item)
	if player:isLocalPlayer() == false then
		
		if player:getPrimaryHandItem() ~= nil then -- has to do multiple, separate checks to prevent erroring if the hand weapon isn't a gun
			if player:getPrimaryHandItem():isRanged() then
				if player:getPrimaryHandItem():getModData().currentCapacity == 0 then -- checks for empty gun
					LMSConditions.generateRandomNumber(player,SurvivorSpeechTable["OutOfAmmo"])
				end
			end
		end
	end
end


function LMSConditions.generateRandomNumber(player, conditionTable, optionalNumber)
	if(conditionTable == nil) then return false end
	local randNumber = ZombRand(#conditionTable) + 1 -- enumerates given table
	local name = ""
	if(player:getModData().Name) then name = player:getModData().Name end
	local ID = player:getModData().ID;
	local SS = SSM:Get(ID)
	--player:Say(name..": "..conditionTable[randNumber])
	SS:Speak(conditionTable[randNumber])
	
	
end

Speech = {};
SpeechLevel = {};

function LMSConditions.doMoodleCheck(player,LMSMoodleLevel, LMSMoodleType, conditionTable, indexNumber, isDoSecondMoodle, optionalMoodleLevel, optionalMoodleType, optionalIndexNumber)
	local SID = player:getModData().ID;
	if(not SID) then return false end
	if(Speech[SID]== nil) then		
		Speech[SID] = {};
		SpeechLevel[SID]= {};
	end
		local SS = SSM:Get(SID)
		
		if((MoodleType.Panic == LMSMoodleType) and (player:getVehicle()~= nil)) or not SS or (SS:isSpeaking()) then return false end
	
		local moodleGet = player:getMoodles():getMoodleLevel(LMSMoodleType)
		if (Speech[SID] ~= nil) and (SpeechLevel[SID]~= nil) and (moodleGet == LMSMoodleLevel) and ( (Speech[SID][LMSMoodleType] == nil) or (SpeechLevel[SID][LMSMoodleType] == nil) or ((SpeechLevel[SID][LMSMoodleType] ~= moodleGet) or (Speech[SID][LMSMoodleType] ~= LMSMoodleType)) ) then
			if (SpeechLevel[SID][LMSMoodleType] == nil) or (moodleGet > SpeechLevel[SID][LMSMoodleType]) then -- prevents conditional speech from toggling for a lower moodle level.
				--player:Say(tostring(SpeechLevel[SID][LMSMoodleType])..","..tostring(Speech[SID][LMSMoodleType]) .. " "..tostring(moodleGet));
				
				Speech[SID][LMSMoodleType] = LMSMoodleType
				SpeechLevel[SID][LMSMoodleType] = moodleGet;
				LMSConditions.generateRandomNumber(player,conditionTable)				
			else
				
				Speech[SID][LMSMoodleType] = LMSMoodleType
				SpeechLevel[SID][LMSMoodleType] = moodleGet;
			end
		end
	
end


function LMSConditions.checkForConditions(player)

	if player:isLocalPlayer() == false then
		
		--Hunger--
		
		LMSConditions.doMoodleCheck(player,1, MoodleType.Sick, SurvivorSpeechTable["Sick"], 3)
		LMSConditions.doMoodleCheck(player,2, MoodleType.Sick, SurvivorSpeechTable["VSick"], 3)
		LMSConditions.doMoodleCheck(player,3, MoodleType.Sick, SurvivorSpeechTable["SSick"], 3)
		LMSConditions.doMoodleCheck(player,4, MoodleType.Sick, SurvivorSpeechTable["SSick"], 3)
		
		--Hunger--
		
		LMSConditions.doMoodleCheck(player,1, MoodleType.Hungry, SurvivorSpeechTable["Hungry"], 3)
		LMSConditions.doMoodleCheck(player,2, MoodleType.Hungry, SurvivorSpeechTable["VHungry"], 3)
		LMSConditions.doMoodleCheck(player,3, MoodleType.Hungry, SurvivorSpeechTable["Starving"], 3)
		LMSConditions.doMoodleCheck(player,4, MoodleType.Hungry, SurvivorSpeechTable["Starving"], 3)
		
		--Thirst--
		
		LMSConditions.doMoodleCheck(player,1, MoodleType.Thirst,  SurvivorSpeechTable["Thirsty"], 13)
		LMSConditions.doMoodleCheck(player,2, MoodleType.Thirst,  SurvivorSpeechTable["Thirsty"], 13)
		LMSConditions.doMoodleCheck(player,3, MoodleType.Thirst,  SurvivorSpeechTable["VThirsty"], 13)
		LMSConditions.doMoodleCheck(player,4, MoodleType.Thirst,  SurvivorSpeechTable["SThirsty"], 13)
		
		--Tired--
		
		LMSConditions.doMoodleCheck(player,1, MoodleType.Tired, SurvivorSpeechTable["Tired"], 2)
		LMSConditions.doMoodleCheck(player,2, MoodleType.Tired, SurvivorSpeechTable["Tired"], 2)
		LMSConditions.doMoodleCheck(player,3, MoodleType.Tired, SurvivorSpeechTable["VTired"], 2)
		LMSConditions.doMoodleCheck(player,4, MoodleType.Tired, SurvivorSpeechTable["STired"], 2)
		
		--Boredom--
		
		LMSConditions.doMoodleCheck(player,1, MoodleType.Bored, LMSConditions.SlightlyBored, 6)
		LMSConditions.doMoodleCheck(player,2, MoodleType.Bored, LMSConditions.Bored, 6)
		LMSConditions.doMoodleCheck(player,3, MoodleType.Bored, LMSConditions.VeryBored, 6)
		LMSConditions.doMoodleCheck(player,4, MoodleType.Bored, LMSConditions.ExtremelyBored, 6)
		
		--Stress--
		
		LMSConditions.doMoodleCheck(player,1, MoodleType.Stress, LMSConditions.SlightlyStressed, 12)
		LMSConditions.doMoodleCheck(player,2, MoodleType.Stress, LMSConditions.Stressed, 12)
		LMSConditions.doMoodleCheck(player,3, MoodleType.Stress, LMSConditions.VeryStressed, 12)
		LMSConditions.doMoodleCheck(player,4, MoodleType.Stress, LMSConditions.ExtremelyStressed, 12)
		
		--Panic--
		
		LMSConditions.doMoodleCheck(player,1, MoodleType.Panic, LMSConditions.SlightlyPanicked, 4)
		LMSConditions.doMoodleCheck(player,2, MoodleType.Panic, LMSConditions.Panicked, 4)
		LMSConditions.doMoodleCheck(player,3, MoodleType.Panic, LMSConditions.VeryPanicked, 4)
		LMSConditions.doMoodleCheck(player,4, MoodleType.Panic, LMSConditions.ExtremelyPanicked, 4)
		
		--Zombification--
		
		LMSConditions.doMoodleCheck(player,1, MoodleType.Zombie, LMSConditions.Zombie, 18)
		
		--Pain--
		
		LMSConditions.doMoodleCheck(player,1, MoodleType.Pain, LMSConditions.SlightlyPainful, 15)
		LMSConditions.doMoodleCheck(player,2, MoodleType.Pain, LMSConditions.Painful, 15)
		LMSConditions.doMoodleCheck(player,3, MoodleType.Pain, LMSConditions.VeryPainful, 15)
		LMSConditions.doMoodleCheck(player,4, MoodleType.Pain, LMSConditions.ExtremelyPainful, 15)
		
		
	end
end


Events.OnLoad.Add(LMSConditions.checkIfLoaded)
--Events.OnWeaponSwing.Add(LMSConditions.checkIfAttacking)