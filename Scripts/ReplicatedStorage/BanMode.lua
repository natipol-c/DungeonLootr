--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     BanMode
  Path:     game.ReplicatedStorage.CmdrClient.Types.BanMode
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = { "UserID", "Username" };

return function(p2) -- Line: 12
    -- upvalues: u1 (copy)
    p2:RegisterType("banMode", {
        DisplayName = "BanMode",

        Transform = function(p3) -- Line: 16, Name: Transform
            return p3;
        end,

        Validate = function(p4) -- Line: 20, Name: Validate
            -- upvalues: u1 (ref)
            for _, v in ipairs(u1) do
                if v:lower() == p4:lower() then
                    return true;
                end;
            end;

            return false, `"{p4}" is not a valid mode. Options: {table.concat(u1, ", ")}`;
        end,

        Autocomplete = function(p5) -- Line: 29, Name: Autocomplete
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

        Parse = function(p8) -- Line: 40, Name: Parse
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