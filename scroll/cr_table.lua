
local cr_table = {}

local widget = require( "widget" )

local separator = 5
--local itemHeight 


local function allToPlace(scrollN)
	local sumHeight = 0

	for i=1, #scrollN.viewItems do
		transition.to( scrollN.viewItems[i], {time=500, y = sumHeight, onComplete= function() print(1) end})

		--scrollN.viewItems[i].y = sumHeight

		sumHeight = sumHeight + scrollN.viewItems[i].height + separator
	end
end

function cr_table.create_table()
	--НЕЛЬЗЯ НАЗЫВАТЬ table
	local table = {}
	-- properties
	table.view = display.newGroup()

	--functions
	table.display = display_table
	table.addItem = addItem
	table.stack = allToPlace
	return table
	--print( "1" )
	--return true
end





function display_table(self, data)

	local scrollView = widget.newScrollView
	{
	    top = 10,
	    left = 0,
	    width = 300,
	    height = 400,
	    horizontalScrollDisabled = true,
    	hideBackground = true   
	}


	self.scroll = scrollView

	local background = display.newRect( (scrollView.x+scrollView.width)/2, (scrollView.y+scrollView.height)/2, 300, 400 )
	background:setFillColor( 0, 0, 0 )

	--Обрати внимение добавляю в группу self.view, которую верну в вызывающий код
	self.view:insert(background)
	self.view:insert(scrollView)

	self.data = data
	self.viewItems = {}

	local sumHeight = 0
	--local separator = 5

	for i=1, #self.data do
		local tempGroup = display.newGroup()

		local lable_back = display.newRect(tempGroup, 0, 0, 300, 50 )  
		lable_back.anchorX, lable_back.anchorY = 0, 0
		lable_back:setFillColor( math.random(50)*0.01, math.random(50)*0.01, math.random(50)*0.01 )

		local delete_but = widget.newButton
		{
		    left = 260,
		    top = 0,
		    --shape = rect,
		    width = 40, 
		    --height = 10,
		    
		    label = "X",
		    labelColor = {default = {0, 0, 0}},
		    onPress = function ( event )
				    transition.to( tempGroup, {time=500, alpha = 0, x = 300, onComplete= function(event)
				    		for i=1,#self.viewItems do
				    			--print("HH")
				    			print(self.viewItems[i],tempGroup)
				    			if(self.viewItems[i]==tempGroup) then
				    				table.remove(self.viewItems, i)
				    				break
				    			end
				    		end

				    		tempGroup:removeSelf()-- body
				    		tempGroup = nil

				    		self:stack() 
				    	end} )
				--end
			    
			    return true
			end
		}

		tempGroup:insert(delete_but)

		local web_text = display.newText( 		{
		    text = string.sub (self.data[i].web, 8),     
		    x = 170,
		    y = 25,
		    --width = 500,     --required for multi-line and alignment
		    font = native.systemFontBold,   
		    fontSize = 20,
		    --align = "center"  --new alignment parameter
		} )
		web_text:setFillColor( 0, 0, 0 )
		tempGroup:insert(web_text)
		

		local logo = display.newImageRect( self.data[i].logo, 50, 50 )-- ERROR 5 parameters, documentation   display.newImageRect( [parentGroup,] filename, [baseDir,] width, height )
		logo.x = 25 
		logo.y = 25  --EROR 30 что, умножить, делить

		tempGroup:insert(logo)

		tempGroup.y = sumHeight

		scrollView:insert(tempGroup)
		table.insert(self.viewItems, tempGroup)

		--tempGroup:addEventListener( "touch", move_delete )
		
		table.last_index = i
		--print( table.last_index )
		logo:addEventListener( "touch", function(event)
			    if event.phase == "began" then
			    	os.execute("start " .. adress[i])
				end
			end )
		
		
		sumHeight = sumHeight + lable_back.height + separator
	end

	return self.view
end

function addItem(self, itemData)
	local sumHeight
	if #self.viewItems==0 then
		sumHeight = 5
	else
		sumHeight = self.viewItems[#self.viewItems].y + 50 + 5
	end

	local tempGroup = display.newGroup()

	local lable_back = display.newRect(tempGroup, 0, 0, 300, 50 ) 
	lable_back.anchorX, lable_back.anchorY = 0, 0
	lable_back:setFillColor( math.random(50)*0.01, math.random(50)*0.01, math.random(50)*0.01 )



	local delete_but = widget.newButton
		{
		    left = 260,
		    top = 0,
		    --shape = rect,
		    width = 40, 
		    --height = 10,
		    
		    label = "X",
		    labelColor = {default = {0, 0, 0}},
		    onPress = function ( event )
				    transition.to( tempGroup, {time=500, alpha = 0, x = 300, onComplete= function(event)
				    		for i=1,#self.viewItems do
				    			--print("HH")
				    			print(self.viewItems[i],tempGroup)
				    			if(self.viewItems[i]==tempGroup) then
				    				table.remove(self.viewItems, i)
				    				break
				    			end
				    		end

				    		tempGroup:removeSelf()-- body
				    		tempGroup = nil

				    		self:stack()
				    	end} )
				--end
			    
			    return true
			end
		}

	tempGroup:insert(delete_but)

	
	local web_text = display.newText( 		{
	    text = string.sub (itemData.web, 8),     
	    x = 170,
	    y = 25,
	    --width = 500,     --required for multi-line and alignment
	    font = native.systemFontBold,   
	    fontSize = 20,
	    --align = "center"  --new alignment parameter
	} )
	web_text:setFillColor( 0, 0, 0 )
	tempGroup:insert(web_text)
	

	local logo = display.newImageRect(itemData.logo, 50, 50 )
	logo.x = 25 
	logo.y = 25  

	tempGroup:insert(logo)

	tempGroup.y = sumHeight

	self.scroll:insert(tempGroup)
	table.insert(self.viewItems, tempGroup)

	--tempGroup:addEventListener( "touch", move_delete )
	
	table.last_index = i
	--print( table.last_index )
	logo:addEventListener( "touch", function(event)
		    if event.phase == "began" then
		    	os.execute("start " .. adress[i])
			end
		end )
end


function move_delete(event)
	-- body
    
	if event.phase == "began" then
        event.target.markX = event.target.x    -- store x location of object
        event.target.touch = 1
    elseif event.phase == "moved" then
    	if event.target.touch == 1 then
	        local x = (event.x - event.xStart) + event.target.markX
	        event.target.x = x    -- move object based on calculations above
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