-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local widget = require( "widget" )
local scroll = require("cr_table")


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

