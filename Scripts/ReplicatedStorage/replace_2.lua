--[[
  Type:     ModuleScript
  Method:   cached
  Name:     replace
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Utility.replace
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "replace",
    Description = "Replaces text A with text B",
    Group = "DefaultUtil",
    Aliases = { "gsub", "//" },
    AutoExec = { "alias \"map|Maps a CSV into another CSV\" replace $1{string|CSV} ([^,]+) \"$2{string|mapped value|Use %1 to insert the element}\"", "alias \"join|Joins a CSV with a specified delimiter\" replace $1{string|CSV} , $2{string|Delimiter}" },
    Args = { {
            Type = "string",
            Name = "Haystack",
            Description = "The source string upon which to perform replacement."
        }, {
            Type = "string",
            Name = "Needle",
            Description = "The string pattern search for."
        }, {
            Type = "string",
            Name = "Replacement",
            Description = "The string to replace matches (%1 to insert matches).",
            Default = ""
        } },

    Run = function(p1, p2, p3, p4) -- Line: 29, Name: Run
        return p2:gsub(p3, p4);
    end
};