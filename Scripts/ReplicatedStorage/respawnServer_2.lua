--[[
  Type:     ModuleScript
  Method:   cached
  Name:     respawnServer
  Path:     game.ReplicatedStorage.Packages._Index.evaera_cmdr@1.12.0.cmdr.BuiltInCommands.Admin.respawnServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:41 2026
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