--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     UIAnimationConfig
  Path:     game.ReplicatedStorage.GameInfo.UIAnimationConfig
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:32 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    VISIBILITY_RECHECK_INTERVAL = 0.2,
    RARITY_SPIN_TAG = "RarityGradientSpin",
    Tags = {
        RotateInfinite = {
            Kind = "Rotate",
            DegreesPerSecond = 15
        },
        BreatheInfinite = {
            Kind = "Breathe",
            ScaleAmplitude = 0.04,
            ScaleFrequency = 0.35,
            RotationAmplitudeDeg = 2,
            RotationFrequency = 0.35
        },
        GradientSlide = {
            Kind = "GradientSlide",
            OffsetAmplitude = 0.5,
            Frequency = 0.25,
            Axis = "X"
        },
        RarityGradientSpin = {
            Kind = "GradientSpin",
            DegreesPerSecond = 20
        },
        GradientRotate = {
            Kind = "GradientRotate",
            DegreesPerSecond = 30
        },
        GradientBreathe = {
            Kind = "GradientBreathe",
            Value = 0.975,
            Frequency = 0.05
        },
        shine = {
            Kind = "Shine",
            Rotation = 5,
            Period = 4,
            WipeDuration = 1,
            PlateauHalfWidth = 0.02,
            ShoulderWidth = 0.05,
            EasingStyle = Enum.EasingStyle.Linear,
            EasingDirection = Enum.EasingDirection.Out
        },
        shine_frame = {
            Kind = "ShineFrame",
            Period = 4,
            WipeDuration = 1,
            OffsetStart = -0.3,
            OffsetEnd = 1.05,
            EasingStyle = Enum.EasingStyle.Linear,
            EasingDirection = Enum.EasingDirection.Out
        }
    }
};