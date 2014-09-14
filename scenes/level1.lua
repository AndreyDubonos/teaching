-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()
local widget = require "widget"





local function onPlayBtnRelease()
	

	composer.gotoScene( "scene2", { effect ="fade", time = 500, params = {"the end"}} )
	
	return true	
end

function scene:create( event )
	local sceneGroup = self.view

	local background = display.newRect( 0, 0, display.contentWidth*2, display.contentHeight*2 )
	background:setFillColor( 0, 0, 0.5 )

	sceneGroup:insert( background )
	
	n_scene_button = widget.newButton{
		label="next scene",
		labelColor = { default={255}, over={128} },
		width=154, height=40,
		onRelease = onPlayBtnRelease	
	}

	n_scene_button.x = display.contentWidth*0.5
	n_scene_button.y = display.contentHeight - 125
	print(event.params)

	local my_text = display.newText( event.params[1], 0, 0, native.systemFont, 20 )

	my_text.x = 50 ; my_text.y = 50
	my_text:setFillColor( 1, 1, 1 )
	my_text.anchorX = 0
	sceneGroup:insert( my_text )
	sceneGroup:insert( n_scene_button )
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	background:removeSelf()
	my_text:removeSelf()

	if n_scene_button then
		n_scene_button:removeSelf()
		n_scene_button = nil
	end
end


---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene