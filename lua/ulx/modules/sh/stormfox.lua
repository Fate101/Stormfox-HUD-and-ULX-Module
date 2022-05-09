local CATEGORY_NAME = "StormFox"

ulx.weather_names = {}
function StormFoxVersion()

	if StormFox2 and StormFox2.Weather then
		ulx.weather_names = 
		{
		    "Clear",
		    "Cloud",
			"Rain",
		    "Radioactive",
		    "Fog",
		    "Lava",
  		  	"Sandstorm",
    	}
	elseif StormFox then
		ulx.weather_names =
		{
			"clear",
			"cloudy",
			"fog",
			"lava",
			"radioactive",
			"rain",
			"sandstorm"
		}
	else return	end
end
StormFoxVersion()

function ulx.settime(calling_ply, time)
	time = string.Trim(time)
	local oldTime = time
	time = string.lower(time)

	if StormFox2 and StormFox2.Time then
		StormFox2.Time.Set(time)
	elseif StormFox then
		StormFox.SetTime(time)
	else
		calling_ply:ChatPrint("StormFox or StormFox 2 is missing!")
	end

	if StormFox2 or StormFox then
		ulx.fancyLogAdmin( calling_ply, "#A set time to #s", oldTime)
	end
end

function ulx.setweather(calling_ply,weather,percentage)
	if StormFox2 and StormFox2.Weather then
		wpercentage = percentage / 100
		StormFox2.Weather.Set(weather, wpercentage)
	elseif StormFox then
		wpercentage = percentage / 100
		StormFox.SetWeather(weather, wpercentage)
	else
		calling_ply:ChatPrint("StormFox or StormFox 2 is missing!")
	end

	if StormFox2 or StormFox then
		ulx.fancyLogAdmin( calling_ply, "#A set weather to #s", weather)
	end
end

function ulx.settemp(calling_ply,temp)
	if StormFox2 and StormFox2.Temperature then
		StormFox2.Temperature.Set(temp)
	elseif StormFox then
		-- Implement farenheight later. For the time being - Celsius baby.
		StormFox.SetTemperature(temp,false)
	else
		calling_ply:ChatPrint("StormFox or StormFox2 is missing!")
	end

	if StormFox2 or StormFox then
		ulx.fancyLogAdmin( calling_ply, "#A set temp to #s", temp)
	end
end

function ulx.setwind(calling_ply,WindSpeed)
	if StormFox2 and StormFox2.Wind then
		StormFox2.Wind.SetForce(WindSpeed)
	elseif StormFox then
		StormFox.SetNetworkData("Wind", WindSpeed)
	else
		calling_ply:ChatPrint("StormFox or StormFox 2 is missing!")
	end

	if StormFox2 or StormFox then
		ulx.fancyLogAdmin( calling_ply, "#A set wind speed to #s", WindSpeed)
	end
end

function ulx.currentweather(calling_ply)
	if StormFox2 and StormFox2.Weather then
		calling_ply:ChatPrint(StormFox2.Weather.GetCurrent().Name)
		calling_ply:ChatPrint(StormFox2.Weather.GetPercent())
		calling_ply:ChatPrint(StormFox2.Wind.GetForce())
	elseif StormFox then
		calling_ply:ChatPrint(StormFox.GetWeatherID())
		calling_ply:ChatPrint(StormFox.GetNetworkData("WeatherMagnitude"))
		calling_ply:ChatPrint(StormFox.GetNetworkData("Wind"))
		calling_ply:ChatPrint(StormFox.GetBeaufort())
		calling_ply:ChatPrint(StormFox.GetTemperature())
	else
		calling_ply:ChatPrint("StormFox or StormFox 2 is missing!")
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