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

forward OnModeInit();
forward OnModeExit();

LoadMode(modeid) {

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