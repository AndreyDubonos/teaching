-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local widget = require( "widget" )
local table = require("cr_table")

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
--[[local scrollView = widget.newScrollView
{
    top = 100,
    left = 10,
    width = 300,
    height = 400,
    scrollWidth = 600,
    scrollHeight = 800,
    listener = scrollListener
}]]

-- Create a image and insert it into the scroll view
logo {"Icon-ouya.png", "Icon-ouya.png", "Icon-ouya.png", "Icon-ouya.png"}
web {"http://google.com", "http://pikabu.ru", "http://www.tumblr.com", "https://hall.com"}

local button1 = widget.newButton
{
    width = 240,
    height = 120,
    defaultFile = "buttonDefault.png",
    overFile = "buttonOver.png",
    label = "button",
    onEvent = handleButtonEvent
}

local function handleButtonEvent( event )

    if ( "ended" == event.phase ) then
        my_table = table.create_table(logo, web)
    end
end
--scrollView:insert( background )
--scrollView:insert( logotype[1] )
--scrollView:insert( logotype[2] )
--os.execute("start " .. logotype[1].web)
--os.execute("start " .. logotype[2].web)