--[[
  Type:     ModuleScript
  Method:   cached
  Name:     getPlayerPlaceInstance
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Debug.getPlayerPlaceInstance
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "get-player-place-instance",
    Description = "Returns the target player\'s Place ID and the JobId separated by a space. Returns 0 if the player is offline or something else goes wrong.",
    Group = "DefaultDebug",
    Aliases = {},
    Args = {
        {
            Type = "playerId",
            Name = "Player",
            Description = "Get the place instance of this player"
        },

        function(p1) -- Line: 12
            return {
                Name = "Format",
                Description = "What data to return. PlaceIdJobId returns both separated by a space.",
                Default = "PlaceIdJobId",
                Type = p1.Cmdr.Util.MakeEnumType("PlaceInstance Format", { "PlaceIdJobId", "PlaceId", "JobId" })
            };
        end
    }
};