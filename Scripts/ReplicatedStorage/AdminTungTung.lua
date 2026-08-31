--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AdminTungTung
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AdminTungTung
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:23 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AdminTungTung",
    Description = "Summon TungTungSahur and spawn random enemies of random difficulties across ALL servers (Admin Event)",
    Group = "Admin",
    Aliases = { "att" },
    Args = { {
            Type = "number",
            Name = "SpawnDuration",
            Description = "How long to spawn enemies after model rises (default 60s, max 300)",
            Optional = true
        }, {
            Type = "number",
            Name = "SpawnInterval",
            Description = "Seconds between enemy spawns (default 2.5, range 0.5-10)",
            Optional = true
        } }
};