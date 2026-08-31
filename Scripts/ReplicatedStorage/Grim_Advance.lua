--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Grim_Advance
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Reaper.Grim_Advance
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:34 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u8 = {
    AnimationName = "Ability_1",
    MaxDuration = 3,
    HitboxSize = Vector3.new(16, 10, 20),
    HitboxRange = 20,
    HitboxRange = 20,

    _SpawnClones = function(p1, p2) -- Line: 43, Name: _SpawnClones
        -- upvalues: ReplicatedStorage (copy)
        local v3 = p2.CloneCount or 3;
        local v4 = p2.CloneInterval or 0.1;
        local v5 = p2.CloneFadeDuration or 1;
        local v6 = p2.CloneColor or Color3.fromRGB(60, 0, 80);
        local Character = p1.Character;

        if not Character then
            return;
        end;

        local ShadowDash_Remote = ReplicatedStorage:FindFirstChild("ShadowDash_Remote");

        if not ShadowDash_Remote then
            return;
        end;

        for i = 1, v3 do
            ShadowDash_Remote:FireAllClients(Character, v6, v5);
            local v7;

            if i < v3 then
                task.wait(v4);
                v7 = i;
            else
                v7 = i;
            end;
        end;
    end
};

function u8._PerformHit(p9, p10) -- Line: 63
    -- upvalues: u8 (copy)
    local HitboxSize = p9.ClassData.HitboxSize;
    local Range = p9.ClassData.Range;
    p9.ClassData.HitboxSize = p10.HitboxSize or u8.HitboxSize;
    p9.ClassData.Range = p10.HitboxRange or u8.HitboxRange;
    local v11 = p9:QueryHitbox(p10.HitboxSize or u8.HitboxSize, p10.HitboxRange or u8.HitboxRange);
    p9.ClassData.HitboxSize = HitboxSize;
    p9.ClassData.Range = Range;
    local v12 = p9:ResolveSkillDamage(p10.DamageMultiplier);

    for _, v in v11 do
        p9:ApplyDamage(v.Character, v12);
    end;
end;

function u8.Activate(u13, u14) -- Line: 87
    -- upvalues: u8 (copy), Debris (copy), SharedUtils (copy)
    local v15 = u13.Animations[u8.AnimationName];

    if not v15 then
        warn("[Boss Grim_Advance] Animation not found:", u8.AnimationName);

        return;
    end;

    local Character = u13.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u13.Is_Using_Skill = true;
    u13.Is_Attacking = true;
    local u16 = false;
    v15:Play(0, 1, u14.AnimSpeed or 1);
    local v20 = v15:GetMarkerReachedSignal("dash"):Connect(function(p17) -- Line: 109
        -- upvalues: u13 (copy), u14 (copy), Debris (ref), SharedUtils (ref), u8 (ref)
        local v18 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if not v18 then
            return;
        end;

        local v19;

        if p17 == "Back" then
            v19 = -v18.CFrame.LookVector;
        else
            v19 = v18.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v19 * (u14.DashSpeed or 80);
        BodyVelocity.Parent = v18;
        Debris:AddItem(BodyVelocity, u14.DashDuration or 0.22);
        SharedUtils.PlaySoundAt(v18, "Dark_Chase", 1);
        task.spawn(u8._SpawnClones, u13, u14);
    end);
    local v23 = v15:GetMarkerReachedSignal("hit"):Connect(function(p21) -- Line: 133
        -- upvalues: u13 (copy), SharedUtils (ref), u8 (ref), u14 (copy)
        local v22 = u13.Character and u13.Character:FindFirstChild("HumanoidRootPart");

        if v22 then
            SharedUtils.PlaySoundAt(v22, "Dark_Crash", 1);
            SharedUtils.PlaySoundAt(v22, "Rolling_Swing", 1);
        end;

        if p21 == "" or not p21 then
            p21 = nil;
        end;

        u13:PlayTurnFX(p21);
        u8._PerformHit(u13, u14);
    end);
    v15.Stopped:Once(function() -- Line: 146
        -- upvalues: u16 (ref)
        u16 = true;
    end);
    task.delay(u8.MaxDuration, function() -- Line: 151
        -- upvalues: u16 (ref)
        u16 = true;
    end);

    while not u16 do
        task.wait();
    end;

    if v23 then
        v23:Disconnect();
    end;

    if v20 then
        v20:Disconnect();
    end;

    u13.Is_Using_Skill = false;
    u13.Is_Attacking = false;
end;

return u8;