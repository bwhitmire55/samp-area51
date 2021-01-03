//
// mode.p
//

#define MODE_INTERMISSION       (0)
#define MODE_BREAK_IN           (1)
#define MODE_BREAK_OUT          (2)

static const gModeList[][] = {
    "Intermission",
    "Break-In",
    "Break-Out"
};

static gCurrentMode;    // Does not update for intermission mode

forward OnModeInit();
forward OnModeExit();

LoadMode(modeid) {

    if(modeid != MODE_INTERMISSION)
        gCurrentMode = modeid;

    new buffer[40];
    format(buffer, sizeof(buffer), "gamemodetext %s", gModeList[modeid]);
    SendRconCommand(buffer);

    switch(modeid) {
        case MODE_INTERMISSION: // Intermission
            state CURRENT_MODE:INTERMISSION;
        case MODE_BREAK_IN: // Break-In
            state CURRENT_MODE:BREAK_IN;
        case MODE_BREAK_OUT: // Break-Out
            state CURRENT_MODE:BREAK_OUT;
        default: // Default to intermission
            state CURRENT_MODE:INTERMISSION;
    }

    CallLocalFunction("OnModeInit", "", "");
}

EndMode(bool: isIntermission = false) {
    CallLocalFunction("OnModeExit", "", "");

    // delay load mode so the caller of this function can properly return
    if(!isIntermission)
        SetTimerEx("DelayLoadMode", 100, false, "i", MODE_INTERMISSION);
    else {
        gCurrentMode++;
        if(gCurrentMode == sizeof(gModeList)) {
            gCurrentMode = MODE_BREAK_IN;
        }
        SetTimerEx("DelayLoadMode", 100, false, "i", gCurrentMode);
    }
}

forward DelayLoadMode(modeid);
public DelayLoadMode(modeid) {
    LoadMode(modeid);

    // handle players
    for(new i = 0; i < MAX_PLAYERS; i++) {
        if(IsPlayerConnected(i)) {
            // Reset script data
            SetPlayerClassID(i, -1);

            // Reset game data
            SetPlayerColor(i, 0x707070FF);
            DisablePlayerCheckpoint(i);

            // Respawn
            TogglePlayerSpectating(i, true);
            PlayerSpectatePlayer(i, INVALID_PLAYER_ID);
            ForceClassSelection(i);
            TogglePlayerSpectating(i, false);
        }
    }
    return 1;
}