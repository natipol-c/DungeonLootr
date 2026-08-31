--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cursed_Speech
  Path:     game.ReplicatedStorage.Classes.Cursed Child.Skill_Modules.Cursed_Speech
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:52 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local ForgeChoreographer = require(ReplicatedStorage.Modules.ClassVFX.ForgeChoreographer);
local ForgeVFXUtil = require(ReplicatedStorage.Modules.ForgeVFXUtil);
local v1 = ForgeChoreographer.markerEmit(script, {
    models = { "Skill3", "HighlightEmit" }
});

function v1.Screen(p2, p3) -- Line: 40
    -- upvalues: ForgeVFXUtil (copy), Lighting (copy)
    if not ForgeVFXUtil.IsScreenOwner(p2) then
        return;
    end;

    local ColorCorrection_FORGE = Lighting:FindFirstChild("ColorCorrection_FORGE");

    if ColorCorrection_FORGE then
        ForgeVFXUtil.GetForge().emit(ColorCorrection_FORGE);
    end;
end;

return v1;