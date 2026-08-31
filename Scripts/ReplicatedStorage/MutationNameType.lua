--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     MutationNameType
  Path:     game.ReplicatedStorage.CmdrClient.Types.MutationNameType
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");

local function GetMutationNames() -- Line: 4
    -- upvalues: ReplicatedStorage (copy)
    local v1 = {};
    local success, result = pcall(require, ReplicatedStorage.GameInfo.MutationData);

    if not success then
        warn("[Cmdr] Failed to load MutationData for mutationName type:", result);

        return v1;
    end;

    for i in pairs(result.Mutations) do
        table.insert(v1, i);
    end;

    table.sort(v1);

    return v1;
end;

return function(p2) -- Line: 19
    -- upvalues: GetMutationNames (copy)
    local u3 = GetMutationNames();
    p2:RegisterType("mutationName", {
        DisplayName = "MutationName",

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

            return false, `"{p5}" is not a valid mutation.`;
        end,

        Autocomplete = function(p6) -- Line: 38, Name: Autocomplete
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

        Parse = function(p9) -- Line: 59, Name: Parse
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