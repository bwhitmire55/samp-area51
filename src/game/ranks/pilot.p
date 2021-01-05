//
// pilot.p
//

#define VEHICLE_HYDRA           (520)
#define VEHICLE_SEA_SPARROW     (447)

public OnVehicleStreamIn(vehicleid, forplayerid) {
    new model = GetVehicleModel(vehicleid);
    if(model == VEHICLE_HYDRA || model == VEHICLE_SEA_SPARROW) {
        if(GetPlayerRank(forplayerid) < eRank_Level_4) {
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