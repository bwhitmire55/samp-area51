//
// break-out.p
//

public OnModeInit() <CURRENT_MODE:BREAK_OUT> {

    // initialize timer
    SetModeTime(10);
    return 1;
}

public OnModeExit() <CURRENT_MODE:BREAK_OUT> {
    return 1;
}

public OnModeTimeExpire() <CURRENT_MODE:BREAK_OUT> {
    EndMode();
    return 1;
}

public OnPlayerRequestClass(playerid, classid) <CURRENT_MODE:BREAK_OUT> {
    return 1;
}

public OnPlayerSpawn(playerid) <CURRENT_MODE:BREAK_OUT> {
    return 1;
}

public OnPlayerEnterCheckpoint(playerid) <CURRENT_MODE:BREAK_OUT> {
    return 1;
}