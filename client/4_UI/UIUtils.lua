--****************************************************
-- RGB functions
--****************************************************
function rgb_to_dec(color)
    return { r = color.r/255, g = color.g/255, b = color.b/255, a = color.a }
end

function hex_to_rgb(hex, opacity)
    hex = hex:gsub("#", "")
    return { r = tonumber(hex:sub(1, 2), 16), g = tonumber(hex:sub(3, 4), 16), b = tonumber(hex:sub(5, 6), 16), a = opacity }
end

function hex_to_dec(hex, opacity)
    return rgb_to_dec(hex_to_rgb(hex, opacity))
end

hex_colors = {
    ["red"] = hex_to_dec("#CB4C4D", 0.8),
    ["orange"] = hex_to_dec("#CBA74C", 0.8),
    ["yellow"] = hex_to_dec("#C8E744", 0.8),
    ["green"] = hex_to_dec("#23C81F", 0.8),
    ["blue"] = hex_to_dec("#4C9ECB", 0.8),
    ["purple"] = hex_to_dec("#8A4CCB", 0.8),
    ["magenta"] = hex_to_dec("#CB4CAD", 0.8),
    ["brown"] = hex_to_dec("#A57E4C", 0.8)
}

area_colors = {
    ["Bounds"] = hex_colors.blue,
    ["ChopTreeArea"] = hex_colors.yellow,
    ["TakeCorpseArea"] = hex_colors.brown,
    ["TakeWoodArea"] = hex_colors.brown,
    ["FarmingArea"] = hex_colors.green,
    ["ForageArea"] = hex_colors.yellow,
    ["CorpseStorageArea"] = hex_colors.red,
    ["FoodStorageArea"] = hex_colors.green,
    ["WoodStorageArea"] = hex_colors.brown,
    ["ToolStorageArea"] = hex_colors.orange,
    ["WeaponStorageArea"] = hex_colors.yellow,
    ["MedicalStorageArea"] = hex_colors.purple,
    ["GuardArea"] = hex_colors.blue
}

--****************************************************
-- Utility
--****************************************************
function get_group()
    local group_id = SSM:Get(0):getGroupID()
    local group = SSGM:Get(group_id)
    if group == nil then
        group = SSGM:newGroup()
        group:addMember(SSM:Get(0), getContextMenuText("Job_Leader"))
    end
    if group then
        if not group:isMember(SSM:Get(0)) then
            group:addMember(SSM:Get(0), getContextMenuText("Job_Leader"))
        elseif not group:hasLeader() then
            group:setLeader(0)
        end
    end
    return group
end

function get_member_info(member_index)
    local group_id = SSM:Get(0):getGroupID()
    local group = SSGM:Get(group_id)
    if group == nil then
        group = SSGM:newGroup()
        group:addMember(SSM:Get(0), getContextMenuText("Job_Leader"))
    end
    if group then
        if not group:isMember(SSM:Get(0)) then
            group:addMember(SSM:Get(0), getContextMenuText("Job_Leader"))
        elseif not group:hasLeader() then
            group:setLeader(0)
        end
    end
    local group_members = group:getMembers()
    local member = group_members[member_index]
    local name = "none"
    local role = "none"
    local task = "none"
    local ai_mode = "none"
    if member.getName ~= nil and member:isInCell() then
        name = member:getName()
        role = tostring(member:getGroupRole())
        task = member.MyTaskManager.Tasks[member.MyTaskManager.CurrentTask]
        ai_mode = tostring(group_members[member_index]:getAIMode())
    elseif member.getName ~= nil and (member:isDead() or not member:saveFileExists()) then
        name = member:getName()
        role = getText("IGUI_health_Deceased")
        group:removeMember(member:getID())
    elseif member.getName ~= nil and member:isInCell() == false then
        name = member:getName()
        local coords = getCoordsFromID(member:getID())
        if coord == 0 then
            SSM:LoadSurvivor(member:getID(), getSpecificPlayer(0):getCurrentSquare())
            coords = "0"
        end
        role = coords
    elseif not checkSaveFileExists("Survivor"..tostring(member)) then
        name = getContextMenuText("MIASurvivor").."["..tostring(member).."]"
        role = getText("IGUI_health_Deceased")
        group:removeMember(member)
    else
        name = getContextMenuText("MIASurvivor").."["..tostring(member).."]"
        local coords = getCoordsFromID(member)
        if coords == 0 then
            SSM:LoadSurvivor(member, getSpecificPlayer(0):getCurrentSquare())
            coords = "0"
        end
        role = tostring(coords)
    end
    return name, role, task, ai_mode
end

function give_order(order_index, member_index)
    local group_id = SSM:Get(0):getGroupID()
    local group_members = SSGM:Get(group_id):getMembers()
    local member = group_members[member_index]
    if member then
        getSpecificPlayer(0):Say(getActionText("CallName_Before")..member:getName()..getActionText("CallName_After"))
        member:getTaskManager():AddToTop(ListenTask:new(member, getSpecificPlayer(0), false))
        SurvivorOrder(nil, member.player, Orders[order_index], nil)
    end
end

--****************************************************
-- Debugging
--****************************************************
dui = { file = "UIUtils.lua" }

function dui.dfile()
    for _, _ in nil do
        -- Triggers a break to automatically open
        -- this file in the debug window.
    end
end