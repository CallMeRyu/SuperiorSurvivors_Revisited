local debug_mode = false
local context_options = {}
ddbugui = {}

context_options.show_context_menu_file = function(debug_table)
    local context_menu = ISContextMenu.get(0, getMouseX(), getMouseY(), 1, 1)
    for i, j in pairs(debug_table) do
        if i ~= "file" then
            context_menu:addOption(tostring(i), nil, function() j() end)
        end
    end
end

--****************************************************
-- TitleBar
--****************************************************
local TitleBar = ISButton:derive("TitleBar")

function TitleBar:initialise()
    ISButton.initialise(self)
end

function TitleBar:onMouseMove(_, _)
    self.parent.mouseOver = true
end

function TitleBar:onMouseMoveOutside(_, _)
    self.parent.mouseOver = false
end

function TitleBar:onMouseUp(_, _)
    if not self.parent:getIsVisible() then
        return
    end
    self.parent.moving = false
    ISMouseDrag.dragView = nil
end

function TitleBar:onMouseUpOutside(_, _)
    if not self.parent:getIsVisible() then
        return
    end
    self.parent.moving = false
    ISMouseDrag.dragView = nil
end

function TitleBar:onMouseDown(x, y)
    if not self.parent:getIsVisible() then
        return
    end
    self.parent.downX = x
    self.parent.downY = y
    self.parent.moving = true
    self.parent:bringToTop()
end

function TitleBar:new(title, parent)
    local o = {}
    o = ISButton:new(0, 0, parent.width, 25)
    setmetatable(o, self)
    self.__index = self
    o.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    o.title = title
    return o
end

--****************************************************
-- PanelFiles
--****************************************************
local PanelFiles = ISPanel:new(0, 25+2, 200, ((25*7)+(8*7))-(25+2))

function PanelFiles:dupdate()
    self:clearChildren()
    local dy = 0
    local switch = 0
    local scroll_height = 0
    for _, dtable in pairs(ddbugui) do
        local file_row = ISPanel:new(0, dy, self.width, 25)
        file_row.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
        file_row.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        local file_name = ISButton:new(0, 0, self.width, 25, dtable.file, nil, function() context_options.show_context_menu_file(dtable) end)
        file_name.borderColor = { r = 0, g = 0, b = 0, a = 0 }
        if switch == 0 then
            file_name.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
            switch = 1
        else
            file_name.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
            switch = 0
        end
        file_row:addChild(file_name)
        self:addChild(file_row)
        dy = dy+25
        scroll_height = scroll_height+1
    end
    self:addScrollBars()
    self:setScrollWithParent(false)
    self:setScrollChildren(true)
    self:setScrollHeight(25*scroll_height)
end

function PanelFiles:prerender()
    self:setStencilRect(0, 0, self.width, self.height)
    if self.background then
        self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    end
    if self.border then
        self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    end
end

function PanelFiles:render()
    self:clearStencilRect()
end

function PanelFiles:onMouseWheel(dir)
    dir = dir*-1
    dir = (self:getScrollHeight()/50)*dir
    dir = self:getYScroll()+dir
    self:setYScroll(dir)
    return true
end

--****************************************************
-- PanelDebug
--****************************************************
PanelDebug = ISPanel:derive("PanelDebug")

function panel_debug_visibility()
    panel_debug:setVisible(not panel_debug:isVisible())
end

function remove_panel_debug()
    panel_debug:removeFromUIManager()
end

function create_panel_debug()
    panel_debug = PanelDebug:new(getCore():getScreenWidth()-(125+100+8+200), getCore():getScreenHeight()-((50*2)+(25*7)+(8*7)+8), 200, (25*7)+(8*7), "Debug")
    panel_debug:addToUIManager()
    panel_debug:setVisible(true)
end

function PanelDebug:initialise()
    ISPanel.initialise(self)
end

function PanelDebug:createChildren()
    self.title_bar = TitleBar:new(self.title, self)
    self:addChild(PanelFiles)
    PanelFiles:dupdate()
    self:addChild(self.title_bar)
end

function PanelDebug:onMouseMove(dx, dy)
    self.mouseOver = true
    if self.moving then
        self:setX(self.x+dx)
        self:setY(self.y+dy)
        self:bringToTop()
    end
end

function PanelDebug:onMouseMoveOutside(dx, dy)
    self.mouseOver = false
    if self.moving then
        self:setX(self.x+dx)
        self:setY(self.y+dy)
        self:bringToTop()
    end
end

function PanelDebug:onMouseUp(_, _)
    if not self:getIsVisible() then
        return
    end
    self.moving = false
    ISMouseDrag.dragView = nil
end

function PanelDebug:onMouseUpOutside(_, _)
    if not self:getIsVisible() then
        return
    end
    self.moving = false
    ISMouseDrag.dragView = nil
end

function PanelDebug:onMouseDown(x, y)
    if not self:getIsVisible() then
        return
    end
    self.downX = x
    self.downY = y
    self.moving = true
    self:bringToTop()
end

function PanelDebug:new(x, y, width, height, title)
    local o = {}
    o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0.7 }
    o.title = title
    return o
end

--****************************************************
-- ButtonDebug
--****************************************************
local ButtonDebug = ISButton:derive("ButtonDebug")

function create_button_debug()
    button_debug = ButtonDebug:new(getCore():getScreenWidth()-(125+100+8), getCore():getScreenHeight()-(50+25), 100, 25, "debug", nil, function() panel_debug_visibility() end)
    button_debug.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    button_debug:setVisible(true)
    button_debug:setEnable(true)
    button_debug:addToUIManager()
end

--****************************************************
-- Debugging
--****************************************************
ddui = { file = "DDebugUI.lua" }
table.insert(ddbugui, 1, ddui)
table.insert(ddbugui, 2, dssi)
table.insert(ddbugui, 3, dssip)
table.insert(ddbugui, 4, dui)
table.insert(ddbugui, 5, dssw)
table.insert(ddbugui, 6, dssbp)
table.insert(ddbugui, 7, dssl)

function ddui.dfile()
    for _, _ in nil do
        -- Triggers a break to automatically open
        -- this file in the debug window.
    end
end

function ddui.dbug()
    print("=================")
    print("ddui::dbug")
    remove_panel_debug()
    print("remove_panel_debug()")
    create_panel_debug()
    ddbugui = {}
    print("create_panel_debug()")
    table.insert(ddbugui, 1, ddui)
    table.insert(ddbugui, 2, dssi)
    table.insert(ddbugui, 3, dssip)
    table.insert(ddbugui, 4, dui)
    table.insert(ddbugui, 5, dssw)
    table.insert(ddbugui, 6, dssbp)
    table.insert(ddbugui, 7, dssl)
    print("=================")
end

--****************************************************
-- SuperbInventory entry point
--****************************************************
function ddebugui_entry_point()
    create_panel_debug()
    create_button_debug()
end
if debug_mode then Events.OnGameStart.Add(ddebugui_entry_point) end