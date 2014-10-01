
local widget = require( "widget" )

function create_table()
	local table = {}
	return table
	--print( "1" )
	--return true
end



function display_table(table, pic, adress)

	scrollView = widget.newScrollView
	{
	    top = -10,
	    left = 0,
	    width = 300,
	    height = 400,
	    --scrollWidth = 600,
	    scrollHeight = 800,
	    horizontalScrollDisabled = true,
    	hideBackground = true   
	    --listener = scrollListener
	}


	local background = display.newRect( 0, 0, 600, 800 )
	background:setFillColor( 0, 0, 0 )
	scrollView:insert(background)

	--scrollView:setScrollHeight( 100 )

	--last_index = 0
	
	-- if lehgt(pic) == length(adress)
	for i, j in pairs(pic) do
		--print(i, j)

		table[i] = display.newGroup()
		

		lable_back = display.newRect( 150, (i-1)*52 +30, 300, 50 )  --anchor
		table[i]:insert(lable_back)

		

		web_text = display.newText( 		{
		    text = string.sub (adress[i], 8),     
		    x = 170,
		    y = (i-1)*52 + 30,
		    --width = 500,     --required for multi-line and alignment
		    font = native.systemFontBold,   
		    fontSize = 20,
		    --align = "center"  --new alignment parameter
		} )
		table[i]:insert(web_text)
		web_text:setFillColor( 0, 0, 0 )
		lable_back:setFillColor( math.random(50)*0.01, math.random(50)*0.01, math.random(50)*0.01 )
		--scrollView:insert(lable_back)
		--scrollView:insert(web_text)

		logo = display.newImageRect( j, 50, 50 )-- ERROR 5 parameters, documentation   display.newImageRect( [parentGroup,] filename, [baseDir,] width, height )
		table[i]:insert(logo)
		logo.x = 30 
		logo.y = (i-1)*52 +30  --EROR 30 что, умножить, делить
		--scrollView:insert(table[i])
		scrollView:insert(table[i])

		table[i]:addEventListener( "touch", move_delete )
		
		table.last_index = i
		--print( table.last_index )
		logo:addEventListener( "touch", function(event)
			    if event.phase == "began" then
			    	os.execute("start " .. adress[i])
				end
			end )
	end
	-- body
	return true
end




function add_item(table, pic, adress )
	table.last_index = table.last_index + 1
	lable_back = display.newRect( 150, (table.last_index -1)*52 +30, 300, 50 )

	table[table.last_index] = display.newGroup()
	web_text = display.newText( 		{
	    text = string.sub (adress, 8),     
	    x = 170,
	    y = (table.last_index-1)*52 + 30,
	    --width = 500,     --required for multi-line and alignment
	    font = native.systemFontBold,   
	    fontSize = 20,
	    --align = "center"  --new alignment parameter
	} )
	web_text:setFillColor( 0, 0, 0 )
	lable_back:setFillColor( math.random(50)*0.01, math.random(50)*0.01, math.random(50)*0.01 )
	table[table.last_index]:insert(lable_back)
	table[table.last_index]:insert(web_text)



	logo = display.newImageRect( pic, 50, 50 )-- ERROR 5 parameters, documentation   display.newImageRect( [parentGroup,] filename, [baseDir,] width, height )
	logo.x = 30 
	logo.y = (table.last_index-1)*52 +30  --EROR 30 что, умножить, делить
	table[table.last_index]:insert(logo)
	
	scrollView:insert(table[table.last_index])
	table[table.last_index]:addEventListener( "touch", move_delete )
	
	logo:addEventListener( "touch", function( event)
		    if event.phase == "began" then
		    	os.execute("start " .. adress)
			end
		end )
	-- body
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
    	--table.last_index = table.last_index - 1       
    	--!!!!!
    end
    
    return true
end
