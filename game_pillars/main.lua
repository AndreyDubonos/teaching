local physics = require("physics")
physics.start()

display.setStatusBar( display.HiddenStatusBar )

local bars = {}
local bar_count = 1
local bar_width = 50

local barColors = {{ r = 255, g = 164, b = 32}, { r = 0, g = 91, b = 223}, {	r = 1, g = 117, b = 168},
	{r = 112, g = 0, b = 255}, { r = 143, g = 255, b = 0}, {r = 99, g = 247, b = 180}} --add more colors

for i=1, #barColors do
	barColors[i].r = barColors[i].r /255
	barColors[i].g = barColors[i].g /255
	barColors[i].b = barColors[i].b /255
end

local bacground = display.newRect( display.contentWidth /2, display.contentHeight /2, display.contentWidth, display.contentHeight )
bacground:setFillColor( 0.95 )

local function on_bar_touch(event)
	local bar = event.target
	transition.cancel(bar)
	transition.to(
		bar, 
		{
			time = math.random(10000, 15000), 
			height = 0
		} 
	)
end

local function new_bar(bar_index)
	local rand_y = 100 --math.random(10, 50)
	local x_end = 0
	local bar

	for _, bar in ipairs(bars) do
		local bar_right = bar.x + bar.width	
		if bar_right > x_end then x_end = bar_right end
	end

	bar = display.newRect(x_end, display.contentHeight, bar_width, rand_y)
	bar:addEventListener("touch", on_bar_touch)

	bar.anchorX = 0
	bar.anchorY = 1

	local colorIndex = math.random( 1, #barColors )

	bar:setFillColor(barColors[colorIndex].r, barColors[colorIndex].g, barColors[colorIndex].b)
	physics.addBody(bar ,"static")

	local height_limit = display.contentHeight / 3 * 2
	transition.to(
		bar, 
		{
			time = math.random(10000, 15000), 
			height = math.random(height_limit, height_limit + 50)
		} 
	)

	bars[bar_index] = bar
	return x_end
end

local function create_bars()
	local bar_index = 1
	local bar_right
	repeat
		bar_right = new_bar(bar_index)
		bar_index = bar_index + 1
	until bar_right > display.contentWidth
end

local function move_bars()
	local bar, index
	local move_value = 2
	for index, bar in ipairs(bars) do
		bar.x = bar.x - move_value
		if bar.x + bar.width < 0 then
			bar:removeSelf()
			new_bar(index)
		end
	end
end

create_bars()

local move = timer.performWithDelay(60, move_bars, 0)
