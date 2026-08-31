--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ConvertToAbsolute
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.ClientUtils.ConvertToAbsolute
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:17 2026
]]

-- Decompiled with Potassium's decompiler.

return function(p1: userdata) -- Line: 1
    local _ = p1.AbsolutePosition;
    local AbsoluteSize = p1.AbsoluteSize;
    p1.Size = UDim2.fromOffset(AbsoluteSize.X, AbsoluteSize.Y);
end;