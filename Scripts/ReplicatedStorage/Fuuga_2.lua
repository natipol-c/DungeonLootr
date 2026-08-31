--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Fuuga
  Path:     game.ReplicatedStorage.Classes.Cursed King.Skills.Fuuga
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:45 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_4",
    EffectModule = "Fuuga"
};
local v2 = script.Parent and script.Parent.Parent;

if v2 then
    v2 = v2:FindFirstChild("VFX");
end;

if v2 then
    v2 = v2:FindFirstChild("SukunaSkill4");
end;

if v2 then
    v2 = v2:FindFirstChild("fuga");
end;

u1.RigLifetime = v2 and v2:GetAttribute("RigLifetime") or 11.5;
u1.DetonateDelay = 3.4;
u1.CastSFX = "Ronan_Spell_01";
u1.DetonateSFX = { "explosion_2", "Sieghart_Spell_15" };
u1.SFXVolume = 1;
u1.CubeDistance = 20;
u1.DamageRadius = 25;
u1.DamageMultiplier = 0.4;
u1.TickInterval = 0.2;
u1.DamageDuration = 5;
u1.MaxDuration = 12;

function u1._StartDamage(u3: any, p4) -- Line: 75
    -- upvalues: u1 (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Name = "Fuuga_DamageAnchor";
    Part.Size = Vector3.new(1, 1, 1);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.CFrame = p4 * CFrame.new(0, 0, -u1.CubeDistance);
    Part.Parent = workspace;
    Debris:AddItem(Part, u1.DamageDuration + 1);
    task.spawn(function() -- Line: 88
        -- upvalues: u1 (ref), u3 (copy), Part (copy)
        local v5 = 0;

        while v5 < u1.DamageDuration and (u3.Character and u3.Character.Parent) do
            for _, v in u3:FindEnemiesNearPosition(Part.Position, u1.DamageRadius) do
                if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
                    u3:ApplyDamage(v, (u3:ResolveSkillDamage(u1.DamageMultiplier, v)));
                end;
            end;

            task.wait(u1.TickInterval);
            v5 = v5 + u1.TickInterval;
        end;

        if Part then
            Part:Destroy();
        end;
    end);
end;

function u1.CanActivate(p6) -- Line: 112
    if p6.Is_Attacking then
        return false, "Attacking";
    end;

    if p6.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p6.Is_Dodging then
        return false, "Dodging";
    end;

    if p6.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u7, p8) -- Line: 120
    -- upvalues: SkillRuntime (copy), u1 (copy), SharedUtils (copy)
    local v9 = SkillRuntime.EnsureAnimation(u7, u1.AnimationName);

    if not v9 then
        warn("[Fuuga] Animation not found");

        return;
    end;

    local Character = u7.Character;
    local u10;

    if Character then
        u10 = Character:FindFirstChild("HumanoidRootPart");
    else
        u10 = Character;
    end;

    if not u10 then
        return;
    end;

    local u11 = SkillRuntime.AnchorHRP(u7);
    u7.Is_Using_Skill = true;
    u7.Is_Attacking = true;
    u11(true);
    Character:SetAttribute("Skill_Camera_Stabilize", true);
    SharedUtils.PlaySoundAt(u10, u1.CastSFX, u1.SFXVolume);
    SkillRuntime.StopAttackAnims(u7);
    v9:Play(0, 1, 1);
    local v12 = SkillRuntime.MakeLifecycle(u7, v9, u1.MaxDuration, function() -- Line: 151
        -- upvalues: u7 (copy), u11 (copy), Character (copy)
        u7.Is_Using_Skill = false;
        u7.Is_Attacking = false;
        u11(false);
        Character:SetAttribute("Skill_Camera_Stabilize", false);
    end);
    local conns = v12.conns;
    local u13 = false;
    conns[#conns + 1] = v9:GetMarkerReachedSignal("VFX"):Connect(function() -- Line: 161
        -- upvalues: u13 (ref), u10 (copy), u7 (copy), u1 (ref), SharedUtils (ref)
        if u13 then
            return;
        end;

        u13 = true;
        local CFrame2 = u10.CFrame;
        u7:PlayEffectModule(u1.EffectModule, "Start", CFrame2);
        task.delay(u1.DetonateDelay, function() -- Line: 171
            -- upvalues: u7 (ref), u1 (ref), SharedUtils (ref), u10 (ref), CFrame2 (copy)
            if not (u7.Character and u7.Character.Parent) then
                return;
            end;

            u7:ShakeCamera("SkillHeavy");

            for _, v in u1.DetonateSFX do
                SharedUtils.PlaySoundAt(u10, v, u1.SFXVolume);
            end;

            u1._StartDamage(u7, CFrame2);
        end);
        task.delay(u1.RigLifetime, function() -- Line: 182
            -- upvalues: u7 (ref), u1 (ref), CFrame2 (copy)
            u7:PlayEffectModule(u1.EffectModule, "DBreset", CFrame2);
        end);
    end);
    conns[#conns + 1] = v9:GetMarkerReachedSignal("DBreset"):Connect(v12.cleanup);
end;

return u1;