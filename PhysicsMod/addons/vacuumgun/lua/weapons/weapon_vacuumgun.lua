SWEP.PrintName = "Vacuum Gun" -- This will be shown in the spawn menu, and in the weapon selection menu
SWEP.Author = "Randy" -- These two options will be shown when you have the weapon highlighted in the weapon selection menu
SWEP.Instructions = "Left mouse to remove gravity, friction, and air resistance, right click to restore it"

SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"

SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 1
SWEP.SlotPos = 2
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = true

SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"

SWEP.ShootSound = Sound("Metal.SawbladeStick")

-- Called when the left mouse button is pressed
function SWEP:PrimaryAttack()
    -- This weapon is 'automatic'. This function call below defines
    -- the rate of fire. Here we set it to shoot every 0.5 seconds.
    self:SetNextPrimaryFire(CurTime() + 0.1)

    -- Call 'ThrowChair' on self with this model
    self:ToggleVacuum(true)
end

-- Called when the rightmouse button is pressed
function SWEP:SecondaryAttack()
    -- Though the secondary fire isn't automatic
    -- players shouldn't be able to fire too fast
    self:SetNextSecondaryFire(CurTime() + 0.1)

    self:ToggleVacuum(false)
end

-- A custom function we added. When you call this the player will fire off a chair!
function SWEP:ToggleVacuum(isToggle)
    local owner = self:GetOwner()

    -- Make sure the weapon is being held before trying to throw a chair
    if (not owner:IsValid()) then return end

    -- If we're the client then this is as much as we want to do.
    -- We play the sound above on the client due to prediction.
    -- (If we didn't they would feel a ping delay during multiplayer)
    if (CLIENT) then return end

    if isToggle then
        physenv.SetGravity(Vector(0,0,0))
        physenv.SetAirDensity(0.00001)
        print(physenv.GetAirDensity())
        for k, v in ipairs(ents.FindByClass("testent")) do
            if v and v:IsValid() then
                v:SetFriction(0.00001)
                print(v:GetFriction())
            end
        end
    else
        physenv.SetGravity(Vector(0,0,-514.9606299213))
        physenv.SetAirDensity(2)
        for k, v in ipairs(ents.FindByClass("testent")) do
            if v and v:IsValid() then
                v:SetFriction(0.2)
            end
        end
    end
end