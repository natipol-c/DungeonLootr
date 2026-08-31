--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Registry
  Path:     game.StarterPlayer.StarterPlayerScripts.Client.Controllers.Registry
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:14 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    _Entries = {},

    Register = function(p1: table, p2: string, p3: any) -- Line: 11, Name: Register
        if p1._Entries[p2] then
            error((`Key "{p2}" is already registered.`));
        end;

        p1._Entries[p2] = p3;
    end,

    Get = function(p4: table, p5: string) -- Line: 18, Name: Get
        return p4._Entries[p5];
    end,

    Remove = function(p6: table, p7: string) -- Line: 22, Name: Remove
        if not p6._Entries[p7] then
            error((`Key "{p7}" is not registered.`));
        end;

        p6._Entries[p7] = nil;
    end
};