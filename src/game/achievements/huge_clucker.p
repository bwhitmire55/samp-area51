//
// huge_clucker.p
//

#define ACH_NAME        "Huge Clucker"

public OnGameModeInit() {
    RegisterAchievement(ACH_NAME, "Obtain 500 kills");
    return CallLocalFunction("hcluck_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit 
#else 
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit hcluck_OnGameModeInit
forward hcluck_OnGameModeInit();

public OnPlayerDeath(playerid, killerid, reason) {
    if(GetPlayerKills(killerid) == 500) {
        AwardPlayerAchievement(killerid, ACH_NAME);
    }
    return CallLocalFunction("hcluck_OnPlayerDeath", "iii", playerid, killerid, reason);
}

#if defined _ALS_OnPlayerDeath
    #undef OnPlayerDeath 
#else 
    #define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath hcluck_OnPlayerDeath
forward hcluck_OnPlayerDeath(playerid, killerid, reason);

#undef ACH_NAME