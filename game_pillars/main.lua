local physics = require("physics")
physics.start()

local pillars = {}
local number_pil = 1

local function new_pillar()
	local rand_y = math.random(10, 50)
	x_end = (number_pil-1)*20
	pillars[number_pil] = display.newRect(x_end, display.contentHeight, 20, rand_y)
	pillars[number_pil].anchorX = 0
	pillars[number_pil].anchorY = 1
	pillars[number_pil]:setFillColor(math.random(), math.random(), math.random())
	physics.addBody(pillars[number_pil] ,"static")
	--display.newRect( 20, 80, 280, 50 )
	--x_end = x_end + 20

	transition.to( pillars[number_pil], {time=math.random(10000, 15000), height = display.contentHeight / 3 * 2} )
	print("x=", x_end)
	print("y=", rand_y)
	print("height", display.contentHeight - rand_y)
	print("all=", display.contentHeight)
	number_pil=number_pil+1
end

--for i = 1, 16 do
--	new_pillar(i)
--end


--local show_pillars = 
timer.performWithDelay(500, new_pillar, 25)