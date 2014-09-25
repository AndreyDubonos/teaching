--local table {}
function create_table()
	return table
end

function display_table(table, pic, adress)
	-- if lehgt(pic) == length(adress)
	for i, j in pairs(pic) do
		table[i].logo = display.newImageRect( j, 50, 50 )-- ERROR 5 parameters, documentation
		table[i].logo.x = 30 table[i].logo.y = i*52 + 10 --EROR 30 что, умножить, делить
		table[i].logo:addEventListener( "touch", openWeb(i, adress) )
	end
	-- body
end

local function openWeb( event, i, adress )
    if event.phase == "began" then
    	os.execute("start " .. adress[i])
	end
end