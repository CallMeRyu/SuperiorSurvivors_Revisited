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
-- InventoryRow
--****************************************************
local InventoryRow = ISPanel:derive("InventoryRow")
local panels = {}

function InventoryRow:initialize()
    ISCollapsableWindow.initialise(self)
end

function InventoryRow:on_click_transfer(direction)
    -- v unequip
    -- ^ equip
    local member = SSGM:Get(SSM:Get(0):getGroupID()):getMembers()[self.member_index]
    if direction == "v" then
        if self.item:isEquipped() then
            ISTimedActionQueue.add(ISUnequipAction:new(member.player, self.item, 1))
        end
    else
        if instanceof(self.item, "InventoryContainer") and self.item:canBeEquipped() ~= "" then
            member.player:setClothingItem_Back(self.item)
            getPlayerData(member.player:getPlayerNum()).playerInventory:refreshBackpacks()
        elseif self.item:getCategory() == "Weapon" then
            if self.item:getAmmoType() ~= nil then
                member:setGunWep(self.item)
                member:reEquipGun()
            else
                member:setMeleWep(self.item)
                member:reEquipMele()
            end
        else
            if self.item:getBodyLocation() ~= "" then
                member.player:setWornItem(self.item:getBodyLocation(), nil)
                member.player:setWornItem(self.item:getBodyLocation(), self.item)
            end
        end
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
    local spacer0 = ISButton:new(0, 0, 2, 25, "", nil, nil)
    local cat_icon = ISButton:new(spacer0.width, 0, 25, 25, "", nil, nil)
    local spacer1 = ISButton:new(cat_icon.x+cat_icon.width, 0, 2, 25, "", nil, nil)
    local cat_item = ISPanel:new(spacer1.x+spacer1.width, 0, 297-(spacer1.width*2)-10, 25)
    local cat_item_name = ISLabel:new(10, 0, 25, tostring(self.item:getName()), 1, 1, 1, 1, nil, true)
    cat_item:addChild(cat_item_name)
    local cat_transfer = ISButton:new(cat_item.x+cat_item.width, 0, 102, 25, self.direction == "v" and "unequip" or "equip", nil, function() self:on_click_transfer(self.direction) end)
    local spacer2 = ISButton:new(self.width-10, 0, 25, 25, "", nil, nil)
    cat_icon:setImage(self.item:getTex())
    cat_icon:forceImageSize(25, 25)
    cat_icon.onMouseDown = function() return  end
    spacer0.onMouseDown = function() return  end
    spacer1.onMouseDown = function() return  end
    spacer2.onMouseDown = function() return  end
    cat_icon.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    cat_item.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    spacer0.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    spacer1.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    spacer2.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    cat_transfer.borderColor = { r = 0, g = 0, b = 0, a = 0 }
    if self.switch == 0 then
        spacer0.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        cat_icon.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        spacer1.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        spacer2.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        cat_item.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        cat_transfer.backgroundColor = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        spacer0.backgroundColorMouseOver = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        cat_icon.backgroundColorMouseOver = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        spacer1.backgroundColorMouseOver = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
        spacer2.backgroundColorMouseOver = { r = 0.25, g = 0.31, b = 0.37, a = 0.23 }
    else
        spacer0.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_icon.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        spacer1.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        spacer2.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_item.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        cat_transfer.backgroundColor = { r = 0, g = 0, b = 0, a = 0 }
        spacer0.backgroundColorMouseOver = { r = 0, g = 0, b = 0, a = 0 }
        cat_icon.backgroundColorMouseOver = { r = 0, g = 0, b = 0, a = 0 }
        spacer1.backgroundColorMouseOver = { r = 0, g = 0, b = 0, a = 0 }
        spacer2.backgroundColorMouseOver = { r = 0, g = 0, b = 0, a = 0 }
    end
    self:addChild(spacer0)
    self:addChild(cat_icon)
    self:addChild(spacer1)
    self:addChild(cat_item)
    self:addChild(cat_transfer)
    self:addChild(spacer2)
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
-- PanelEquipableItems
--****************************************************
local PanelEquipableItems = ISPanel:new(0, ((25*2)+2)+(275/2)+(4+25), 426, 275/2)
table.insert(panels, 1, PanelEquipableItems)

function PanelEquipableItems:dupdate()
    self:clearChildren()
    local dy = 0
    local switch = 0
    local member = SSGM:Get(SSM:Get(0):getGroupID()):getMembers()[self.member_index]
    local items = member.player:getInventory():getItems()
    local scroll_height = 0
    for i=0, items:size()-1 do
        local item = items:get(i)
        if not item:isEquipped() and (item:getCategory() == "Clothing" or instanceof(item, "InventoryContainer") or item:getCategory() == "Weapon") then
            local inventory_row = InventoryRow:new(dy, self.width, 25, item, "^", switch)
            switch = (switch == 0) and 1 or 0
            self:addChild(inventory_row)
            dy = dy+25
            scroll_height = scroll_height+1
        end
    end
    self:addScrollBars()
    self:setScrollWithParent(false)
    self:setScrollChildren(true)
    self:setScrollHeight(25*scroll_height)
end

function PanelEquipableItems:prerender()
    self:setStencilRect(0, 0, self.width, self.height)
    if self.background then
        self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    end
    if self.border then
        self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    end
end

function PanelEquipableItems:render()
    self:clearStencilRect()
end

function PanelEquipableItems:onMouseWheel(dir)
    dir = dir*-1
    dir = (self:getScrollHeight()/20)*dir
    dir = self:getYScroll()+dir
    self:setYScroll(dir)
    return true
end

--****************************************************
-- PanelEquippedItems
--****************************************************
local PanelEquippedItems = ISPanel:new(0, (25*2)+2, 426, 275/2)
table.insert(panels, 1, PanelEquippedItems)

function PanelEquippedItems:dupdate()
    self:clearChildren()
    local dy = 0
    local switch = 0
    local member = SSGM:Get(SSM:Get(0):getGroupID()):getMembers()[self.member_index]
    local items = member.player:getInventory():getItems()
    local scroll_height = 0
    for i=0, items:size()-1 do
        local item = items:get(i)
        if item:isEquipped() then
            local inventory_row = InventoryRow:new(dy, self.width, 25, item, "v", switch)
            switch = (switch == 0) and 1 or 0
            self:addChild(inventory_row)
            dy = dy+25
            scroll_height = scroll_height+1
        end
    end
    self:addScrollBars()
    self:setScrollWithParent(false)
    self:setScrollChildren(true)
    self:setScrollHeight(25*scroll_height)
end

function PanelEquippedItems:prerender()
    self:setStencilRect(0, 0, self.width, self.height)
    if self.background then
        self:drawRectStatic(0, 0, self.width, self.height, self.backgroundColor.a, self.backgroundColor.r, self.backgroundColor.g, self.backgroundColor.b)
    end
    if self.border then
        self:drawRectBorderStatic(0, 0, self.width, self.height, self.borderColor.a, self.borderColor.r, self.borderColor.g, self.borderColor.b)
    end
end

function PanelEquippedItems:render()
    self:clearStencilRect()
end

function PanelEquippedItems:onMouseWheel(dir)
    dir = dir*-1
    dir = (self:getScrollHeight()/20)*dir
    dir = self:getYScroll()+dir
    self:setYScroll(dir)
    return true
end

--****************************************************
-- PanelLoadout
--****************************************************
PanelLoadout = ISPanel:derive("PanelLoadout")

function create_panel_loadout(member_index)
    if panel_loadout then
        panel_loadout:removeFromUIManager()
        panel_loadout = nil
    end
    panel_loadout = PanelLoadout:new(window_super_survivors.x+window_super_survivors.width+8, window_super_survivors.y, 426, 25*15+(3*2), member_index)
    panel_loadout:addToUIManager()
    panel_loadout:setVisible(true)
end

function PanelLoadout:initialise()
    ISPanel.initialise(self)
end

function PanelLoadout:createChildren()
    self:clearChildren()
    local member = SSGM:Get(SSM:Get(0):getGroupID()):getMembers()[self.member_index]
    self.header_member = TitleBar:new(tostring(member:getName()), self)
    local equipped_items = ISButton:new(0, 25, self.width, 25, "Equipped Items", nil, nil)
    local equipable_items = ISButton:new(0, (25*2)+(2+(275/2)+2), self.width, 25, "Equipable Items", nil, nil)
    local button_close = ISButton:new(0, self.height-25, self.width, 25, "close", nil, function() self:removeFromUIManager() end)
    equipped_items.onMouseDown = function() return  end
    equipable_items.onMouseDown = function() return  end
    equipped_items.backgroundColorMouseOver = equipped_items.backgroundColor
    equipable_items.backgroundColorMouseOver = equipable_items.backgroundColor
    equipped_items.borderColor = { r = 1, g = 1, b = 1, a = 0.35 }
    equipable_items.borderColor = { r = 1, g = 1, b = 1, a = 0.35 }
    InventoryRow.member_index = self.member_index
    PanelEquippedItems.member_index = self.member_index
    PanelEquipableItems.member_index = self.member_index
    self:addChild(self.header_member)
    self:addChild(equipped_items)
    self:addChild(equipable_items)
    self:addChild(PanelEquippedItems)
    self:addChild(PanelEquipableItems)
    self:addChild(button_close)
    PanelEquippedItems:dupdate()
    PanelEquipableItems:dupdate()
end

function PanelLoadout:onMouseMove(dx, dy)
    self.mouseOver = true
    if self.moving then
        self:setX(self.x+dx)
        self:setY(self.y+dy)
        self:bringToTop()
    end
end

function PanelLoadout:onMouseMoveOutside(dx, dy)
    self.mouseOver = false
    if self.moving then
        self:setX(self.x+dx)
        self:setY(self.y+dy)
        self:bringToTop()
    end
end

function PanelLoadout:onMouseUp(_, _)
    if not self:getIsVisible() then
        return
    end
    self.moving = false
    ISMouseDrag.dragView = nil
end

function PanelLoadout:onMouseUpOutside(_, _)
    if not self:getIsVisible() then
        return
    end
    self.moving = false
    ISMouseDrag.dragView = nil
end

function PanelLoadout:onMouseDown(x, y)
    if not self:getIsVisible() then
        return
    end
    self.downX = x
    self.downY = y
    self.moving = true
    self:bringToTop()
end

function PanelLoadout:new(x, y, width, height, member_index)
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
dssl = { file = "SuperSurvivorLoadout.lua" }

function dssl.dfile()
    for _, _ in nil do
        -- Triggers a break to automatically open
        -- this file in the debug window.
    end
end