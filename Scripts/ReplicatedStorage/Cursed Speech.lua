--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Cursed Speech
  Path:     game.ReplicatedStorage.Classes.Cursed Child.Skills.Cursed Speech
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:51 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ServerScriptService = game:GetService("ServerScriptService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local SkillRuntime = require(ServerScriptService.Management.Modules.SkillRuntime);
local Chains = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Effects"):WaitForChild("Chains");
local u1 = {
    Cooldown = 13,
    DamageMultiplier = 1.75,
    AnimationName = "Ability_3",
    EffectModule = "Cursed_Speech",
    Skill_SFX = nil,
    HitboxSize = Vector3.new(28, 20, 35),
    HitboxRange = 30,
    StunDuration = 3,
    CastSFX = "DontMove",
    CastVolume = 1,
    MaxDuration = 2
};

local function getPoolFolder() -- Line: 63
    -- upvalues: Chains (copy)
    local CursedChild_CursedSpeech_Chains_Pool = workspace:FindFirstChild("CursedChild_CursedSpeech_Chains_Pool");

    if not CursedChild_CursedSpeech_Chains_Pool then
        CursedChild_CursedSpeech_Chains_Pool = Instance.new("Folder");
        CursedChild_CursedSpeech_Chains_Pool.Name = "CursedChild_CursedSpeech_Chains_Pool";
        CursedChild_CursedSpeech_Chains_Pool.Parent = workspace;

        for i = 1, 8 do
            local v2 = Chains:Clone();
            v2.Name = "Chains_" .. i;
            v2.Anchored = true;
            v2.CFrame = CFrame.new(0, -500, 0);
            v2.Parent = CursedChild_CursedSpeech_Chains_Pool;
            local _ = i;
        end;
    end;

    return CursedChild_CursedSpeech_Chains_Pool;
end;

local function acquireFX() -- Line: 80
    -- upvalues: getPoolFolder (copy)
    for _, child in getPoolFolder():GetChildren() do
        if not child:GetAttribute("InUse") then
            child:SetAttribute("InUse", true);

            return child;
        end;
    end;

    return nil;
end;

local function releaseFX(p3) -- Line: 90
    local ChainAnchorWeld = p3:FindFirstChild("ChainAnchorWeld");

    if ChainAnchorWeld then
        ChainAnchorWeld:Destroy();
    end;

    p3.Anchored = true;
    p3.CFrame = CFrame.new(0, -500, 0);
    p3:SetAttribute("InUse", false);
end;

local function applyChainStun(u4) -- Line: 101
    -- upvalues: acquireFX (copy), u1 (copy)
    local HumanoidRootPart = u4:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    u4:SetAttribute("Is_Stunned", true);
    local Anchored = HumanoidRootPart.Anchored;
    HumanoidRootPart.Anchored = true;
    local u5 = acquireFX();

    if u5 then
        u5.Anchored = false;
        u5.CFrame = HumanoidRootPart.CFrame;
        local WeldConstraint = Instance.new("WeldConstraint");
        WeldConstraint.Name = "ChainAnchorWeld";
        WeldConstraint.Part0 = HumanoidRootPart;
        WeldConstraint.Part1 = u5;
        WeldConstraint.Parent = u5;
    end;

    task.delay(u1.StunDuration, function() -- Line: 121
        -- upvalues: u4 (copy), HumanoidRootPart (copy), Anchored (copy), u5 (copy)
        if u4 and u4.Parent then
            u4:SetAttribute("Is_Stunned", false);
        end;

        if HumanoidRootPart and HumanoidRootPart.Parent then
            HumanoidRootPart.Anchored = Anchored;
        end;

        if u5 then
            local v6 = u5;
            local ChainAnchorWeld = v6:FindFirstChild("ChainAnchorWeld");

            if ChainAnchorWeld then
                ChainAnchorWeld:Destroy();
            end;

            v6.Anchored = true;
            v6.CFrame = CFrame.new(0, -500, 0);
            v6:SetAttribute("InUse", false);
        end;
    end);
end;

function u1.CanActivate(p7) -- Line: 130
    if p7.Is_Attacking then
        return false, "Attacking";
    end;

    if p7.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p7.Is_Dodging then
        return false, "Dodging";
    end;

    if p7.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u8, p9) -- Line: 138
    -- upvalues: SkillRuntime (copy), u1 (copy), SharedUtils (copy), applyChainStun (copy)
    local v10 = SkillRuntime.EnsureAnimation(u8, u1.AnimationName);

    if not v10 then
        warn("[Cursed Speech] Animation not found");

        return;
    end;

    local Character = u8.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u8.Is_Using_Skill = true;
    u8.Is_Attacking = true;
    SkillRuntime.StopAttackAnims(u8);
    v10:Play(0, 1, 1);
    local v11 = SkillRuntime.MakeLifecycle(u8, v10, u1.MaxDuration, function() -- Line: 156
        -- upvalues: u8 (copy)
        u8.Is_Using_Skill = false;
        u8.Is_Attacking = false;
    end);

    for _, v in SkillRuntime.BindVFXMarkers(u8, v10, u1.EffectModule) do
        v11.conns[#v11.conns + 1] = v;
    end;

    v11.conns[#v11.conns + 1] = v10:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 167
        -- upvalues: u8 (copy), u1 (ref), Character (copy), SharedUtils (ref), SkillRuntime (ref), applyChainStun (ref)
        local v12 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");
        u8:PlayEffectModule(u1.EffectModule, "Screen", (v12 or Character).CFrame);

        if v12 then
            SharedUtils.PlaySoundAt(v12, u1.CastSFX, u1.CastVolume);
        end;

        u8:ShakeCamera("SkillHeavy");

        for _, v in SkillRuntime.HitboxSweep(u8, {
            Multiplier = u1.DamageMultiplier,
            Size = u1.HitboxSize,
            Range = u1.HitboxRange
        }) do
            if not v:GetAttribute("IsBoss") and u8:CanApplyStatusTo(v) then
                applyChainStun(v);
            end;
        end;
    end);
    v11.conns[#v11.conns + 1] = v10:GetMarkerReachedSignal("DBreset"):Connect(v11.cleanup);
end;

return u1;