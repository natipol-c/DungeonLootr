--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DevProduct
  Path:     game.ReplicatedStorage.CmdrClient.Types.DevProduct
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MonetizationList = require(ReplicatedStorage.GameInfo.MonetizationList);
local u1 = {};

for i, v in pairs(MonetizationList) do
    if v.Id and typeof(v.Id) == "number" then
        table.insert(u1, i);
    end;
end;

table.sort(u1);

return function(p2) -- Line: 15
    -- upvalues: u1 (copy)
    p2:RegisterType("devProduct", {
        DisplayName = "Dev Product",

        Transform = function(p3) -- Line: 19, Name: Transform
            return p3;
        end,

        Validate = function(p4) -- Line: 23, Name: Validate
            -- upvalues: u1 (ref)
            for _, v in ipairs(u1) do
                if v:lower() == p4:lower() then
                    return true;
                end;
            end;

            return false, `"{p4}" is not a valid product name.`;
        end,

        Autocomplete = function(p5) -- Line: 32, Name: Autocomplete
            -- upvalues: u1 (ref)
            local v6 = p5:lower();
            local v7 = {};

            for _, v in ipairs(u1) do
                if v:lower():sub(1, #v6) == v6 then
                    table.insert(v7, v);
                end;
            end;

            return v7;
        end,

        Parse = function(p8) -- Line: 45, Name: Parse
            -- upvalues: u1 (ref)
            for _, v in ipairs(u1) do
                if v:lower() == p8:lower() then
                    return v;
                end;
            end;

            return p8;
        end
    });
end;