//
// weather.p
//

static const WeatherIDs[] = {
    8,  // thunderstorm
    9,  // cloudy & foggy
    19, // sandstorm
    16  // cloudy & rainy
};

public OnModeInit() {
    SetWeather(WeatherIDs[random(sizeof(WeatherIDs))]);
    return CallLocalFunction("weather_OnModeInit", "", "");
}

#if defined _ALS_OnModeInit
    #undef OnModeInit
#else 
    #define _ALS_OnModeInit
#endif
#define OnModeInit weather_OnModeInit
forward weather_OnModeInit(playerid);