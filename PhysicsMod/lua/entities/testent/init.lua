AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("mass_update")
util.AddNetworkString("gravity_update")
util.AddNetworkString("friction_update")
util.AddNetworkString("airdensity_update")

function ENT:Initialize()
    self:SetModel("models/props_interiors/BathTub01a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetFriction(0.2)
    physenv.SetGravity(Vector(0,0,-514.9606299213))

    local phys = self:GetPhysicsObject()

    if (phys:IsValid()) then
        phys:Wake()
        MASS = phys:GetMass()
        net.Start("mass_update")
        net.WriteFloat(MASS)
        net.Broadcast()

        GRAVITY = 0.01905 * -physenv.GetGravity().z
        net.Start("gravity_update")
        net.WriteFloat(GRAVITY)
        net.Broadcast()

        FRICTION = self:GetFriction()
        net.Start("friction_update")
        net.WriteFloat(FRICTION)
        net.Broadcast()

        AIR_DENSITY = physenv.GetAirDensity()
        net.Start("airdensity_update")
        net.WriteFloat(AIR_DENSITY)
        net.Broadcast()
    end
end

function ENT:Think()
    local phys = self:GetPhysicsObject()
    if IsValid(phys) then
        MASS = phys:GetMass()
        GRAVITY = 0.01905 * -physenv.GetGravity().z
        FRICTION = self:GetFriction()
        AIR_DENSITY = physenv.GetAirDensity()
    end
    net.Start("mass_update")
    net.WriteFloat(MASS)
    net.Broadcast()
    net.Start("gravity_update")
    net.WriteFloat(GRAVITY)
    net.Broadcast()
    net.Start("airdensity_update")
    net.WriteFloat(AIR_DENSITY)
    net.Broadcast()
end