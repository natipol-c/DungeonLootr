--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Sonido_Barrage
  Path:     game.ReplicatedStorage.Classes.Vacio.Skill_Modules.Sonido_Barrage
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:48 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local ForgeChoreographer = require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer);
local ForgeVFXUtil = require(ReplicatedStorage.Modules.ForgeVFXUtil);
local v1 = ForgeChoreographer.markerEmit(script, {
    models = { "Skill3", "HighlightEmit" }
});
local Emit = v1.Emit;

function v1.Emit(p2, p3, p4) -- Line: 38
    -- upvalues: ForgeVFXUtil (copy), Lighting (copy), Emit (copy)
    if p4 ~= "ColorCorrectionVacio3" then
        return Emit(p2, p3, p4);
    end;

    if not ForgeVFXUtil.IsScreenOwner(p2) then
        return;
    end;

    local ColorCorrectionVacio3 = Lighting:FindFirstChild("ColorCorrectionVacio3");

    if ColorCorrectionVacio3 then
        ForgeVFXUtil.GetForge().emit(ColorCorrectionVacio3);
    end;
end;

return v1;