include("autorun/sh_myaddon.lua")

util.AddNetworkString("displaymessage_update")
util.AddNetworkString("scoreboard_opened")

-- hook.Add("PlayerSay", "MyAddonChatCommands", function(sender, text, teamChat)
--     if text == "!crowbar" then
--         sender:Give("weapon_crowbar")
--         sender:ChatPrint("You received a crowbar")
--     end
-- end)

local function SetDisplayMessage(text)
    MYADDON_DISPLAYMESSAGE = text
    net.Start("displaymessage_update")
    net.WriteString(MYADDON_DISPLAYMESSAGE)
    net.Broadcast()
end

hook.Add("PlayerSpawn", "PlayerSpawnNotify", function(ply)
    --Called when the player spawns in
    SetDisplayMessage(ply:Name() .. " just spawned in!")
end)

hook.Add("PlayerDisconnected", "PlayerDisconnectNotify", function(ply)
    --Called when the player disconnects
    SetDisplayMessage(ply:Name() .. " has disconnected.")
end)

hook.Add("PlayerInitialSpawn", "PlayerInitialSpawnNotify", function(ply)
    net.Start("displaymessage_update")
    net.WriteString(MYADDON_DISPLAYMESSAGE)
    net.Send(ply)
end)

net.Receive("scoreboard_opened", function(len, ply)
    SetDisplayMessage(ply:Name() .. " has opened the Scoreboard!")
end)