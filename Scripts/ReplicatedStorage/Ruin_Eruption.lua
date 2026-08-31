--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Ruin_Eruption
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Oathbreaker.Ruin_Eruption
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:33 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Debris = game:GetService("Debris");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_4",
    MaxDuration = 3.5,
    HitboxSize = Vector3.new(17, 20, 17)
};

function u1._SpawnAndDetonateGrenade(p2, p3, p4) -- Line: 51
    -- upvalues: ReplicatedStorage (copy), Debris (copy), SharedUtils (copy), u1 (copy)
    local v5 = p2.Character and p2.Character:FindFirstChild("HumanoidRootPart");

    if not v5 then
        return;
    end;

    local v6 = p2.ClassData.SwingVolume or 1;
    local v7 = ReplicatedStorage:FindFirstChild("Assets") and ReplicatedStorage.Assets:FindFirstChild("Effects") and ReplicatedStorage.Assets.Effects:FindFirstChild("Grenade");
    local v8 = v5.Position - Vector3.new(0, 3, 0);

    if v7 then
        local u9 = v7:Clone();

        if u9:IsA("BasePart") then
            u9.Position = v8;
            u9.Anchored = true;
        elseif u9:IsA("Model") then
            u9:PivotTo(CFrame.new(v8));
        end;

        u9.Parent = workspace;
        task.delay(0.025, function() -- Line: 73
            -- upvalues: u9 (copy)
            u9:SetAttribute("Fire", true);
        end);
        Debris:AddItem(u9, 5);
        local v10 = u9:IsA("BasePart") and u9 and u9 or u9:FindFirstChildWhichIsA("BasePart");

        if v10 then
            SharedUtils.PlaySoundAt(v10, p4, v6);
        end;
    else
        SharedUtils.PlaySoundAt(v5, p4, v6);
    end;

    local v11 = p3.HitboxSize or u1.HitboxSize;
    local OverlapParams_new_ret = OverlapParams.new();
    OverlapParams_new_ret.ExcludeInstances = { p2.Character };
    local v12 = {};

    for _, v in workspace:GetPartBoundsInBox(CFrame.new(v8), v11, OverlapParams_new_ret) do
        local v13 = v:FindFirstAncestorOfClass("Model");

        if v13 and (not v12[v13] and v13:FindFirstChildOfClass("Humanoid")) then
            v12[v13] = true;
        end;
    end;

    local v14 = p2:ResolveSkillDamage(p3.DamageMultiplier);

    for i in v12 do
        p2:ApplyDamage(i, v14);
    end;
end;

function u1.Activate(u15, u16) -- Line: 119
    -- upvalues: u1 (copy), SharedUtils (copy), Debris (copy)
    local v17 = u15.Animations[u1.AnimationName];

    if not v17 then
        warn("[Boss Ruin_Eruption] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u15.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u15.Is_Using_Skill = true;
    u15.Is_Attacking = true;
    local u18 = false;
    v17:Play(0, 1, u16.AnimSpeed or 1);
    local u19 = 0;
    local v21 = v17:GetMarkerReachedSignal("hit"):Connect(function(p20) -- Line: 142
        -- upvalues: u19 (ref), u1 (ref), u15 (copy), u16 (copy)
        u19 = u19 + 1;

        if u19 == 1 then
            u1._SpawnAndDetonateGrenade(u15, u16, "Earth_Hammer");
        else
            task.delay(0.025, function() -- Line: 150
                -- upvalues: u1 (ref), u15 (ref), u16 (ref)
                u1._SpawnAndDetonateGrenade(u15, u16, "Earth_Hammer_2");
            end);
        end;

        if p20 == "" or not p20 then
            p20 = nil;
        end;

        u15:PlayTurnFX(p20);
    end);
    local v25 = v17:GetMarkerReachedSignal("dash"):Connect(function(p22) -- Line: 160
        -- upvalues: u15 (copy), SharedUtils (ref), u16 (copy), Debris (ref)
        local v23 = u15.Character and u15.Character:FindFirstChild("HumanoidRootPart");

        if not v23 then
            return;
        end;

        SharedUtils.PlaySoundAt(v23, "Tiger_Roar", u15.ClassData.SwingVolume or 1);
        local v24;

        if p22 == "Back" then
            v24 = -v23.CFrame.LookVector;
        else
            v24 = v23.CFrame.LookVector;
        end;

        local BodyVelocity = Instance.new("BodyVelocity");
        BodyVelocity.Name = "BossSkillDash";
        BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
        BodyVelocity.Velocity = v24 * (u16.DashSpeed or 75);
        BodyVelocity.Parent = v23;
        Debris:AddItem(BodyVelocity, u16.DashDuration or 0.2);
    end);
    v17.Stopped:Once(function() -- Line: 181
        -- upvalues: u18 (ref)
        u18 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 186
        -- upvalues: u18 (ref)
        u18 = true;
    end);

    while not u18 do
        task.wait();
    end;

    if v21 then
        v21:Disconnect();
    end;

    if v25 then
        v25:Disconnect();
    end;

    u15.Is_Using_Skill = false;
    u15.Is_Attacking = false;
end;

return u1;