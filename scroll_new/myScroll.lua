
local cr_table = {}

local widget = require( "widget" )
local composer = require "composer"

local separator = 5
--local itemHeight 

function cr_table.create_table()
	cr_table.view = display.newGroup()
	return cr_table
end

function cr_table:stack()
	local sumHeight = 0

	for i = 1, #self.viewItems do
		transition.to(
			self.viewItems[i],
			{
				time = 500,
				y = sumHeight
			}
		)
		--scrollN.viewItems[i].y = sumHeight

		sumHeight = sumHeight + self.viewItems[i].height + separator
	end
end

function cr_table:createItem(itemData)
	local itemGroup = display.newGroup()
	itemGroup._data = itemData

	local lable_back = display.newRect(itemGroup, 0, 0, 300, 50)
	lable_back.anchorX, lable_back.anchorY = 0, 0
	lable_back:setFillColor(math.random(50) * 0.01, math.random(50) * 0.01, math.random(50) * 0.01)

	local delete_but = widget.newButton
	{
		left = 260,
		top = 0,
		width = 40, 
		
		label = "X",
		labelColor = {default = {0, 0, 0}},
		onPress = function(event)
			transition.to(itemGroup, {
				time = 500,
				alpha = 0,
				x = 300,
				onComplete =
					function(event)
						for i = 1, #self.viewItems do
							if (self.viewItems[i] == itemGroup) then
								table.remove(self.viewItems, i)
								table.remove(self.data, i)
								break
							end
						end

						itemGroup:removeSelf()
						itemGroup = nil

						self:stack() 
					end
				}
			)
			return true
		end
	}

	itemGroup:insert(delete_but)
	
	local web_text = display.newText{
		text = itemData.name,	 
		x = 170,
		y = 25,
		font = native.systemFontBold,   
		fontSize = 20,
	}
	web_text:setFillColor( 0, 0, 0 )
	itemGroup:insert(web_text)
	itemGroup.name = web_text

	
	local logo = display.newImageRect(itemData.logo, 50, 50) 
	logo.x = 25 
	logo.y = 25  

	itemGroup:insert(logo)
	itemGroup.y = self.sumHeight

	self.scroll:insert(itemGroup)
	table.insert(self.viewItems, itemGroup)

	table.last_index = i

	logo:addEventListener("touch",
		function(event)
			if event.phase == "began" then
				composer.gotoScene("change" , {params = itemGroup, effect = "fade", time = 100} )
			end
		end
	)

	self.sumHeight = self.sumHeight + lable_back.height + separator
end

function cr_table:display(data)
	local scrollView = widget.newScrollView{
		top = 10,
		left = 10,
		width = 300,
		height = 400,
		horizontalScrollDisabled = true,
		hideBackground = true   
	}

	self.scroll = scrollView

	local background = display.newRect(display.contentWidth / 2, display.contentHeight / 2, display.contentWidth, display.contentHeight)
	background:setFillColor(0, 0, 0)

	--Обрати внимение: добавляю в группу self.view, которую верну в вызывающий код
	self.view:insert(background)
	self.view:insert(scrollView)

	self.data = data
	self.viewItems = {}

	self.sumHeight = 0

	for i = 1, #self.data do
		self:createItem(self.data[i])
	end

	return self.view
end

function cr_table:addItem(itemData)
	if #self.viewItems == 0 then
		self.sumHeight = 5
	else
		self.sumHeight = self.viewItems[#self.viewItems].y + 50 + 5
	end

	self:createItem(itemData)	
end


function move_delete(event)
	if event.phase == "began" then
		event.target.markX = event.target.x	-- store x location of object
		event.target.touch = 1
	elseif event.phase == "moved" then
		if event.target.touch == 1 then
			local x = (event.x - event.xStart) + event.target.markX
			event.target.x = x	-- move object based on calculations above
		end
	elseif event.phase == "ended" then
		event.target.touch = 0
	end
	if (event.x >= 290) or (event.x <= 0) then
		event.target:removeSelf()
	end
	
	return true
end

return cr_table