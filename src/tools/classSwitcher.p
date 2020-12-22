//
// classSwitcher.p
//

#if !defined DEV_ENVIRONMENT
    #endinput
#endif

#include <zcmd>

COMMAND:class(playerid, params[]) {
    ForceClassSelection(playerid);
    SendClientMessage(playerid, 0x00FF00FF, "Class selection forced.");
    return 1;
}