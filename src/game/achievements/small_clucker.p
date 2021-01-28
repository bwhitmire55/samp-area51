//
// small_clucker.p 
//  Get 100 kills
//

#define ACH_NAME        "Small Clucker"

public OnGameModeInit() {
    RegisterAchievement(ACH_NAME, "Obtain 100 kills");
    return CallLocalFunction("scluck_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit 
#else 
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit scluck_OnGameModeInit
forward scluck_OnGameModeInit();

public OnPlayerDeath(playerid, killerid, reason) {
    if(GetPlayerKills(killerid) == 100) {
        AwardPlayerAchievement(killerid, ACH_NAME);
    }
    return CallLocalFunction("scluck_OnPlayerDeath", "iii", playerid, killerid, reason);
}

#if defined _ALS_OnPlayerDeath
    #undef OnPlayerDeath 
#else 
    #define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath scluck_OnPlayerDeath
forward scluck_OnPlayerDeath();

#undef ACH_NAME