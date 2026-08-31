--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     FlagUtil
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CommonUtils.FlagUtil
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:20 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    getUserFlag = function(u1) -- Line: 11, Name: getUserFlag
        local success, result = pcall(function() -- Line: 12
            -- upvalues: u1 (copy)
            return UserSettings():IsUserFeatureEnabled(u1);
        end);

        return success and result;
    end
};