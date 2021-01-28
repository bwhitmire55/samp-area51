//
// big_clucker.p
//

#define ACH_NAME        "Big Clucker"

public OnGameModeInit() {
    RegisterAchievement(ACH_NAME, "Obtain 250 kills");
    return CallLocalFunction("bcluck_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit 
#else 
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit bcluck_OnGameModeInit
forward bcluck_OnGameModeInit();

public OnPlayerDeath(playerid, killerid, reason) {
    if(GetPlayerKills(killerid) == 250) {
        AwardPlayerAchievement(killerid, ACH_NAME);
    }
    return CallLocalFunction("bcluck_OnPlayerDeath", "iii", playerid, killerid, reason);
}

#if defined _ALS_OnPlayerDeath
    #undef OnPlayerDeath 
#else 
    #define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath bcluck_OnPlayerDeath
forward bcluck_OnPlayerDeath(playerid, killerid, reason);

#undef ACH_NAME