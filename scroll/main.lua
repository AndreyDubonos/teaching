-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local widget = require( "widget" )

-- ScrollView listener
--[[local function scrollListener( event )

    local phase = event.phase
    if ( phase == "began" ) then print( "Scroll view was touched" )
    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
    elseif ( phase == "ended" ) then print( "Scroll view was released" )
    end

    -- In the event a scroll limit is reached...
    if ( event.limitReached ) then
        if ( event.direction == "up" ) then print( "Reached top limit" )
        elseif ( event.direction == "down" ) then print( "Reached bottom limit" )
        elseif ( event.direction == "left" ) then print( "Reached left limit" )
        elseif ( event.direction == "right" ) then print( "Reached right limit" )
        end
    end

    return true
end]]

-- Create the widget
local scrollView = widget.newScrollView
{
    top = 100,
    left = 10,
    width = 300,
    height = 400,
    scrollWidth = 600,
    scrollHeight = 800,
    listener = scrollListener
}

-- Create a image and insert it into the scroll view
local background = display.newImageRect( "Icon-ouya.png", 768, 1024 )
local logotype = {}
logotype[1] = display.newImageRect( "Icon-ouya.png", 50 ,50 )
logotype[1].web = "http://google.com"
logotype[1].x = 20   logotype[1].y = 20
logotype[2] = display.newImageRect( "Icon-ouya.png", 50, 50 )
logotype[2].web = "http://pikabu.ru"
logotype[2].y = 100  logotype[2].x = 20
scrollView:insert( background )
scrollView:insert( logotype[1] )
scrollView:insert( logotype[2] )
--os.execute("start " .. logotype[1].web)
--os.execute("start " .. logotype[2].web)

local function openWeb( event )
    if event.phase == "began" then
    	os.execute("start " .. event.target.web)
	end
end

logotype[1]:addEventListener( "touch", openWeb )
logotype[2]:addEventListener( "touch", openWeb )