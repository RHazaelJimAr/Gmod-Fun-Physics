print("cl_tutorial file loaded")

surface.CreateFont("tutorialshop_24", {
    font = "Roboto",
    extended = false,
    size = 24,
    weight = 500,
})

surface.CreateFont("tutorialshop_18", {
    font = "Roboto",
    extended = false,
    size = 18,
    weight = 500,
})

function TUTORIALSHOP.Open()
    local scrw, scrh = ScrW(), ScrH()
    TUTORIALSHOP.Menu = vgui.Create("DFrame")
    TUTORIALSHOP.Menu:SetSize(scrw * .35, scrh * .8)
    TUTORIALSHOP.Menu:Center()
    TUTORIALSHOP.Menu:SetTitle("")
    TUTORIALSHOP.Menu:MakePopup()
    TUTORIALSHOP.Menu.Paint = function(me,w,h)
        surface.SetDrawColor(TUTORIALSHOP.Theme["background"])
        surface.DrawRect(0,0,w,h)
        draw.SimpleText("SHOP", "tutorialshop_24", w / 2, h * .02, TUTORIALSHOP.Theme["text"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    local scroll = vgui.Create( "DScrollPanel", TUTORIALSHOP.Menu )
    scroll:Dock( FILL )

    local frameH = TUTORIALSHOP.Menu:GetTall()
    local frameW = TUTORIALSHOP.Menu:GetWide()
    local yspace = frameH * .01
    for k,itemData in pairs(TUTORIALSHOP.Items) do
        local itemPanel = vgui.Create("DPanel", scroll)
        itemPanel:DockMargin(0, 0, 0, yspace)
        itemPanel:Dock(TOP)
        itemPanel:SetTall(frameH * .1)
        itemPanel.Paint = function(me,w,h)
            surface.SetDrawColor(TUTORIALSHOP.Theme["background"])
            surface.DrawRect(0,0,w,h)
            draw.SimpleText(itemData.name, "tutorialshop_18", w * .02, h * .15, TUTORIALSHOP.Theme["text"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText(itemData.description, "tutorialshop_18", w * .02, h * .35, TUTORIALSHOP.Theme["text"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText("$" .. itemData.price, "tutorialshop_18", w * .02, h * .55, TUTORIALSHOP.Theme["text"], TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        local marginSpace = frameW * .03
        local purchaseButton = vgui.Create("DButton", itemPanel)
        purchaseButton:Dock(RIGHT)
        purchaseButton:SetWide(frameW * .2)
        purchaseButton:DockMargin(0, marginSpace, marginSpace, marginSpace)
        purchaseButton:SetText("")
        purchaseButton.Paint = function(me,w,h)
            surface.SetDrawColor(TUTORIALSHOP.Theme["purchasebutton"])
            surface.DrawRect(0,0,w,h)
            draw.SimpleText("PURCHASE", "tutorialshop_18", w / 2, h / 2, TUTORIALSHOP.Theme["text"], TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        purchaseButton.DoClick = function()
            net.Start("tutorialshop_purchase")
            net.WriteInt(k, 32)
            net.SendToServer()
        end
    end
end

concommand.Add("tutorial_shop", function()
    TUTORIALSHOP.Open()
end)