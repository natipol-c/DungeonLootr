--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Playful_Cloud
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Unrestricted.Playful_Cloud
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:36 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_3",
    MaxDuration = 5.5,
    OpeningHitboxSize = Vector3.new(17, 12, 22),
    OpeningHitboxRange = 20,
    RapidfireHitboxSize = Vector3.new(15, 12, 20),
    RapidfireHitboxRange = 18,
    RandomSlashPool = { "Right_Slash", "Left_Slash" },
    DashSpeed = 65,
    DashDuration = 0.2,
    DashBackSFX = "sukuna_slash_single"
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

local function RandomOffset(p3) -- Line: 71
    local v4 = (math.random() * 2 - 1) * p3;
    local v5 = (math.random() * 2 - 1) * p3;

    return Vector3.new(v4, 0, v5);
end;

function u1._SpawnClones(u6, p7) -- Line: 80
    -- upvalues: u2 (copy)
    if not u2 then
        return;
    end;

    local u8 = p7.CloneCount or 2;
    local u9 = p7.CloneInterval or 0.04;
    local u10 = p7.CloneFadeDuration or 0.6;
    local u11 = p7.CloneColor or Color3.fromRGB(255, 215, 0);
    local u12 = p7.CloneSpread or 6;
    task.spawn(function() -- Line: 89
        -- upvalues: u8 (copy), u6 (copy), u2 (ref), u10 (copy), u11 (copy), u12 (copy), u9 (copy)
        for i = 1, u8 do
            if not u6.Is_Using_Skill then
                break;
            end;

            local v13 = {
                Action = "Clone",
                FadeDuration = u10,
                Color = u11,
                NPCModel = u6.Character
            };
            local v14 = u12;
            local v15 = (math.random() * 2 - 1) * v14;
            local v16 = (math.random() * 2 - 1) * v14;
            v13.Offset = Vector3.new(v15, 0, v16);
            u2:FireAllClients(nil, v13);
            local v17;

            if i < u8 then
                task.wait(u9);
                v17 = i;
            else
                v17 = i;
            end;
        end;
    end);
end;

function u1._PerformHit(p18, p19, p20, p21) -- Line: 109
    local v22 = p18:QueryHitbox(p20, p21);
    local v23 = p18:ResolveSkillDamage(p19);

    for _, v in v22 do
        p18:ApplyDamage(v.Character, v23);
    end;
end;

function u1.Activate(u24, u25) -- Line: 121
    -- upvalues: u1 (copy), SharedUtils (copy), Debris (copy)
    local v26 = u24.Animations[u1.AnimationName];

    if not v26 then
        warn("[Boss Playful_Cloud] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u24.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u24.Is_Using_Skill = true;
    u24.Is_Attacking = true;
    local u27 = false;
    local u28 = u25.OpeningDamageMult or 5.5;
    local u29 = u25.DamageMultiplier or 2.5;
    local u30 = u25.OpeningHitboxSize or u1.OpeningHitboxSize;
    local u31 = u25.OpeningHitboxRange or u1.OpeningHitboxRange;
    local u32 = u25.HitboxSize or u1.RapidfireHitboxSize;
    local u33 = u25.HitboxRange or u1.RapidfireHitboxRange;
    v26:Play(0, 1, u25.AnimSpeed or 1);
    local u34 = 0;
    local v38 = v26:GetMarkerReachedSignal("hit"):Connect(function(p35) -- Line: 154
        -- upvalues: u34 (ref), u25 (copy), u24 (copy), u1 (ref), u28 (copy), u30 (copy), u31 (copy), u29 (copy), u32 (copy), u33 (copy)
        u34 = u34 + 1;
        u24:PlayCombatSound(u25.SwingSoundFolder or (u24.ClassData.SwingSoundFolder or "Chain_Swing"), nil, u24.ClassData.SwingVolume or 1);

        if u34 == 1 then
            if p35 == "" or not p35 then
                p35 = nil;
            end;

            u24:PlayTurnFX(p35);
            u1._PerformHit(u24, u28, u30, u31);

            return;
        end;

        local v36 = nil;

        if p35 == "Random" then
            local v37 = u25.RandomSlashPool or u1.RandomSlashPool;
            p35 = v37[math.random(1, #v37)];
        elseif p35 == "" then
            p35 = v36;
        end;

        u24:PlayTurnFX(p35);
        u1._PerformHit(u24, u29, u32, u33);

        if u34 % 3 == 0 then
            u1._SpawnClones(u24, u25);
        end;
    end);
    local v41 = v26:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 190
        -- upvalues: u24 (copy), SharedUtils (ref), u1 (ref), u25 (copy), Debris (ref)
        local v39 = u24.Character and u24.Character:FindFirstChild("HumanoidRootPart");

        if not v39 then
            return;
        end;

        SharedUtils.PlaySoundAt(v39, u1.DashBackSFX, u24.ClassData.SwingVolume or 1);
        local v40 = -v39.CFrame.LookVector;
        local Unit = Vector3.new(v40.X, 0, v40.Z).Unit;
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossPlayfulCloud_BackDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = Unit * (u25.DashSpeed or u1.DashSpeed);
        BodyVelocity.Parent = v39;
        Debris:AddItem(BodyVelocity, u25.DashDuration or u1.DashDuration);
    end);
    v26.Stopped:Once(function() -- Line: 214
        -- upvalues: u27 (ref)
        u27 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 219
        -- upvalues: u27 (ref)
        u27 = true;
    end);

    while not u27 do
        task.wait();
    end;

    if v38 then
        v38:Disconnect();
    end;

    if v41 then
        v41:Disconnect();
    end;

    u24.Is_Using_Skill = false;
    u24.Is_Attacking = false;
end;

return u1;