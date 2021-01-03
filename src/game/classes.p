//
// classes.p
//

/**
    TODO:
        - Test system integrity when dynamically adding and deleting classes
        - Add macro to allow independent class selection views
 */

#if defined _classes_included
    #endinput
#endif

#if !defined MAX_CLASSES
    #define MAX_CLASSES         (100)
#endif

#if !defined MAX_CLASS_WEAPONS
    #define MAX_CLASS_WEAPONS   (5)
#endif

enum eClass {
    bool: eClass_Created,
    eClass_Skin,
    Float: eClass_X,
    Float: eClass_Y,
    Float: eClass_Z,
    Float: eClass_A,
    eClass_Interior,
    eClass_World,
    eClass_Team,
    eClass_Weapon[MAX_CLASS_WEAPONS],
    eClass_Ammo[MAX_CLASS_WEAPONS]
};

static gClassData[MAX_CLASSES][eClass];
static gLastPlayerClass[MAX_PLAYERS] = { -1, ... };
static gPlayerClassIter[MAX_PLAYERS] = { -1, ... };

stock AddClass(skin, Float: x, Float: y, Float: z, Float: a) {
    
    new slot = GetEmptySlot();
    if(slot != -1) {
        gClassData[slot][eClass_Created] = true;
        gClassData[slot][eClass_Skin] = skin;
        gClassData[slot][eClass_X] = x;
        gClassData[slot][eClass_Y] = y;
        gClassData[slot][eClass_Z] = z;
        gClassData[slot][eClass_A] = a;

        // specifically set class to NO_TEAM, to avoid potential overwrite
        gClassData[slot][eClass_Team] = NO_TEAM;
        return slot;
    }
    return -1;
}

stock SetClassInterior(id, interior) {
    if((0 <= id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        gClassData[id][eClass_Interior] = interior;
    }
}

stock GetClassInterior(id) {
    if((0 <= id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        return gClassData[id][eClass_Interior];
    }
    return -1;
}

stock SetClassWorld(id, world) {
    if((0 <= id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        gClassData[id][eClass_World] = world;
    }
}

stock GetClassWorld(id) {
    if((0 <= id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        return gClassData[id][eClass_World];
    }
    return -1;
}

stock SetClassTeam(id, team) {
    if((0 <= id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        gClassData[id][eClass_Team] = team;
    }
}

stock GetClassTeam(id) {
    if((0 <= id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        return gClassData[id][eClass_Team];
    }
    return NO_TEAM;
}

stock SetClassPosition(id, Float: x, Float: y, Float: z, Float: a) {
    if((0 <= id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        gClassData[id][eClass_X] = x;
        gClassData[id][eClass_Y] = y;
        gClassData[id][eClass_Z] = z;
        gClassData[id][eClass_A] = a;
    }
}

stock GetClassPosition(id, &Float: x, &Float: y, &Float: z, &Float: a) {
    if((0 <= id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        x = gClassData[id][eClass_X];
        y = gClassData[id][eClass_Y];
        z = gClassData[id][eClass_Z];
        a = gClassData[id][eClass_A];
        return 1;
    }
    return 0;
}

stock SetClassWeapon(id, weapon, ammo) {
    if((0 <= id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        for(new i = 0; i < MAX_CLASS_WEAPONS; i++) {
            if(gClassData[id][eClass_Weapon][i] == 0) {
                gClassData[id][eClass_Weapon][i] = weapon;
                gClassData[id][eClass_Ammo][i] = ammo;
                break;
            }
        }
    }
}

stock GetClassWeapons(id, weapon[MAX_CLASS_WEAPONS], ammo[MAX_CLASS_WEAPONS], count = MAX_CLASS_WEAPONS) {
    if((0 <= id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        if(count <= MAX_CLASS_WEAPONS) {
            for(new i = 0; i < count; i++) {
                weapon[i] = gClassData[id][eClass_Weapon][i];
                ammo[i] = gClassData[id][eClass_Ammo][i];
            }
        }
    }
}

stock GetPlayerClassID(playerid) {
    return gPlayerClassIter[playerid];
}

stock SetPlayerClassID(playerid, classid) {
    gPlayerClassIter[playerid] = classid;
}

stock DeleteClass(id) {
    if((0 <= id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        gClassData[id][eClass_Created] = false;
        gClassData[id][eClass_Skin] = 0;
        gClassData[id][eClass_X] = 0.0;
        gClassData[id][eClass_Y] = 0.0;
        gClassData[id][eClass_Z] = 0.0;
        gClassData[id][eClass_A] = 0.0;
        gClassData[id][eClass_Team] = NO_TEAM;
        gClassData[id][eClass_Interior] = 0;
        gClassData[id][eClass_World] = 0;

        for(new i = 0; i < MAX_CLASS_WEAPONS; i++) {
            gClassData[id][eClass_Weapon][i] = 0;
            gClassData[id][eClass_Ammo][i] = 0;
        }
    }
}

static stock GetEmptySlot() {
    for(new i = 0; i < MAX_CLASSES; i++) {
        if(gClassData[i][eClass_Created] == false) {
            return i;
        }
    }
    return -1;
}

static stock GetFirstClass() {
    for(new i = 0; i < MAX_CLASSES; i++) {
        if(gClassData[i][eClass_Created]) {
            return i;
        }
    }
    return -1;
}

static stock GetLastClass() {
    for(new i = MAX_CLASSES - 1; i >= 0; i--) {
        if(gClassData[i][eClass_Created]) {
            return i;
        }
    }
    return -1;
}

static stock GetNextClass(iter) {
    for(new i = iter + 1; i < MAX_CLASSES; i++) {
        if(gClassData[i][eClass_Created]) {
            return i;
        }
    }
    return GetFirstClass();
}

static stock GetPreviousClass(iter) {
    for(new i = iter - 1; i >= 0; i--) {
        if(gClassData[i][eClass_Created]) {
            return i;
        }
    }
    return GetLastClass();
}

static stock UpdateClassDisplay(playerid) {
    SetPlayerSkin(playerid, gClassData[gPlayerClassIter[playerid]][eClass_Skin]);
}

public OnGameModeInit() {
    AddPlayerClass(0, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(0, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 0, 0, 0);
    AddPlayerClass(0, 0.00, 0.00, 0.00, 0.00, 0, 0, 0, 0, 0, 0);
    return CallLocalFunction("class_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit class_OnGameModeInit
forward class_OnGameModeInit();

public OnPlayerRequestClass(playerid, classid) {

    enum { MOVE_NONE, MOVE_RIGHT, MOVE_LEFT };
    new move;
    // detect move; if any
    switch(gLastPlayerClass[playerid]) {
        case 0: {
            if(classid == 1) {
                move = MOVE_RIGHT;
            } else if(classid == 2) { 
                move = MOVE_LEFT;
            }
        }
        case 1: {
            if(classid == 2) {
                move = MOVE_RIGHT;
            } else if(classid == 0) {
                move = MOVE_LEFT;
            }
        }
        case 2: { 
            if(classid == 0) {
                move = MOVE_RIGHT;
            } else if(classid == 1) {
                move = MOVE_LEFT;
            }
        }
        case -1: {
            move = MOVE_NONE;
        }
    }

    switch(move) {
        case MOVE_RIGHT: gPlayerClassIter[playerid] = GetNextClass(gPlayerClassIter[playerid]);
        case MOVE_LEFT: gPlayerClassIter[playerid] = GetPreviousClass(gPlayerClassIter[playerid]);
        case MOVE_NONE: gPlayerClassIter[playerid] = GetFirstClass();
    }

    if(gPlayerClassIter[playerid] != -1) {
        UpdateClassDisplay(playerid);
    }

    gLastPlayerClass[playerid] = classid;
    return CallLocalFunction("class_OnPlayerRequestClass", "ii", playerid, classid);
}

#if defined _ALS_OnPlayerRequestClass
	#undef OnPlayerRequestClass
#else
	#define _ALS_OnPlayerRequestClass
#endif
#define OnPlayerRequestClass class_OnPlayerRequestClass
forward class_OnPlayerRequestClass(playerid, classid);

public OnPlayerSpawn(playerid) {

    if(gPlayerClassIter[playerid] != -1) {
        SetPlayerPos(playerid, 
            gClassData[gPlayerClassIter[playerid]][eClass_X],
            gClassData[gPlayerClassIter[playerid]][eClass_Y],
            gClassData[gPlayerClassIter[playerid]][eClass_Z]
        );
        SetPlayerFacingAngle(playerid, gClassData[gPlayerClassIter[playerid]][eClass_A]);
        SetPlayerInterior(playerid, gClassData[gPlayerClassIter[playerid]][eClass_Interior]);
        SetPlayerVirtualWorld(playerid, gClassData[gPlayerClassIter[playerid]][eClass_World]);
        SetPlayerTeam(playerid, gClassData[gPlayerClassIter[playerid]][eClass_Team]);

        for(new i = 0; i < MAX_CLASS_WEAPONS; i++) {
            GivePlayerWeapon(playerid, 
                gClassData[gPlayerClassIter[playerid]][eClass_Weapon][i],
                gClassData[gPlayerClassIter[playerid]][eClass_Ammo][i]
            );
        }
    }
    return CallLocalFunction("class_OnPlayerSpawn", "i", playerid);
}

#if defined _ALS_OnPlayerSpawn
	#undef OnPlayerSpawn
#else
	#define _ALS_OnPlayerSpawn
#endif
#define OnPlayerSpawn class_OnPlayerSpawn
forward class_OnPlayerSpawn(playerid);

public OnPlayerDisconnect(playerid, reason) {

    gPlayerClassIter[playerid] = -1;
    gLastPlayerClass[playerid] = -1;
    return CallLocalFunction("class_OnPlayerDisconnect", "ii", playerid, reason);
}

#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect class_OnPlayerDisconnect
forward class_OnPlayerDisconnect(playerid, reason);