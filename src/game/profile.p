//
// profile.p
//

static gPlayerKills[MAX_PLAYERS];
static gPlayerDeaths[MAX_PLAYERS];

public OnGameModeInit() {
    AddAccountData("kills", TYPE_INT, gPlayerKills);
    AddAccountData("deaths", TYPE_INT, gPlayerDeaths);
    return CallLocalFunction("profile_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else 
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit profile_OnGameModeInit
forward profile_OnGameModeInit();

public OnPlayerDisconnect(playerid, reason) {
    gPlayerKills[playerid] = 0;
    gPlayerDeaths[playerid] = 0;
    return CallLocalFunction("profile_OnPlayerDisconnect", "ii", playerid, reason);
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect 
#else
    #define _ALS_OnPlayerDisconnect 
#endif 
#define OnPlayerDisconnect profile_OnPlayerDisconnect
forward profile_OnPlayerDisconnect(playerid, reason);

public OnPlayerDeath(playerid, killerid, reason) {
    gPlayerDeaths[playerid]++;

    if(IsPlayerConnected(killerid)) {
        gPlayerKills[killerid]++;
    }
    return CallLocalFunction("profile_OnPlayerDeath", "iii", playerid, killerid, reason);
}

#if defined _ALS_OnPlayerDeath
    #undef OnPlayerDeath 
#else 
    #define _ALS_OnPlayerDeath 
#endif 
#define OnPlayerDeath profile_OnPlayerDeath 
forward profile_OnPlayerDeath(playerid, killerid, reason);