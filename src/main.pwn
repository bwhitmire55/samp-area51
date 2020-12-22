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
#include "game/mode.p"
#include "game/classes.p"
// - Modes - //
#include "game/modes/intermission.p"
#include "game/modes/break-in.p"
#include "game/modes/break-out.p"
// - Tools - //
#include "tools/coordSaver.p"
#include "tools/classSwitcher.p"

main() {}

public OnGameModeInit() {

    // ----- TEMP TEST CODE START ----- //

    LoadMode(MODE_BREAK_IN);

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