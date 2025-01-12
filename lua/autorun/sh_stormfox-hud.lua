if SERVER then
    CreateConVar("StormFoxHudServerName","Your Server Name",FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Sets the Server Name text under Clock")
    CreateConVar("StormFoxHudServerNameEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables Server Name text under Clock")
    CreateConVar("StormFoxHudWeatherEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables Weather text under Clock")
    CreateConVar("StormFoxHudTempEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables Temp text under Clock")
    CreateConVar("StormFoxHudDarkRPBalEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables DarkRP Balance under Clock")
    CreateConVar("StormFoxHudDarkRPJobEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables DarkRP Job under Clock")
    CreateConVar("StormFoxHudDarkRPSalaryEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables DarkRP Salary under Clock")
end

if CLIENT then
    CreateConVar("StormFoxHudServerName","Your Server Name",FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Sets the Server Name text under Clock")
    CreateConVar("StormFoxHudServerNameEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables Server Name text under Clock")
    CreateConVar("StormFoxHudWeatherEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables Weather text under Clock")
    CreateConVar("StormFoxHudTempEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables Temp text under Clock")
    CreateConVar("StormFoxHudDarkRPBalEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables DarkRP Balance under Clock")
    CreateConVar("StormFoxHudDarkRPJobEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables DarkRP Job under Clock")
    CreateConVar("StormFoxHudDarkRPSalaryEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables DarkRP Salary under Clock")
    surface.CreateFont( "StormFoxTime75" , { font = "Trebuchet24", size = 75, weight = 500 })
    surface.CreateFont( "StormFoxTime40" , { font = "Trebuchet24", size = 40, weight = 100 })
    surface.CreateFont( "StormFoxTime40o" , { font = "Trebuchet24", size = 40, weight = 100, outline = true })

    local function ShowStormFoxHUD()
        local time = nil
        local info = ""

        if StormFox2 then
        	time = StormFox2.Time.TimeToString(nil, StormFox2.Setting.GetCache("12h_display"))
        elseif StormFox then
    	    time = StormFox.GetRealTime(nil, cookie.GetNumber("StormFox - ampm",0))
        end

        if time == nil then return end
        local x, y = draw.SimpleTextOutlined( time, "StormFoxTime75", 50, 40, color_white, 0, 0, 1, color_black )

        if GetConVar("StormFoxHudServerNameEnabled"):GetInt() == 1 then
            info = info .. GetConVar("StormFoxHudServerName"):GetString() .. "\n"
        end       
		
        if GetConVar("StormFoxHudWeatherEnabled"):GetInt() == 1 then
            if StormFox2 then
                info = info .. "Weather: " .. StormFox2.Weather.GetDescription() .. "\n"
            elseif StormFox then
                info = info .. "Weather: " .. StormFox.GetWeather() .. "\n"
            end
        end

        if GetConVar("StormFoxHudTempEnabled"):GetInt() == 1 then
            if StormFox2 then
                info = info .. "Temp: " .. math.Round(StormFox2.Temperature.Get()) .. "°C \n"
            elseif StormFox then
                info = info .. "Temp: " .. math.Round(StormFox.GetTemperature()) .. "°C \n"
            end
        end
        
        -- DarkRP specific info
        if engine.ActiveGamemode() == "darkrp" then
            if GetConVar("StormFoxHudDarkRPJobEnabled"):GetInt() == 1 then
                if DarkRP then
                    local jobvalue = LocalPlayer():getDarkRPVar("job")
                    if jobvalue then
                        info = info .. "Job: " .. jobvalue .. "\n"
                    end
                end
            end

            if GetConVar("StormFoxHudDarkRPSalaryEnabled"):GetInt() == 1 then
                if DarkRP then
                    local salaryvalue = DarkRP.formatMoney(LocalPlayer():getDarkRPVar("salary"))
                    if salaryvalue then
                        info = info .. "Salary: " .. salaryvalue .. "\n"
                    end
                end
            end

            if GetConVar("StormFoxHudDarkRPBalEnabled"):GetInt() == 1 then
                if DarkRP then
                    local walletvalue = DarkRP.formatMoney(LocalPlayer():getDarkRPVar("money"))
                    if walletvalue then
                        info = info .. "Balance: " .. walletvalue .. "\n"
                    end
                end
            end
        end
        
        if info == "" then
            return 
        else
            draw.DrawText( info , "StormFoxTime40o", 50 + 5, 50 + y/2 + 15, color_white, TEXT_ALIGN_LEFT )
        end

    end
    hook.Add("HUDPaint","EnableStormFoxHUDPaint",ShowStormFoxHUD) 

    //When key is being used
    hook.Add( "KeyPress", "OpenedScoreboard", function( ply, key )
        if ( key == IN_SCORE ) then
            hook.Remove("HUDPaint","EnableStormFoxHUDPaint")
        end
    end )
    
    // When key is released
    hook.Add( "KeyRelease", "ReleaseScoreboard", function( ply, key )
        if ( key == IN_SCORE ) then
            hook.Add("HUDPaint","EnableStormFoxHUDPaint",ShowStormFoxHUD) 
        end
    end )
end