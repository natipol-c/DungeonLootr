--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     logger
  Path:     game.ReplicatedStorage.ExternalModules.ForgeVFX.mod.logger
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:30 2026
]]

-- Decompiled with Potassium's decompiler.

local function msg(...) -- Line: 1
    return `[Forge Emit API]: {table.concat({ ... }, " ")}`;
end;

return {
    error = function(...) -- Line: 7, Name: error
        -- upvalues: msg (copy)
        error(msg(..., "\n"));
    end,

    warn = function(...) -- Line: 11, Name: warn
        -- upvalues: msg (copy)
        warn(msg(...));
        warn(msg(debug.traceback("stack trace:")));
    end,

    info = function(...) -- Line: 16, Name: info
        -- upvalues: msg (copy)
        print(msg(...));
    end
};