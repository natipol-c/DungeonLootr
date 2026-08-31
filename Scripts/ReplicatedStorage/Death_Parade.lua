--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Death_Parade
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Dark Rider.Death_Parade
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:34 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Debris");
require(ReplicatedStorage.Modules.SharedUtils);
local u8 = {
    AnimationName = "Ability_4",
    MaxDuration = 5,
    HitboxSize = Vector3.new(18, 14, 18),
    HitboxRange = 20,

    _SpawnClones = function(p1, p2) -- Line: 32, Name: _SpawnClones
        -- upvalues: ReplicatedStorage (copy)
        local v3 = p2.CloneCount or 3;
        local v4 = p2.CloneInterval or 0.08;
        local v5 = p2.CloneFadeDuration or 1;
        local v6 = p2.CloneColor or Color3.fromRGB(80, 0, 120);
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

function u8._PerformHit(p9, p10) -- Line: 52
    -- upvalues: u8 (copy)
    local HitboxSize = p9.ClassData.HitboxSize;
    local Range = p9.ClassData.Range;
    p9.ClassData.HitboxSize = p10.HitboxSize or u8.HitboxSize;
    p9.ClassData.Range = p10.HitboxRange or u8.HitboxRange;
    local v11 = p9:QueryHitbox();
    p9.ClassData.HitboxSize = HitboxSize;
    p9.ClassData.Range = Range;
    local v12 = p9:ResolveSkillDamage(p10.DamageMultiplier);

    for _, v in v11 do
        p9:ApplyDamage(v.Character, v12);
    end;
end;

function u8.Activate(u13, u14) -- Line: 73
    -- upvalues: u8 (copy)
    local v15 = u13.Animations[u8.AnimationName];

    if not v15 then
        warn("[Boss Death_Parade] Animation not found:", u8.AnimationName);

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
    local v18 = v15:GetMarkerReachedSignal("hit"):Connect(function(p17) -- Line: 93
        -- upvalues: u14 (copy), u13 (copy), u8 (ref)
        u13:PlayCombatSound(u14.SwingSoundFolder or (u13.ClassData.SwingSoundFolder or "Gun_Shots"), nil, u13.ClassData.SwingVolume or 1);

        if p17 == "" or not p17 then
            p17 = nil;
        end;

        u13:PlayTurnFX(p17);
        task.spawn(u8._SpawnClones, u13, u14);
        u8._PerformHit(u13, u14);
    end);
    v15.Stopped:Once(function() -- Line: 105
        -- upvalues: u16 (ref)
        u16 = true;
    end);
    task.delay(u8.MaxDuration, function() -- Line: 109
        -- upvalues: u16 (ref)
        u16 = true;
    end);

    while not u16 do
        task.wait();
    end;

    if v18 then
        v18:Disconnect();
    end;

    u13.Is_Using_Skill = false;
    u13.Is_Attacking = false;
end;

return u8;