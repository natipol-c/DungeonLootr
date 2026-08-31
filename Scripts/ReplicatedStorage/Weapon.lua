--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Weapon
  Path:     game.ReplicatedStorage.CmdrClient.Types.Weapon
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local function GetWeaponNames() -- Line: 5
    -- upvalues: ReplicatedStorage (copy)
    local v1 = {};
    local Weapons = ReplicatedStorage:FindFirstChild("Weapons");

    if Weapons then
        for _, child in ipairs(Weapons:GetChildren()) do
            table.insert(v1, child.Name);
        end;
    end;

    table.sort(v1);

    return v1;
end;

return function(p2) -- Line: 19
    -- upvalues: GetWeaponNames (copy)
    local u3 = GetWeaponNames();
    p2:RegisterType("weapon", {
        DisplayName = "Weapon",

        Transform = function(p4) -- Line: 25, Name: Transform
            return p4;
        end,

        Validate = function(p5) -- Line: 29, Name: Validate
            -- upvalues: u3 (copy)
            for _, v in ipairs(u3) do
                if v:lower() == p5:lower() then
                    return true;
                end;
            end;

            return false, `"{p5}" is not a valid weapon.`;
        end,

        Autocomplete = function(p6) -- Line: 39, Name: Autocomplete
            -- upvalues: u3 (copy)
            local v7 = p6:lower();
            local v8 = {};

            for _, v in ipairs(u3) do
                if v:lower():sub(1, #v7) == v7 then
                    table.insert(v8, v);
                end;
            end;

            if #v8 == 0 then
                for _, v in ipairs(u3) do
                    if v:lower():find(v7, 1, true) then
                        table.insert(v8, v);
                    end;
                end;
            end;

            return v8;
        end,

        Parse = function(p9) -- Line: 61, Name: Parse
            -- upvalues: u3 (copy)
            for _, v in ipairs(u3) do
                if v:lower() == p9:lower() then
                    return v;
                end;
            end;

            return p9;
        end
    });
end;