//
// modetimer.p
//

static gTimeLeft;
static gModeTimer;
static Text: gTimerTextdraw;

SetModeTime(time) { // in minutes
    gTimeLeft = time*60;
    gModeTimer = SetTimer("UpdateTimer", 1000, true);
}

forward UpdateTimer();
public UpdateTimer() {
    gTimeLeft--;

    new buffer[30];
    format(buffer, sizeof(buffer), "~r~Time Left: ~w~%2d:%02d", gTimeLeft / 60, gTimeLeft % 60);
    TextDrawSetString(gTimerTextdraw, buffer);

    if(gTimeLeft == 0) {
        KillTimer(gModeTimer);
        CallLocalFunction("OnModeTimeExpire", "", "");
    }
}

public OnGameModeInit() {
    gTimerTextdraw = TextDrawCreate(629.000000, 425.000000, " ");
    TextDrawFont(gTimerTextdraw, 1);
    TextDrawLetterSize(gTimerTextdraw, 0.437500, 1.500000);
    TextDrawTextSize(gTimerTextdraw, 360.500000, 2.500000);
    TextDrawSetOutline(gTimerTextdraw, 1);
    TextDrawSetShadow(gTimerTextdraw, 0);
    TextDrawAlignment(gTimerTextdraw, 3);
    TextDrawColor(gTimerTextdraw, -1);
    TextDrawBackgroundColor(gTimerTextdraw, 255);
    TextDrawBoxColor(gTimerTextdraw, 50);
    TextDrawUseBox(gTimerTextdraw, 0);
    TextDrawSetProportional(gTimerTextdraw, 1);
    TextDrawSetSelectable(gTimerTextdraw, 0);
    return CallLocalFunction("modet_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit modet_OnGameModeInit
forward modet_OnGameModeInit();

public OnPlayerSpawn(playerid) {

    TextDrawShowForPlayer(playerid, gTimerTextdraw);
    return CallLocalFunction("modet_OnPlayerSpawn", "i", playerid);
}

#if defined _ALS_OnPlayerSpawn 
    #undef OnPlayerSpawn 
#else 
    #define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn modet_OnPlayerSpawn
forward modet_OnPlayerSpawn(playerid);

forward OnModeTimeExpire();