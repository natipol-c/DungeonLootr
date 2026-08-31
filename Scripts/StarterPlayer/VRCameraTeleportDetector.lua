--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     VRCameraTeleportDetector
  Path:     game.StarterPlayer.StarterPlayerScripts.PlayerModule.CameraModule.VRCameraTeleportDetector
  Service:  StarterPlayer
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 04:00:19 2026
]]

-- Decompiled with Potassium's decompiler.

local u1 = {
    JUMP_STUDS = 4,
    SETTLED_STUDS = 1,
    DEBOUNCE_SECONDS = 0.25
};

function u1.shouldRecenter(p2: number?, p3: number, p4: number?, p5: number) -- Line: 29
    -- upvalues: u1 (copy)
    if p3 <= u1.JUMP_STUDS then
        return false;
    end;

    if p2 == nil or u1.SETTLED_STUDS > p2 then
        return p4 == nil or p5 - p4 >= u1.DEBOUNCE_SECONDS;
    end;

    return false;
end;

return u1;