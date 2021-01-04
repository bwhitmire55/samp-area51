//
// acc_cmds.p
//

#define MIN_PASSWORD_LEN            (3)
#define MAX_PASSWORD_LEN            (20)

#define MAX_INVALID_LOGIN_ATTEMPTS  (3)

static gPlayerLoginAttempts[MAX_PLAYERS];

COMMAND:register(playerid, params[]) {
    if(IsPlayerLoggedIn(playerid)) 
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Error: {FFFFFF}Already logged-in.");
    
    if(isnull(params))
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/register <password>");

    if(strlen(params) < MIN_PASSWORD_LEN || strlen(params) > MAX_PASSWORD_LEN) {
        new buffer[128];
        format(buffer, sizeof(buffer), "{FF0000}Error: {FFFFFF}Password length must be between %i and %i characters long.", MIN_PASSWORD_LEN, MAX_PASSWORD_LEN);
        SendClientMessage(playerid, 0xFFFFFFFF, buffer);
        return 1;
    }

    if(RegisterPlayer(playerid, params)) {
        SendClientMessage(playerid, 0xFFFFFFFF, "{00FF00}Success: {FFFFFF}You have successfully registered an account.");
    } else {
        SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Error: {FFFFFF}Username already exists.");
    }
    return 1;
}

COMMAND:login(playerid, params[]) {
    if(IsPlayerLoggedIn(playerid)) 
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Error: {FFFFFF}Already logged-in.");

    if(isnull(params))
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/login <password>");

    if(LoginPlayer(playerid, params)) {
        SendClientMessage(playerid, 0xFFFFFFFF, "{00FF00}Success: {FFFFFF}You have successfully logged-in.");
    } else {
        SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Error: {FFFFFF}Something went wrong...");
        
        gPlayerLoginAttempts[playerid]++;
        if(gPlayerLoginAttempts[playerid] == MAX_INVALID_LOGIN_ATTEMPTS) {
            SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Error: {FFFFFF}Maximum number of login attempts exceeded.");
            DelayKick(playerid, "A51-BOT", "Maximum number of login attempts exceeded");
        }
    }
    return 1;
}

public OnPlayerDisconnect(playerid, reason) {
    gPlayerLoginAttempts[playerid] = 0;
    return CallLocalFunction("acc_cmds_OnPlayerDisconnect", "ii", playerid, reason);
}

#if defined _ALS_OnPlayerDisconnect
    #undef OnPlayerDisconnect 
#else
    #define _ALS_OnPlayerDisconnect 
#endif 
#define OnPlayerDisconnect acc_cmds_OnPlayerDisconnect
forward acc_cmds_OnPlayerDisconnect(playerid, reason);