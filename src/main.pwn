/**
    The Area 51 Server Script

    Copyright (c) Blake Whitmire, 2020
 */


#include <a_samp>

// overwrite a_samp constants
#undef MAX_PLAYERS
#define MAX_PLAYERS     (30)

// toggle dev environment
#define DEV_ENVIRONMENT

// client rules
#define SERVER_HOSTNAME         "The Area 51 Server"
#define SERVER_GAMEMODE         "Default"
#define SERVER_MAPNAME          "San Andreas"
#define SERVER_WEBURL           "www.sa-mp.com"

// --- Include Modules --- //
// - Game - //
#include "game/classes.p"
// - Tools - //
#include "tools/coordSaver.p"
#include "tools/classSwitcher.p"

main() {}

public OnGameModeInit() {

    // ----- TEMP TEST CODE START ----- //

    new class_Army = AddClass(287, 213.693, 1902.717, 17.640, 5.548); // ARMY
    SetClassWeapon(class_Army, WEAPON_M4, 300);
    SetClassWeapon(class_Army, WEAPON_MP5, 200);
    SetClassWeapon(class_Army, WEAPON_GRENADE, 5);

    new class_FBI = AddClass(286, 214.584,1822.596,6.414,271.861); // FBI
    SetClassWeapon(class_FBI, WEAPON_MP5, 300);
    SetClassWeapon(class_FBI, WEAPON_DEAGLE, 60);
    SetClassWeapon(class_FBI, WEAPON_NITESTICK, 1);

    new class_Scientist = AddClass(70, 351.283,2537.139,16.733,214.739); // SCIENTIST
    SetClassWeapon(class_Scientist, WEAPON_DEAGLE, 60);
    SetClassWeapon(class_Scientist, WEAPON_ROCKETLAUNCHER, 5);
    SetClassWeapon(class_Scientist, WEAPON_KNIFE, 1);

    new class_Thug = AddClass(121, -379.358,2201.278,42.356,247.009); // THUG
    SetClassWeapon(class_Thug, WEAPON_AK47, 300);
    SetClassWeapon(class_Thug, WEAPON_DEAGLE, 60);
    SetClassWeapon(class_Thug, WEAPON_BAT, 1);

    new class_Pyro = AddClass(206, -366.686,2202.583,42.484,191.235); // PYRO
    SetClassWeapon(class_Pyro, WEAPON_M4, 300);
    SetClassWeapon(class_Pyro, WEAPON_SHOTGSPA, 70);
    SetClassWeapon(class_Pyro, WEAPON_FLAMETHROWER, 50);

    new class_Sniper = AddClass(122, 315.713,973.972,1961.442,357.029); // SNIPER
    SetClassInterior(class_Sniper, 9);
    SetClassWeapon(class_Sniper, WEAPON_SNIPER, 100);
    SetClassWeapon(class_Sniper, WEAPON_SILENCED, 100);
    SetClassWeapon(class_Sniper, WEAPON_KNIFE, 1);

    // ----- TEMP TEST CODE END ----- //

    // set client rules
    SendRconCommand("hostname "SERVER_HOSTNAME);
    SendRconCommand("gamemodetext "SERVER_GAMEMODE);
    SendRconCommand("mapname "SERVER_MAPNAME);
    SendRconCommand("WebURL "SERVER_WEBURL);

    // set world elements
    UsePlayerPedAnims();
    DisableInteriorEnterExits();
    AllowInteriorWeapons(false);
    EnableStuntBonusForAll(false);

    #if defined DEV_ENVIRONMENT
        SendRconCommand("loadfs fsdebug");
    #endif
    return 1;
}

public OnPlayerRequestClass(playerid, classid) {

    SetPlayerPos(playerid, 0.00, 0.00, 5.00);
    SetPlayerFacingAngle(playerid, 90.0);
    SetPlayerCameraPos(playerid, 0.00, 5.00, 5.00);
    SetPlayerCameraLookAt(playerid, 0.00, 0.00, 5.00);

    SendClientMessage(playerid, 0x00FF00FF, "Class has been requested.");
    return 1;
}