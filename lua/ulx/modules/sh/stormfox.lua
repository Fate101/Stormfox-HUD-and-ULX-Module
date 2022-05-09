function ulx.settime( calling_ply, time)
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

local settime = ulx.command( "StormFox", "ulx settime", ulx.settime, "!settime" )
settime:addParam{ type = ULib.cmds.StringArg, hint = "Time"}
settime:defaultAccess( ULib.ACCESS_ADMIN )
settime:help("Sets the specified time for StormFox")
