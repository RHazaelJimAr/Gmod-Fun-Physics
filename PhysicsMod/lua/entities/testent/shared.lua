ENT.Type = "anim"
ENT.Base = "base_gmodentity"

ENT.PrintName = "Physics Bathtub"

ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Int", 1, "TestInt")
end

MASS = 0
GRAVITY = 0
FRICTION = 0
AIR_DENSITY = 0