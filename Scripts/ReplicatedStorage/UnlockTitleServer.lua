--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UnlockTitleServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.UnlockTitleServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local Knit = require(game.ReplicatedStorage.Packages.Knit);

return function(p1: any, p2: userdata, p3: string) -- Line: 3
    -- upvalues: Knit (copy)
    if Knit.GetService("TitleService"):UnlockTitle(p2, p3) then
        return string.format("Unlocked title \'%s\' for %s", p3, p2.Name);
    end;

    return string.format("Failed to unlock title \'%s\' for %s (may already be unlocked or title doesn\'t exist)", p3, p2.Name);
end;