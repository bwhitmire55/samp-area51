//
// break-out.p
//

/**
    TO-DO:
        -> Add gate with gate-breaching code
        -> Add barriers to block the entrance through the vents
        -> Display messages for break-ins, and a totals counter
 */

#define BREAK_OUT_GOAL  (1)

#define TEAM_DEFENSE    (1)
#define TEAM_ATTACK     (2)

#define CP_NONE         (0)
#define CP_BREACH       (1)
#define CP_FINAL        (2)

static gClass_Army;
static gClass_FBI;
static gClass_Scientist;
static gClass_Thug;
static gClass_Pyro;
static gClass_Sniper;

static gPlayerCPStatus[MAX_PLAYERS];

static gBreakOutCounter;

public OnModeInit() <CURRENT_MODE:BREAK_OUT> {
    gClass_Army = AddClass(287, 213.693, 1902.717, 17.640, 5.548); // ARMY
    SetClassWeapon(gClass_Army, WEAPON_M4, 300);
    SetClassWeapon(gClass_Army, WEAPON_MP5, 200);
    SetClassWeapon(gClass_Army, WEAPON_GRENADE, 5);
    SetClassTeam(gClass_Army, TEAM_DEFENSE);

    gClass_FBI = AddClass(286, 214.584,1822.596,6.414,271.861); // FBI
    SetClassWeapon(gClass_FBI, WEAPON_MP5, 300);
    SetClassWeapon(gClass_FBI, WEAPON_DEAGLE, 60);
    SetClassWeapon(gClass_FBI, WEAPON_NITESTICK, 1);
    SetClassTeam(gClass_FBI, TEAM_DEFENSE);

    gClass_Scientist = AddClass(70, 351.283,2537.139,16.733,214.739); // SCIENTIST
    SetClassWeapon(gClass_Scientist, WEAPON_DEAGLE, 60);
    SetClassWeapon(gClass_Scientist, WEAPON_ROCKETLAUNCHER, 5);
    SetClassWeapon(gClass_Scientist, WEAPON_KNIFE, 1);
    SetClassTeam(gClass_Scientist, TEAM_DEFENSE);

    gClass_Thug = AddClass(121, 268.603,1883.703,-30.093,0.145); // THUG
    SetClassWeapon(gClass_Thug, WEAPON_AK47, 300);
    SetClassWeapon(gClass_Thug, WEAPON_DEAGLE, 60);
    SetClassWeapon(gClass_Thug, WEAPON_BAT, 1);
    SetClassTeam(gClass_Thug, TEAM_ATTACK);

    gClass_Pyro = AddClass(206, 268.603,1883.703,-30.093,0.145); // PYRO
    SetClassWeapon(gClass_Pyro, WEAPON_M4, 300);
    SetClassWeapon(gClass_Pyro, WEAPON_SHOTGSPA, 70);
    SetClassWeapon(gClass_Pyro, WEAPON_FLAMETHROWER, 50);
    SetClassTeam(gClass_Pyro, TEAM_ATTACK);

    gClass_Sniper = AddClass(122, 268.603,1883.703,-30.093,0.145); // SNIPER
    SetClassInterior(gClass_Sniper, 9);
    SetClassWeapon(gClass_Sniper, WEAPON_SNIPER, 100);
    SetClassWeapon(gClass_Sniper, WEAPON_SILENCED, 100);
    SetClassWeapon(gClass_Sniper, WEAPON_KNIFE, 1);
    SetClassTeam(gClass_Sniper, TEAM_ATTACK);

    // initialize timer
    SetModeTime(10);
    return 1;
}

public OnModeExit() <CURRENT_MODE:BREAK_OUT> {
    DeleteClass(gClass_Army);
    DeleteClass(gClass_FBI);
    DeleteClass(gClass_Scientist);
    DeleteClass(gClass_Thug);
    DeleteClass(gClass_Pyro);
    DeleteClass(gClass_Sniper);

    gBreakOutCounter = 0;
    return 1;
}

public OnModeTimeExpire() <CURRENT_MODE:BREAK_OUT> {
    EndMode();
    return 1;
}

public OnPlayerRequestClass(playerid, classid) <CURRENT_MODE:BREAK_OUT> {
    SetPlayerPos(playerid, 0.00, 0.00, 2.00);
    SetPlayerFacingAngle(playerid, 180.0);
    SetPlayerCameraPos(playerid, 0.00, 5.00, 2.00);
    SetPlayerCameraLookAt(playerid, 0.00, 0.00, 2.00);
    return 1;
}

public OnPlayerSpawn(playerid) <CURRENT_MODE:BREAK_OUT> {
    new class = GetPlayerClassID(playerid);
    if(class == gClass_Thug) {
        SetPlayerCheckpoint(playerid, 246.703,1859.488,14.084, 5.0);
        gPlayerCPStatus[playerid] = CP_BREACH;
    } else if(class == gClass_Pyro || class == gClass_Sniper) {
        SetPlayerCheckpoint(playerid, -378.041,2220.522,42.093, 5.0);
        gPlayerCPStatus[playerid] = CP_FINAL;
    } else {
        gPlayerCPStatus[playerid] = CP_NONE;
    }

    if(GetClassTeam(class) == TEAM_ATTACK) {
        SetPlayerColor(playerid, 0xFF0000FF);
    } else if(GetClassTeam(class) == TEAM_DEFENSE) {
        SetPlayerColor(playerid, 0x00FF00FF);
    }
    return 1;
}

public OnPlayerEnterCheckpoint(playerid) <CURRENT_MODE:BREAK_OUT> {
    switch(gPlayerCPStatus[playerid]) {
        case CP_BREACH: {
            // -- Breach gate here -- //
            SetPlayerCheckpoint(playerid, -378.041,2220.522,42.093, 5.0);
            gPlayerCPStatus[playerid] = CP_FINAL;
        }
        case CP_FINAL: {
            DisablePlayerCheckpoint(playerid);
            gPlayerCPStatus[playerid] = CP_NONE;

            gBreakOutCounter++;
            if(gBreakOutCounter == BREAK_OUT_GOAL) {
                EndMode();
            }
        }
    }
    return 1;
}

// undef mode script symbols
#undef BREAK_OUT_GOAL

#undef TEAM_DEFENSE 
#undef TEAM_ATTACK 

#undef CP_NONE 
#undef CP_BREACH 
#undef CP_FINAL