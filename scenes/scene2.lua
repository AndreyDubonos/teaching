local composer = require( "composer" )
local scene = composer.newScene()


--------------------------------------------

function scene:create( event )
	local sceneGroup = self.view


	local background = display.newRect( 0, 0, display.contentWidth*2, display.contentHeight*2 )
	background:setFillColor( 0.5, 0, 0 )

	sceneGroup:insert( background )

	local my_text = display.newText( event.params[1], 0, 0, native.systemFont, 25 )
	my_text.x = 50 ; my_text.y = 100
	my_text:setFillColor( 1, 1, 1 )
	my_text.anchorX = 0

end

function scene:destroy( event )
	local sceneGroup = self.view
	
	background:removeSelf()
	my_text:removeSelf()

end


---------------------------------------------------------------------------------

scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene