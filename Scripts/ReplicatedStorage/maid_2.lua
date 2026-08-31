--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     maid
  Path:     game.ReplicatedStorage.Packages._Index.devsparkle_maid@2.1.0.maid
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:39 2026
]]

-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 41
    -- upvalues: u1 (copy)
    return setmetatable({
        _Tasks = {}
    }, u1);
end;

function u1.GiveTask(p2, p3) -- Line: 48
    table.insert(p2._Tasks, p3);
end;

function u1.LinkToInstance(u4: table, u5: userdata) -- Line: 60
    -- upvalues: Players (copy), CollectionService (copy)
    if u5:IsA("Player") then
        u4:GiveTask(Players.PlayerRemoving:Connect(function(p6) -- Line: 62
            -- upvalues: u5 (copy), u4 (copy)
            if p6 == u5 then
                u4:DoCleaning();
            end;
        end));

        return;
    end;

    u5:AddTag("MaidLinkToInstance");
    u4:GiveTask(CollectionService:GetInstanceRemovedSignal("MaidLinkToInstance"):Connect(function(p7) -- Line: 70
        -- upvalues: u5 (copy), u4 (copy)
        if p7 == u5 then
            u4:DoCleaning();
        end;
    end));
    u4:GiveTask(u5.Destroying:Connect(function() -- Line: 76
        -- upvalues: u4 (copy), u5 (copy)
        u4:DoCleaning();
        u5:RemoveTag("MaidLinkToInstance");
    end));
end;

function u1.DoCleaning(p8) -- Line: 109
    local _Tasks = p8._Tasks;
    p8._Tasks = {};

    for _, v in next, _Tasks do
        local v9 = typeof(v);
        local v10 = v9 == "table";

        if v9 == "RBXScriptConnection" or v10 and v.Disconnect then
            v:Disconnect();
        elseif v9 == "thread" then
            xpcall(task.cancel, function(p11) -- Line: 120
                local debug_info_ret = debug.info(4, "n");
                warn(debug.traceback((`Maid could not cancel thread for "{debug_info_ret or "Unknown Function"}": {p11}`)));
            end, v);
        elseif v9 == "Instance" or v10 and v.Destroy then
            v:Destroy();
        else
            v();
        end;
    end;

    table.clear(_Tasks);
end;

u1.Disconnect = u1.DoCleaning;
u1.Destroy = u1.DoCleaning;

return table.freeze(u1);