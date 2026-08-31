--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AttributeObserver
  Path:     game.ReplicatedStorage.Globals.Modules.AttributeObserver
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:37 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {};
u1.__index = u1;
local Signal = require(script.Parent.Signal);

function u1.new(u2: userdata, u3: string) -- Line: 10
    -- upvalues: u1 (copy), Signal (copy)
    local u4 = setmetatable({}, u1);
    u4.Object = u2;
    u4.AttributeName = u3;
    u4.Value = u2:GetAttribute(u3);
    u4.ValueChanged = Signal.new();
    u4.Connection = u2:GetAttributeChangedSignal(u3):Connect(function() -- Line: 18
        -- upvalues: u4 (copy), u2 (copy), u3 (copy)
        local Value = u4.Value;
        u4.Value = u2:GetAttribute(u3);
        u4.ValueChanged:Fire(Value, u4.Value);
    end);

    return u4;
end;

function u1.UpdateInstance(u5: table, p6: userdata) -- Line: 28
    u5.Connection:Disconnect();
    u5.Object = p6;
    u5.Value = u5.Object:GetAttribute(u5.AttributeName);
    u5.Connection = u5.Object:GetAttributeChangedSignal(u5.AttributeName):Connect(function() -- Line: 33
        -- upvalues: u5 (copy)
        local Value = u5.Value;
        u5.Value = u5.Object:GetAttribute(u5.AttributeName);
        u5.ValueChanged:Fire(Value, u5.Value);
    end);
end;

function u1.Destroy(p7) -- Line: 41
    p7.Connection:Disconnect();
    table.clear(p7);
end;

return u1;