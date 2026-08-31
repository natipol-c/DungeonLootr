--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VehicleCameraConfig
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VehicleCamera.VehicleCameraConfig
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:20 2026
]]

-- Decompiled with Potassium's decompiler.

return {
    pitchStiffness = 0.5,
    yawStiffness = 2.5,
    autocorrectDelay = 1,
    autocorrectMinCarSpeed = 16,
    autocorrectMaxCarSpeed = 32,
    autocorrectResponse = 0.5,
    cutoffMinAngularVelYaw = 60,
    cutoffMaxAngularVelYaw = 180,
    cutoffMinAngularVelPitch = 15,
    cutoffMaxAngularVelPitch = 60,
    pitchBaseAngle = 18,
    pitchDeadzoneAngle = 12,
    firstPersonResponseMul = 10,
    yawReponseDampingRising = 1,
    yawResponseDampingFalling = 3,
    pitchReponseDampingRising = 1,
    pitchResponseDampingFalling = 3,
    verticalCenterOffset = 0.33
};