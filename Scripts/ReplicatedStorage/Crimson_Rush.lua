--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Crimson_Rush
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Dreadlord.Crimson_Rush
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
local u1 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");
local u9 = {
    AnimationName = "Ability_1",
    MaxDuration = 2.5,
    HitboxSize = Vector3.new(25, 15, 30),
    HitboxRange = 20,
    DashSpeeds = { 60, 70 },
    DashDuration = 0.15,

    _SpawnClones = function(u2, p3) -- Line: 54, Name: _SpawnClones
        -- upvalues: u1 (copy)
        if not u1 then
            return;
        end;

        local u4 = p3.CloneCount or 2;
        local u5 = p3.CloneInterval or 0.04;
        local u6 = p3.CloneFadeDuration or 0.6;
        local u7 = p3.CloneColor or Color3.fromRGB(255, 40, 40);
        task.spawn(function() -- Line: 62
            -- upvalues: u4 (copy), u2 (copy), u1 (ref), u6 (copy), u7 (copy), u5 (copy)
            for i = 1, u4 do
                if not u2.Is_Using_Skill then
                    break;
                end;

                u1:FireAllClients(nil, {
                    Action = "Clone",
                    FadeDuration = u6,
                    Color = u7,
                    NPCModel = u2.Character
                });
                local v8;

                if i < u4 then
                    task.wait(u5);
                    v8 = i;
                else
                    v8 = i;
                end;
            end;
        end);
    end
};

function u9._PerformHit(p10, p11) -- Line: 81
    -- upvalues: u9 (copy)
    local HitboxSize = p10.ClassData.HitboxSize;
    local Range = p10.ClassData.Range;
    p10.ClassData.HitboxSize = p11.HitboxSize or u9.HitboxSize;
    p10.ClassData.Range = p11.HitboxRange or u9.HitboxRange;
    local v12 = p10:QueryHitbox();
    p10.ClassData.HitboxSize = HitboxSize;
    p10.ClassData.Range = Range;
    local v13 = p10:ResolveSkillDamage(p11.DamageMultiplier);

    for _, v in v12 do
        p10:ApplyDamage(v.Character, v13);
    end;
end;

function u9.Activate(u14, u15) -- Line: 103
    -- upvalues: u9 (copy), SharedUtils (copy), Debris (copy)
    local v16 = u14.Animations[u9.AnimationName];

    if not v16 then
        warn("[Boss Crimson_Rush] Animation not found:", u9.AnimationName);

        return;
    end;

    local Character = u14.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u14.Is_Using_Skill = true;
    u14.Is_Attacking = true;
    local u17 = false;
    local u18 = u15.DashSpeeds or u9.DashSpeeds;
    local u19 = u15.DashDuration or u9.DashDuration;
    local v20 = u14.FX and u14.FX.Rose_Dash;

    if v20 then
        v20:SetAttribute("Fire", not v20:GetAttribute("Fire"));
    end;

    SharedUtils.PlaySoundAt(Character, "anime_explode", 0.8);
    v16:Play(0, 1, u15.AnimSpeed or 1);
    local u21 = 0;
    local v26 = v16:GetMarkerReachedSignal("hit"):Connect(function(p22) -- Line: 136
        -- upvalues: u21 (ref), u14 (copy), u9 (ref), u15 (copy), u18 (copy), Debris (ref), u19 (copy), SharedUtils (ref)
        u21 = u21 + 1;
        local v23 = u21;
        local v24 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

        if not v24 then
            return;
        end;

        u14:PlayTurnFX(v23 == 1 and "Right_Slash" or "Left_Slash");
        u9._SpawnClones(u14, u15);
        local v25 = u18[v23] or u18[#u18];
        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v24.CFrame.LookVector * v25;
        BodyVelocity.Parent = v24;
        Debris:AddItem(BodyVelocity, u19);
        u14:PlayCombatSound(u15.SwingSoundFolder or (u14.ClassData.SwingSoundFolder or "Flame_Swing"), nil, u14.ClassData.SwingVolume or 1);

        if v23 == 1 then
            SharedUtils.PlaySoundAt(v24, "claw_crosscut_03", 0.8);
        end;

        u9._PerformHit(u14, u15);
    end);
    local v27 = v16:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 174
        -- upvalues: u17 (ref)
        u17 = true;
    end);
    v16.Stopped:Once(function() -- Line: 179
        -- upvalues: u17 (ref)
        u17 = true;
    end);
    task.delay(u9.MaxDuration, function() -- Line: 183
        -- upvalues: u17 (ref)
        u17 = true;
    end);

    while not u17 do
        task.wait();
    end;

    if v26 then
        v26:Disconnect();
    end;

    if v27 then
        v27:Disconnect();
    end;

    u14.Is_Using_Skill = false;
    u14.Is_Attacking = false;
end;

return u9;