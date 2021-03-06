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
name_current_block = 0


local image_sheet = graphics.newImageSheet("Explosion_Spritesheet.png", {

	width = 400,
	height = 400,
	numFrames = 25,

		
	sheetContentWidth = 2000,  -- width of original 1x size of entire sheet
	sheetContentHeight = 2000   -- height of original 1x size of entire sheet
	})-- right now


local function onCollision(  event )

	if ( event.phase == "began" ) then


    	--print( event.x,event.y )
    	--print( name_current_block )
    	--print( event.other.myName )
    	--if (name_current_block ~= event.other.myName) then

    	if(event.target.isFirstCollision==true) then
			local sprite = display.newSprite( image_sheet, 
				{
					name="walking",
					start=1,
					count=25,
					time=1000,
					loopCount = 1,  
			
				} )
	    	
	    	sprite.x = event.target.x
	    	sprite.y =  event.target.y
			sprite:play()
			--end
			--name_current_block = event.other.myName   
			

			--event.target:removeEventListener("collision", onCollision)
			event.target.isFirstCollision=false;
		end
	end
end
--item.collision = onLocalCollision
--	crate1:addEventListener( "collision", crate1 )

--Runtime:addEventListener( "collision", onCollision )
--grass.collision = onLocalCollision

function new_block()
	
	xRand= math.random(0,320)
	local block = display.newRect( xRand, -10, 10, 10 )
	block:setFillColor( 1, 1, 0) 

	physics.addBody( block, { density=0.9, friction=0.3, bounce=0.3} )
	table.insert( fraction_table, block )
	block:addEventListener( "collision", onCollision )
	--block.myName = #fraction_table
	block.isFirstCollision=true; -- TUT
	--print( block.myName )


	--for key, item in pairs(fraction_table) do
	--	if ( item.x > display.contentWidth ) and ( item.y < 0 ) then 
	--		--physics.removeBody(item)
	--		--table.remove( fraction_table, key )
	--	end	
	--end
end


local dropCrates = timer.performWithDelay( 1000, new_block, -1 )

