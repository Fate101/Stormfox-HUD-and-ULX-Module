local CATEGORY_NAME = "StormFox"

-- Helper functions
local function isStormFox2() return StormFox2 and StormFox2.Weather end
local function isStormFox1() return StormFox and not StormFox2 end
local function checkStormFox(ply)
    if not (isStormFox2() or isStormFox1()) then
        ply:ChatPrint("Error: StormFox or StormFox 2 is not installed!")
        return false
    end
    return true
end

-- Initialize weather names based on version
ulx.weather_names = {}
function StormFoxVersion()
    if isStormFox2() then
        ulx.weather_names = {
            "Clear", "Cloud", "Rain", "Radioactive",
            "Fog", "Lava", "Sandstorm"
        }
    elseif isStormFox1() then
        ulx.weather_names = {
            "clear", "cloudy", "fog", "lava",
            "radioactive", "rain", "sandstorm"
        }
    end
end
StormFoxVersion()

function ulx.settime(calling_ply, time)
    if not checkStormFox(calling_ply) then return end
    
    time = string.Trim(time)
    local oldTime = time
    time = string.lower(time)

    if isStormFox2() then
        StormFox2.Time.Set(time)
    else
        StormFox.SetTime(time)
    end
    
    ulx.fancyLogAdmin(calling_ply, "#A set time to #s", oldTime)
end

function ulx.setweather(calling_ply, weather, percentage)
    if not checkStormFox(calling_ply) then return end
    
    local wpercentage = math.Clamp(percentage / 100, 0, 1)
    
    if isStormFox2() then
        StormFox2.Weather.Set(weather, wpercentage)
    else
        StormFox.SetWeather(weather, wpercentage)
    end
    
    ulx.fancyLogAdmin(calling_ply, "#A set weather to #s at #i%", weather, percentage)
end

function ulx.settemp(calling_ply, temp)
    if not checkStormFox(calling_ply) then return end
    
    if isStormFox2() then
        StormFox2.Temperature.Set(temp)
    else
        StormFox.SetTemperature(temp, false)
    end
    
    ulx.fancyLogAdmin(calling_ply, "#A set temperature to #i°C", temp)
end

function ulx.setwind(calling_ply, WindSpeed)
    if not checkStormFox(calling_ply) then return end
    
    if isStormFox2() then
        StormFox2.Wind.SetForce(WindSpeed)
    else
        StormFox.SetNetworkData("Wind", WindSpeed)
    end
    
    ulx.fancyLogAdmin(calling_ply, "#A set wind speed to #i", WindSpeed)
end

function ulx.currentweather(calling_ply)
    if not checkStormFox(calling_ply) then return end
    
    if isStormFox2() then
        calling_ply:ChatPrint("Weather: " .. StormFox2.Weather.GetCurrent().Name)
        calling_ply:ChatPrint("Intensity: " .. math.Round(StormFox2.Weather.GetPercent() * 100) .. "%")
        calling_ply:ChatPrint("Wind Speed: " .. StormFox2.Wind.GetForce())
    else
        calling_ply:ChatPrint("Weather: " .. StormFox.GetWeatherID())
        calling_ply:ChatPrint("Intensity: " .. math.Round(StormFox.GetNetworkData("WeatherMagnitude") * 100) .. "%")
        calling_ply:ChatPrint("Wind Speed: " .. StormFox.GetNetworkData("Wind"))
        calling_ply:ChatPrint("Beaufort Scale: " .. StormFox.GetBeaufort())
        calling_ply:ChatPrint("Temperature: " .. StormFox.GetTemperature() .. "°C")
    end
end

local setweather = ulx.command("StormFox", "ulx setweather", ulx.setweather, "!setweather")
setweather:addParam{ type=ULib.cmds.StringArg, completes=ulx.weather_names, hint="weather", error="Invalid weather specified", ULib.cmds.restrictToCompletes}
setweather:addParam{ type=ULib.cmds.NumArg, hint="Weather Percentage", min=0, max=100, default=30 }
setweather:defaultAccess( ULib.ACCESS_ADMIN )
setweather:help("Change the current weather")

local settime = ulx.command( "StormFox", "ulx settime", ulx.settime, "!settime" )
settime:addParam{ type = ULib.cmds.StringArg, hint = "time"}
settime:defaultAccess( ULib.ACCESS_ADMIN )
settime:help("Sets the specified time for StormFox")

local settemp = ulx.command("StormFox", "ulx settemp", ulx.settemp, "!settemp")
settemp:addParam{ type = ULib.cmds.NumArg, hint = "temp"}
settemp:defaultAccess( ULib.ACCESS_ADMIN )
settemp:help("Sets the specified Temp for StormFox in Celsius")

local setwindspeed = ulx.command("StormFox", "ulx setwindspeed", ulx.setwind, "!setwindspeed")
setwindspeed:addParam{ type = ULib.cmds.NumArg, hint = "Wind Speed", min=0, max=70, default=7 }
setwindspeed:defaultAccess( ULib.ACCESS_ADMIN )
setwindspeed:help("Sets the wind speed for StormFox")

local getcurrentweather = ulx.command("StormFox", "ulx getcurrentweather", ulx.currentweather, "!currentweather")
getcurrentweather:defaultAccess( ULib.ACCESS_ADMIN )
getcurrentweather:help("Prints current weather details")