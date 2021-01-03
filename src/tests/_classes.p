//
// _classes.p
//
//      Test module (classes.p) 
//

#if !defined DEV_RUN_TESTS
    #endinput
#endif

public OnGameModeInit() {

    print("\n\n\n-------------------------------------------------");
    print("- Running tests for classes.p");
    print("--------------------------------");

    new i;

    new testClass = AddClass(5, 1.00, 2.00, 3.00, 4.00);

    // interior
    SetClassInterior(testClass, 1);
    printf("- Interior: %i | Expected: %i", GetClassInterior(testClass), 1);

    // world
    SetClassWorld(testClass, 5);
    printf("- World: %i | Expected: %i", GetClassWorld(testClass), 5);

    // team
    SetClassTeam(testClass, 3);
    printf("- Team: %i | Expected: %i", GetClassTeam(testClass), 3);

    // weapons
    i = 0;
    while(i < MAX_CLASS_WEAPONS) {
        SetClassWeapon(testClass, i+1, 500);
        i++;
    }

    new weapons[MAX_CLASS_WEAPONS], ammo[MAX_CLASS_WEAPONS];
    GetClassWeapons(testClass, weapons, ammo);
    
    i = 0;
    while(i < MAX_CLASS_WEAPONS) {
        printf("- [Weapon: %i] [Ammo: %i] | Expected: [Weapon: %i] [Ammo: %i]", weapons[i], ammo[i], i+1, 500);
        i++;
    }

    i = 0;
    while( i < MAX_CLASS_WEAPONS) {
        weapons[i] = 0;
        ammo[i] = 0;
        i++;
    }

    GetClassWeapons(testClass, weapons, ammo, 3);

    i = 0;
    while(i < MAX_CLASS_WEAPONS) {
        printf("- [Weapon: %i] [Ammo: %i] | Expected: [Weapon: %i] [Ammo: %i]", weapons[i], ammo[i], i >= 3 ? 0 : i+1, i >= 3 ? 0 : 500);
        i++;
    }

    // class limits
    for(i = 1; i < MAX_CLASSES; i++) {
        AddClass(1, 0.00, 1.00, 2.00, 3.00);
    }

    printf("- Class Overflow: %i | Expected: %i", AddClass(2, 0.00, 0.00, 0.00, 0.00), -1);

    // CLEANUP
    for(i = 0; i < MAX_CLASSES; i++) {
        DeleteClass(i);
    }

    print("--------------------------------");
    print("- Completed tests for classes.p");
    print("-------------------------------------------------\n\n\n");
    return CallLocalFunction("_class_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit _class_OnGameModeInit
forward _class_OnGameModeInit();