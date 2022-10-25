include("shared.lua")

surface.CreateFont( "myaddon_sb_32", {
	font = "Roboto", --  Use the font-name which is shown to you by your operating system Font Viewer, not the file name
	size = 32,
	weight = 500,
})

local function Draw3DText( pos, ang, scale, text, flipView )
	if ( flipView ) then
		-- Flip the angle 180 degrees around the UP axis
		ang:RotateAroundAxis( Vector( 0, 0, 1 ), 180 )
	end

	cam.Start3D2D( pos, ang, scale )
		-- Actually draw the text. Customize this to your liking.
		draw.DrawText( text, "myaddon_sb_32", 0, 0, Color( 0, 255, 0, 255 ), TEXT_ALIGN_CENTER )
	cam.End3D2D()
end

net.Receive("mass_update", function()
    local newMass = net.ReadFloat()
    MASS = newMass
end)

net.Receive("gravity_update", function()
    local newGravity = net.ReadFloat()
    GRAVITY = newGravity
end)

net.Receive("friction_update", function()
    local newFriction = net.ReadFloat()
    FRICTION = newFriction
end)

net.Receive("airdensity_update", function()
    local newAirDensity = net.ReadFloat()
    AIR_DENSITY = newAirDensity
end)

function ENT:Draw()
    self:DrawModel()

    -- The text to display
	local textVelocity = "Velocity: " .. tostring(math.floor(self:GetVelocity().x)) .. "x " .. tostring(math.floor(self:GetVelocity().y)) .. "y " .. tostring(math.floor(self:GetVelocity().z)) .. "z"
	local textFriction = "Friction: " .. tostring(FRICTION)
	local textGravity = "Gravity: " .. tostring(GRAVITY)
	local textMass = "Mass: " .. tostring(MASS)
	local textAirDensity = "Air Density: " .. tostring(AIR_DENSITY)

	-- The position. We use model bounds to make the text appear just above the model. Customize this to your liking.
	local mins, maxs = self:GetModelBounds()
	local pos = self:GetPos() + Vector( 0, 0, maxs.z + 20 )

	-- The angle
	local ang = Angle( 0, 0, 90 )
	ang.y = LocalPlayer():EyeAngles().y - 90

    -- Draw front
	Draw3DText( pos, ang, 0.2, textVelocity, false )
	-- DrawDraw3DTextback
	Draw3DText( pos, ang, 0.2, textVelocity, true )

	-- Draw front
	Draw3DText( pos + Vector(0, 0, 10), ang, 0.2, textFriction, false )
	-- DrawDraw3DTextback
	Draw3DText( pos + Vector(0, 0, 10), ang, 0.2, textFriction, true )

	-- Draw front
	Draw3DText( pos + Vector(0, 0, 20), ang, 0.2, textGravity, false )
	-- DrawDraw3DTextback
	Draw3DText( pos + Vector(0, 0, 20), ang, 0.2, textGravity, true )

	-- Draw front
	Draw3DText( pos + Vector(0, 0, 30), ang, 0.2, textMass, false )
	-- DrawDraw3DTextback
	Draw3DText( pos + Vector(0, 0, 30), ang, 0.2, textMass, true )

	-- Draw front
	Draw3DText( pos + Vector(0, 0, 40), ang, 0.2, textAirDensity, false )
	-- DrawDraw3DTextback
	Draw3DText( pos + Vector(0, 0, 40), ang, 0.2, textAirDensity, true )

	phys = self:GetPhysicsObject()
    if ( input.IsKeyDown == KEY_SPACE ) then
        phys:ApplyForceCenter( self:GetVelocity() + Vector( 0, 0, 1000 ) )
        print("jump")
    end
end