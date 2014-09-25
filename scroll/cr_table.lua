--local table {}
function create_table()
	--table{}
	--return table
	print( "1" )
	return true
end

function display_table(table, pic, adress)
	-- if lehgt(pic) == length(adress)
	for i, j in pairs(pic) do
		print(pic)
		print(web)
		table[i].pic = display.newImageRect( j, 50, 50 )-- ERROR 5 parameters, documentation   display.newImageRect( [parentGroup,] filename, [baseDir,] width, height )
		table[i].pic.x = 30 
		table[i].pic.y = i*52 + 10 --EROR 30 что, умножить, делить
		table[i].pic:addEventListener( "touch", openWeb(i, adress) )
	end
	-- body
end

local function openWeb( event, i, adress )
    if event.phase == "began" then
    	os.execute("start " .. adress[i])
	end
end