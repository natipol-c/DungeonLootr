--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     CosmeticSetId
  Path:     game.ReplicatedStorage.CmdrClient.Types.CosmeticSetId
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

local GameInfo = game:GetService("ReplicatedStorage"):WaitForChild("GameInfo");
local CosmeticData = require(GameInfo:WaitForChild("CosmeticData"));

return function(p1) -- Line: 9
    -- upvalues: CosmeticData (copy)
    local All = CosmeticData.GetAll();
    table.sort(All);
    local u2 = {};

    for _, v in ipairs(All) do
        u2[v:lower()] = v;
    end;

    p1:RegisterType("cosmeticSetId", {
        DisplayName = "Cosmetic Set",

        Transform = function(p3) -- Line: 22, Name: Transform
            return p3;
        end,

        Validate = function(p4) -- Line: 26, Name: Validate
            -- upvalues: u2 (copy)
            if u2[p4:lower()] then
                return true;
            end;

            return false, `"{p4}" is not a valid cosmetic set.`;
        end,

        Autocomplete = function(p5) -- Line: 33, Name: Autocomplete
            -- upvalues: All (copy)
            local v6 = p5:lower();
            local v7 = {};

            for _, v in ipairs(All) do
                if v:lower():sub(1, #v6) == v6 then
                    table.insert(v7, v);
                end;
            end;

            if #v7 == 0 then
                for _, v in ipairs(All) do
                    if v:lower():find(v6, 1, true) then
                        table.insert(v7, v);
                    end;
                end;
            end;

            return v7;
        end,

        Parse = function(p8) -- Line: 56, Name: Parse
            -- upvalues: u2 (copy)
            return u2[p8:lower()] or p8;
        end
    });
end;