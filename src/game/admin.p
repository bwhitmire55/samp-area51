//
// admin.p
//

static gPlayerAdminLevel[MAX_PLAYERS];

SetPlayerAdminLevel(playerid, level) {
    gPlayerAdminLevel[playerid] = level;   
}

GetPlayerAdminLevel(playerid) {
    return gPlayerAdminLevel[playerid];
}

static SendAdminMessage(const message[]) {
    for(new i = 0; i < MAX_PLAYERS; i++) {
        if(gPlayerAdminLevel[i] > 0) {
            SendClientMessage(i, 0xFFFFFFFF, message);
        }
    }
}

public OnGameModeInit() {
    AddAccountData("admin", TYPE_INT, gPlayerAdminLevel);
    return CallLocalFunction("admin_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit
#else 
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit admin_OnGameModeInit
forward admin_OnGameModeInit();

public OnPlayerDisconnect(playerid, reason) {
    gPlayerAdminLevel[playerid] = 0;
    return CallLocalFunction("admin_OnPlayerDisconnect", "ii", playerid, reason); 
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect 
#else
    #define _ALS_OnPlayerDisconnect 
#endif 
#define OnPlayerDisconnect admin_OnPlayerDisconnect
forward admin_OnPlayerDisconnect(playerid, reason);

public OnPlayerText(playerid, text[]) {
    if(strlen(text) && text[0] == '@') {
        new buffer[128];
        if(GetPlayerAdminLevel(playerid) > 0) {
            format(buffer, sizeof(buffer), "{80080}[ADMIN] {FFFFFF}%s: %s", ReturnPlayerName(playerid), text[1]);
            SendAdminMessage(buffer);
        } else {
            format(buffer, sizeof(buffer), "{%x}%s: {FFFFFF}%s",
                GetPlayerColor(playerid),
                ReturnPlayerName(playerid),
                text[1]
            );
            SendClientMessageToAll(0xFFFFFFFF, buffer);
        }
        return 0;
    }
    return CallLocalFunction("admin_OnPlayerText", "is", playerid, text);
}

#if defined _ALS_OnPlayerText
    #undef OnPlayerText 
#else
    #define _ALS_OnPlayerText
#endif 
#define OnPlayerText admin_OnPlayerText
forward admin_OnPlayerText(playerid, text[]);