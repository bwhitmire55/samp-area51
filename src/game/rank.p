//
// rank.p
//

#define VEHICLE_HYDRA       (520)
#define VEHICLE_SEA_SPARROW (447)

enum {
    eRank_Level_0,
    eRank_Level_1,
    eRank_Level_2,
    eRank_Level_3,
    eRank_Level_4
};

static gPlayerRank[MAX_PLAYERS] = {eRank_Level_0, ...};

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

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger) {
    new model = GetVehicleModel(vehicleid);

    if(model == VEHICLE_HYDRA || model == VEHICLE_SEA_SPARROW) {
        if(gPlayerRank[playerid] < eRank_Level_4 && !ispassenger) {
            SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Error: {FFFFFF}Must be rank 4 to pilot the Hydra and Sea Sparrow.");
        }
    }
    return CallLocalFunction("rank_OnPlayerEnterVehicle", "iii", playerid, vehicleid, ispassenger);
}

#if defined _ALS_OnPlayerEnterVehicle
    #undef OnPlayerEnterVehicle 
#else
    #define _ALS_OnPlayerEnterVehicle
#endif 
#define OnPlayerEnterVehicle rank_OnPlayerEnterVehicle
forward rank_OnPlayerEnterVehicle(playerid, vehicleid, ispassenger);

public OnVehicleStreamIn(vehicleid, forplayerid) {
    new model = GetVehicleModel(vehicleid);
    if(model == VEHICLE_HYDRA || model == VEHICLE_SEA_SPARROW) {
        if(gPlayerRank[forplayerid] < eRank_Level_4) {
            SetVehicleParamsForPlayer(vehicleid, forplayerid, false, true);
        }
    }
    return CallLocalFunction("rank_OnVehicleStreamIn", "ii", vehicleid, forplayerid);
}

#if defined _ALS_OnVehicleStreamIn
    #undef OnVehicleStreamIn 
#else 
    #define _ALS_OnVehicleStreamIn 
#endif 
#define OnVehicleStreamIn rank_OnVehicleStreamIn
forward rank_OnVehicleStreamIn(vehicleid, forplayerid);