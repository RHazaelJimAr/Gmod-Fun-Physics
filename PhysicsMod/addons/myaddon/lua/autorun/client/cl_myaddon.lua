include("autorun/sh_myaddon.lua")

net.Receive("displaymessage_update", function()
    local newMessage = net.ReadString()
    MYADDON_DISPLAYMESSAGE = newMessage
end)

local function ToggleScoreboard(toggle)
    if toggle then
        local scrw, scrh = ScrW(), ScrH()
        MyAddonScoreboard = vgui.Create("DImage", frame)
        MyAddonScoreboard:SetSize(scrw * .3, scrh * .6)
        MyAddonScoreboard:Center()
        MyAddonScoreboard:MakePopup()
        MyAddonScoreboard:SetImage("backgrounds/Formulas.png")
    else
        if IsValid(MyAddonScoreboard) then
            MyAddonScoreboard:Remove()
        end
    end
end

hook.Add("ScoreboardShow", "MyAddonOpenScoreBoard", function()
    ToggleScoreboard(true)
    net.Start("scoreboard_opened")
    net.SendToServer()
    return false
end)

hook.Add("ScoreboardHide", "MyAddonHideScoreBoard", function()
    ToggleScoreboard(false)
end)

local dist = 4000^2

hook.Add("HUDPaint", "WaypointExample", function()
    for k,v in pairs(player.GetAll()) do
        if v == LocalPlayer() then continue end
        local pos = v:GetPos()
        if LocalPlayer():GetPos():DistToSqr(pos) < dist then
            pos = pos:ToScreen()
            surface.SetDrawColor(0,0,0,200)
            surface.DrawRect(pos.x - 32, pos.y - 32, 64, 64)
            draw.SimpleText(v:Name(), "myaddon_sb_14", pos.x, pos.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end
end)