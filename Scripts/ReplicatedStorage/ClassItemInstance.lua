--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ClassItemInstance
  Path:     game.ReplicatedStorage.GameInfo.ClassItemInstance
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

local HttpService = game:GetService("HttpService");
local u9 = {
    DEFAULT_CLASS = "Ronin",

    New = function(p1: string, p2: string, p3: string?, p4: string?) -- Line: 50, Name: New
        -- upvalues: HttpService (copy)
        return {
            Locked = false,
            Serial = nil,
            GUID = HttpService:GenerateGUID(false),
            ClassName = p1,
            Rarity = p2,
            Aspect = p3,
            Source = p4 or "Conversion"
        };
    end,

    IsInstance = function(p5) -- Line: 64, Name: IsInstance
        local v6;

        if type(p5) == "table" then
            v6 = type(p5.GUID) == "string";
        else
            v6 = false;
        end;

        return v6;
    end,

    NewSlot = function(p7: string, p8: string?) -- Line: 71, Name: NewSlot
        return {
            ClassName = p7,
            Aspect = p8
        };
    end
};

function u9.NormalizeSlot(p10) -- Line: 78
    -- upvalues: u9 (copy)
    return type(p10) == "table" and {
        ClassName = p10.ClassName or u9.DEFAULT_CLASS,
        Aspect = p10.Aspect
    } or (type(p10) == "string" and p10 ~= "" and {
        Aspect = nil,
        ClassName = p10
    } or {
        Aspect = nil,
        ClassName = u9.DEFAULT_CLASS
    });
end;

function u9.SlotClassName(p11) -- Line: 92
    -- upvalues: u9 (copy)
    return u9.NormalizeSlot(p11).ClassName;
end;

return u9;