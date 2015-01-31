local physics = require("physics")
physics.start()

display.setStatusBar(display.HiddenStatusBar)

local bars = {}
local active_bar = nil
local bar_count = 1
local bar_width = 50

local barColors = {"1E2F73", "B92028", "EEB51C", "088240", "007A8E", "004C91", "00230B"}

local background = display.newRect(display.contentWidth / 2, display.contentHeight / 2, display.contentWidth, display.contentHeight)
background:setFillColor(0.95)

local function cancel_touch()
	transition.cancel(active_bar)
	local height_limit = display.contentHeight / 3 * 2
	transition.to(
		active_bar, 
		{
			time = math.random(4000, 6000), 
			height = math.random(height_limit, height_limit + 50)
		} 
	)
end

local function on_back_touch(event)
	if event.phase == "ended" then
		cancel_touch()
	end
end

local function on_bar_touch(event)
	local bar = event.target
	if event.phase == "began" then
		active_bar = bar		
		transition.cancel(bar)
		transition.to(
			bar, 
			{
				time = math.random(6000, 8000), 
				height = 0
			} 
		)
	elseif event.phase == "ended" then
		cancel_touch()
	end
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
	bar._index = bar_index

	local colorHex = barColors[math.random(1, #barColors)]
	local colorVal = tonumber(colorHex, 16)

	-- extract each of 3 RGB components and convert them to floating point number
	bar:setFillColor(colorVal / 65536 / 256, (colorVal / 256) % 256 / 256, (colorVal % 256) / 256)
	physics.addBody(bar, "static")

	local height_limit = display.contentHeight / 3 * 2
	transition.to(
		bar, 
		{
			time = math.random(6000, 8000), 
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

background:addEventListener("touch", on_back_touch)
local move = timer.performWithDelay(60, move_bars, 0)
