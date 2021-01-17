//
// team_chat.p
//

public OnPlayerText(playerid, text[]) {
    new team = GetPlayerTeam(playerid);
    new buffer[128];
    format(buffer, sizeof(buffer), "{%x}%s: %s", GetPlayerColor(playerid), ReturnPlayerName(playerid), text);
    for(new i = 0; i < MAX_PLAYERS; i++) {
        if(team == GetPlayerTeam(i)) {
            SendClientMessage(i, 0xFFFFFFFF, buffer);
        }
    }
    return CallLocalFunction("tchat_OnPlayerText", "is", playerid, text);
}

#if defined _ALS_OnPlayerText
    #undef OnPlayerText 
#else
    #define _ALS_OnPlayerText 
#endif 
#define OnPlayerText tchat_OnPlayerText
forward tchat_OnPlayerText(playerid, text[]);