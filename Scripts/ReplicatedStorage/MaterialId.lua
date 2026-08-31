--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     MaterialId
  Path:     game.ReplicatedStorage.CmdrClient.Types.MaterialId
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:25 2026
]]

-- Decompiled with Potassium's decompiler.

local GameInfo = game:GetService("ReplicatedStorage"):WaitForChild("GameInfo");
local ItemData = require(GameInfo:WaitForChild("ItemData"));
local ForgeData = require(GameInfo:WaitForChild("ForgeData"));

return function(p1) -- Line: 14
    -- upvalues: ItemData (copy), ForgeData (copy)
    local u2 = {};
    local u3 = {};

    local function add(p4) -- Line: 20
        -- upvalues: u2 (copy), u3 (copy)
        if p4 and not u2[p4] then
            u2[p4] = true;
            table.insert(u3, p4);
        end;
    end;

    for i in ItemData.Index do
        if i and not u2[i] then
            u2[i] = true;
            table.insert(u3, i);
        end;
    end;

    local MATERIAL_ID = ForgeData.MATERIAL_ID;

    if MATERIAL_ID and not u2[MATERIAL_ID] then
        u2[MATERIAL_ID] = true;
        table.insert(u3, MATERIAL_ID);
    end;

    local REFORGE_MATERIAL_ID = ForgeData.REFORGE_MATERIAL_ID;

    if REFORGE_MATERIAL_ID and not u2[REFORGE_MATERIAL_ID] then
        u2[REFORGE_MATERIAL_ID] = true;
        table.insert(u3, REFORGE_MATERIAL_ID);
    end;

    table.sort(u3);
    local u5 = {};

    for _, v in ipairs(u3) do
        u5[v:lower()] = v;
    end;

    p1:RegisterType("materialId", {
        DisplayName = "Material",

        Transform = function(p6) -- Line: 44, Name: Transform
            return p6;
        end,

        Validate = function(p7) -- Line: 48, Name: Validate
            -- upvalues: u5 (copy)
            if u5[p7:lower()] then
                return true;
            end;

            return false, `"{p7}" is not a valid material. Use autocomplete to see options.`;
        end,

        Autocomplete = function(p8) -- Line: 55, Name: Autocomplete
            -- upvalues: u3 (copy)
            local v9 = p8:lower();
            local v10 = {};

            for _, v in ipairs(u3) do
                if v:lower():sub(1, #v9) == v9 then
                    table.insert(v10, v);
                end;
            end;

            if #v10 == 0 then
                for _, v in ipairs(u3) do
                    if v:lower():find(v9, 1, true) then
                        table.insert(v10, v);
                    end;
                end;
            end;

            return v10;
        end,

        Parse = function(p11) -- Line: 78, Name: Parse
            -- upvalues: u5 (copy)
            return u5[p11:lower()] or p11;
        end
    });
end;