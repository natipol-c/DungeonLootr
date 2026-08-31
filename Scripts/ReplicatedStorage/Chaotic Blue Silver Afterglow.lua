--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Chaotic Blue Silver Afterglow
  Path:     game.ReplicatedStorage.Classes.Chaotic Fist.Skills.Chaotic Blue Silver Afterglow
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:58 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    Cooldown = 15,
    AnimationName = "Ability_4",
    BarrageDamageMultiplier = 0.21,
    BarrageInterval = 0.15,
    BarrageHitboxSize = Vector3.new(30, 30, 30),
    BarrageHitboxRange = 25,
    FinalDamageMultiplier = 3.75,
    FinalHitboxSize = Vector3.new(40, 40, 40),
    FinalHitboxRange = 25,
    PhantomCount = 6,
    PhantomRadius = 10,
    PhantomDamageMult = 0.2,
    PhantomDuration = 4,
    PhantomInterval = 0.15,
    PhantomHitboxSize = Vector3.new(20, 20, 20),
    PhantomHitboxRange = 15,
    PhantomColor = Color3.fromRGB(220, 30, 30),
    PhantomFadeDuration = 1.5,
    PhantomPauseAtEnd = 0.5,
    MaxDuration = 8
};
local u2 = nil;

local function GetPhantomRemote() -- Line: 69
    -- upvalues: u2 (ref), ReplicatedStorage (copy)
    if u2 then
        return u2;
    end;

    local v3 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes");

    if not v3 then
        return nil;
    end;

    u2 = v3:FindFirstChild("PhantomAttack");

    if not u2 then
        u2 = Instance.new("RemoteEvent");
        u2.Name = "PhantomAttack";
        u2.Parent = v3;
    end;

    return u2;
end;

function u1._EnsureAnimation(p4) -- Line: 87
    -- upvalues: u1 (copy), ReplicatedStorage (copy)
    local AnimationName = u1.AnimationName;

    if p4.Animations[AnimationName] then
        return p4.Animations[AnimationName];
    end;

    local v5 = ReplicatedStorage.Classes:FindFirstChild(p4.ClassName);

    if not v5 then
        return nil;
    end;

    local Skill_Animations = v5:FindFirstChild("Skill_Animations");

    if not Skill_Animations then
        return nil;
    end;

    local v6 = Skill_Animations:FindFirstChild(u1.AnimationName);

    if not v6 then
        return nil;
    end;

    local v7 = p4.Humanoid and p4.Humanoid:FindFirstChildOfClass("Animator");

    if not v7 then
        return nil;
    end;

    local v8 = v7:LoadAnimation(v6);
    v8.Priority = Enum.AnimationPriority.Action3;
    v8:Play(0, 0, 0);
    v8:Stop(0);
    p4.Animations[AnimationName] = v8;

    return v8;
end;

local function FirePartIclesFX(p9) -- Line: 113
    -- upvalues: CollectionService (copy)
    if not p9 then
        return;
    end;

    if not p9:HasTag("ParticleObject") then
        CollectionService:AddTag(p9, "ParticleObject");
    end;

    p9:SetAttribute("PartIcles_Fire", not p9:GetAttribute("PartIcles_Fire"));
end;

local function FireParticles(p10: userdata) -- Line: 121
    if not p10:HasTag("ParticleObject") then
        p10:AddTag("ParticleObject");
    end;

    p10:SetAttribute("Fire", not p10:GetAttribute("Fire"));
end;

function u1._PerformBarrageHit(p11) -- Line: 128
    -- upvalues: u1 (copy)
    local HitboxSize = p11.ClassData.HitboxSize;
    local Range = p11.ClassData.Range;
    p11.ClassData.HitboxSize = u1.BarrageHitboxSize;
    p11.ClassData.Range = u1.BarrageHitboxRange;
    local v12 = p11:Hitbox();
    p11.ClassData.HitboxSize = HitboxSize;
    p11.ClassData.Range = Range;

    for _, v in v12 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p11:ApplyDamage(v, (p11:ResolveSkillDamage(u1.BarrageDamageMultiplier, v)));
        end;
    end;
end;

function u1._PerformFinalHit(p13) -- Line: 148
    -- upvalues: u1 (copy)
    local HitboxSize = p13.ClassData.HitboxSize;
    local Range = p13.ClassData.Range;
    p13.ClassData.HitboxSize = u1.FinalHitboxSize;
    p13.ClassData.Range = u1.FinalHitboxRange;
    local v14 = p13:Hitbox();
    p13.ClassData.HitboxSize = HitboxSize;
    p13.ClassData.Range = Range;

    for _, v in v14 do
        if not v:HasTag("Ignore_Damage") and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) then
            p13:ApplyDamage(v, (p13:ResolveSkillDamage(u1.FinalDamageMultiplier, v)));
        end;
    end;
end;

function u1._SpawnPhantomFormation(u15) -- Line: 170
    -- upvalues: GetPhantomRemote (copy), u1 (copy), CollectionService (copy)
    local v16 = GetPhantomRemote();

    if not v16 then
        return;
    end;

    local Player = u15.Player;

    if not Player then
        return;
    end;

    local v17 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

    if not v17 then
        return;
    end;

    local v18 = Player:GetAttribute("Active_Class") or "";
    local Position = v17.Position;
    local u19 = u1.BarrageDamageMultiplier * u1.PhantomDamageMult;

    for i = 1, u1.PhantomCount do
        local v20 = (i - 1) * (6.283185307179586 / u1.PhantomCount);
        local v21 = math.cos(v20) * u1.PhantomRadius;
        local v22 = math.sin(v20) * u1.PhantomRadius;
        local u23 = Position + Vector3.new(v21, 0, v22);
        local CFrame_lookAt_ret = CFrame.lookAt(u23, Position);
        v16:FireAllClients(Player, {
            ClassName = v18,
            AnimationName = u1.AnimationName,
            FXNames = { "Ability_4" },
            Color = u1.PhantomColor,
            FadeDuration = u1.PhantomFadeDuration,
            PauseAtEnd = u1.PhantomPauseAtEnd,
            AttackSpeed = u15:GetEffectiveStat("AttackSpeed") or 1,
            SwingSoundFolder = u15.ClassData.SwingSoundFolder,
            Position = CFrame_lookAt_ret
        });
        task.spawn(function() -- Line: 208
            -- upvalues: u1 (ref), CollectionService (ref), u23 (copy), u15 (copy), u19 (copy)
            local v24 = 0;

            while v24 < u1.PhantomDuration do
                for _, v in CollectionService:GetTagged("Enemy") do
                    if v.Parent and (not v:GetAttribute("Dead") or v:GetAttribute("Can_Finish")) and not v:HasTag("Ignore_Damage") then
                        local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart");

                        if HumanoidRootPart and (HumanoidRootPart.Position - u23).Magnitude <= u1.PhantomHitboxRange then
                            u15:ApplyDamage(v, (u15:ResolveSkillDamage(u19, v)));
                            local NormalHit = HumanoidRootPart:FindFirstChild("NormalHit");

                            if NormalHit then
                                if not NormalHit:HasTag("ParticleObject") then
                                    NormalHit:AddTag("ParticleObject");
                                end;

                                NormalHit:SetAttribute("Fire", not NormalHit:GetAttribute("Fire"));
                            end;
                        end;
                    end;
                end;

                task.wait(u1.PhantomInterval);
                v24 = v24 + u1.PhantomInterval;
            end;
        end);
        local _ = i;
    end;
end;

function u1.CanActivate(p25) -- Line: 241
    if p25.Is_Attacking then
        return false, "Attacking";
    end;

    if p25.Is_Using_Skill then
        return false, "Skill in progress";
    end;

    if p25.Is_Dodging then
        return false, "Dodging";
    end;

    if p25.Is_Stunned then
        return false, "Stunned";
    end;

    return true;
end;

function u1.Activate(u26, p27) -- Line: 249
    -- upvalues: u1 (copy), CollectionService (copy), SharedUtils (copy)
    local v28 = u1._EnsureAnimation(u26);

    if not v28 then
        warn("[Chaotic Blue Silver Afterglow] Animation not found");

        return;
    end;

    local Character = u26.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u26.Is_Using_Skill = true;
    u26.Is_Attacking = true;
    Character.Anchored = true;

    for i, v in u26.Animations do
        if i:match("^Attack_") and v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    local u29 = false;
    local u30 = nil;
    local u31 = false;
    v28:Play(0, 1, 1);
    u1._SpawnPhantomFormation(u26);
    local u33 = v28:GetMarkerReachedSignal("Particle_Fire"):Connect(function() -- Line: 286
        -- upvalues: u26 (copy), CollectionService (ref)
        local v32 = u26.FX and u26.FX.Compass;

        if not v32 then
            return;
        end;

        if not v32:HasTag("ParticleObject") then
            CollectionService:AddTag(v32, "ParticleObject");
        end;

        v32:SetAttribute("PartIcles_Fire", not v32:GetAttribute("PartIcles_Fire"));
    end);
    local u34 = v28:GetMarkerReachedSignal("hit_start"):Connect(function() -- Line: 293
        -- upvalues: u26 (copy), u31 (ref), u29 (ref), u30 (ref), u1 (ref)
        u26:SetLoopFX("Afterglow_Barrage", true);
        u31 = true;
        u29 = true;
        u30 = task.spawn(function() -- Line: 300
            -- upvalues: u29 (ref), u1 (ref), u26 (ref)
            while u29 do
                u1._PerformBarrageHit(u26);
                u26:PlayCombatSound(u26.ClassData.SwingSoundFolder or "Naoya_Punches", nil, u26.ClassData.SwingVolume or 0.5);
                u26:ShakeCamera("Hit");
                task.wait(u1.BarrageInterval);
            end;
        end);
    end);
    local u35 = v28:GetMarkerReachedSignal("hit_end"):Connect(function() -- Line: 315
        -- upvalues: u29 (ref), u30 (ref), u31 (ref), u26 (copy)
        u29 = false;

        if u30 then
            task.cancel(u30);
            u30 = nil;
        end;

        if u31 then
            u26:SetLoopFX("Afterglow_Barrage", false);
            u31 = false;
        end;
    end);
    local u37 = v28:GetMarkerReachedSignal("hit_final"):Connect(function() -- Line: 331
        -- upvalues: Character (copy), u26 (copy), SharedUtils (ref), u1 (ref)
        if Character and Character.Parent then
            Character.Anchored = false;
        end;

        u26:PlayFX("Ability_4_Large");
        u26:ShakeCamera("SkillHeavy");
        local v36 = u26.Character and u26.Character:FindFirstChild("HumanoidRootPart");

        if v36 then
            SharedUtils.PlaySoundAt(v36, "lightningcrash", 1);
        end;

        u1._PerformFinalHit(u26);
    end);
    local u38 = nil;
    local u39 = false;

    local function releaseState() -- Line: 351
        -- upvalues: u39 (ref), u26 (copy)
        if u39 then
            return;
        end;

        u39 = true;
        u26.Is_Using_Skill = false;
        u26.Is_Attacking = false;
    end;

    local function cleanup() -- Line: 359
        -- upvalues: u33 (ref), u34 (ref), u35 (ref), u37 (ref), u38 (ref), u29 (ref), u30 (ref), u31 (ref), u26 (copy), Character (copy), u39 (ref)
        if u33 then
            u33:Disconnect();
        end;

        if u34 then
            u34:Disconnect();
        end;

        if u35 then
            u35:Disconnect();
        end;

        if u37 then
            u37:Disconnect();
        end;

        if u38 then
            u38:Disconnect();
        end;

        u29 = false;

        if u30 then
            pcall(task.cancel, u30);
            u30 = nil;
        end;

        if u31 then
            u26:SetLoopFX("Afterglow_Barrage", false);
            u31 = false;
        end;

        if Character and Character.Parent then
            Character.Anchored = false;
        end;

        if u39 then
            return;
        end;

        u39 = true;
        u26.Is_Using_Skill = false;
        u26.Is_Attacking = false;
    end;

    u38 = v28:GetMarkerReachedSignal("DBreset"):Connect(releaseState);
    v28.Stopped:Once(cleanup);
    task.delay(u1.MaxDuration, cleanup);
end;

return u1;