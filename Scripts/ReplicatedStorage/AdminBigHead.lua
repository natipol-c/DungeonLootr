--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AdminBigHead
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AdminBigHead
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AdminBigHead",
    Description = "Scale every player\'s head across ALL servers for a duration (Admin Event)",
    Group = "Admin",
    Aliases = { "abh" },
    Args = { {
            Type = "number",
            Name = "HeadMult",
            Description = "Head size multiplier (default 5, e.g. 5 = 5x normal head size)",
            Optional = true
        }, {
            Type = "number",
            Name = "Duration",
            Description = "Duration in seconds before heads revert (default 60, max 600)",
            Optional = true
        } }
};