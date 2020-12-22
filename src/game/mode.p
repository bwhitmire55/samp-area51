//
// mode.p
//

#define MODE_INTERMISSION       (0)
#define MODE_BREAK_IN           (1)
#define MODE_BREAK_OUT          (2)

static const gModeList[] = {
    "Intermission",
    "Break-In",
    "Break-Out"
};

forward OnModeLoaded();

LoadMode(modeid) {

    new buffer[40];
    format(buffer, sizeof(buffer), "gamemodetext %s", gModeList[modeid]);
    SendRconCommand(buffer);

    switch(modeid) {
        case 0: // Intermission
            state CURRENT_MODE:INTERMISSION;
        case 1: // Break-In
            state CURRENT_MODE:BREAK_IN;
        case 2: // Break-Out
            state CURRENT_MODE:BREAK_OUT;
        default: // Default to intermission
            state CURRENT_MODE:INTERMISSION;
    }

    CallLocalFunction("OnModeLoaded", "", "");
}