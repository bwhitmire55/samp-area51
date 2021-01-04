//
// acc_cmds.p
//

COMMAND:register(playerid, params[]) {
    if(IsPlayerLoggedIn(playerid)) 
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Error: {FFFFFF}Already logged-in.");
    
    if(isnull(params))
        return SendClientMessage(playerid, 0xFFFFFFFF, "{FF0000}Usage: {FFFFFF}/register <password>");

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
    }
    return 1;
}