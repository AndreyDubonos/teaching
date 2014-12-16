local composer = require "composer"

local test_sc = composer.newScene()

function test_sc:create(event)
    local myRectangle = display.newRect(0, 0, 150, 50)
	local view = self.view

    myRectangle.strokeWidth = 3
    myRectangle:setFillColor(0.5)
    myRectangle:setStrokeColor(1, 0, 0)

    view:insert(myRectangle)
    print("test_sc:create")
end

test_sc:addEventListener( "create", test_sc )

return test_sc