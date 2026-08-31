--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     uptimeServer
  Path:     game.ReplicatedStorage.ExternalModules.Cmdr.Server commands.Debug.uptimeServer
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:29 2026
]]

-- Decompiled with Potassium's decompiler.

local os_time_ret = os.time();

return function() -- Line: 3
    -- upvalues: os_time_ret (copy)
    local v1 = os.time() - os_time_ret;

    return ("%dd %dh %dm %ds"):format(math.floor(v1 / 86400), math.floor(v1 / 3600) % 24, math.floor(v1 / 60) % 60, math.floor(v1) % 60);
end;