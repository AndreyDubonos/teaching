-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local group = display.newGroup()
local block = display.newRect( 100, 100, 30, 30 )
block:setFillColor( 1, 0, 0 )
group:insert( block )

group.x = 50
group.y = 50

--Add a smaller blue box
local circle = display.newCircle(group, 50, 50, 30 )
circle:setFillColor( 0, 0, 1 )
--group:insert( circle )

local polygon = display.newPolygon( group, 120, 60, {15, 15, 0, 40, 30, 40} )
polygon:setFillColor( 1, 1, 0 )
transition.to(group, {time=3000, delay=5000, rotation=45, onComplete=function()
		group:scale( 100, 100 )
		end})

transition.to( circle, { time=4000, y=100, x=100} )

transition.pause()

transition.to( group, { time=4000, y=150, x=150, onComplete=function()
		group.alpha=0.5
		transition.resume()
		end} )


