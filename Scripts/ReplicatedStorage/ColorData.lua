--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     ColorData
  Path:     game.ReplicatedStorage.GameInfo.ColorData
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    Difficulty = {
        Easy = Color3.fromRGB(0, 255, 0),
        Normal = Color3.fromRGB(255, 255, 0),
        Hard = Color3.fromRGB(255, 51, 51),
        Nightmare = Color3.fromRGB(155, 48, 255),
        Endless = Color3.fromRGB(255, 102, 0)
    },
    Pod = {
        Idle = Color3.fromRGB(143, 255, 255),
        Queuing = Color3.fromRGB(85, 255, 0),
        Warping = Color3.fromRGB(255, 40, 40)
    },
    ChallengePod = {
        Idle = Color3.fromRGB(255, 177, 82),
        Queuing = Color3.fromRGB(85, 255, 0),
        Warping = Color3.fromRGB(255, 40, 40)
    },

    ToHex = function(p1) -- Line: 44, Name: ToHex
        return string.format("#%02X%02X%02X", math.floor(p1.R * 255 + 0.5), math.floor(p1.G * 255 + 0.5), (math.floor(p1.B * 255 + 0.5)));
    end
};