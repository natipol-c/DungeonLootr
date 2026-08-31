--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     SpawnEnemy
  Path:     game.ReplicatedStorage.CmdrClient.Commands.SpawnEnemy
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "SpawnEnemy",
    Description = "Spawn any enemy (or boss) near the player with full combat AI",
    Group = "Admin",
    Aliases = { "se" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The player to spawn the enemy near"
        }, {
            Type = "enemyId",
            Name = "EnemyId",
            Description = "Enemy name from Enemy_Data (autocomplete enabled — e.g. \'Bandit Chief\')"
        }, {
            Type = "string",
            Name = "Difficulty",
            Description = "Optional difficulty: Easy, Normal, Hard, Nightmare, Endless (default Easy)",
            Optional = true
        }, {
            Type = "number",
            Name = "Amount",
            Description = "Number of enemies to spawn (default 1, max 20)",
            Optional = true
        }, {
            Type = "number",
            Name = "Scale",
            Description = "Model scale multiplier (default 1, e.g. 2 = double size)",
            Optional = true
        }, {
            Type = "giveableItem",
            Name = "DropItem",
            Description = "Special item to drop on death (e.g. Cosmetic:Shadow, Potion:SmallHealPercent)",
            Optional = true
        }, {
            Type = "number",
            Name = "DropAmount",
            Description = "Amount of the special drop item (default 1)",
            Optional = true
        } }
};