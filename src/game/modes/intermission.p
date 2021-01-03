//
// intermission.p
//

#define INTERMISSION_DURATION       (15)

static gClass;

public OnModeInit() <CURRENT_MODE:INTERMISSION> {

    gClass = AddClass(0, 0.00, 0.00, 0.00, 0.00);

    new buffer[70];
    format(buffer, sizeof(buffer), "~y~Next mode beginning in %i seconds...", INTERMISSION_DURATION);
    GameTextForAll(buffer, 5000, 5);

    SetTimer("intEndMode", INTERMISSION_DURATION*1000, false);
    return 1;
}

public OnModeExit() <CURRENT_MODE:INTERMISSION> {
    DeleteClass(gClass);
    return 1;
}

public OnModeTimeExpire() <CURRENT_MODE:INTERMISSION> {
    return 1;
}

public OnPlayerRequestClass(playerid, classid) <CURRENT_MODE:INTERMISSION> {
    return 1;
}

public OnPlayerSpawn(playerid) <CURRENT_MODE:INTERMISSION> {
    return 1;
}

public OnPlayerEnterCheckpoint(playerid) <CURRENT_MODE:INTERMISSION> {
    return 1;
}

forward intEndMode();
public intEndMode() {
    EndMode(true);
    return 1;
}