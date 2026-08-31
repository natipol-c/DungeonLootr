--[[
  Type:     LocalScript
  Method:   cached
  Name:     LocalScript
  Path:     game.StarterGui.Main.Frames.Chest_RNG.Chests.Template_Scroller.ItemContainer.Crystal.DisplayName.UIGradient.LocalScript
  Service:  StarterGui
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:10 2026
]]

-- Decompiled with Potassium's decompiler.

local script_Parent = script.Parent;

while true do
    for i = 0, 1, 0.01 do
        script_Parent.Offset = Vector2.new(0, i / 10);
        task.wait();
        local _ = i;
    end;

    for i = 1, 0, -0.01 do
        script_Parent.Offset = Vector2.new(0, i / 10);
        task.wait();
        local _ = i;
    end;
end;