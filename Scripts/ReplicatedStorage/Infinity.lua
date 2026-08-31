--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Infinity
  Path:     game.ReplicatedStorage.Classes.Honored One.Skills.Infinity
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
local RigMap = require(ReplicatedStorage.Globals.Modules.RigMap);
local u1 = {
    ManagesCooldown = true,
    AnimationName = "Ability_4",
    ActivationLock = 0.3,
    InfinityDuration = 30,
    InfinityCooldown = 45,
    InfinityDamageReduction = 50,
    InfinityAttackSpeed = 0.15,
    InfinityMoveSpeed = 0.15,
    InfinityAuraFolder = "Skill4",
    InfinityAuraTag = "HonoredOne_InfinityAura",
    RCTDuration = 5,
    RCTCooldown = 30,
    RCTInstantHeal = 0.2,
    RCTRegenTotal = 0.05,
    RCTRegenTicks = 10,
    RCTAuraFolder = "Skill4 Alt",
    RCTAuraTag = "HonoredOne_RCTAura"
};
local u2 = {
    Head = "Head",
    Torso = "Torso",
    Right_Arm = "Right Arm",
    Left_Arm = "Left Arm",
    Right_Leg = "Right Leg",
    Left_Leg = "Left Leg"
};

local function weldAura(p3: any, p4: string, p5: string) -- Line: 85
    -- upvalues: ReplicatedStorage (copy), u2 (copy), RigMap (copy)
    local Character = p3.Character;

    if not Character then
        return;
    end;

    local v6 = ReplicatedStorage.Classes:FindFirstChild(p3.ClassName);

    if v6 then
        v6 = v6:FindFirstChild("VFX");
    end;

    if v6 then
        v6 = v6:FindFirstChild(p4);
    end;

    if not v6 then
        warn((`[Infinity] aura folder "VFX/{p4}" not found`));

        return;
    end;

    local v7 = Character:FindFirstChild(p5);

    if v7 then
        v7:Destroy();
    end;

    local Folder = Instance.new("Folder");
    Folder.Name = p5;
    Folder:AddTag(p5);
    Folder.Parent = Character;

    for _, child in v6:GetChildren() do
        if child:IsA("BasePart") then
            local v8 = u2[child.Name];
            local v9, v10;

            if v8 then
                v9, v10 = RigMap.GetWeldTarget(Character, v8);
            else
                v9 = nil;
                v10 = nil;
            end;

            if v9 then
                local v11 = child:Clone();
                v11.Anchored = false;
                v11.CanCollide = false;
                v11.CanQuery = false;
                local Weld = Instance.new("Weld");
                Weld.Name = child.Name .. "_Weld";
                Weld.Part0 = v9;
                Weld.Part1 = v11;

                if v10 then
                    Weld.C0 = v10.CFrame;
                    v11.CFrame = v9.CFrame * v10.CFrame;
                else
                    v11.CFrame = v9.CFrame;
                end;

                Weld.Parent = v11;
                v11.Parent = Folder;
            end;
        end;
    end;
end;

local function unweldAura(p12: any, p13: string) -- Line: 136
    local Character = p12.Character;

    if Character then
        Character = Character:FindFirstChild(p13);
    end;

    if Character then
        Character:Destroy();
    end;
end;

local function applyInfinityBuffs(p14) -- Line: 144
    -- upvalues: u1 (copy)
    p14.StatModifiers.AttackSpeed = (p14.StatModifiers.AttackSpeed or 0) + u1.InfinityAttackSpeed * (p14.ClassData.AttackSpeed or 1);

    if p14.Player then
        p14.Player:SetAttribute("Skill_DamageReduction", u1.InfinityDamageReduction);
    end;

    if p14.Humanoid then
        p14.Humanoid:SetAttribute("Skill_MoveSpeedBonus", u1.InfinityMoveSpeed);

        if not p14.SlowingDown then
            p14:Slowdown(false);
        end;
    end;
end;

local function removeInfinityBuffs(p15) -- Line: 165
    -- upvalues: u1 (copy)
    p15.StatModifiers.AttackSpeed = math.max(0, (p15.StatModifiers.AttackSpeed or 0) - u1.InfinityAttackSpeed * (p15.ClassData.AttackSpeed or 1));

    if p15.Player then
        p15.Player:SetAttribute("Skill_DamageReduction", nil);
    end;

    if p15.Humanoid then
        p15.Humanoid:SetAttribute("Skill_MoveSpeedBonus", nil);

        if not p15.SlowingDown then
            p15:Slowdown(false);
        end;
    end;
end;

local function playCastPose(p16) -- Line: 183
    -- upvalues: SkillRuntime (copy), u1 (copy)
    local v17 = SkillRuntime.EnsureAnimation(p16, u1.AnimationName);

    if v17 then
        SkillRuntime.StopAttackAnims(p16);
        v17:Play(0, 1, 1);
    end;
end;

local function releaseCastLock(u18) -- Line: 192
    -- upvalues: u1 (copy)
    task.delay(u1.ActivationLock, function() -- Line: 193
        -- upvalues: u18 (copy)
        u18.Is_Using_Skill = false;
    end);
end;

local function addMovesetSwap(p19) -- Line: 198
    p19.SpecialMoveset = (p19.SpecialMoveset or 0) + 1;
end;

local function removeMovesetSwap(p20) -- Line: 202
    p20.SpecialMoveset = math.max(0, (p20.SpecialMoveset or 0) - 1);

    if p20.SpecialMoveset == 0 then
        p20.TurnCount = 1;
        p20._animHitIndex = 0;
    end;
end;

local function startCooldown(p21: any, p22: any, p23: number) -- Line: 215
    local Player = p21.Player;
    local v24 = (not Player and 0 or (Player:GetAttribute("Stat_CooldownReduction") or 0) / 100) + (p21._bonusCDR or 0);

    if v24 > 0 then
        p23 = p23 * math.max(0, 1 - v24);
    end;

    p21.Skill_Cooldowns[p22] = os.clock() + p23;

    if Player then
        local u25 = "Skill" .. tostring(p22);
        local v26 = os.clock() + p23;
        Player:SetAttribute(u25 .. "_CooldownDuration", p23);
        Player:SetAttribute(u25 .. "_CooldownEnd", v26);
        Player:SetAttribute(u25 .. "_OnCooldown", true);
        task.delay(p23, function() -- Line: 238
            -- upvalues: Player (copy), u25 (copy)
            if Player and (Player.Parent and (Player:GetAttribute(u25 .. "_CooldownEnd") or 0) <= os.clock()) then
                Player:SetAttribute(u25 .. "_OnCooldown", false);
            end;
        end);
    end;
end;

function u1._startInfinity(u27) -- Line: 249
    -- upvalues: SkillRuntime (copy), u1 (copy), applyInfinityBuffs (copy), weldAura (copy)
    u27._infinityActive = true;
    local v28 = SkillRuntime.EnsureAnimation(u27, u1.AnimationName);

    if v28 then
        SkillRuntime.StopAttackAnims(u27);
        v28:Play(0, 1, 1);
    end;

    u27.SpecialMoveset = (u27.SpecialMoveset or 0) + 1;
    applyInfinityBuffs(u27);
    weldAura(u27, u1.InfinityAuraFolder, u1.InfinityAuraTag);
    task.delay(u1.ActivationLock, function() -- Line: 193
        -- upvalues: u27 (copy)
        u27.Is_Using_Skill = false;
    end);
    task.delay(u1.InfinityDuration, function() -- Line: 258
        -- upvalues: u1 (ref), u27 (copy)
        u1._endInfinity(u27);
    end);
end;

function u1._endInfinity(p29) -- Line: 263
    -- upvalues: removeInfinityBuffs (copy), u1 (copy)
    if not p29._infinityActive then
        return;
    end;

    p29._infinityActive = false;
    p29.SpecialMoveset = math.max(0, (p29.SpecialMoveset or 0) - 1);

    if p29.SpecialMoveset == 0 then
        p29.TurnCount = 1;
        p29._animHitIndex = 0;
    end;

    removeInfinityBuffs(p29);
    local InfinityAuraTag = u1.InfinityAuraTag;
    local Character = p29.Character;

    if Character then
        Character = Character:FindFirstChild(InfinityAuraTag);
    end;

    if Character then
        Character:Destroy();
    end;
end;

function u1._startRCT(u30) -- Line: 275
    -- upvalues: SkillRuntime (copy), u1 (copy), weldAura (copy)
    u30._rctActive = true;
    local v31 = SkillRuntime.EnsureAnimation(u30, u1.AnimationName);

    if v31 then
        SkillRuntime.StopAttackAnims(u30);
        v31:Play(0, 1, 1);
    end;

    u30.SpecialMoveset = (u30.SpecialMoveset or 0) + 1;
    weldAura(u30, u1.RCTAuraFolder, u1.RCTAuraTag);
    task.delay(u1.ActivationLock, function() -- Line: 193
        -- upvalues: u30 (copy)
        u30.Is_Using_Skill = false;
    end);
    local Humanoid = u30.Humanoid;

    if Humanoid and Humanoid.Health > 0 then
        local MaxHealth = Humanoid.MaxHealth;
        Humanoid.Health = math.min(MaxHealth, Humanoid.Health + u1.RCTInstantHeal * MaxHealth);
    end;

    task.spawn(function() -- Line: 291
        -- upvalues: u1 (ref), u30 (copy)
        local RCTRegenTicks = u1.RCTRegenTicks;
        local v32 = u1.RCTRegenTotal / RCTRegenTicks;
        local v33 = u1.RCTDuration / RCTRegenTicks;

        for i = 1, RCTRegenTicks do
            task.wait(v33);

            if not u30._rctActive then
                break;
            end;

            local Humanoid2 = u30.Humanoid;
            local v34;

            if Humanoid2 and Humanoid2.Health > 0 then
                Humanoid2.Health = math.min(Humanoid2.MaxHealth, Humanoid2.Health + v32 * Humanoid2.MaxHealth);
                v34 = i;
            else
                v34 = i;
            end;
        end;
    end);
    task.delay(u1.RCTDuration, function() -- Line: 305
        -- upvalues: u1 (ref), u30 (copy)
        u1._endRCT(u30);
    end);
end;

function u1._endRCT(p35) -- Line: 310
    -- upvalues: u1 (copy)
    if not p35._rctActive then
        return;
    end;

    p35._rctActive = false;
    p35.SpecialMoveset = math.max(0, (p35.SpecialMoveset or 0) - 1);

    if p35.SpecialMoveset == 0 then
        p35.TurnCount = 1;
        p35._animHitIndex = 0;
    end;

    local RCTAuraTag = u1.RCTAuraTag;
    local Character = p35.Character;

    if Character then
        Character = Character:FindFirstChild(RCTAuraTag);
    end;

    if Character then
        Character:Destroy();
    end;
end;

function u1.CanActivate(p36) -- Line: 321
    if p36.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p36.Is_Attacking then
        return false, "Attacking";
    end;

    if p36.Is_Dodging then
        return false, "Dodging";
    end;

    if p36.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(p37, p38) -- Line: 332
    -- upvalues: u1 (copy), startCooldown (copy)
    u1._startInfinity(p37);
    startCooldown(p37, p38, u1.InfinityDuration + u1.InfinityCooldown);
end;

function u1.ActivateHold(p39, p40) -- Line: 338
    -- upvalues: u1 (copy), startCooldown (copy)
    u1._startRCT(p39);
    startCooldown(p39, p40, u1.RCTDuration + u1.RCTCooldown);
end;

return u1;