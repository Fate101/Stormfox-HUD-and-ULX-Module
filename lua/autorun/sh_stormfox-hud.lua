if SERVER then
    CreateConVar("StormFoxHudServerName","My Server Name",FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Sets the Server Name text under Clock")
    CreateConVar("StormFoxHudServerNameEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables Server Name text under Clock")
end

if CLIENT then
    CreateConVar("StormFoxHudServerName","My Server Name",FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Sets the Server Name text under Clock")
    CreateConVar("StormFoxHudServerNameEnabled",1,FCVAR_REPLICATED + FCVAR_SERVER_CAN_EXECUTE,"Enables/Disables Server Name text under Clock")
    surface.CreateFont( "StormFoxTime75" , { font = "Trebuchet24", size = 75, weight = 500 })
    surface.CreateFont( "StormFoxTime35" , { font = "Trebuchet24", size = 35, weight = 100 })

    local function ShowStormFoxHUD()
        local time = nil

        if StormFox2 then
        	time = StormFox2.Time.TimeToString(nil, StormFox2.Setting.GetCache("12h_display"))
        elseif StormFox then
    	time = StormFox.GetRealTime(nil, cookie.GetNumber("StormFox - ampm",0))
        end

        if time == nil then return end
        local x, y = draw.SimpleTextOutlined( time, "StormFoxTime75", 50, 40, color_white, 0, 0, .5, color_black )

        if GetConVar("StormFoxHudServerNameEnabled"):GetInt() == 1 then
            draw.SimpleTextOutlined( GetConVar("StormFoxHudServerName"):GetString() , "StormFoxTime35", 50 + 5, 50 + y/2 + 15, color_white, 0, 0, .5, color_black )
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