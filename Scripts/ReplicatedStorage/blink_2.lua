--[[
  Type:     ModuleScript
  Method:   cached
  Name:     blink
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Debug.blink
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Name = "blink",
    Description = "Teleports you to where your mouse is hovering.",
    Group = "DefaultDebug",
    Aliases = { "b" },
    Args = {},

    ClientRun = function(p1) -- Line: 8, Name: ClientRun
        local Mouse = p1.Executor:GetMouse();
        local Character = p1.Executor.Character;

        if not Character then
            return "You don\'t have a character.";
        end;

        Character:MoveTo(Mouse.Hit.p);

        return "Blinked!";
    end
};