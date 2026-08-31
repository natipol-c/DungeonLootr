--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GlobalEventType
  Path:     game.ReplicatedStorage.CmdrClient.Types.GlobalEventType
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = { "MutationBuff" };

return function(p2) -- Line: 11
    -- upvalues: u1 (copy)
    p2:RegisterType("globalEventType", {
        DisplayName = "GlobalEventType",

        Transform = function(p3) -- Line: 15, Name: Transform
            return p3;
        end,

        Validate = function(p4) -- Line: 19, Name: Validate
            -- upvalues: u1 (ref)
            for _, v in ipairs(u1) do
                if v:lower() == p4:lower() then
                    return true;
                end;
            end;

            return false, `"{p4}" is not a valid event type.`;
        end,

        Autocomplete = function(p5) -- Line: 28, Name: Autocomplete
            -- upvalues: u1 (ref)
            local v6 = p5:lower();
            local v7 = {};

            for _, v in ipairs(u1) do
                if v:lower():sub(1, #v6) == v6 then
                    table.insert(v7, v);
                end;
            end;

            if #v7 == 0 then
                for _, v in ipairs(u1) do
                    if v:lower():find(v6, 1, true) then
                        table.insert(v7, v);
                    end;
                end;
            end;

            return v7;
        end,

        Parse = function(p8) -- Line: 49, Name: Parse
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