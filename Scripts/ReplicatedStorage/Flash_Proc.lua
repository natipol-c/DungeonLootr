--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Flash_Proc
  Path:     game.ReplicatedStorage.Classes.Divergent.Mastery_Passives.Flash_Proc
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:46 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);

return {
    Name = "Flash_Proc",
    Trigger = "OnCrit",
    Cooldown = 3,
    Level = 13,

    Execute = function(p1, p2) -- Line: 33, Name: Execute
        -- upvalues: SharedUtils (copy)
        if math.random() > 0.5 then
            return;
        end;

        local Character = p1.Character;

        if Character then
            Character = Character:FindFirstChild("HumanoidRootPart");
        end;

        if not Character then
            return;
        end;

        p1:PlayTurnFX();
        SharedUtils.PlaySoundAt(Character, "lightningcrash", 1);
        local HitboxSize = p1.ClassData.HitboxSize;
        local Range = p1.ClassData.Range;
        p1.ClassData.HitboxSize = Vector3.new(20, 20, 29);
        p1.ClassData.Range = 29;
        local v3 = p1:Hitbox();
        p1.ClassData.HitboxSize = HitboxSize;
        p1.ClassData.Range = Range;

        for _, v in v3 do
            if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
                p1:ApplyDamage(v, (p1:ResolveSkillDamage(2.5, v)));
            end;
        end;
    end
};