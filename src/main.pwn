/**
    The Area 51 Server Script

    Copyright (c) Blake Whitmire, 2020
 */


#include <a_samp>

// overwrite a_samp constants
#undef MAX_PLAYERS
#define MAX_PLAYERS     (30)

// 3rd party libraries
#include <sscanf2>
#include <zcmd>

// edited 3rd party libraries
#define ACCOUNT_DATABASE        "area51.db"
#define ACCOUNT_DATABASE_TABLE  "users"
#define ACCOUNT_MAX_COLUMN_NAME (30)
#define ACCOUNT_MAX_COLUMNS     (50)
#include "inc/account.inc"

// toggle dev environment (tools, FS's)
#define DEV_ENVIRONMENT
// toggle dev module tests
//#define DEV_RUN_TESTS

// client rules
#define SERVER_HOSTNAME         "The Area 51 Server"
#define SERVER_GAMEMODE         "Default"
#define SERVER_MAPNAME          "San Andreas"
#define SERVER_WEBURL           "www.sa-mp.com"

// --- Include Modules --- //
// - Util - //
#include "misc/util.p"
// - Game - //
#include "game/mode.p"
#include "game/modetimer.p"
#include "game/classes.p"
#include "game/profile.p"
#include "game/rank.p"
#include "game/gen_cmds.p"
#include "game/acc_cmds.p"
// - World - //
#include "game/world/weather.p"
// - Modes - //
#include "game/modes/intermission.p"
#include "game/modes/break-in.p"
#include "game/modes/break-out.p"
// - Tools - //
#include "tools/coordSaver.p"
// - Tests - //
#include "tests/_classes.p"

main() { }

public OnGameModeInit() {

    // ----- TEMP TEST CODE START ----- //



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

    // start the game
    LoadMode(MODE_BREAK_IN);
    return 1;
}