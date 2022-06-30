


Update 15 Experimental - U1

This will be in experimental until there is enough additions to make it public-worthy

* Updated "LootCategoryTask:ForceFinish()" function to avoid nil errors. Thanks to Chingling152 for this knowledge!!
* Started cleaning code of the AI-Manager.Lua file


Update 15 Experimental - U2
* Cleaned up SuperSurvivorOptions.lua - the more files cleaned, the more optimized the mod will be - Special thanks to Chingling152 for helping make this happen!


Update 15 Experimental - U3
* Updates to the Debug mode - To be able to find bugs, we must create a more diverse debugging system. And now the in game options has that. 


Experimental 15 - U4

* Updates to the "DebugCharacterUnStuck", so when right click unstuck an NPC, the NPC in question may actually move now. 
* * (This needs more testing)

* Made an adjustment to how 'NPCs Get stuck management' is handled, which was causing NPCs to 'stutter walk' during some instances. 
* * (Also needs testing to see how NPCs are moving around)

* The options menu has been updated further! any setting that had a % chance to do something? Now scales from 0% to 100%. You now have full control.
* Fixed a bug where the previous one that modded the NPCs mod did not have "Hostile over time" to function correctly. It was copying a different option value! 


Experimental 15 - U5
* Hoxfix for NPCs not stopping mid combat
* Update to AImanager - Attempt fix NPcs running away right after any form of combat 


Experimental 15 - U6
* NPCs seem to run away from hordes with melee
* NPCs seem not to run away as much with guns during hordes
* NPCs combat each other just fine
* NPCs do not run away after a combat encounter  as far as noticed

Experimental 15 - U7
* NPCs that are your 'companions' will now obey new orders that you give them
* Please report any weird results of this. I am trying to see if the job 'Worker' has other things with them. I couldn't find anything, so I figured this would hopefully give the NPC in question to do what you tell them to do. 
* Basically, please report any weirdness from NPCs when you give them new orders after you give them the 'follow' order. 

Experimental 15 - U7.1
* Further tweaks to the 'follow task'. NPCs that follow you should now follow you more efficiently, and run to you better, (based off the in game follow option) in hopes to make it where you don't have to constantly use the hotkeys 'stay closer' to 0, just to get an NPC to run to you. 

Experimental 15 - U7.3
* NPCs should do pretty darn greatly with the follow task
* Fixed a bug where Alt Spawn NPCs was creating an error when checking to be hostile chance.

