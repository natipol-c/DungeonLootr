--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     AddTool
  Path:     game.ReplicatedStorage.CmdrClient.Commands.AddTool
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:22 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "AddTool",
    Description = "Give a player a tool",
    Group = "Admin",
    Aliases = { "at" },
    Args = { {
            Type = "player",
            Name = "Player",
            Description = "The Player who\'ll receive the tool"
        }, {
            Type = "string",
            Name = "ToolId",
            Description = "The ID of the tool"
        }, {
            Type = "boolean",
            Name = "Permanent?",
            Description = "Want the tool to be permanent?"
        } }
};