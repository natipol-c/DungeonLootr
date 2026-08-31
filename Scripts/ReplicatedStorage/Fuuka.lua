--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Fuuka
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Zero.Fuuka
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_1",
    MaxDuration = 2.5,
    HitboxSize = Vector3.new(26, 20, 32),
    HitboxRange = 28,
    DashSpeed = 90,
    DashDuration = 0.29,
    SlashesFX = "Slashes",
    SlashesHits = 3,
    SwingSFXFolder = "Power_Swing_Fast",
    CloneCount = 5,
    CloneInterval = 0.05,
    CloneFadeDuration = 2,
    CloneColor = Color3.fromRGB(0, 200, 255),
    JudgementVolume = 0.6,
    SheatheVolume = 0.8
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._SpawnClones(u3) -- Line: 81
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    task.spawn(function() -- Line: 84
        -- upvalues: u1 (ref), u3 (copy), u2 (ref)
        for i = 1, u1.CloneCount do
            if not u3.Is_Using_Skill then
                break;
            end;

            u2:FireAllClients(nil, {
                Action = "Clone",
                FadeDuration = u1.CloneFadeDuration,
                Color = u1.CloneColor,
                NPCModel = u3.Character
            });
            local v4;

            if i < u1.CloneCount then
                task.wait(u1.CloneInterval);
                v4 = i;
            else
                v4 = i;
            end;
        end;
    end);
end;

function u1._PerformHit(p5, p6) -- Line: 103
    -- upvalues: u1 (copy)
    local v7 = p5:QueryHitbox(p6.HitboxSize or u1.HitboxSize, p6.HitboxRange or u1.HitboxRange);
    local v8 = p5:ResolveSkillDamage(p6.DamageMultiplier);

    for _, v in v7 do
        p5:ApplyDamage(v.Character, v8);
    end;
end;

function u1.Activate(u9, u10) -- Line: 118
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local v11 = u9.Animations[u1.AnimationName];

    if not v11 then
        warn("[Boss Fuuka] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u9.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u9.Is_Using_Skill = true;
    u9.Is_Attacking = true;
    local u12 = u10.DashSpeed or u1.DashSpeed;
    local u13 = u10.DashDuration or u1.DashDuration;
    v11:Play(0, 1, u10.AnimSpeed or 1);
    local u14 = {};

    local function disconnectAll() -- Line: 141
        -- upvalues: u14 (copy)
        for _, v in u14 do
            v:Disconnect();
        end;

        table.clear(u14);
    end;

    u14[#u14 + 1] = v11:GetMarkerReachedSignal("dash"):Connect(function() -- Line: 147
        -- upvalues: u9 (copy), u12 (copy), Debris (ref), u13 (copy), u1 (ref), SharedUtils (ref)
        local v15 = u9.Character and u9.Character:FindFirstChild("HumanoidRootPart");

        if not v15 then
            return;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v15.CFrame.LookVector * u12;
        BodyVelocity.Parent = v15;
        Debris:AddItem(BodyVelocity, u13);
        u1._SpawnClones(u9);
        SharedUtils.PlaySoundAt(v15, "Judgement_Cut", u1.JudgementVolume);
    end);
    local u16 = 0;
    u14[#u14 + 1] = v11:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 165
        -- upvalues: u16 (ref), u1 (ref), u9 (copy), u10 (copy)
        u16 = u16 + 1;

        if u16 <= u1.SlashesHits then
            u9:PlayTurnFX(u1.SlashesFX);
        else
            if p17 == "" or not p17 then
                p17 = nil;
            end;

            u9:PlayTurnFX(p17);
        end;

        u9:PlayCombatSound(u10.SwingSoundFolder or u1.SwingSFXFolder, nil, u9.ClassData.SwingVolume or 0.5);
        u1._PerformHit(u9, u10);
    end);
    u14[#u14 + 1] = v11:GetMarkerReachedSignal("sheathe"):Connect(function() -- Line: 180
        -- upvalues: u9 (copy), SharedUtils (ref), u1 (ref)
        local v18 = u9.Character and u9.Character:FindFirstChild("HumanoidRootPart");

        if v18 then
            SharedUtils.PlaySoundAt(v18, "Sheathe_1", u1.SheatheVolume);
        end;
    end);
    local u19 = false;
    u14[#u14 + 1] = v11:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 189
        -- upvalues: u19 (ref)
        u19 = true;
    end);
    v11.Stopped:Once(function() -- Line: 192
        -- upvalues: u19 (ref)
        u19 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 195
        -- upvalues: u19 (ref)
        u19 = true;
    end);

    while not u19 do
        task.wait();
    end;

    for _, v in u14 do
        v:Disconnect();
    end;

    table.clear(u14);
    u9.Is_Using_Skill = false;
    u9.Is_Attacking = false;
end;

return u1;