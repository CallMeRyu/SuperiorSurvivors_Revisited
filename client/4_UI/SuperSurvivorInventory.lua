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

function TitleBar:new(x, width, title, parent)
    local o = {}
    o = ISButton:new(x, 0, width, 25)
    setmetatable(o, self)
    self.__index = self
    o.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    o.title = title
    o.parent = parent
    return o
end

--****************************************************
-- InventoryRow
--****************************************************
local InventoryRow = ISPanel:derive("InventoryRow")
local panels = {}

function InventoryRow:initialize()
    ISCollapsableWindow.initialise(self)
end

function InventoryRow:on_click_transfer(direction)
    -- > player to member
    -- < member to player
    local item_id = self.item:getID()
    local member = SSGM:Get(SSM:Get(0):getGroupID()):getMembers()[self.member_index]
    local member_inventory = member.player:getInventory()
    local player_inventory = getPlayerInventory(0).inventory
    if direction == ">" then
        if self.item:isEquipped() then
            ISTimedActionQueue.add(ISUnequipAction:new(getSpecificPlayer(0), self.item, 1))
        end
        player_inventory:removeItemWithID(item_id)
        --member_inventory:addItem(self.item:getFullType())
        member_inventory:addItem(self.item)
    else
        if self.item:isEquipped() then
            ISTimedActionQueue.add(ISUnequipAction:new(member.player, self.item, 1))
        end
        member_inventory:removeItemWithID(item_id)
        --player_inventory:addItem(self.item:getFullType())
        player_inventory:addItem(self.item)
    end
    panels[1]:dupdate()
    panels[2]:dupdate()
end

function InventoryRow:update_tooltip()
    if self.item then
        if self.tool_render then
            self.tool_render:setItem(self.item)
            self.tool_render:setVisible(true)
            self.tool_render:addToUIManager()
            self.tool_render:bringToTop()
        else
            self.tool_render = ISToolTipInv:new(self.item)
            self.tool_render:initialise()
            self.tool_render:addToUIManager()
            self.tool_render:setVisible(true)
            self.tool_render:setOwner(self)
        end
        self.tool_render.followMouse = not self.doController
    elseif self.tool_render then
        self.tool_render:removeFromUIManager()
        self.tool_render:setVisible(false)
    end
end

function InventoryRow:onMouseMove(_, _)
    self.mouseOver = self:isMouseOver()
    self:update_tooltip()
end

function InventoryRow:onMouseMoveOutside(dx, dy)
    self.mouseOver = false;
    if self.onmouseoutfunction then
        self.onmouseoutfunction(self.target, self, dx, dy);
    end
    if self.tool_render then
        self.tool_render:removeFromUIManager()
        self.tool_render:setVisible(false)
    end
end

function InventoryRow:createChildren()
    local cat_icon = ISButton:new(0, 0, 25, 25, "", nil, nil)
    local cat_item = ISButton:new(25, 0, 250, 25, tostring(self.item:getName()), nil, nil)
    local cat_type = ISButton:new(25+250, 0, 150, 25, tostring(self.item:getCategory()), nil, nil)
    local cat_transfer = ISButton:new(25+250+150, 0, 50, 25, self.direction, nil, function() self:on_click_transfer(self.direction) end)
    cat_icon:setImage(self.item:getTex())
    cat_icon:forceImageSize(25, 25)
    cat_icon.onMouseDown = function() return  end
    cat_item.onMouseDown = function() return  end
    cat_type.onMouseDown = function() return  end
    cat_icon.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    cat_item.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    cat_type.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    cat_transfer.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    if self.switch == 0 then
        cat_icon.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        cat_item.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        cat_type.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        cat_transfer.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        cat_icon.backgroundColorMouseOver = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        cat_item.backgroundColorMouseOver = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        cat_type.backgroundColorMouseOver = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
    else
        cat_icon.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_item.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_type.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_transfer.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_icon.backgroundColorMouseOver = { r = 0, g = 0, b = 0, a = 0 }
        cat_item.backgroundColorMouseOver = { r = 0, g = 0, b = 0, a = 0 }
        cat_type.backgroundColorMouseOver = { r = 0, g = 0, b = 0, a = 0 }
    end
    self:addChild(cat_icon)
    self:addChild(cat_item)
    self:addChild(cat_type)
    self:addChild(cat_transfer)
end

function InventoryRow:new(y, width, height, item, direction, switch)
    local o = {}
    o = ISPanel:new(0, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
    o.switch = switch
    o.item = item
    o.direction = direction
    return o
end

--****************************************************
-- PanelMemberInventory
--****************************************************
local PanelMemberInventory = ISPanel:new(475, 25+2, 475, ((25*10)+(8*7))-(50+8*2))
table.insert(panels, 1, PanelMemberInventory)

function PanelMemberInventory:dupdate()
    self:clearChildren()
    local dy = 0
    local switch = 0
    local member = SSGM:Get(SSM:Get(0):getGroupID()):getMembers()[self.member_index]
    local items = member.player:getInventory():getItems()
    local scroll_height = 0
    for i=0, items:size()-1 do
        local item = items:get(i)
        local inventory_row = InventoryRow:new(dy, self.width, 25, item, "<", switch)
        switch = (switch == 0) and 1 or 0
        self:addChild(inventory_row)
        dy = dy+25
        scroll_height = scroll_height+1
    end
    self:addScrollBars()
    self:setScrollWithParent(false)
    self:setScrollChildren(true)
    self:setScrollHeight((25*scroll_height)+4)
end

function PanelMemberInventory:prerender()
    self:setStencilRect(0, 0, self.width, self.height)
    if self.background then
        self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    end
    if self.border then
        self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    end
end

function PanelMemberInventory:render()
    self:clearStencilRect()
end

function PanelMemberInventory:onMouseWheel(dir)
    dir = dir*-1
    dir = (self:getScrollHeight()/50)*dir
    dir = self:getYScroll()+dir
    self:setYScroll(dir)
    return true
end

--****************************************************
-- PanelOwnInventory
--****************************************************
local PanelOwnInventory = ISPanel:new(0, 25+2, 475, ((25*10)+(8*7))-(50+8*2))
table.insert(panels, 1, PanelOwnInventory)

function PanelOwnInventory:dupdate()
    self:clearChildren()
    local dy = 0
    local switch = 0
    local items = getPlayerInventory(0).inventory:getItems()
    local scroll_height = 0
    for i=0, items:size()-1 do
        local item = items:get(i)
        local inventory_row = InventoryRow:new(dy, self.width, 25, item, ">", switch)
        switch = (switch == 0) and 1 or 0
        self:addChild(inventory_row)
        dy = dy+25
        scroll_height = scroll_height+1
    end
    self:addScrollBars()
    self:setScrollWithParent(false)
    self:setScrollChildren(true)
    self:setScrollHeight((25*scroll_height)+4)
end

function PanelOwnInventory:prerender()
    self:setStencilRect(0, 0, self.width, self.height)
    if self.background then
        self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    end
    if self.border then
        self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    end
end

function PanelOwnInventory:render()
    self:clearStencilRect()
end

function PanelOwnInventory:onMouseWheel(dir)
    dir = dir*-1
    dir = (self:getScrollHeight()/50)*dir
    dir = self:getYScroll()+dir
    self:setYScroll(dir)
    return true
end

--****************************************************
-- PanelInventoryTransfer
--****************************************************
PanelInventoryTransfer = ISPanel:derive("PanelInventoryTransfer")

function create_panel_inventory_transfer(member_index)
    if panel_inventory_transfer then
        panel_inventory_transfer:removeFromUIManager()
        panel_inventory_transfer = nil
    end
    panel_inventory_transfer = PanelInventoryTransfer:new(window_super_survivors.x, window_super_survivors.y+window_super_survivors.height+8, 475*2, (25*10)+(8*5), member_index)
    panel_inventory_transfer:addToUIManager()
    panel_inventory_transfer:setVisible(true)
end

function PanelInventoryTransfer:initialise()
    ISPanel.initialise(self)
end

function PanelInventoryTransfer:createChildren()
    self:clearChildren()
    local member = SSGM:Get(SSM:Get(0):getGroupID()):getMembers()[self.member_index]
    local member_inventory = member.player:getInventory()
    local player_inventory = getPlayerInventory(0).inventory
    self.header_player = TitleBar:new(
            0,
            self.width/2,
            tostring(getPlayer():getDisplayName()).."    ["..string.format("%.2f", player_inventory:getCapacityWeight()).." / "..string.format("%.2f", player_inventory:getContentsWeight()).."]",
            self
    )
    self.header_member = TitleBar:new(
            self.width/2,
            self.width/2,
            tostring(member:getName()).."    ["..string.format("%.2f", member_inventory:getCapacityWeight()).." / "..string.format("%.2f", member_inventory:getContentsWeight()).."]",
            self
    )
    local button_close = ISButton:new(0, self.height-25, self.width, 25, "close", nil, function() self:removeFromUIManager() end)
    InventoryRow.member_index = self.member_index
    PanelOwnInventory.member_index = self.member_index
    PanelMemberInventory.member_index = self.member_index
    self:addChild(self.header_player)
    self:addChild(self.header_member)
    self:addChild(PanelOwnInventory)
    self:addChild(PanelMemberInventory)
    self:addChild(button_close)
    PanelOwnInventory:dupdate()
    PanelMemberInventory:dupdate()
end

function PanelInventoryTransfer:onMouseMove(dx, dy)
    self.mouseOver = true
    if self.moving then
        self:setX(self.x+dx)
        self:setY(self.y+dy)
        self:bringToTop()
    end
end

function PanelInventoryTransfer:onMouseMoveOutside(dx, dy)
    self.mouseOver = false
    if self.moving then
        self:setX(self.x+dx)
        self:setY(self.y+dy)
        self:bringToTop()
    end
end

function PanelInventoryTransfer:onMouseUp(_, _)
    if not self:getIsVisible() then
        return
    end
    self.moving = false
    ISMouseDrag.dragView = nil
end

function PanelInventoryTransfer:onMouseUpOutside(_, _)
    if not self:getIsVisible() then
        return
    end
    self.moving = false
    ISMouseDrag.dragView = nil
end

function PanelInventoryTransfer:onMouseDown(x, y)
    if not self:getIsVisible() then
        return
    end
    self.downX = x
    self.downY = y
    self.moving = true
    self:bringToTop()
end

function PanelInventoryTransfer:new(x, y, width, height, member_index)
    local o = {}
    o = ISPanel:new(x, y, width, height)
    setmetatable(o, self)
    self.__index = self
    o.borderColor = { r = 1, g = 1, b = 1, a = 0.2 }
    o.backgroundColor = { r = 0, g = 0, b = 0, a = 0.7 }
    o.member_index = member_index
    return o
end

--****************************************************
-- Debugging
--****************************************************
dssi = { file = "SuperSurvivorInventory.lua" }

function dssi.dfile()
    for _, _ in nil do
        -- Triggers a break to automatically open
        -- this file in the debug window.
    end
end