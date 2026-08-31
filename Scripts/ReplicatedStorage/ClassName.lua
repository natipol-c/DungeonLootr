--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ClassName
  Path:     game.ReplicatedStorage.CmdrClient.Types.ClassName
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Class_Data = require(ReplicatedStorage:WaitForChild("Classes"):WaitForChild("Class_Data"));

return function(p1) -- Line: 9
    -- upvalues: Class_Data (copy)
    local u2 = nil;
    local u3 = nil;

    local function getData() -- Line: 16
        -- upvalues: u2 (ref), u3 (ref), Class_Data (ref)
        if u2 then
            return u2, u3;
        end;

        local AllClassNames = Class_Data.GetAllClassNames();

        if #AllClassNames == 0 then
            return {}, {};
        end;

        table.sort(AllClassNames);
        local v4 = {};

        for _, v in ipairs(AllClassNames) do
            v4[v:lower()] = v;
        end;

        u2 = AllClassNames;
        u3 = v4;

        return u2, u3;
    end;

    p1:RegisterType("className", {
        DisplayName = "Class",

        Transform = function(p5) -- Line: 42, Name: Transform
            return p5;
        end,

        Validate = function(p6) -- Line: 46, Name: Validate
            -- upvalues: getData (copy)
            local _, v7 = getData();

            if v7[p6:lower()] then
                return true;
            end;

            return false, `"{p6}" is not a valid class.`;
        end,

        Autocomplete = function(p8) -- Line: 54, Name: Autocomplete
            -- upvalues: getData (copy)
            local v9 = getData();
            local v10 = p8:lower();
            local v11 = {};

            for _, v in ipairs(v9) do
                if v:lower():sub(1, #v10) == v10 then
                    table.insert(v11, v);
                end;
            end;

            if #v11 == 0 then
                for _, v in ipairs(v9) do
                    if v:lower():find(v10, 1, true) then
                        table.insert(v11, v);
                    end;
                end;
            end;

            return v11;
        end,

        Parse = function(p12) -- Line: 78, Name: Parse
            -- upvalues: getData (copy)
            local _, v13 = getData();

            return v13[p12:lower()] or p12;
        end
    });
end;