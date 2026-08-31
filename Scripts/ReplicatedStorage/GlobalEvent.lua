--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     GlobalEvent
  Path:     game.ReplicatedStorage.CmdrClient.Commands.GlobalEvent
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "GlobalEvent",
    Description = "Trigger a global event across all servers (Admin Abuse)",
    Group = "Admin",
    Aliases = { "ge" },
    Args = { {
            Type = "globalEventType",
            Name = "EventType",
            Description = "The type of event to trigger (e.g. MutationBuff)"
        }, {
            Type = "mutationName",
            Name = "Target",
            Description = "The mutation to buff (e.g. Frosted, Demonic)"
        }, {
            Type = "number",
            Name = "BoostPercent",
            Description = "Boost percentage (e.g. 5000 = 51x chance, 10000 = 101x chance)"
        }, {
            Type = "number",
            Name = "Duration",
            Description = "Duration in seconds (max 600)"
        } }
};