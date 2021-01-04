//
// gen_cmds.pwn
//

COMMAND:kill(playerid, params[]) {
    SetPlayerHealth(playerid, 0.0);
    return 1;
}

COMMAND:class(playerid, params[]) {
    ForceClassSelection(playerid);
    SetPlayerHealth(playerid, 0.0);
    return 1;
}

COMMAND:pm(playerid, params[]) {
    new targetid, message[90], buffer[128];
    if(sscanf(params, "us[90]", targetid, message)) {
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/pm <playerid/name> <message>");
    }
    format(buffer, sizeof(buffer), "{FFFF00}[PM]%s: {FFFFFF}%s", ReturnPlayerName(playerid), message);
    SendClientMessage(targetid, 0xFFFFFFFF, buffer);
    return 1;
}

COMMAND:all(playerid, params[]) {
    new buffer[128];
    if(isnull(params)) {
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/a(ll) <message>");
    } else {
        format(buffer, sizeof(buffer), "{707070}[ALL]%s: {FFFFFF}%s", ReturnPlayerName(playerid), params);
        SendClientMessageToAll(0xFFFFFFFF, buffer);
    }
    return 1;
}
COMMAND:a(playerid, params[]) { return cmd_all(playerid, params); }