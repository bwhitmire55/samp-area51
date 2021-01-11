//
// adm_cmds.p
//

#define WARNINGS_TO_KICK        (3)

// -- Level 1 Commands -- //

COMMAND:slap(playerid, params[]) {
    if(GetPlayerAdminLevel(playerid) < 1)
        return 0;

    new targetid;
    if(sscanf(params, "u", targetid))
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/slap <playerid/name>");

    new Float: x, Float: y, Float: z;
    GetPlayerPos(targetid, x, y, z);
    SetPlayerPos(targetid, x, y, z + 10);
    return 1;
}

COMMAND:kick(playerid, params[]) {
    if(GetPlayerAdminLevel(playerid) < 1)
        return 0;

    new targetid, reason[60];
    if(sscanf(params, "us[60]", targetid, reason))
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/kick <playerid/name> <reason>");
    
    DelayKick(targetid, ReturnPlayerName(playerid), reason);
    return 1;
}

COMMAND:warn(playerid, params[]) {
    if(GetPlayerAdminLevel(playerid) < 1)
        return 0;

    new targetid, reason[60];
    if(sscanf(params, "us[60]", targetid, reason))
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/warn <playerid/name> <reason>");
    
    SetPlayerWarnings(targetid, GetPlayerWarnings(targetid) + 1);
    new buffer[128];
    format(buffer, sizeof(buffer), "[ADMIN] %s has warned %s. Reason: %s. [%i/%i]",
        ReturnPlayerName(playerid),
        ReturnPlayerName(targetid),
        reason,
        GetPlayerWarnings(targetid),
        WARNINGS_TO_KICK
    );
    SendClientMessageToAll(0xFFFFFFFF, buffer);

    if(GetPlayerWarnings(targetid) == WARNINGS_TO_KICK) {
        DelayKick(targetid, "SYSTEM", "Maximum number of warnings exceeded.");
    }
    return 1;
}

// -- Level 2 Commands -- //

// -- Level 3 Commands -- //