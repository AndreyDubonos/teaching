local physics = require("physics")
physics.start()

local pillars = {}
local x_end = 0
local rand_y = 50

local function new_pillar(i)
	rand_y = math.random(200, 300)
	pillars[i] = display.newRect(x_end, display.contentHeight, 20, rand_y)
	pillars[i].anchorX = 0
	pillars[i].anchorY = 1
	pillars[i]:setFillColor(math.random(), math.random(), math.random())
	physics.addBody(pillars[i] ,"static")
	--display.newRect( 20, 80, 280, 50 )
	y = rand_y
	--x_end = x_end + 20
	x_end = i*20
	transition.to( pillars[i], {time=math.random(10000, 15000), height = display.contentHeight} )
	print("x=", x_end)
	print("y=", rand_y)
	print("height", display.contentHeight - rand_y)
	print("all=", display.contentHeight)
end

for i = 1, 16 do
	new_pillar(i)
end


--local show_pillars = 
--timer.performWithDelay(500, new_pillar)