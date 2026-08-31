--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Onboarding
  Path:     game.ReplicatedStorage.CmdrClient.Commands.Onboarding
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "onboarding",
    Description = "Debug: Start onboarding at a specific phase (Start / Dungeon / OutOfDungeon) or End it. Does not change saved data.",
    Group = "Admin",
    Aliases = { "tutorial" },
    Args = { {
            Type = "players",
            Name = "Players",
            Description = "The player(s) whose onboarding flow to trigger/end"
        }, {
            Type = "onboardingAction",
            Name = "Phase",
            Description = "Start (lobby) · Dungeon (in-run systems) · OutOfDungeon (post-run lobby) · End"
        } }
};