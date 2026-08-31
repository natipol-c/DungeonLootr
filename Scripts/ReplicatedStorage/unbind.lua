--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     unbind
  Path:     game.ReplicatedStorage.CmdrClient.Commands.unbind
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:21 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "unbind",
    Description = "Unbinds an input previously bound with Bind",
    Group = "DefaultUtil",
    Aliases = {},
    Args = { {
            Type = "userInput ! bindableResource @ player",
            Name = "Input/Key",
            Description = "The key or input type you\'d like to unbind."
        } },

    ClientRun = function(p1, p2) -- Line: 14, Name: ClientRun
        local Store = p1:GetStore("CMDR_Binds");

        if not Store[p2] then
            return "That input wasn\'t bound.";
        end;

        Store[p2]:Disconnect();
        Store[p2] = nil;

        return "Unbound command from input.";
    end
};