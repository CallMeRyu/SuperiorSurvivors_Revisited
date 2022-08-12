--****************************************************
-- DLocator
--****************************************************
local DLocator = ISPanel:derive("DLocator")
local ButtonShowLocators = ISButton:derive("ButtonShowLocators")
local locator_instances = {}
local flag_show = false

function ButtonShowLocators:initialise()
    ISButton.initialise(self)
end

function ButtonShowLocators:update()
    if ISWorldMap_instance then
        if ISWorldMap_instance:isVisible() then self:setVisible(true)
        else self:setVisible(false) end
    end
    if flag_show then self:setTitle("Hide Survivors")
    else self:setTitle("Show Survivors") end
end

function ButtonShowLocators:new(x, y, width, height, title, clicktarget, onclick)
    local o = {}
    o = ISButton:new(x, y, width, height, title, clicktarget, onclick)
    setmetatable(o, self)
    self.__index = self
    return o
end

function remove_button_show_locators()
    button_show_locators:removeFromUIManager()
end

function create_button_show_locators()
    button_show_locators = ButtonShowLocators:new(50, getCore():getScreenHeight()-50, 150, 25, "Show Survivors", nil, on_click_show_locators)
    button_show_locators:addToUIManager()
    button_show_locators:setVisible(false)
    button_show_locators:setAlwaysOnTop(true)
end
Events.OnGameStart.Add(create_button_show_locators)

function on_click_show_locators()
    if flag_show then flag_show = false
    else flag_show = true end
end

function DLocator:initialise()
    ISPanel.initialise(self)
end

local function get_show_state() return flag_show end

function DLocator:dupdate()
    if ISWorldMap_instance then
        if ISWorldMap_instance:isVisible() then
            self:setVisible(get_show_state())
            local x = ISWorldMap_instance.mapAPI:worldToUIX(self.member.player:getX(), self.member.player:getY())
            local y = ISWorldMap_instance.mapAPI:worldToUIY(self.member.player:getX(), self.member.player:getY())
            self:setX(x-3)
            self:setY(y-3)
            if self.flag == false then self.flag = true end
        else
            if self.flag then
                table.remove(locator_instances, self.index)
                self:removeFromUIManager()
            end
        end
    end
end

local function update_locators()
    for _, value in pairs(locator_instances) do
        if value ~= nil then value:dupdate() end
    end
end
Events.OnRenderTick.Add(update_locators)

function DLocator:createChildren()
    self.indicator = ISPanel:new(0, 0, 7, 7)
    self.indicator.backgroundColor = { r = 0, g = 0, b = 1, a = 1 }
    self.member_name = ISLabel:new(0, self.indicator.height-2, 25, self.member:getName(), 1 ,1, 1, 1, UIFont.NewSmall, true)
    self:addChild(self.indicator)
    self:addChild(self.member_name)
end

function DLocator:onMouseMove(dx, dy)
    if ISWorldMap_instance.dragging then
        local mouse_x = ISWorldMap_instance:getMouseX()
        local mouse_y = ISWorldMap_instance:getMouseY()
        if not ISWorldMap_instance.dragMoved and math.abs(mouse_x-ISWorldMap_instance.dragStartX) <= 4 and math.abs(mouse_y-ISWorldMap_instance.dragStartY) <= 4 then
            return
        end
        ISWorldMap_instance.dragMoved = true
        local world_x = ISWorldMap_instance.mapAPI:uiToWorldX(mouse_x, mouse_y, ISWorldMap_instance.dragStartZoomF, ISWorldMap_instance.dragStartCX, ISWorldMap_instance.dragStartCY)
        local world_y = ISWorldMap_instance.mapAPI:uiToWorldY(mouse_x, mouse_y, ISWorldMap_instance.dragStartZoomF, ISWorldMap_instance.dragStartCX, ISWorldMap_instance.dragStartCY)
        ISWorldMap_instance.mapAPI:centerOn(ISWorldMap_instance.dragStartCX+ISWorldMap_instance.dragStartWorldX-world_x, ISWorldMap_instance.dragStartCY+ISWorldMap_instance.dragStartWorldY-world_y)
    end
    return true
end

function DLocator:onMouseMoveOutside(dx, dy)
    return self:onMouseMove(dx, dy)
end

function DLocator:onMouseDown(x, y)
    local mouse_x = ISWorldMap_instance:getMouseX()
    local mouse_y = ISWorldMap_instance:getMouseY()
    ISWorldMap_instance.dragging = true
    ISWorldMap_instance.dragMoved = false
    ISWorldMap_instance.dragStartX = mouse_x
    ISWorldMap_instance.dragStartY = mouse_y
    ISWorldMap_instance.dragStartCX = ISWorldMap_instance.mapAPI:getCenterWorldX()
    ISWorldMap_instance.dragStartCY = ISWorldMap_instance.mapAPI:getCenterWorldY()
    ISWorldMap_instance.dragStartZoomF = ISWorldMap_instance.mapAPI:getZoomF()
    ISWorldMap_instance.dragStartWorldX = ISWorldMap_instance.mapAPI:uiToWorldX(mouse_x, mouse_y)
    ISWorldMap_instance.dragStartWorldY = ISWorldMap_instance.mapAPI:uiToWorldY(mouse_x, mouse_y)
    return true
end

function DLocator:onMouseUp(_, _)
    ISWorldMap_instance.dragging = false
    return true
end

function DLocator:onMouseUpOutside(_, _)
    ISWorldMap_instance.dragging = false
    return true
end

function DLocator:onMouseWheel(del)
    ISWorldMap_instance.mapAPI:zoomAt(ISWorldMap_instance:getMouseX(), ISWorldMap_instance:getMouseY(), del)
    return true
end

function DLocator:new(x, y, member, index)
    local o = {}
    o = ISPanel:new(x, y, 100, 25+2+4)
    setmetatable(o, self)
    self.__index = self
    o.member = member
    o.flag = false
    o.index = index
    o.onMouseWheel = nil
    o.onMouseMove = nil
    return o
end

function on_map_key(key)
    if not ISWorldMap.checkKey(key) then return end
    local group_members = get_group():getMembers()
    for i=2, #group_members do
        local locator = DLocator:new(0, 0, group_members[i], i)
        locator.member = group_members[i]
        locator.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        locator.borderColor = { r = 0, g = 0, b = 0, a = 0 }
        locator:addToUIManager()
        locator:setVisible(false)
        locator:setAlwaysOnTop(true)
        table.insert(locator_instances, i, locator)
    end
end
Events.OnKeyPressed.Add(on_map_key)

--****************************************************
-- Debugging
--****************************************************
dsl = {}

function dsl.dfile()
    for _, _ in nil do
        -- Triggers a break to automatically open
        -- this file in the debug window.
    end
end

--function remove_locators()
--    for i=1, #locator_instances do
--        if locator_instances[i] ~= nil then locator_instances[i]:removeFromUIManager() end
--    end
--end