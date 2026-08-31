--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Crater_Slam
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Founder.Crater_Slam
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
local u1 = {
    AnimationName = "Ability_1",
    MaxDuration = 3,
    ExplosionDelay = 0.22,
    ExplosionHitboxSize = Vector3.new(15, 20, 15)
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._SpawnClones(u3, p4) -- Line: 48
    -- upvalues: u2 (copy)
    if not u2 then
        return;
    end;

    local u5 = p4.CloneCount or 3;
    local u6 = p4.CloneInterval or 0.06;
    local u7 = p4.CloneFadeDuration or 1;
    local u8 = p4.CloneColor or Color3.fromRGB(100, 150, 220);
    task.spawn(function() -- Line: 56
        -- upvalues: u5 (copy), u3 (copy), u2 (ref), u7 (copy), u8 (copy), u6 (copy)
        for i = 1, u5 do
            if not u3.Is_Using_Skill then
                break;
            end;

            u2:FireAllClients(nil, {
                Action = "Clone",
                FadeDuration = u7,
                Color = u8,
                NPCModel = u3.Character
            });
            local v9;

            if i < u5 then
                task.wait(u6);
                v9 = i;
            else
                v9 = i;
            end;
        end;
    end);
end;

function u1._PerformHit(p10, p11) -- Line: 75
    local v12 = p10:QueryHitbox(p11.HitboxSize, p11.HitboxRange);
    local v13 = p10:ResolveSkillDamage(p11.DamageMultiplier);

    for _, v in v12 do
        p10:ApplyDamage(v.Character, v13);
    end;
end;

function u1._SpawnExplosion(p14, p15, p16) -- Line: 88
    -- upvalues: ReplicatedStorage (copy), Debris (copy), SharedUtils (copy), u1 (copy)
    local v17 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Effects") and ReplicatedStorage.Assets.Effects:FindFirstChild("Grenade");

    if v17 then
        local v18 = v17:Clone();

        if v18:IsA("BasePart") then
            v18.Position = p16;
            v18.Anchored = true;
        elseif v18:IsA("Model") then
            v18:PivotTo(CFrame.new(p16));
        end;

        v18.Parent = workspace;
        Debris:AddItem(v18, 5);
        task.wait(0.05);
        v18:SetAttribute("Fire", true);
        local v19 = v18:IsA("BasePart") and v18 and v18 or v18:FindFirstChildWhichIsA("BasePart");

        if v19 then
            SharedUtils.PlaySoundAt(v19, "Earth_Hammer", 2);
        end;
    end;

    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { p14.Character };
    local v20 = {};

    for _, v in workspace:GetPartBoundsInBox(CFrame.new(p16), u1.ExplosionHitboxSize, OverlapParams_new_ret) do
        local v21 = v:FindFirstAncestorOfClass("Model");

        if v21 and (not v20[v21] and v21:FindFirstChildOfClass("Humanoid")) then
            v20[v21] = true;
        end;
    end;

    local v22 = p14:ResolveSkillDamage(p15.DamageMultiplier);

    for i in v20 do
        p14:ApplyDamage(i, v22);
    end;
end;

function u1.Activate(u23, u24) -- Line: 143
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local v25 = u23.Animations[u1.AnimationName];

    if not v25 then
        warn("[Boss Crater_Slam] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u23.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u23.Is_Using_Skill = true;
    u23.Is_Attacking = true;
    local u26 = false;
    v25:Play(0, 1, u24.AnimSpeed or 1);
    local v30 = v25:GetMarkerReachedSignal("dash"):Connect(function(p27) -- Line: 165
        -- upvalues: u23 (copy), u24 (copy), Debris (ref), u1 (ref)
        local v28 = u23.Character and u23.Character:FindFirstChild("HumanoidRootPart");

        if not v28 then
            return;
        end;

        local v29;

        if p27 == "Back" then
            v29 = -v28.CFrame.LookVector;
        else
            v29 = v28.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v29 * (u24.DashSpeed or 65);
        BodyVelocity.Parent = v28;
        Debris:AddItem(BodyVelocity, u24.DashDuration or 0.15);
        u1._SpawnClones(u23, u24);
    end);
    local v33 = v25:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 186
        -- upvalues: u23 (copy), SharedUtils (ref), u1 (ref), u24 (copy)
        u23:PlayTurnFX("Slam");
        local v31 = u23.Character and u23.Character:FindFirstChild("HumanoidRootPart");

        if v31 then
            SharedUtils.PlaySoundAt(v31, "Earth_Hammer_2", 2);
        end;

        u1._PerformHit(u23, u24);
        task.delay(u1.ExplosionDelay, function() -- Line: 199
            -- upvalues: u23 (ref), u1 (ref), u24 (ref)
            local v32 = u23.Character and u23.Character:FindFirstChild("HumanoidRootPart");

            if v32 then
                u1._SpawnExplosion(u23, u24, v32.Position);
            end;
        end);
    end);
    v25.Stopped:Once(function() -- Line: 208
        -- upvalues: u26 (ref)
        u26 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 212
        -- upvalues: u26 (ref)
        u26 = true;
    end);

    while not u26 do
        task.wait();
    end;

    if v30 then
        v30:Disconnect();
    end;

    if v33 then
        v33:Disconnect();
    end;

    u23.Is_Using_Skill = false;
    u23.Is_Attacking = false;
end;

return u1;