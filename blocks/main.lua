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
  round = display.newRect( x, y, 70, 70)
  physics.addBody( round, "static", { friction=0.5, bounce=0.3, radius=20 } ) 
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

	
	block = display.newRect( xRand, -10, 10, 10 ) -- before block = display.newRect( -100, 150, 50, 50 )

	block:setFillColor( color[colorRand][1]/255, color[colorRand][2]/255, color[colorRand][3]/255 ) -- before block:setFillColor( color[rand][1], color[rand][2], color[rand][3] )
	physics.addBody( block, { density=0.9, friction=0.3, bounce=0.3} )
end

local dropCrates = timer.performWithDelay( 200, new_block, -1 ) -- infinitely -- before local dropCrates = timer.performWithDelay( 50, new_block, 100 )
sky:addEventListener( "touch", set_round )