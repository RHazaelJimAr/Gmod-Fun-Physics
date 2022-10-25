

CreateClientConVar( "cl_showhints", "1", true, false )

-- A list of hints we've already done so we don't repeat ourselves`
local ProcessedHints = {}

--
-- Throw's a Hint to the screen
--
local function ThrowHint( name )

	local show = GetConVarNumber( "cl_showhints" )
	if ( show == 0 ) then return end

	if ( engine.IsPlayingDemo() ) then return end

	local text = language.GetPhrase( "Hint_" .. name )

	local s, e, group = string.find( text, "%%([^%%]+)%%" )
	while ( s ) do
		local key = input.LookupBinding( group )
		if ( !key ) then key = "<NOT BOUND>" end

		text = string.gsub( text, "%%([^%%]+)%%", "'" .. key:upper() .. "'" )
		s, e, group = string.find( text, "%%([^%%]+)%%" )
	end

	GAMEMODE:AddNotify( text, NOTIFY_HINT, 20 )

	surface.PlaySound( "ambient/water/drip" .. math.random( 1, 4 ) .. ".wav" )

end


--
-- Adds a hint to the queue
--
function GM:AddHint( name, delay )

	if ( ProcessedHints[ name ] ) then return end

	timer.Create( "HintSystem_" .. name, delay, 1, function() ThrowHint( name ) end )
	ProcessedHints[ name ] = true

end

--
-- Removes a hint from the queue
--
function GM:SuppressHint( name )

	timer.Remove( "HintSystem_" .. name )

end

-- Show opening menu hint if they haven't opened the menu within 30 seconds
-- GM:AddHint( "OpeningMenu", 30 )

-- Tell them how to turn the hints off after 1 minute
GM:AddHint( "Annoy1", 5 )
GM:AddHint( "Annoy2", 10 )
GM:AddHint( "Annoy3", 15 )
GM:AddHint( "Annoy4", 20 )
GM:AddHint( "Annoy5", 25 )
GM:AddHint( "Annoy6", 30 )

GM:AddHint("FirstLaw", 60)
GM:AddHint("SecondLaw", 65)
GM:AddHint("ThirdLaw", 70)

GM:AddHint("Vacuum", 100)
GM:AddHint("Vacuum2", 105)
GM:AddHint("Vacuum3", 110)
GM:AddHint("Vacuum4", 125)
GM:AddHint("Vacuum5", 130)
GM:AddHint("Vacuum6", 135)

GM:AddHint("Mass", 165)
GM:AddHint("Mass2", 170)
GM:AddHint("Mass3", 175)
GM:AddHint("Mass4", 180)
GM:AddHint("Mass5", 185)
GM:AddHint("Mass6", 190)
GM:AddHint("Mass7", 195)
GM:AddHint("Mass8", 200)
GM:AddHint("Mass9", 205)
GM:AddHint("Mass10", 210)
GM:AddHint("Mass11", 215)

GM:AddHint("Friction", 245)
GM:AddHint("Friction2", 250)
GM:AddHint("Friction3", 255)

GM:AddHint("Reaction", 285)
GM:AddHint("Reaction2", 290)
GM:AddHint("Reaction3", 295)
GM:AddHint("Reaction4", 300)
GM:AddHint("Reaction5", 305)

GM:AddHint("Tips", 345)
GM:AddHint("Vectors", 350)
GM:AddHint("Vectors2", 365)
GM:AddHint("Vectors3", 370)
GM:AddHint("Vectors4", 375)
GM:AddHint("Vectors5", 380)
GM:AddHint("Vectors6", 385)
GM:AddHint("Vectors7", 390)
GM:AddHint("Vectors8", 395)

GM:AddHint("Gravity", 425)
GM:AddHint("Gravity2", 430)
GM:AddHint("Normal", 435)
GM:AddHint("Normal2", 440)
GM:AddHint("Normal3", 445)

GM:AddHint("Weight", 475)
GM:AddHint("Weight2", 480)
GM:AddHint("Weight3", 485)
GM:AddHint("Weight4", 490)

GM:AddHint("Formula", 520)
GM:AddHint("Formula2", 535)
GM:AddHint("Formula3", 540)
GM:AddHint("Formula4", 570)
GM:AddHint("Formula5", 585)
GM:AddHint("Formula6", 590)
GM:AddHint("Formula7", 595)
GM:AddHint("Formula8", 600)

GM:AddHint("Goodbye", 630)
GM:AddHint("Goodbye2", 635)
GM:AddHint("Goodbye3", 640)
GM:AddHint("Goodbye4", 645)
GM:AddHint("Goodbye5", 650)
GM:AddHint("Goodbye6", 655)
GM:AddHint("Goodbye7", 660)
GM:AddHint("Goodbye8", 665)
GM:AddHint("Goodbye9", 670)
