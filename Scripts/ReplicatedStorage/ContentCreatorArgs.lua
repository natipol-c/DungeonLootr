--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ContentCreatorArgs
  Path:     game.ReplicatedStorage.CmdrClient.Types.ContentCreatorArgs
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = { "FreezeTime", "NoUI", "Freecam" };
local u2 = { "true", "false" };

local function makeAutocomplete(u3) -- Line: 14
    return function(p4) -- Line: 15
        -- upvalues: u3 (copy)
        local v5 = p4:lower();
        local v6 = {};

        for _, v in ipairs(u3) do
            if v:lower():sub(1, #v5) == v5 then
                table.insert(v6, v);
            end;
        end;

        if #v6 == 0 then
            for _, v in ipairs(u3) do
                if v:lower():find(v5, 1, true) then
                    table.insert(v6, v);
                end;
            end;
        end;

        return v6;
    end;
end;

return function(p7) -- Line: 37
    -- upvalues: u1 (copy), u2 (copy)
    local v10 = {
        DisplayName = "Action",

        Transform = function(p8) -- Line: 41, Name: Transform
            return p8;
        end,

        Validate = function(p9) -- Line: 45, Name: Validate
            -- upvalues: u1 (ref)
            for _, v in ipairs(u1) do
                if v:lower() == p9:lower() then
                    return true;
                end;
            end;

            return false, `"{p9}" is not a valid cc action. Options: FreezeTime, NoUI, Freecam`;
        end
    };
    local u11 = u1;

    function v10.Autocomplete(p12) -- Line: 15
        -- upvalues: u11 (copy)
        local v13 = p12:lower();
        local v14 = {};

        for _, v in ipairs(u11) do
            if v:lower():sub(1, #v13) == v13 then
                table.insert(v14, v);
            end;
        end;

        if #v14 == 0 then
            for _, v in ipairs(u11) do
                if v:lower():find(v13, 1, true) then
                    table.insert(v14, v);
                end;
            end;
        end;

        return v14;
    end;

    function v10.Parse(p15) -- Line: 56
        -- upvalues: u1 (ref)
        for _, v in ipairs(u1) do
            if v:lower() == p15:lower() then
                return v;
            end;
        end;

        return p15;
    end;

    p7:RegisterType("ccAction", v10);
    local v18 = {
        DisplayName = "true/false",

        Transform = function(p16) -- Line: 70, Name: Transform
            return p16:lower();
        end,

        Validate = function(p17) -- Line: 74, Name: Validate
            return p17 == "true" and true or p17 == "false", "Please choose true or false.";
        end
    };
    local u19 = u2;

    function v18.Autocomplete(p20) -- Line: 15
        -- upvalues: u19 (copy)
        local v21 = p20:lower();
        local v22 = {};

        for _, v in ipairs(u19) do
            if v:lower():sub(1, #v21) == v21 then
                table.insert(v22, v);
            end;
        end;

        if #v22 == 0 then
            for _, v in ipairs(u19) do
                if v:lower():find(v21, 1, true) then
                    table.insert(v22, v);
                end;
            end;
        end;

        return v22;
    end;

    function v18.Parse(p23) -- Line: 80
        return p23 == "true";
    end;

    p7:RegisterType("ccToggle", v18);
end;