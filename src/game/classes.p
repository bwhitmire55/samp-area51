//
// classes.p
//

/**
    TODO:
        Implement the game mechanics behind class selection
        > Create temporary classes to interact with the game
        > Update the skin of the temporary classes for the player when they request a 
            different class
        > Set the rest of the data (position, interior, world, etc) after the player spawns
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
    eClass_Weapon[MAX_CLASS_WEAPONS],
    eClass_Ammo[MAX_CLASS_WEAPONS]
};

static gClassData[MAX_CLASSES][eClass];

stock AddClass(skin, Float: x, Float: y, Float: z, Float: a) {
    
    new slot = GetEmptySlot();
    if(slot != -1) {
        gClassData[slot][eClass_Created] = true;
        gClassData[slot][eClass_Skin] = skin;
        gClassData[slot][eClass_X] = x;
        gClassData[slot][eClass_Y] = y;
        gClassData[slot][eClass_Z] = z;
        gClassData[slot][eClass_A] = a;
        return slot;
    }
    return -1;
}

stock SetClassInterior(id, interior) {
    if((0 < id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        gClassData[id][eClass_Interior] = interior;
    }
}

stock SetClassWorld(id, world) {
    if((0 < id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        gClassData[id][eClass_World] = world;
    }
}

stock SetClassPosition(id, Float: x, Float: y, Float: z, Float: a) {
    if((0 < id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        gClassData[id][eClass_X] = x;
        gClassData[id][eClass_Y] = y;
        gClassData[id][eClass_Z] = z;
        gClassData[id][eClass_A] = a;
    }
}

stock SetClassWeapon(id, weapon, ammo) {
    if((0 < id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        for(new i = 0; i < MAX_CLASS_WEAPONS; i++) {
            if(gClassData[id][eClass_Weapon][i] == 0) {
                gClassData[id][eClass_Weapon][i] = weapon;
                gClassData[id][eClass_Ammo][i] = ammo;
            }
        }
    }
}

stock DestroyClass(id) {
    if((0 < id < MAX_CLASSES) && gClassData[id][eClass_Created] == true) {
        gClassData[id][eClass_Created] = false;
        gClassData[id][eClass_Skin] = 0;
        gClassData[id][eClass_X] = 0.0;
        gClassData[id][eClass_Y] = 0.0;
        gClassData[id][eClass_Z] = 0.0;
        gClassData[id][eClass_A] = 0.0;
        gClassData[id][eClass_Interior] = 0;
        gClassData[id][eClass_World] = 0;

        for(new i = 0; i < MAX_CLASS_WEAPONS; i++) {
            gClassData[i][eClass_Weapon][i] = 0;
            gClassData[i][eClass_Ammo][i] = 0;
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