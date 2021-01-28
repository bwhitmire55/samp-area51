//
// grand_master_cluck.p
//

#define ACH_NAME        "Grand Master Cluck"

public OnGameModeInit() {
    RegisterAchievement(ACH_NAME, "Obtain 1000 kills");
    return CallLocalFunction("gmcluck_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit 
#else 
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit gmcluck_OnGameModeInit
forward gmcluck_OnGameModeInit();

public OnPlayerDeath(playerid, killerid, reason) {
    if(GetPlayerKills(killerid) == 1000) {
        AwardPlayerAchievement(killerid, ACH_NAME);
    }
    return CallLocalFunction("gmcluck_OnPlayerDeath", "iii", playerid, killerid, reason);
}

#if defined _ALS_OnPlayerDeath
    #undef OnPlayerDeath 
#else 
    #define _ALS_OnPlayerDeath
#endif
#define OnPlayerDeath gmcluck_OnPlayerDeath
forward gmcluck_OnPlayerDeath(playerid, killerid, reason);

#undef ACH_NAME