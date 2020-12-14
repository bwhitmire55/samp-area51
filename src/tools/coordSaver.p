//
// coordSaver.p
//

#if !defined DEV_ENVIRONMENT
    #endinput
#endif

#include <zcmd>

#define COORD_SAVER_FILE        "savedpositions.txt"

COMMAND:savepos(playerid, params[]) {

    new Float: x, Float: y, Float: z, Float: a;
    new File: hFile = fopen(COORD_SAVER_FILE, io_append);
    new buffer[256];

    if(hFile) {
        if(IsPlayerInAnyVehicle(playerid)) {
            GetVehiclePos(GetPlayerVehicleID(playerid), x, y, z);
            GetVehicleZAngle(GetPlayerVehicleID(playerid), a);
            format(buffer, sizeof(buffer), "CreateVehicle(%i,%0.3f,%0.3f,%0.3f,%0.3f,-1,-1); %s",
                GetVehicleModel(GetPlayerVehicleID(playerid)),
                x, y, z, a, params
            );
        } else {
            GetPlayerPos(playerid, x, y, z);
            GetPlayerFacingAngle(playerid, a);
            format(buffer, sizeof(buffer), "AddPlayerClass(%i,%0.3f,%0.3f,%0.3f,%0.3f,0,0,0,0,0,0); %s",
                GetPlayerSkin(playerid), x, y, z, a, params
            );
        }
        strcat(buffer, "\r\n");
        fwrite(hFile, buffer);
        fclose(hFile);
    }
    return 1;
}