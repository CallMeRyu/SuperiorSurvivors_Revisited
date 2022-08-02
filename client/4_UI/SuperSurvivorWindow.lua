local window_height = (30*10)+20+44+2
local window_width = 850
local panel_height = 30*10
local context_options = {}
local survivor_headers = {}
survivor_panels = {}

base_area_visibility = {
    ["Bounds"] = { area_shown = false, group_id = nil, button_title = "show" },
    ["ChopTreeArea"] = { area_shown = false, group_id = nil, button_title = "show" },
    ["TakeCorpseArea"] = { area_shown = false, group_id = nil, button_title = "show" },
    ["TakeWoodArea"] = { area_shown = false, group_id = nil, button_title = "show" },
    ["FarmingArea"] = { area_shown = false, group_id = nil, button_title = "show" },
    ["ForageArea"] = { area_shown = false, group_id = nil, button_title = "show" },
    ["CorpseStorageArea"] = { area_shown = false, group_id = nil, button_title = "show" },
    ["FoodStorageArea"] = { area_shown = false, group_id = nil, button_title = "show" },
    ["WoodStorageArea"] = { area_shown = false, group_id = nil, button_title = "show" },
    ["ToolStorageArea"] = { area_shown = false, group_id = nil, button_title = "show" },
    ["WeaponStorageArea"] = { area_shown = false, group_id = nil, button_title = "show" },
    ["MedicalStorageArea"] = { area_shown = false, group_id = nil, button_title = "show" },
    ["GuardArea"] = { area_shown = false, group_id = nil, button_title = "show" }
}

--****************************************************
-- PanelGroup
--****************************************************
local PanelGroup = ISPanel:new(0, 14+1+25+3, window_width, panel_height)
table.insert(survivor_panels, 1, PanelGroup)

function PanelGroup:dupdate()
    self:clearChildren()
    local dy = 0
    local switch = 0
    local group = get_group()
    local group_members = group:getMembers()
    for i=1, #group_members do
        local name, role = get_member_info(i)
        if role == "IGUI_SS_Job_Leader" then role = getContextMenuText("Job_Leader") end
        local panel_entry = ISPanel:new(0, dy, 850, 30)
        panel_entry.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
        panel_entry.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        panel_entry.dwidth = 850/2
        local cat_member_name = ISButton:new(0, 0, panel_entry.dwidth, 30, tostring(name), nil, function() context_options.show_context_menu_member(i) end)
        local cat_member_role = ISButton:new(panel_entry.dwidth, 0, panel_entry.dwidth, 30, tostring(role), nil, function() context_options.show_context_menu_role(i) end)
        cat_member_name.borderColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_member_role.borderColor = { r = 0, g = 0, b = 0, a = 0 }
        if switch == 0 then
            cat_member_name.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
            cat_member_role.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
            switch = 1
        else
            cat_member_name.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
            cat_member_role.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
            switch = 0
        end
        panel_entry:addChild(cat_member_name)
        panel_entry:addChild(cat_member_role)
        self:addChild(panel_entry)
        dy = dy+30
    end
    self:addScrollBars()
    self:setScrollWithParent(false)
    self:setScrollChildren(true)
    self:setScrollHeight(30*#group_members)
end

function PanelGroup:prerender()
    self:setStencilRect(0, 0, self.width, self.height)
    if self.background then
        self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    end
    if self.border then
        self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    end
end

function PanelGroup:render()
    self:clearStencilRect()
end

function PanelGroup:onMouseWheel(dir)
    dir = dir*-1
    dir = (self:getScrollHeight()/50)*dir
    dir = self:getYScroll()+dir
    self:setYScroll(dir)
    return true
end

--****************************************************
-- PanelBase
--****************************************************
local PanelBase = ISPanel:new(0, 14+1+25+3, window_width, panel_height)
PanelBase:setVisible(false)
table.insert(survivor_panels, 2, PanelBase)

-- PanelBaseEntry
local PanelBaseEntry = ISPanel:derive("PanelBaseEntry")

function PanelBaseEntry:initialize()
    ISCollapsableWindow.initialise(self)
end

function is_area_set(area_name)
    local group = get_group()
    local sum = 0
    if area_name == "Bounds" then
        for _, j in ipairs(group.Bounds) do
            sum = sum+j
        end
    else
        for _, j in ipairs(group.GroupAreas[area_name]) do
            sum = sum+j
        end
    end
    return (sum ~= 0) and true or false
end

function PanelBaseEntry:createChildren()
    local context_area_name = (self.area_name == "Bounds") and "BaseArea" or self.area_name
    local cat_area_name = ISButton:new(1, 0, self.dwidth, 30, getText("ContextMenu_SS_"..context_area_name), nil, function() print(self.area_name) end)
    local cat_area_set = ISButton:new(self.dwidth+1, 0, self.dwidth, 30, self.area_set, nil, nil)
    local cat_area_show = ISButton:new(self.dwidth*2, 0, self.dwidth, 30, base_area_visibility[self.area_name].button_title, nil, function() on_click_base_show(self.group_id, self.area_name) end)
    local cat_area_edit = ISButton:new(self.dwidth*3, 0, self.dwidth, 30, "edit", nil, function() create_panel_base_info(self.area_name) end)
    cat_area_name.onMouseDown = function() return end
    cat_area_set.onMouseDown = function() return  end
    cat_area_name.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    cat_area_set.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    cat_area_show.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    cat_area_edit.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    cat_area_show.enable = is_area_set(self.area_name)
    if self.switch == 0 then
        cat_area_name.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
        cat_area_set.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
        cat_area_show.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
        cat_area_edit.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
        cat_area_set.backgroundColorMouseOver = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
        cat_area_name.backgroundColorMouseOver = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
    else
        cat_area_name.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_area_set.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_area_show.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_area_edit.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_area_set.backgroundColorMouseOver = { r = 0, g = 0, b = 0, a = 0 }
        cat_area_name.backgroundColorMouseOver = { r = 0, g = 0, b = 0, a = 0 }
    end
    self:addChild(cat_area_name)
    self:addChild(cat_area_set)
    self:addChild(cat_area_show)
    self:addChild(cat_area_edit)
end

function PanelBaseEntry:new(x, y, width, height, area_name, area_set, area_show, switch, group_id)
    local o = {}
    o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
    o.dwidth = 850/4
    o.area_name = area_name
    o.area_set = area_set
    o.area_show = area_show
    o.switch = switch
    o.group_id = group_id
    return o
end

function PanelBase:dupdate()
    self:clearChildren()
    local dy = 0
    local switch = 0
    local group_id = SSM:Get(0):getGroupID()
    local group = get_group()
    -- bounds area
    local base_set = (is_area_set("Bounds")) and "set" or "not set"
    local panel_entry_base = PanelBaseEntry:new(0, dy, window_width, 30, "Bounds", base_set, base_area_visibility["Bounds"].button_title, switch, group_id)
    switch = (switch == 0) and 1 or 0
    self:addChild(panel_entry_base)
    dy = dy+30
    -- group areas
    local area_count = 1
    for area_name, _ in pairs(group.GroupAreas) do
        local area_set = (is_area_set(tostring(area_name))) and "set" or "not set"
        local panel_entry_area = PanelBaseEntry:new(0, dy, window_width, 30, tostring(area_name), area_set, base_area_visibility[tostring(area_name)].button_title, switch, group_id)
        switch = (switch == 0) and 1 or 0
        self:addChild(panel_entry_area)
        dy = dy+30
        area_count = area_count+1
    end
    self:addScrollBars()
    self:setScrollWithParent(false)
    self:setScrollChildren(true)
    self:setScrollHeight(30*area_count)
end

function PanelBase:prerender()
    self:setStencilRect(0, 0, self.width, self.height)
    if self.background then
        self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    end
    if self.border then
        self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    end
end

function PanelBase:render()
    self:clearStencilRect()
end

function PanelBase:onMouseWheel(dir)
    dir = dir*-1
    dir = (self:getScrollHeight()/50)*dir
    dir = self:getYScroll()+dir
    self:setYScroll(dir)
    return true
end

--****************************************************
-- PanelCompanions
--****************************************************
local PanelCompanions = ISPanel:new(0, 14+1+25+3, window_width, panel_height)
PanelCompanions:setVisible(false)
table.insert(survivor_panels, 3, PanelCompanions)

function PanelCompanions:dupdate()
    self:clearChildren()
    local dy = 0
    local switch = 0
    local group = get_group()
    local group_members = group:getMembers()
    local companion_count = 0
    for i=1, #group_members do
        local name, role, _, ai_mode = get_member_info(i)
        local panel_entry = ISPanel:new(0, dy, 850, 30)
        panel_entry.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
        panel_entry.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        panel_entry.dwidth = 850/4
        local cat_companion_name = ISButton:new(1, 0, panel_entry.dwidth, 30, tostring(name), nil, function() context_options.show_context_menu_member(i) end)
        local cat_companion_task = ISButton:new(panel_entry.dwidth+1, 0, panel_entry.dwidth, 30, tostring(ai_mode), nil, nil)
        local cat_companion_order = ISButton:new(panel_entry.dwidth*2, 0, panel_entry.dwidth, 30, "order", nil, function() context_options.show_context_menu_order(i) end)
        local cat_companion_call = ISButton:new(panel_entry.dwidth*3, 0, panel_entry.dwidth, 30, "call", nil, function() on_click_companion_call(i) end)
        cat_companion_task.onMouseDown = function() return end
        cat_companion_name.borderColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_companion_task.borderColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_companion_order.borderColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_companion_call.borderColor = { r = 0, g = 0, b = 0, a = 0 }
        if role == "Companion" then
            companion_count = companion_count+1
            if switch == 0 then
                cat_companion_name.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
                cat_companion_task.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
                cat_companion_order.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
                cat_companion_call.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
                cat_companion_task.backgroundColorMouseOver = { r = 0.25, g = 0.31, b = 0.37, a = 0.3 }
                switch = 1
            else
                cat_companion_name.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
                cat_companion_task.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
                cat_companion_order.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
                cat_companion_call.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
                cat_companion_task.backgroundColorMouseOver = { r = 0, g = 0, b = 0, a = 0 }
                switch = 0
            end
            panel_entry:addChild(cat_companion_name)
            panel_entry:addChild(cat_companion_task)
            panel_entry:addChild(cat_companion_order)
            panel_entry:addChild(cat_companion_call)
            self:addChild(panel_entry)
            dy = dy+30
        end
    end
    self:addScrollBars()
    self:setScrollWithParent(false)
    self:setScrollChildren(true)
    self:setScrollHeight(30*companion_count)
end

function PanelCompanions:prerender()
    self:setStencilRect(0, 0, self.width, self.height)
    if self.background then
        self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    end
    if self.border then
        self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    end
end

function PanelCompanions:render()
    self:clearStencilRect()
end

function PanelCompanions:onMouseWheel(dir)
    dir = dir*-1
    dir = (self:getScrollHeight()/50)*dir
    dir = self:getYScroll()+dir
    self:setYScroll(dir)
    return true
end

--****************************************************
-- WindowSuperSurvivors
--****************************************************
local WindowSuperSurvivors = ISCollapsableWindow:derive("WindowSuperSurvivors")

function window_super_survivors_visibility()
    window_super_survivors:setVisible(not window_super_survivors:isVisible())
end

function remove_window_super_survivors()
    window_super_survivors:removeFromUIManager()
end

function create_window_super_survivors()
    window_super_survivors = WindowSuperSurvivors:new(200, 100, window_width, window_height)
    window_super_survivors:addToUIManager()
    window_super_survivors:setVisible(false)
    window_super_survivors.pin = true
end

function WindowSuperSurvivors:initialize()
    ISCollapsableWindow.initialise(self)
end

function WindowSuperSurvivors:createChildren()
    self.y_pos = 14+3
    self.tab_width = self.width/3
    self.tab_height = 20
    ISCollapsableWindow.createChildren(self)
    -- headers group
    self.headers_group = ISPanel:new(0, self.y_pos, self.width, 25)
    table.insert(survivor_headers, 1, self.headers_group)
    self.headers_group_width = self.width/2
    self.headers_group_name = ISButton:new(1, 0, self.headers_group_width, 25, "Name", nil, nil)
    self.headers_group_status = ISButton:new(self.headers_group_width-1, 0, self.headers_group_width, 25, "Role", nil, nil)
    self.headers_group_name.onMouseDown = function() return  end
    self.headers_group_status.onMouseDown = function() return  end
    self.headers_group_name.backgroundColorMouseOver = self.headers_group_name.backgroundColor
    self.headers_group_status.backgroundColorMouseOver = self.headers_group_status.backgroundColor
    self:addChild(self.headers_group)
    self.headers_group:addChild(self.headers_group_name)
    self.headers_group:addChild(self.headers_group_status)
    -- headers base
    self.headers_base = ISPanel:new(0, self.y_pos, self.width, 25)
    self.headers_base:setVisible(false)
    table.insert(survivor_headers, 1, self.headers_base)
    self.headers_base_width = self.width/4
    self.headers_base_area = ISButton:new(1, 0, self.headers_base_width, 25, "Area", nil, nil)
    self.headers_base_status = ISButton:new(self.headers_base_width+1, 0, self.headers_base_width, 25, "Set", nil, nil)
    self.headers_base_show = ISButton:new(self.headers_base_width*2, 0, self.headers_base_width, 25, "Show", nil, nil)
    self.headers_base_modify = ISButton:new(self.headers_base_width*3, 0, self.headers_base_width, 25, "Modify", nil, nil)
    self.headers_base_area.onMouseDown = function() return  end
    self.headers_base_status.onMouseDown = function() return  end
    self.headers_base_show.onMouseDown = function() return  end
    self.headers_base_modify.onMouseDown = function() return  end
    self.headers_base_area.backgroundColorMouseOver = self.headers_base_area.backgroundColor
    self.headers_base_status.backgroundColorMouseOver = self.headers_base_status.backgroundColor
    self.headers_base_show.backgroundColorMouseOver = self.headers_base_show.backgroundColor
    self.headers_base_modify.backgroundColorMouseOver = self.headers_base_modify.backgroundColor
    self:addChild(self.headers_base)
    self.headers_base:addChild(self.headers_base_area)
    self.headers_base:addChild(self.headers_base_status)
    self.headers_base:addChild(self.headers_base_show)
    self.headers_base:addChild(self.headers_base_modify)
    -- headers companions
    self.headers_companions = ISPanel:new(0, self.y_pos, self.width, 25)
    self.headers_companions:setVisible(false)
    table.insert(survivor_headers, 1, self.headers_companions)
    self.headers_companions_width = self.width/4
    self.headers_companions_name = ISButton:new(1, 0, self.headers_companions_width, 25, "Name", nil, nil)
    self.headers_companions_task = ISButton:new(self.headers_companions_width+1, 0, self.headers_companions_width, 25, "Task", nil, nil)
    self.headers_companions_command = ISButton:new(self.headers_companions_width*2, 0, self.headers_companions_width, 25, "Command", nil, nil)
    self.headers_companions_call = ISButton:new(self.headers_companions_width*3, 0, self.headers_companions_width, 25, "Call", nil, nil)
    self.headers_companions_name.onMouseDown = function() return  end
    self.headers_companions_task.onMouseDown = function() return  end
    self.headers_companions_command.onMouseDown = function() return  end
    self.headers_base_modify.onMouseDown = function() return  end
    self.headers_companions_name.backgroundColorMouseOver = self.headers_companions_name.backgroundColor
    self.headers_companions_task.backgroundColorMouseOver = self.headers_companions_task.backgroundColor
    self.headers_companions_command.backgroundColorMouseOver = self.headers_companions_command.backgroundColor
    self.headers_companions_call.backgroundColorMouseOver = self.headers_companions_call.backgroundColor
    self:addChild(self.headers_companions)
    self.headers_companions:addChild(self.headers_companions_name)
    self.headers_companions:addChild(self.headers_companions_task)
    self.headers_companions:addChild(self.headers_companions_command)
    self.headers_companions:addChild(self.headers_companions_call)
    -- panels
    self:addChild(PanelGroup)
    self:addChild(PanelBase)
    self:addChild(PanelCompanions)
    -- tabs
    self.tabs = ISPanel:new(0, self.height-25+3, 846, self.tab_height)
    self.tab_group = ISButton:new(0, 0, self.tab_width, self.tab_height, "Group", nil, function() on_click_tab(self.headers_group, PanelGroup) end)
    self.tab_base = ISButton:new(self.tab_width, 0, self.tab_width, self.tab_height, "Base", nil, function() on_click_tab(self.headers_base, PanelBase) end)
    self.tab_companions = ISButton:new(self.tab_width*2, 0, self.tab_width, self.tab_height, "Companions", nil, function() on_click_tab(self.headers_companions, PanelCompanions) end)
    self.tab_group.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    self.tab_base.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    self.tab_companions.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    self:addChild(self.tabs)
    self.tabs:addChild(self.tab_group)
    self.tabs:addChild(self.tab_companions)
    self.tabs:addChild(self.tab_base)
end

function WindowSuperSurvivors:new(x, y, width, height)
    local o = {}
    o = ISCollapsableWindow:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.title = "Super Survivors"
    o.pin = false
    o.resizable = false
    o.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0.7 }
    return o
end

--****************************************************
-- ButtonSuperSurvivors
--****************************************************
local ButtonSuperSurvivors = ISButton:derive("ButtonSuperSurvivors")
local ButtonReloadMenu = ISButton:derive("ButtonReloadMenu")

function remove_button_super_survivors()
    button_super_survivors:removeFromUIManager()
end

function create_button_super_survivors()
    button_super_survivors = ButtonSuperSurvivors:new(getCore():getScreenWidth()-(125+100+8), getCore():getScreenHeight()-50, 100, 25, "survivors", nil, function() window_super_survivors_visibility() end)
    button_super_survivors.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    button_super_survivors:setVisible(true)
    button_super_survivors:setEnable(true)
    button_super_survivors:addToUIManager()
end

function remove_button_reload_menu()
    button_reload_menu:removeFromUIManager()
end

function create_button_reload_menu()
    button_reload_menu = ButtonReloadMenu:new(getCore():getScreenWidth()-(100+25+8), getCore():getScreenHeight()-50, 25, 25, "!", nil, function() dssw.dbug() end)
    button_reload_menu.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    button_reload_menu:setVisible(true)
    button_reload_menu:setEnable(true)
    button_reload_menu:addToUIManager()
end

--****************************************************
-- Utility
--****************************************************
function on_click_base_show(group_id, area_name)
    base_area_visibility[area_name].group_id = group_id
    if base_area_visibility[area_name].area_shown then
        base_area_visibility[area_name].area_shown = false
        base_area_visibility[area_name].button_title = "show"
    else
        base_area_visibility[area_name].area_shown = true
        base_area_visibility[area_name].button_title = "hide"
    end
    survivor_panels[2]:dupdate()
end

function on_click_tab(target_headers, target_panel)
    for _, header in pairs(survivor_headers) do
        if header == target_headers then header:setVisible(true)
        else header:setVisible(false) end
    end
    for _, panel in pairs(survivor_panels) do
        if panel == target_panel then
            panel:setVisible(true)
            panel:dupdate()
        else panel:setVisible(false) end
    end
end

function on_click_companion_call(member_index)
    local group_id = SSM:Get(0):getGroupID()
    local group_members = SSGM:Get(group_id):getMembers()
    local member = group_members[member_index]
    if member then
        getSpecificPlayer(0):Say(getActionText("CallName_Before")..member:getName()..getActionText("CallName_After"))
        member:getTaskManager():AddToTop(ListenTask:new(member, getSpecificPlayer(0), false))
    end
end

context_options.show_context_menu_order = function(member_index)
    if member_index == 1 then return end
    local context_menu = ISContextMenu.get(0, getMouseX(), getMouseY(), 1, 1)
    context_menu:addOption("Barricade", nil, function() give_order(1, member_index) end)
    context_menu:addOption("Chop Wood", nil, function() give_order(2, member_index) end)
    context_menu:addOption("Clean Up Inventory", nil, function() give_order(3, member_index) end)
    context_menu:addOption("Doctor", nil, function() give_order(4, member_index) end)
    context_menu:addOption("Explore", nil, function() give_order(5, member_index) end)
    context_menu:addOption("Follow", nil, function() give_order(6, member_index) end)
    context_menu:addOption("Farming", nil, function() give_order(7, member_index) end)
    context_menu:addOption("Forage", nil, function() give_order(8, member_index) end)
    context_menu:addOption("Gather Wood", nil, function() give_order(9, member_index) end)
    context_menu:addOption("Go Find Food", nil, function() give_order(10, member_index) end)
    context_menu:addOption("Go Find Water", nil, function() give_order(11, member_index) end)
    context_menu:addOption("Go Find Weapon", nil, function() give_order(12, member_index) end)
    context_menu:addOption("Guard", nil, function() give_order(13, member_index) end)
    context_menu:addOption("Hold Still", nil, function() give_order(14, member_index) end)
    context_menu:addOption("Lock Doors", nil, function() give_order(15, member_index) end)
    context_menu:addOption("Unlock Doors", nil, function() give_order(16, member_index) end)
    context_menu:addOption("Loot Room", nil, function() give_order(17, member_index) end)
    context_menu:addOption("Patrol", nil, function() give_order(18, member_index) end)
    context_menu:addOption("Stand Ground", nil, function() give_order(19, member_index) end)
    context_menu:addOption("Stop", nil, function() give_order(20, member_index) end)
    context_menu:addOption("Dismiss", nil, function() give_order(21, member_index) end)
    context_menu:addOption("Relax", nil, function() give_order(22, member_index) end)
    context_menu:addOption("Return To Base", nil, function() give_order(23, member_index) end)
    context_menu:addOption("Pile Corpses", nil, function() give_order(24, member_index) end)
end

context_options.show_context_menu_role = function(member_index)
    if member_index == 1 then return end
    local group_id = SSM:Get(0):getGroupID()
    local group = SSGM:Get(group_id)
    local group_members = SSGM:Get(group_id):getMembers()
    local member = group_members[member_index]
    local context_menu = ISContextMenu.get(0, getMouseX(), getMouseY(), 1, 1)
    context_menu:addOption("Call", nil, function() on_click_companion_call(member_index)  end)
    local order = context_menu:addOption("Order", nil, nil)
    local sub_order = context_menu:getNew(context_menu)
    sub_order:addOption("Barricade", nil, function() give_order(1, member_index) end)
    sub_order:addOption("Chop Wood", nil, function() give_order(2, member_index) end)
    sub_order:addOption("Clean Up Inventory", nil, function() give_order(3, member_index) end)
    sub_order:addOption("Doctor", nil, function() give_order(4, member_index) end)
    sub_order:addOption("Explore", nil, function() give_order(5, member_index) end)
    sub_order:addOption("Follow", nil, function() give_order(6, member_index) end)
    sub_order:addOption("Farming", nil, function() give_order(7, member_index) end)
    sub_order:addOption("Forage", nil, function() give_order(8, member_index) end)
    sub_order:addOption("Gather Wood", nil, function() give_order(9, member_index) end)
    sub_order:addOption("Go Find Food", nil, function() give_order(10, member_index) end)
    sub_order:addOption("Go Find Water", nil, function() give_order(11, member_index) end)
    sub_order:addOption("Go Find Weapon", nil, function() give_order(12, member_index) end)
    sub_order:addOption("Guard", nil, function() give_order(13, member_index) end)
    sub_order:addOption("Hold Still", nil, function() give_order(14, member_index) end)
    sub_order:addOption("Lock Doors", nil, function() give_order(15, member_index) end)
    sub_order:addOption("Unlock Doors", nil, function() give_order(16, member_index) end)
    sub_order:addOption("Loot Room", nil, function() give_order(17, member_index) end)
    sub_order:addOption("Patrol", nil, function() give_order(18, member_index) end)
    sub_order:addOption("Stand Ground", nil, function() give_order(19, member_index) end)
    sub_order:addOption("Stop", nil, function() give_order(20, member_index) end)
    sub_order:addOption("Dismiss", nil, function() give_order(21, member_index) end)
    sub_order:addOption("Relax", nil, function() give_order(22, member_index) end)
    sub_order:addOption("Return To Base", nil, function() give_order(23, member_index) end)
    sub_order:addOption("Pile Corpses", nil, function() give_order(24, member_index) end)
    context_menu:addSubMenu(order, sub_order)
    local remove = context_menu:addOption("Remove", nil, nil)
    local sub_remove = context_menu:getNew(context_menu)
    sub_remove:addOption("Confirm", nil, function() group:removeMember(member:getID()) end)
    context_menu:addSubMenu(remove, sub_remove)
end

context_options.show_context_menu_member = function(member_index)
    if member_index == 1 then return end
    local context_menu = ISContextMenu.get(0, getMouseX(), getMouseY(), 1, 1)
    context_menu:addOption("Information", nil, function() show_survivor_info(member_index)  end)
    context_menu:addOption("Inventory", nil, function() create_panel_inventory_transfer(member_index)  end)
end

--****************************************************
-- Events
--****************************************************
LuaEventManager.AddEvent("on_update_group_role")

function base_area_visibility.event_update_area_highlight()
    for area_name, _ in pairs(base_area_visibility) do
        if tostring(area_name) ~= "event_update_area_highlight" then
            if base_area_visibility[tostring(area_name)].area_shown and base_area_visibility[tostring(area_name)].group_id ~= nil then
                local group_id = base_area_visibility[tostring(area_name)].group_id
                local group = SSGM:Get(group_id)
                local coords = (tostring(area_name) == "Bounds") and group.Bounds or group.GroupAreas[area_name]
                local x1 = coords[1]
                local x2 = coords[2]
                local y1 = coords[3]
                local y2 = coords[4]
                for i=x1, x2 do
                    for j=y1, y2 do
                        local cell = getCell():getGridSquare(i, j, getSpecificPlayer(0):getZ())
                        if cell and cell:getFloor() then
                            cell:getFloor():setHighlightColor(area_colors[area_name].r, area_colors[area_name].g, area_colors[area_name].b, area_colors[area_name].a)
                            cell:getFloor():setHighlighted(true)
                        end
                    end
                end
            end
        end
    end
end
Events.OnRenderTick.Add(base_area_visibility.event_update_area_highlight)

function wrap_set_group_role(func)
    return function(...)
        LuaEventManager.triggerEvent("on_update_group_role")
        return func(...)
    end
end

function wrap_survivor_order(func)
    return function(...)
        LuaEventManager.triggerEvent("on_update_group_role")
        return func(...)
    end
end

function event_set_group_role()
    if window_super_survivors:isVisible() then
        print("event_set_group_role()")
        survivor_panels[1]:dupdate()
        survivor_panels[3]:dupdate()
    end
end
Events.on_update_group_role.Add(event_set_group_role)

function event_update_group_role()
    if window_super_survivors:isVisible() then
        print("event_update_group_role()")
        survivor_panels[1]:dupdate()
        survivor_panels[3]:dupdate()
    end
end
Events.on_update_group_role.Add(event_update_group_role)

function event_every_minute()
    if window_super_survivors:isVisible() then
        --for _, panel in pairs(survivor_panels) do
        --    panel:dupdate()
        --end
        survivor_panels[1]:dupdate()
        survivor_panels[3]:dupdate()
    end
end
Events.EveryOneMinute.Add(event_every_minute)

--****************************************************
-- Debugging
--****************************************************
dssw = { file = "SuperSurvivorWindow.lua" }

function dssw.dfile()
    for _, _ in nil do
        -- Triggers a break to automatically open
        -- this file in the debug window.
    end
end

function dssw.dbug()
    print("=================")
    print("dssw::dbug")
    remove_window_super_survivors()
    print("remove_window_super_survivors()")
    create_window_super_survivors()
    print("create_window_super_survivors()")
    print("=================")
end

--****************************************************
-- SuperSurvivorWindow entry point
--****************************************************
function super_survivor_window_entry_point()
    create_window_super_survivors()
    create_button_super_survivors()
    create_button_reload_menu()
    --SuperSurvivor.setGroupRole = wrap_set_group_role(SuperSurvivor.setGroupRole)
    --SurvivorOrder = wrap_survivor_order(SurvivorOrder)
end
Events.OnGameStart.Add(super_survivor_window_entry_point)