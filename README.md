# samp-area51

[![sampctl](https://img.shields.io/badge/sampctl-samp--area51-2f2f2f.svg?style=for-the-badge)](https://github.com/bwhitmire55/samp-area51)

<!--
Short description of your library, why it's useful, some examples, pictures or
videos. Link to your forum release thread too.

Remember: You can use "forumfmt" to convert this readme to forum BBCode!

What the sections below should be used for:

`## Installation`: Leave this section un-edited unless you have some specific
additional installation procedure.

`## Testing`: Whether your library is tested with a simple `main()` and `print`,
unit-tested, or demonstrated via prompting the player to connect, you should
include some basic information for users to try out your code in some way.

And finally, maintaining your version number`:

* Follow [Semantic Versioning](https://semver.org/)
* When you release a new version, update `VERSION` and `git tag` it
* Versioning is important for sampctl to use the version control features

Happy Pawning!
-->

## samp-area51

samp-area51 is a replica of the once very popular 'The Area 51 Server'. Once a part of the Official Server List, the premise of the server was simple; a standard TDM script where Area 51 base personnel try to prevent a group of individual from entering the base. This remake will focus on replicating the core mechanics of the original gamemode script, while flushing out some of the lesser touched parts. These would include a more objective style play, or potentially a story, to make better sense of the surrounding madness; updated visual asthetics for a more soothing appearance; and extending base systems found commonly among all gamemode server scripts.

Base idea credits, and the original authors of the script, go to [RP]Jolteon/Redirect_Left and [RP]Ettans. 

## Features

* Two base gamemodes (Break-In and Break-Out)
* Player Rank system; progressing through the ranks will be access to various capabilities in-game
* Achievement system
* Administrator system
* Team-balancing system
* Anti-Cheat System

## Classes

* Defenders
    * Army [M4, MP5, Grenade]
    * FBI [MP5, Desert Eagle, Nightstick]
    * Scientist [Desert Eagle, Rocket Launcher, Knife]
    * Medic [Shotgun, Colt45, Fire Extinguisher]
* Attackers
    * Thug [AK47, Desert Eagle, Baseball Bat]
    * Pyromaniac [M4, Spaz Shotgun, Flamethrower]
    * Sniper [Sniper Rifle, Silenced Pistol, Knife]
    * Medic [Shotgun, Colt45, Fire Extinguisher]

## Ranks

* Rank 1 [x kills] -> 
* Rank 2 [x kills] ->
* Rank 3 [x kills] -> 
* Rank 4 [x kills] -> Drive the Seasparrow or Hydra

## Achievements

Fill

## Administrator System

* Level 1
    * /spec [id]
    * /unspec
    * /slap [id]
    * /warn [id] [reason]
    * /kick [id] [reason]
* Level 2
    * /ban [id] [reason]
    * /goto [id]
    * /get [id]
* Level 3
    * /(an)nounce [message]
    * /makeadmin [id] [level]

## Team-Balance System

Fill

## Anti-Cheat System

* Anti C-Bug
* Anti Money Hack
* Gameplay-based systems
    * Entering an objective when otherwise impossible (Breaking-In before gate has been breached)

## General Commands

* /help
* /rules
* /register [password]
* /login [password]
* /stats [(opt)id]
* /kill
* /class

## Dependencies

ZCMD (ZeeX)

## Todo

-> Re-work the dev environment setting. Tools and tests should be independent of one another

-> Tests should have a core module which regulates how they operate (i.e. printing to file)