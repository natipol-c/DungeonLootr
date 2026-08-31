--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Pack Hunt
  Path:     game.ReplicatedStorage.Classes.Coyote.Skills.Pack Hunt
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:57 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = {
    Cooldown = 8,
    MaxCharges = 2,
    DamageMultiplier = 1,
    AnimationName = "Ability_2",
    HitboxSize = Vector3.new(40, 10, 40),
    HitboxRange = 20,
    IFrameDuration = 1.2,
    ClonesPerHit = 2,
    CloneInterval = 0.04,
    CloneFadeDuration = 0.7,
    CloneColor = Color3.fromRGB(80, 150, 255),
    LoopFX = "Hunt",
    MaxDuration = 1.5,
    HoldAnimationName = "Ability_2_Hold",
    SummonCount = 2,
    SummonLifetime = 20,
    SummonColor = Color3.fromRGB(140, 200, 255),
    SummonDamageRate = 0.7,
    HoldDodgeDuration = 0.6,
    SummonBeatDelay = 0.3,
    HoldMaxDuration = 1.5
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._EnsureAnimation(p3, p4) -- Line: 79
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local v5 = p4 or u1.AnimationName;

    if p3.Animations[v5] then
        return p3.Animations[v5];
    end;

    local v6 = ReplicatedStorage.Classes:FindFirstChild(p3.ClassName);

    if not v6 then
        return nil;
    end;

    local Skill_Animations = v6:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v7 = Skill_Animations:FindFirstChild(v5);

    if not v7 then
        return nil;
    end;

    local v8 = p3.Humanoid and p3.Humanoid:FindFirstChildOfClass("Animator");

    if not v8 then
        return nil;
    end;

    local v9 = v8:LoadAnimation(v7);
    v9.Priority = Enum.AnimationPriority.Action3;
    v9:Play(0, 0, 0);
    v9:Stop(0);
    p3.Animations[v5] = v9;

    return v9;
end;

function u1._PerformHit(p10) -- Line: 107
    -- upvalues: u1 (copy)
    local HitboxSize = p10.ClassData.HitboxSize;
    local Range = p10.ClassData.Range;
    p10.ClassData.HitboxSize = u1.HitboxSize;
    p10.ClassData.Range = u1.HitboxRange;
    local v11 = p10:Hitbox();
    p10.ClassData.HitboxSize = HitboxSize;
    p10.ClassData.Range = Range;
    local v12 = 0;

    for _, v in v11 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p10:ApplyDamage(v, (p10:ResolveSkillDamage(u1.DamageMultiplier, v)));
            v12 = v12 + 1;
        end;
    end;

    return v12;
end;

function u1._SpawnClones(u13) -- Line: 132
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    task.spawn(function() -- Line: 135
        -- upvalues: u1 (ref), u13 (copy), u2 (ref)
        for i = 1, u1.ClonesPerHit do
            if not u13.Is_Using_Skill then
                break;
            end;

            u2:FireAllClients(u13.Player, {
                Action = "Clone",
                FadeDuration = u1.CloneFadeDuration,
                Color = u1.CloneColor
            });
            local v14;

            if i < u1.ClonesPerHit then
                task.wait(u1.CloneInterval);
                v14 = i;
            else
                v14 = i;
            end;
        end;
    end);
end;

function u1.CanActivate(p15) -- Line: 154
    if p15.Is_Attacking then
        return false, "Attacking";
    end;

    if p15.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p15.Is_Dodging then
        return false, "Dodging";
    end;

    if p15.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u16, p17) -- Line: 162
    -- upvalues: u1 (copy)
    local v18 = u1._EnsureAnimation(u16);

    if not v18 then
        warn("[Pack Hunt] Animation not found");

        return;
    end;

    u16.Is_Using_Skill = true;
    u16.Is_Attacking = true;

    if u16.Player then
        u16.Player:SetAttribute("iFrame", true);
    end;

    u16.Character:SetAttribute("iFrame", true);
    task.delay(u1.IFrameDuration, function() -- Line: 176
        -- upvalues: u16 (copy)
        local Player = u16.Player;
        local Character = u16.Character;

        if Player then
            Player:SetAttribute("iFrame", false);
        end;

        if Character then
            Character:SetAttribute("iFrame", false);
        end;
    end);
    u16.Character:SetAttribute("Skill_Camera_Stabilize", true);

    for i, v in u16.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v18:Play(0, 1, 1);
    local u19 = {};

    local function disconnectAll() -- Line: 197
        -- upvalues: u19 (copy)
        for _, v in u19 do
            v:Disconnect();
        end;

        table.clear(u19);
    end;

    local u20 = false;

    local function releaseState() -- Line: 203
        -- upvalues: u20 (ref), u16 (copy)
        if u20 then
            return;
        end;

        u20 = true;
        u16.Is_Using_Skill = false;
        u16.Is_Attacking = false;
    end;

    local u21 = false;

    local function disableHuntFX() -- Line: 213
        -- upvalues: u21 (ref), u16 (copy), u1 (ref)
        if not u21 then
            return;
        end;

        u21 = false;
        u16:SetLoopFX(u1.LoopFX, false);
    end;

    u19[#u19 + 1] = v18:GetMarkerReachedSignal("hit"):Connect(function(p22) -- Line: 220
        -- upvalues: u21 (ref), u16 (copy), u1 (ref)
        if not u21 then
            u21 = true;
            u16:SetLoopFX(u1.LoopFX, true);
        end;

        u16:PlayCombatSound(u16.ClassData.SwingSoundFolder or "Cero_Shoot", nil, u16.ClassData.SwingVolume or 0.5);
        u16:ShakeCamera("SkillLight");
        u1._SpawnClones(u16);
        u1._PerformHit(u16);
    end);
    u19[#u19 + 1] = v18:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 235
        -- upvalues: u21 (ref), u16 (copy), u1 (ref), u20 (ref)
        if u21 then
            u21 = false;
            u16:SetLoopFX(u1.LoopFX, false);
        end;

        if u20 then
            return;
        end;

        u20 = true;
        u16.Is_Using_Skill = false;
        u16.Is_Attacking = false;
    end);
    v18.Stopped:Once(function() -- Line: 242
        -- upvalues: u20 (ref), u16 (copy), u21 (ref), u1 (ref), u19 (copy)
        if not u20 then
            u20 = true;
            u16.Is_Using_Skill = false;
            u16.Is_Attacking = false;
        end;

        if u21 then
            u21 = false;
            u16:SetLoopFX(u1.LoopFX, false);
        end;

        for _, v in u19 do
            v:Disconnect();
        end;

        table.clear(u19);

        if u16.Player then
            u16.Player:SetAttribute("iFrame", false);
        end;

        if u16.Character then
            u16.Character:SetAttribute("iFrame", false);
            u16.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 253
        -- upvalues: u20 (ref), u16 (copy), u21 (ref), u1 (ref), u19 (copy)
        if not u20 then
            u20 = true;
            u16.Is_Using_Skill = false;
            u16.Is_Attacking = false;
        end;

        if u21 then
            u21 = false;
            u16:SetLoopFX(u1.LoopFX, false);
        end;

        for _, v in u19 do
            v:Disconnect();
        end;

        table.clear(u19);

        if u16.Player then
            u16.Player:SetAttribute("iFrame", false);
        end;

        if u16.Character then
            u16.Character:SetAttribute("iFrame", false);
            u16.Character:SetAttribute("Skill_Camera_Stabilize", false);
        end;
    end);
end;

function u1.ActivateHold(u23, p24) -- Line: 270
    -- upvalues: u1 (copy)
    local v25 = u1._EnsureAnimation(u23, u1.HoldAnimationName);

    if not v25 then
        warn("[Pack Hunt] Hold animation not found");

        return;
    end;

    local Character = u23.Character;
    local v26;

    if Character then
        v26 = Character:FindFirstChild("HumanoidRootPart");
    else
        v26 = Character;
    end;

    if not v26 then
        return;
    end;

    u23.Is_Using_Skill = true;
    u23.Is_Attacking = true;
    Character:SetAttribute("Dodge", true);
    task.delay(u1.HoldDodgeDuration, function() -- Line: 287
        -- upvalues: Character (copy)
        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end);

    for i, v in u23.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    v25:Play(0, 1, 1);
    local u27 = false;

    local function doSummon() -- Line: 304
        -- upvalues: u27 (ref), u23 (copy), u1 (ref)
        if u27 then
            return;
        end;

        u27 = true;
        u23:SummonClones({
            Count = u1.SummonCount,
            Lifetime = u1.SummonLifetime,
            Color = u1.SummonColor,
            DamageRate = u1.SummonDamageRate
        });
        u23:ShakeCamera("SkillMedium");
    end;

    local u28 = {};

    local function _() -- Line: 318
        -- upvalues: u28 (copy)
        for _, v in u28 do
            v:Disconnect();
        end;

        table.clear(u28);
    end;

    local u29 = false;

    local function _() -- Line: 324
        -- upvalues: u29 (ref), u23 (copy), Character (copy)
        if u29 then
            return;
        end;

        u29 = true;
        u23.Is_Using_Skill = false;
        u23.Is_Attacking = false;

        if Character then
            Character:SetAttribute("Dodge", false);
        end;
    end;

    u28[#u28 + 1] = v25:GetMarkerReachedSignal("hit"):Connect(doSummon);
    u28[#u28 + 1] = v25:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 335
        -- upvalues: u29 (ref), u23 (copy), Character (copy), u28 (copy)
        if not u29 then
            u29 = true;
            u23.Is_Using_Skill = false;
            u23.Is_Attacking = false;

            if Character then
                Character:SetAttribute("Dodge", false);
            end;
        end;

        for _, v in u28 do
            v:Disconnect();
        end;

        table.clear(u28);
    end);
    task.delay(u1.SummonBeatDelay, doSummon);
    v25.Stopped:Once(function() -- Line: 342
        -- upvalues: u29 (ref), u23 (copy), Character (copy), u28 (copy)
        if not u29 then
            u29 = true;
            u23.Is_Using_Skill = false;
            u23.Is_Attacking = false;

            if Character then
                Character:SetAttribute("Dodge", false);
            end;
        end;

        for _, v in u28 do
            v:Disconnect();
        end;

        table.clear(u28);
    end);
    task.delay(u1.HoldMaxDuration, function() -- Line: 346
        -- upvalues: u29 (ref), u23 (copy), Character (copy), u28 (copy)
        if not u29 then
            u29 = true;
            u23.Is_Using_Skill = false;
            u23.Is_Attacking = false;

            if Character then
                Character:SetAttribute("Dodge", false);
            end;
        end;

        for _, v in u28 do
            v:Disconnect();
        end;

        table.clear(u28);
    end);
end;

return u1;