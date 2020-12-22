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

    AddClass(287, 213.693, 1902.717, 17.640, 5.548); // ARMY
    AddClass(286, 214.584,1822.596,6.414,271.861); // FBI
    AddClass(70, 351.283,2537.139,16.733,214.739); // SCIENTIST

    //AddPlayerClass(287, 213.693, 1902.717, 17.640, 5.548, 0, 0, 0, 0, 0, 0);
    //AddPlayerClass(286, 214.584,1822.596,6.414,271.861, 0, 0, 0, 0, 0, 0);

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