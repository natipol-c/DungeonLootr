--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SendToAFK
  Path:     game.ReplicatedStorage.CmdrClient.Commands.SendToAFK
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "SendToAFK",
    Description = "Teleport a player to the AFK Chamber place (debug — bypasses the gate flag)",
    Group = "Admin",
    Aliases = { "afkchamber" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to send to the AFK Chamber"
        } }
};