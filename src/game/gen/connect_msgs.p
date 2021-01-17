//
// connect_msgs.p
//

public OnPlayerConnect(playerid) {
    new buffer[128];
    format(buffer, sizeof(buffer), "{FFFF00}[CONNECT] {FFFFFF}%s has joined the server", ReturnPlayerName(playerid));
    SendClientMessageToAll(0xFFFFFFFF, buffer);
    return CallLocalFunction("cmsgs_OnPlayerConnect", "i", playerid);
}

#if defined _ALS_OnPlayerConnect
    #undef OnPlayerConnect 
#else
    #define _ALS_OnPlayerConnect 
#endif 
#define OnPlayerConnect cmsgs_OnPlayerConnect
forward cmsgs_OnPlayerConnect(playerid);

public OnPlayerDisconnect(playerid, reason) {
    new buffer[128];
    format(buffer, sizeof(buffer), "{FFFF00}[DISCONNECT] {FFFFFF}%s has left the server ", ReturnPlayerName(playerid));

    switch(reason) {
        case 0: strcat(buffer, "[Timeout]");
        case 1: strcat(buffer, "[Quit]");
        case 2: strcat(buffer, "[Kicked]");
    }
    SendClientMessageToAll(0xFFFFFFFF, buffer);
    return CallLocalFunction("cmsgs_OnPlayerDisconnect", "ii", playerid, reason);
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect 
#else
    #define _ALS_OnPlayerDisconnect 
#endif 
#define OnPlayerDisconnect cmsgs_OnPlayerDisconnect
forward cmsgs_OnPlayerDisconnect(playerid, reason);