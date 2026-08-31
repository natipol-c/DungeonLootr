--[[
  Type:     ModuleScript
  Method:   cached
  Name:     position
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Debug.position
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "position",
    Description = "Returns Vector3 position of you or other players. Empty string is the player has no character.",
    Group = "DefaultDebug",
    Aliases = { "pos" },
    Args = {
        {
            Type = "player",
            Name = "Player",
            Description = "The player to report the position of. Omit for your own position.",
            Default = game:GetService("Players").LocalPlayer
        }
    },

    ClientRun = function(p1, p2) -- Line: 17, Name: ClientRun
        local Character = p2.Character;

        return not (Character and Character:FindFirstChild("HumanoidRootPart")) and "" or tostring(Character.HumanoidRootPart.Position):gsub("%s", "");
    end
};