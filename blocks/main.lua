-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local physics = require("physics")
physics.start()

local set_round = function( event )

local phase = event.phase

  if "began" == phase then
  x = event.xStart   -- store x location of object
  y = event.yStart   -- store y location of object
  --round = display.newImageRect( "circle.png", 70, 70)
  --round.x = x
  --round.y = y
  round = display.newCircle( x, y, 35 )
  physics.addBody( round, "static", { friction=0.5, bounce=0.3, radius=35 } ) 
 end
 return true
end

--display.setStatusBar( display.HiddenStatusBar )

local grass = display.newImage("grass.png")  
grass.x = 160; grass.y = 478

local sky = display.newImage( "bkg_clouds.png" )
sky.x = display.contentWidth / 2
sky.y = 200


physics.addBody( grass, "static", { friction=0.5, bounce=0.3 } )
fraction_table = {}

function new_block()	
	
	color = {
		{201, 160, 220},
		{18, 10, 143},
		{208, 240, 192},
		{0, 255, 255},
		{0, 0, 255},
		{3, 192, 60},
		{255, 218, 185},
		{128, 128, 128},
		{253, 233, 16},
		{152, 255, 152},
		{175, 238, 238},
		{192, 192, 192}
	}

	colorRand = math.random(12)
	xRand= math.random(0,320)

	
	block = display.newRect( xRand, -10, 10, 10 ) 

	local color_trans = function( obj )
		color_change = math.random(12)
    	obj:setFillColor( color[color_change][1], color[color_change][2], color[color_change][3] ) 
	end
	block:setFillColor( color[colorRand][1], color[colorRand][2], color[colorRand][3] ) 
	physics.addBody( block, { density=0.9, friction=0.3, bounce=0.3} )
	table.insert( fraction_table, block )

	transition.to( block,{ time=200, onRepeat=5, onComplete=color_trans } )

	for key, item in pairs(fraction_table) do
		if ( item.x > display.contentWidth ) and ( item.y < 0 ) then 
			physics.removeBody(item)
			table.remove( fraction_table, key )
		end
	end






	--frac_len = #fraction_table
	--print( frac_len )
	--for i=1, (frac_len) do
	--	if ( fraction_table[i].x > display.contentWidth ) and ( fraction_table[i].x < 0 ) then 
	--		table.remove( fraction_table, i )
	--		frac_len = frac_len - 1
	--	end
	--end


end

local dropCrates = timer.performWithDelay( 200, new_block, -1 ) -- infinitely -- before local dropCrates = timer.performWithDelay( 50, new_block, 100 )
sky:addEventListener( "touch", set_round )