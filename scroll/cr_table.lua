--local table {}
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
	    horizontalScrollDisabled = true
    	--hideBackground = true   
	    --listener = scrollListener
	}


	local background = display.newRect( 0, 0, 600, 800 )
	background:setFillColor( 0, 0, 0 )
	scrollView:insert(background)

	--scrollView:setScrollHeight( 100 )

	--last_index = 0
	
	-- if lehgt(pic) == length(adress)
	for i, j in pairs(pic) do
		print(i, j)
		lable_back = display.newRect( 30, (i-1)*52 +30, 600, 50 )

		local web_text = display.newText( 		{
		    text = string.sub (adress[i], 8),     
		    x = 170,
		    y = (i-1)*52 + 30,
		    --width = 500,     --required for multi-line and alignment
		    font = native.systemFontBold,   
		    fontSize = 20,
		    --align = "center"  --new alignment parameter
		} )
		web_text:setFillColor( 0, 0, 0 )
		lable_back:setFillColor( math.random(50)*0.01, math.random(50)*0.01, math.random(50)*0.01 )
		scrollView:insert(lable_back)
		scrollView:insert(web_text)

		table[i] = display.newImageRect( j, 50, 50 )-- ERROR 5 parameters, documentation   display.newImageRect( [parentGroup,] filename, [baseDir,] width, height )
		table[i].x = 30 
		table[i].y = (i-1)*52 +30  --EROR 30 что, умножить, делить
		scrollView:insert(table[i])
		table.last_index = i
		--print( table.last_index )
		table[i]:addEventListener( "touch", function( event)
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
	lable_back = display.newRect( 30, (table.last_index -1)*52 +30, 600, 50 )

		local web_text = display.newText( 		{
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
		scrollView:insert(lable_back)
		scrollView:insert(web_text)

		table[table.last_index] = display.newImageRect( pic, 50, 50 )-- ERROR 5 parameters, documentation   display.newImageRect( [parentGroup,] filename, [baseDir,] width, height )
		table[table.last_index].x = 30 
		table[table.last_index].y = (table.last_index-1)*52 +30  --EROR 30 что, умножить, делить
		scrollView:insert(table[table.last_index])
		
		
		table[table.last_index]:addEventListener( "touch", function( event)
			    if event.phase == "began" then
			    	os.execute("start " .. adress)
				end
			end )
	-- body
end

