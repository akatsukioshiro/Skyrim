# Unique Skill - Allegiant Dead #
## Introduction ##
### Existing Magic ###
  * __Spells__ : ___(Alteration, Conjuration, Destruction, Enchanting, Illusion, Restoration)___
  * __Shouts__
  * __Ability__
### New Magic ###
#### Allegiant Dead : Introduction ####
  * This is _papyrus scripted_ magic.
  * This magic is Quest based.
  * Computationally, this mod is mid-heavy.
#### Allegiant Dead : Working ####
  * Establishes ___NPC Recognition System___, currently recognizes last _30 NPCs_ player meets.
  * ___Crosshair____ is programmed to identify NPCs using _actor references_.
  * ___Enslaves NPCs___ __killed by player__ to fight in favor if NPC is among last 30 NPCs player meets.
  * NPCs killed by player are forced faction changes, relation ship rank changes etc, and given __Quest Reference Alias__ with ___Follow___ AI Package.
  * __Number of enslaved NPCs is also limitted to 30__, it is a _circular loop_ and new NPCs can be added to _replace previously enslaved NPCs_.
  * NPCs falling out of enslaved NPCs loop meet their fate, ___ie Die___.
  
