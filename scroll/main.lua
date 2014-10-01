-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local widget = require( "widget" )
local scroll = require("cr_table")

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

--Почему не local?
local logos = {"google.png", "pikabu.png", "tumblr.png", "twitter.png"}
local webs = {"http://google.com", "http://pikabu.ru", "http://www.tumblr.com", "http://twitter.com"}

local data = {}
for i=1, #logos do
    table.insert(data, {logo=logos[i], web=webs[i]})
end

item_logo = "habrhabr.png"
item_web = "http://habrahabr.ru"

my_table = scroll.create_table()
--print( my_table[1] )
my_table:display(data)

function handleButtonEvent( event )
    if ( "began" == event.phase ) then
        my_table:addItem({logo = item_logo, web = item_web})
    end
    return true
end

button1 = widget.newButton
{
    left = 70,
    top = 400,
    id = "button1",
    label = "display",
    onPress = handleButtonEvent
}


--but = display.newRect( 50, 50, 50, 50 )

--[[function handleButtonEvent:but( event )
    if event.phase == "began" then
        print( "You touched the object!" )
        return true
    end
end]]



--but:addEventListener( "touch", handleButtonEvent )