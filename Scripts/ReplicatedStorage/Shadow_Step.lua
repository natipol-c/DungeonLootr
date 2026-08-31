--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Shadow_Step
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Kage.Shadow_Step
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SharedUtils = require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_1",
    MaxDuration = 3,
    HitboxSize = Vector3.new(20, 20, 28),
    HitboxRange = 28,
    WarpSearchRange = 80,
    WarpBehindOffset = 5
};

function u1._FindNearestPlayer(p2) -- Line: 49
    -- upvalues: u1 (copy), Players (copy)
    local v3 = p2.Character and p2.Character:FindFirstChild("HumanoidRootPart");

    if not v3 then
        return nil;
    end;

    local Position = v3.Position;
    local v4 = u1.WarpSearchRange + 1;
    local v5 = nil;

    for _, v in Players:GetPlayers() do
        if not v:GetAttribute("IsSpectating") then
            local Character = v.Character;

            if Character and not Character:GetAttribute("Dead") then
                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart then
                    local Magnitude = (HumanoidRootPart.Position - Position).Magnitude;

                    if Magnitude <= u1.WarpSearchRange and Magnitude < v4 then
                        v4 = Magnitude;
                        v5 = {
                            character = Character,
                            hrp = HumanoidRootPart
                        };
                    end;
                end;
            end;
        end;
    end;

    return v5;
end;

function u1._WarpBehind(p6, p7) -- Line: 77
    -- upvalues: u1 (copy)
    local v8 = p6.Character and p6.Character:FindFirstChild("HumanoidRootPart");

    if not (v8 and p7.hrp) then
        return;
    end;

    local v9 = p7.hrp.CFrame * CFrame.new(0, 0, u1.WarpBehindOffset);
    v8.CFrame = CFrame.new(v9.Position, p7.hrp.Position);
end;

function u1._PerformHit(p10, p11) -- Line: 86
    -- upvalues: u1 (copy)
    local HitboxSize = p10.ClassData.HitboxSize;
    local Range = p10.ClassData.Range;
    p10.ClassData.HitboxSize = p11.HitboxSize or u1.HitboxSize;
    p10.ClassData.Range = p11.HitboxRange or u1.HitboxRange;
    local v12 = p10:QueryHitbox();
    p10.ClassData.HitboxSize = HitboxSize;
    p10.ClassData.Range = Range;
    local v13 = p10:ResolveSkillDamage(p11.DamageMultiplier);

    for _, v in v12 do
        p10:ApplyDamage(v.Character, v13);
    end;
end;

function u1.Activate(u14, u15) -- Line: 108
    -- upvalues: u1 (copy), SharedUtils (copy)
    local v16 = u14.Animations[u1.AnimationName];

    if not v16 then
        warn("[Boss Shadow_Step] Animation not found:", u1.AnimationName);

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
    SharedUtils.PlaySoundAt(Character, "Dark_Chase", 1);
    local v18 = u1._FindNearestPlayer(u14);

    if v18 then
        u1._WarpBehind(u14, v18);
    end;

    v16:Play(0, 1, u15.AnimSpeed or 1);
    local v21 = v16:GetMarkerReachedSignal("hit"):Connect(function(p19) -- Line: 139
        -- upvalues: u14 (copy), SharedUtils (ref), u1 (ref), u15 (copy)
        local v20 = u14.Character and u14.Character:FindFirstChild("HumanoidRootPart");

        if v20 then
            SharedUtils.PlaySoundAt(v20, "Earth_Hammer", 1);
        end;

        if p19 == "" or not p19 then
            p19 = nil;
        end;

        u14:PlayTurnFX(p19);
        u1._PerformHit(u14, u15);
    end);
    local v23 = v16:GetMarkerReachedSignal("DBreset"):Connect(function() -- Line: 151
        -- upvalues: u14 (copy)
        local v22 = u14.FX and u14.FX.Smoke;

        if v22 then
            v22:SetAttribute("Fire", not v22:GetAttribute("Fire"));
        end;
    end);
    v16.Stopped:Once(function() -- Line: 159
        -- upvalues: u17 (ref)
        u17 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 163
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