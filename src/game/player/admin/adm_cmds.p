//
// adm_cmds.p
//

#define WARNINGS_TO_KICK        (3)

// -- Level 1 Commands -- //

// Dumb spec & unspec; flush out to proper system later
COMMAND:spec(playerid, params[]) {
    if(GetPlayerAdminLevel(playerid) < 1) 
        return 0;

    new targetid;
    if(sscanf(params, "u", targetid)) 
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/spec <playerid/name>");

    TogglePlayerSpectating(playerid, true);
    
    if(GetPlayerVehicleID(targetid) != INVALID_VEHICLE_ID) {
        PlayerSpectateVehicle(playerid, GetPlayerVehicleID(targetid));
    } else {
        PlayerSpectatePlayer(playerid, targetid);
    }
    return 1;
}

COMMAND:unspec(playerid, params[]) {
    if(GetPlayerAdminLevel(playerid) < 1)
        return 0;

    TogglePlayerSpectating(playerid, false);
    return 1;
}

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

COMMAND:ban(playerid, params[]) {
    if(GetPlayerAdminLevel(playerid) < 2) 
        return 0;

    new targetid, reason[60];
    if(sscanf(params, "us[60]", targetid, reason))
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/ban <playerid/name> <reason>");
    
    DelayBan(targetid, ReturnPlayerName(playerid), reason);
    return 1;
}

COMMAND:goto(playerid, params[]) {
    if(GetPlayerAdminLevel(playerid) < 2) 
        return 0;

    new targetid;
    if(sscanf(params, "u", targetid)) 
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/goto <playerid/name>");

    new Float: x, Float: y, Float: z;
    GetPlayerPos(targetid, x, y, z);
    SetPlayerPos(playerid, x, y, z + 0.02);
    return 1;
}

COMMAND:get(playerid, params[]) {
    if(GetPlayerAdminLevel(playerid) < 2)
        return 0;
    
    new targetid;
    if(sscanf(params, "u", targetid)) 
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/get <playerid/name>");

    new Float: x, Float: y, Float: z;
    GetPlayerPos(playerid, x, y, z);
    GetXYInFrontOfPlayer(playerid, 2.0, x, y);
    SetPlayerPos(targetid, x, y, z);
    return 1;
}

// -- Level 3 Commands -- //

COMMAND:announce(playerid, params[]) {
    if(GetPlayerAdminLevel(playerid) < 3) 
        return 0;

    if(isnull(params)) 
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/(an)nounce <message>");

    new buffer[128];
    format(buffer, sizeof(buffer), "{FF00FF}[ADMIN ANNOUNCEMENT]: {FFFFFF}%s", params);
    SendClientMessageToAll(0xFFFFFFFF, buffer);
    return 1;
}
COMMAND:an(playerid, params[]) { return cmd_announce(playerid, params); }

COMMAND:makeadmin(playerid, params[]) {
    if(GetPlayerAdminLevel(playerid) < 3 && !IsPlayerAdmin(playerid))
        return 0;

    new targetid, level;
    if(sscanf(params, "ui", targetid, level)) 
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/makeadmin <playerid/name> <level>");

    new buffer[128];
    format(buffer, sizeof(buffer), "{FF00FF}[ADMIN ANNOUNCEMENT]: {FFFFFF}%s has made %s an administrator (level: %i)",
        ReturnPlayerName(playerid),
        ReturnPlayerName(targetid),
        level 
    );
    SendClientMessageToAll(0xFFFFFFFF, buffer);
    SetPlayerAdminLevel(targetid, level);
    return 1;
}