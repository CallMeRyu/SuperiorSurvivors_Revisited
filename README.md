UPDATE 16 - RELEASED
-
Here is the progress of what happened. 

Update 16 Experimental
-
Yep, already started for the next version of the mod!

EXP 16 - U1 
- 
* Clothing update: You now can make your own addon mods for the NPCs to wear! Got a clothing mod you want the NPCs to wear by chance? Now you can! 

Link to addon: https://steamcommunity.com/sharedfiles/filedetails/?id=2828423670


Special thanks to NightScale for this addition! 

EXP 16 - U2
-
* Added in game option to hide/display NPCs names
* Added in game option to hide/display the red color on hostile NPCs


EXP 16 - U3
-
* Expansion to the Clothing set rarity. So now you can have more tiers of rare chance choices.
ALL THE WAY UP TO legendary 1%

(*Because someone will request it*)


EXP 16 - U4
-
* Added an in game option to hide 'roleplay messages' the kind of messages you would see npcs do like ' *Reloading gun* ' with * in the text. You now have the ability to disable that if you like. 
* Updated PTBR localization - Thanks to ruannuness for this!


EXP 16 - U5
-
(since I did not post update notes in last upload)

* Fixed the clothing mod bug returning 'legendary' rolls as null

* NPCs under the new Pursue_se function should now obey locked door rules more often and will be less likely to get stuck once again =)

* Made adjustments to the Pursue_se and scores functions.
NPCs should be a little bit better reacting with their surroundings.

(*THIS WILL NEED TESTING & FEEDBACK, PLEASE*)

* Weapons expanded* Just like the clothing, you now can make your own addon mods for base weapons and modded weapons into superior survivors!

* Threaten task edit: Now there should be a chance you can run away from a npc threatening you to go away


EXP 16 - U6
-
I *believe* I have made it where the NPCs, when using a gun and reloading it, AND there is zombies near said npc, 99% of the time, that NPC will run away.
This *MAY* have side effects of hostile NPCs running away from you, but that could also be counted as a feature if you turn off hostile colors in the options menu. Also do not worry, this does not effect followers (unless the follower bugs out because some other unforseen reason)
As per always, feedback requested.

EXP 16 - U7
-
* First attempt at fixing the "Chance to spawn with guns" isn't multiplied 1.5x (This is how last modder added it, because previously there wasn't 0-100%, it was multiples of 5 in the options menu.)

* Getting preparations set for AI-Manager update for the future. Soon AI-Manager tasks should use less RAM/CPU since it will not be having to scan through as much code as it previously once did. But for now, just preparing the code for that day.


EXP 16 - U8
-
* Changed HumanEntityScan and SixthSenseScan functions: They will no longer increase dangerseencount; DoVision already does this. What that means is, there should be less likely NPCs will run away from weird situations like you vs the npc while there not being any zombies around.

* dohumanentityscan will also require not standing in front of a door. This should assist with npcs not spamming doors, 'knowing' that you're on the other side.

* Removed a 'return true' at the end of pursue_se

* Changed AI-Manager checks for 'If Job is companion follower', so now followers should ignore certain tasks that aren't meant for them more likely.

* Follower task update to now check more often if the follower has the 'follower' task

* Fixed a bug where 'bravery' was posted twice in value
* Chanced Bravery's default setting to 'very brave' since most players want non-cowardly npcs

* Updated the visual of the options menu to be more easier to read

EXP 16 - U9 (Final)
-
This should be the final update for this experimental update. This is the most I can do, and it's due time for a public release. Other than minor updates that is. 

* Gun damage with NPCs are a bit more randomized, AND they can now MISS their shots. 

* NPCs will no longer try to loot your base! Be sure 'safe base' is on, AND you have your base's squares set!
(Side note: Don't let your mouse left click touch a yellow square when you're clicking in the menu of 'set base', or it'll reset the squares!)

* The clothing addon now supports weapons! You now can add weapon tables from your (or other's) mods for the NPCs!

* Updated the default options for certain settings that players don't consider & yet wonder why x thing isn't happening that they want.
* NPCs are more likely to goto windows again when they can't enter a door! 
* NPCs that are in your group: I increased the priority odds to make NPCs to clean themselves. Was at +0, now at +2
* ManageStuckDoors function will also look out for barricaded windows, even if the name doesn't make sense now. 
* Changed the sixthsense scan, it works with hostile npcs w/guns again
* NPCs will have a chance to give up chasing you if you run far enough away from them 



* As always, updated options menu UI - Some day I'll leave the options menu alone lol.

