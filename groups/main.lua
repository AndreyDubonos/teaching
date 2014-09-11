-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local group = display.newGroup()
group.anchorChildren = true
--group.anchorX = 1
--group.anchorY = 1
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
--transition.to(group, {time=5000, delay=9000, anchorX=1, anchorX=1})
transition.to(group, {time=3000, delay=5000,rotation=45,  onComplete=function()
		--group:scale( 2, 2 )
		end})

transition.to(group, {time=5000, delay=8000, xScale=2, yScale=2})


transition.to( circle, { time=4000, y=100, x=100} )

transition.pause()
print(group.anchorX, group.anchorY)
transition.to( group, { time=4000, y=150, x=150, onComplete=function()
		group.alpha=0.5
		transition.resume()
		end} )


local block1 = display.newRect( 40, 40, 30, 30 )

transition.to(block1, {time=3000, delay=5000,rotation=45, onComplete=function()
		block1.anchorX = 1
		block1.anchorY = 1
		end} )

transition.to(block1, {time=3000, delay=10000,rotation=75})
