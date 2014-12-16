local composer = require("composer")
local widget = require("widget")
local scroll = require("cr_table")
local json = require("json")
local menu_sc = composer.newScene()
local fileName = "data.json"
local filePath = system.DocumentsDirectory

function menu_sc:save()
    local path = system.pathForFile(fileName, filePath)
    local file = io.open(path, "w")
    if file then
        local contents = json.encode(self.data)
        file:write( contents )
        io.close( file )
    end
end

function menu_sc:load()
    local path = system.pathForFile(fileName, filePath)
    local contents = ""
    local file = io.open( path, "r" )
    print("file", file)
    if file then
        local contents = file:read( "*a" )
        self.data = json.decode(contents);
        io.close( file )
    else
        self.data = {
            {logo = "google.png", web = "http://google.com", name = "google.com"}, 
            {logo = "pikabu.png", web = "http://pikabu.ru", name = "pikabu.ru"}, 
            {logo = "tumblr.png", web = "http://www.tumblr.com", name = "tumblr.com"}, 
            {logo = "twitter.png", web = "http://twitter.com", name = "twitter.com"}
        }    
    end    
end

function menu_sc:create( event )
    local view = self.view

    -- добавить массив названий!
    --если файл не пуст, загрузить массивы из файла
    self:load()

    item_logo = "habrhabr.png"
    item_web = "http://habrahabr.ru"
    item_name = "habrahabr.ru"

    self.table = scroll:create_table()

    function handleButtonEvent( event )
        if ( "began" == event.phase ) then
            self.table:addItem({logo = item_logo, web = item_web})
            -- TODO: добавить название и адресс в массив данных
        end
        return true
    end

    local tableView = self.table:display(self.data)
    view:insert(tableView)

    local butDisplay = widget.newButton
    {
        left = 70,
        top = 400,
        id = "butDisplay",
        label = "display",
        onPress = handleButtonEvent
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

menu_sc:addEventListener("create", menu_sc)
menu_sc:addEventListener("show", menu_sc)

return menu_sc
