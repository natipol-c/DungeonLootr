--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     TitleId
  Path:     game.ReplicatedStorage.CmdrClient.Types.TitleId
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local GameInfo = game:GetService("ReplicatedStorage"):WaitForChild("GameInfo");
local TitleData = require(GameInfo:WaitForChild("TitleData"));

return function(p1) -- Line: 10
    -- upvalues: TitleData (copy)
    local u2 = {};

    for i in pairs(TitleData.Titles) do
        table.insert(u2, i);
    end;

    table.sort(u2);
    local u3 = {};

    for _, v in ipairs(u2) do
        u3[v:lower()] = v;
    end;

    p1:RegisterType("titleId", {
        DisplayName = "Title",

        Transform = function(p4) -- Line: 26, Name: Transform
            return p4;
        end,

        Validate = function(p5) -- Line: 30, Name: Validate
            -- upvalues: u3 (copy)
            if u3[p5:lower()] then
                return true;
            end;

            return false, `"{p5}" is not a valid title.`;
        end,

        Autocomplete = function(p6) -- Line: 37, Name: Autocomplete
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

        Parse = function(p9) -- Line: 60, Name: Parse
            -- upvalues: u3 (copy)
            return u3[p9:lower()] or p9;
        end
    });
end;