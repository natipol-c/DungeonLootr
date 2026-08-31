--[[
  Type:     LocalScript
  Method:   cached
  Name:     MobileReposition
  Path:     game.Players.Natipol123.PlayerGui.Main.HUD.Notification.MobileReposition
  Service:  PlayerGui
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:20 2026
]]

-- Decompiled with Potassium's decompiler.

if not script.Parent:GetAttribute("MobilePosition") then
    return;
end;

local UserInputService = game:GetService("UserInputService");

if UserInputService.TouchEnabled and not (UserInputService.KeyboardEnabled or UserInputService.MouseEnabled) and true or false then
    script.Parent.Position = script.Parent:GetAttribute("MobilePosition");
end;