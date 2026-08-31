--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     respawnServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.Admin.respawnServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

return function(p1, p2) -- Line: 1
    for _, v in pairs(p2) do
        if v.Character then
            v:LoadCharacter();
        end;
    end;

    return ("Respawned %d players."):format(#p2);
end;