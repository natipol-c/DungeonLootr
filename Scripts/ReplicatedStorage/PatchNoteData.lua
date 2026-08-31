--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     PatchNoteData
  Path:     game.ReplicatedStorage.GameInfo.PatchNoteData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local v3 = {
    MAX_REWARDS = 3
};

for _, child in script:GetChildren() do
    if child:IsA("ModuleScript") then
        local success, result = pcall(require, child);

        if success and type(result) == "table" then
            if result.Id and result.Order then
                result.Rewards = result.Rewards or {};

                if #result.Rewards > 3 then
                    warn((`[PatchNoteData] Note '{result.Id}' has {#result.Rewards} rewards; capping to {3}`));

                    while #result.Rewards > 3 do
                        table.remove(result.Rewards);
                    end;
                end;

                table.insert(u1, result);
                u2[result.Id] = result;
            else
                warn((`[PatchNoteData] Note module '{child.Name}' missing Id/Order — skipped`));
            end;
        else
            warn((`[PatchNoteData] Failed to load note module '{child.Name}': {result}`));
        end;
    end;
end;

table.sort(u1, function(p4, p5) -- Line: 63
    if p4.Order == p5.Order then
        return p4.Id > p5.Id;
    end;

    return p4.Order > p5.Order;
end);

function v3.GetOrdered() -- Line: 72
    -- upvalues: u1 (copy)
    return u1;
end;

function v3.GetById(p6: string) -- Line: 77
    -- upvalues: u2 (copy)
    return u2[p6];
end;

function v3.HasRewards(p7: table?) -- Line: 82
    local v8;

    if p7 == nil or p7.Rewards == nil then
        v8 = false;
    else
        v8 = #p7.Rewards > 0;
    end;

    return v8;
end;

return v3;