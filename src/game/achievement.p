//
// achievement.p
//

#if !defined ACHIEVEMENT_DATABASE
    #define ACHIEVEMENT_DATABASE            "server.db"
#endif 

#if !defined ACHIEVEMENT_CONST_TABLE
    #define ACHIEVEMENT_CONST_TABLE         "ach_const"
#endif 

#if !defined ACHIEVEMENT_RECORD_TABLE 
    #define ACHIEVEMENT_RECORD_TABLE        "ach_record"
#endif

static DB:gDBHandle;

public OnGameModeInit() {
    gDBHandle = db_open(ACHIEVEMENT_DATABASE);

    if(!gDBHandle) {
        print("[Error - achievement.p] Cannot connect to database "ACHIEVEMENT_DATABASE".");
    } else {
        CreateDatabaseTables();
    }
    return CallLocalFunction("ach_OnGameModeInit", "", "");
}

#if defined _ALS_OnGameModeInit
    #undef OnGameModeInit 
#else 
    #define _ALS_OnGameModeInit
#endif
#define OnGameModeInit ach_OnGameModeInit
forward ach_OnGameModeInit();

public OnGameModeExit() {
    if(gDBHandle) {
        db_close(gDBHandle);
    }
    return CallLocalFunction("ach_OnGameModeExit", "", "");
}

#if defined _ALS_OnGameModeExit
    #undef OnGameModeExit
#else 
    #define _ALS_OnGameModeExit
#endif
#define OnGameModeExit ach_OnGameModeExit
forward ach_OnGameModeExit();

stock RegisterAchievement(const ach_name[], const ach_desc[]) {

    new query[128];
    format(query, sizeof(query), "INSERT OR IGNORE INTO `"ACHIEVEMENT_CONST_TABLE"` (name, desc) VALUES ('%s', '%s')",
        ach_name, ach_desc 
    );
    if(gDBHandle) {
        db_query(gDBHandle, query);
    }   
}

stock AwardPlayerAchievement(playerid, const ach_name[]) {

    new 
        DBResult: result, 
        query[128];

    format(query, sizeof(query), "SELECT id FROM `"ACHIEVEMENT_CONST_TABLE"` WHERE name = '%s' LIMIT 1", ach_name);
    result = db_query(gDBHandle, query);
    if(result) {
        if(db_num_rows(result)) {
            new id = db_get_field_int(result);
            new pid = GetPlayerUID(playerid);

            format(query, sizeof(query), "INSERT OR IGNORE INTO `"ACHIEVEMENT_RECORD_TABLE"` (pid, ach_id) VALUES(%i, %i)", pid, id);
            db_query(gDBHandle, query);
        }
        db_free_result(result);
    }
}

static CreateDatabaseTables() {
    db_query(gDBHandle, "CREATE TABLE IF NOT EXISTS `"ACHIEVEMENT_CONST_TABLE"` ( \
        id INTEGER PRIMARY KEY AUTOINCREMENT, \
        name TEXT, \
        desc TEXT, \
        UNIQUE(name, desc) \
    );");

    db_query(gDBHandle, "CREATE TABLE IF NOT EXISTS `"ACHIEVEMENT_RECORD_TABLE"` ( \
        pid INTEGER, \
        ach_id INTEGER, \
        UNIQUE(pid, ach_id) \
    );");
}