--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Killer_Instinct
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Unrestricted.Killer_Instinct
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
local u7 = {
    AnimationName = "Ability_4",
    MaxDuration = 2.5,
    SetupMultiplier = 2.8,
    FinisherMultiplier = 7.8,
    HitboxSize = Vector3.new(18, 16, 24),
    HitboxRange = 22,
    DashSpeed = 78,
    DashDuration = 0.18,
    RapidSFXFolder = "Naoya_Punches",
    FinalSFX = { "jojo punch", "anime_explode" },

    _PerformHit = function(p1, p2, p3, p4) -- Line: 67, Name: _PerformHit
        local v5 = p1:QueryHitbox(p3, p4);
        local v6 = p1:ResolveSkillDamage(p2);

        for _, v in v5 do
            p1:ApplyDamage(v.Character, v6);
        end;
    end
};

function u7.Activate(u8, p9) -- Line: 79
    -- upvalues: u7 (copy), Debris (copy), SharedUtils (copy)
    local v10 = u8.Animations[u7.AnimationName];

    if not v10 then
        warn("[Boss Killer_Instinct] Animation not found:", u7.AnimationName);

        return;
    end;

    local Character = u8.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u8.Is_Using_Skill = true;
    u8.Is_Attacking = true;
    local u11 = false;
    local u12 = p9.DamageMultiplier or u7.SetupMultiplier;
    local u13 = p9.FinalDamageMult or u7.FinisherMultiplier;
    local u14 = p9.HitboxSize or u7.HitboxSize;
    local u15 = p9.HitboxRange or u7.HitboxRange;
    local LookVector = Character.CFrame.LookVector;
    local Unit = Vector3.new(LookVector.X, 0, LookVector.Z).Unit;
    local BodyVelocity = Instance.new("BodyVelocity");
    BodyVelocity.Name = "BossKillerInstinct_ForwardDash";
    BodyVelocity.MaxForce = Vector3.new(100000, 0, 100000);
    BodyVelocity.Velocity = Unit * (p9.DashSpeed or u7.DashSpeed);
    BodyVelocity.Parent = Character;
    Debris:AddItem(BodyVelocity, p9.DashDuration or u7.DashDuration);
    v10:Play(0, 1, p9.AnimSpeed or 1);
    local u16 = 0;
    local v21 = v10:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 119
        -- upvalues: u16 (ref), u8 (copy), u7 (ref), SharedUtils (ref), u12 (copy), u13 (copy), u14 (copy), u15 (copy)
        u16 = u16 + 1;
        local v18 = u8.ClassData.SwingVolume or 1;
        local v19 = u8.Character and u8.Character:FindFirstChild("HumanoidRootPart");

        if u16 < 3 then
            u8:PlayCombatSound(u7.RapidSFXFolder, nil, v18);
        elseif v19 then
            for _, v in u7.FinalSFX do
                SharedUtils.PlaySoundAt(v19, v, v18);
            end;
        end;

        if p17 == "" or not p17 then
            p17 = nil;
        end;

        u8:PlayTurnFX(p17);
        local v20;

        if u16 < 3 then
            v20 = u12;
        else
            v20 = u13;
        end;

        u7._PerformHit(u8, v20, u14, u15);
    end);
    v10.Stopped:Once(function() -- Line: 147
        -- upvalues: u11 (ref)
        u11 = true;
    end);
    task.delay(u7.MaxDuration, function() -- Line: 152
        -- upvalues: u11 (ref)
        u11 = true;
    end);

    while not u11 do
        task.wait();
    end;

    if v21 then
        v21:Disconnect();
    end;

    u8.Is_Using_Skill = false;
    u8.Is_Attacking = false;
end;

return u7;