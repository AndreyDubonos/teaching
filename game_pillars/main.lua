local physics = require("physics")
physics.start()

display.setStatusBar(display.HiddenStatusBar)

local bars = {}
local active_bar = nil
local active_x = 0
local active_y = 0
local bar_count = 1
local bar_width = 50

local barColors = {"1E2F73", "B92028", "EEB51C", "088240", "007A8E", "004C91", "00230B"}

local background = display.newRect(display.contentWidth / 2, display.contentHeight / 2, display.contentWidth, display.contentHeight)
background:setFillColor(0.95)

local function cancel_active()
	if active_bar == nil then return end

	transition.cancel(active_bar)
	local height_limit = display.contentHeight / 3 * 2
	transition.to(
		active_bar, 
		{
			time = math.random(4000, 6000), 
			height = math.random(height_limit, height_limit + 50)
		} 
	)
	active_bar = nil
end

local function set_active_bar(bar, x, y)
	if active_bar ~= nil then
		cancel_active()
	end

	if bar == nil then
		return
	end

	active_bar = bar
	active_x = x
	active_y = y

	transition.cancel(bar)
	transition.to(
		bar, 
		{
			time = math.random(6000, 8000), 
			height = 0
		} 
	)
end

local function end_touch()
	active_x = nil
	active_y = nil
end

local function on_back_touch(event)
	if event.phase == "began" or  event.phase == "moved" then
		active_x = event.x
		active_y = event.y
	elseif event.phase == "ended" then
		cancel_active()
		end_touch()
	end
end

local function on_bar_touch(event)
	local bar = event.target
	if event.phase == "began" then
		set_active_bar(bar, event.x, event.y)
	elseif event.phase == "moved" then
		if active_bar ~= bar then
			set_active_bar(bar, event.x, event.y)
		end
	elseif event.phase == "ended" then
		cancel_active()
		end_touch();
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
	local new_active_bar = nil

	for index, bar in ipairs(bars) do
		bar.x = bar.x - move_value
		if bar.x + bar.width < 0 then
			bar:removeSelf()
			new_bar(index)
			bar = bars[index]
		end

		if active_x ~= nil and active_y ~= nil then
			local bounds = bar.contentBounds

			if
				active_x >= bounds.xMin and active_x <= bounds.xMax and
				active_y >= bounds.yMin and active_y <= bounds.yMax
			then
				print("BoundsMatch( ", index, "): ", active_x, ", ", active_y, " in ", bounds.xMin, ", ", bounds.yMin, ", ", bounds.xMax, ", ", bounds.yMax)
				new_active_bar = bar
			end
		end
	end

	if new_active_bar ~= active_bar then
		if new_active_bar == nil then
			print("ActiveNotFound")
		else
			print("ActiveChanged ", new_active_bar._index)
		end
		set_active_bar(new_active_bar, active_x, active_y)
	end
end

create_bars()

background:addEventListener("touch", on_back_touch)
local move = timer.performWithDelay(60, move_bars, 0)
