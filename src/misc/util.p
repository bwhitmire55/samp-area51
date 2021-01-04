//
// util.p
//

ReturnPlayerName(playerid) {
    new name[MAX_PLAYER_NAME + 1];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
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

forward DelayKickC(playerid);
public DelayKickC(playerid) {
    Kick(playerid);
    return 1;
}