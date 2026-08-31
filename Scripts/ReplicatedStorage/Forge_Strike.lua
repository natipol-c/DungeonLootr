--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Forge_Strike
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Greatsword.Forge_Strike
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
    MaxDuration = 2.5
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._SpawnClones(u3, p4) -- Line: 44
    -- upvalues: u2 (copy)
    if not u2 then
        return;
    end;

    local u5 = p4.CloneCount or 3;
    local u6 = p4.CloneInterval or 0.06;
    local u7 = p4.CloneFadeDuration or 1;
    local u8 = p4.CloneColor or Color3.fromRGB(200, 50, 50);
    task.spawn(function() -- Line: 52
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

function u1._PerformHit(p10, p11) -- Line: 73
    local v12 = p10:QueryHitbox(p11.HitboxSize, p11.HitboxRange);
    local v13 = p10:ResolveSkillDamage(p11.DamageMultiplier);

    for _, v in v12 do
        p10:ApplyDamage(v.Character, v13);
    end;
end;

function u1.Activate(u14, u15) -- Line: 88
    -- upvalues: u1 (copy), Debris (copy), SharedUtils (copy)
    local v16 = u14.Animations[u1.AnimationName];

    if not v16 then
        warn("[Boss Forge_Strike] Animation not found:", u1.AnimationName);

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
    v16:Play(0, 1, u15.AnimSpeed or 1);
    local v21 = v16:GetMarkerReachedSignal("dash"):Connect(function(p18) -- Line: 111
        -- upvalues: u14 (copy), u15 (copy), Debris (ref), u1 (ref)
        local v19 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

        if not v19 then
            return;
        end;

        local v20;

        if p18 == "Back" then
            v20 = -v19.CFrame.LookVector;
        else
            v20 = v19.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v20 * (u15.DashSpeed or 60);
        BodyVelocity.Parent = v19;
        Debris:AddItem(BodyVelocity, u15.DashDuration or 0.2);
        u1._SpawnClones(u14, u15);
    end);
    local v23 = v16:GetMarkerReachedSignal("hit"):Connect(function() -- Line: 132
        -- upvalues: u14 (copy), SharedUtils (ref), u1 (ref), u15 (copy)
        u14:PlayTurnFX("Slam");
        local v22 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

        if v22 then
            SharedUtils.PlaySoundAt(v22, "Earth_Hammer_2", 2);
        end;

        u1._PerformHit(u14, u15);
    end);
    v16.Stopped:Once(function() -- Line: 147
        -- upvalues: u17 (ref)
        u17 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 152
        -- upvalues: u17 (ref)
        u17 = true;
    end);

    while not u17 do
        task.wait();
    end;

    if v21 then
        v21:Disconnect();
    end;

    if v23 then
        v23:Disconnect();
    end;

    u14.Is_Using_Skill = false;
    u14.Is_Attacking = false;
end;

return u1;