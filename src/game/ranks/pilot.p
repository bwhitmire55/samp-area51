//
// pilot.p
//

#define VEHICLE_HYDRA           (520)
#define VEHICLE_SEA_SPARROW     (447)

static gRankID;

public OnGameModeInit() {
    gRankID = RegisterRank("Pilot", "Pilot the Hydra or Seasparrow", 1000);
    return CallLocalFunction("pilot_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit 
#else 
    #define _ALS_OnGameModeInit
#endif 
#define OnGameModeInit pilot_OnGameModeInit
forward pilot_OnGameModeInit();

public OnVehicleStreamIn(vehicleid, forplayerid) {
    new model = GetVehicleModel(vehicleid);
    if(model == VEHICLE_HYDRA || model == VEHICLE_SEA_SPARROW) {
        if(GetPlayerRank(forplayerid) < gRankID) {
            SetVehicleParamsForPlayer(vehicleid, forplayerid, false, true);
        }
    }
    return CallLocalFunction("pilot_OnVehicleStreamIn", "ii", vehicleid, forplayerid);
}

#if defined _ALS_OnVehicleStreamIn
    #undef OnVehicleStreamIn 
#else 
    #define _ALS_OnVehicleStreamIn 
#endif 
#define OnVehicleStreamIn pilot_OnVehicleStreamIn
forward pilot_OnVehicleStreamIn(vehicleid, forplayerid);