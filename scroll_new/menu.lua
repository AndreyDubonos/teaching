local composer = require("composer")
local widget = require("widget")
local scroll = require("myScroll")
local json = require("json")
local loadsave = require "loadsave"

local menu_sc = composer.newScene()

local fileName = "data.json"

function menu_sc:save()
    print("saved")
    loadsave.saveTable(self.data, fileName, filePath)
end

function menu_sc:load()
    local tempData = loadsave.loadTable(fileName, system.DocumentsDirectory)

    if(tempData) then
        self.data = tempData
        print("data loaded")
    else
        print("data not loaded")
        self.data = {
            {logo = "assets/google.png", web = "http://google.com", name = "google.com"}, 
            {logo = "assets/pikabu.png", web = "http://pikabu.ru", name = "pikabu.ru"}, 
            {logo = "assets/tumblr.png", web = "http://www.tumblr.com", name = "tumblr.com"}, 
            {logo = "assets/twitter.png", web = "http://twitter.com", name = "twitter.com"}
        }    
    end
end

function menu_sc:create( event )
    local view = self.view

    local back = display.newRect(view, display.contentWidth/2, display.contentHeight/2, display.contentWidth, display.contentHeight)
    self:load()

    local item_logo = "assets/habrhabr.png"
    local item_web = "http://habrahabr.ru"
    local item_name = "habrahabr.ru"

    self.scroll = scroll:create_table()

    function handleButtonEvent( event )
        if ( "ended" == event.phase ) then
            local newItem = {logo = item_logo, web = item_web, name = item_name}
            self.scroll:addItem(newItem)
            table.insert(self.data, newItem)
            self:save()
        end
        return true
    end

    local tableView = self.scroll:display(self.data)
    view:insert(tableView)
    local butDisplay = widget.newButton
    {
        left = display.contentWidth * 0.25,
        top = display.contentHeight - 30,
        shape = "rect",
        emboss = true,
        width = display.contentWidth * 0.5,
        height = 30,
        fontSize = 16,
       fillColor = { default={ 0,0,0,0.1 }, over={ 0,0,0,1 } },
       strokeColor = { default={ 0.25 }, over={ 0.25 } },
       labelColor = { default={ 0.85 }, over={ 0.85 } },
       strokeWidth = 5,
        id = "butDisplay",
        label = "Display",
        onEvent = handleButtonEvent
    }
    view:insert(butDisplay)
end

function menu_sc:show(event)
    print("Params: ", event.params);

    if event.params == nil then
        return
    end

    print("Name (show): ", self.data[1].name)
    
    self:save()
end
function menu_sc:destroy( event )
    self:save()
end

menu_sc:addEventListener("create", menu_sc)
menu_sc:addEventListener("show", menu_sc)
menu_sc:addEventListener("destroy", menu_sc)

return menu_sc
