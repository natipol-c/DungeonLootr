--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     LevelScope
  Path:     game.ReplicatedStorage.CmdrClient.Types.LevelScope
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = { "player", "class" };

return function(p2) -- Line: 6
    -- upvalues: u1 (copy)
    p2:RegisterType("levelScope", {
        DisplayName = "Scope",

        Transform = function(p3) -- Line: 10, Name: Transform
            return p3;
        end,

        Validate = function(p4) -- Line: 14, Name: Validate
            -- upvalues: u1 (ref)
            for _, v in ipairs(u1) do
                if v:lower() == p4:lower() then
                    return true;
                end;
            end;

            return false, `"{p4}" is not a valid level scope. Options: player, class`;
        end,

        Autocomplete = function(p5) -- Line: 23, Name: Autocomplete
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

        Parse = function(p8) -- Line: 36, Name: Parse
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