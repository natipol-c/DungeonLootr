--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     WipeLeaderboard
  Path:     game.ReplicatedStorage.CmdrClient.Commands.WipeLeaderboard
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "WipeLeaderboard",
    Description = "Remove a player\'s entry from a leaderboard. Power also resets their PeakGearScore (works offline / cross-server). Party boards (BossRushParty/ChallengeParty) remove every party run the player was part of.",
    Group = "Whitelist",
    Aliases = { "wipelb" },
    Args = { {
            Type = "playerId",
            Name = "Player",
            Description = "Target player by username (works for OFFLINE players too)"
        }, {
            Type = "leaderboardBoard",
            Name = "Board",
            Description = "Leaderboard to wipe them from (e.g. Power, or BossRushParty)"
        } }
};