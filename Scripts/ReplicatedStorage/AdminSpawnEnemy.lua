--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AdminSpawnEnemy
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AdminSpawnEnemy
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AdminSpawnEnemy",
    Description = "Spawn enemies at the arena across ALL servers (Admin Event)",
    Group = "Admin",
    Aliases = { "ase" },
    Args = {
        {
            Type = "enemyId",
            Name = "EnemyId",
            Description = "Enemy name from Enemy_Data (autocomplete enabled — e.g. \'Bandit Chief\')"
        },
        {
            Type = "string",
            Name = "SpawnLocation",
            Description = "Where to spawn: \'Main\' (Main_Spawn) or \'Random\' (Random_Spawn parts)",
            Optional = true,
            Default = "Main"
        },
        {
            Type = "string",
            Name = "Difficulty",
            Description = "Optional difficulty: Easy, Normal, Hard, Nightmare, Endless (default Easy)",
            Optional = true
        },
        {
            Type = "number",
            Name = "Amount",
            Description = "Number of enemies to spawn (default 1, max 20)",
            Optional = true
        },
        {
            Type = "number",
            Name = "Scale",
            Description = "Model scale multiplier (default 1, e.g. 2 = double size)",
            Optional = true
        },
        {
            Type = "giveableItem",
            Name = "DropItem",
            Description = "Special item to drop on death (e.g. Cosmetic:Shadow, Potion:SmallHealPercent)",
            Optional = true
        },
        {
            Type = "number",
            Name = "DropAmount",
            Description = "Amount of the special drop item (default 1)",
            Optional = true
        },
        {
            Type = "number",
            Name = "Duration",
            Description = "Event banner duration in seconds (default 120, max 600)",
            Optional = true
        }
    }
};