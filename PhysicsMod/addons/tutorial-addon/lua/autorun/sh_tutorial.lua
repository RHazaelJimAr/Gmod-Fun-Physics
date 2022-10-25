--
print("sh_tutorial file loaded")
TUTORIALSHOP = TUTORIALSHOP or {}
TUTORIALSHOP.Theme = {
    ["background"] = Color(0,0,0,200),
    ["purchasebutton"] = Color(0,200,0,255),
    ["text"] = Color(255,255,255),
}
TUTORIALSHOP.Items = {
    {
        name = "SKS",
        classname = "fas2_sks",
        price = 450,
        description = "This is a trusty SKS.",
    },
    {
        name = "M24",
        classname = "fas2_m24",
        price = 20000,
        description = "This is a trusty M24.",
    },
    {
        name = "Glock 20",
        classname = "fas2_glock20",
        price = 500,
        description = "This is a trusty Glock 20.",
    },
}
--GLOBAL TABLE FULL OF "ITEMS"
--NETWORKING BETWEEN CLIENT AND SERVER
--PANELS AND VGUI
--LOOPS AND CONDITIONS