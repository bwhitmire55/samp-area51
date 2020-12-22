# Adding Game Modes

## Updating the mode module [src/game/mode.p]

The mode module contains some generic data about the modes that are available to the server. This includes the name of the mode, a definition representing the mode with a unique ID, and a state to set the server's script in. While the state is an implementation detail and you do not have to know how it works to add a mode, it's worth looking into state automata in the Pawn language documentation (pawn-lang.pdf).

Let's work top-to-bottom in the file to add our mode. First, add a definition representing our gamemode with a unique ID. For consistency sake, make the ID that of the previous mode incremented by one.

```
#define MODE_INTERMISSION       (0)
#define MODE_BREAK_IN           (1)
#define MODE_BREAK_OUT          (2)
#define MODE_MY_MODE            (3) // add this line
```

Next, add the mode name to the gModeList array. Make sure to place a comma at the end of the previous mode index, and exclude a comma from the mode you are adding to the array.

```
static const gModeList[] = {
    "Intermission",
    "Break-In",
    "Break-Out",
    "My-Mode" // like so
};
```

Now, we need to look at the LoadMode function. Inside you see a switch statement which follows through cases for the mode symbols defined above. We will need to add a case for our new mode. Use the symbol name as the identifier, and for consistency sake, place it before the "default" case.

```
switch(modeid) {
        case MODE_INTERMISSION: // Intermission
            state CURRENT_MODE:INTERMISSION;
        case MODE_BREAK_IN: // Break-In
            state CURRENT_MODE:BREAK_IN;
        case MODE_BREAK_OUT: // Break-Out
            state CURRENT_MODE:BREAK_OUT;
        case MODE_MY_MODE: // My mode
        default: // Default to intermission
            state CURRENT_MODE:INTERMISSION;
    }
```
The following line we need to add a custom state for the script to interpret. Following the previous examples, use the symbol name we defined above, excluding the "MODE_" part.

```
switch(modeid) {
        case MODE_INTERMISSION: // Intermission
            state CURRENT_MODE:INTERMISSION;
        case MODE_BREAK_IN: // Break-In
            state CURRENT_MODE:BREAK_IN;
        case MODE_BREAK_OUT: // Break-Out
            state CURRENT_MODE:BREAK_OUT;
        case MODE_MY_MODE: // My mode
            state CURRENT_MODE:MY_MODE; // like so
        default: // Default to intermission
            state CURRENT_MODE:INTERMISSION;
    }
```

If you save and compile at this point you will get some errors. But no worries, let's fix those up.

## Adding a game mode script

We will now create the script file for our custom mode. This should be created in the src/game/modes directory.

## Things to note

-> All constant-symbols should be defined with #define, and undefined at the bottom of the file
-> All non-constant variables should be declared static, so they do not pollute the global namespace
-> Each callback needs to declared for the correct state <CURRENT_MODE:MY_MODE>
-> Each callback used in other game mode scripts needs to be defined in your script; and vice-versa. Anytime a new callback is used in a mode file, that callback must be added to all mode files

## Adding the game mode to rotation

...