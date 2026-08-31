--[[
  Type:     LocalScript
  Method:   cached
  Name:     update size
  Path:     game.Players.Natipol123.PlayerGui.dialog.dialogResponses.2.text.update size
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:26 2026
]]

-- Decompiled with Potassium's decompiler.

local script_Parent = script.Parent;
local u1 = script:FindFirstAncestorWhichIsA("ScreenGui");
local Vector2_new_ret = Vector2.new(1920, 1080);
u1:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 6, Name: updateTextSize
    -- upvalues: u1 (copy), Vector2_new_ret (copy), script_Parent (copy)
    local AbsoluteSize = u1.AbsoluteSize;
    local v2 = math.min(AbsoluteSize.X / Vector2_new_ret.X, AbsoluteSize.Y / Vector2_new_ret.Y) * 30;
    script_Parent.TextSize = math.max(9, v2);
end);
local AbsoluteSize = u1.AbsoluteSize;
local v3 = math.min(AbsoluteSize.X / Vector2_new_ret.X, AbsoluteSize.Y / Vector2_new_ret.Y) * 30;
script_Parent.TextSize = math.max(9, v3);