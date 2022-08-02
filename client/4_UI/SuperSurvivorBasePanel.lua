--****************************************************
-- PanelHeader
--****************************************************
local PanelHeader = ISButton:derive("PanelHeader")

function PanelHeader:initialise()
    ISButton.initialise(self)
end

function PanelHeader:onMouseMove(_, _)
    self.parent.mouseOver = true
end

function PanelHeader:onMouseMoveOutside(_, _)
    self.parent.mouseOver = false
end

function PanelHeader:onMouseUp(_, _)
    if not self.parent:getIsVisible() then
        return
    end
    self.parent.moving = false
    ISMouseDrag.dragView = nil
end

function PanelHeader:onMouseUpOutside(_, _)
    if not self.parent:getIsVisible() then
        return
    end
    self.parent.moving = false
    ISMouseDrag.dragView = nil
end

function PanelHeader:onMouseDown(x, y)
    if not self.parent:getIsVisible() then
        return
    end
    self.parent.downX = x
    self.parent.downY = y
    self.parent.moving = true
    self.parent:bringToTop()
end

function PanelHeader:new(title, parent)
    local o = {}
    o = ISButton:new(0, 0, parent.width, 25)
    setmetatable(o, self)
    self.__index = self
    o.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    o.title = title
    return o
end

--****************************************************
-- PanelBaseInfo
--****************************************************
PanelBaseInfo = ISPanel:derive("PanelBaseInfo")

function create_panel_base_info(area_name)
    panel_base_info = PanelBaseInfo:new(window_super_survivors.x+window_super_survivors.width+8, window_super_survivors.y, 426, (25*7)+(8*7), area_name)
    panel_base_info:addToUIManager()
    panel_base_info:setVisible(true)
end

function PanelBaseInfo:initialise()
    ISPanel.initialise(self)
end

function PanelBaseInfo:dupdate()
    self.group = SSGM:Get(SSM:Get(0):getGroupID())
    self.set_state = is_area_set(self.area_name)
    if self.set_state then
        self.button_select_area.enable = false
        self.button_set.enable = false
        self.button_cancel.enable = false
        self.button_clear.enable = true
    else
        self.button_select_area.enable = true
        self.button_set.enable = true
        self.button_cancel.enable = true
        self.button_clear.enable = false
    end
    if self.area_name == "Bounds" then
        self.text_x1:setName("x1: "..tostring(self.group.Bounds[1]))
        self.text_y1:setName("y1: "..tostring(self.group.Bounds[2]))
        self.text_x2:setName("x2: "..tostring(self.group.Bounds[3]))
        self.text_y2:setName("y2: "..tostring(self.group.Bounds[4]))
        self.text_z:setName("z: "..tostring(self.group.Bounds[5]))
        if self.manual_editing then
            self.textbox_x1:setText(tostring(self.group.Bounds[1]))
            self.textbox_y1:setText(tostring(self.group.Bounds[2]))
            self.textbox_x2:setText(tostring(self.group.Bounds[3]))
            self.textbox_y2:setText(tostring(self.group.Bounds[4]))
            self.textbox_z:setText(tostring(self.group.Bounds[5]))
        end
    else
        self.text_x1:setName("x1: "..tostring(self.group.GroupAreas[self.area_name][1]))
        self.text_y1:setName("y1: "..tostring(self.group.GroupAreas[self.area_name][2]))
        self.text_x2:setName("x2: "..tostring(self.group.GroupAreas[self.area_name][3]))
        self.text_y2:setName("y2: "..tostring(self.group.GroupAreas[self.area_name][4]))
        self.text_z:setName("z: "..tostring(self.group.GroupAreas[self.area_name][5]))
        if self.manual_editing then
            self.textbox_x1:setText(tostring(self.group.GroupAreas[self.area_name][1]))
            self.textbox_y1:setText(tostring(self.group.GroupAreas[self.area_name][2]))
            self.textbox_x2:setText(tostring(self.group.GroupAreas[self.area_name][3]))
            self.textbox_y2:setText(tostring(self.group.GroupAreas[self.area_name][4]))
            self.textbox_z:setText(tostring(self.group.GroupAreas[self.area_name][5]))
        end
    end
end

function PanelBaseInfo:on_click_select_area()
    local area_to_edit = (self.area_name == "Bounds") and "BaseArea" or self.area_name
    StartSelectingArea(0, area_to_edit)
end

function PanelBaseInfo:on_click_set()
    local area_to_edit = (self.area_name == "Bounds") and "BaseArea" or self.area_name
    SelectingArea(0, area_to_edit, 1)
    survivor_panels[2]:dupdate()
    self:dupdate()
end

function PanelBaseInfo:on_click_cancel()
    local area_to_edit = (self.area_name == "Bounds") and "BaseArea" or self.area_name
    SelectingArea(0, area_to_edit, 0)
    survivor_panels[2]:dupdate()
    self:dupdate()
end

function PanelBaseInfo:on_click_save()
    self.group = SSGM:Get(SSM:Get(0):getGroupID())
    if self.area_name == "Bounds" then
        self.group.Bounds[1] = tonumber(self.textbox_x1:getText())
        self.group.Bounds[2] = tonumber(self.textbox_y1:getText())
        self.group.Bounds[3] = tonumber(self.textbox_x2:getText())
        self.group.Bounds[4] = tonumber(self.textbox_y2:getText())
        self.group.Bounds[5] = tonumber(self.textbox_z:getText())
    else
        self.group.GroupAreas[self.area_name][1] = tonumber(self.textbox_x1:getText())
        self.group.GroupAreas[self.area_name][2] = tonumber(self.textbox_y1:getText())
        self.group.GroupAreas[self.area_name][3] = tonumber(self.textbox_x2:getText())
        self.group.GroupAreas[self.area_name][4] = tonumber(self.textbox_y2:getText())
        self.group.GroupAreas[self.area_name][5] = tonumber(self.textbox_z:getText())
    end
    survivor_panels[2]:dupdate()
    self:dupdate()
end

function PanelBaseInfo:on_click_clear()
    self.group = SSGM:Get(SSM:Get(0):getGroupID())
    if self.area_name == "Bounds" then
        self.group.Bounds[1] = 0
        self.group.Bounds[2] = 0
        self.group.Bounds[3] = 0
        self.group.Bounds[4] = 0
        self.group.Bounds[5] = 0
        base_area_visibility["Bounds"].button_title = "show"
    else
        self.group.GroupAreas[self.area_name][1] = 0
        self.group.GroupAreas[self.area_name][2] = 0
        self.group.GroupAreas[self.area_name][3] = 0
        self.group.GroupAreas[self.area_name][4] = 0
        self.group.GroupAreas[self.area_name][5] = 0
        base_area_visibility[self.area_name].button_title = "show"
    end
    survivor_panels[2]:dupdate()
    self:dupdate()
end

function PanelBaseInfo:on_click_manual()
    if self.manual_editing then
        self.manual_editing = not self.manual_editing
        self:removeChild(self.panel_manual_edit)
        self:setHeight(self.height-((25*7)+(8*7)))
    else
        self.manual_editing = not self.manual_editing
        self:setHeight(self.height+(25*7)+(8*7))
        self.panel_manual_edit = ISPanel:new(0, (25*7)+(8*7), self.width, (25*7)+(8*7))
        self.panel_manual_edit.borderColor = { r = 1, g = 1, b = 1, a = 0.1 }
        self.panel_manual_edit.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        self.manual_edit = ISButton:new(0,0, self.width, 25, "manual editing", nil, nil)
        self.text_mx1 = ISLabel:new(8, self.manual_edit.height+8, 25, "x1: ", 1, 1, 1, 1, nil, true)
        self.text_my1 = ISLabel:new(8, (self.manual_edit.height*2)+(8*2), 25, "y1: ", 1, 1, 1, 1, nil, true)
        self.text_mx2 = ISLabel:new(8, (self.manual_edit.height*3)+(8*3), 25, "x2: ", 1, 1, 1, 1, nil, true)
        self.text_my2 = ISLabel:new(8, (self.manual_edit.height*4)+(8*4), 25, "y2: ", 1, 1, 1, 1, nil, true)
        self.text_mz = ISLabel:new(8, (self.manual_edit.height*5)+(8*5), 25, "z: ", 1, 1, 1, 1, nil, true)
        self.textbox_x1 = ISTextEntryBox:new("", 30, self.manual_edit.height+8, 100, 25)
        self.textbox_y1 = ISTextEntryBox:new("", 30, (self.manual_edit.height*2)+(8*2), 100, 25)
        self.textbox_x2 = ISTextEntryBox:new("", 30, (self.manual_edit.height*3)+(8*3), 100, 25)
        self.textbox_y2 = ISTextEntryBox:new("", 30, (self.manual_edit.height*4)+(8*4), 100, 25)
        self.textbox_z = ISTextEntryBox:new("", 30, (self.manual_edit.height*5)+(8*5), 100, 25)
        self.button_save = ISButton:new(8,(self.manual_edit.height*6)+(8*6), self.width-16, 25, "save", nil, function() self:on_click_save() end)
        self.manual_edit.borderColor = { r = 0, g = 0, b = 0, a = 0 }
        self.manual_edit.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        self.manual_edit.onMouseDown = function() return  end
        self.manual_edit.backgroundColorMouseOver = self.manual_edit.backgroundColor
        self.textbox_x1.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
        self.textbox_y1.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
        self.textbox_x2.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
        self.textbox_y2.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
        self.textbox_z.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
        self.button_save.borderColor = { r = 1, g = 1, b = 1, a = 0.26 }
        self.panel_manual_edit:addChild(self.manual_edit)
        self.panel_manual_edit:addChild(self.text_mx1)
        self.panel_manual_edit:addChild(self.text_my1)
        self.panel_manual_edit:addChild(self.text_mx2)
        self.panel_manual_edit:addChild(self.text_my2)
        self.panel_manual_edit:addChild(self.text_mz)
        self.panel_manual_edit:addChild(self.textbox_x1)
        self.panel_manual_edit:addChild(self.textbox_y1)
        self.panel_manual_edit:addChild(self.textbox_x2)
        self.panel_manual_edit:addChild(self.textbox_y2)
        self.panel_manual_edit:addChild(self.textbox_z)
        self.panel_manual_edit:addChild(self.button_save)
        self:addChild(self.panel_manual_edit)
        self.group = SSGM:Get(SSM:Get(0):getGroupID())
        if self.area_name == "Bounds" then
            self.textbox_x1:setText(tostring(self.group.Bounds[1]))
            self.textbox_y1:setText(tostring(self.group.Bounds[2]))
            self.textbox_x2:setText(tostring(self.group.Bounds[3]))
            self.textbox_y2:setText(tostring(self.group.Bounds[4]))
            self.textbox_z:setText(tostring(self.group.Bounds[5]))
        else
            self.textbox_x1:setText(tostring(self.group.GroupAreas[self.area_name][1]))
            self.textbox_y1:setText(tostring(self.group.GroupAreas[self.area_name][2]))
            self.textbox_x2:setText(tostring(self.group.GroupAreas[self.area_name][3]))
            self.textbox_y2:setText(tostring(self.group.GroupAreas[self.area_name][4]))
            self.textbox_z:setText(tostring(self.group.GroupAreas[self.area_name][5]))
        end
    end
end

function PanelBaseInfo:on_click_close()
    self:removeFromUIManager()
end

function PanelBaseInfo:createChildren()
    local context_area_name = (self.area_name == "Bounds") and "BaseArea" or self.area_name
    --self.panel_header = ISButton:new(0, 0, self.width, 25, getText("ContextMenu_SS_"..context_area_name), nil, nil)
    self.panel_header = PanelHeader:new(getText("ContextMenu_SS_"..context_area_name), self)
    self.text_z = ISLabel:new(8, self.panel_header.height+8, 25, "z: 1", 1, 1, 1, 1, nil, true)
    self.text_x1 = ISLabel:new(8, (self.panel_header.height*2)+(8*2), 25, "x1: 9122", 1, 1, 1, 1, nil, true)
    self.text_y1 = ISLabel:new(8, (self.panel_header.height*3)+(8*3), 25, "y1: 9182", 1, 1, 1, 1, nil, true)
    self.text_x2 = ISLabel:new(8, (self.panel_header.height*4)+(8*4), 25, "x2: 9182", 1, 1, 1, 1, nil, true)
    self.text_y2 = ISLabel:new(8, (self.panel_header.height*5)+(8*5), 25, "y2: 8981", 1, 1, 1, 1, nil, true)
    self.button_select_area = ISButton:new(self.width-8-100,self.panel_header.height+8, 100, 25, "select area", nil, function() self:on_click_select_area() end)
    self.button_set = ISButton:new(self.width-8-100,(self.panel_header.height*2)+(8*2), 100, 25, "set", nil, function() self:on_click_set() end)
    self.button_cancel = ISButton:new(self.width-8-100,(self.panel_header.height*3)+(8*3), 100, 25, "cancel", nil, function() self:on_click_cancel() end)
    self.button_clear = ISButton:new(self.width-8-100,(self.panel_header.height*4)+(8*4), 100, 25, "clear", nil, function() self:on_click_clear() end)
    self.button_manual_edit = ISButton:new(self.width-8-100,(self.panel_header.height*5)+(8*5), 100, 25, "manual edit", nil, function() self:on_click_manual() end)
    self.button_close = ISButton:new(8,(self.panel_header.height*6)+(8*6), self.width-16, 25, "close", nil, function() self:on_click_close() end)
    --self.panel_header.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    --self.panel_header.onMouseDown = function() return  end
    --self.panel_header.backgroundColorMouseOver = self.panel_header.backgroundColor
    self.button_select_area.borderColor = { r = 1, g = 1, b = 1, a = 0.26 }
    self.button_set.borderColor = { r = 1, g = 1, b = 1, a = 0.26 }
    self.button_cancel.borderColor = { r = 1, g = 1, b = 1, a = 0.26 }
    self.button_clear.borderColor = { r = 1, g = 1, b = 1, a = 0.26 }
    self.button_manual_edit.borderColor = { r = 1, g = 1, b = 1, a = 0.26 }
    self.button_close.borderColor = { r = 1, g = 1, b = 1, a = 0.26 }
    self:addChild(self.panel_header)
    self:addChild(self.text_z)
    self:addChild(self.text_x1)
    self:addChild(self.text_y1)
    self:addChild(self.text_x2)
    self:addChild(self.text_y2)
    self:addChild(self.button_select_area)
    self:addChild(self.button_set)
    self:addChild(self.button_cancel)
    self:addChild(self.button_clear)
    self:addChild(self.button_manual_edit)
    self:addChild(self.button_close)
    self:dupdate()
end

function PanelBaseInfo:onMouseMove(dx, dy)
    self.mouseOver = true
    if self.moving then
        self:setX(self.x+dx)
        self:setY(self.y+dy)
        self:bringToTop()
    end
end

function PanelBaseInfo:onMouseMoveOutside(dx, dy)
    self.mouseOver = false
    if self.moving then
        self:setX(self.x+dx)
        self:setY(self.y+dy)
        self:bringToTop()
    end
end

function PanelBaseInfo:onMouseUp(_, _)
    if not self:getIsVisible() then
        return
    end
    self.moving = false
    ISMouseDrag.dragView = nil
end

function PanelBaseInfo:onMouseUpOutside(_, _)
    if not self:getIsVisible() then
        return
    end
    self.moving = false
    ISMouseDrag.dragView = nil
end

function PanelBaseInfo:onMouseDown(x, y)
    if not self:getIsVisible() then
        return
    end
    self.downX = x
    self.downY = y
    self.moving = true
    self:bringToTop()
end

function PanelBaseInfo:new(x, y, width, height, area_name)
    local o = {}
    o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0.7}
    o.manual_editing = false
    o.area_name = tostring(area_name)
    o.set_state = false
    return o
end

--****************************************************
-- Debugging
--****************************************************
dssbp = { file = "SuperSurvivorBasePanel.lua" }

function dssbp.dfile()
    for _, _ in nil do
        -- Triggers a break to automatically open
        -- this file in the debug window.
    end
end

--****************************************************
-- TODO: base editing
--****************************************************
-- Display cell grid in area selection.