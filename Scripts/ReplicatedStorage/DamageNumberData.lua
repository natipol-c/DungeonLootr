--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DamageNumberData
  Path:     game.ReplicatedStorage.GameInfo.DamageNumberData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
local u2 = {};
local u3 = {
    ActiveAnimation = "FloatAndLinger"
};

for _, child in script:GetChildren() do
    if child:IsA("ModuleScript") then
        local success, result = pcall(require, child);

        if success and type(result) == "table" then
            if type(result.Name) == "string" and type(result.Render) == "function" then
                if u1[result.Name] then
                    warn((`[DamageNumberData] Duplicate animation Name '{result.Name}' — keeping the first, skipping '{child.Name}'`));
                else
                    u1[result.Name] = result;
                    table.insert(u2, result.Name);
                end;
            else
                warn((`[DamageNumberData] Animation module '{child.Name}' missing Name/Render — skipped`));
            end;
        else
            warn((`[DamageNumberData] Failed to load animation module '{child.Name}': {result}`));
        end;
    end;
end;

table.sort(u2);

function u3.Get(p4: string?) -- Line: 84
    -- upvalues: u1 (copy)
    return p4 ~= nil and u1[p4] or nil;
end;

function u3.GetActive() -- Line: 91
    -- upvalues: u1 (copy), u3 (copy), u2 (copy)
    local v5 = u1[u3.ActiveAnimation];

    if v5 then
        return v5;
    end;

    local v6 = u2[1];

    if v6 then
        warn((`[DamageNumberData] ActiveAnimation '{u3.ActiveAnimation}' not found — falling back to '{v6}'`));

        return u1[v6];
    end;

    warn("[DamageNumberData] No animation modules found");

    return nil;
end;

function u3.GetNames() -- Line: 107
    -- upvalues: u2 (copy)
    return u2;
end;

return u3;