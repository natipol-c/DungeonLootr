--[[
  Type:     ModuleScript
  Method:   decompile
  Name:     Frame_Onslaught
  Path:     game.ReplicatedStorage.GameInfo.Boss_Abilities.Chaotic Fist.Frame_Onslaught
  Service:  ReplicatedStorage
  Success:  true
  Executor: Potassium v2.4.5
  Game:     Dungeon_Lootr_RELEASE (106484206883664)
  Time:     Tue Sep  1 03:59:35 2026
]]

-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Debris");
require(ReplicatedStorage.Modules.SharedUtils);
local u1 = {
    AnimationName = "Ability_4",
    MaxDuration = 3,
    HitboxSize = Vector3.new(17, 12, 27),
    HitboxRange = 27,
    CloneCount = 3,
    CloneInterval = 0.04,
    CloneFadeDuration = 0.8,
    CloneColor = Color3.fromRGB(0, 200, 180),
    CloneSpread = 5
};
local u2 = ReplicatedStorage:FindFirstChild("Player") and ReplicatedStorage.Player:FindFirstChild("Remotes") and ReplicatedStorage.Player.Remotes:FindFirstChild("ShadowDash");

function u1._PerformHit(p3, p4) -- Line: 47
    -- upvalues: u1 (copy)
    local HitboxSize = p3.ClassData.HitboxSize;
    local Range = p3.ClassData.Range;
    p3.ClassData.HitboxSize = p4.HitboxSize or u1.HitboxSize;
    p3.ClassData.Range = p4.HitboxRange or u1.HitboxRange;
    local v5 = p3:QueryHitbox();
    p3.ClassData.HitboxSize = HitboxSize;
    p3.ClassData.Range = Range;
    local v6 = p3:ResolveSkillDamage(p4.DamageMultiplier);

    for _, v in v5 do
        p3:ApplyDamage(v.Character, v6);
    end;
end;

local function RandomOffset(p7) -- Line: 67
    local v8 = (math.random() * 2 - 1) * p7;
    local v9 = (math.random() * 2 - 1) * p7;

    return Vector3.new(v8, 0, v9);
end;

function u1._SpawnClones(u10, p11) -- Line: 76
    -- upvalues: u2 (copy), u1 (copy)
    if not u2 then
        return;
    end;

    local u12 = p11.CloneCount or u1.CloneCount;
    local u13 = p11.CloneInterval or u1.CloneInterval;
    local u14 = p11.CloneFadeDuration or u1.CloneFadeDuration;
    local u15 = p11.CloneColor or u1.CloneColor;
    local u16 = p11.CloneSpread or u1.CloneSpread;
    task.spawn(function() -- Line: 85
        -- upvalues: u12 (copy), u10 (copy), u2 (ref), u14 (copy), u15 (copy), u16 (copy), u13 (copy)
        for i = 1, u12 do
            if not u10.Is_Using_Skill then
                break;
            end;

            local Player = u10.Player;
            local v17 = {
                Action = "Clone",
                FadeDuration = u14,
                Color = u15
            };
            local v18 = u16;
            local v19 = (math.random() * 2 - 1) * v18;
            local v20 = (math.random() * 2 - 1) * v18;
            v17.Offset = Vector3.new(v19, 0, v20);
            u2:FireAllClients(Player, v17);
            local v21;

            if i < u12 then
                task.wait(u13);
                v21 = i;
            else
                v21 = i;
            end;
        end;
    end);
end;

function u1.Activate(u22, u23) -- Line: 106
    -- upvalues: u1 (copy)
    local v24 = u22.Animations[u1.AnimationName];

    if not v24 then
        warn("[Boss Kieru Frame_Onslaught] Animation not found:", u1.AnimationName);

        return;
    end;

    local Character = u22.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    u22.Is_Using_Skill = true;
    u22.Is_Attacking = true;
    local u25 = false;
    v24:Play(0, 1, u23.AnimSpeed or 1);
    local v27 = v24:GetMarkerReachedSignal("hit"):Connect(function(p26) -- Line: 128
        -- upvalues: u22 (copy), u1 (ref), u23 (copy)
        u22:PlayCombatSound(u22.ClassData.SwingSoundFolder or "Naoya_Punches", nil, u22.ClassData.SwingVolume or 1);

        if p26 == "" or not p26 then
            p26 = nil;
        end;

        u22:PlayTurnFX(p26);
        u1._PerformHit(u22, u23);
        u1._SpawnClones(u22, u23);
    end);
    v24.Stopped:Once(function() -- Line: 144
        -- upvalues: u25 (ref)
        u25 = true;
    end);
    task.delay(u1.MaxDuration, function() -- Line: 149
        -- upvalues: u25 (ref)
        u25 = true;
    end);

    while not u25 do
        task.wait();
    end;

    if v27 then
        v27:Disconnect();
    end;

    u22.Is_Using_Skill = false;
    u22.Is_Attacking = false;
end;

return u1;