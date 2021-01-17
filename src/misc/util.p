//
// util.p
//

ReturnPlayerName(playerid) {
    new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

GetXYInFrontOfPlayer(playerid, Float: distance, &Float: x, &Float: y) {
    new Float: a;
    GetPlayerPos(playerid, x, y, a);
    GetPlayerFacingAngle(playerid, a);
    x += distance * floatsin(-a, degrees);
    y += distance * floatcos(-a, degrees);
}

DelayKick(playerid, const kicker[], const reason[]) {
    new buffer[128];
    format(buffer, sizeof(buffer), "{FFFF00}[KICK] {FFFFFF}%s has been kicked by %s. Reason: %s", 
        ReturnPlayerName(playerid),
        kicker, reason
    );
    SendClientMessageToAll(0xFFFFFFFF, buffer);
    SetTimerEx("DelayKickC", 500, false, "i", playerid);
}

DelayBan(playerid, const kicker[], const reason[]) {
    new buffer[128];
    format(buffer, sizeof(buffer), "{FFFF00}[BAN] {FFFFFF}%s has been banned by %s. Reason: %s", 
        ReturnPlayerName(playerid),
        kicker, reason
    );
    SendClientMessageToAll(0xFFFFFFFF, buffer);
    SetTimerEx("DelayBanC", 500, false, "i", playerid);
}

forward DelayKickC(playerid);
public DelayKickC(playerid) {
    Kick(playerid);
    return 1;
}

forward DelayBanC(playerid);
public DelayBanC(playerid) {
    Ban(playerid);
    return 1;
}