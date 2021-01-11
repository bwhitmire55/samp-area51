//
// admin.p
//

static gPlayerAdminLevel[MAX_PLAYERS];

SetPlayerAdminLevel(playerid, level) {
    gPlayerAdminLevel[playerid] = level;   
}

GetPlayerAdminLevel(playerid) {
    return gPlayerAdminLevel[playerid];
}

public OnGameModeInit() {
    AddAccountData("admin", TYPE_INT, gPlayerAdminLevel);
    return CallLocalFunction("admin_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else 
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit admin_OnGameModeInit
forward admin_OnGameModeInit();

public OnPlayerDisconnect(playerid, reason) {
    gPlayerAdminLevel[playerid] = 0;
    return CallLocalFunction("admin_OnPlayerDisconnect", "ii", playerid, reason); 
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect 
#else
    #define _ALS_OnPlayerDisconnect 
#endif 
#define OnPlayerDisconnect admin_OnPlayerDisconnect
forward admin_OnPlayerDisconnect(playerid, reason);