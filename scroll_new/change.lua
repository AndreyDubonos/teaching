local composer = require "composer"
local widget = require("widget")
local fileName = "data.json"
local filePath = system.DocumentsDirectory

local scene_ch = composer.newScene()

function scene_ch:sceneExit()
    composer.gotoScene("menu", {effect = "fade", time = 100}) 
    self.newAdress.isVisible = false
    self.newName.isVisible = false
    --self.newAdress:removeSelf()
    --self.newName:removeSelf()
end

function scene_ch:exitSave()
    self.data.web = self.newAdress.text
    self.data.name = self.newName.text
    self.newAdress.isVisible = false
    self.newName.isVisible = false
    --self.newAdress:removeSelf()
    --self.newName:removeSelf()
    composer.gotoScene("menu", {params = self.data, effect = "fade", time = 100})
end

function scene_ch:create(event)
    local view = self.view

	self.newAdress = native.newTextField(100, 10, 150, 50 )
    view:insert(self.newAdress)
    self.newAdress.text = "text1"

	self.newName = native.newTextField(100, 70, 150, 50)
    view:insert(self.newName)
    self.newName.text = "text2"

	local background = display.newRect( 0, 0, display.contentWidth*2, display.contentHeight*2 )
	background:setFillColor(0, 0.5, 0)
    view:insert(background)

	local cancelBut = widget.newButton
	{
	    left = 0,
	    top = 400,
	    id = "button1",
	    label = "cancel",
	    labelColor = {default = {0, 0, 0}, over = {0, 0, 0, 1}},
	    onPress = function()
            self:sceneExit()
        end
	}
    view:insert(cancelBut)

	local saveBut = widget.newButton
	{
	    left = 140,
	    top = 400,
	    id = "button2",
	    label = "save",
	    labelColor = {default = {0, 0, 0}, over = {0, 0, 0, 1}},
	    onPress = function()
            self:exitSave()
        end
	}
    view:insert(saveBut)
end

function scene_ch:show(event)

	self.newAdress.isVisible = true
	self.newName.isVisible = true
    self.data = event.params._data
    self.newAdress.text = self.data.web
    self.newName.text = self.data.name
end

scene_ch:addEventListener("create", scene_ch)
scene_ch:addEventListener("show", scene_ch)

return scene_ch