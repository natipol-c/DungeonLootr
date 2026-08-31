--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SetTrait
  Path:     game.ReplicatedStorage.CmdrClient.Commands.SetTrait
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "setTrait",
    Description = "Set (or clear) the class-weapon aspect/trait on a player\'s currently-equipped class. Pick a trait from the dropdown, or \'None\' to clear it. Rebuilds the class so procs + aura apply live.",
    Group = "Admin",
    Aliases = { "setAspect" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player whose currently-equipped class gets the trait"
        }, {
            Type = "classTrait",
            Name = "Trait",
            Description = "Aspect to apply (Blaze / Fulmin / Glaciel / …), or None to clear"
        } }
};