-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local physics = require("physics")
physics.start()


--display.setStatusBar( display.HiddenStatusBar )

local grass = display.newImage("grass.png")  
grass.x = 160; grass.y = 478

local sky = display.newImage( "bkg_clouds.png" )
sky.x = display.contentWidth / 2
sky.y = 200


physics.addBody( grass, "static", { friction=0.5, bounce=0.3 } )  

-- local block1 = display.newRect( -100, 150, 50, 50 )
-- physics.addBody( block1, "dynamic", { density=0.9, friction=0.3, bounce=0.3} )
-- block1:setFillColor(50)
-- block1.isSleepingAllowed = false

function new_block()	
	color = {} -- инициализация в одну строку?
	color[1] = {201, 160, 220}
	color[2] = {18, 10, 143}
	color[3] = {208, 240, 192}
	color[4] = {0, 255, 255}
	color[5] = {0, 0, 255}
	color[6] = {3, 192, 60}
	color[7] = {255, 218, 185}
	color[8] = {128, 128, 128}
	color[9] = {253, 233, 16}
	color[10] = {152, 255, 152}
	color[11] = {175, 238, 238}
	color[12] = {192, 192, 192}

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