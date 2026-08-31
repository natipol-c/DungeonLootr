--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     blink
  Path:     game.ReplicatedStorage.CmdrClient.Commands.blink
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:21 2026
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