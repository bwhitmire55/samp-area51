//
// break-in.p
//

static const TEAM_DEFENSE = 1;
static const TEAM_ATTACK = 2;

static gClass_Army;
static gClass_FBI;
static gClass_Scientist;
static gClass_Thug;
static gClass_Pyro;
static gClass_Sniper;

static gParachutePickups[2];

public OnModeInit() <CURRENT_MODE:BREAK_IN> {
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

    gClass_Thug = AddClass(121, -379.358,2201.278,42.356,247.009); // THUG
    SetClassWeapon(gClass_Thug, WEAPON_AK47, 300);
    SetClassWeapon(gClass_Thug, WEAPON_DEAGLE, 60);
    SetClassWeapon(gClass_Thug, WEAPON_BAT, 1);
    SetClassTeam(gClass_Thug, TEAM_ATTACK);

    gClass_Pyro = AddClass(206, -366.686,2202.583,42.484,191.235); // PYRO
    SetClassWeapon(gClass_Pyro, WEAPON_M4, 300);
    SetClassWeapon(gClass_Pyro, WEAPON_SHOTGSPA, 70);
    SetClassWeapon(gClass_Pyro, WEAPON_FLAMETHROWER, 50);
    SetClassTeam(gClass_Pyro, TEAM_ATTACK);

    gClass_Sniper = AddClass(122, 315.713,973.972,1961.442,357.029); // SNIPER
    SetClassInterior(gClass_Sniper, 9);
    SetClassWeapon(gClass_Sniper, WEAPON_SNIPER, 100);
    SetClassWeapon(gClass_Sniper, WEAPON_SILENCED, 100);
    SetClassWeapon(gClass_Sniper, WEAPON_KNIFE, 1);
    SetClassTeam(gClass_Sniper, TEAM_ATTACK);

    // world pickups
    gParachutePickups[0] = CreatePickup(1310, 3, 319.408,1020.835,1950.642, -1);
    gParachutePickups[1] = CreatePickup(1310, 3, 312.365,1020.340,1950.756, -1);
    return 1;
}

public OnModeExit() <CURRENT_MODE:BREAK_IN> {

    DeleteClass(gClass_Army);
    DeleteClass(gClass_FBI);
    DeleteClass(gClass_Scientist);
    DeleteClass(gClass_Thug);
    DeleteClass(gClass_Pyro);
    DeleteClass(gClass_Sniper);

    DestroyPickup(gParachutePickups[0]);
    DestroyPickup(gParachutePickups[1]);
    return 1;
}

public OnPlayerRequestClass(playerid, classid) <CURRENT_MODE:BREAK_IN> {
    SetPlayerPos(playerid, 0.00, 0.00, 2.00);
    SetPlayerFacingAngle(playerid, 180.0);
    SetPlayerCameraPos(playerid, 0.00, 5.00, 2.00);
    SetPlayerCameraLookAt(playerid, 0.00, 0.00, 2.00);
    return 1;
}