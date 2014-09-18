-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

--[[local group = display.newGroup()
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

transition.to(block1, {time=3000, delay=10000,rotation=75})]]--


local button = display.newGroup()

circle = display.newCircle(button, 200, 200, 40 )
circle:setFillColor( 0, 0.4, 0.2)
girl = display.newImage( "but_girl.png", 200, 200 )
girl.height = 200
girl.width = 200
--group:insert( circle)
button:insert( girl)
button.anchorChildren = true

button.x = 200
button.y = 200

button.anchorX = 0.5
button.anchorY = 0.5

--transition.to(button, {time=5000, delay=2000, xScale=1.2, yScale=1.2})

local function onObjectTouch( event )
    if event.phase == "began" then
    	if (((event.x - 200)^2 + (event.y - 200)^2) < 1600) then
        	transition.to(button, {time=400, xScale=1.1, yScale=1.1})
        end
    end

    if event.phase == "ended" then
    	--if ((event.x - 200)^2 + (event.y - 200)^2 < 1600) then
    	transition.to(button, {time=400, xScale=1, yScale=1})
    	--print( 2 )
        --end
    end
    if event.phase == "moved" then
    	if (((event.x - 200)^2 + (event.y - 200)^2) > 1600) then
        	transition.to(button, {time=400, xScale=1, yScale=1})
        	--print( (event.x - 200)^2 + (event.y - 200)^2 )
        end
    end
    return true
end

button:addEventListener( "touch", onObjectTouch )
