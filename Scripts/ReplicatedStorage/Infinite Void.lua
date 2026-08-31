--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Infinite Void
  Path:     game.ReplicatedStorage.Classes.Honored One.Skills.Infinite Void
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:53 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ultimate",
    EffectModule = "Infinite_Void",
    EffectMethod = "Activate",
    CastSFX = "HonoredOne",
    StunRadius = 100,
    StunDuration = 15,
    StunBosses = true,
    ScanBoxSize = Vector3.new(200, 120, 200),
    ChannelDuration = 9.05,
    ReleasePadding = 0.3
};

function u1._ApplyVoidStun(u2) -- Line: 84
    -- upvalues: u1 (copy)
    local HumanoidRootPart = u2:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v3 = os.clock() + u1.StunDuration;

    if (u2:GetAttribute("Stun_Until") or 0) < v3 then
        u2:SetAttribute("Stun_Until", v3);
    end;

    u2:SetAttribute("Is_Stunned", true);
    local v4 = u2:GetAttribute("IsBoss") == true;
    local Anchored = HumanoidRootPart.Anchored;

    if not v4 then
        HumanoidRootPart.Anchored = true;
    end;

    local u5 = false;

    local function release(p6: boolean) -- Line: 105
        -- upvalues: u5 (ref), HumanoidRootPart (copy), Anchored (copy), u2 (copy)
        if u5 then
            return;
        end;

        u5 = true;

        if HumanoidRootPart.Parent then
            HumanoidRootPart.Anchored = Anchored;
        end;

        if p6 and u2.Parent then
            u2:SetAttribute("Is_Stunned", false);
        end;
    end;

    local v7 = u2:FindFirstChildOfClass("Humanoid");

    if v7 then
        v7.Died:Once(function() -- Line: 116
            -- upvalues: u5 (ref), HumanoidRootPart (copy), Anchored (copy)
            if u5 then
                return;
            end;

            u5 = true;

            if HumanoidRootPart.Parent then
                HumanoidRootPart.Anchored = Anchored;
            end;
        end);
    end;

    task.delay(u1.StunDuration, function() -- Line: 119
        -- upvalues: u2 (copy), u5 (ref), HumanoidRootPart (copy), Anchored (copy)
        if not u2.Parent then
            return;
        end;

        if os.clock() < (u2:GetAttribute("Stun_Until") or 0) - 0.05 then
            return;
        end;

        if u5 then
            return;
        end;

        u5 = true;

        if HumanoidRootPart.Parent then
            HumanoidRootPart.Anchored = Anchored;
        end;

        if u2.Parent then
            u2:SetAttribute("Is_Stunned", false);
        end;
    end);
end;

function u1._ScanTargets(p8) -- Line: 130
    -- upvalues: u1 (copy)
    local v9 = p8.Character and p8.Character:FindFirstChild("HumanoidRootPart");

    if not v9 then
        return {};
    end;

    local HitboxSize = p8.ClassData.HitboxSize;
    local Range = p8.ClassData.Range;
    p8.ClassData.HitboxSize = u1.ScanBoxSize;
    p8.ClassData.Range = 0;
    local v10 = p8:Hitbox();
    p8.ClassData.HitboxSize = HitboxSize;
    p8.ClassData.Range = Range;
    local Position = v9.Position;
    local v11 = {};

    for _, v in v10 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") and (u1.StunBosses or not v:GetAttribute("IsBoss"))) and p8:CanApplyStatusTo(v) then
            local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart and (HumanoidRootPart.Position - Position).Magnitude <= u1.StunRadius then
                table.insert(v11, v);
            end;
        end;
    end;

    return v11;
end;

function u1.CanActivate(p12) -- Line: 163
    if p12.Is_Attacking then
        return false, "Attacking";
    end;

    if p12.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p12.Is_Dodging then
        return false, "Dodging";
    end;

    if p12.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u13, p14) -- Line: 171
    -- upvalues: SkillRuntime (copy), u1 (copy), SharedUtils (copy)
    local v15 = SkillRuntime.EnsureAnimation(u13, u1.AnimationName);

    if not v15 then
        warn("[Infinite Void] Animation not found");

        return;
    end;

    local Character = u13.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    local CFrame = Character.CFrame;
    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;
    SkillRuntime.StopAttackAnims(u13);
    local u16 = SkillRuntime.AnchorHRP(u13);
    u16(true);

    local function unanchor() -- Line: 198
        -- upvalues: u16 (copy)
        u16(false);
    end;

    task.delay(u1.ChannelDuration, unanchor);

    if u13.Humanoid then
        u13.Humanoid.Died:Once(unanchor);
    end;

    u13:PlayEffectModule(u1.EffectModule, u1.EffectMethod, CFrame);
    SharedUtils.PlaySoundAt(Character, u1.CastSFX);
    v15:Play(0, 1, 1);
    local u17 = SkillRuntime.BindVFXMarkers(u13, v15, u1.EffectModule);

    for _, v in u1._ScanTargets(u13) do
        u1._ApplyVoidStun(v);
    end;

    u13:ShakeCamera("SkillHeavy");
    local u18 = false;

    local function v19() -- Line: 227
        -- upvalues: u18 (ref), u17 (copy), u13 (copy)
        if u18 then
            return;
        end;

        u18 = true;

        for _, v in u17 do
            v:Disconnect();
        end;

        u13.Is_Using_Skill = false;
        u13.Is_Attacking = false;
    end;

    v15.Stopped:Once(v19);
    task.delay(u1.ChannelDuration + u1.ReleasePadding, v19);
end;

return u1;