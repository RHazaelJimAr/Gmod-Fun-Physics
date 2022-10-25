util.AddNetworkString("tutorialshop_purchase")

net.Receive("tutorialshop_purchase", function(len, ply)
    local id = net.ReadInt(32)
    local itemData = TUTORIALSHOP.Items[id]
    if not itemData then return end

    ply:ChatPrint("Attempting to purchase " .. itemData.name)
end)