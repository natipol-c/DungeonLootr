--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GroupRoles
  Path:     game.ReplicatedStorage.GameInfo.GroupRoles
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local GroupService = game:GetService("GroupService");
local u1 = {
    GROUP_ID = 110427303,
    ADMIN_ROLES = { "Owner", "Owner / Lead Developer", "Lead Developer", "Developer", "Admin", "Lead Map Designer" },
    EARLY_ACCESS = "Early Access",
    EARLY_ACCESS_PLUS = "Early Access+",
    CONTENT_CREATOR = "Content Creator",
    TESTER = "Tester"
};
u1.EARLY_ACCESS_BYPASS_ROLES = {
    u1.EARLY_ACCESS,
    u1.EARLY_ACCESS_PLUS,
    u1.CONTENT_CREATOR,
    u1.TESTER,
    "X",
    "Marketing Lead",
    "Group Holder",
    "Trusted",
    "Staff Helper"
};

function u1.GetRoles(u2: number) -- Line: 68
    -- upvalues: GroupService (copy), u1 (copy)
    local success, result = pcall(function() -- Line: 69
        -- upvalues: GroupService (ref), u2 (copy), u1 (ref)
        return GroupService:GetRolesInGroupAsync(u2, u1.GROUP_ID);
    end);

    if not success or type(result) ~= "table" then
        return nil;
    end;

    if not result.IsMember then
        return {};
    end;

    local v3 = {};

    for _, v in result.Roles do
        table.insert(v3, v.Name);
    end;

    return v3;
end;

function u1.GetRole(u4: userdata) -- Line: 89
    -- upvalues: u1 (copy)
    local success, result = pcall(function() -- Line: 90
        -- upvalues: u4 (copy), u1 (ref)
        return u4:GetRoleInGroup(u1.GROUP_ID);
    end);

    if success then
        return result;
    end;

    return nil;
end;

function u1.IsAdminRole(p5: string?) -- Line: 100
    -- upvalues: u1 (copy)
    local v6;

    if p5 == nil then
        v6 = false;
    else
        v6 = table.find(u1.ADMIN_ROLES, p5) ~= nil;
    end;

    return v6;
end;

function u1.IsEarlyAccessBypassRole(p7: string?) -- Line: 107
    -- upvalues: u1 (copy)
    local v8;

    if p7 == nil then
        v8 = false;
    else
        v8 = table.find(u1.EARLY_ACCESS_BYPASS_ROLES, p7) ~= nil;
    end;

    return v8;
end;

function u1.HasAnyRole(p9: number, p10: table) -- Line: 117
    -- upvalues: u1 (copy)
    local Roles = u1.GetRoles(p9);

    if Roles == nil then
        return nil;
    end;

    for _, v in Roles do
        if table.find(p10, v) ~= nil then
            return true;
        end;
    end;

    return false;
end;

function u1.HasRole(p11: number, p12: string) -- Line: 131
    -- upvalues: u1 (copy)
    return u1.HasAnyRole(p11, { p12 });
end;

function u1.HasAdminRole(p13: number) -- Line: 136
    -- upvalues: u1 (copy)
    return u1.HasAnyRole(p13, u1.ADMIN_ROLES);
end;

return u1;