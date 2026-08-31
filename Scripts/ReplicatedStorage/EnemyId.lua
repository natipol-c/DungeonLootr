--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     EnemyId
  Path:     game.ReplicatedStorage.CmdrClient.Types.EnemyId
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local GameInfo = game:GetService("ReplicatedStorage"):WaitForChild("GameInfo");
local Enemy_Data = require(GameInfo:WaitForChild("Enemy_Data"));

return function(p1) -- Line: 11
    -- upvalues: Enemy_Data (copy)
    local u2 = {};

    for i in Enemy_Data.Index do
        table.insert(u2, i);
    end;

    table.sort(u2);
    local u3 = {};

    for _, v in ipairs(u2) do
        u3[v:lower()] = v;
    end;

    p1:RegisterType("enemyId", {
        DisplayName = "Enemy",

        Transform = function(p4) -- Line: 28, Name: Transform
            return p4;
        end,

        Validate = function(p5) -- Line: 32, Name: Validate
            -- upvalues: u3 (copy)
            if u3[p5:lower()] then
                return true;
            end;

            return false, `"{p5}" is not a valid enemy. Use autocomplete to see options.`;
        end,

        Autocomplete = function(p6) -- Line: 39, Name: Autocomplete
            -- upvalues: u2 (copy)
            local v7 = p6:lower();
            local v8 = {};

            for _, v in ipairs(u2) do
                if v:lower():sub(1, #v7) == v7 then
                    table.insert(v8, v);
                end;
            end;

            if #v8 == 0 then
                for _, v in ipairs(u2) do
                    if v:lower():find(v7, 1, true) then
                        table.insert(v8, v);
                    end;
                end;
            end;

            return v8;
        end,

        Parse = function(p9) -- Line: 62, Name: Parse
            -- upvalues: u3 (copy)
            return u3[p9:lower()] or p9;
        end
    });
end;