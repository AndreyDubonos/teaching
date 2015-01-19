local physics = require("physics")
physics.start()

local pillars = {}
local number_pil = 1
local pil_group = display.newGroup()

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
	pil_group:insert(pillars[number_pil])
	transition.to( pillars[number_pil], {time=math.random(10000, 15000), height = math.random(display.contentHeight / 3 * 2, display.contentHeight / 3 * 2 + 50)} )
	--print("x=", x_end)
	--print("y=", rand_y)
	--print("height", display.contentHeight - rand_y)
	--print("all=", display.contentHeight)
	number_pil=number_pil+1 --(по надобности хранить в отдельном поле эл-та массива)
end

local function move_pillars()
	pil_group.x = pil_group.x - 2
end

--for i = 1, 16 do
--	new_pillar(i)
--end


local show_pillars = timer.performWithDelay(500, new_pillar, 0)
local move = timer.performWithDelay(60, move_pillars, 0)
