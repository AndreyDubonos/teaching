-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )

local scene = composer.newScene()


local widget = require "widget"


local next_btn, next_btn1 


local function onPlayBtnRelease()
	

	composer.gotoScene( "level1", {effect ="fade",time = 500, params = {"scene1"}} )
	
	return true	
end

function scene:create( event )
	local sceneGroup = self.view



	local background = display.newRect( 0, 0, display.contentWidth*2, display.contentHeight*2 )
	background:setFillColor( 0, 0.5, 0 )

	sceneGroup:insert( background )
	

	next_btn = widget.newButton{
		label="next",
		labelColor = { default={255}, over={128} },
		width=154, height=40,
		onRelease = onPlayBtnRelease	
	}
	next_btn.x = display.contentWidth*0.5
	next_btn.y = display.contentHeight - 125
	print(event.params)

	local my_text = display.newText( event.params[1], 0, 0, native.systemFont, 20 )

	my_text.x = 50 ; my_text.y = 50
	my_text:setFillColor( 1, 1, 1 )
	my_text.anchorX = 0
	sceneGroup:insert( my_text )

	sceneGroup:insert( next_btn )
end


function scene:destroy( event )
	local sceneGroup = self.view
	

	background:removeSelf()
	my_text:removeSelf()

	if next_btn then
		next_btn:removeSelf()	
		next_btn = nil
	end
end

---------------------------------------------------------------------------------

scene:addEventListener( "create", scene )

scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene