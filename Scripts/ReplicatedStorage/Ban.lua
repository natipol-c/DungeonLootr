--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ban
  Path:     game.ReplicatedStorage.CmdrClient.Commands.Ban
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:24 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "Ban",
    Description = "Ban a player by UserID or Username (works offline / cross-server). Applies a Roblox universe ban + an instant realtime kick.",
    Group = "Admin",
    Aliases = { "b" },
    Args = { {
            Type = "banMode",
            Name = "Mode",
            Description = "Whether the next value is a UserID or a Username"
        }, {
            Type = "string",
            Name = "Target",
            Description = "The numeric UserID or the Username, matching Mode"
        }, {
            Type = "string",
            Name = "Reason",
            Description = "Reason for the ban (shown to the player). Quote it for spaces."
        }, {
            Type = "number",
            Name = "Duration",
            Description = "Ban length in seconds (omit or 0 = permanent)",
            Default = 0
        } }
};