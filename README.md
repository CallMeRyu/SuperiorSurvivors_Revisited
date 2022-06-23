Update 14 Experimental 

- Survivor Bravery is now included on combat tasks. Will it help? It seems like the NPCs won't run away always after first hit. At least with my testing.

- Pursue Task Update: I brought it back, I believe I figured out how to keep it working too. Now the hostile NPCs will not magically forget where you are 
within a short range. But if they are on your tail, they're going to try to find you, and they're going to be better at it. (That's the hopeful idea anyways.)

- Walking/Running: Added a new function to assist the NPCs to run or walk to their targets. This is to assist further on fixing the issues where
the NPCs run into the main player or into each other, or pushing you into a horde of zombies. 

- Guns Update: NPCs be a bit better with guns. Especially the hostile NPCs. The hostile NPCs currently will not goto to you to threaten you, then run off
to reload and then fight you. The NPCs will now prepare for battle like they should. This wasn't easy to get going, but so far things are looking good, 
and the NPCs are mostly doing what they're supposed to.

The NPCs on Pursue task / Threaten task, when very far away, they are currently walking, when they should be running. This is currently a known bug
and I'll be working on that later too. But for now, here you go (to anyone that reads this.)


You want to go here and send the files into this area. Make sure you get a prompt to overwrite existing files. 
![image](https://user-images.githubusercontent.com/73253293/175006784-0671d6e8-8fc1-4edf-be0c-405f3f01d92a.png)


Update 14 Experimental - 2nd upload

- Guns: NPCs should now be even better with using guns as they were previously than last upload. 
The NPCs will run away though once they have realized they don't have ammo or sense they are in danger for the most part. 
So this would include your player groups. The NPCs will try to keep their own life in tact. (or try to anyways.)

- Bravery: Forgot about this, but I adjusted the 'Very brave' option. Instead of it being 4 points of bravery, it's now 50. 
I have no idea how this will effect the NPCs. It may do nothing at all, or it may break everything else. 


Update 14 Experimental - Upload 3. 
- I figured out why the NPCs weren't attacking zeds. 



Update 14 Experimental - Upload 4
- Unless you have Debug mode on (the in game option) you can no longer spawn an NPC while pressing 6 key.                                                       
[THANKS TO NIGHTSCALE FOR FINDING THIS]

- Debug mode in the options actually will turn on the debug features.
- Marked off some of the "print()" functions, it may not seem like much, but enough of them running at once will start adding lag. So, removed some leftovers from the previous modders.

- Carefully updated Task_IsPursue_SC() function. Now it will let any NPC scan for humans, but as long as it doesn't have a target and along with several other if's.
Basically what this means is, the NPCs will have a small radius sense around them to know when there's another hostile around them. (does it always work? Mostly)
But generally this is meant for hostile NPCs the most. This way if a NPC gets behind another while an attack happens, the npc can turn around. to simulate that they know that there was just previously a fight going on, and then continue the fight.
.
.
.

Update 14 Experimental - Upload 5
- NPCs that are your companions, should now follow you more often. HOWEVER, you will notice they will try to run away, but they won't go too far away. If they go outside roughly 10 blocks away, they'll return back to you. 
- Alt spawning update: You now will also be able to spawn a group and the % seperatly. Right now the localization text isn't correct, it will still say 'group and %' but it really is saying 'ONLY groups'. 

Time to get some sleep =P

Notes to do
- Make the alt spawning obey the 'chance to spawn hostile' rules
- 

Update 14 Experimental - Upload 6
- Updated Options menu, it's now a lot easier to read
- Updated Alt spawning: You now can choose 0% to 100% chance for alt spawning to take effect each hour


Update 14 Experimental - Upload 7
- More work towards NPCs tasks when they're the companion role (To following the main player) so they don't run away
- More work into making the NPCs to enforce walking 