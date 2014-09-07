-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local physics = require("physics")
physics.start()

local grass = display.newImage("grass.png")  
grass.x = 160; grass.y = 478

local sky = display.newImage( "bkg_clouds.png" )
sky.x = display.contentWidth / 2
sky.y = 200

physics.addBody( grass, "static", { friction=0.5, bounce=0.3 } )
fraction_table = {}

function new_block()
	xRand= math.random(0,320)
	block = display.newRect( xRand, -10, 10, 10 )
	block:setFillColor( 1, 1, 0) 

	physics.addBody( block, { density=0.9, friction=0.3, bounce=0.3} )
	table.insert( fraction_table, block )


	for key, item in pairs(fraction_table) do
		if ( item.x > display.contentWidth ) and ( item.y < 0 ) then 
			physics.removeBody(item)
			table.remove( fraction_table, key )
		end
		if ( item.y > 425) then
			local image_sheet = graphics.newImageSheet("Explosion_Spritesheet.png", {
	    		--required parameters
	    		width = 40,
	    		height = 40,
	    		numFrames = 20,

	    		--optional parameters; used for dynamic resolution support
	    		sheetContentWidth = 200,  -- width of original 1x size of entire sheet
	    		sheetContentHeight = 160   -- height of original 1x size of entire sheet
	        })-- right now

	        local sprite = display.newSprite( image_sheet, 
				{
	    			name="walking",
	    			start=1,
	    			count=20,
	    			time=100,
	    			loopCount = 0,   -- Optional ; default is 0 (loop indefinitely)
	    			loopDirection = "forward"    -- Optional ; values include "forward" or "bounce"
				} )

	        sprite.x = item.x
	        sprite.y = item.y
	        
	        table.remove( fraction_table, key )

		end
	end
end

local dropCrates = timer.performWithDelay( 400, new_block, -1 )

