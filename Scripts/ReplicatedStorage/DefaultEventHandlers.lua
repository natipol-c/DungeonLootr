--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     DefaultEventHandlers
  Path:     game.ReplicatedStorage.CmdrClient.DefaultEventHandlers
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:21 2026
]]

-- Decompiled with Potassium's decompiler.

local StarterGui = game:GetService("StarterGui");
local Window = require(script.Parent.CmdrInterface.Window);

return function(p1) -- Line: 4
    -- upvalues: StarterGui (copy), Window (copy)
    p1:HandleEvent("Message", function(p2) -- Line: 5
        -- upvalues: StarterGui (ref)
        StarterGui:SetCore("ChatMakeSystemMessage", {
            Text = ("[Announcement] %s"):format(p2),
            Color = Color3.fromRGB(249, 217, 56)
        });
    end);
    p1:HandleEvent("AddLine", function(...) -- Line: 12
        -- upvalues: Window (ref)
        Window:AddLine(...);
    end);
end;