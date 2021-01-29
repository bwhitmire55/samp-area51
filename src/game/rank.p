//
// rank.p
//

#define RANK_MAX_RANKS      (4)
#define RANK_MAX_NAME_LEN   (20)
#define RANK_MAX_DESC_LEN   (60)

#define RANK_INVALID        (2,147,483,647)

enum eRank {
    eRank_Name[RANK_MAX_NAME_LEN],
    eRank_Desc[RANK_MAX_DESC_LEN],
    eRank_Goal
};

static gRankData[RANK_MAX_RANKS][eRank];
static gRankIter;
static gPlayerRank[MAX_PLAYERS];

RegisterRank(const name[], const desc[], goal) {
    if(gRankIter != RANK_MAX_RANKS) {
        strcat(gRankData[gRankIter][eRank_Name], name);
        strcat(gRankData[gRankIter][eRank_Desc], desc);
        gRankData[gRankIter][eRank_Goal] = goal;
        gRankIter++;
        return gRankIter;
    }
    return RANK_INVALID;
}

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
    gPlayerRank[playerid] = 0;
    return CallLocalFunction("rank_OnPlayerDisconnect", "ii", playerid, reason); 
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect 
#else
    #define _ALS_OnPlayerDisconnect 
#endif 
#define OnPlayerDisconnect rank_OnPlayerDisconnect
forward rank_OnPlayerDisconnect(playerid, reason);

public OnPlayerDeath(playerid, killerid, reason) {
    if(IsPlayerConnected(killerid)) {
        for(new i = 0; i < gRankIter; i++) {
            if(GetPlayerKills(killerid) == gRankData[i][eRank_Goal]) {
                gPlayerRank[killerid] = i+1;
                CallLocalFunction("OnPlayerRankChange", "ii", playerid, gPlayerRank[killerid]);
                break;
            }
        }
    }
    return CallLocalFunction("rank_OnPlayerDeath", "iii", playerid, killerid, reason);
}

#if defined _ALS_OnPlayerDeath
    #undef OnPlayerDeath 
#else
    #define _ALS_OnPlayerDeath
#endif 
#define OnPlayerDeath rank_OnPlayerDeath
forward rank_OnPlayerDeath(playerid, killerid, reason);

forward OnPlayerRankChange(playerid, rank);
public OnPlayerRankChange(playerid, rank) {
    new buffer[128];
    format(buffer, sizeof(buffer), "{FFFFFF}%s has just achieved rank %i[%s] by obtaining %i kills - %s",
        rank, 
        gRankData[rank-1][eRank_Name],
        gRankData[rank-1][eRank_Goal],
        gRankData[rank-1][eRank_Desc]
    );
    SendClientMessageToAll(0xFFFFFFFF, buffer);
    return 1;
}