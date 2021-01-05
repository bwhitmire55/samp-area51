//
// rank.p
//

enum {
    eRank_Level_0,
    eRank_Level_1,
    eRank_Level_2,
    eRank_Level_3,
    eRank_Level_4
};

static gPlayerRank[MAX_PLAYERS] = {eRank_Level_0, ...};

GetPlayerRank(playerid) {
    return gPlayerRank[playerid];
}

public OnGameModeInit() {
    AddAccountData("rank", TYPE_INT, gPlayerRank);
    return CallLocalFunction("rank_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else 
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit rank_OnGameModeInit
forward rank_OnGameModeInit();

public OnPlayerDisconnect(playerid, reason) {
    gPlayerRank[playerid] = eRank_Level_0;
    return CallLocalFunction("rank_OnPlayerDisconnect", "ii", playerid, reason); 
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect 
#else
    #define _ALS_OnPlayerDisconnect 
#endif 
#define OnPlayerDisconnect rank_OnPlayerDisconnect
forward rank_OnPlayerDisconnect(playerid, reason);