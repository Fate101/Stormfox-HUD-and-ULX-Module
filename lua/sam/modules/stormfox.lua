local sam = sam
local command = sam.command
local language = sam.language

command.new("settime")
	:SetPermission("settime", "admin")
	:SetCategory("StormFox")
	:AddArg("text", {hint = "Time", optional = false})
	:Help("Sets the specified time for StormFox")
	:GetRestArgs(true)
	:OnExecute(function(ply, time)
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
			sam.player.send_message(nil, "{A} set time to {T}", { A = ply, T = oldTime })
		end
	end)
:End()
